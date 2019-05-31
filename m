Received: by mail-wm1-f66.google.com with SMTP id c6so2406965wml.0
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uZbuxhHVHcynOQgqA0CBgFMa9ielraHbwouUTo0tDiI=;
        b=wmxCj0XPy0a3ClJ6+VCUgSyD7dL3f6XUZHTjoQIaYCzrYCjFrLCdGOnphUnUm+ijLp
         lMSXqkkAldKLB24V+4lVJ5zpx3ebZctSuqLwLC3qwnTwufkQrWRr+NStb6cYzfFBSJJF
         3GxVlw/KUP3cCNjY7SIELi/NiyXtACFPxLyAdH6zCKEOSbQL3pVQWmadzKDWRmOdMv9f
         QtERQpkgSMITsfSHUzuuIiphFkZcQrY0B7gVJBW1hY8HHJRcDzznzMrW7I+IKwYbE5lt
         LwnveouOZP3dumuqG+Vl2UgtdydhdadcsnbHIEUdjlI6wQEZMvW//k5T1kNmZuX2PhCt
         c88g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: u200: enable support for USB Host & Gadget
References: <20190531081057.8761-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <432db1b5-93dc-3237-e040-a7b40eabc65f@baylibre.com>
Date: Fri, 31 May 2019 10:20:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190531081057.8761-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 31/05/2019 10:10, Neil Armstrong wrote:
> Now the Amlogic G12A DT and drivers are present, enable full USB
> on the U200 Reference Design board.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  configs/u200_defconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/configs/u200_defconfig b/configs/u200_defconfig
> index 13b6f41847..2c0999c707 100644
> --- a/configs/u200_defconfig
> +++ b/configs/u200_defconfig
> @@ -37,3 +37,20 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_USB=y
> +CONFIG_USB_HOST=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_PHY=y
> +CONFIG_MESON_G12A_USB_PHY=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
> 

Applied to u-boot-amlogic
