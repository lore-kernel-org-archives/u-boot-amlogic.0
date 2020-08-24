Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.191342.1598258041134791296
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2020 01:34:01 -0700
Received: by mail-wm1-f66.google.com with SMTP id a65so3872917wme.5
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2020 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjTnhgI//mns9bR1HbQ9hHwR+X0RmgdZ6i39/z2r31w=;
        b=BxxtKIi9rsgYSr8T678bp1m+g5cRzSiE+hNf411ff+V0i7vB1W8kGouzEcd2gFKbQr
         hgBTaG2JPeGq0suIAny8IUHqhXSXg0nDh0cNgOLnzVyPWUvVRdA0ozY4FGk9OluI8Iwz
         bGsB2PAD8sNQDHowa8uOS2UxRt/U0YhH+Qq8NTpwhP88I8LLFHcqydhLbCsmTPXqiHgQ
         QryLE/aI7IVSlyEk9bkefX501rjb6Ia6H4hImAPq7jdJoZ2SLxtSOjCxF/FiGxDk/Qrh
         i9XrX0LcoZJt3MpanGOxy7HSmC4ASqL+pyHo+SMLCCD3I8+9ZITVfh0s1a3gOcSxctJN
         1tOA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] configs: odroid-n2: update for HDMI output & USB keyboard
References: <20200814062515.1803-1-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9d24c034-a658-c79e-b569-b4a9d8e9aa2b@baylibre.com>
Date: Mon, 24 Aug 2020 10:33:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200814062515.1803-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On 14/08/2020 08:25, Anand Moon wrote:
> Enable options to permit HDMI output on Odroid-N2 G12B boards.
> Enable VPU Power Domain.
> Enable USB_KEYBOARD.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/odroid-n2_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index 358d1fc630..e8b8da9084 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -34,6 +34,8 @@ CONFIG_ETH_DESIGNWARE=y
>  CONFIG_MESON_G12A_USB_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_RESET=y
> @@ -47,10 +49,17 @@ CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  # CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_USB_KEYBOARD=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
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
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>


Applying to u-boot-amlogic

Neil
