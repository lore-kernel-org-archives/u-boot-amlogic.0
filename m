Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web12.10671.1611659468697008246
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 03:11:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1611659459;
	bh=YtjfyOUqWEkYdvx/ZjxSmKfYsAM8+/OIcjPsyGn13BA=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=H+ERezk7Td/Kq7ENUmxIGNyp0S/tbhC3wbitkTz6Z1hKJTLJf3lgv0nG8iKS+4nYn
	 QHr+MROlVTvwFzfUsTFJChLCU6ZBdSZyxCxBciv2EViOtQT6QtdiW6xcxtZRsFfJ0y
	 2aiK1a+OzGuXugtlAUKrzoLq2xsyOQupriv6quxg=
Subject: Re: [PATCH v5 2/4] button: add a simple Analog to Digital Converter device based button driver
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
 <CGME20210126095112eucas1p1af8ac76eaede4baf2b0cfeac561a6a06@eucas1p1.samsung.com>
 <20210126095036.6429-3-m.szyprowski@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <e2bf2621-a9a4-9ba6-ccbb-0a6b35c8d8bf@gmx.de>
Date: Tue, 26 Jan 2021 12:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <20210126095036.6429-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 1/26/21 10:50 AM, Marek Szyprowski wrote:
> Add a simple Analog to Digital Converter device based button driver. Thi=
s
> driver binds to the 'adc-keys' device tree node.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/button/Kconfig      |   8 ++
>   drivers/button/Makefile     |   1 +
>   drivers/button/button-adc.c | 156 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 165 insertions(+)
>   create mode 100644 drivers/button/button-adc.c
>
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 6b3ec7e55d..6db3c5e93a 100644
> --- a/drivers/button/Kconfig
> +++ b/drivers/button/Kconfig
> @@ -9,6 +9,14 @@ config BUTTON
>   	  can provide access to board-specific buttons. Use of the device tre=
e
>   	  for configuration is encouraged.
>
> +config BUTTON_ADC
> +	bool "Button adc"
> +	depends on BUTTON
> +	help
> +	  Enable support for buttons which are connected to Analog to Digital
> +	  Converter device. The ADC driver must use driver model. Buttons are
> +	  configured using the device tree.
> +
>   config BUTTON_GPIO
>   	bool "Button gpio"
>   	depends on BUTTON
> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
> index fcc10ebe8d..bbd18af149 100644
> --- a/drivers/button/Makefile
> +++ b/drivers/button/Makefile
> @@ -3,4 +3,5 @@
>   # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
>
>   obj-$(CONFIG_BUTTON) +=3D button-uclass.o
> +obj-$(CONFIG_BUTTON_ADC) +=3D button-adc.o
>   obj-$(CONFIG_BUTTON_GPIO) +=3D button-gpio.o
> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
> new file mode 100644
> index 0000000000..1901d59a0e
> --- /dev/null
> +++ b/drivers/button/button-adc.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + */
> +
> +#include <common.h>
> +#include <adc.h>
> +#include <button.h>
> +#include <log.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <dm/of_access.h>
> +#include <dm/uclass-internal.h>
> +
> +/**
> + * struct button_adc_priv - private data for button-adc driver.
> + *
> + * @adc: Analog to Digital Converter device to which button is connecte=
d.
> + * @channel: channel of the ADC device to probe the button state.
> + * @min: minimal raw ADC sample value to consider button as pressed.
> + * @max: maximal raw ADC sample value to consider button as pressed.
> + */
> +struct button_adc_priv {
> +	struct udevice *adc;
> +	int channel;
> +	int min;
> +	int max;
> +};
> +
> +static enum button_state_t button_adc_get_state(struct udevice *dev)
> +{
> +	struct button_adc_priv *priv =3D dev_get_priv(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D adc_start_channel(priv->adc, priv->channel);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adc_channel_data(priv->adc, priv->channel, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (ret =3D=3D 0)
> +		return (val >=3D priv->min && val < priv->max) ?
> +			BUTTON_ON : BUTTON_OFF;
> +
> +	return ret;
> +}
> +
> +static int button_adc_probe(struct udevice *dev)
> +{
> +	struct button_uc_plat *uc_plat =3D dev_get_uclass_plat(dev);
> +	struct button_adc_priv *priv =3D dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	u32 treshold, up_treshold, t;
> +	unsigned int mask;
> +	ofnode node;
> +	int ret, vdd;
> +
> +	/* Ignore the top-level button node */
> +	if (!uc_plat->label)
> +		return 0;
> +
> +	ret =3D dev_read_phandle_with_args(dev->parent, "io-channels",
> +					 "#io-channel-cells", 0, 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D uclass_get_device_by_ofnode(UCLASS_ADC, args.node, &priv->adc)=
;
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ofnode_read_u32(dev_ofnode(dev->parent),
> +			      "keyup-threshold-microvolt", &up_treshold);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ofnode_read_u32(dev_ofnode(dev), "press-threshold-microvolt",
> +			      &treshold);
> +	if (ret)
> +		return ret;
> +
> +	dev_for_each_subnode(node, dev->parent) {
> +		ret =3D ofnode_read_u32(dev_ofnode(dev),
> +				      "press-threshold-microvolt", &t);
> +		if (ret)
> +			return ret;
> +
> +		if (t > treshold)
> +			up_treshold =3D t;

Linux' Documentation/devicetree/bindings/input/adc-keys.txt describes
that one virtual key is created per sub-node.

If I read your code correctly, this is not what you are implementing.
Instead you only define a single key per adc-keys node.

Why are your deviating from the bindings document?

Best regards

Heinrich

> +	}
> +
> +	ret =3D adc_vdd_value(priv->adc, &vdd);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adc_data_mask(priv->adc, &mask);
> +	if (ret)
> +		return ret;
> +
> +	priv->channel =3D args.args[0];
> +	priv->min =3D mask * (treshold / 1000) / (vdd / 1000);
> +	priv->max =3D mask * (up_treshold / 1000) / (vdd / 1000);
> +
> +	return ret;
> +}
> +
> +static int button_adc_bind(struct udevice *parent)
> +{
> +	struct udevice *dev;
> +	ofnode node;
> +	int ret;
> +
> +	dev_for_each_subnode(node, parent) {
> +		struct button_uc_plat *uc_plat;
> +		const char *label;
> +
> +		label =3D ofnode_read_string(node, "label");
> +		if (!label) {
> +			debug("%s: node %s has no label\n", __func__,
> +			      ofnode_get_name(node));
> +			return -EINVAL;
> +		}
> +		ret =3D device_bind_driver_to_node(parent, "button_adc",
> +						 ofnode_get_name(node),
> +						 node, &dev);
> +		if (ret)
> +			return ret;
> +		uc_plat =3D dev_get_uclass_plat(dev);
> +		uc_plat->label =3D label;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct button_ops button_adc_ops =3D {
> +	.get_state	=3D button_adc_get_state,
> +};
> +
> +static const struct udevice_id button_adc_ids[] =3D {
> +	{ .compatible =3D "adc-keys" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(button_adc) =3D {
> +	.name		=3D "button_adc",
> +	.id		=3D UCLASS_BUTTON,
> +	.of_match	=3D button_adc_ids,
> +	.ops		=3D &button_adc_ops,
> +	.priv_auto	=3D sizeof(struct button_adc_priv),
> +	.bind		=3D button_adc_bind,
> +	.probe		=3D button_adc_probe,
> +};
>

