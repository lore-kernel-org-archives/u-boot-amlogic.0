Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.75365.1679583732354574876
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 08:02:12 -0700
Received: by mail-wm1-f46.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1402518wms.1
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679583731;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C4A6Nr9KkQBOWVUJyqV9UJbQdXq4Pz/FbNPkIJmT0Ao=;
        b=cmwHalRhBME2w5J4WJJOfz0pcRO/0miKACZlZtbILeKOTr3z931anTCW5q2K13KfJL
         HqdlyXaDZ8G32Z07IHiyNdXRVMSAxqObZRQQuqv7H4J9YYxcP/GMX9BalmJt0q9qsMfd
         GkdLuvEuBD3TXXgFSACBJzhW4AdwcZ61lQHyad/6K48tZQn8+OOjh42BAwdSvtduf3pu
         VJbM/7G6/57+tqVGjmZ9GOZ2guTtjA08rMhvSQs09D6ttOUMBoK1Ie/DmIhrx9B0AAT+
         9leY28dTIUDtGlnOSSNXyGXvE1qnmmvSt8H0tqJ3Ae4T11F4iSH6rSUstj5zHzvKSTOZ
         7Z6Q==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <6ef3b7a4-c740-77f8-dfe5-77906a172cc2@linaro.org>
Date: Thu, 23 Mar 2023 16:02:09 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 13/14] boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
References: <20230323143142.780306-1-christianshewitt@gmail.com>
 <20230323143142.780306-14-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323143142.780306-14-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 15:31, Christian Hewitt wrote:
> Add configurations for the WeTek Hub and WeTek Play2 boards.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/p200/MAINTAINERS |  2 +
>   configs/wetek-hub_defconfig    | 70 ++++++++++++++++++++++++++++++++++
>   configs/wetek-play2_defconfig  | 70 ++++++++++++++++++++++++++++++++++
>   3 files changed, 142 insertions(+)
>   create mode 100644 configs/wetek-hub_defconfig
>   create mode 100644 configs/wetek-play2_defconfig
> 
> diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
> index 33ca3df5c6..264218e3be 100644
> --- a/board/amlogic/p200/MAINTAINERS
> +++ b/board/amlogic/p200/MAINTAINERS
> @@ -7,6 +7,8 @@ F:	board/amlogic/p200/
>   F:	configs/nanopi-k2_defconfig
>   F:	configs/odroid-c2_defconfig
>   F:	configs/p200_defconfig
> +F:	configs/wetek-hub_defconfig
> +F:	configs/wetek-play2_defconfig
>   F:	doc/board/amlogic/p200.rst
>   F:	doc/board/amlogic/nanopi-k2.rst
>   F:	doc/board/amlogic/odroid-c2.rst
> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> new file mode 100644
> index 0000000000..634833f7fe
> --- /dev/null
> +++ b/configs/wetek-hub_defconfig
> @@ -0,0 +1,70 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" wetek-hub"
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
> +CONFIG_DEBUG_UART=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> +CONFIG_OF_BOARD_SETUP=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
> +CONFIG_PHY=y
> +CONFIG_MESON_GXBB_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXBB=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_DWC2=y
> +CONFIG_USB_KEYBOARD=y
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
> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> new file mode 100644
> index 0000000000..6d33b09a94
> --- /dev/null
> +++ b/configs/wetek-play2_defconfig
> @@ -0,0 +1,70 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" wetek-play2"
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
> +CONFIG_DEBUG_UART=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> +CONFIG_OF_BOARD_SETUP=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
> +CONFIG_PHY=y
> +CONFIG_MESON_GXBB_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXBB=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_DWC2=y
> +CONFIG_USB_KEYBOARD=y
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
