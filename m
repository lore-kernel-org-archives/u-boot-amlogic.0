Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.7531.1608284597843559014
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:43:18 -0800
Received: by mail-wr1-f45.google.com with SMTP id c5so1421706wrp.6
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2V0uvA2Me6clbSCxZe+QhqsS8fgAVc2vdXn1jw+AS8=;
        b=dSh0uen8QghZ1IiL5ExHRXNPS6wKeUw1L3kuP+z9s6nvlr2KJtM7Qjq4BJ1IIomO0p
         xqfc32Z4AOW483UU821jYguFxFjxrRiGXCz2wzcZwzPk4EYp5fH7ttBtFxUXZ0BAN0UW
         WUlJfc/6dU7dD4sUg0uga6rrqDhiCVRFgmcmKgvsfqvZBk2iKcelDejfirfDItEp1Fdw
         t/lecS3xA4jiiHAN5052rAxdbrcaKD+R2fHvCl1e5NBNBJflkOMQADr8Pxu3bcmpxMJP
         yntpNve6mrbp3l9PDOLT0UQKOpWqyq12r4Yxm89u5jHX8XXxv4Wk7fErnSVH8ZFXn3yC
         rpww==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/5] boards: amlogic: add Beelink GT-King defconfig
References: <20201218084545.29135-1-christianshewitt@gmail.com>
 <20201218084545.29135-4-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <97d23c04-92d9-958a-167e-f90c76317617@baylibre.com>
Date: Fri, 18 Dec 2020 10:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <20201218084545.29135-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 09:45, Christian Hewitt wrote:
> Add a defconfig for the Beelink GT-King Android STB, which is based
> on the Amlogic W400 reference design.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  configs/beelink-gtking_defconfig | 71 ++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 configs/beelink-gtking_defconfig
> 
> diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
> new file mode 100644
> index 0000000000..ea428874af
> --- /dev/null
> +++ b/configs/beelink-gtking_defconfig
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
> +CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking"
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
