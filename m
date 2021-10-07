Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web12.8614.1633594258860881694
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 01:10:59 -0700
Received: by mail-wr1-f44.google.com with SMTP id t8so16485384wri.1
        for <u-boot-amlogic@groups.io>; Thu, 07 Oct 2021 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9vAaZtnczGdZkoKdBhrjOVGYuAAiZH9+YwBdA5fu/I=;
        b=6N7C94ag6skSEQDr7IrJ5dR1YEwRW8i7vD3QCxO5FjI1uWiqMLnoo6B3fg66s2H6Hk
         imhTOqOGIhH4ZIZj+z5W9EBcLEd3luDtPHP1I0u/W8FhKlE8rsH+yHblCwuBMTZTOylO
         7FoCtoO0Xe6UhCHofdDmg3oDlw9PhuClzJoxyT1ugxRSklocidiMTFRS48NyGslHi73a
         dKxcEfrox9z9cP7Zz0rgDGG20jWZFhGJjiboUcTim/VGGuR64t0AF2a/iiJ87IhxLbOF
         GXum6nvgI3e0etXXTXTXLQ/+0k1PGibNrh57w5mmc8VFsVeqBLek88+3h13x9nCGSxN4
         +JIQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] ARM: amlogic: update JetHub D1/H1 configs (was: add SYS_LOAD_ADDR to JetHub D1/H1 configs)
References: <20211006151148.1240465-1-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <60afb5d7-0004-9d10-bfb4-4ed694b5b9dc@baylibre.com>
Date: Thu, 7 Oct 2021 10:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20211006151148.1240465-1-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/10/2021 17:11, Vyacheslav Bocharov wrote:
> - late fix for 49c8ef0e45a91ec894ef15e7d043dafe8f1c5efd commit by Tom Rini.
> - enable i2c, rtc, eeprom

thanks, I'll squash it on the previous patch on my u-boot-amlogic-next tree.

Neil

> 
> Changes:
> - add i2c, rtc, eeprom
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  configs/jethub_j100_defconfig | 8 ++++++++
>  configs/jethub_j80_defconfig  | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
> index 290ce4db85..533f251855 100644
> --- a/configs/jethub_j100_defconfig
> +++ b/configs/jethub_j100_defconfig
> @@ -11,21 +11,27 @@ CONFIG_DEBUG_UART_BASE=0xff803000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_IDENT_STRING=" jethubj100"
>  CONFIG_DEBUG_UART=y
> +CONFIG_SYS_LOAD_ADDR=0x01000000
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
> +CONFIG_CMD_EEPROM=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_RANDOM_UUID=y
> +CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_RTC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_PARTITION_TYPE_GUID=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD_UBI=y
>  CONFIG_PHY_REALTEK=y
> @@ -37,6 +43,8 @@ CONFIG_PINCTRL_MESON_AXG=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_RESET=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_PCF8563=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
> index 7db05af3b0..ad6bec0c43 100644
> --- a/configs/jethub_j80_defconfig
> +++ b/configs/jethub_j80_defconfig
> @@ -12,25 +12,31 @@ CONFIG_DEBUG_UART_BASE=0xc81004c0
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_IDENT_STRING=" jethubj80"
>  CONFIG_DEBUG_UART=y
> +CONFIG_SYS_LOAD_ADDR=0x01000000
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
> +CONFIG_CMD_EEPROM=y
>  CONFIG_CMD_ADC=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_RANDOM_UUID=y
> +CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_RTC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_PARTITION_TYPE_GUID=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SARADC_MESON=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD_UBI=y
>  CONFIG_PHY_MESON_GXL=y
> @@ -45,6 +51,8 @@ CONFIG_PINCTRL_MESON_GXL=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_RESET=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_PCF8563=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> 

