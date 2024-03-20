Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF3CD11DB
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:20:51 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.37039.1710912525300183531
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Mar 2024 22:28:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yAPGVIIm;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: dan.carpenter@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4146562a839so10164865e9.1
        for <u-boot-amlogic@groups.io>; Tue, 19 Mar 2024 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710912523; x=1711517323; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDlOrCVKQ+OXTfLpu6C8wdEc8MeG0rYfIu4Amm4kBmk=;
        b=yAPGVIImJoQtny0WKSfpp/l3X74RE+OXfz31TX+M1fVIPu9eTwihcZCuQNfPpieCU4
         KlJpjNtX4q/Gr59SeQNsC4+6dMRU6cg6SVCb+EtFvzL7WUDEharbXI8vQJ5Ekoht9ple
         BIaX9lWmJ4WAITL5g2SWwDqC0ZM9HbUgM1Jpgu8XmOUmXxy2ij1CudYgcjgNoucuQqY9
         hmtvv5V7KEDi/fW2fhQOJv2hCkDiLZEsA13b05dTBPpLjRStuFh/EMaMEh5c4RCiBJyY
         JxPEK2Z5MTmVybobeGRFa/GgMlrPt50E/8p3vvljcSBgFxNZ0+tNKCC+uZ1e8qEOJSwo
         qdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710912523; x=1711517323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDlOrCVKQ+OXTfLpu6C8wdEc8MeG0rYfIu4Amm4kBmk=;
        b=eVgQUvoEVu7j5x5fN0PC7f9R8Muqd+Wd5zyErqTU3jHzDKtXNAz9SdAeSvDGe5fUWg
         K3X2BKplJdUax6sCFIoylJ5obm8BYvJbsVJrPwxQyqR3Gd2MN7P9bc//FF2U9Pz9aJbB
         82QJEwqFqI/iYeiCudvxxfaa1uEIp1zqX2JocQ7Uel/8O1Ni/X2/2KGx7Obne4zMOIZc
         jexOPSEk2U3/1jrTXIuzGS06TzWBIU7KEX9Vj+OJ6gaC0CtP+/83lNnSc5d+GOJA73jU
         /sLGLuICaI1h9CC3OddEU7t1rNnkZgDhRP016NYue6c7K6UVVcY0M9G3u+y6nLeXnzV2
         H0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW5R8GWV0WikFDjpmBOsmWDz30lUrH4gy+NKKmYWwJJHWTekQqfgu/6AwYoAva5G5u84fjnupIuCiALf0gbMPkKB77kw5Bwrfc=
X-Gm-Message-State: AOJu0YxLlstt7Y0fvRqd5wVfHPWbmzaVQaHY1e0xiCjysE8FtZZOM6HF
	8sdFDW0R7QnBT74SQM6RgZskhg30xXDsJfv2Wqdo19FhSBdmzdGVTAHbhnyZGqw=
X-Google-Smtp-Source: AGHT+IF+ctcB7UXGdCvuK0N+Be6HmNKhq4wEpi1PA5nc2ZGKWgz4cfX+PFWGZjALPU6lgNdrX8XDiw==
X-Received: by 2002:a05:6000:544:b0:33e:bf0f:8156 with SMTP id b4-20020a056000054400b0033ebf0f8156mr2922372wrf.38.1710912521517;
        Tue, 19 Mar 2024 22:28:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033e79eca6dfsm13781217wrm.50.2024.03.19.22.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:28:41 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:28:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: Re: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
Message-ID: <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
References: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:20:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2210

On Tue, Mar 19, 2024 at 03:53:24PM +0100, Neil Armstrong wrote:
> While meson_sm_read_efuse() doesn't overflow, the string is not
> zero terminated and env_set() will buffer overflow and add random
> characters to environment.
> 

In the Linux kernel we would give this a CVE because it's information
disclosure bug...

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  board/amlogic/jethub-j80/jethub-j80.c | 6 ++++--
>  board/amlogic/p200/p200.c             | 3 ++-
>  board/amlogic/p201/p201.c             | 3 ++-
>  board/amlogic/p212/p212.c             | 3 ++-
>  board/amlogic/q200/q200.c             | 3 ++-
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
> index 185880de13..d10492cc46 100644
> --- a/board/amlogic/jethub-j80/jethub-j80.c
> +++ b/board/amlogic/jethub-j80/jethub-j80.c
> @@ -28,8 +28,8 @@
>  int misc_init_r(void)
>  {
>  	u8 mac_addr[EFUSE_MAC_SIZE];
           ^^^^^^^^^^^^^^^^^^^^^^^^

This one is also a problem.  You can't pass non-terminated strings to
eth_env_set_enetaddr().  We call strlen() on it in either hsearch_r() or
env_get_from_linear().

All the other functions had a mac_addr[] issue as well.

Btw, this kind of bug is a good candidate for a static checker warning.
I can create a Smatch check for this.  It would probably be easier in
Coccinelle even, but I'm the Smatch maintainer.

regards,
dan carpenter


> -	char serial[EFUSE_SN_SIZE];
> -	char usid[EFUSE_USID_SIZE];
> +	char serial[EFUSE_SN_SIZE + 1];
> +	char usid[EFUSE_USID_SIZE + 1];
>  	ssize_t len;
>  	unsigned int adcval;
>  	int ret;
> @@ -46,6 +46,7 @@ int misc_init_r(void)
>  	if (!env_get("serial")) {
>  		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>  					  EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>  		if (len == EFUSE_SN_SIZE)
>  			env_set("serial", serial);


