Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4038D1CDB6
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 08:32:43 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.13612.1729585959475187464
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 01:32:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=jxgP8d8P;
 spf=pass (domain: baylibre.com, ip: 209.85.128.50, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so52189685e9.3
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729585958; x=1730190758; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewlRDRy9rSStzBpNiy2SmbDXWnIcvHgbQLDAoT1XjrU=;
        b=jxgP8d8Ps2d6LSeYvpBXLrdAFBJOa7/tJ1piLelSR80m2eAZZLsS+V1PGZR6FOvJp1
         +DbF9rKsneJwCOxQ8vmkZcWMUDDCZm7CI+wVmEs9Itw1ng9tI008r2Ot6ihMuLXJ7qwI
         NBohOGeNCfA4/zwu8jXcL+qHbDVW8uuPQNZSmn2z48yA9eMDJLcxbJMi5f9kmGYa2VV7
         dQkf2d5H87pthNwnP6VCYLGFGL/UQq2kpuGlpWlw5hY2xdIL/RTwjbfH7rQXE67nHbWF
         /AVolJ0bFtFkF3C07tsihJDM4Z3WN1w2Z8QoyLTwdrtaqFpFwNvRyvI3MFuO8Fkg0CJI
         /xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585958; x=1730190758;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewlRDRy9rSStzBpNiy2SmbDXWnIcvHgbQLDAoT1XjrU=;
        b=k3QDpRfOGSZ9jhaB+BB8mNw2GJAfy4OtaVBFUySlGIKxQjaxHy0fFgsX9VNCB2rzOP
         7cSMwsVAt0M1Tne2Q5tUUMGgvixezop5VChqaNLTop7nOZV8i0RBFmZ25oGiDtGgUpFy
         ymEDXbNn3w+FUOcdSK0ZNit3e1HDU97jrspzyudOK+edbl9yP/BVPSUB0wSlOrI8+cq/
         BM8gttusZJUUdRxc6wT+1yJ38keqS6/oj2iVNzNOra4x5qwQ507GrPu99U3vlhVlsIvn
         ZC9oMPcy1ISSV5kZqZdo6JgRuiLwJu2lUaZkTZdST261dYhvMCTm555ogqrjwfDbW5x/
         kUjg==
X-Forwarded-Encrypted: i=1; AJvYcCV/oi8ISUj3BtKqD888zQ8tlctdv0avFtJBv9jG2WxmNZyuGo7kNUUtMcJHlUbB5WFomgnz9TDc+UJI+06zpw==@groups.io
X-Gm-Message-State: AOJu0YySEfMf0O+OzicXy04AojPCjDNavQMptNO/6JLZbi72ipG/eDAp
	XSY26qmOX/cFyy4XTXPXtxWleokKWuHd4kIpjJKubiJQMY0pmgECaaqTjYA3f2I=
X-Google-Smtp-Source: AGHT+IH620t5DBpF6+J/rjWeUv1k560iRER3FSXu7Gw6Viveebz0L8IwbUS7xPbIcS5tN0IZLx/eZw==
X-Received: by 2002:a05:600c:1d27:b0:431:5847:f63f with SMTP id 5b1f17b1804b1-4316164ac7amr113798365e9.13.1729585957599;
        Tue, 22 Oct 2024 01:32:37 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5709efsm82701435e9.10.2024.10.22.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:32:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
Date: Tue, 22 Oct 2024 10:32:34 +0200
Message-ID: <87ttd4wna5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 08:32:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2509

Hi Dmitry,

Thank you for this series.

On jeu., oct. 17, 2024 at 17:12, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - redesign 'bcb' command to U_BOOT_LONGHELP approach
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Boot tested AOSP using on Khadas VIM3 using khadas_vim3_android_defconfig

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3_android

Boot tested Android 14 on Beagle Play using:
am62x_beagleplay_a53_defconfig and am62x_a53_android.config

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # beagleplay

> ---
> Changes in v5:
> - rework direct #ifdefs to IS_ENABLED() macro
> - redesign 'bcb' command to U_BOOT_LONGHELP approach
> - check argc directly in the ab_select and ab_dump subcommands handlers
> - Link to v4: https://lore.kernel.org/r/20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com
>
> Changes in v4:
> - add #ifdefs for CONFIG_ANDROID_AB in cmd/bcb.c to allow the usage of
>   the bcb command without A/B enabled
> - run the savedefconfig command for all defconfigs that include the
>   CMD_BCB configuration
> - resolve merge conflicts with latest master
> - provide additional trailers from the previous version (excluding
>   changed patches)
> - Link to v3: https://lore.kernel.org/r/20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com
>
> Changes in v3:
> - return "Legend" block for bcb command
> - additionally, verify the CONFIG_ANDROID_AB configuration alongside
>   CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
>   designated board.
> - Link to v2: https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/
>
> Changes in v2:
> - move ab_select_slot() documentation to @ notation
> - move ab_select command to bcb subcommands per Simon and Mattijs
>   suggestions
> - redesign ab_dump as bcb subcommand
> - use spaces instead of tabs in the ab_dump command output
> - print hex values in the lowercase
> - add RvB tags
> - Link to v1: https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
>
> ---
> Dmitry Rokosov (6):
>       include/android_ab: move ab_select_slot() documentation to @ notation
>       cmd: bcb: rework the command to U_BOOT_LONGHELP approach
>       treewide: bcb: move ab_select command to bcb subcommands
>       cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>       cmd: bcb: introduce 'ab_dump' command to print BCB block content
>       common: android_ab: fix slot suffix for abc block
>
>  MAINTAINERS                               |   1 -
>  boot/android_ab.c                         | 116 +++++++++++++---
>  cmd/Kconfig                               |  14 --
>  cmd/Makefile                              |   1 -
>  cmd/ab_select.c                           |  66 ---------
>  cmd/bcb.c                                 | 221 +++++++++++++++++-------------
>  configs/am57xx_evm_defconfig              |   1 -
>  configs/am57xx_hs_evm_defconfig           |   1 -
>  configs/am57xx_hs_evm_usb_defconfig       |   1 -
>  configs/khadas-vim3_android_ab_defconfig  |   1 -
>  configs/khadas-vim3l_android_ab_defconfig |   1 -
>  configs/sandbox64_defconfig               |   2 +
>  configs/sandbox_defconfig                 |   1 -
>  doc/android/ab.rst                        |  12 +-
>  include/android_ab.h                      |  17 ++-
>  include/configs/khadas-vim3_android.h     |   2 +-
>  include/configs/khadas-vim3l_android.h    |   2 +-
>  include/configs/meson64_android.h         |   4 +-
>  include/configs/ti_omap5_common.h         |   4 +-
>  test/py/tests/test_android/test_ab.py     |  31 ++++-
>  20 files changed, 275 insertions(+), 224 deletions(-)
> ---
> base-commit: 98a36deb9ab7aaea70b0b0db47718100e08cf3e8
> change-id: 20241008-android_ab_master-d86d71c839ae
>
> Best regards,
> -- 
> Dmitry Rokosov <ddrokosov@salutedevices.com>

