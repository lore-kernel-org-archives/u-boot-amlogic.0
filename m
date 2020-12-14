Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.1142.1607972303781724351
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:58:24 -0800
Received: by mail-wm1-f66.google.com with SMTP id g185so16247966wmf.3
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S38ZaFyxQ/D36CnEJk/lL1fHDWOObqgKksxKmqEjdCM=;
        b=0SJL6sc5SD3U6LpDlHgYTqX01OJuAEETPEsgNuPl0eBA4dCv9Hk0AI1joNwkF3W9tK
         gUj/mCDvsuMrDciIL6iVjepKh5bP9vEzzNAeTbkuxgqIWfufSKANTpVmiugi39i26Doa
         4GEUhcaHIiJwf4ECeQSqsI+joay3v5P4nMuFtnx60yC9tQH6p4qqdRxaUugp0hWvwtpr
         BcoDgDq7WaYxV6h1V/mfK/5H8a2pmWrh/A/BYyZeywBWWdNC7URVlhgzETz5b4Qt9f4h
         Dgx1gwYnzFQ/F3Oo4oAxXrcYxt9QF9gv//FD+w9UAX5tiPP2RYVplL6f3wxAMTRSx34e
         XPIw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson-gx: change clock phase value on AGX SoCs
References: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bd392bb1-8d7a-a72f-a927-0e47ae77641f@baylibre.com>
Date: Mon, 14 Dec 2020 19:58:20 +0100
MIME-Version: 1.0
In-Reply-To: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Stefan Agner <stefan@agner.ch>
Cc: peng.fan@nxp.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 07/12/2020 18:15, Stefan Agner wrote:
> Amlogic AGX SoCs seem to have issue communicating with some eMMC
> devices (in particular with a Micron 128GB eMMC 5.1). The device
> is detected with 1-bit bus width, and at higher temperature loading
> pretty much anything from the storage fails: (e.g. fs_devread read error
> - block).
> 
> When phase is set to 270° it is detected with 8-bit bus width and is
> working fine accross all temperatures.

This is new to G12, I only had such issues and reports for SM1 only until now.

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Neil,
> 
> I debugged this issue today on an ODROID N2+ not booting reliably. I am
> not sure if we can safely switch to 270° for all SoCs with
> amlogic,meson-axg-mmc, but I guess we have to try and see what happens?
> I will do a bit broader testing in the comming days here.

amlogic,meson-axg-mmc covers too much SoCs, I'll prefer if you introduce
an u-boot only amlogic,meson-g12b-mmc compatible like I did for SM1.

> 
> Btw, I do see that 180° is also set in Linux. Do you have a patch to
> address this in Linux?

I never had such reports on Linux, I think because eMMCs are directly used
in HS200 mode and 180° is the right configuration for HS200...

Neil

> 
> --
> Stefan
> 
> 
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
>  drivers/mmc/meson_gx_mmc.c                | 9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> index cb16f75fc6..db5e058098 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -14,6 +14,7 @@
>  
>  enum meson_gx_mmc_compatible {
>  	MMC_COMPATIBLE_GX,
> +	MMC_COMPATIBLE_AGX,
>  	MMC_COMPATIBLE_SM1,
>  };
>  
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 5facbfdd9a..2c27113c10 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -64,14 +64,15 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  
>  	/*
>  	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
> +	 * AGX SoCs don't work reliable with some eMMCs with CLK_CO_PHASE_180
>  	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
>  	 * Other SoCs use CLK_CO_PHASE_180 by default.
>  	 * It needs to find what is a proper value about each SoCs.
>  	 */
> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
> -		meson_mmc_clk |= CLK_CO_PHASE_270;
> -	else
> +	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_GX))
>  		meson_mmc_clk |= CLK_CO_PHASE_180;
> +	else
> +		meson_mmc_clk |= CLK_CO_PHASE_270;
>  
>  	/* 180 phase tx clock */
>  	meson_mmc_clk |= CLK_TX_PHASE_000;
> @@ -327,7 +328,7 @@ int meson_mmc_bind(struct udevice *dev)
>  
>  static const struct udevice_id meson_mmc_match[] = {
>  	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_GX },
> -	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_GX },
> +	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_AGX },
>  	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_SM1 },
>  	{ /* sentinel */ }
>  };
> 

