Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5ABCF2564
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 11:05:19 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8810.1728731112307771074
 for <u-boot-amlogic@groups.io>;
 Sat, 12 Oct 2024 04:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=YhcbwMoc;
 spf=pass (domain: baylibre.com, ip: 209.85.128.44, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4311e470fdaso12903385e9.3
        for <u-boot-amlogic@groups.io>; Sat, 12 Oct 2024 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728731111; x=1729335911; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrLx217Q/yikaZugYKAAmEkE2SP6n1WsqiWlkkB8bsM=;
        b=YhcbwMocNp7OaX9AZjQsMDJdgy+TrQlDSu49GUYWaRuKa2MyM1kmsPGJxW0UDl1cFI
         cPNv675DolZuW4nn3z9q7Lj4z0kIyybX5envDm3Ox6N4inJR2FKuTm/jFzVIy4j6MWfU
         7F/KinWF1AWETJuYEADW5meFwbfLxI20HfTnfAO+I9UnQziU5tnIWXOos92I8z5McsfZ
         UFTHn2rdUMtYja2mEJY35quQwlmKZUUs7ko+CpZa3da2UW/IrjlX6A4Si2Y2uacHQPcu
         oVA7Z2zTTApkHvqbMmtk8x5Fpo1mR79q15EW4+WczSofuGZhb7xGzkOpNmammm1RQkQa
         ex5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728731111; x=1729335911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrLx217Q/yikaZugYKAAmEkE2SP6n1WsqiWlkkB8bsM=;
        b=rpRxk/+Be9GYcPDpVJ0wSozRBU3oDvCX/D1K52qj9cMHy5WD0KEodFW5e7Yfcz3soc
         idu5FNCv0Gkx04n2g6dqnXtObm+SsYqhzgpByuhJG8RVoDdIP/oJ7ZQSb6TkfrtBwDQ+
         fKwwkyw0HlZqSo25x1Vhhvk2eTQkcucBBjXlZq/HhwQPYIlM06j4pI/KdqBX89JcyyHO
         jJKBcSbj3DVf7PbKCCT2FtaS6GTfDFgWspbAQ/hIV1i4VyqO3wtEy9TFbTDEgWqPIMdV
         kb4+ONii5FOy0faCbaFsPiwO97eDLazlJ/pnwFicSp52jLSw407fwBc6z/ki9ar/WnuA
         V5jg==
X-Forwarded-Encrypted: i=1; AJvYcCV8YgC1EBjLBd0ESRzWnv1t5uZ3lWdF76Ly2d2lcoig7HjsNh55yqdCMgT4Nad7gECTC80jDWsnLGjA03WSnw==@groups.io
X-Gm-Message-State: AOJu0YxEmSrDSjP8E6v0ty3rlh2JTzEa79rKELEkuB7xn+4FrLxI2z2p
	U9u9r5Kgq6bthv9nFkf2RV4Hrvl3fIjNV/rbvzOXMV6VTJjcEn3EfMg9Q0uGsso=
X-Google-Smtp-Source: AGHT+IHRmmaxscQPORhnIFWEPaU3isMnjsn8pU/7RlfOpnd402abQF2c5RsRxVvXORMd25BDyPBOjA==
X-Received: by 2002:a05:600c:5117:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4311dee59aamr53162665e9.16.1728731110648;
        Sat, 12 Oct 2024 04:05:10 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:e40:30d4:b1ee:f034? ([2a05:6e02:10a5:e010:e40:30d4:b1ee:f034])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4b1a0sm96163375e9.14.2024.10.12.04.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 04:05:10 -0700 (PDT)
Message-ID: <643e645b-01a4-4f51-8930-2e469a14a711@baylibre.com>
Date: Sat, 12 Oct 2024 13:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: khadas-vim3{l}: Increase boot/recovery
 partition size
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
 <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 12 Oct 2024 11:05:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2452

Hi,

Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> The Android Common Kernel is over 34MiB now [1]. This does not
> include any kernel modules nor the Android ramdisk.
>
> To make sure we are future proof, increase both recovery
> and boot partitions to 64 MiB.
>
> [1] https://source.android.com/docs/core/architecture/kernel/gki-android15-6_6-release-builds
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/configs/khadas-vim3_android.h  | 8 ++++----
>   include/configs/khadas-vim3l_android.h | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index da6adf6c413a..b76e049f09cc 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -21,8 +21,8 @@
>   	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
>   	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
>   	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> -	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> -	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>   	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
> @@ -33,8 +33,8 @@
>   	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
>   	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
>   	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> -	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>   	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>   	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index b1768e2d8211..0ab8ffd372a4 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -21,8 +21,8 @@
>   	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
>   	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
>   	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> -	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> -	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>   	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
> @@ -33,8 +33,8 @@
>   	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
>   	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
>   	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> -	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>   	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>   	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>


