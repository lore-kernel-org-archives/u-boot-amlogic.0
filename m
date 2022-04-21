Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web12.18000.1650520660950807963
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 22:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650520657; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:
	 disposition-notification-to; bh=0LL98D42OVKF966cyKxhQgvm+YeBj3avSaugXML1Nes=;
	b=vWkEn4m3v9cwdDx4vxu5/xVzXqOrmVejTK0ujdrFNY6Fi1zyrH5DvMf/SQPPVdNIktNLKf
	gy0Bpnt/7G+ib1BC6F/8ksSu46PasEagwjcpS1dVNSxyMuD2+XsputSWa1v3MIi93nV0rz
	iEv9FeVkGC/n20gVxQBAWfdc60ObessFi7y+aaM+WfopXAkLVVtifTk22p+ylC9w4AGKZI
	mtIdYyzOaoJ7yEzT8JZ9UfLvOsGJvPpm8Ttn6w3SixH1yly44pT9YLRhmmK2yl38iW3FTW
	sCyQ0sHxNr2lFV32hzzQHsY12tzj9rnL0p39/QOvYgXDlCr+N3LiXsm82rwrgg==
Subject: Re: [PATCH 1/5] clk: meson: add minimal driver for axg-ao clocks
References: <20220420175502.2449249-1-adeep@lexina.in>
 <20220420175502.2449249-2-adeep@lexina.in>
 <2cfa21b7-5ace-422e-f0ad-8b5c322a65b6@gmail.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <a912af81-0536-7564-1eac-62461f48f34b@lexina.in>
Date: Thu, 21 Apr 2022 08:57:34 +0300
MIME-Version: 1.0
In-Reply-To: <2cfa21b7-5ace-422e-f0ad-8b5c322a65b6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Sean Anderson <seanga2@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

20.04.2022 23:12, Sean Anderson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 4/20/22 1:54 PM, Vyacheslav Bocharov wrote:
>> Add minimal driver AO clocks on meson AXG family. Only ADC related clock=
s
>> are supported.
>>
>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>> ---
>> =C2=A0 drivers/clk/meson/Makefile |=C2=A0 1 +
>> =C2=A0 drivers/clk/meson/axg-ao.c | 83 +++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 2 files changed, 84 insertions(+)
>> =C2=A0 create mode 100644 drivers/clk/meson/axg-ao.c
>>
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index b9c6bd66cf..a486b13e9c 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -5,5 +5,6 @@
>> =C2=A0 obj-$(CONFIG_CLK_MESON_GX) +=3D gxbb.o
>> =C2=A0 obj-$(CONFIG_CLK_MESON_AXG) +=3D axg.o
>> +obj-$(CONFIG_CLK_MESON_AXG) +=3D axg-ao.o
>> =C2=A0 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a.o
>> =C2=A0 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a-ao.o
>> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
>> new file mode 100644
>> index 0000000000..264ec6f0d3
>> --- /dev/null
>> +++ b/drivers/clk/meson/axg-ao.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include <common.h>
>> +#include <log.h>
>> +#include <asm/io.h>
>> +#include <clk-uclass.h>
>> +#include <dm.h>
>> +#include <regmap.h>
>> +#include <syscon.h>
>> +#include <dt-bindings/clock/axg-aoclkc.h>
>> +
>> +#include "clk_meson.h"
>> +
>> +struct meson_clk {
>> +=C2=A0=C2=A0=C2=A0 struct regmap *map;
>> +};
>> +
>> +#define AO_CLK_GATE0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x40
>> +#define AO_SAR_CLK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x90
>> +
>> +static struct meson_gate gates[] =3D {
>> +=C2=A0=C2=A0=C2=A0 MESON_GATE(CLKID_AO_SAR_ADC, AO_CLK_GATE0, 7),
>> +=C2=A0=C2=A0=C2=A0 MESON_GATE(CLKID_AO_SAR_ADC_CLK, AO_SAR_CLK, 7),
>> +};
>> +
>> +static int meson_set_gate(struct clk *clk, bool on)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct meson_clk *priv =3D dev_get_priv(clk->dev);
>> +=C2=A0=C2=A0=C2=A0 struct meson_gate *gate;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (clk->id >=3D ARRAY_SIZE(gates))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
> Do this check in request().

Do you mean remove this check from meson_set_gate and add request=20
function like this:

static int meson_clk_request(struct clk *clk)
{
	struct npcm_clk_priv *priv =3D dev_get_priv(clk->dev);

	if (clk->id >=3D ARRAY_SIZE(gates))
		return -ENOENT;

	return 0;
}

static struct clk_ops meson_clk_ops =3D {
	.disable	=3D meson_clk_disable,
	.enable		=3D meson_clk_enable,
	.request	=3D meson_clk_request,
};

?

>=20
>> +=C2=A0=C2=A0=C2=A0 gate =3D &gates[clk->id];
>> +
>> +=C2=A0=C2=A0=C2=A0 if (gate->reg =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 regmap_update_bits(priv->map, gate->reg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(gate->bit), on ? BIT(gate->bit) : 0);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int meson_clk_enable(struct clk *clk)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return meson_set_gate(clk, true);
>> +}
>> +
>> +static int meson_clk_disable(struct clk *clk)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return meson_set_gate(clk, false);
>> +}
>> +
>> +static int meson_clk_probe(struct udevice *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct meson_clk *priv =3D dev_get_priv(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 priv->map =3D syscon_node_to_regmap(dev_ofnode(dev_g=
et_parent(dev)));
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(priv->map))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(priv->map);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static struct clk_ops meson_clk_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .disable=C2=A0=C2=A0=C2=A0 =3D meson_clk_disable,
>> +=C2=A0=C2=A0=C2=A0 .enable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D meson_clk_enable,
>> +};
>> +
>> +static const struct udevice_id meson_clk_ids[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "amlogic,meson-axg-aoclkc" },
>> +=C2=A0=C2=A0=C2=A0 { }
>> +};
>> +
>> +U_BOOT_DRIVER(meson_clk_axg_ao) =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"meson_clk_axg_ao",
>> +=C2=A0=C2=A0=C2=A0 .id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D UC=
LASS_CLK,
>> +=C2=A0=C2=A0=C2=A0 .of_match=C2=A0=C2=A0=C2=A0 =3D meson_clk_ids,
>> +=C2=A0=C2=A0=C2=A0 .priv_auto=C2=A0=C2=A0=C2=A0 =3D sizeof(struct meson=
_clk),
>> +=C2=A0=C2=A0=C2=A0 .ops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &=
meson_clk_ops,
>> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 meson_clk_probe,
>> +};
>>
>=20
> Otherwise LGTM

Thanks

> --Sean

--=20
Vyacheslav
