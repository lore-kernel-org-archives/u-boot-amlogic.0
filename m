Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.5618.1574859370943776924
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 04:56:11 -0800
Received: by mail-wm1-f67.google.com with SMTP id l1so6981642wme.2
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 04:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GMBlkLnpG0IuI4ISv49YZdXAYIHl6Rj7Bh0uBj9y1DU=;
        b=bl0yZPsiheZ5zSPxaPCWUVK3UZoSdKBlKlyCAcKQGdYMPS5GP69qCVw1Yh4Cd6iaah
         MkZzQAGEt/ryuT7xQTlD9EjhQYe0HeEcivD7M4pgDmT8xC/GKQtfhJ4DOPT3gmTkVORL
         Q5IqAw4/ety6NdJBH7KL03VovB1mJDEsOzbut+3ucpl/S3TtGux2HkkBGfCQBdxfeaBG
         W4Srv1uapJvOmdqL7ip7C/6HOkrw4XL9rQA0Vv+eaLjIj/2MHSendagmc7A+4JDThNG8
         obMWURSfGoM8E34usFOOeND10D/fyTqrSBTfKdPpgPz6b0xztzuRA9jZsTBHUPLbJJEh
         5zbg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 3/4] board: amlogic: select PWRSEQ for all amlogic platform
References: <20191126211206.4537-1-linux.amoon@gmail.com>
 <20191126211206.4537-4-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <7ede41e8-980b-44f3-6ef8-e59a8865d528@baylibre.com>
Date: Wed, 27 Nov 2019 13:56:08 +0100
MIME-Version: 1.0
In-Reply-To: <20191126211206.4537-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/11/2019 22:12, Anand Moon wrote:
> commit a10388dc6982 ("mmc: meson-gx: add support for mmc-pwrseq-emmc")
> introduce CONFIG_PWESEQ for power sequence for eMMC module on
> amlogic platform, so enable this to all amlogic boards.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
