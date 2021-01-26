Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web09.10720.1611660308405193223
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 03:25:09 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210126112505euoutp0147c351fb46d83906df4d3b183eaaa753~dxIJiZO2T2407524075euoutp01p
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 11:25:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210126112505euoutp0147c351fb46d83906df4d3b183eaaa753~dxIJiZO2T2407524075euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611660305;
	bh=QTJQmzbrQv1D0ESMFWGXm07BIy53RTbdAtocLPjaPJM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=i+OflC+jLYaDSseDIn0LM4+DfO5BkoFQSlF5gsMU0ZOfVIbx2MbS11oxBwtDuA/wu
	 Vr2BsrI0YbwyoGveXPo6/lwwmeQ5hDkSwmzjrzwfu6Rn7pQShbI8eMmTrcqMQdeG3L
	 fEoVmeM0ghV5Lq6BjE5zjzx8DRkO4czmwF7w9duw=
Subject: Re: [PATCH v5 2/4] button: add a simple Analog to Digital Converter device based button driver
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1d5b1718-9b28-61dd-8137-3a50d9ec2e6e@samsung.com>
Date: Tue, 26 Jan 2021 12:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <e2bf2621-a9a4-9ba6-ccbb-0a6b35c8d8bf@gmx.de>
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
	<CGME20210126095112eucas1p1af8ac76eaede4baf2b0cfeac561a6a06@eucas1p1.samsung.com>
	<20210126095036.6429-3-m.szyprowski@samsung.com>
	<e2bf2621-a9a4-9ba6-ccbb-0a6b35c8d8bf@gmx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Heinrich,

On 26.01.2021 12:10, Heinrich Schuchardt wrote:
> On 1/26/21 10:50 AM, Marek Szyprowski wrote:
>> Add a simple Analog to Digital Converter device based button driver.=20
>> This
>> driver binds to the 'adc-keys' device tree node.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> =C2=A0 drivers/button/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 ++
>> =C2=A0 drivers/button/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1=
 +
>> =C2=A0 drivers/button/button-adc.c | 156 +++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 3 files changed, 165 insertions(+)
>> =C2=A0 create mode 100644 drivers/button/button-adc.c
>>
>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>> index 6b3ec7e55d..6db3c5e93a 100644
>> --- a/drivers/button/Kconfig
>> +++ b/drivers/button/Kconfig
>> @@ -9,6 +9,14 @@ config BUTTON
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can provide access to board=
-specific buttons. Use of the=20
>> device tree
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for configuration is encour=
aged.
>>
>> +config BUTTON_ADC
>> +=C2=A0=C2=A0=C2=A0 bool "Button adc"
>> +=C2=A0=C2=A0=C2=A0 depends on BUTTON
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable support for buttons which are c=
onnected to Analog to=20
>> Digital
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Converter device. The ADC driver must =
use driver model.=20
>> Buttons are
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configured using the device tree.
>> +
>> =C2=A0 config BUTTON_GPIO
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Button gpio"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on BUTTON
>> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
>> index fcc10ebe8d..bbd18af149 100644
>> --- a/drivers/button/Makefile
>> +++ b/drivers/button/Makefile
>> @@ -3,4 +3,5 @@
>> =C2=A0 # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathom=
e.com>
>>
>> =C2=A0 obj-$(CONFIG_BUTTON) +=3D button-uclass.o
>> +obj-$(CONFIG_BUTTON_ADC) +=3D button-adc.o
>> =C2=A0 obj-$(CONFIG_BUTTON_GPIO) +=3D button-gpio.o
>> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
>> new file mode 100644
>> index 0000000000..1901d59a0e
>> --- /dev/null
>> +++ b/drivers/button/button-adc.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://www.samsung.com
>> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> + */
>> +
>> +#include <common.h>
>> +#include <adc.h>
>> +#include <button.h>
>> +#include <log.h>
>> +#include <dm.h>
>> +#include <dm/lists.h>
>> +#include <dm/of_access.h>
>> +#include <dm/uclass-internal.h>
>> +
>> +/**
>> + * struct button_adc_priv - private data for button-adc driver.
>> + *
>> + * @adc: Analog to Digital Converter device to which button is=20
>> connected.
>> + * @channel: channel of the ADC device to probe the button state.
>> + * @min: minimal raw ADC sample value to consider button as pressed.
>> + * @max: maximal raw ADC sample value to consider button as pressed.
>> + */
>> +struct button_adc_priv {
>> +=C2=A0=C2=A0=C2=A0 struct udevice *adc;
>> +=C2=A0=C2=A0=C2=A0 int channel;
>> +=C2=A0=C2=A0=C2=A0 int min;
>> +=C2=A0=C2=A0=C2=A0 int max;
>> +};
>> +
>> +static enum button_state_t button_adc_get_state(struct udevice *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct button_adc_priv *priv =3D dev_get_priv(dev)=
;
>> +=C2=A0=C2=A0=C2=A0 unsigned int val;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D adc_start_channel(priv->adc, priv->channel=
);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D adc_channel_data(priv->adc, priv->channel,=
 &val);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (val >=3D priv->min=
 && val < priv->max) ?
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BU=
TTON_ON : BUTTON_OFF;
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static int button_adc_probe(struct udevice *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct button_uc_plat *uc_plat =3D dev_get_uclass_=
plat(dev);
>> +=C2=A0=C2=A0=C2=A0 struct button_adc_priv *priv =3D dev_get_priv(dev)=
;
>> +=C2=A0=C2=A0=C2=A0 struct ofnode_phandle_args args;
>> +=C2=A0=C2=A0=C2=A0 u32 treshold, up_treshold, t;
>> +=C2=A0=C2=A0=C2=A0 unsigned int mask;
>> +=C2=A0=C2=A0=C2=A0 ofnode node;
>> +=C2=A0=C2=A0=C2=A0 int ret, vdd;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Ignore the top-level button node */
>> +=C2=A0=C2=A0=C2=A0 if (!uc_plat->label)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D dev_read_phandle_with_args(dev->parent, "i=
o-channels",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "#io-channel-cells", =
0, 0, &args);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D uclass_get_device_by_ofnode(UCLASS_ADC, ar=
gs.node,=20
>> &priv->adc);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ofnode_read_u32(dev_ofnode(dev->parent),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "keyup-threshold-microvolt", &up_tresho=
ld);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ofnode_read_u32(dev_ofnode(dev), "press-th=
reshold-microvolt",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &treshold);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_for_each_subnode(node, dev->parent) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ofnode_read_u32(de=
v_ofnode(dev),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "press-threshol=
d-microvolt", &t);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (t > treshold)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up=
_treshold =3D t;
>
> Linux' Documentation/devicetree/bindings/input/adc-keys.txt describes
> that one virtual key is created per sub-node.
>
> If I read your code correctly, this is not what you are implementing.
> Instead you only define a single key per adc-keys node.
>
> Why are your deviating from the bindings document?

No I don't. button_adc_bind() binds to the root node with 'adc-keys'=20
compatible, while the dev_for_each_subnode() loop instantiates driver=20
for each subnode, so the button_adc_probe() is called for each defined=20
key. I've copied this pattern from gpio-keys driver.

 >> ...

Here is the related code:

>> +static int button_adc_bind(struct udevice *parent)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct udevice *dev;
>> +=C2=A0=C2=A0=C2=A0 ofnode node;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_for_each_subnode(node, parent) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct button_uc_plat *uc_=
plat;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *label;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D ofnode_read_stri=
ng(node, "label");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!label) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
bug("%s: node %s has no label\n", __func__,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofnode_get_name(node));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D device_bind_driver=
_to_node(parent, "button_adc",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ofnode_get_name(node),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 node, &dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uc_plat =3D dev_get_uclass=
_plat(dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uc_plat->label =3D label;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static const struct button_ops button_adc_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .get_state=C2=A0=C2=A0=C2=A0 =3D button_adc_get_st=
ate,
>> +};
>> +
>> +static const struct udevice_id button_adc_ids[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "adc-keys" },
>> +=C2=A0=C2=A0=C2=A0 { }
>> +};
>> +
>> +U_BOOT_DRIVER(button_adc) =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 "button_adc",
>> +=C2=A0=C2=A0=C2=A0 .id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
UCLASS_BUTTON,
>> +=C2=A0=C2=A0=C2=A0 .of_match=C2=A0=C2=A0=C2=A0 =3D button_adc_ids,
>> +=C2=A0=C2=A0=C2=A0 .ops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 &button_adc_ops,
>> +=C2=A0=C2=A0=C2=A0 .priv_auto=C2=A0=C2=A0=C2=A0 =3D sizeof(struct but=
ton_adc_priv),
>> +=C2=A0=C2=A0=C2=A0 .bind=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 button_adc_bind,
>> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 button_adc_probe,
>> +};
>>
>
>
Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

