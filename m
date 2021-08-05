Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.11149.1628180485122838067
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:25 -0700
Received: by mail-wr1-f44.google.com with SMTP id k4so7361117wrc.0
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fa0bCi+nMZwdvl0JGiq/xnCLA8kHcEM6oi2gZrLXVJ0=;
        b=h6OG6qqGzsM4Ubg3o/euTlVPPtdQ+nBTnAS3ZTOEQ6EVYGEmJ7MPUxtUqMGzWIExsR
         sxwDu05Ifbr/CNwGWcyEOX+Zl59EHU4C6a/ZuMm1Rq0geqKMh8F1Mc9e+v+SX+fcstrK
         kpsJoIne8kB9rhqqrNjQeYGncO4tEGYhm0a/x+uliotnMB8kmOPUno+RjrZDpghd6iDb
         EKKE+OSuw4vmbhjq4+1EE2quZBPYNXA9XgS4GCHwdJNdyxjAmlA/uWa8nHErv+Tf0YwK
         yd8ZHab/lAb8qGS+sQSdF7mAfYJ00zFaRfvg9hwF+US+0MfIk1EikgMWTgiKWAfB5xwH
         BfOA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 8/9] configs: sei510/sei610: don't use hard-coded gpt uuids
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-9-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1169860d-7030-fb83-bb48-5dc47ad908a3@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:12 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-9-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> doc/README.gpt states:
> 
>> The fields 'uuid' and 'uuid_disk' are optional if CONFIG_RANDOM_UUID is
>> enabled. A random uuid will be used if omitted or they point to an empty/
>> non-existent environment variable. The environment variable will be
>> set to the generated UUID.  The 'gpt guid' command reads the current
>> value of the uuid_disk from the GPT.
> 
> Since we have CONFIG_RANDOM_UUID=y, remove the hard-coded uuids
> and use meaningful variable names instead.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/sei510.h | 12 ++++--------
>  include/configs/sei610.h | 12 ++++--------
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/include/configs/sei510.h b/include/configs/sei510.h
> index 16a34c717d..5bf2668803 100644
> --- a/include/configs/sei510.h
> +++ b/include/configs/sei510.h
> @@ -10,20 +10,16 @@
>  #define __CONFIG_H
>  
>  #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
> -#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
> -#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
> -#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
> -#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
>  	"name=logo,size=2M,uuid=" LOGO_UUID \
> -	"name=cache,size=256M,uuid=" CACHE_UUID \
> -	"name=system,size=1536M,uuid=" SYSTEM_UUID \
> -	"name=vendor,size=256M,uuid=" VENDOR_UUID \
> -	"name=userdata,size=5341M,uuid=" USERDATA_UUID \
> +	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> +	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
> +	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
> +	"name=userdata,size=5341M,uuid={uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  
> diff --git a/include/configs/sei610.h b/include/configs/sei610.h
> index 6d13fd143b..baace75a02 100644
> --- a/include/configs/sei610.h
> +++ b/include/configs/sei610.h
> @@ -10,20 +10,16 @@
>  #define __CONFIG_H
>  
>  #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
> -#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
> -#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
> -#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
> -#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
>  	"name=logo,size=2M,uuid=" LOGO_UUID \
> -	"name=cache,size=256M,uuid=" CACHE_UUID \
> -	"name=system,size=1536M,uuid=" SYSTEM_UUID \
> -	"name=vendor,size=256M,uuid=" VENDOR_UUID \
> -	"name=userdata,size=12795M,uuid=" USERDATA_UUID \
> +	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> +	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
> +	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
> +	"name=userdata,size=12795M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  #include <configs/meson64_android.h>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
