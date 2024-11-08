Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92ED5E14C
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 10:06:04 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.9493.1731060357431900471
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Nov 2024 02:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=w6JW5loh;
 spf=pass (domain: baylibre.com, ip: 209.85.221.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1617276f8f.3
        for <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731060356; x=1731665156; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPuxFq8G86F7ZxNsbKsWivHGDnFjqFoOZEWGV2yLJM0=;
        b=w6JW5loh/wXgU0CrJoeECoe4irCrrVDZNzFfUHD+dj28qT6JTKtvP/R/zWtY2fSIDO
         6MzUx9yumw5AnjsfRmqdkgoq09OqIjSYcbSVkehmO/7ef2N40AmSgt+9BVJoVXoyVzex
         79uiNgn50fyYG8rMmQeDtAcYPaU3H5URv9tLnCKVulp0bslgOOsvgUQfig4uoR5bZBd9
         4uWtMTT/FDwK3j6ApufFKEcU3grjUOrX9nAIHtfRxZOwOMj3cXi3ZTVbXlM7vc78ShaT
         zuflqU9QJaEJ6NB+hRYfQQ+9u3xxouyoEKHbYkx5P25FZLYgivAUv84HA2UtfU1rnrxG
         0hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060356; x=1731665156;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPuxFq8G86F7ZxNsbKsWivHGDnFjqFoOZEWGV2yLJM0=;
        b=ul94Nyja63WH0IsOjjPeq59nxxsY7+s03Jm8Odt1Gda/aOzuIlqIx6n1yM8EFgXV1w
         bKoSkYXBLYxDpel21hAjak86aqh4cphx5/bS7qzDsZ1pEtavVwFOFPmxFTzG/XZdXzrH
         D+jzONd/4VtJX/iqTt/IarXqWcGfOwRqUdxnIc4dqd5CWi17SUmpWQHxgBpQedQqPoyq
         MUJEzgE77+nDT4Sn1uaVidXqmqpIMtlT+i4mzb+TURSr1ZRRcmPNDYCwq8M0qJZ0rQUs
         iSlpdxOue1C14wefDxFB/o6KWQj912x5uKZt+0dB+V9vUlLh2d2GJEY8fv8o2KvamecU
         K2vA==
X-Forwarded-Encrypted: i=1; AJvYcCWRd+blijkOpKLQnvOCbN5aeHOtdwo+asOCVs8DUSjOeMBfYpLBsnOby8/Rz+SNEdKms5gLssM3odLLc4xIHA==@groups.io
X-Gm-Message-State: AOJu0YzsE+riL2BBS8D7hQ2hVPy840pQM2gCk6HQMwPbrIPzFwwVeg7F
	PZQG6hlTLCeM8Z/1f7FzUSpmrGmcPJ+ElktPHQvyVVva7AcwuDGZUXx1YSmYLJU=
X-Google-Smtp-Source: AGHT+IGNnPl5Tmu1YJYr6nRRLnkObvWpHZIwsm4ck1eS3tsGXjw2aLz42dJpARgc+JCP/TuTQwYvig==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21c0 with SMTP id ffacd0b85a97d-381f44325f1mr425429f8f.57.1731060355548;
        Fri, 08 Nov 2024 02:05:55 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c0414sm91976965e9.23.2024.11.08.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:55 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
In-Reply-To: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
Date: Fri, 08 Nov 2024 11:05:51 +0100
Message-ID: <87msia3urk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 10:06:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2537

Hi Neil,

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
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---

Do you think you can pick up just this patch ([3/6])?

Since it's a fixing a regression that I introduced I'd like this to
picked up without depending on the rest of the series.

Thanks!
Mattijs

>  include/configs/khadas-vim3_android.h  | 4 ++--
>  include/configs/khadas-vim3l_android.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

[...]

