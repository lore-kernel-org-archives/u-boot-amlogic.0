Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.28453.1604306443065639047
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Nov 2020 00:40:43 -0800
Received: by mail-wr1-f65.google.com with SMTP id i16so8106565wrv.1
        for <u-boot-amlogic@groups.io>; Mon, 02 Nov 2020 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iwdku80x9CEIaOlbWSB7o5KnKB4bL/eDDvime3x0cQ=;
        b=T5MXFtSejpGeIn7ZIrLPDCyigc07EwE4xS3hqhlEoWTU11QNePC8tBhGZpHB5TpdM/
         BxBRNsprbcKOh4cXvx+OPVzSbk2b1kWKd+ygrvAosE8ZCyFsQPHOeEA2pPtuzR9i4VQN
         ubaGvlAyvlOl205hX9BpjSIXTLcun65GsS6lw5NVW0JV6ZhtjsKAL/2tNsv49BfmuCJi
         Iua+BRKkPN3dHsSks2zzbZ3yVf4w8KmAxkLygFvwLlkJrG9uiA9MOuZ1GNM8MULdfdIN
         qt5VZM11hNS6y3z9XkoM56jQ/cMNWIuTS5Kxrk/5c5G9+pfYxPQb8U0Av8y0ulcgLVOW
         hceA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: meson64: relocate config_distro_bootcmmd header
References: <CGME20201102030646epcas1p35d5804491644c065158d5aa91238f154@epcas1p3.samsung.com>
 <20201102030706.2577-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <cf30389d-66f6-5d45-5f8a-c590bcc72ed0@baylibre.com>
Date: Mon, 2 Nov 2020 09:40:39 +0100
MIME-Version: 1.0
In-Reply-To: <20201102030706.2577-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 02/11/2020 04:07, Jaehoon Chung wrote:
> Relocate a config_distro_bootcmd header before defined
> CONFIG_EXTRA_ENV_SETTINGS. Otherwise it can't change to specific
> environment.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  include/configs/meson64.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index cee690068022..52cc01f73da3 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -69,6 +69,8 @@
>  	func(DHCP, dhcp, na)
>  #endif
>  
> +#include <config_distro_bootcmd.h>
> +
>  #ifndef CONFIG_EXTRA_ENV_SETTINGS
>  #define CONFIG_EXTRA_ENV_SETTINGS \
>  	"stdin=" STDIN_CFG "\0" \
> @@ -83,6 +85,5 @@
>  	BOOTENV
>  #endif
>  
> -#include <config_distro_bootcmd.h>
>  
>  #endif /* __MESON64_CONFIG_H */
> 

Thanks,
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
