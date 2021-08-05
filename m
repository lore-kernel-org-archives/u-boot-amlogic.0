Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web09.11169.1628180471399154750
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:11 -0700
Received: by mail-wm1-f43.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so5840673wmd.0
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRAtyweFGU/uzPtMK6BXNtwXijFjuPXk5bkgY++4ZVM=;
        b=THLvRk/INdyTmYIoNagDo4X8tM43DadFaCdEAFSXHZBFMEJvsfFEUbkSjnKTGUt1Kq
         ndzIOzDuXZoqFq7hmuHuOX5u2sMDrKmbElZ1nsr97ExajCU+XkJrse+4B4cgVQFuYJxb
         2fc0FLUlmUwJuhj3YS8j92qskQ+WxdBQfYAX41JbVeleBDfR2NTGiacdJEaIIVerZUkm
         Yqij9gQWFzuByehHawA/9F45/nxT8LkceST+JQX2MAXyJstEpttetpdL/4Ooycvg3FI0
         mRTAwQ6ryG/OnulVuQTIIVZvQ9cPFCv8L8Cbj89kwMrKtM8KYMbb1znWx3bJlTxYPyTR
         tkRA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/9] configs: meson64: permit redefining SYS_MALLOC_LEN
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-2-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c68ec64e-5309-be21-db7b-452c8f01e0f8@baylibre.com>
Date: Thu, 5 Aug 2021 18:20:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-2-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> Permit redefining SYS_MALLOC_LEN for board specific configs.
> This is especially useful for Android with AVB, which requires a malloc
> length of 128M.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index fb7f16d148..f9bb0240d2 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -32,7 +32,9 @@
>  #define CONFIG_CPU_ARMV8
>  #define CONFIG_REMAKE_ELF
>  #define CONFIG_SYS_MAXARGS		32
> +#ifndef CONFIG_SYS_MALLOC_LEN
>  #define CONFIG_SYS_MALLOC_LEN		(32 << 20)
> +#endif
>  #define CONFIG_SYS_CBSIZE		1024
>  
>  #define CONFIG_SYS_SDRAM_BASE		0
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
