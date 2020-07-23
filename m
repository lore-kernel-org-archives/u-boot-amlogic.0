Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.8092.1595493507457847033
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Jul 2020 01:38:27 -0700
Received: by mail-wr1-f66.google.com with SMTP id q5so4315657wru.6
        for <u-boot-amlogic@groups.io>; Thu, 23 Jul 2020 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ge1Nf4xcMvqckRrTQ3ChOh0PH1W4AYz3vF9NDQDYYU4=;
        b=CQmu2Jc4ZjMnOjdzLJPF94xJibSQW/jhGCCJReR22NWBcAH90tkjbfRzzBKNzcBrO9
         RAuNiwTCW6fpijACqiLBU5FSkDk5CPsTf5HN0elOLZ2emkiomm+0QqonUoAlARhen1Qo
         H+/Cg1lnEEhzttQ3+Qmmude5kiwuPqb+GjH1Mad/hiBaNKC3hU1KRLnOiNsRBftcQQvu
         MIyVAQDLM/IKN6w51S03fdXI3rp9hVesRJCg/yDxUcbcbUJiK+koHE8nE1nkFws7J+aH
         u0croaG+5wM8sNBruBm6G1Ac2baDdK7zqi60CZ5GRDoekMqDOPsHZhmBMvLDIOrJOCNY
         x4mQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] configs: odroid-c2: update for HDMI output, ADC & USB keyboard
References: <20200723080635.1377-1-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <be1a513d-eeb7-242c-e2a1-ef57a667a9db@baylibre.com>
Date: Thu, 23 Jul 2020 10:38:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200723080635.1377-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 23/07/2020 10:06, Anand Moon wrote:
> Enable options to permit HDMI output on Odroid-C2 GXBB boards.
> Enable VPU Power Domain.
> Enable ADC and USB_KERBOARD.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes:
> --fix the subject
> --Add revieved by Neil
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

Applied to u-boot-amlogic

Neil
