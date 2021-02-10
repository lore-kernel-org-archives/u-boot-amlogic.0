Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.3015.1612947890109389476
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Feb 2021 01:04:50 -0800
Received: by mail-wm1-f48.google.com with SMTP id j21so1164229wmj.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Feb 2021 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gEUrxq33HpqdAt4M3cZxdp2BDOIvUR/YuoqY9K2X9h0=;
        b=sl61FVWSd/RwGnid4T9dETEFbNPeaLYIjuxDjLuIpV2G8JSI4Gg1Mut7XL3INT3iXG
         oI97NyB0JA/tMXftgZnEOrGcAM23mj2S8M4GFGLdKAkORqaCvJaQSmBldffq/C3r45mG
         m4LwGzZ9z83riMJDrGxgj9XU7gd7U3UvQaatlFe4TVYdx07pdaOY0gylaQB0V+FPIWCp
         wZ4ZrkwVTu5v/+SSncnzxbwfl9anzjnLDOod/63YNluYAhyaBkRuJ23MIqSBYs1Bi2LG
         N+G6EMrxKAVKglx4XX5zAOevPcWbdu8sOqXhRPWca+RKEazxrj5Nvs9E5agKz4F+p5qR
         TGFA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: odroid: add runtime detection of the N2/N2+/C4/HC4 variants
References: <CGME20210204091156eucas1p2c0ef39f48be756ff3c40dd7be3dac684@eucas1p2.samsung.com>
 <20210204091145.19201-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a070832a-0970-1451-8571-7b914a5ea7c7@baylibre.com>
Date: Wed, 10 Feb 2021 10:04:45 +0100
MIME-Version: 1.0
In-Reply-To: <20210204091145.19201-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 04/02/2021 10:11, Marek Szyprowski wrote:
> Use the ADC channel 1 to check the hardware revision of the board and
> detect the N2 vs. N2+ and the C4 vs. HC4 variants. Each of them use
> different dtb file, so adjust fdtfile environment variable to the
> detected variant.
> 
> The ADC min/max values for each variant are taken from the vendor code,
> adjusted to the 12-bit ADC driver operation mode (vendor code use 10-bit
> mode).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> The relevant vendor's code is here:
> https://github.com/hardkernel/u-boot/blob/odroidg12-v2015.01/board/hardkernel/odroid-common/board.c#L55
> ---
>  arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |  6 ++
>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |  6 ++
>  board/amlogic/odroid-n2/odroid-n2.c           | 80 +++++++++++++++++++
>  configs/odroid-c4_defconfig                   |  4 +-
>  configs/odroid-n2_defconfig                   |  4 +-
>  5 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
> index 236f2468dc..a92f9e9ff1 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
> @@ -5,3 +5,9 @@
>   */
>  
>  #include "meson-g12-common-u-boot.dtsi"
> +
> +/* SARADC is needed for proper board variant detection */
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddao_1v8>;
> +};
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> index fbcc8287c5..963bf96b25 100644
> --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> @@ -12,6 +12,12 @@
>  	snps,reset-active-low;
>  };
>  
> +/* SARADC is needed for proper board variant detection */
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddao_1v8>;
> +};
> +
>  &tflash_vdd {
>  	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
>  };
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index d9955433bf..2eb7fa93be 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -6,6 +6,7 @@
>  
>  #include <common.h>
>  #include <dm.h>
> +#include <adc.h>
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> @@ -19,6 +20,11 @@
>  #define EFUSE_MAC_SIZE		12
>  #define MAC_ADDR_LEN		6
>  
> +#define ODROID_HW_VS_ADC_CHANNEL	1
> +
> +#define MESON_SOC_ID_G12B	0x29
> +#define MESON_SOC_ID_SM1	0x2b
> +
>  int mmc_get_env_dev(void)
>  {
>  	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
> @@ -26,6 +32,79 @@ int mmc_get_env_dev(void)
>  	return 0;
>  }
>  
> +/* Variant detection is based on the ADC RAW values for the channel #1 */
> +static struct meson_odroid_boards {
> +	unsigned int soc_id;
> +	unsigned int adc_min;
> +	unsigned int adc_max;
> +	char *variant;
> +} boards[] = {
> +	/* OdroidN2 rev 2018,7,23 */
> +	{ MESON_SOC_ID_G12B, 80 * 4,  90 * 4, "n2" },
> +	/* OdroidN2 rev 2018,12,6 */
> +	{ MESON_SOC_ID_G12B, 160 * 4, 170 * 4, "n2" },
> +	/* OdroidN2 rev 2019,1,17 */
> +	{ MESON_SOC_ID_G12B, 245 * 4, 255 * 4, "n2" },
> +	/* OdroidN2 rev 2019,2,7 */
> +	{ MESON_SOC_ID_G12B, 330 * 4, 350 * 4, "n2" },
> +	/* OdroidN2plus rev 2019,11,20 */
> +	{ MESON_SOC_ID_G12B, 410 * 4, 430 * 4, "n2_plus" },
> +	/* OdroidC4 rev 2020,01,29 */
> +	{ MESON_SOC_ID_SM1,   80 * 4, 100 * 4, "c4" },
> +	/* OdroidHC4 rev 2019,12,10 */
> +	{ MESON_SOC_ID_SM1,  300 * 4, 320 * 4, "hc4" },
> +	/* OdroidC4 rev 2019,11,29 */
> +	{ MESON_SOC_ID_SM1,  335 * 4, 345 * 4, "c4" },
> +	/* OdroidHC4 rev 2020,8,7 */
> +	{ MESON_SOC_ID_SM1,  590 * 4, 610 * 4, "hc4" },
> +};
> +
> +static void odroid_set_fdtfile(char *soc, char *variant)
> +{
> +	char s[128];
> +
> +	snprintf(s, sizeof(s), "amlogic/meson-%s-odroid-%s.dtb", soc, variant);
> +	env_set("fdtfile", s);
> +}
> +
> +static int odroid_detect_variant(void)
> +{
> +	char *variant = "", *soc = "";
> +	unsigned int adcval = 0;
> +	int ret, i, soc_id = 0;
> +
> +	if (of_machine_is_compatible("amlogic,sm1")) {
> +		soc_id = MESON_SOC_ID_SM1;
> +		soc = "sm1";
> +	} else if (of_machine_is_compatible("amlogic,g12b")) {
> +		soc_id = MESON_SOC_ID_G12B;
> +		soc = "g12b";
> +	} else {
> +		return -1;
> +	}
> +
> +	ret = adc_channel_single_shot("adc@9000", ODROID_HW_VS_ADC_CHANNEL,
> +				      &adcval);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(boards) ; ++i) {
> +		if (soc_id == boards[i].soc_id &&
> +		    adcval >= boards[i].adc_min &&
> +		    adcval < boards[i].adc_max) {
> +			variant = boards[i].variant;
> +			break;
> +		}
> +	}
> +
> +	printf("Board variant: %s\n", variant);
> +	env_set("variant", variant);
> +
> +	odroid_set_fdtfile(soc, variant);
> +
> +	return 0;
> +}
> +
>  int misc_init_r(void)
>  {
>  	u8 mac_addr[MAC_ADDR_LEN];
> @@ -58,5 +137,6 @@ int misc_init_r(void)
>  			meson_generate_serial_ethaddr();
>  	}
>  
> +	odroid_detect_variant();
>  	return 0;
>  }
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index 367d22db0b..8a9b8b0c02 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -8,7 +8,7 @@ CONFIG_DM_GPIO=y
>  CONFIG_MESON_G12A=y
>  CONFIG_DEBUG_UART_BASE=0xff803000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> -CONFIG_IDENT_STRING=" odroid-c4"
> +CONFIG_IDENT_STRING=" odroid-c4/hc4"
>  CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
> @@ -26,6 +26,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
>  CONFIG_DM_MMC=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_PHY_REALTEK=y
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index 76c60ab032..b82bd78f2d 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -8,7 +8,7 @@ CONFIG_DM_GPIO=y
>  CONFIG_MESON_G12A=y
>  CONFIG_DEBUG_UART_BASE=0xff803000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> -CONFIG_IDENT_STRING=" odroid-n2"
> +CONFIG_IDENT_STRING=" odroid-n2/n2_plus"
>  CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
> @@ -26,6 +26,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
>  CONFIG_DM_MMC=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_PHY_REALTEK=y
> 

Applied to u-boot-amlogic
