Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web08.980.1607972106843853018
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:55:07 -0800
Received: by mail-wm1-f68.google.com with SMTP id 190so4492369wmz.0
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7SHco2+LtAmQKDRO6FY2tZN7Wc3KiX/j8kJ1i41oKk=;
        b=wI9OiNDhFYNfn/8gQd68pKzlG7UwOAzRglY3k6HOiqO8vZ5vYW3tOvgq/Om6OMzRGO
         MIBaX/9hhXHuob/V6rOldItdYYL0Yf+Mm4YMNYrtZaPosI359ZvPRp1DKHYyQe8YZooQ
         1+EYtELbwoi/rNpywGIg5q8R/9CeOJudlWunNGgpcjJcnNUd4NCS7I3Rh0fLOphsXfO3
         12iPiNSOB4Jpu8KWROIaRVMI7yWpEvc4xAsGAolSYBFXokBuP/EUrtag2HXRT591uyll
         MZmWG41lmbZRweIkh/9Lw9XlKbxi6yZ+6h+1iJ/2M8gxw3RbFFCaeGqdaKgg4gfMKhK4
         g1Cw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 6/6] configs: khadas-vim3: enable Function button support
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
 <CGME20201214112452eucas1p2ceb557dffa15ea073f922bf59afb8578@eucas1p2.samsung.com>
 <20201214112437.18757-7-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c67d2024-019e-e671-b748-0b25d274d806@baylibre.com>
Date: Mon, 14 Dec 2020 19:55:03 +0100
MIME-Version: 1.0
In-Reply-To: <20201214112437.18757-7-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 14/12/2020 12:24, Marek Szyprowski wrote:
> Add options required to check the 'Function' button state.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  configs/khadas-vim3_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
> index 9d7ba72d440..bc174305692 100644
> --- a/configs/khadas-vim3_defconfig
> +++ b/configs/khadas-vim3_defconfig
> @@ -29,6 +29,10 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_MESON=y
>  CONFIG_DM_MMC=y
> 

If you separate the ADC configs and Button configs, I can directly apply the clk-ao & adc patches
for next release.

Neil
