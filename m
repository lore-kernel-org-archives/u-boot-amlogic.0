Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498FDD2C54B
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 12:56:25 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.17497.1729601782089722595
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 05:56:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=DlFbvzsM;
 spf=pass (domain: baylibre.com, ip: 209.85.128.47, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431616c23b5so28288045e9.0
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601780; x=1730206580; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnNtK7N/98RDsZJ/GZKkZgrYYLQdsPv9TL7fYQGchrQ=;
        b=DlFbvzsMJsz6iDTqLERPTDq0BaFmbH1q1/o1AAh+KVTgxkbsMmatQkmFnAHffBsa6c
         uF9BpSFWjcf+mNywxSWF0yakonUumGmzBKdvWgFh2rHSnaT7s4mvf/Y8XWeO6Hx8NCO+
         tdj54jAd+ENjY0ZLnBdIzkABmJvNuawoeeZo3Fbr3BWUkwEgCr2omMf0tTIGyUT+JtYB
         1LKnv0BtsRgMdsO6irq4GaVBUgsrSxfjsZuvQ5zbOPl++b0g/+nygKkeWEFvIJ/Fy6Ri
         KG2m/retjBCFvf639EbHN+Zxl3wMlOHjRiyWtwZiR6/hPwj8xt+01cTrhQTNI4RsINcH
         4rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601780; x=1730206580;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnNtK7N/98RDsZJ/GZKkZgrYYLQdsPv9TL7fYQGchrQ=;
        b=mNuxpYT8nFcZP9tkXUNWtUYiVfwUebIIKqL5jvdHTNR2u98kxMEMi04tD0qnq7CTY7
         9kzQ6a+q26xA5lQsV7LZqMUloR+raZQvBiJEsAwGLTGBbvY/P2w375JHGoN+UEQyjWBR
         /dcSeIpasfnrD/cVmW0sNg1nlS8nmlxnDrLWbYgIi5myGD/OfOjyM/+wIbcZdFUaKy+q
         DQzXA2sr1cGzF1/Rfxs/iiX7UUokd3ha1GvwfPDVFk+IzHZKsGSQ+hnoD3P0W8TwxP76
         mN9Gjj0yvDhPfXNytS1doWjhcdkNPpi5J/8fdySgf5xZ9YOAj77hM+NNf/qDocIho92Y
         f5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWYrZNnLTCi67S4JM6ae9j5JsPLoqGmsDnrsarmikTZbr2CyU4bAGSwdl1J6XLojaiAs/cOxdkGDAfxcGkJaA==@groups.io
X-Gm-Message-State: AOJu0YwD1eO6GWjdGv2pGC3TfGfHN6ccSDzG48JfE33k6atmUXt21hRz
	IXdBP1jsxr+dy/Kv3Qm10tcxkcLXUxZAW8pbWmduvTlxqMAuOOo5OswuBivkeirFLoQP5s8BxUU
	Q
X-Google-Smtp-Source: AGHT+IGWOe/hCdE2hhTD3wH9tbT4N8YjZeJD4b6dr7JQIwGRytnUTd3c3wh71lXdr8aQVZcCUUpMKg==
X-Received: by 2002:a05:600c:5250:b0:431:3b80:6ca7 with SMTP id 5b1f17b1804b1-4317be9ced7mr19937815e9.13.1729601780344;
        Tue, 22 Oct 2024 05:56:20 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc596sm86731165e9.44.2024.10.22.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:56:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 6/6] bootstd: Add test for Android boot image v2
In-Reply-To: <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:56:17 +0200
Message-ID: <87v7xkuwi6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 12:56:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2516

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Rename actual android bootmethod test to specify it's for boot image
> version 4.
> Add a unit test for testing the Android bootmethod with boot image
> version 2.
>
> This requires another mmc image (mmc8) to contain the following
> partitions:
> - misc: contains the Bootloader Control Block (BCB)
> - boot_a: contains a fake generic kernel image
>
> we can test this with:
>
> $ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc8.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts | 10 +++++++++-
>  test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
>  test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 9bf44ae3b0bc..108633a727f9 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -44,6 +44,7 @@
>  		mmc5 = "/mmc5";
>  		mmc6 = "/mmc6";
>  		mmc7 = "/mmc7";
> +		mmc8 = "/mmc8";
>  		pci0 = &pci0;
>  		pci1 = &pci1;
>  		pci2 = &pci2;
> @@ -1135,13 +1136,20 @@
>  		filename = "mmc6.img";
>  	};
>  
> -	/* This is used for Android tests */
> +	/* This is used for Android tests image v4 tests */

Nit: we are repeating "tests" twice here.
Maybe rephrase to "This is used for Android boot image v4 tests" ?

With the nit addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[...]

>  	mmc7 {
>
> -- 
> 2.34.1

