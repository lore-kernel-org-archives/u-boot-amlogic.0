Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26679D2C548
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 12:25:45 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.16937.1729599935046366033
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 05:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=X3t2dgbI;
 spf=pass (domain: baylibre.com, ip: 209.85.128.44, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316cce103dso40446525e9.3
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729599933; x=1730204733; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BN1cq1ezvaxG8SfZXlwBk9V9+LLKWRfaF8sFXT4q+VI=;
        b=X3t2dgbIH//LiRa5pLbSYUipe6NsOd6CbmUyPiKA59mqY2NU62GqO8Pdz5dKGKMzJj
         j/ZnGkvolVksuQ9cl76uvCOYZFQsKn97J33QcpLcyjbAVbwhQ3IeQKKgT+HAElvvPG/A
         sOK6p8DIBWn0rnhAsQHBTVc3ZeYBLQSWJITQ/aa5XASrXdrRVWAmOeFg6I11LmlLv9Bd
         OppgQjagM6SJ251rF6HkMoLvkSeyL3DdyxwN5IigPsLywReYwgVDck76U8YLSNTdrCw4
         jBFmCujiyxn/aLcNYESItDQiogNgWqg+rjpfpujmJ5MxLUKXByLqStF1RnSkrsfoOLKO
         wZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729599933; x=1730204733;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN1cq1ezvaxG8SfZXlwBk9V9+LLKWRfaF8sFXT4q+VI=;
        b=NOLoL/Lhg5CBJ4vi9YZQivs8z8jH5tg58iig3hoAH7rqggqYuKn4gUCqdnf4Dc7Mce
         9PhYTw1JwSlrGY3cZpJsPCNz+i4Y1rJ0rvc6Y/1JTDSqmDj0vbzwhxKveqiSeIGgJIYh
         41eZP2yC355+iLv56dApYQwT5dw9Gof83S+0u2mNVO/3JDcH3YdHo4s2uCHQJpLjLKZz
         ZTiqCYnVfZeUKd/qgwAWJ9j2I+aLnNnJf72J3NP/KNx4h72MW6BvAwn/v528KL4csrw6
         0IyIALtdFJXbZQDrpYwYkWPIVTeUaebvg4eUzppKSGXAAbivMP1lfhJvCuCbCqQtTMsA
         8q+g==
X-Forwarded-Encrypted: i=1; AJvYcCVu+IZOOM+oLmW06FGCUjKCQYSg29Y/s6hUmD4Y1wm5P8EYKO5BS8F3lf26R+82TytepT4QS/gy3jHXZZ8xrg==@groups.io
X-Gm-Message-State: AOJu0YxhpFs2MiYRnYaOU6wl9NEl3p9KMqE4eQWGpPBlP/3yaRyFvd2a
	O5f9F4VOY0PXFQzpjnU/s/TL1HjNMBxDM/C17bz/oaZy6IJw2QsrCagDu4DevEM=
X-Google-Smtp-Source: AGHT+IFHRoAkrwpTQgIZQ6fMn3C8qngS1fJEMk+tgfz0Pm4NBpc+T2sVMEupX+2OQyEbLkF8FDdJFA==
X-Received: by 2002:a5d:4f84:0:b0:37d:46fa:d1d7 with SMTP id ffacd0b85a97d-37eb486acc3mr12691485f8f.57.1729599933201;
        Tue, 22 Oct 2024 05:25:33 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ef1sm330077566b.38.2024.10.22.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:25:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
In-Reply-To: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:25:26 +0200
Message-ID: <874j54wci1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 12:25:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2513

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> After increase boot and recovery partition userdata was not resize.
> so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
> $partitions` fail because end of last partition is outside of eMMC
> size.
>
> Remove 64MB on userdata partitions to fix it.
>
> Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
> partition size")

nitpick: Fixes should be a single line.

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

When making the patch, I was not aware that VIM3 had 2 models with
different eMMC sizes:
- VIM3 (Basic) with 16GB of eMMC
- VIM3 Pro with 32GB of eMMC

I of course have the VIM3 pro so I did not notice this regression.

Sorry about this.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  include/configs/khadas-vim3_android.h  | 4 ++--
>  include/configs/khadas-vim3l_android.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index fc89efb4c36e..0e2953fe71b3 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -24,7 +24,7 @@
>  	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
>  	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #else
>  #define PARTS_DEFAULT \
> @@ -37,7 +37,7 @@
>  	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
>  
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index 5b2aed1cf62a..f39a3782d663 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -24,7 +24,7 @@
>  	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
>  	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #else
>  #define PARTS_DEFAULT \
> @@ -37,7 +37,7 @@
>  	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
>  
>
> -- 
> 2.34.1

