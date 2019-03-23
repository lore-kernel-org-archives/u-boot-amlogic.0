Received: by mail-wm1-f66.google.com with SMTP id a184so4322357wma.2
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=kYwKRL+fDe0HYokwhw6ZJDAbcq/uqx/HoQhYVny7sIQ=;
        b=yz0tGgvvi6wHNZMudsNgzBTXdSKUUsNzr2LYsITlhdObr4Ll29fP7XRJo+1sJ0tudQ
         jg20trHYQGi7LlkxTLRlFjgXMx8+14iJxMPb/xhgtoa373AcQFlHjFZQc8hHMVR8kuPW
         RRlVY2d1e4+g9IMb5mbQbmxUz+IvOVXL2Gkms29FZqEgcDnRLErJoxZfG2Nx/x+82ZLF
         2hm7wj/xaB60uQ9oOdcSPT/MYqiAdboo3zUFBqa/gwiUMQR94tusVBHQNEAcAYfwlz3r
         kYIWeNMlZHJH1sVbV7+OVjl6Sffgkxyee5heyWlLg1M5Kf44AGttFDNFIx3J3keuJxKB
         E39g==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C960433.8020506@baylibre.com>
Date: Sat, 23 Mar 2019 11:02:27 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: meson: display Amlogic SoC Information
References: <86ef73kkcw.fsf@julienm-ubuntu-20JES0UQ00.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <86ef73kkcw.fsf@julienm-ubuntu-20JES0UQ00.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, Albert Aribaud <albert.u.boot@aribaud.net>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Julien,

First, please also CC to u-boot-amlogic@groups.io !

Le 19/03/2019 15:26, Julien Masson a =E9crit :
> The Amlogic SoCs have a registers containing the die revision
> and packaging type to determine the SoC family and package marketing
> name like S905X for the GXL SoC Family.
>=20
> This code is taken from the Linux meson-gx-socinfo driver and adapted
> to U-Boot printing.
>=20
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
>  arch/arm/mach-meson/board-common.c | 140 +++++++++++++++++++++++++++++++=
++++++
>  configs/khadas-vim_defconfig       |   2 +-
>  configs/libretech-cc_defconfig     |   2 +-
>  configs/odroid-c2_defconfig        |   2 +-
>  configs/p212_defconfig             |   2 +-

Please add to all the Amlogic boards, including nanopi-k2, khadas-vim2 and =
s400

>  5 files changed, 144 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/boa=
rd-common.c
> index 8c41301..e766ebc 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -7,11 +7,59 @@
>  #include <asm/arch/boot.h>
>  #include <linux/libfdt.h>
>  #include <linux/err.h>
> +#include <linux/bitfield.h>
>  #include <asm/arch/mem.h>
>  #include <asm/arch/sm.h>
>  #include <asm/armv8/mmu.h>
> +#include <asm/io.h>
>  #include <asm/unaligned.h>
>  #include <efi_loader.h>
> +#include <dm.h>
> +#include <syscon.h>
> +#include <regmap.h>
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
> +} soc_ids[] =3D {
> +	{ "GXBB",   0x1f },
> +	{ "GXTVBB", 0x20 },
> +	{ "GXL",    0x21 },
> +	{ "GXM",    0x22 },
> +	{ "TXL",    0x23 },
> +	{ "TXLX",   0x24 },
> +	{ "AXG",    0x25 },
> +	{ "GXLX",   0x26 },
> +	{ "TXHD",   0x27 },
> +};
> +
> +static const struct meson_gx_package_id {
> +	const char *name;
> +	unsigned int major_id;
> +	unsigned int pack_id;
> +} soc_packages[] =3D {
> +	{ "S905",   0x1f, 0 },
> +	{ "S905H",  0x1f, 0x13 },
> +	{ "S905M",  0x1f, 0x20 },
> +	{ "S905D",  0x21, 0 },
> +	{ "S905X",  0x21, 0x80 },
> +	{ "S905W",  0x21, 0xa0 },
> +	{ "S905L",  0x21, 0xc0 },
> +	{ "S905M2", 0x21, 0xe0 },
> +	{ "S912",   0x22, 0 },
> +	{ "962X",   0x24, 0x10 },
> +	{ "962E",   0x24, 0x20 },
> +	{ "A113X",  0x25, 0x37 },
> +	{ "A113D",  0x25, 0x22 },
> +};

Can you handle the mask into this struct aswell like
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/c=
ommit/?h=3Dv5.2/drivers&id=3Ddce47aed20c7de3ee2011b7a63e67f08e9dcfb5e ?

You should also add the new IDs like in :
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/c=
ommit/?h=3Dv5.2/drivers&id=3D65f80df58eb770b2b687c35142c113d1ad6fa415

> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -115,3 +163,95 @@ void reset_cpu(ulong addr)
>  {
>  	psci_system_reset();
>  }
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
> +	unsigned int pack =3D socinfo_to_pack(socinfo) & 0xf0;
> +	unsigned int major =3D socinfo_to_major(socinfo);
> +	int i;
> +
> +	for (i =3D 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
> +		if (soc_packages[i].major_id =3D=3D major &&
> +		    soc_packages[i].pack_id =3D=3D pack)
> +			return soc_packages[i].name;
> +	}
> +
> +	return "Unknown";
> +}
> +
> +static const char *socinfo_to_soc_id(u32 socinfo)
> +{
> +	unsigned int id =3D socinfo_to_major(socinfo);
> +	int i;
> +
> +	for (i =3D 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
> +		if (soc_ids[i].id =3D=3D id)
> +			return soc_ids[i].name;
> +	}
> +
> +	return "Unknown";
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
> +	nodeoffset =3D fdt_node_offset_by_compatible(gd->fdt_blob, -1,
> +						   "amlogic,meson-gx-ao-secure");
> +	if (nodeoffset < 0)
> +		return 0;
> +
> +	/* check if chip-id is available */
> +	if (!fdt_getprop(gd->fdt_blob, nodeoffset, "amlogic,has-chip-id", NULL))
> +		return 0;
> +
> +	/* get regmap from the syscon node */
> +	node =3D offset_to_ofnode(nodeoffset);
> +	regmap =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap)) {
> +		printf("%s: failed to get regmap\n", __func__);
> +		return 0;
> +	}
> +
> +	/* read soc info */
> +	ret =3D regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
> +	if (ret && !socinfo) {
> +		printf("%s: invalid chipid value\n", __func__);
> +		return 0;
> +	}
> +
> +	/* print board information */
> +	printf("Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
> +	       socinfo_to_soc_id(socinfo),
> +	       socinfo_to_package_id(socinfo),
> +	       socinfo_to_major(socinfo),
> +	       socinfo_to_minor(socinfo),
> +	       socinfo_to_pack(socinfo),
> +	       socinfo_to_misc(socinfo));

Can you also show the board model from DT like the original show_board_info=
() ?

> +
> +	return 0;
> +}

Looks good, but can you move this code to a separate C file, like board-inf=
o.c ?

> diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
> index 6f1ad0e..aeec2be 100644
> --- a/configs/khadas-vim_defconfig
> +++ b/configs/khadas-vim_defconfig
> @@ -11,7 +11,7 @@ CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=3Dy
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defcon=
fig
> index d28c7ab..a1b9fd9 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=3Dy
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 747da18..04904c2 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -10,7 +10,7 @@ CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/p212_defconfig b/configs/p212_defconfig
> index b048863..0422740 100644
> --- a/configs/p212_defconfig
> +++ b/configs/p212_defconfig
> @@ -11,7 +11,7 @@ CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
> -# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_GPIO=3Dy
>=20

Thanks !!

Neil
