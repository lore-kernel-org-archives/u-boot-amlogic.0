Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.103412.1696317938123377908
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:25:38 -0700
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3215f19a13aso628047f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317936; x=1696922736; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y337/XDAUnT+gz+l2dXCsycRVWdnKCPPU0YlcTa7Hns=;
        b=RlBdTLa95NVt2pzyDOwsziKX+KZtJlJvlu3XLJJLDiUK1DiJ6BRIjH8jsVMFwATy+s
         YD0JFRimKf5iIS/ps83tHegL5EOs5rIZuT48X1dwxrogQU6P4MND6cmCItHjLFAiOos2
         RKl39ml6+6RxHbyObElDPHCCuVze6nu7aakVK0ycq/hPyM70+SAkGe8DdPvsyZ02MHAI
         UhYh6eCebObIXU14FcOJ6Y/pxNRYAmCWSx1upcJQLXdzT23m+f77MnixWqb1OVqsw09w
         EGioNIIYGYWTQ0cZOjqiMkZAgFtSFO8+yNdlmY8I7n3rFLD0ixeBUcoy4pfNZhCskTKn
         +QBg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <edd025f8-46a2-4045-9b74-58f0e7a57996@linaro.org>
Date: Tue, 3 Oct 2023 09:25:34 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/8] phy: get rid of raw hex values
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-4-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-4-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> It is better to use defines instead of write raw
> hex values in regmap.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 161 ++++++++++++++++++++++++++++++++--
>   1 file changed, 153 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 650b88bd18..2e366b16ae 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -23,12 +23,28 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
> +#include <linux/bitfield.h>
>   
>   #define PHY_CTRL_R0						0x0
>   #define PHY_CTRL_R1						0x4
>   #define PHY_CTRL_R2						0x8
> +
>   #define PHY_CTRL_R3						0xc
> +	#define PHY_CTRL_R3_SQUELCH_REF				GENMASK(1, 0)
> +	#define PHY_CTRL_R3_HSDIC_REF				GENMASK(3, 2)
> +	#define PHY_CTRL_R3_DISC_THRESH				GENMASK(7, 4)
> +
>   #define PHY_CTRL_R4						0x10
> +	#define PHY_CTRL_R4_CALIB_CODE_7_0			GENMASK(7, 0)
> +	#define PHY_CTRL_R4_CALIB_CODE_15_8			GENMASK(15, 8)
> +	#define PHY_CTRL_R4_CALIB_CODE_23_16			GENMASK(23, 16)
> +	#define PHY_CTRL_R4_I_C2L_CAL_EN			BIT(24)
> +	#define PHY_CTRL_R4_I_C2L_CAL_RESET_N			BIT(25)
> +	#define PHY_CTRL_R4_I_C2L_CAL_DONE			BIT(26)
> +	#define PHY_CTRL_R4_TEST_BYPASS_MODE_EN			BIT(27)
> +	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0			GENMASK(29, 28)
> +	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2			GENMASK(31, 30)
> +
>   #define PHY_CTRL_R5						0x14
>   #define PHY_CTRL_R6						0x18
>   #define PHY_CTRL_R7						0x1c
> @@ -37,15 +53,93 @@
>   #define PHY_CTRL_R10						0x28
>   #define PHY_CTRL_R11						0x2c
>   #define PHY_CTRL_R12						0x30
> +
>   #define PHY_CTRL_R13						0x34
> +	#define PHY_CTRL_R13_CUSTOM_PATTERN_19			GENMASK(7, 0)
> +	#define PHY_CTRL_R13_LOAD_STAT				BIT(14)
> +	#define PHY_CTRL_R13_UPDATE_PMA_SIGNALS			BIT(15)
> +	#define PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET		GENMASK(20, 16)
> +	#define PHY_CTRL_R13_CLEAR_HOLD_HS_DISCONNECT		BIT(21)
> +	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_VAL		BIT(22)
> +	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_EN		BIT(23)
> +	#define PHY_CTRL_R13_I_C2L_HS_EN			BIT(24)
> +	#define PHY_CTRL_R13_I_C2L_FS_EN			BIT(25)
> +	#define PHY_CTRL_R13_I_C2L_LS_EN			BIT(26)
> +	#define PHY_CTRL_R13_I_C2L_HS_OE			BIT(27)
> +	#define PHY_CTRL_R13_I_C2L_FS_OE			BIT(28)
> +	#define PHY_CTRL_R13_I_C2L_HS_RX_EN			BIT(29)
> +	#define PHY_CTRL_R13_I_C2L_FSLS_RX_EN			BIT(30)
> +
>   #define PHY_CTRL_R14						0x38
>   #define PHY_CTRL_R15						0x3c
> +
>   #define PHY_CTRL_R16						0x40
> +	#define PHY_CTRL_R16_MPLL_M				GENMASK(8, 0)
> +	#define PHY_CTRL_R16_MPLL_N				GENMASK(14, 10)
> +	#define PHY_CTRL_R16_MPLL_TDC_MODE			BIT(20)
> +	#define PHY_CTRL_R16_MPLL_SDM_EN			BIT(21)
> +	#define PHY_CTRL_R16_MPLL_LOAD				BIT(22)
> +	#define PHY_CTRL_R16_MPLL_DCO_SDM_EN			BIT(23)
> +	#define PHY_CTRL_R16_MPLL_LOCK_LONG			GENMASK(25, 24)
> +	#define PHY_CTRL_R16_MPLL_LOCK_F			BIT(26)
> +	#define PHY_CTRL_R16_MPLL_FAST_LOCK			BIT(27)
> +	#define PHY_CTRL_R16_MPLL_EN				BIT(28)
> +	#define PHY_CTRL_R16_MPLL_RESET				BIT(29)
> +	#define PHY_CTRL_R16_MPLL_LOCK				BIT(30)
> +	#define PHY_CTRL_R16_MPLL_LOCK_DIG			BIT(31)
> +
>   #define PHY_CTRL_R17						0x44
> +	#define PHY_CTRL_R17_MPLL_FRAC_IN			GENMASK(13, 0)
> +	#define PHY_CTRL_R17_MPLL_FIX_EN			BIT(16)
> +	#define PHY_CTRL_R17_MPLL_LAMBDA1			GENMASK(19, 17)
> +	#define PHY_CTRL_R17_MPLL_LAMBDA0			GENMASK(22, 20)
> +	#define PHY_CTRL_R17_MPLL_FILTER_MODE			BIT(23)
> +	#define PHY_CTRL_R17_MPLL_FILTER_PVT2			GENMASK(27, 24)
> +	#define PHY_CTRL_R17_MPLL_FILTER_PVT1			GENMASK(31, 28)
> +
>   #define PHY_CTRL_R18						0x48
> +	#define PHY_CTRL_R18_MPLL_LKW_SEL			GENMASK(1, 0)
> +	#define PHY_CTRL_R18_MPLL_LK_W				GENMASK(5, 2)
> +	#define PHY_CTRL_R18_MPLL_LK_S				GENMASK(11, 6)
> +	#define PHY_CTRL_R18_MPLL_DCO_M_EN			BIT(12)
> +	#define PHY_CTRL_R18_MPLL_DCO_CLK_SEL			BIT(13)
> +	#define PHY_CTRL_R18_MPLL_PFD_GAIN			GENMASK(15, 14)
> +	#define PHY_CTRL_R18_MPLL_ROU				GENMASK(18, 16)
> +	#define PHY_CTRL_R18_MPLL_DATA_SEL			GENMASK(21, 19)
> +	#define PHY_CTRL_R18_MPLL_BIAS_ADJ			GENMASK(23, 22)
> +	#define PHY_CTRL_R18_MPLL_BB_MODE			GENMASK(25, 24)
> +	#define PHY_CTRL_R18_MPLL_ALPHA				GENMASK(28, 26)
> +	#define PHY_CTRL_R18_MPLL_ADJ_LDO			GENMASK(30, 29)
> +	#define PHY_CTRL_R18_MPLL_ACG_RANGE			BIT(31)
> +
>   #define PHY_CTRL_R19						0x4c
> +
>   #define PHY_CTRL_R20						0x50
> +	#define PHY_CTRL_R20_USB2_IDDET_EN			BIT(0)
> +	#define PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0		GENMASK(3, 1)
> +	#define PHY_CTRL_R20_USB2_OTG_VBUSDET_EN		BIT(4)
> +	#define PHY_CTRL_R20_USB2_AMON_EN			BIT(5)
> +	#define PHY_CTRL_R20_USB2_CAL_CODE_R5			BIT(6)
> +	#define PHY_CTRL_R20_BYPASS_OTG_DET			BIT(7)
> +	#define PHY_CTRL_R20_USB2_DMON_EN			BIT(8)
> +	#define PHY_CTRL_R20_USB2_DMON_SEL_3_0			GENMASK(12, 9)
> +	#define PHY_CTRL_R20_USB2_EDGE_DRV_EN			BIT(13)
> +	#define PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0		GENMASK(15, 14)
> +	#define PHY_CTRL_R20_USB2_BGR_ADJ_4_0			GENMASK(20, 16)
> +	#define PHY_CTRL_R20_USB2_BGR_START			BIT(21)
> +	#define PHY_CTRL_R20_USB2_BGR_VREF_4_0			GENMASK(28, 24)
> +	#define PHY_CTRL_R20_USB2_BGR_DBG_1_0			GENMASK(30, 29)
> +	#define PHY_CTRL_R20_BYPASS_CAL_DONE_R5			BIT(31)
> +
>   #define PHY_CTRL_R21						0x54
> +	#define PHY_CTRL_R21_USB2_BGR_FORCE			BIT(0)
> +	#define PHY_CTRL_R21_USB2_CAL_ACK_EN			BIT(1)
> +	#define PHY_CTRL_R21_USB2_OTG_ACA_EN			BIT(2)
> +	#define PHY_CTRL_R21_USB2_TX_STRG_PD			BIT(3)
> +	#define PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0		GENMASK(5, 4)
> +	#define PHY_CTRL_R21_BYPASS_UTMI_CNTR			GENMASK(15, 6)
> +	#define PHY_CTRL_R21_BYPASS_UTMI_REG			GENMASK(25, 20)
> +
>   #define PHY_CTRL_R22						0x58
>   #define PHY_CTRL_R23						0x5c
>   
> @@ -78,25 +172,76 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
>   
>   	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
> -	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
> -	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
> -	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
> +	regmap_write(priv->regmap, PHY_CTRL_R16,
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
> +		PHY_CTRL_R16_MPLL_LOAD |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
> +		PHY_CTRL_R16_MPLL_FAST_LOCK |
> +		PHY_CTRL_R16_MPLL_EN |
> +		PHY_CTRL_R16_MPLL_RESET);
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R17,
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FRAC_IN, 0) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA1, 7) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA0, 7) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
> +		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R18,
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ROU, 7) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_DATA_SEL, 3) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_BIAS_ADJ, 1) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_BB_MODE, 0) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ALPHA, 3) |
> +		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
> +		PHY_CTRL_R18_MPLL_ACG_RANGE;
>   
>   	udelay(PLL_RESET_COMPLETE_TIME);
>   
>   	/* UnReset PLL */
> -	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
> +	regmap_write(priv->regmap, PHY_CTRL_R16,
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
> +		PHY_CTRL_R16_MPLL_LOAD |
> +		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
> +		PHY_CTRL_R16_MPLL_FAST_LOCK |
> +		PHY_CTRL_R16_MPLL_EN);
>   
>   	/* PHY Tuning */
> -	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
> -	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
> +	regmap_write(priv->regmap, PHY_CTRL_R20,
> +		FIELD_PREP(PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0, 4) |
> +		PHY_CTRL_R20_USB2_OTG_VBUSDET_EN |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_DMON_SEL_3_0, 15) |
> +		PHY_CTRL_R20_USB2_EDGE_DRV_EN |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0, 3) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_ADJ_4_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R4,
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> +		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> +		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> +		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> +		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
>   
>   	/* Tuning Disconnect Threshold */
> -	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
> +	regmap_write(priv->regmap, PHY_CTRL_R3,
> +		FIELD_PREP(PHY_CTRL_R3_SQUELCH_REF, 0) |
> +		FIELD_PREP(PHY_CTRL_R3_HSDIC_REF, 1) |
> +		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
>   
>   	/* Analog Settings */
>   	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> -	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
> +	regmap_write(priv->regmap, PHY_CTRL_R13,
> +		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> +		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
>   
>   	return 0;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
