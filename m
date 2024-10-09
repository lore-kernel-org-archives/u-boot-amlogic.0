Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C4CFC508
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
 by mx.groups.io with SMTP id smtpd.web10.5978.1728439022837806133
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 18:57:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=HJqRTS/0;
 spf=pass (domain: chromium.org, ip: 209.85.217.41, mailfrom: sjg@chromium.org)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a3cb09e28cso1911726137.3
        for <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728439022; x=1729043822; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4r1ZLz7BBtjCnUFs8BOd/sFDM2Oe4ncTeL5RTkav7Y=;
        b=HJqRTS/0lewkElafUgzxODmowP8Ks9eJ/2lsGOz6H6NuzOS0hOrEbNv16GyIZYUNOS
         mknQQe1nyCjwZjYPBxpQLdHguDhBrgitxhUEMICEEvWlNL7nS54cwRllh5u2fBHIT/pX
         oivfJbwTUHlugpwwi8PbVFIh3976xvNtui9oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439022; x=1729043822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4r1ZLz7BBtjCnUFs8BOd/sFDM2Oe4ncTeL5RTkav7Y=;
        b=PpapChr7KxXZ6GJiLjOYEi+p+A4G+i4Nq2inyUTuYEY6yDb6B6zH4L964ovhOxyPQ+
         dmGI5HcGPd41iQw/L+oHu0OCCFa0gwlgDHVxeySzS2AJjGB92UicfM8cwdp/yEajaYzf
         UF1l+hipeoA9CUGRGMVgRBCq6/o2dTBXoIOJDFUQ1US/dAW0pYrmMIugh4X3nxiy8mqA
         jYA7r3O2KrH3vKhM7ifo73zzAXfQGUirb+YqHb5U9w7rPBkbXnux412QqGt4Wfgc1JYX
         BGYz33e0ZIxgNXBid81r/4XN6H/K/fjIqaxtheySIr4B88u0gCZeCPWhb/J7OyjF2uYl
         pYHw==
X-Forwarded-Encrypted: i=1; AJvYcCXxf34TgRVkch8suwxSWO8BMsHm5aTtGehWEvkEX3rN1TiCb07vRi7gHWMYTiKBPII2VasDbkM3BQZGf1D8eA==@groups.io
X-Gm-Message-State: AOJu0YzsedhEHFAj13O9/DibNA4A0fLYINwaMOJw2DYrShRs8fi+J6LW
	oRTALh9YnvGXvCS1Ygv7CPSx3US3AY7JJKPEBr12kjVAu1Ds9N+jA1JJ+Ty5EMzRGdfgvf40kC/
	9B+96N8gL4Zw0svcxkcufezBGmIa2juoEE3GC
X-Google-Smtp-Source: AGHT+IF+Yiwei8AxJ/IG6XNTm74bjruuKA8bMjEMYFHOIh9qZQs7O2zazbPrb0+tcf3ObvFZ09+BcLhz/a8CMjZtr70=
X-Received: by 2002:a05:6102:370c:b0:4a3:3d4f:edd2 with SMTP id
 ada2fe7eead31-4a448d7d503mr1226488137.17.1728439021866; Tue, 08 Oct 2024
 18:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com> <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:46 -0600
Message-ID: <CAFLszTjW+a=jNvktZdix4LZmkVBr6WmyzQMuramf5rqMN_-Xsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb subcommands
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
	"Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
	u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2462

On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> To enhance code organization, it is beneficial to consolidate all A/B
> BCB management routines into a single super-command.
> The 'bcb' command is an excellent candidate for this purpose.
>
> This patch integrates the separate 'ab_select' command into the 'bcb'
> group as the 'ab_select' subcommand, maintaining the same parameter list
> for consistency.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  MAINTAINERS                               |  1 -
>  cmd/Kconfig                               | 15 +------
>  cmd/Makefile                              |  1 -
>  cmd/ab_select.c                           | 66 -------------------------------
>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
>  configs/khadas-vim3_android_ab_defconfig  |  1 -
>  configs/khadas-vim3l_android_ab_defconfig |  1 -
>  configs/sandbox64_defconfig               |  4 +-
>  configs/sandbox_defconfig                 |  4 +-
>  doc/android/ab.rst                        | 12 +++---
>  include/configs/khadas-vim3_android.h     |  2 +-
>  include/configs/khadas-vim3l_android.h    |  2 +-
>  include/configs/meson64_android.h         |  4 +-
>  include/configs/ti_omap5_common.h         |  4 +-
>  test/py/tests/test_android/test_ab.py     |  8 ++--
>  16 files changed, 85 insertions(+), 104 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

