Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.7234.1627550509265398929
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:21:49 -0700
Received: by mail-wm1-f47.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso3552622wmp.1
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXfjhv1ZCuD/1ur7iXk8faWegrrCU/nOLj3jkzp/f0o=;
        b=wqaq5P7x2/EIYWyC+LufhfIY8oSgwZ8NI8iQSt+y1l/xiG36TmVJJiW4Pvk95sb+9B
         LbJKpctGG79/W+jXeoW4GAJZgo/0P9HSQQVjieBrf0L+FB8dXcCWwgWL6H2VHw1MEot4
         v5OLOrfmTu1Q1wkV2HhlSbx7x0/KH9mKO5DG5k0tM+VMl34c1lO/QJyy62P6BFZ8txSR
         PL8VG6f9r5fWYB9Baxs9cEQmY2mcrp1VA86qodwjpjgIkDOYaay5C2JIHG+C7iatk8+y
         PZvWts9jFd9ObkYlCtnRrNGrd3NbzftDWKxSXnH/d33h6/Q4b5ZhFhwjfhh2ejCqUIO2
         X/4A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/6] configs: sei610: fix typo in header comment
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-2-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <276503c4-1190-f526-609e-b1d9fac7d31a@baylibre.com>
Date: Thu, 29 Jul 2021 11:21:47 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-2-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> s/510/610/
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/sei610.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/sei610.h b/include/configs/sei610.h
> index 6d093161c9..9eeffdd72c 100644
> --- a/include/configs/sei610.h
> +++ b/include/configs/sei610.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Configuration for the SEI510
> + * Configuration for the SEI610
>   *
>   * Copyright (C) 2019 Baylibre, SAS
>   * Author: Jerome Brunet <jbrunet@baylibre.com>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
