Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.7513.1595490241794904440
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Jul 2020 00:44:02 -0700
Received: by mail-wr1-f66.google.com with SMTP id 88so4174274wrh.3
        for <u-boot-amlogic@groups.io>; Thu, 23 Jul 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6eZtzQvaEMEzzxjS5eLpPtTy2kLAIoWjQUVdxaNJE+s=;
        b=YS3AO+hLRMiMdmvpa+wJMRX+++DIqFoHcp/hkL7sMwpHHaqq6l9k4Fn95gAG8gaU/o
         nC47qgc4IUv7HinYNJWL16PtMjA2gNlwRifp0a4b0/hDwW/U5b8aE5+QbHpO7o18zn5C
         MFRS88XlUkWUJl2mLVZMssC/L4GuBBTMlTjEbZAlosqkII1f9cT4yuKabiS3j62/upCa
         KSTRJssgB2JCwjrM9ze0ccRgZFcGJ9/KE8yeKU5pzcc+6+N8P9XYuDgl8i9DtrHQTVXV
         YjKbqhs7Vvkem/Cz69GRBlI2s4k8a3lzIXlCNleRUKCqyt22dq7uFC4X50mXRqhUWu2k
         1koQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: odroid-c2: enable HDMI output
References: <20200722150404.2834-1-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8d033f09-8bc0-310f-0410-becd61a87ba6@baylibre.com>
Date: Thu, 23 Jul 2020 09:43:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200722150404.2834-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The subject should be: "configs: odroid-c2: update for HDMI output, ADC & USB keyboard"

Can you resend ?

On 22/07/2020 17:04, Anand Moon wrote:
> Enable options to permit HDMI output on Odroid-C2 GXBB boards.
> Enable VPU Power Domain.
> Enable ADC and USB_KERBOARD.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/odroid-c2_defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index f62e83a345..c80719abd6 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -15,6 +15,7 @@ CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
> @@ -26,6 +27,7 @@ CONFIG_OF_CONTROL=y
>  CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SARADC_MESON=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_MESON=y
>  CONFIG_DM_MMC=y
> @@ -38,6 +40,8 @@ CONFIG_MESON_GXBB_USB_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_GXBB=y
>  CONFIG_DM_REGULATOR=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_DM_RESET=y
> @@ -47,5 +51,12 @@ CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
>  CONFIG_DM_USB=y
>  CONFIG_USB_DWC2=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_DM_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SMBIOS_MANUFACTURER="Hardkernel Co., Ltd."
> 

With the new subject:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
