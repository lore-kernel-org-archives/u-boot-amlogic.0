Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.6717.1586160227247986130
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2020 01:03:48 -0700
Received: by mail-wr1-f65.google.com with SMTP id h9so16226247wrc.8
        for <u-boot-amlogic@groups.io>; Mon, 06 Apr 2020 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMypD2WLZFzXKX3RNWf6hLqJhZH5zzL/jobOaDCDWSQ=;
        b=fJbPb2Vau1hrK5DhlJNCcuee8n5VviAGigNGA03uO6E7/crHdGiQabCcQGpqDqeE/4
         kAOBc6fhilc18A4Plb0XWd2lvvBEW0rCVZSEWU4Gm20xWhXn7SPR+dNn9I6LduDoYiOs
         1dpVOn2nN7U5vbWcfqiF3QGb+YEgbNgQV2jlhBVznOynvv2JK9nWVolH2m0suPivltQs
         PXzYhompFRn+VRg3uWep/ctOW2PdWbA+3wZ9DmLLljDgjcn9cfaM+gyc8Jn5qhO0Qs+i
         28Uyx1RkfEtlMovzyzzpVLCqlkpAVwtrk9VijuGQwyckn7UI/4JapW7bEWQneqHPwiWO
         m+bg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm: meson: imply DM_RNG
References: <20200405102023.15217-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f831af5e-458d-b9e8-b8ab-9914949da968@baylibre.com>
Date: Mon, 6 Apr 2020 10:03:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200405102023.15217-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, open list <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 05/04/2020 12:20, Heinrich Schuchardt wrote:
> All ARCH_MESON boards have a hardware random number generator. So we should
> enable building the RNG driver.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bbb1e2738b..eee4538c7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -762,6 +762,7 @@ config ARCH_OMAP2PLUS
>  config ARCH_MESON
>  	bool "Amlogic Meson"
>  	imply DISTRO_DEFAULTS
> +	imply DM_RNG
>  	help
>  	  Support for the Meson SoC family developed by Amlogic Inc.,
>  	  targeted at media players and tablet computers. We currently
> --
> 2.25.1
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>

You can take it now, or I will push it later.

Neil
