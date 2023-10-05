Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.13882.1696508874418319454
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 05:27:54 -0700
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-405524e6768so8364245e9.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Oct 2023 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696508873; x=1697113673; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIDgibJIkeo2ZcyBvv+ediHwi4mDal+OhzVvyCat8ZM=;
        b=ArrdU5DjtaM4ml7PCtRvxnV6GTfLWI/36W52eZZ+/GvbbXNImtsJ/b4QtEO8W0Y5EP
         Kh1nm354M0PR1Xg1CIUbjSqnkk82jA09NO9Imr5uoqYRdkulrgyikPVgb4OKgelEblv2
         Ue6Rrzz4FYNjS9Irf6v39iOAPjBUqsE2sxTj2vFxWUmPbtZBAIH8XI0z39Jk/oJ9uNGi
         JGzSYdLlCYuF/kFNbcXG5o2SOOA6n1o1I5+c6DICby0JhakyerFR2NN9Oct+gzWGduwl
         ZTiUIiKczEinjpR+8tZJvTcdO13E3rMGC+fHK+dAry1zk24PUCTIHE9eX5Bh1Se03Whe
         3+cQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3782b09f-8279-4c66-b7f6-7115ee8ce79b@linaro.org>
Date: Thu, 5 Oct 2023 14:27:51 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: sm: fix build warning
References: <20231005081936.72178-1-avromanov@salutedevices.com>
In-Reply-To: <20231005081936.72178-1-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/10/2023 10:19, Alexey Romanov wrote:
> This fixes following warning during u-boot build:
> WARNING: unmet direct dependencies detected for MESON_SM
>    Depends on [n]: SM [=n]
>    Selected by [y]:
>    - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
> 
> Fixes: 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/sm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index b4cc3f768e..f0987275d2 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -3,7 +3,7 @@ config SM
>   
>   config MESON_SM
>   	bool "Amlogic Secure Monitor driver"
> -	depends on SM
> +	select SM
>   	default n
>   	help
>   	  Say y here to enable the Amlogic secure monitor driver.

Thanks,

Squashed into 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")

Neil
