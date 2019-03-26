Received: by mail-wm1-f68.google.com with SMTP id a188so12011419wmf.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z0690MV2Ski22SQ00pgADq5oJJXQ1Cl3+Zyv++xm3kA=;
        b=ykUsj2UwSf60s8gwOrvqFwGueZcqdNw0W+IzzAwxMF7gTxy6dzZUehIYLLFyUARxR/
         IcFpHOqC6+wmv+w/W4/X2UfTVyzvfCLciY+DGNiH5yvT3ykU1e6CsDgFsSAxDGKmoRzW
         ew71ySlfNjAmfLzCTIHdoMY9glLNi8ww+eY2jUZ273or+o74IcanbeULjtehV+KPUPSL
         KyZiWAJ8LqooEcekkV0/Q4OyK9ll6X8zS44vxo9USK1s8IokcOjStRp5QPj4WE71dVxV
         7Tna5ZXvAM+PlBqUADR6aYwEQrZneInPCQ5B+kqNTETFmcTs5IZFK4WbK6JkCfRvfYas
         gMIA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] ARM: meson: display Amlogic SoC Information
References: <86a7hjrzf3.fsf@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1f666d3a-4ed7-1e7e-9ffb-7aebda0ebc4e@baylibre.com>
Date: Tue, 26 Mar 2019 10:28:17 +0100
MIME-Version: 1.0
In-Reply-To: <86a7hjrzf3.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Julien Masson <jmasson@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Albert Aribaud <albert.u.boot@aribaud.net>
List-ID: <u-boot-amlogic@groups.io>

Hi Julien,

On 25/03/2019 11:55, Julien Masson wrote:
> The Amlogic SoCs have a registers containing the die revision
> and packaging type to determine the SoC family and package marketing
> name like S905X for the GXL SoC Family.
> 
> This code is taken from the Linux meson-gx-socinfo driver and adapted
> to U-Boot printing.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
> Changes from v1:
> -> enable CONFIG_DISPLAY_BOARDINFO for nanopi-k2, khadas-vim2 and s400
> 
> -> handle the mask like the kernel when getting the package id:
> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/commit/?h=v5.2/drivers&id=dce47aed20c7de3ee2011b7a63e67f08e9dcfb5e
> 
> -> add new soc ids:
> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/commit/?h=v5.2/drivers&id=65f80df58eb770b2b687c35142c113d1ad6fa415
> 
> -> print the board model from the device tree
> 
> -> move all the source code in dedicated new file: board-info.c
> 
>  arch/arm/mach-meson/Makefile     |   2 +-
>  arch/arm/mach-meson/board-info.c | 166 +++++++++++++++++++++++++++++++++++++++
>  configs/khadas-vim2_defconfig    |   2 +-
>  configs/khadas-vim_defconfig     |   2 +-
>  configs/libretech-cc_defconfig   |   2 +-
>  configs/nanopi-k2_defconfig      |   2 +-
>  configs/odroid-c2_defconfig      |   2 +-
>  configs/p212_defconfig           |   2 +-
>  configs/s400_defconfig           |   2 +-
>  9 files changed, 174 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/mach-meson/board-info.c
> 
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index b716e1a..6ddfba6 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -2,6 +2,6 @@
>  #
>  # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
>  
> -obj-y += board-common.o sm.o
> +obj-y += board-common.o sm.o board-info.o
>  obj-$(CONFIG_MESON_GX) += board-gx.o
>  obj-$(CONFIG_MESON_AXG) += board-axg.o
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> new file mode 100644
> index 0000000..ba248e8
> --- /dev/null
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2019 Julien Masson <jmasson@baylibre.com>
> + * (C) Copyright 2019 Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <common.h>
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <linux/bitfield.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +
> +#define AO_SEC_SD_CFG8		0xe0
> +#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
> +
> +#define SOCINFO_MAJOR	GENMASK(31, 24)
> +#define SOCINFO_PACK	GENMASK(23, 16)
> +#define SOCINFO_MINOR	GENMASK(15, 8)
> +#define SOCINFO_MISC	GENMASK(7, 0)
> +
> +static const struct meson_gx_soc_id {
> +	const char *name;
> +	unsigned int id;
> +} soc_ids[] = {
> +	{ "GXBB",   0x1f },
> +	{ "GXTVBB", 0x20 },
> +	{ "GXL",    0x21 },
> +	{ "GXM",    0x22 },
> +	{ "TXL",    0x23 },
> +	{ "TXLX",   0x24 },
> +	{ "AXG",    0x25 },
> +	{ "GXLX",   0x26 },
> +	{ "TXHD",   0x27 },
> +	{ "G12A",   0x28 },
> +	{ "G12B",   0x29 },
> +};
> +
> +static const struct meson_gx_package_id {
> +	const char *name;
> +	unsigned int major_id;
> +	unsigned int pack_id;
> +	unsigned int pack_mask;
> +} soc_packages[] = {
> +	{ "S905",   0x1f, 0,    0x20 }, /* pack_id != 0x20 */
> +	{ "S905H",  0x1f, 0x3,  0xf },  /* pack_id & 0xf == 0x3 */
> +	{ "S905M",  0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
> +	{ "S905D",  0x21, 0,    0xf0 },
> +	{ "S905X",  0x21, 0x80, 0xf0 },
> +	{ "S905W",  0x21, 0xa0, 0xf0 },
> +	{ "S905L",  0x21, 0xc0, 0xf0 },
> +	{ "S905M2", 0x21, 0xe0, 0xf0 },
> +	{ "S805X",  0x21, 0x30, 0xf0 },
> +	{ "S805Y",  0x21, 0xb0, 0xf0 },
> +	{ "S912",   0x22, 0,    0x0 },  /* Only S912 is known for GXM */
> +	{ "962X",   0x24, 0x10, 0xf0 },
> +	{ "962E",   0x24, 0x20, 0xf0 },
> +	{ "A113X",  0x25, 0x37, 0xff },
> +	{ "A113D",  0x25, 0x22, 0xff },
> +	{ "S905D2", 0x28, 0x10, 0xf0 },
> +	{ "S905X2", 0x28, 0x40, 0xf0 },
> +	{ "S922X",  0x29, 0x40, 0xf0 },
> +};
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static inline unsigned int socinfo_to_major(u32 socinfo)
> +{
> +	return FIELD_GET(SOCINFO_MAJOR, socinfo);
> +}
> +
> +static inline unsigned int socinfo_to_minor(u32 socinfo)
> +{
> +	return FIELD_GET(SOCINFO_MINOR, socinfo);
> +}
> +
> +static inline unsigned int socinfo_to_pack(u32 socinfo)
> +{
> +	return FIELD_GET(SOCINFO_PACK, socinfo);
> +}
> +
> +static inline unsigned int socinfo_to_misc(u32 socinfo)
> +{
> +	return FIELD_GET(SOCINFO_MISC, socinfo);
> +}
> +
> +static const char *socinfo_to_package_id(u32 socinfo)
> +{
> +	unsigned int pack = socinfo_to_pack(socinfo);
> +	unsigned int major = socinfo_to_major(socinfo);
> +	int i;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
> +		if (soc_packages[i].major_id == major &&
> +		    soc_packages[i].pack_id ==
> +		    (pack & soc_packages[i].pack_mask))
> +			return soc_packages[i].name;
> +	}
> +
> +	return "Unknown";
> +}
> +
> +static const char *socinfo_to_soc_id(u32 socinfo)
> +{
> +	unsigned int id = socinfo_to_major(socinfo);
> +	int i;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
> +		if (soc_ids[i].id == id)
> +			return soc_ids[i].name;
> +	}
> +
> +	return "Unknown";
> +}
> +
> +static void print_board_model(void)
> +{
> +	const char *model;
> +	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
> +	printf("Model: %s\n", model ? model : "Unknown");
> +}
> +
> +int show_board_info(void)
> +{
> +	struct regmap *regmap;
> +	int nodeoffset, ret;
> +	ofnode node;
> +	unsigned int socinfo;
> +
> +	/* find the offset of compatible node */
> +	nodeoffset = fdt_node_offset_by_compatible(gd->fdt_blob, -1,
> +						   "amlogic,meson-gx-ao-secure");
> +	if (nodeoffset < 0)
> +		return 0;
> +
> +	/* check if chip-id is available */
> +	if (!fdt_getprop(gd->fdt_blob, nodeoffset, "amlogic,has-chip-id", NULL))
> +		return 0;
> +
> +	/* get regmap from the syscon node */
> +	node = offset_to_ofnode(nodeoffset);
> +	regmap = syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap)) {
> +		printf("%s: failed to get regmap\n", __func__);
> +		return 0;
> +	}
> +
> +	/* read soc info */
> +	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
> +	if (ret && !socinfo) {
> +		printf("%s: invalid chipid value\n", __func__);
> +		return 0;
> +	}
> +
> +	/* print board information */
> +	print_board_model();
> +	printf("Soc:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
> +	       socinfo_to_soc_id(socinfo),
> +	       socinfo_to_package_id(socinfo),
> +	       socinfo_to_major(socinfo),
> +	       socinfo_to_minor(socinfo),
> +	       socinfo_to_pack(socinfo),
> +	       socinfo_to_misc(socinfo));
> +
> +	return 0;
> +}
> diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
> index 0f738cb..7e40683 100644
> --- a/configs/khadas-vim2_defconfig
> +++ b/configs/khadas-vim2_defconfig
> @@ -9,7 +9,7 @@ CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=y
> diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
> index 6f1ad0e..aeec2be 100644
> --- a/configs/khadas-vim_defconfig
> +++ b/configs/khadas-vim_defconfig
> @@ -11,7 +11,7 @@ CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=y
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
> index d28c7ab..a1b9fd9 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=y
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 8bbf48f..60481cd 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=y
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 747da18..04904c2 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -10,7 +10,7 @@ CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=y
> diff --git a/configs/p212_defconfig b/configs/p212_defconfig
> index b048863..0422740 100644
> --- a/configs/p212_defconfig
> +++ b/configs/p212_defconfig
> @@ -11,7 +11,7 @@ CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=y
> diff --git a/configs/s400_defconfig b/configs/s400_defconfig
> index 1bd4b71..6cd47d0 100644
> --- a/configs/s400_defconfig
> +++ b/configs/s400_defconfig
> @@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_MISC_INIT_R=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=y
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=y
> 

Looks good,

I will also update the p200 and p201 defconfig from Mohammad's patchset when
applying, no need to resend for that.

I applied it to u-boot-amlogic and will run some tests.

Neil
