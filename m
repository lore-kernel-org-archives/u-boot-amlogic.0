Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065CD6207C
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 17:21:21 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.27303.1732036874191671962
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 09:21:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=WwbobcwJ;
 spf=pass (domain: baylibre.com, ip: 209.85.128.41, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so28425e9.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732036872; x=1732641672; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyiOIRxu2XVeE05fIFWzY8AymSfRDSGGx1SqnKQW1hw=;
        b=WwbobcwJuKBnnTcsRuwTb76JmDMG+UTS/i9Pya7USLYEBZReK8mcvkn+uLPWc5e5qX
         oGSJ+Ae4ZfS/2diEt9wpFn04dSVjS4j+ISfMNMz4bFTvVUXSKunpxjkzYXKA1eEP30RW
         HR1bRtnYkUvepKD91+ty4zh0dMVGKsRCUlgihz9sLKZRE1sxDeEOSRtB9RNX+NBCJ3OC
         ejrbWkQPidcJ9HiAbq9X/zYPkTIH2KGWL8CtN+LrbxQBUhINJB46mBSNg8VXErDJCfQ0
         +/8m6gigeHcHcZ0e11+8KtuXCxLzgTfwAG+7CCxlqlj6jWsvJxNA5QtR5WIKGptRSD6J
         CA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036872; x=1732641672;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyiOIRxu2XVeE05fIFWzY8AymSfRDSGGx1SqnKQW1hw=;
        b=ewoI2c5zZtTyO1PoLw6vDMCm7dLes9IDC0g9nQHaKVLRSYOP3y/426DU/5/Ppt7wAb
         r3aoiC7tudTCPmHtQxMCUZJRxjOsITuiSG9DLGcVZZSjaWmyegc5CPC650+/q/iBHtp2
         JkZxVgwbB4RyOXB+K01hLtRjP9UeSxNSfJvoFuz+CWgjxHuKkO3MFxaLB9IoeV897Flp
         nXBCaaULK4b1vC1yRle8ljmjxK3jGkUv6a1nPSkeZvOWzGOm6MH9YA7ff5lrASCJa37U
         y71EvXpKEAa14n4O9z8tt6wbC7Qmv5DdV7v5avJGhUGznabb+7L0TSfUb5bMkbxmxdds
         1P6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIWn9vVd4PYlR9gVdE4h/vLav1Ox2m3qPV0FJkhdKCZ05Q2pOUCRlTByEWB4+TEjvJPV52TV2FQHR5WfGHxQ==@groups.io
X-Gm-Message-State: AOJu0YwPx8sW1P24ahi5Vq4GyMCXlCst4+E/wWDdwHYOUu6OuF2SiMQj
	27rC4tvJDoavGBMmZSfNU34ouFQXiTFnrX7cKMkcImobfJ5uImiSrOIWFozWz/E=
X-Google-Smtp-Source: AGHT+IGqfy+lWRefSC4ejNiuylZ5kNAipR7ZGojlGieSVTyp7qXVtSQuCgREjg4t4i7wal2OXXTKpA==
X-Received: by 2002:a05:600c:4fce:b0:431:7ccd:ff8a with SMTP id 5b1f17b1804b1-432f57df971mr37285705e9.14.1732036872449;
        Tue, 19 Nov 2024 09:21:12 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28bc11sm200968415e9.31.2024.11.19.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:21:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
Date: Tue, 19 Nov 2024 18:21:08 +0100
Message-ID: <87mshvxhq3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 17:21:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2574

Hi Guillaume,

On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi,
>
> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>> Actually bootmethod android only support android boot image version 4
>> and with AB image, some old platform wtill use android boot image
>> version 2 with AB or without AB slot.
>> 
>> This patchset add support of both version 2 and non-AB slot images.
>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/5] bootstd: android: add support of bootimage v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
> [2/5] bootstd: android: add non-A/B image support
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
> [5/5] bootstd: Add test for Android boot image v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a

CI has found some issues when applying these series:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452

Could you have a look please?

Thanks!

>
> --
> Mattijs

