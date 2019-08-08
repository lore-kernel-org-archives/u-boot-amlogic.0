Received: by mail-wr1-f67.google.com with SMTP id 31so94013278wrm.1
        for <u-boot-amlogic@groups.io>; Thu, 08 Aug 2019 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RRDDwa3N/FY3sjhfPN/cf5ZfX2VWDf9V3XnCMJiOjm0=;
        b=J6XzXf4zL5fKjk72d39Nt19S/A9gjEDGEXAuzRX/cEl1zoAkRyMgo3Eq3zP6n/A1WH
         cT1hTQK6ZgbxS7pssGBuy1EMbrJ+pInGXHrsJHD4reannXA7KV9V+exJIDEFDnq9zSDH
         BHzeMColhip/3agPyMSat7kEZagZoxcOSnijFtdytiELZQlUGhHrvZVyFm9+xCTcAeO6
         7I+qmSzyjR+ue0DZyBApN/9+VWYh6seFK21KQCTxIw++FegDk6D04XhOktwmJqhpF1O/
         5qXYRTArtL/koTVvRYtDW95LTU4LpBiYxhvXo5nodTK6TbmQB95pQKNZqAECdc1bzzE9
         Zrmw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3: Kconfig: get rid of obsolete mode selection
References: <20190807155539.29369-1-jjhiblot@ti.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <574feca7-9ef9-904c-4b3e-12d96fcec6ad@baylibre.com>
Date: Thu, 8 Aug 2019 10:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190807155539.29369-1-jjhiblot@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jean-Jacques Hiblot <jjhiblot@ti.com>, marex@denx.de, kever.yang@rock-chips.com, lukma@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, sven@svenschwermer.de
List-ID: <u-boot-amlogic@groups.io>

On 07/08/2019 17:55, Jean-Jacques Hiblot wrote:
> The mode selection for the DWC3 is kind of obsolete. The driver does not
> have to be host only or gadget only. This choice is confusing.
> All the remaining callers of dwc3_uboot_init() explicitly set dr_mode
> before calling the function, so none rely on a default behavior.
> 
> Remove the choice menu and keep only the USB_DWC3_GADGET option. Enable it
> by default if USB_GADGET and USB_DWC3 are enabled.
> It must be disabled for the evb-rk3328 and odroid-n2 as it uses DWC2 for
> the gadget and DWC3 for the host.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> 
> ---
> 
> This patch applies on top of git://git.denx.de/u-boot-usb.git master
> 
> This patch was a part of a larger series. The changes since are:
> - Fix the test of the USB_DWC3_GADGET option. IS_ENABLED() requires the
>   whole option name including the 'CONFIG_' prefix
> - disable the CONFIG_USB_DWC3_GADGET option for the new odroid-n2 config
> 
> 
> configs/evb-rk3328_defconfig |  1 +
>  configs/odroid-n2_defconfig  |  1 +
>  drivers/usb/dwc3/Kconfig     | 18 ++----------------
>  drivers/usb/dwc3/core.c      |  4 ++--
>  4 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index fcc04f27ec..373ddf2f7f 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -63,6 +63,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x2207
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index 38d1549375..40b491e170 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -49,6 +49,7 @@ CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
>  CONFIG_USB_DWC3_MESON_G12A=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y

For odroid-n2_defconfig :

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 25e1a38aee..c302486291 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -7,25 +7,11 @@ config USB_DWC3
>  
>  if USB_DWC3
>  
> -choice
> -	bool "DWC3 Mode Selection"
> -
> -config USB_DWC3_HOST
> -	bool "Host only mode"
> -	depends on USB
> -	help
> -	  Select this when you want to use DWC3 in host mode only,
> -	  thereby the gadget feature will be regressed.
> -
>  config USB_DWC3_GADGET
> -	bool "Gadget only mode"
> +	bool "USB Gadget support for DWC3"
> +	default y
>  	depends on USB_GADGET
>  	select USB_GADGET_DUALSPEED
> -	help
> -	  Select this when you want to use DWC3 in gadget mode only,
> -	  thereby the host feature will be regressed.
> -
> -endchoice
>  
>  comment "Platform Glue Driver Support"
>  
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1baad39796..10b3f837f2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -707,9 +707,9 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
>  		return -ENOMEM;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
> +	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
>  		dwc->dr_mode = USB_DR_MODE_HOST;
> -	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
> +	else if (!IS_ENABLED(CONFIG_USB_HOST))
>  		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
>  
>  	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
> 

