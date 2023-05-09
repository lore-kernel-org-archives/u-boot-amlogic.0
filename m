Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.26412.1683618825450944966
 for <u-boot-amlogic@groups.io>;
 Tue, 09 May 2023 00:53:45 -0700
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3077d134028so2750435f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 09 May 2023 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683618824; x=1686210824;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IyF4OYotiZ5BcMyCLNgyKufyy/GPg8Qrkx0h80ET8+4=;
        b=FsVKAXVGvYmPO39f4t3hmvgD3f1NaCmIz/Bg6F4Ai47eI9vHAYWlW5rDdjZg0vA2nW
         63a7aHP7eVOfq76aooa6PLukEMhABMZQSdSGM0ZMJwdLYSAvfc5LON6+qlHj6aOrMdXF
         7Njbnq3U4T0HKFEjSq0318/zniXZceLmVMnAJVa+QjdFMAR491kE6aqUZUYafHQS/lmK
         x6wEbPNYZRQuRvH9UfRRHTt6/mlyfNtJqeG3PKq7z72UBG+V/7NzErH4e7xU78OA3GPj
         8nDBRZmNdspslniRaqxLZQG0QO08F22/hjuM+ZvmK8f9IgoPZ/Vxkt2qzNm+/q9Os7Xb
         HQug==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <2c3758b9-d4e8-cf06-195b-dcab9c2e654c@linaro.org>
Date: Tue, 9 May 2023 09:53:42 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 4/6] phy: remove phy-supply related code
References: <20230419134014.128461-1-eugen.hristev@collabora.com>
 <20230419134014.128461-4-eugen.hristev@collabora.com>
In-Reply-To: <20230419134014.128461-4-eugen.hristev@collabora.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Eugen Hristev <eugen.hristev@collabora.com>, kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, xdrudis@tinet.cat, jagan@edgeble.ai, anarsoul@gmail.com
List-ID: <u-boot-amlogic@groups.io>

On 19/04/2023 15:40, Eugen Hristev wrote:
> phy-supply is now handled at uclass level. Remove it from the drivers that
> implement it at the driver level.
> 
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 48 -----------------------------------
>   drivers/phy/meson-gxbb-usb2.c | 38 ---------------------------
>   drivers/phy/meson-gxl-usb2.c  | 30 ----------------------
>   3 files changed, 116 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 2fbba7fdae01..650b88bd1803 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -54,50 +54,12 @@
>   
>   struct phy_meson_g12a_usb2_priv {
>   	struct regmap		*regmap;
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice		*phy_supply;
> -#endif
>   #if CONFIG_IS_ENABLED(CLK)
>   	struct clk		clk;
>   #endif
>   	struct reset_ctl	reset;
>   };
>   
> -
> -static int phy_meson_g12a_usb2_power_on(struct phy *phy)
> -{
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice *dev = phy->dev;
> -	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
> -
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, true);
> -		if (ret)
> -			return ret;
> -	}
> -#endif
> -
> -	return 0;
> -}
> -
> -static int phy_meson_g12a_usb2_power_off(struct phy *phy)
> -{
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice *dev = phy->dev;
> -	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
> -
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, false);
> -		if (ret) {
> -			pr_err("Error disabling PHY supply\n");
> -			return ret;
> -		}
> -	}
> -#endif
> -
> -	return 0;
> -}
> -
>   static int phy_meson_g12a_usb2_init(struct phy *phy)
>   {
>   	struct udevice *dev = phy->dev;
> @@ -155,8 +117,6 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
>   struct phy_ops meson_g12a_usb2_phy_ops = {
>   	.init = phy_meson_g12a_usb2_init,
>   	.exit = phy_meson_g12a_usb2_exit,
> -	.power_on = phy_meson_g12a_usb2_power_on,
> -	.power_off = phy_meson_g12a_usb2_power_off,
>   };
>   
>   int meson_g12a_usb2_phy_probe(struct udevice *dev)
> @@ -193,14 +153,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   	}
>   #endif
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	ret = device_get_supply_regulator(dev, "phy-supply", &priv->phy_supply);
> -	if (ret && ret != -ENOENT) {
> -		pr_err("Failed to get PHY regulator\n");
> -		return ret;
> -	}
> -#endif
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/phy/meson-gxbb-usb2.c b/drivers/phy/meson-gxbb-usb2.c
> index 7a2e3d2739e8..70a80b863819 100644
> --- a/drivers/phy/meson-gxbb-usb2.c
> +++ b/drivers/phy/meson-gxbb-usb2.c
> @@ -12,7 +12,6 @@
>   #include <clk.h>
>   #include <dm.h>
>   #include <generic-phy.h>
> -#include <power/regulator.h>
>   #include <regmap.h>
>   #include <reset.h>
>   #include <linux/bitops.h>
> @@ -81,9 +80,6 @@
>   struct phy_meson_gxbb_usb2_priv {
>   	struct regmap *regmap;
>   	struct reset_ctl_bulk resets;
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice *phy_supply;
> -#endif
>   };
>   
>   static int phy_meson_gxbb_usb2_power_on(struct phy *phy)
> @@ -92,15 +88,6 @@ static int phy_meson_gxbb_usb2_power_on(struct phy *phy)
>   	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
>   	uint val;
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, true);
> -
> -		if (ret)
> -			return ret;
> -	}
> -#endif
> -
>   	regmap_update_bits(priv->regmap, REG_CONFIG,
>   			   REG_CONFIG_CLK_32k_ALTSEL,
>   			   REG_CONFIG_CLK_32k_ALTSEL);
> @@ -140,26 +127,8 @@ static int phy_meson_gxbb_usb2_power_on(struct phy *phy)
>   	return 0;
>   }
>   
> -static int phy_meson_gxbb_usb2_power_off(struct phy *phy)
> -{
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice *dev = phy->dev;
> -	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
> -
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, false);
> -
> -		if (ret)
> -			return ret;
> -	}
> -#endif
> -
> -	return 0;
> -}
> -
>   static struct phy_ops meson_gxbb_usb2_phy_ops = {
>   	.power_on = phy_meson_gxbb_usb2_power_on,
> -	.power_off = phy_meson_gxbb_usb2_power_off,
>   };
>   
>   static int meson_gxbb_usb2_phy_probe(struct udevice *dev)
> @@ -192,13 +161,6 @@ static int meson_gxbb_usb2_phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	ret = device_get_supply_regulator(dev, "phy-supply", &priv->phy_supply);
> -	if (ret && ret != -ENOENT) {
> -		pr_err("Failed to get PHY regulator\n");
> -		return ret;
> -	}
> -#endif
>   	ret = reset_get_bulk(dev, &priv->resets);
>   	if (!ret) {
>   		ret = reset_deassert_bulk(&priv->resets);
> diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
> index 9fb376cec448..4c631310efac 100644
> --- a/drivers/phy/meson-gxl-usb2.c
> +++ b/drivers/phy/meson-gxl-usb2.c
> @@ -16,7 +16,6 @@
>   #include <generic-phy.h>
>   #include <regmap.h>
>   #include <linux/delay.h>
> -#include <power/regulator.h>
>   #include <clk.h>
>   #include <linux/usb/otg.h>
>   
> @@ -101,9 +100,6 @@
>   
>   struct phy_meson_gxl_usb2_priv {
>   	struct regmap		*regmap;
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	struct udevice		*phy_supply;
> -#endif
>   #if CONFIG_IS_ENABLED(CLK)
>   	struct clk		clk;
>   #endif
> @@ -167,14 +163,6 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
>   
>   	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, true);
> -		if (ret)
> -			return ret;
> -	}
> -#endif
> -
>   	return 0;
>   }
>   
> @@ -189,16 +177,6 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>   	val |= U2P_R0_POWER_ON_RESET;
>   	regmap_write(priv->regmap, U2P_R0, val);
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	if (priv->phy_supply) {
> -		int ret = regulator_set_enable(priv->phy_supply, false);
> -		if (ret) {
> -			pr_err("Error disabling PHY supply\n");
> -			return ret;
> -		}
> -	}
> -#endif
> -
>   	return 0;
>   }
>   
> @@ -229,14 +207,6 @@ int meson_gxl_usb2_phy_probe(struct udevice *dev)
>   	}
>   #endif
>   
> -#if CONFIG_IS_ENABLED(DM_REGULATOR)
> -	ret = device_get_supply_regulator(dev, "phy-supply", &priv->phy_supply);
> -	if (ret && ret != -ENOENT) {
> -		pr_err("Failed to get PHY regulator\n");
> -		return ret;
> -	}
> -#endif
> -
>   	return 0;
>   }
>   

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
