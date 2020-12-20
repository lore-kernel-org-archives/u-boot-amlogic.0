Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web11.30605.1608502705929634693
 for <u-boot-amlogic@groups.io>;
 Sun, 20 Dec 2020 14:18:26 -0800
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201220221822epoutp0136e4dd2b05b418d6138dcfe1ba71a681~SjK_mcSjo2851928519epoutp01w
	for <u-boot-amlogic@groups.io>; Sun, 20 Dec 2020 22:18:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201220221822epoutp0136e4dd2b05b418d6138dcfe1ba71a681~SjK_mcSjo2851928519epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608502703;
	bh=KxyyR13kfcq3UKy6YeCplUZIB1IcTXsYgkz3D/x7vGM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=E3nUxhIEQdh1OF9xGhX23xiiEITAwxvLRN3/QDFf5fWxp04VcNF0Pzofo8FDP+qz7
	 K3el7fpVyLGn+MRA7JzR0uxDSam8zLeirtVxLrBHTafb/lvUVsZOwh7Ge54faCFdSI
	 dDq8HRwtPuUGy9I1DHYbn/Esv0ZKyd7DJ5EQVMvU=
Subject: Re: [PATCH] board: amlogic: add MMC boot device detection for environment load
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <0367a080-ffbd-ad90-3623-0ea2751e81aa@samsung.com>
Date: Mon, 21 Dec 2020 07:18:43 +0900
MIME-Version: 1.0
In-Reply-To: <20201218142645.5496-1-m.szyprowski@samsung.com>
References: <CGME20201218142657eucas1p1834b72338d1cd92f59738e7e3e0c875d@eucas1p1.samsung.com>
	<20201218142645.5496-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/18/20 11:26 PM, Marek Szyprowski wrote:
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

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

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

