Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.108080.1696339249386819982
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 06:20:49 -0700
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-317c3ac7339so944778f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696339248; x=1696944048; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2Q3dx5DjcgMxfcC+WcIYhO7m+VcD7KHy6pA9uIZNiA=;
        b=qafROfxnQt8cVmAlJfzPkbs5sh5itnovExb0+DSAhOtMgnGGaj1NXJ8QBh+zQFs792
         IEK5+WKW7FybyiWOt0E9pEEkDRfM1qUNqYMqynZo+Kv+h213bxtuHVI1jL3hX4L8LqlE
         7f8X2mX8J+pU5N0zy5qOrYwZprguHmLOb2a1Jdypau5eA1JVwwfGiqTTBxGaUk4A4nIU
         6OFFsfJOrXqhAXWelI1yzGbb/FzmYTrKOrD3WLtSOlbxtb1cSY8WKHQADRj3BMBsewNb
         E/9FrQmbxjWnC6G6bzXv4Dc7WoNlXk2esuxqH9r1IVC6ChVCkpNSIIqe7xmxSWMBFXZf
         pVNA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <5d2f41d9-d98a-486d-b5da-6289dcffffea@linaro.org>
Date: Tue, 3 Oct 2023 15:20:46 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/8] phy: support Amlogic A1 family
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-6-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-6-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 03/10/2023 13:28, Alexey Romanov wrote:
> Setting G12A and A1 is similar, so we can use G12A phy
> driver with little changes.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/Kconfig           |  2 +-
>   drivers/phy/meson-g12a-usb2.c | 79 ++++++++++++++++++++++++++++-------
>   2 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index cf4d5908d7..60be62907d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -190,7 +190,7 @@ config MESON_GXL_USB_PHY
>   
>   config MESON_G12A_USB_PHY
>   	bool "Amlogic Meson G12A USB PHYs"
> -	depends on PHY && ARCH_MESON && MESON_G12A
> +	depends on PHY && ARCH_MESON && (MESON_G12A || MESON_A1)
>   	imply REGMAP
>   	help
>   	  This is the generic phy driver for the Amlogic Meson G12A
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 7b028784a0..90053dbea3 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -18,6 +18,7 @@
>   #include <regmap.h>
>   #include <linux/delay.h>
>   #include <power/regulator.h>
> +#include <power-domain.h>
>   #include <reset.h>
>   #include <clk.h>
>   
> @@ -146,18 +147,28 @@
>   #define RESET_COMPLETE_TIME					1000
>   #define PLL_RESET_COMPLETE_TIME					100
>   
> +enum meson_soc_id {
> +	MESON_SOC_A1,
> +	MESON_SOC_G12A,
> +};
> +
>   struct phy_meson_g12a_usb2_priv {
>   	struct regmap		*regmap;
>   #if CONFIG_IS_ENABLED(CLK)
>   	struct clk		clk;
>   #endif
>   	struct reset_ctl	reset;
> +#if CONFIG_IS_ENABLED(POWER_DOMAIN)
> +	struct power_domain pwrdm;
> +#endif
> +	int soc_id;
>   };
>   
>   static int phy_meson_g12a_usb2_init(struct phy *phy)
>   {
>   	struct udevice *dev = phy->dev;
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
> +	u32 value;
>   	int ret;
>   
>   #if CONFIG_IS_ENABLED(CLK)
> @@ -196,8 +207,7 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
>   		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
>   
> -	regmap_write(priv->regmap, PHY_CTRL_R18,
> -		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
> +	value = FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
> @@ -209,6 +219,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
>   		PHY_CTRL_R18_MPLL_ACG_RANGE;
>   
> +	if (priv->soc_id == MESON_SOC_A1)
> +		value |= PHY_CTRL_R18_MPLL_DCO_CLK_SEL;
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R18, value);
> +
>   	udelay(PLL_RESET_COMPLETE_TIME);
>   
>   	/* UnReset PLL */
> @@ -231,13 +246,19 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
>   		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
>   
> -	regmap_write(priv->regmap, PHY_CTRL_R4,
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> -		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> -		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> -		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
> +	if (priv->soc_id == MESON_SOC_G12A)
> +		regmap_write(priv->regmap, PHY_CTRL_R4,
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> +			PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> +			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> +			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
> +	else if (priv->soc_id == MESON_SOC_A1)
> +		regmap_write(priv->regmap, PHY_CTRL_R21,
> +			PHY_CTRL_R21_USB2_CAL_ACK_EN |
> +			PHY_CTRL_R21_USB2_TX_STRG_PD |
> +			FIELD_PREP(PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0, 2));
>   
>   	/* Tuning Disconnect Threshold */
>   	regmap_write(priv->regmap, PHY_CTRL_R3,
> @@ -246,10 +267,15 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
>   
>   	/* Analog Settings */
> -	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> -	regmap_write(priv->regmap, PHY_CTRL_R13,
> -		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> -		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	if (priv->soc_id == MESON_SOC_G12A) {
> +		regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> +		regmap_write(priv->regmap, PHY_CTRL_R13,
> +			PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> +			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	} else if (priv->soc_id == MESON_SOC_A1) {
> +		regmap_write(priv->regmap, PHY_CTRL_R13,
> +			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	}
>   
>   	return 0;
>   }
> @@ -281,6 +307,8 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +	priv->soc_id = (enum meson_soc_id)dev_get_driver_data(dev);
> +
>   	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   	if (ret)
>   		return ret;
> @@ -297,6 +325,22 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> +#if CONFIG_IS_ENABLED(POWER_DOMAIN)
> +	ret = power_domain_get(dev, &priv->pwrdm);
> +	if (ret < 0 && ret != -ENODEV) {
> +		pr_err("failed to get power domain\n");
> +		return ret;
> +	}
> +
> +	if (ret != -ENODEV) {
> +		ret = power_domain_on(&priv->pwrdm);
> +		if (ret < 0) {
> +			pr_err("failed to enable power domain\n");
> +			return ret;
> +		}
> +	}
> +#endif
> +
>   #if CONFIG_IS_ENABLED(CLK)
>   	ret = clk_get_by_index(dev, 0, &priv->clk);
>   	if (ret < 0)
> @@ -307,7 +351,14 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   }
>   
>   static const struct udevice_id meson_g12a_usb2_phy_ids[] = {
> -	{ .compatible = "amlogic,g12a-usb2-phy" },
> +	{
> +		.compatible = "amlogic,g12a-usb2-phy",
> +		.data = (ulong)MESON_SOC_G12A,
> +	},
> +	{
> +		.compatible = "amlogic,a1-usb2-phy",
> +		.data = (ulong)MESON_SOC_A1,
> +	},
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
