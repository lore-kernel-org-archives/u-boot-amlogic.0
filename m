Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.2275.1589360510791159362
 for <u-boot-amlogic@groups.io>;
 Wed, 13 May 2020 02:01:51 -0700
Received: by mail-wr1-f66.google.com with SMTP id s8so19885561wrt.9
        for <u-boot-amlogic@groups.io>; Wed, 13 May 2020 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cTECsnv+hNCmBe4PP+CyXJkEcqEQbk8odHGvthgrBI=;
        b=pyCHExa0MyUx7+pUpBp/hHOrXnvVgVbbBz3WyoVvHt15CPjEVB7bBOmBwIPGLf9WlP
         ITMz2nHlT6H6GHqunDSY4QPVCF+g+/YgmofKgs11XswDq2NYfv2NeHxB4elqH2Fc/R3h
         QTwbZriIDRMP+D4jnmPX/fyUYl5/PXeOJcscjjdXHh1Lr90BZQu0SUUHIWheQVmJHysb
         bcM+SXFdYke8r1rfAW+WNOofzsvQjwUBD9q/mSGi4mh4a1y6iE5MqfEmPzdf6Uvq0Un5
         jSo0PLYcG0H1JRKsm+Uul8oruOtwK5w14zDlqeIAit5MC8u61eLCM7Lgk2KvIm2uid1l
         BNzw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] configs: khadas-vim3: enable HDMI output
References: <20200511131728.5570-1-narmstrong@baylibre.com>
 <160DFBC267226B0F.7726@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bef4f0d6-9849-7c52-51d5-e8e6c092f992@baylibre.com>
Date: Wed, 13 May 2020 11:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <160DFBC267226B0F.7726@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 11/05/2020 15:17, Neil Armstrong via groups.io wrote:
> Enable options to permit HDMI output on Khadas VIM3 & VIM3L boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  configs/khadas-vim3_defconfig  | 9 +++++++++
>  configs/khadas-vim3l_defconfig | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
> index 692138eb11..4aeab0e35d 100644
> --- a/configs/khadas-vim3_defconfig
> +++ b/configs/khadas-vim3_defconfig
> @@ -40,6 +40,8 @@ CONFIG_ETH_DESIGNWARE=y
>  CONFIG_MESON_G12A_USB_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_RESET=y
> @@ -55,6 +57,7 @@ CONFIG_DM_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +CONFIG_USB_KEYBOARD=y
>  # CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
>  CONFIG_USB_GADGET=y
> @@ -63,4 +66,10 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_DM_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
> index 28c20c0d6d..887885f329 100644
> --- a/configs/khadas-vim3l_defconfig
> +++ b/configs/khadas-vim3l_defconfig
> @@ -57,6 +57,7 @@ CONFIG_DM_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +CONFIG_USB_KEYBOARD=y
>  # CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
>  CONFIG_USB_GADGET=y
> @@ -66,6 +67,9 @@ CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_DM_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_VIDEO_MESON=y
>  CONFIG_VIDEO_DT_SIMPLEFB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
>
Applied to u-boot-amlogic

Neil
