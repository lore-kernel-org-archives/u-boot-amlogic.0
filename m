Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.21221.1683269730000435506
 for <u-boot-amlogic@groups.io>;
 Thu, 04 May 2023 23:55:30 -0700
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f19323259dso13885985e9.3
        for <u-boot-amlogic@groups.io>; Thu, 04 May 2023 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269728; x=1685861728;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MH19cT91Eg94D4oglQ2416xls3VAPL5AOxBO3/T2I0c=;
        b=axo1bNP7dc2gm4Yc7M5o4ClP+6mO3WJOiFHc2/BqXK5WkHqT2XjnETgklmkl68iiP7
         9tW5jbdQMM82fLTPJSj/30rjJ9J68PaD7sg2YuQC2xd3lV1ODitxlyzCvI67/h6qzxg+
         Rek1iiqRbCXYjmb0kIJD7TwB2p4CaCzKqb0KHCEkZqI7f5CwcYy+jPbr8SRyBryZ35Wb
         /lZsevvgxw/UtMEEOlptcZVvnZd8VBlimZSQT1Yq/KnZUirbwk2fJhyJonXPyYaOOxQs
         m/m91osSYO4hvnHYux5CEvGvoWs7LmfpOWKtpXpvJDkMXHgKCdbPEjO3hXEcb1CW3vHM
         JnuQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <752bcedf-5792-7c43-0573-7fd4d81b54fc@linaro.org>
Date: Fri, 5 May 2023 08:55:27 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1 5/5] board: amlogic: add support for AD401 board
References: <20230424180151.9524-1-ivprusov@sberdevices.ru>
 <20230424180151.9524-6-ivprusov@sberdevices.ru>
In-Reply-To: <20230424180151.9524-6-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@sberdevices.ru>
Cc: kernel@sberdevices.ru, prusovigor@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2023 20:01, Igor Prusov wrote:
> The AD401 board is the Amlogic A1 SoC reference board
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   MAINTAINERS                  |  1 +
>   arch/arm/mach-meson/Kconfig  |  1 +
>   board/amlogic/ad401/Makefile |  4 +++
>   board/amlogic/ad401/ad401.c  | 15 ++++++++++
>   configs/ad401_defconfig      | 54 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 75 insertions(+)
>   create mode 100644 board/amlogic/ad401/Makefile
>   create mode 100644 board/amlogic/ad401/ad401.c
>   create mode 100644 configs/ad401_defconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02a5a8682f..6860309896 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -150,6 +150,7 @@ L:	u-boot-amlogic@groups.io
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
>   F:	arch/arm/mach-meson/
>   F:	arch/arm/include/asm/arch-meson/
> +F:	board/amlogic/

Boards MAINTAINERS are separate, so please add a separate MAINTAINERS
file in board/amlogic/ad401/, you can add me ad maintainer like other
boards.

>   F:	cmd/meson/
>   F:	drivers/clk/meson/
>   F:	drivers/serial/serial_meson.c
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 519ed563c0..669ca09a00 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -75,6 +75,7 @@ config SYS_VENDOR
>   
>   config SYS_BOARD
>   	string "Board name"
> +	default "ad401" if MESON_A1
>   	default "p200" if MESON_GXBB
>   	default "p212" if MESON_GXL
>   	default "q200" if MESON_GXM
> diff --git a/board/amlogic/ad401/Makefile b/board/amlogic/ad401/Makefile
> new file mode 100644
> index 0000000000..e65c1215f6
> --- /dev/null
> +++ b/board/amlogic/ad401/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# (C) Copyright 2023 SberDevices, Inc.
> +
> +obj-y	:= ad401.o
> diff --git a/board/amlogic/ad401/ad401.c b/board/amlogic/ad401/ad401.c
> new file mode 100644
> index 0000000000..356b2880bd
> --- /dev/null
> +++ b/board/amlogic/ad401/ad401.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 SberDevices, Inc.
> + * Author: Igor Prusov <ivprusov@sberdevices.ru>
> + */
> +
> +#include <init.h>
> +#include <asm/arch/eth.h>
> +
> +int misc_init_r(void)
> +{
> +	meson_generate_serial_ethaddr();
> +
> +	return 0;
> +}
> diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
> new file mode 100644
> index 0000000000..529e553bac
> --- /dev/null
> +++ b/configs/ad401_defconfig
> @@ -0,0 +1,54 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x00000000
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-a1-ad401"
> +CONFIG_SYS_PROMPT="ad401 # "
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_MESON_A1=y
> +CONFIG_DEBUG_UART_BASE=0xfe001c00
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0x0
> +CONFIG_DEBUG_UART=y
> +CONFIG_ANDROID_BOOT_IMAGE=y
> +CONFIG_FIT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_BOOTCOMMAND="run storeboot"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_CMD_UBI=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
> +CONFIG_LED=y
> +CONFIG_MISC=y
> +CONFIG_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_A1=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_PWM=y
> +CONFIG_PWM_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_WDT=y


With MAINTAINERS file in board dir:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

