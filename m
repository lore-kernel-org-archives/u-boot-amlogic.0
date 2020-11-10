Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web08.24824.1604996249191311760
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Nov 2020 00:17:29 -0800
Received: by mail-wr1-f65.google.com with SMTP id b8so11654344wrn.0
        for <u-boot-amlogic@groups.io>; Tue, 10 Nov 2020 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAjLgrpaxAkAsR/bFzn2vBcqH+3u54W9eVzJ/oxtSdU=;
        b=kvrldX22uGLAcBqJ8FgOSAzh2IcDvQDB5J7JZtLkzAVqmwIjvarllIMh7srqfGkvu/
         kz30SQlXIpatBBgnyqlmzXCTFhUv/y/jj+dTwBdPRF0OxcBkDgZyuMzCM8NsWB1dE6hI
         /Pvttoev8gP49WxYsCwTT1bqaodY+9HQiS14trN83Eqo0yKZIINygPAa+o2ASWmz75JV
         j7Wmo0daFY5V1PSUHKMdSfmIXw90VyjWVthTCbkri6QXrfqF3TxWfulHKvC1XP0d0PyH
         Tenw8kalLAokmHgg5uPddS/z1+o6DQbp0kDQhQsF7tHGk9wq5r7QeQHnI/Pbw0GSNrRq
         6F5w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: control ddr_mode bit
References: <CGME20201110075040epcas1p1f3865c6fd9c7f3c561faf12ac760d277@epcas1p1.samsung.com>
 <20201110075055.25318-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8015b1fa-89d9-20d4-f27b-fc4aea938297@baylibre.com>
Date: Tue, 10 Nov 2020 09:15:14 +0100
MIME-Version: 1.0
In-Reply-To: <20201110075055.25318-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 10/11/2020 08:50, Jaehoon Chung wrote:
> EMMC_CFG register has a cfg_ddr bit(BIT[2]).
> It needs to set when mmc is running to ddr mode.
> Otherwise, its bit should be cleared.
> CFG_DDR[2] - 1: DDR mode, 0: SDR mode
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
>  drivers/mmc/meson_gx_mmc.c                | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> index 1e9f8cf498b4..c2f77c7308ec 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -38,6 +38,7 @@
>  #define   CFG_BUS_WIDTH_1		0
>  #define   CFG_BUS_WIDTH_4		1
>  #define   CFG_BUS_WIDTH_8		2
> +#define   CFG_DDR_MODE			BIT(2)
>  #define   CFG_BL_LEN_MASK		GENMASK(7, 4)
>  #define   CFG_BL_LEN_SHIFT		4
>  #define   CFG_BL_LEN_512		(9 << 4)
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 7c60e0566560..6fcf6c2ced27 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -90,6 +90,11 @@ static int meson_dm_mmc_set_ios(struct udevice *dev)
>  	else
>  		return -EINVAL;
>  
> +	if (mmc->ddr_mode)
> +		meson_mmc_cfg |= CFG_DDR_MODE;
> +	else
> +		meson_mmc_cfg &= ~CFG_DDR_MODE;
> +
>  	/* 512 bytes block length */
>  	meson_mmc_cfg &= ~CFG_BL_LEN_MASK;
>  	meson_mmc_cfg |= CFG_BL_LEN_512;
> 

Interesting, how did it work without this bit ?

This driver seems to really be in a bad state...

Neil

