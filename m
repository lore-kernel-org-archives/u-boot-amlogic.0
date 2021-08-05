Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.11205.1628180482061339185
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:22 -0700
Received: by mail-wr1-f49.google.com with SMTP id m12so7294932wru.12
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mhM35GL2SxKZGLDHQGON9ixc3vTkAi3Znon/s7podHY=;
        b=ink3DPX6iucPro+rYD2r6/wW22feBkr7DrdygDKLU/Go032ClyLglUWnIjkzR6wvr+
         5tSWe06TLSnnPqjS3vQvoxtXpnBR0k74FALR16cCLg0j70TbS/MybHgNoNF/QPHbg/By
         VTr0xBZKkYRR7CzdFlz+gRIQbcW6B6qy9zdMsDJU3CO6GBXwbm3YxehDHwpLYRlTD+NN
         FZvGolW0tUdhDjKvyeIn95ldaCJrHyoyHi7jw/a1duVIPlTXNbmlRxXHUeBi71i6GWax
         epn2buzfgWl5JAvzGpwu4CtNLz0yS3KMsIxBh1N+c9ZY7/yGONneAXXH98Wg0LwviLlo
         gW1Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 7/9] configs: sei510/sei610: reformat PARTS_default
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-8-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <624f0bcb-89df-c3a7-3baf-a082c22208fc@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:09 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-8-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> There is a mix of spaces and tabs at the leading \. This makes updating
> theses lines harder.
> 
> Add a single space before each \ for some consistency.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/sei510.h | 14 +++++++-------
>  include/configs/sei610.h | 14 +++++++-------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/configs/sei510.h b/include/configs/sei510.h
> index d37b4c6405..16a34c717d 100644
> --- a/include/configs/sei510.h
> +++ b/include/configs/sei510.h
> @@ -16,14 +16,14 @@
>  #define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
> -#define PARTS_DEFAULT                                        \
> -	"uuid_disk=${uuid_gpt_disk};"  			\
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=logo,size=2M,uuid=" LOGO_UUID             \
> -	"name=cache,size=256M,uuid=" CACHE_UUID             \
> -	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
> -	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
> -	"name=userdata,size=5341M,uuid=" USERDATA_UUID	\
> +	"name=logo,size=2M,uuid=" LOGO_UUID \
> +	"name=cache,size=256M,uuid=" CACHE_UUID \
> +	"name=system,size=1536M,uuid=" SYSTEM_UUID \
> +	"name=vendor,size=256M,uuid=" VENDOR_UUID \
> +	"name=userdata,size=5341M,uuid=" USERDATA_UUID \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  
> diff --git a/include/configs/sei610.h b/include/configs/sei610.h
> index 9eeffdd72c..6d13fd143b 100644
> --- a/include/configs/sei610.h
> +++ b/include/configs/sei610.h
> @@ -16,14 +16,14 @@
>  #define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
> -#define PARTS_DEFAULT                                        \
> -	"uuid_disk=${uuid_gpt_disk};"  			\
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=logo,size=2M,uuid=" LOGO_UUID             \
> -	"name=cache,size=256M,uuid=" CACHE_UUID             \
> -	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
> -	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
> -	"name=userdata,size=12795M,uuid=" USERDATA_UUID	\
> +	"name=logo,size=2M,uuid=" LOGO_UUID \
> +	"name=cache,size=256M,uuid=" CACHE_UUID \
> +	"name=system,size=1536M,uuid=" SYSTEM_UUID \
> +	"name=vendor,size=256M,uuid=" VENDOR_UUID \
> +	"name=userdata,size=12795M,uuid=" USERDATA_UUID \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  #include <configs/meson64_android.h>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
