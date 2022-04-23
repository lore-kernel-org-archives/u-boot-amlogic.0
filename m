Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.4072.1650697431358570488
 for <u-boot-amlogic@groups.io>;
 Sat, 23 Apr 2022 00:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650697427; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=00bUWUsjn3OPE99Mz5MlSAwv+cq7lzm0I9BK40qiHPk=;
	b=JpsUVXwjO7FdfOy2ssp5B8xNvoh28mnbGZb1muJyqRA0b5nMXbX62UUG847OVHO+eAsbab
	I1ovKJdwH0SRQAlPVNLWY6MrierSrc+j2gLeN2D7RiHGOjcPf2okXnUhfBWBfGnc0HzO1E
	JfOF/+rak2ku4zcSTsGwAicsEhm7XaeHrI44bHBJSid/6drc/6PIp+xsqU+TL5ALhGQel9
	iNl9Bq4QUZZ7fHYNWbSOqeX11KjsvQtNKAI8jD9QHWWXotaJaXq/KGpEQuh0Datt30i0/d
	1AeJ55jpzfpeeyjYafDmDbgt2B22wvTv8Evyr7jjwHM4/qPJm5/Dpzw6xbnPfA==
Message-ID: <ef7c685a-940e-8ad0-1079-1a961cb06957@lexina.in>
Date: Sat, 23 Apr 2022 10:03:42 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/6] clk: meson: add minimal driver for axg-ao clocks
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-2-adeep@lexina.in>
 <868d6185-339c-59a1-8113-a5eb00f84ec2@gmail.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <868d6185-339c-59a1-8113-a5eb00f84ec2@gmail.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Sean Anderson <seanga2@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>



23.04.2022 1:55, Sean Anderson wrote:
> On 4/22/22 1:29 AM, Vyacheslav Bocharov wrote:
>> Add minimal driver AO clocks on meson AXG family. Only ADC related clock=
s
>> are supported.
>>
>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>> ---
>> =C2=A0 drivers/clk/meson/Makefile |=C2=A0 1 +
>> =C2=A0 drivers/clk/meson/axg-ao.c | 89 +++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 2 files changed, 90 insertions(+)
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
>> index 0000000000..3f9617e9f7
>> --- /dev/null
>> +++ b/drivers/clk/meson/axg-ao.c
>> @@ -0,0 +1,89 @@
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
>> +=C2=A0=C2=A0=C2=A0 gate =3D &gates[clk->id];
>> +
>> +=C2=A0=C2=A0=C2=A0 if (gate->reg =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
> I don't think you need this.
Hmm. You're right. The gates is all predefined. Therefore zero values=20
cannot be there. I will fix it in g12-ao-clk as well.

>=20
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
>> +static int meson_clk_request(struct clk *clk)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (clk->id >=3D ARRAY_SIZE(gates))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static struct clk_ops meson_clk_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .disable=C2=A0=C2=A0=C2=A0 =3D meson_clk_disable,
>> +=C2=A0=C2=A0=C2=A0 .enable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D meson_clk_enable,
>> +=C2=A0=C2=A0=C2=A0 .request=C2=A0=C2=A0=C2=A0 =3D meson_clk_request,
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
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
