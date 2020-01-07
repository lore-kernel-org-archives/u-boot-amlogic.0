Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.5528.1578404529337981072
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 05:42:09 -0800
Received: by mail-wr1-f65.google.com with SMTP id t2so53977960wrr.1
        for <u-boot-amlogic@groups.io>; Tue, 07 Jan 2020 05:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqqaRWF6iWeBMuNow4EFCQsm1JAyFxSH5wVS3n+N0T4=;
        b=xT3hp9NPAfTWQmnDmsLmnxADMuVL31a20KjAy6L3oyACL6JrpSyBLmJlPIzJbpeieE
         ig3aRlQ+WyBiXEklCTFn2VB0K3q/xIeh4dIWjUa4VG/TnBNnnxnX6rw2Q9+4NFvxr9dN
         uBB7InhWYpFkiRZcNP/PIty64ETAdeRzBnXdCQG79kA+7qFc3i8rqoAJDg4ZOLT15FXK
         1DHW8+4CVDOjnl4/YkpC5BB5JUz2WrDzzT+4aDEPfC98d/KmgLcVewknf4F/JpNWlvUU
         N5ljq3HjZVW+/kxilHFV0xdJg4LMQ+Wl1+5z8MTtp7OfA+Hh9jOOiEsQ25cnFo+bh1hl
         SLJA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv3 3/3] board: amlogic: select PWRSEQ for all amlogic platform
References: <20191226113353.1757-1-linux.amoon@gmail.com>
 <20191226113353.1757-4-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3d389772-c5da-b916-adc1-aef21aa9ad02@baylibre.com>
Date: Tue, 7 Jan 2020 14:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <20191226113353.1757-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/12/2019 12:33, Anand Moon wrote:
> commit a10388dc6982 ("mmc: meson-gx: add support for mmc-pwrseq-emmc")
> introduce CONFIG_PWESEQ for power sequence for eMMC module on
> amlogic platform, so enable this to all amlogic boards.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-meson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index e29e4c0acc..513a33dae2 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -8,6 +8,7 @@ config MESON64_COMMON
>  	select DM_SERIAL
>  	select SYSCON
>  	select REGMAP
> +	select PWRSEQ
>  	select BOARD_LATE_INIT
>  	imply CMD_DM
>  
> 


Applied this patch to u-boot-amlogic

Neil

