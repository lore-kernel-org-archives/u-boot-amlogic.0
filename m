Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.6994.1581253698489429774
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 05:08:18 -0800
Received: by mail-wm1-f68.google.com with SMTP id a9so7534916wmj.3
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=p8eLy3K9qAh3x+hyyWXY68mTg0TrSrqi9GAIbz74TkE=;
        b=yiprXa5umHZJCsOkgtYqSjiZ3Hf9m4amEdwtghdDOvHfXjX5DidD1s7a4p7ruIMY4v
         Hz2/g3jaP8zyoP80ChqmmrzoGzfWq6cFLlkM0IwspITbyphHuO0NDm2mpialBg7Kuc0w
         7Ow4qOZD2oHV9oNSZAEeJv9hWCxbf/MbPyUnb/cJuQAzirQTxRFytQ4lURy95WkOD7+W
         Q907HYjdoXUf3YT6wIOcFenf9C+U6olidx+CUFQ9Y9iJy5KqOj6d+iSnttFaYqEsr2+1
         wcdX0t/iPBO0cNMKiHO1NxVPHBWisvzhkChikgAmismYK6ET5Ya1R1dFVPv/F56QyYVU
         tnig==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-2-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <61096502-4817-a095-4d11-b487781202b0@baylibre.com>
Date: Sun, 9 Feb 2020 14:08:15 +0100
MIME-Version: 1.0
In-Reply-To: <20200209110557.1996-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 09/02/2020 =E0 12:05, Anand Moon a =E9crit :
> As per mainline line kernel fix the clk tuning phase for mmc,
> set Core=3D180, Tx=3D0, Rx=3D0 clk phase for mmc initialization.
> As per S905, S905X, AGX and S922X datasheet set the default
> values for clk tuning.
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes from previous
> v5  Fix the commit message, configure as per mainline kernel.
>     drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.
>=20
> v4  Fix the update mask value using FIELD_PREP macro.
>=20
> v3  Fix the initialization of core clk tunning phase as per datasheet.
>     Fix the commit message.
>=20
> v2: Fix the clk phase macro to support PHASE_180
>     drop the wrong CLK_CORE_PHASE_MASK macro.
>=20
> v1: use the mainline kernel tuning for clk tuning.
>=20
> Fixed the commmit messages.
> Patch v1:
> https://patchwork.ozlabs.org/patch/1201208/
>=20
> Before these changes.
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
> After these changes
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
>     clock is enabled (52000000Hz)
> Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> ---
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
>  drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++----
>  2 files changed, 38 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include=
/asm/arch-meson/sd_emmc.h
> index e3a72c8b66..f4299485dc 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -7,6 +7,7 @@
>  #define __SD_EMMC_H__
> =20
>  #include <mmc.h>
> +#include <linux/bitops.h>
> =20
>  #define SDIO_PORT_A			0
>  #define SDIO_PORT_B			1
> @@ -19,15 +20,20 @@
>  #define   CLK_MAX_DIV			63
>  #define   CLK_SRC_24M			(0 << 6)
>  #define   CLK_SRC_DIV2			(1 << 6)
> -#define   CLK_CO_PHASE_000		(0 << 8)
> -#define   CLK_CO_PHASE_090		(1 << 8)
> -#define   CLK_CO_PHASE_180		(2 << 8)
> -#define   CLK_CO_PHASE_270		(3 << 8)
> -#define   CLK_TX_PHASE_000		(0 << 10)
> -#define   CLK_TX_PHASE_090		(1 << 10)
> -#define   CLK_TX_PHASE_180		(2 << 10)
> -#define   CLK_TX_PHASE_270		(3 << 10)
> -#define   CLK_ALWAYS_ON			BIT(24)
> +
> +#define   CRYSTAL_24MHZ			0
> +#define   CLK_PHASE_0			0
> +#define   CLK_PHASE_180			2
> +
> +#define   CLK_DIV_MASK			GENMASK(5, 0)
> +#define   CLK_SRC_MASK			GENMASK(7, 6)
> +#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
> +#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
> +#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
> +
> +#define   CLK_V2_ALWAYS_ON		BIT(24)
> +
> +#define   CLK_V3_ALWAYS_ON		BIT(28)
> =20
>  #define MESON_SD_EMMC_CFG		0x44
>  #define   CFG_BUS_WIDTH_MASK		GENMASK(1, 0)
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 86c1a7164a..b013c7c5fb 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -16,6 +16,10 @@
>  #include <asm/arch/sd_emmc.h>
>  #include <linux/log2.h>
> =20
> +#include <linux/bitops.h>
> +#include <linux/compat.h>
> +#include <linux/bitfield.h>
> +
>  static inline void *get_regbase(const struct mmc *mmc)
>  {
>  	struct meson_mmc_platdata *pdata =3D mmc->priv;
> @@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	}
>  	clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> =20
> -	/* 180 phase core clock */
> -	meson_mmc_clk |=3D CLK_CO_PHASE_180;
> -
> -	/* 180 phase tx clock */
> -	meson_mmc_clk |=3D CLK_TX_PHASE_000;
> +	/* Clock divider */
> +	meson_mmc_clk |=3D CLK_DIV_MASK;

This will set the max divider, whatever the value of clk_div, so the follow=
ing statement:
meson_mmc_clk |=3D clk_div;
will have no effect.


> +	/* Clock source : Crystal 24MHz */
> +	meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);

You set CRYSTAL_24MHZ here, but the src is selected in clk_src and set with:
meson_mmc_clk |=3D clk_src;

In conclusion your change forces the 24MHz crystal and max divider whatever=
 the
freq asked by the mmc core !

> +	/* Core clock phase 2:180 */
> +	meson_mmc_clk |=3D FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
> +	/* TX clock phase 0:180 */
> +	meson_mmc_clk |=3D FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
> +	/* RX clock phase 0:180 */
> +	meson_mmc_clk |=3D FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);

These are ok, but it's exactly the same as before with a different style.

> +
> +#ifdef CONFIG_MESON_GX
> +	/* clk always on */
> +	meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> +#endif
> +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> +	/* clk always on */
> +	meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> +#endif

Why not, not sure about the effect.

> =20
>  	/* clock settings */
>  	meson_mmc_clk |=3D clk_src;
>=20

Neil
