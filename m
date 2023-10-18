Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4376CDB483
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 06:57:44 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.275892.1697612261002915400
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 23:57:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=rUyYYrba;
 spf=pass (domain: baylibre.com, ip: 209.85.128.54, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40651a726acso57251815e9.1
        for <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 23:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697612259; x=1698217059; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hC7gfFasRFf7e4n8J/wHOZ5LuE7ogVSxA0H+54ce7wg=;
        b=rUyYYrba/Fx2bVI1rLSfnNJ1dzuzyqjzRp4gQGfHb0yQJxMOOoYQMt4gWfOH4+fy4h
         g8rXD+up9ID5gpPWY2gfMbHY2PO0QimG3a2gOXjxMz8HqO9OPqt4C/Uy2wpnhL9gDiid
         bb7G8fOOfmiuBUh34GtzFCS1n2WOm6XL75pAokM+D07N2drkOGjQ9w+HU4vj3w2yOJLo
         mu40AWGe5FLNFaz/AhBqtQNiR4kvsEsCVVQ1GDzXYLIVrdaRtiw26hPQ0leRn+7EbK81
         QwV7N6OOARpOQv4SOOonz75zE78l66ZX0nqI69GeU/5U0Kr1FODh5fnEclEi+j6wth/R
         4ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612259; x=1698217059;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC7gfFasRFf7e4n8J/wHOZ5LuE7ogVSxA0H+54ce7wg=;
        b=nnZUVVnTPdGfWKwI0J+Gn9OI/wZkgHLp44upVnFDKV3FqNYz60A1CWbXGfEa4Gp2/Q
         DLAGdnW5+K3GnjFYkTrl52Gf86gBO7huGwJtMLl3zTtckB8KwXFfZcAApgeEti47xcyh
         9SQFNAwz6d2F8fOKkCATcHkNBadaVDdQJ4daXNt1ZmWKmmlsK1TLkvZYIkm6JhxeApwB
         MvnrGuc0AZEw/FyRyb6INz8YTHT3/lDBrvW2s3KIWbDccHZuDbaYYSysSX9OgMQvUJ52
         8D9fKFnptGIHieR16cRvKGOph1gwCIoxf4By3L6JscvZNkgyfW23CbHwWJjb+20O/uEP
         yzEQ==
X-Gm-Message-State: AOJu0Yz1ooKUkkdRw1CTYVldLygqocgC9tAzykoe2C/IdqNI+fiKu91/
	X0DwyHnsKPzciwiJ8ZU0iYGVSjTVTkLvxsUBkkM=
X-Google-Smtp-Source: AGHT+IEH45ub7TWEO9XQqWSBohIfOOEuZztbZ7h1jbI9Boj35Nsf9ZYS/6dueL8SAuL3VsqJbHKxqQ==
X-Received: by 2002:a5d:6045:0:b0:320:8e6:b0cf with SMTP id j5-20020a5d6045000000b0032008e6b0cfmr3279199wrt.42.1697612259110;
        Tue, 17 Oct 2023 23:57:39 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d6741000000b003200c918c81sm1362127wrw.112.2023.10.17.23.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:57:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, glaroque@baylibre.com, neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, avromanov@salutedevices.com
Subject: Re: [PATCH] phy: meson-g12a-usb2: fix ret check on power_domain_get
In-Reply-To: <20231017185725.809524-1-glaroque@baylibre.com>
References: <20231017185725.809524-1-glaroque@baylibre.com>
Date: Wed, 18 Oct 2023 08:57:37 +0200
Message-ID: <87v8b4xvry.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 06:57:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1777

On mar., oct. 17, 2023 at 20:57, "Guillaume La Roque" <glaroque@baylibre.com> wrote:

> Patch which add A1 SoC support create a regression on khadas vim3/vim3l
> boards when we try to use fastboot command:
>
>   => fastboot usb 0
>   failed to get power domain
>   failed to get power domain
>   No USB device found
>   USB init failed: -19
>
> Add ENOENT check on ret in probe function.
>
> Fixes: 5533c883ce10 ("phy: support Amlogic A1 family")
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Tested on vim3 with:

=> fastboot usb 0

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
>  drivers/phy/meson-g12a-usb2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 4ba3992bda70..3958d2404b85 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -328,12 +328,12 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>  
>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
>  	ret = power_domain_get(dev, &priv->pwrdm);
> -	if (ret < 0 && ret != -ENODEV) {
> -		pr_err("failed to get power domain\n");
> +	if (ret < 0 && ret != -ENODEV && ret != -ENOENT) {
> +		pr_err("failed to get power domain : %d\n", ret);
>  		return ret;
>  	}
>  
> -	if (ret != -ENODEV) {
> +	if (ret != -ENODEV && ret != -ENOENT) {
>  		ret = power_domain_on(&priv->pwrdm);
>  		if (ret < 0) {
>  			pr_err("failed to enable power domain\n");
> -- 
> 2.34.1
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1773): https://groups.io/g/u-boot-amlogic/message/1773
> Mute This Topic: https://groups.io/mt/102024645/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

