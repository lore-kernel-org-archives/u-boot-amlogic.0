Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.190557.1598258048010851324
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2020 01:34:08 -0700
Received: by mail-wr1-f67.google.com with SMTP id r15so7739876wrp.13
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2020 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wuZozwV6xyKm7SMdTmNWC1Ndq0iDLShWwVl1LCxeuWY=;
        b=WDjuPRaKRdGEUlfk47zXFSQ65OisNuy/Y1jZ7npxEAk8QHR2rv4JtX70+y+syiAe+5
         ZdSQV/6kRHZuDjt+PUXy+Gq2FXRVgD0TVucqAA00wxeJS86J+y81/yd1LNQ9KagcEoGE
         Nr7gJH3nb6d2Ng3afW3S7vbfPVRS211Ee7wyDneFHJ93W44cEIv6D7/zCq/wGHDS001Q
         qU2UzRJvjU44J+D6WB4lTWOCDA+YefaELTfNzEW/n5jY/BOZY1q4xpfK/1i6aov7qcnB
         Kx3qOLrNeCFDSrmXfzSZVrjDwUJNQAaUmcEIqAKUC8rLcp+I4YMgP1ZOd8Tu6WszK/9h
         ru3Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] configs: odroid-c4: update for HDMI output background & USB keyboard
References: <20200814062515.1803-1-linux.amoon@gmail.com>
 <20200814062515.1803-2-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b6a5996a-b7cd-4b97-ec71-cdb830cac202@baylibre.com>
Date: Mon, 24 Aug 2020 10:34:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200814062515.1803-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On 14/08/2020 08:25, Anand Moon wrote:
> Enable options SYS_WHITE_ON_BLACK to permit HDMI background
> screen from white to back, also enable USB_KEYBOARD.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/odroid-c4_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index 4d112d3490..50653de638 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -49,6 +49,7 @@ CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  # CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_USB_KEYBOARD=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
> @@ -56,6 +57,9 @@ CONFIG_USB_GADGET_DWC2_OTG=y
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

Acked-by: Neil Armstrong <narmstrong@baylibre.com>


Applying to u-boot-amlogic

Neil
