Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.67841.1679561475105251333
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:51:15 -0700
Received: by mail-wm1-f42.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so626197wmq.4
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561473;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q0r2e+fFea9wwtstm7SkPOZ41kGt5l6iiNmJhtDerY=;
        b=eEHoSG6N4HNCRopOH3T8hlVYMMPf/Z6pfmyTzajuMAh4IILKx4lFFaBlOYXZIdjH6j
         xsHPc309xZiJiJK7SuMFFGjyq2P1wv8sgzXKB1csLA4SnCfC7vSfd48mO4wu90n2dSpV
         mD5sTT00wFtLtjSxVDgA4/p59YS98QN5KHAOeyn5QM50U2alncEXYgNPxtujWDMUVot+
         BNcyn9Im/HT5EqdYmZfeaEwajMWOLcAMBz5B9LL0Y/YB5/pJVrlubW+B/HQxN0THxnT+
         x3tmHbTSKfqCI2YBRBamrdhAojkdd0AAZEEHkbhhvcLFgThzL0LZAndSbdfaqqpRoq9V
         fH4g==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <88e79b01-8f2d-e1f5-12aa-cf628e622b76@linaro.org>
Date: Thu, 23 Mar 2023 09:51:13 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 06/13] boards: add BananaPi M2S defconfig
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <20230323065458.776029-7-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323065458.776029-7-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 07:54, Christian Hewitt wrote:
> Add configuration for the Bananapi BPI-M2S.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/bananapi-m2s_defconfig | 82 ++++++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>   create mode 100644 configs/bananapi-m2s_defconfig
> 
> diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
> new file mode 100644
> index 0000000000..3109e0ce48
> --- /dev/null
> +++ b/configs/bananapi-m2s_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-bananapi-m2s"
> +CONFIG_MESON_G12A=y
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" bpi-m2s"
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
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
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
> +CONFIG_MDIO_MUX_MESON_G12A=y
> +CONFIG_PCI=y
> +CONFIG_PCIE_DW_MESON=y
> +CONFIG_MESON_G12A_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
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
