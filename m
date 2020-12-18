Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.7703.1608284622330843616
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:43:42 -0800
Received: by mail-wr1-f47.google.com with SMTP id w5so1405855wrm.11
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riXNhwu6QVUbvAIBHSYPEHu4XiopFfLuVH7acrDam/I=;
        b=RUvlccjfRgnIuajclJR08gYlt8t2m8T5iLeIcpf5HJ6asyk/RBHK6CVvkhfwxAJerz
         e+CPBe/N2iTsqZTP7P46xltksVlzfinS48UYsdB2XwoDlJzFszqwapawhb5+5R2EqhC5
         UuPkvx7tFtRbKFikouyJ/i/+n+XMmYmXiukRFukQCYl54zSTLGoouyFmY/Z+RQnbicRB
         Ks6XRi3B6MO15s7Sc10OT0hxeyajOj8NCBuIdICiTW5xdccZO/6boPXmMr6pgGJuKDBP
         Oq02jCvDL4UB4rBDyLnILbPDULRjaLZNo0TxBfoSH+JII+9+GnOc+J3e7pyTjHd9FgXV
         lzmw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/5] boards: amlogic: add Beelink GT-King Pro defconfig
References: <20201218084545.29135-1-christianshewitt@gmail.com>
 <20201218084545.29135-5-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <732fdedf-269c-6574-4b80-49a2f432fb4c@baylibre.com>
Date: Fri, 18 Dec 2020 10:43:39 +0100
MIME-Version: 1.0
In-Reply-To: <20201218084545.29135-5-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 09:45, Christian Hewitt wrote:
> Add a defconfig for the Beelink GT-King Pro Android STB, which is based
> on the Amlogic W400 reference design.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  configs/beelink-gtkingpro_defconfig | 71 +++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 configs/beelink-gtkingpro_defconfig
> 
> diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
> new file mode 100644
> index 0000000000..569031600a
> --- /dev/null
> +++ b/configs/beelink-gtkingpro_defconfig
> @@ -0,0 +1,71 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="beelink-s922x"
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_MESON_G12A=y
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" beelink"
> +CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking-pro"
> +CONFIG_DEBUG_UART=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_MESON_G12A_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_DM_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
