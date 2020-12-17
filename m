Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by mx.groups.io with SMTP id smtpd.web08.11198.1608223085680912458
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Dec 2020 08:38:06 -0800
Date: Thu, 17 Dec 2020 17:38:02 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: <20201217090624.14902-1-m.szyprowski@samsung.com> (message from
	Marek Szyprowski on Thu, 17 Dec 2020 10:06:24 +0100)
Subject: Re: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com> <20201217090624.14902-1-m.szyprowski@samsung.com>
Message-ID: <42689b5a1ca64ebc@bloch.sibelius.xs4all.nl>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, narmstrong@baylibre.com, jh80.chung@samsung.com, b.zolnierkie@samsung.com
List-ID: <u-boot-amlogic@groups.io>

> From: Marek Szyprowski <m.szyprowski@samsung.com>
> Date: Thu, 17 Dec 2020 10:06:24 +0100
> 
> For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
> pin to the input (high impedance?) mode, otherwise the board is stuck
> in the middle of loading early stages of the bootloader from SD card.
> 
> This has been achieved by hijacking reset_misc() callback from the PSCI
> firmware in the Odroid board code. The common meson cpu_reset() function,
> which is called later during the reboot procedure, will call PSCI reboot
> anyway.
> 
> This issue doesn't happen if board is booted from eMMC.

This diff fixes the same issue on my Odroid HC4 board as well.  That
board is similar enough to the Odroid C4 that using
odroid-c4_defconfig works.  I'm using a patched FDT from Armbian

  https://github.com/armbian/build/blob/master/patch/kernel/meson64-current/0071-ODROID-HC4-Introduce-new-SBC-board-ODROID-HC4.patch

which keeps the "hardkernel,odroid-c4" compatible, so that aspect of
the diff seems to be allright.

Ideally this issue would be fixed in the PSCI implementation such that
rebooting after the OS has been loaded would work as well.  But that
isn't possible since there is no Open Source TF-A implementation for
these boards.

Tested-by: Mark Kettenis <kettenis@openbsd.org>


> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  board/amlogic/odroid-n2/odroid-n2.c | 15 +++++++++++++++
>  configs/odroid-c4_defconfig         |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index caf7fd6810..ad91de7ac5 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -10,6 +10,7 @@
>  #include <init.h>
>  #include <net.h>
>  #include <asm/io.h>
> +#include <asm/gpio.h>
>  #include <asm/arch/sm.h>
>  #include <asm/arch/eth.h>
>  
> @@ -47,3 +48,17 @@ int misc_init_r(void)
>  
>  	return 0;
>  }
> +
> +#ifndef CONFIG_PSCI_RESET
> +void reset_misc(void)
> +{
> +	if (of_machine_is_compatible("hardkernel,odroid-c4")) {
> +		unsigned int gpio;
> +		const char *str_gpio = "aobus-banks3";
> +
> +		gpio_lookup_name(str_gpio, NULL, NULL, &gpio);
> +		gpio_request(gpio, "reboot");
> +		gpio_direction_input(gpio);
> +	}
> +}
> +#endif
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index 367d22db0b..ca0ab71a7a 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
> +# CONFIG_PSCI_RESET is not set
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=y
> -- 
> 2.17.1
> 
> 
