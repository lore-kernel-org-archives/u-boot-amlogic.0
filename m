Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.2026.1571905193948799717
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Oct 2019 01:19:54 -0700
Received: by mail-wm1-f68.google.com with SMTP id q130so1450627wme.2
        for <u-boot-amlogic@groups.io>; Thu, 24 Oct 2019 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NrwQxsWKbdMhbz6Iy9cpOaRsuxwkbdRw2hLZfWn8Xgk=;
        b=F9zF7hbeVUpKuNu4GCrriBhV0NgssNv1pL8j5hF3MpH2uQPT4SgG8/LxFU7fqNpx6n
         1HdL2a31USjxhNbSXx0l/HqkLkbdl4lk7oUn0TjfduXblQyPC9vFOwVCocCCSpewr3h2
         LSXoO0SFvwAySueYNt1X6NJIc5K9TsGrAkPKygvwkJSuD5YPePbzLX3uqpBcP3O//8EY
         0QzPa/kFbGNmKEd9UwMuvkGlM4b8e8E1p9Vjy7ql6YAyjaCbp61EmH6vAweihl88VLoy
         8fwqZtaDOijIYnPxIuQOx5YuHC3dfe/RgFhGPUcIGy/Wp+Wuz/kFhbCWGtu5PCQYS1gN
         oo3A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: sei610: khadas-vim3 : disable Gadget support for the DWC3
References: <20191024081540.6229-1-jjhiblot@ti.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <60ab69cc-e4ec-89de-5097-eba74506ad69@baylibre.com>
Date: Thu, 24 Oct 2019 10:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <20191024081540.6229-1-jjhiblot@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jean-Jacques Hiblot <jjhiblot@ti.com>, marex@denx.de, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/10/2019 10:15, Jean-Jacques Hiblot wrote:
> Those platform use the DWC2 controller for the gadget support and the
> DWC3 for host-only operations.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
> 
> Applies on u-boot/master.
> Fixes build breakage introduced by "usb: dwc3: Kconfig: get rid of obsolete mode
> selection"
> 
>  configs/khadas-vim3_defconfig | 1 +
>  configs/sei610_defconfig      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
> index cd37f7840e..81ac42e599 100644
> --- a/configs/khadas-vim3_defconfig
> +++ b/configs/khadas-vim3_defconfig
> @@ -44,6 +44,7 @@ CONFIG_DM_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
> diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
> index 520a683d2e..1f36722a8e 100644
> --- a/configs/sei610_defconfig
> +++ b/configs/sei610_defconfig
> @@ -62,6 +62,7 @@ CONFIG_DM_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> 

Acked-by: Neil Armstrong <narmstrog@baylibre.com>
