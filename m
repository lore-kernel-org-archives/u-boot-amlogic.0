Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.11127.1628180471625676544
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:11 -0700
Received: by mail-wm1-f52.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so4114495wmd.3
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vayjRoXlWpMijpjKEjv01EfmEdQ98lbaf5rxOuDfKKY=;
        b=jzkOzkKOI0mE+gdRWehvDtEaXUpZfk1VghkKuSWFqMRrOq200adpcINh2oGmbGF8cJ
         c4hWg+EnnxBXhuPLDWDwkQIhCx4JH52hCw97426qhffeEpLCkgOI6J+2qGOwWgtHOHGh
         bAU7WJcvtaPWzzETJ4bdB20G4WufWIt6wdFolatjjlrvroQlSXOlR4EzNAUc6ZDwDwzO
         35/nTnbZzmL4RNGY9JpFuAVp1+CqhBZquiDevGfGB/bj3lBEcYljnWrFsksCSWyBrLnk
         trUSc5wLOzXevPHe5NAsexCMFDmUP+1WLdJDBqQEKN3bE0X5fUvh5pSulCMSwVxtbkwj
         Yf2g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/9] configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-3-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b8635d23-23c6-fbd2-2e2f-291f98f3e59a@baylibre.com>
Date: Thu, 5 Aug 2021 18:20:56 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-3-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> To prepare for AVB support, increase SYS_MALLOC_LEN to 128M.
> This value has been found by testing the following on khadas vim3l:
>   => avb init
>   => avb verify
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index f9f2b26416..bc3ffb9ca5 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -9,6 +9,10 @@
>  #ifndef __MESON64_ANDROID_CONFIG_H
>  #define __MESON64_ANDROID_CONFIG_H
>  
> +#include <linux/sizes.h>
> +
> +#define CONFIG_SYS_MALLOC_LEN	       SZ_128M
> +
>  #ifndef BOOT_PARTITION
>  #define BOOT_PARTITION "boot"
>  #endif
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
