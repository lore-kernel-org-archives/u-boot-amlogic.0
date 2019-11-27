Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.5676.1574859637565446243
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 05:00:37 -0800
Received: by mail-wm1-f65.google.com with SMTP id s14so569418wmh.4
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tRrY/Rda2Lp6EBWbZMyloDCjAXhT58VNetC0i68YWYU=;
        b=bpypuiPWqw66SmBvJywRApYqoxqhAAiNBALmyyOV8E7LM9l0jxdtW0QHg83pcsWgnK
         r0l7ilLkMPT0rLIr9fXeEX3F/b6BQdFHuqgSHTBen0hOhmRxCfI/zkN1T3GCZRwMldWi
         IicLbQQAMv5RM6yhE27lrsVUIyDrxV4V0t1erNMNg//5SzMQN0HrwdqbFykwUK/1qErI
         HnrLNrPojB2tANRP9euJvFo77aDHlX1g+D6+GYAeW46QxSBgiD7AKFBVC9fB8qt7KXSm
         bG/r91TcORS6eCyLsRNWVwSY21vlvA5mS1c6JoQ7jxy7MGe0rSxVCydllSt4f87QYGGv
         o+Mw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 1/4] mmc: meson-gx: Fix tx phase in the tuning process
References: <20191126211206.4537-1-linux.amoon@gmail.com>
 <20191126211206.4537-2-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <cbd329c9-a14b-3d50-595e-0cfb6bf625c7@baylibre.com>
Date: Wed, 27 Nov 2019 14:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191126211206.4537-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 26/11/2019 22:12, Anand Moon wrote:
> odroid n2 eMMC module would failed to boot up,
> because of TX phase clk failure, fix the typo in
> TX phase macro to help tune correct clk freqency.
> 
> Before these changes.
>   clock is enabled (380953Hz)
>   clock is enabled (25000000Hz)
> after these changes
>   clock is enabled (380953Hz)
>   clock is enabled (25000000Hz)
>   clock is enabled (52000000Hz)
>   clock is enabled (52000000Hz)
>   clock is enabled (52000000Hz)
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Tested on
> new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
> old back   - eMMC CGND3R 58.2 GiB MMC 5.0
> ---
>  drivers/mmc/meson_gx_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 031cc79ccb..87bea2888b 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -53,7 +53,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	meson_mmc_clk |= CLK_CO_PHASE_180;
>  
>  	/* 180 phase tx clock */
> -	meson_mmc_clk |= CLK_TX_PHASE_000;
> +	meson_mmc_clk |= CLK_TX_PHASE_180;
>  
>  	/* clock settings */
>  	meson_mmc_clk |= clk_src;
> 

I don't understand what this change helps, the linux driver sets the TX phase to 0,
why 180 would help here ?

Neil
