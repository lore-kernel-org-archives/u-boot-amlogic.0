Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.67841.1679561475105251333
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:51:32 -0700
Received: by mail-wm1-f42.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so626655wmq.4
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561492;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L0I7QvM6A80rykBCgEPu2ZMacQmX66lChRyCs0/spqA=;
        b=eeLer/7qGHFgO9ckKbP6uoDrW1L/+Vnxr/GnwuP+ZgN7eElsqUrbX0GbSsQvYLmDKq
         aZUnFNxUuTa+3fbs4E2KvbL0JnU4+5zbQSAHlt4aCOi+gtqxOya8kGXK2zckaR8/Cmwc
         EFaTp80E/ao4isphLC6UQHv7x8Wz2bgJVyKeVy0SvrJJ5kNxJqzojkO2uXCQqQYaSvfg
         gewgzWZFWuxK1MZRbbbclgBG7r50dGL6Bg2tQZQ9eCidH1LRu5dwY4ezx4BRXyUt4Vci
         K3vzBVbo7Bi2f8c0YUlMHWRchq52K3wkDCVcuwa7XywYGnvQuIK5UNA4fOjRlbMMAVWw
         KyOQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <6e069d1f-9382-a708-9c47-ab7563a20a19@linaro.org>
Date: Thu, 23 Mar 2023 09:51:31 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 09/13] boards: amlogic: add Radxa Zero2 defconfig
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <20230323065458.776029-10-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323065458.776029-10-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 07:54, Christian Hewitt wrote:
> Add board configuration for the Radxa Zero2.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/radxa-zero2_defconfig | 77 +++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
>   create mode 100644 configs/radxa-zero2_defconfig
> 
> diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
> new file mode 100644
> index 0000000000..2218b0db7d
> --- /dev/null
> +++ b/configs/radxa-zero2_defconfig
> @@ -0,0 +1,77 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-radxa-zero2"
> +CONFIG_MESON_G12A=y
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" radxa-zero2"
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_OF_BOARD_SETUP=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=y
> +CONFIG_SYS_MAXARGS=32
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +# CONFIG_PHY_REALTEK is not set
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_MDIO_MUX=y
> +# CONFIG_ETH_DESIGNWARE_MESON8B is not set
> +CONFIG_MDIO_MUX_MESON_G12A=y
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
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_VIDEO_BMP_RLE8=y
> +CONFIG_BMP_16BPP=y
> +CONFIG_BMP_24BPP=y
> +CONFIG_BMP_32BPP=y
> +CONFIG_OF_LIBFDT_OVERLAY=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
