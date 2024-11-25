Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256CD58088
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 12:07:04 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.17337.1732536420580568041
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Nov 2024 04:07:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=o9fTzAhQ;
 spf=pass (domain: baylibre.com, ip: 209.85.128.47, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so4070065e9.1
        for <u-boot-amlogic@groups.io>; Mon, 25 Nov 2024 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732536419; x=1733141219; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLhU2KiGUOvvWpupFvS6VRkI1WD8foXri87SjJGbUjE=;
        b=o9fTzAhQ6pSoB/NsXC1aWa1iwYXx5dOtQkQHlvrOaBiZokgvOwoGC0D4ElmP8qzv+B
         5rT0eh4O0n9Ert6ru6mVp4WcMOlhye6oRbYo74P0MyYxMBqlMMS4IBo242/fT5eNqZbs
         s+sPCcLrx46fuuSraLi302OLmazKkGmgH85PT4frr71/dGO8kgII7n0twC6kjN7va+2c
         V+i7hz9+JSAtzbY16lZZFnFq4cJmFVrnzQTbPEfvym1jNb9OI/mtrQQnB/iNwDp++C+D
         wl8YBILbPLnlkbTW1XfmLg0Wd6NcBvC4TxIDK3Z8dgu12gF5MVbZf6Q+12UMeEfREFex
         KAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732536419; x=1733141219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLhU2KiGUOvvWpupFvS6VRkI1WD8foXri87SjJGbUjE=;
        b=RGpCTJSjYnr6ZxIxDF68FDSCxSCKVRkQ1aTAElq5ZqdChWN84OmG453DgI98FLdhLH
         /WJNpdhJWNUOEu3nrYpRG/nhHKY+NYA1gZbr887l8foYRcBohg3rdqo8gUTSXh+hKfSc
         9m1Z16MtaarungKA/Z1yn2lPb/um2gw7+g2Js3iDXa2bL/ZL1pG6Wq71udoM5f2GfF5c
         1id4pfGxzH6VnKOKVtDRTcmKnTYQP0WJWfoQgh3eMkALF6IyKJHjHvzjef5/oMIuEwYo
         2F46GgsWTVJ2aAOqZPbh7oRcqDvAM+zLC0vA6l3OlBFfnmax53rWImcCX9+DoOJSFRyr
         b2eg==
X-Gm-Message-State: AOJu0YwM2sl+wqYcpLxmfy6IxocvEOnih0WeLCW6aMAuvRafK3xv268w
	Tqo38eQGVFTeP+ucj6ryPuxt6xJr+FqRQnKcSJfgUgyd14yZ5oqwnPmTYjQ8ErbjE8LTKslxkCP
	K
X-Gm-Gg: ASbGncuAJrjfJCfEEUPdD26FjqGrnV1rLzt8MtmhFTgKG0nZR+MN0auKtH0YIoSneJ4
	pUP1XuCszCpIbuoO6Gvx4fQLXDQpNjM9GgXbB0e+lRZyCNMgUytnYi6MjWx/MXGjNNYo6zwjkEb
	3fvBPkeCnV82X68JGsbCv6n5c4ier4lgil9JF5p69K1DZZumA+zZqi3TqI731IjiYgYexbbLz38
	nnq9+ejJ29Yt1PlwO6b21muHN/+gASiSYFXmGY+KW5B7Gca8X/P8nkvgyI=
X-Google-Smtp-Source: AGHT+IEZuJ+TgmE/DtvhAjyA52WsX860lJhabZYV2pyVwkKh273h0/TZB4pOpqu0Pcn/3ghWxC4Mxw==
X-Received: by 2002:a05:600c:19d0:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-433ce41ce2cmr118774455e9.13.1732536418835;
        Mon, 25 Nov 2024 04:06:58 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a0876a41sm24159955e9.11.2024.11.25.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:06:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <1809644DD9DF8FC7.18574@groups.io>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <1809644DD9DF8FC7.18574@groups.io>
Date: Mon, 25 Nov 2024 13:06:57 +0100
Message-ID: <87serfbjq6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Nov 2024 12:07:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2581

Hello,

On mar., nov. 19, 2024 at 15:16, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:

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

Due to the test regressions discussed in this thread, I'm dropping this
series from the u-boot-dfu tree.

Please submit a v4 targetting next once [1] lands in next.

Thanks,
Mattijs

[1] https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/

>
> --
> Mattijs
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2573): https://groups.io/g/u-boot-amlogic/message/2573
> Mute This Topic: https://groups.io/mt/109662676/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

