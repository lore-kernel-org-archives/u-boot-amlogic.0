Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web11.849.1608059949713103973
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 11:19:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1608059941;
	bh=GEn818FjCLibBhmMuXba0SlTLjyTTY6G/WSEiZlJt6s=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=ePFFoXgq1sqLSxGDRdc2mwfs5nZcNZc7aKgiEel2P+Zs0nGyb6hiwt7gcS0EJ16xS
	 krAidc7klEil/9FME8NF1dMEBxLdE9zD/QbFE0ZQs9/spyJS6HrrOHq+HYK1D6soWZ
	 nluSJRGV0NjnSjwh2Wezg1tY9rzqYJymmvK7Id/I=
Subject: Re: [PATCH v2 5/7] button: add a simple ADC-based button driver
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
 <CGME20201215144244eucas1p12404d7047f032e03ebcad27b88f23a25@eucas1p1.samsung.com>
 <20201215144230.9235-6-m.szyprowski@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <025dc553-b8f1-d334-24f8-54523b29428e@gmx.de>
Date: Tue, 15 Dec 2020 20:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <20201215144230.9235-6-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 3:42 PM, Marek Szyprowski wrote:
> Add a simple ADC-based button driver. This driver binds to the 'adc-keys=
'
> device tree node.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/button/Kconfig      |   8 +++
>   drivers/button/Makefile     |   1 +
>   drivers/button/button-adc.c | 117 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 126 insertions(+)
>   create mode 100644 drivers/button/button-adc.c
>
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 6b3ec7e55d..283367f2bd 100644
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
> +	  Enable support for buttons which are connected to ADC lines. The ADC

ADC might stand for "Analog to Digital Converter", or "Automated Data
Collection", or "Automatic Distance Control, or something else. Please,
replace the abbreviation by the full expression.

Best regards

Heinrich

> +	  driver must use driver model. Buttons are configured using the devic=
e
> +	  tree.
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
> index 0000000000..086c676c02
> --- /dev/null
> +++ b/drivers/button/button-adc.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + */
> +
> +#include <common.h>
> +#include <button.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <dm/uclass-internal.h>
> +#include <log.h>
> +#include <adc.h>
> +
> +struct button_adc_priv {
> +	struct udevice *adc;
> +	int channel;
> +};
> +
> +static enum button_state_t button_adc_get_state(struct udevice *dev)
> +{
> +	struct button_adc_priv *priv =3D dev_get_priv(dev);
> +	unsigned int val, mask;
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
> +	ret =3D adc_data_mask(priv->adc, &mask);
> +	if (ret)
> +		return ret;
> +
> +	/* getting state is simplified a bit */
> +	if (ret =3D=3D 0)
> +		return (val < mask / 2) ? BUTTON_ON : BUTTON_OFF;
> +
> +	return ret;
> +}
> +
> +static int button_adc_probe(struct udevice *dev)
> +{
> +	struct button_uc_plat *uc_plat =3D dev_get_uclass_platdata(dev);
> +	struct button_adc_priv *priv =3D dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	int ret;
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
> +	ret =3D uclass_get_device_by_name(UCLASS_ADC, ofnode_get_name(args.nod=
e),
> +					&priv->adc);
> +	if (ret)
> +		return ret;
> +
> +	priv->channel =3D args.args[0];
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
> +		uc_plat =3D dev_get_uclass_platdata(dev);
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
> +	.priv_auto_alloc_size =3D sizeof(struct button_adc_priv),
> +	.bind		=3D button_adc_bind,
> +	.probe		=3D button_adc_probe,
> +};
>

