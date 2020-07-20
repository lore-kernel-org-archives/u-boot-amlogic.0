Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.33730.1595231765384820469
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Jul 2020 00:56:08 -0700
Received: by mail-wr1-f66.google.com with SMTP id a6so16815306wrm.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Jul 2020 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwisqeoXtTFmdsK5j/t4UMslAJZkR0Tf2v9gDKhKlGM=;
        b=oCAsjVl93q8ew9SD/Ww6pA+9pJoxzMquWHAg8Vpfee2K3Zo1QAKLpGWAKFX7rCr9rW
         GtGS+5QL2I2Lmzknxj391NEnoNjgNwwl68qG6DkNjadE518u09PxTHpYTzgJD9A6e4vj
         UnN2nDcWlKptps24s5wzEuTqlH0OIu/gCXS/S1sMyU4pKKrEfbicrQtXEoXjHpYh+CGS
         7lMTzz345UjMDrxOODEG0owGFo4lT+d4Yr+/Fs1KgXPdEm/rjmWdmS5j9WUe9V3krig0
         Cl6xLS4Vtur1qsPP8eu2Vw/9knkNxJjRFQGYGDKbMkWVlWyl8KuB4YW98AFciUT63cOd
         OVqw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 1/2] arm: move CONFIG_PREBOOT="usb start" to KConfig
References: <20200719135632.681954-1-dr@jones.dk>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <404928c1-4da3-d3c1-c0fd-133ce7f7c6dc@baylibre.com>
Date: Mon, 20 Jul 2020 09:56:01 +0200
MIME-Version: 1.0
In-Reply-To: <20200719135632.681954-1-dr@jones.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jonas Smedegaard <dr@jones.dk>, u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Hannes Schmelzer <hannes.schmelzer@br-automation.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jagan Teki <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>, Matthias Brugger <mbrugger@suse.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Ovidiu Panait <ovidiu.panait@windriver.com>, Peter Robinson <pbrobinson@gmail.com>, Ruslan Trofymenko <ruslan.trofymenko@linaro.org>, Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>, Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 19/07/2020 15:56, Jonas Smedegaard wrote:
> This commit moves CONFIG_PREBOOT="usb start" to common/KConfig
> for all boards also declaring USB_KEYBOARD.
> 
> Besides simplifying defconfig files, this also enables support for
> board-specific CONFIG_PREBOOT for sunxi boards:
> commit 37304aaf60bf ("Convert CONFIG_USE_PREBOOT and CONFIG_PREBOOT to
> Kconfig") intended to support CONFIG_PREBOOT, but
> include/configs/sunxi-common.h hardcodes preboot as part of internally
> defined CONSOLE_STDIN_SETTINGS, silently ignoring any board-specific
> CONFIG_PREBOOT.
> 
> Signed-off-by: Jonas Smedegaard <dr@jones.dk>
> Series-Cc: Jagan Teki <jagan@amarulasolutions.com>
> Series-Cc: Lukasz Majewski <lukma@denx.de>
> Series-Cc: Andre Przywara <andre.przywara@arm.com>
> 
> ---
> 
> (no changes since v1)
> 
> 
> Changes in v4:
> - generalize to cover all boards, thanks to Jagan Teki
> 
> Changes in v3:
> - move default setting to KConfig, thanks to Andre Przywara and Lukasz Majewski
> 
> Changes in v2:
> - Rephrase commit message to clarify relationship with KConfig entries
> 
> ---
>  common/Kconfig                        | 1 +
>  configs/libretech-ac_defconfig        | 1 -
>  configs/libretech-s905d-pc_defconfig  | 1 -
>  configs/libretech-s912-pc_defconfig   | 1 -
>  configs/pinebook-pro-rk3399_defconfig | 1 -
>  configs/rockpro64-rk3399_defconfig    | 1 -
>  configs/rpi_0_w_defconfig             | 1 -
>  configs/rpi_2_defconfig               | 1 -
>  configs/rpi_3_32b_defconfig           | 1 -
>  configs/rpi_3_b_plus_defconfig        | 1 -
>  configs/rpi_3_defconfig               | 1 -
>  configs/rpi_defconfig                 | 1 -
>  configs/seaboard_defconfig            | 1 -
>  configs/ventana_defconfig             | 1 -
>  include/configs/sunxi-common.h        | 1 -
>  15 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 67b3818fde..62d78c5bd7 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -403,6 +403,7 @@ config BOOTCOMMAND
>  
>  config USE_PREBOOT
>  	bool "Enable preboot"
> +	default "usb start" if USB_KEYBOARD
>  	help
>  	  When this option is enabled, the existence of the environment
>  	  variable "preboot" will be checked immediately before starting the
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index d3fc9cb25d..3fb7f36193 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -14,7 +14,6 @@ CONFIG_IDENT_STRING=" libretech-ac"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_USE_PREBOOT=y
> -CONFIG_PREBOOT="usb start"
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
> index 67e52925db..18192ece34 100644
> --- a/configs/libretech-s905d-pc_defconfig
> +++ b/configs/libretech-s905d-pc_defconfig
> @@ -14,7 +14,6 @@ CONFIG_IDENT_STRING=" libretech-s905d-pc"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_USE_PREBOOT=y
> -CONFIG_PREBOOT="usb start"
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_CMD_BDI is not set
> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
> index 50138aa3ac..6b2c949823 100644
> --- a/configs/libretech-s912-pc_defconfig
> +++ b/configs/libretech-s912-pc_defconfig
> @@ -13,7 +13,6 @@ CONFIG_IDENT_STRING=" libretech-s912-pc"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_USE_PREBOOT=y
> -CONFIG_PREBOOT="usb start"
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_CMD_BDI is not set

For Amlogic libretech amlogic boards.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
