Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.9349.1609230330489008052
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 00:25:30 -0800
Received: by mail-wr1-f52.google.com with SMTP id t16so13960100wra.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 00:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8QOb+GKr+/mqywBWtRFoRZlzFp0CfPHnm0TvvBrH28=;
        b=sRJUOh5ZSzUgeR/P2rECuNwzO5nmOxBgyk0LHPa22g4pn+7w2TzdK3lm8N6G5abpcb
         OYhdthHCJ0wHNkQ7S9qNbCHsmfxFkHEfISy6iUCE7WoP+XgbNTDmA/zF9MJWshZTN/Yj
         ICRoqkpRkUPz+YrQ+mxMuCLRUrVk7Ue6Gpgvh+1k4oFj0DVAbDqVPQ6uywuqgWjKg5Pp
         JNO0BFweGttBWE994iPpNFsigMCiXyYe2cPwrWreGEjzCEFPk3EComletZD8GhTg02Bg
         v1SCgUcZzB/0kH3l1m/gi5Nz+fb//BBMwzL3yp5YNO8nO1iPQd/pqM311b78N2QOyjB0
         Vm8w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: add MMC boot device detection for environment load
References: <CGME20201218142657eucas1p1834b72338d1cd92f59738e7e3e0c875d@eucas1p1.samsung.com>
 <20201218142645.5496-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4f5681a1-2c9f-4fe3-1c22-e2603d34fe51@baylibre.com>
Date: Tue, 29 Dec 2020 09:25:27 +0100
MIME-Version: 1.0
In-Reply-To: <20201218142645.5496-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 15:26, Marek Szyprowski wrote:
> Detect eMMC or SD card boot on Odroid-C4/N2 and Khadas VIM3(l) boards and
> report proper MMC device for the environment loading code. This allows to
> automatically load and store environment variables on the FAT partition
> or RAW offset of the MMC device without the need to use different
> configurations on eMMC and SD card.
> 
> To use this feature with environment stored on FAT partition, one has to
> specify an empty device part (i.e. ":1" for the first partition) in
> CONFIG_ENV_FAT_DEVICE_AND_PART to let the code to set the device to the
> value returned by mmc_get_env_dev() function.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  board/amlogic/odroid-n2/odroid-n2.c | 8 ++++++++
>  board/amlogic/vim3/vim3.c           | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index caf7fd6810..12ee5d3abc 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -10,6 +10,7 @@
>  #include <init.h>
>  #include <net.h>
>  #include <asm/io.h>
> +#include <asm/arch/boot.h>
>  #include <asm/arch/sm.h>
>  #include <asm/arch/eth.h>
>  
> @@ -17,6 +18,13 @@
>  #define EFUSE_MAC_SIZE		12
>  #define MAC_ADDR_LEN		6
>  
> +int mmc_get_env_dev(void)
> +{
> +	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
> +		return 1;
> +	return 0;
> +}
> +
>  int misc_init_r(void)
>  {
>  	u8 mac_addr[MAC_ADDR_LEN];
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 09ef39ff30..f9049e0172 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -10,10 +10,18 @@
>  #include <init.h>
>  #include <net.h>
>  #include <asm/io.h>
> +#include <asm/arch/boot.h>
>  #include <asm/arch/eth.h>
>  #include <i2c.h>
>  #include "khadas-mcu.h"
>  
> +int mmc_get_env_dev(void)
> +{
> +	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
> +		return 2;
> +	return 1;
> +}
> +
>  /*
>   * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>   * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> 

Thanks,
I would have hoped to have something more generic... but for now it's ok !

Applying to u-boot-amlogic-next

Neil
