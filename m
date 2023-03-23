Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.67460.1679561441196618475
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:50:41 -0700
Received: by mail-wm1-f53.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so582240wmq.3
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561439;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lcUcj/Qnxaayk6nRS9LP740lBkBNHZkS3q6ybfWHtbA=;
        b=gPYaWjv4k3NDQLzb139R9WV6HFE+oOUQLSoDfR0cNlSY9DcUgPwL7eYqfD/L2vUKUy
         SsVuQJQLtMWRy8IHykLwX83HTcatnLXA1xaiV+xDN/xwCWs3APYz5A3XQZxdCfgSK2rP
         QdbootX9BlxKNrEcB59ZlbZpQZgXQDScNLippXyUY8X3vKKX6z0sKpo22ILMAPZXDEUB
         MEmE2dxzAlLsrWvIi3Ne1Fi9sxK2yxbIvAdjG4g8vzGmEHEJ/WZ6Z83luuc++ykyuzlS
         TvfGMDxl/cuQDiSI418Qp/8TX+uGSEQDp1C71uTDl/OuisZVBMuYSfzQSeqp/jy8DFwK
         kl/g==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <fbb47878-dd7c-bbc4-ef09-16aab3471538@linaro.org>
Date: Thu, 23 Mar 2023 09:50:39 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/13] boards: add BananaPi M2-Pro defconfig
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <20230323065458.776029-4-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323065458.776029-4-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 07:54, Christian Hewitt wrote:
> Add configuration for the BananaPi M2-Pro board.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/bananapi-m2-pro_defconfig | 76 +++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>   create mode 100644 configs/bananapi-m2-pro_defconfig
> 
> diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
> new file mode 100644
> index 0000000000..28b603fe20
> --- /dev/null
> +++ b/configs/bananapi-m2-pro_defconfig
> @@ -0,0 +1,76 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m2-pro"
> +CONFIG_MESON_G12A=y
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING="bpi-m2-pro"
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
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
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
