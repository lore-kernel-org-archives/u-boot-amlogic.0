Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.7218.1608280597532730904
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 00:36:38 -0800
Received: by mail-wm1-f41.google.com with SMTP id c133so1491946wme.4
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IciUGLfdRIzjhJsGsaMQeweoBPpfwMRtItys+PpjwZk=;
        b=a2I37JIzOsd6Vj/NHuAwzGA87xdwES27eAA6Tqx4PHbjIIfwjFsmfu4XzfuI6+AluE
         UkZBaIyuAH7nH7A/350ue/tGm2FmSxjS2C9kUiA253IqUiFJu38KToisaGKClERTsSuU
         yo4gr+ENawaRzl7SZmhmhwXJOR3/L5JcsvtBZj1zXqO4NVH5Z/4Ju4qn1Adq5Um68W+F
         toU5L2nf6/bbvhhzbVNfNim6MH9IBYM4oTL5qbXay/vm7usMPFZaHX9xdXNlKPF1M8UH
         S93jB5JUHHTcxYgnh/AdlHw+SOMMtyI8k59siamvXQPj4gmtz8rKdrRPB0zyd0tW5n9N
         naRw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com>
 <20201217090624.14902-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0c53e06e-afa4-2308-7d5d-ba08b1d0caf3@baylibre.com>
Date: Fri, 18 Dec 2020 09:36:34 +0100
MIME-Version: 1.0
In-Reply-To: <20201217090624.14902-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dongjin Kim <tobetter@hardkernel.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 17/12/2020 10:06, Marek Szyprowski wrote:
> For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
> pin to the input (high impedance?) mode, otherwise the board is stuck
> in the middle of loading early stages of the bootloader from SD card.

Did you try taking the regulator-tflash_vdd and doing a disable/enable sequence
to reset the card ?

The GPIOAO_3 has a default pull-up, so I don't see why moving it to input could change
anything.

So maybe simply doing a 0->1 transition could do the same, using the regulator
would be much better.

Can't we add "shutdown" or equivalent method to  the mmc driver that could do this
directly with the vdd regulator ?

@tobetter, could you provide us a summary of how to fix the reboot issues on the
N2, N2+, C4 and HC4 ?

Thanks,
Neil

> 
> This has been achieved by hijacking reset_misc() callback from the PSCI
> firmware in the Odroid board code. The common meson cpu_reset() function,
> which is called later during the reboot procedure, will call PSCI reboot
> anyway.
> 
> This issue doesn't happen if board is booted from eMMC.
> 
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
> 

