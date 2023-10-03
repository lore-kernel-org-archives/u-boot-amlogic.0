Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.103440.1696318084454032673
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:28:04 -0700
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so638941f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696318083; x=1696922883; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI1Orn3EJa3HQcc/ggnsfl+sLGf56m79pjP3Xr2ASt4=;
        b=WP/cLyIo5FqcJt9ml3Q7WNF93GZ1N/QdkI5wAE8r1yeSNF17wj6ivgHYw71ezIyYHG
         SWMWdSN4/Xe+UmDE0+RSaXpxR7Fk1jtUhhCQR7YTmJOd1cQiQtFK/uMH+91LGLv6noaF
         zzJxxgD2WD3oRKP0yEN+e5tO2LlpvcT8tuR9wrKe1xQoo0y21WHVF/1eQ3aomSG/GfvZ
         rxH5DnmsnIO3/GTe6Y8n81dJQZiN+7H/nHZWgVqdV715fCsI9TP6D3mpSE75uVJp8lXR
         pJafgzQV3sj48lfH5hOfGK8D73bvni5f1VcVVMYZR3sLEMscyqw21qySYdnsN6uAoQG3
         okBA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <60b40445-d790-4f1d-89a8-14b8beb20d9e@linaro.org>
Date: Tue, 3 Oct 2023 09:28:00 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 7/8] dwc3: add support for Amlogic A1 family
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-8-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-8-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> Now the driver supports also A1 phy layer.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 73 ++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 90418ddc1d..550e6682a2 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -28,6 +28,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
> +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>   
>   /* USB2 Ports Control Registers */
>   
> @@ -102,10 +103,22 @@ enum {
>   	PHY_COUNT,
>   };
>   
> -static const char *phy_names[PHY_COUNT] = {
> +static const char *const dwc3_meson_g12a_phy_names[] = {
>   	"usb2-phy0", "usb2-phy1", "usb3-phy0",
>   };
>   
> +static const char *const dwc3_meson_a1_phy_names[] = {
> +	"usb2-phy0", "usb2-phy1"
> +};
> +
> +struct dwc3_meson_g12a;
> +
> +struct dwc3_meson_g12a_drvdata {
> +	const char *const *phy_names;
> +	unsigned int phy_cnt;
> +	int (*clk_init)(struct dwc3_meson_g12a *priv);
> +};
> +
>   struct dwc3_meson_g12a {
>   	struct udevice		*dev;
>   	struct regmap           *regmap;
> @@ -119,6 +132,7 @@ struct dwc3_meson_g12a {
>   #if CONFIG_IS_ENABLED(DM_REGULATOR)
>   	struct udevice		*vbus_supply;
>   #endif
> +	struct dwc3_meson_g12a_drvdata *drvdata;
>   };
>   
>   #define U2P_REG_SIZE						0x20
> @@ -293,10 +307,11 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
>   
>   static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
>   {
> +	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
>   	int i, ret;
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> -		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
> +		ret = generic_phy_get_by_name(priv->dev, data->phy_names[i],
>   					      &priv->phys[i]);
>   		if (ret == -ENOENT || ret == -ENODATA)
>   			continue;
> @@ -354,18 +369,36 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson_g12a *priv)
>   	return 0;
>   }
>   
> +static int dwc3_meson_a1_clk_init(struct dwc3_meson_g12a *priv)
> +{
> +	int ret;
> +
> +	ret = clk_get_by_name(priv->dev, "usb_bus", &priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int dwc3_meson_g12a_probe(struct udevice *dev)
>   {
>   	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
> +	struct dwc3_meson_g12a_drvdata *data =
> +		(struct dwc3_meson_g12a_drvdata *)dev_get_driver_data(dev);
>   	int ret, i;
>   
> +	priv->drvdata = data;
>   	priv->dev = dev;
>   
>   	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   	if (ret)
>   		return ret;
>   
> -	ret = dwc3_meson_g12a_clk_init(priv);
> +	ret = data->clk_init(priv);
>   	if (ret)
>   		return ret;
>   
> @@ -398,7 +431,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -407,7 +440,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   			goto err_phy_init;
>   	}
>   
> -	for (i = 0; i < PHY_COUNT; ++i) {
> +	for (i = 0; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -419,7 +452,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   	return 0;
>   
>   err_phy_init:
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt ; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -432,20 +465,21 @@ err_phy_init:
>   static int dwc3_meson_g12a_remove(struct udevice *dev)
>   {
>   	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
> +	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
>   	int i;
>   
>   	reset_release_all(&priv->reset, 1);
>   
>   	clk_release_all(&priv->clk, 1);
>   
> -	for (i = 0; i < PHY_COUNT; ++i) {
> +	for (i = 0; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
>   		 generic_phy_power_off(&priv->phys[i]);
>   	}
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -455,8 +489,27 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
>   	return dm_scan_fdt_dev(dev);
>   }
>   
> +static const struct dwc3_meson_g12a_drvdata meson_g12a_drvdata = {
> +	.phy_names = dwc3_meson_g12a_phy_names,
> +	.phy_cnt = ARRAY_SIZE(dwc3_meson_g12a_phy_names),
> +	.clk_init = dwc3_meson_g12a_clk_init,
> +};
> +
> +static const struct dwc3_meson_g12a_drvdata meson_a1_drvdata = {
> +	.phy_names = dwc3_meson_a1_phy_names,
> +	.phy_cnt = ARRAY_SIZE(dwc3_meson_a1_phy_names),
> +	.clk_init = dwc3_meson_a1_clk_init,
> +};
> +
>   static const struct udevice_id dwc3_meson_g12a_ids[] = {
> -	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
> +	{
> +		.compatible = "amlogic,meson-g12a-usb-ctrl",
> +		.data = (ulong)&meson_g12a_drvdata,
> +	},
> +	{
> +		.compatible = "amlogic,meson-a1-usb-ctrl",
> +		.data = (ulong)&meson_a1_drvdata,
> +	},
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
