Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3536BD5E156
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 10:39:04 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.9843.1731062340632950883
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Nov 2024 02:39:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=SyELNlca;
 spf=pass (domain: baylibre.com, ip: 209.85.167.50, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2378616e87.0
        for <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731062339; x=1731667139; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChoqMoh2T+eig/XpTTE8Tcj5u81rqtdZXLhWcSY6EWc=;
        b=SyELNlcaYP4GwKHKbcmYjU3Em8kdqFa2d5m3pIIt9yevrGkx2T6W1s2y79Wq3Lqoi7
         46XeeirOyZiNZjYakapsfJGBPGQQ2fj8AA0jv+uRMx0Q/6zhfCQIfa3uEJixuRJ+rOGf
         +EmboS1xKWPu//MRhz7zh3psupCFVeBrpqcd9gQm18cu67KBU0O9M0H/IhYpl0AIRvqL
         V7H+QUknpaK9ExUVeiSMMO03QDgj4woMDFZoo5BRA3HeU98/zBay9Nn4Ig/hA9i8St3U
         rn5x5d4CRdyMUkEdQ3+TUJY5aprF44bQfa08fLLJFnomCKLAyOzapJr5VHRCiMuOgh7j
         0/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062339; x=1731667139;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChoqMoh2T+eig/XpTTE8Tcj5u81rqtdZXLhWcSY6EWc=;
        b=JJvHhYPm0/p9GUoXYEL2pAmecrPSWcX0iPIZsnCGT1AynX6BZJFIGEW7nS6sFSUbS5
         E1Kw4Zoq7gXlOGCdW4x2lq6yGsIDyT8F50aKmeB8sgUIt1VcoAzFXfp4pgHTy40olTuk
         jwQ9Q+uhWxrgLKp+tmmN45WiAmv89EueMIhAEUzAVFnSYb0rI5ScjsTnhGoCr+Bp+5u7
         xlw3HrF1gXyRbPzzDrJvqXHx8pL069lg8+T+X6yO7ycT1N0M0CHhj1Tgm1ZIqR20JZ4w
         wlDkps0E0D5JNZ3KbE1ndDCYgkaeqRgPH4dscTwMMxiH7UYddlooaS4Ejs/+f4mSa7rj
         U66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoNPhQ6v8lG5t+jIjXZnIJkNKz545cxRlAdHJ9qMx6riA7zmdJWBH3TnRvGrHYurMT2D35S8b9hOS6yJ1m6Q==@groups.io
X-Gm-Message-State: AOJu0YxzAgwx1s10ieLvqSPNOA0B3EOdVca0eVVAk/rxRKZvXas+/8ka
	Hd3GIeS9k3O+MV1mOa4PAJ+zI+fRGhNKpFFgIYgL/7i4OreOWJalfVqFgEklhVw=
X-Google-Smtp-Source: AGHT+IFW8QVCN5MP2DyN8EOgoayKfgEaOrqjB9pOITOne1wJM368GLG5uI8OkEwJOgIwljEbs4P55A==
X-Received: by 2002:a05:6512:3d1d:b0:539:fc45:a292 with SMTP id 2adb3069b0e04-53d8626c94amr1266790e87.43.1731062338516;
        Fri, 08 Nov 2024 02:38:58 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm59621335e9.30.2024.11.08.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:38:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: (subset) [PATCH 0/6] Add support of Android Boot Image version
 2 and non-AB image
In-Reply-To: <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 11:38:55 +0100
Message-ID: <87jzde3t8g.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 10:39:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2540

On ven., nov. 08, 2024 at 11:11, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On Thu, 17 Oct 2024 18:10:24 +0200, Guillaume La Roque wrote:
>> Actually bootmethod android only support android boot image version 4
>> and with AB image, some old platform wtill use android boot image
>> version 2 with AB or without AB slot.
>> 
>> This patchset add support of both version 2 and non-AB slot images.
>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)
>
> [3/6] configs: khadas-vim3{l}: fix userdata size
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/895b54998e57a5d099c09915341dd9312e0ad7a7

Great, thanks a lot, Neil !

>
> -- 
> Neil

