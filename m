Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.75.1614015634031669476
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Feb 2021 09:40:34 -0800
Received: by mail-wm1-f41.google.com with SMTP id p3so36923wmc.2
        for <u-boot-amlogic@groups.io>; Mon, 22 Feb 2021 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30Wh7rDh1kVYkMOu4vKxMsE8UlBmcgxXMqgvKFPfd9M=;
        b=Sfm3flesQMFlzrkEr6wXdoeUbrQ50RAzOH5bNOZsCm8Iu7pbpSR5l3J+xTAS0BdmTL
         X1R2kGf/5zl5ehaOdvH4eueAG0D6pqsAl0IdTMFle7XU9jUT+sL1cwhjY6yeKjCs8SJE
         B9Hxz736FlLhexeit2zZUwO1QG+hL89A15FryqKjMbXnQE+oD3jl5+sWpQTc/Ln1NTn4
         cYu1kfCIzHMpOHu6RyNQuW6DxWASenhhlcC+sMley+dGRf6/8+8p7v4ahid7Stk/W63i
         DSIfICmf6bXoFZBCN2QX4euS64TNChIyq5vBe+DaCYuFGpqmTxuHx9jx7LNEckNpV9Hr
         ovWA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH V2 4/5] ARM: mach-meson: select MMC_PWRSEQ config
References: <20210216011656.12855-1-jh80.chung@samsung.com>
 <CGME20210216011617epcas1p39914bbdb2b853b7effd89cfc126cb6c2@epcas1p3.samsung.com>
 <20210216011656.12855-5-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a02997c4-3fa3-a837-5826-53695ce85414@baylibre.com>
Date: Mon, 22 Feb 2021 18:40:31 +0100
MIME-Version: 1.0
In-Reply-To: <20210216011656.12855-5-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, sjg@chromium.org, peng.fan@nxp.com, kever.yang@rock-chips.com, philipp.tomsich@theobroma-systems.com
List-ID: <u-boot-amlogic@groups.io>

On 16/02/2021 02:16, Jaehoon Chung wrote:
> Before time, PWRSEQ is selected since below commit.
> commit 262d34363373 ("board: amlogic: select PWRSEQ for all amlogic platform")
> Select MMC_PWRSEQ config because of introducing CONFIG_MMC_PWRSEQ for
> only eMMC module.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm/mach-meson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 513a33dae204..6cba2c40ddaa 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -9,6 +9,7 @@ config MESON64_COMMON
>  	select SYSCON
>  	select REGMAP
>  	select PWRSEQ
> +	select MMC_PWRSEQ
>  	select BOARD_LATE_INIT
>  	imply CMD_DM
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
