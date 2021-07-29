Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.7192.1627550619556205880
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:23:39 -0700
Received: by mail-wr1-f52.google.com with SMTP id n12so6070934wrr.2
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrwILQRIwT6qavYUdvWJ3f/OQY0XTwD9IoSexieFgco=;
        b=FA/aj+j9N6P+0wPBj7IFCH/4H5QXdQeX8KrgIvbLKepz618X2xnjI5bAa5unbFhgBI
         H4sU+netuBxkydUsbggTEPRWfK3kq96mJk/N+i1t2Se9S1CR273j/Rsb62sfiGIZTdyi
         hqKcZn5L4M74O4hCIwHbi93jRPrhtxmmg67B43Uv9ShbyxmDOGNGDcnlJPI9DymHEy35
         OwSc7aYwspdbYaWEGGA+m3JO4T4LLF8MHM61ePPuX2guQlu2lxSsXFnALGNtiIJrlmpS
         wy471F6DVznCUeLkD5DzlQXTGk0GFwpgKeT/sROEfSUhDbYp8qoM+kAr2E/vG/Gc1ntB
         jYDQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 6/6] configs: meson64_android: don't set console bootargs
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-7-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <59050a6f-8a97-4c14-05cc-e22fbe71c1da@baylibre.com>
Date: Thu, 29 Jul 2021 11:23:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-7-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> The console bootargs are already set from the kernel commandline.
> On Android, this is done in yukawa at [1]
> 
> Don't set it in the bootloader since it's overridden by the kernel anyways.
> 
> [1] https://android-review.googlesource.com/c/device/amlogic/yukawa/+/1112994
> Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 56545a72f8..3b61d5f703 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -86,7 +86,7 @@
>  	"bootcmd_system=" \
>  		"echo Loading Android " BOOT_PARTITION " partition...;" \
>  		"mmc dev ${mmcdev};" \
> -		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
> +		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
>  		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
>  		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> @@ -121,8 +121,6 @@
>  	"gpio_recovery=88\0"                                          \
>  	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
>  	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
> -	"console=/dev/ttyAML0\0"                                      \
> -	"bootargs=no_console_suspend\0"                               \
>  	"stdin=" STDIN_CFG "\0"                                       \
>  	"stdout=" STDOUT_CFG "\0"                                     \
>  	"stderr=" STDOUT_CFG "\0"                                     \
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
