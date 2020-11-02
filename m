Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.28498.1604306444261616971
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Nov 2020 00:40:44 -0800
Received: by mail-wr1-f67.google.com with SMTP id w1so13542439wrm.4
        for <u-boot-amlogic@groups.io>; Mon, 02 Nov 2020 00:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iwdku80x9CEIaOlbWSB7o5KnKB4bL/eDDvime3x0cQ=;
        b=naj3LwM92SkshVVAYrOykhiwYx3T1HQAG7XXGQVNFFufxuIDMqWSzthACASH8o1B/V
         reQ+bL0pqJZq5Dj9LwJXsFZz1TRXumtkdJ6AkzAFQUVvhIpStaZ85fsSxqH1ieKyOzX0
         4AWLQW1MDvpJkJPnESS+hToyWBpX+O6eU24bD98AwdO8/iENYcNFdF623I53oBlb9tG7
         dyWacDwTt5jQ6kIWo6E8yBjp7OWjpB5+u1uh2qSdvVYlP//7YtGyhdB9T2kq2XvsWhfU
         7rFxpXsY74Ts8H1otPTH1qYuWT8afB0NMbqWO0A81++ekPxhtsFTeX/7tmg023QcESBI
         zqCQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: meson64: relocate config_distro_bootcmmd header
References: <CGME20201102030646epcas1p35d5804491644c065158d5aa91238f154@epcas1p3.samsung.com>
 <20201102030706.2577-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <138871c6-df9b-3208-47ac-eb50726314b8@baylibre.com>
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
