Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D7CEDD9B
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 14:06:01 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.17480.1728482755386985637
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 07:05:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=EKC/dwp5;
 spf=pass (domain: baylibre.com, ip: 209.85.128.45, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cba8340beso5869715e9.1
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728482754; x=1729087554; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEXYhGUpt3lex8EEnhqZVXPY4Fe5dox/5PvVm9sdB54=;
        b=EKC/dwp5AfDuxCOlHz3PwpJbqRU4O/nwYev2YPvKT+eBIqJKrvWn+d0/CUYMpBoL+B
         4qkCTDIzWbG1ZDluchoe0m2extdsxAX+wvV/IsmDGhDPTms8No6Ui4X12/BypMRvpWs5
         Rm2cq0MPF12M7oevVjjuBADLa7VE1IfW83BJqhtOeJJgnLd0/+uCiLAkwJyycH/JAVCF
         acpF1nao59SzsI6C86hKZr6n9E/zfnRWHM6UrP4mPgquiPUsBSy4KhN+1jqlSCR4XZIe
         KtbMyX0D/6A2+XCoZcUfQrLivMtDWM0y/IEg6dqHmdrwiOoIgNOGN4rvvW0L1F9lc7MF
         94WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482754; x=1729087554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEXYhGUpt3lex8EEnhqZVXPY4Fe5dox/5PvVm9sdB54=;
        b=c/vfg6zXrGHzTePqScVnEunXfeMs2zv4pOksHaoxyqDcr0qcz0MF+lb/br1jJrzY4/
         oKUn1BKZJtyaYRBqDw8rpnN10FVcOekvmqwz9Fhq5BJ/AQ4nQ6lwwLo5T5WvPfazJ7R7
         qcxw3Os7VqdqJylKJgJARzHUqng848VO9iUojzPbIAXIN31B7L1Ez08zNWG6K3mfd6TN
         lrxPKrCAfnBag44pRhtA4h9Oyt+3K7/5F74b+gCLacsNJyncchzUQ5ZqVsXfFgk7pwxv
         yFRouejAE3UqNYj31QXwbO0i3sxR+k1962e6F8du4f+Da38l5Sb7zZ5aZSGfWQg9kjqM
         GdTw==
X-Forwarded-Encrypted: i=1; AJvYcCWzv9zXJAOLBj83GWCxFn7JUUpJDr5WBr5FCAiSty/xwvXSGg4iOyy7enlMMamYCzZYnD4a3ASV/sYJ6f2hyw==@groups.io
X-Gm-Message-State: AOJu0YzNoDmseTE4OBiVEiAKLKZB0q0cb/k0QOBq9i7jUiE2HpUGIQml
	8hNa6r24J3P+nCOsaAJLsHGRUU83T5+nZ+jV29AAnfcQUcqV8vsfJVSTjzGpSRI=
X-Google-Smtp-Source: AGHT+IFzHvvQumDNsZK2t0ahDm1BDv9AAfzjxmRaHuZG0eXmO1tB/UF8hlRYjojmyz9Y9jiYoWQcag==
X-Received: by 2002:adf:9c0a:0:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-37d293405c3mr4172533f8f.21.1728482753496;
        Wed, 09 Oct 2024 07:05:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:591a:75a8:66a2:c5c3? ([2a05:6e02:10a5:e010:591a:75a8:66a2:c5c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4d8sm10529099f8f.36.2024.10.09.07.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:05:52 -0700 (PDT)
Message-ID: <c3dae5c8-6465-471c-b262-99b925eeac37@baylibre.com>
Date: Wed, 9 Oct 2024 16:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
To: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 14:06:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2437

Hi,

just test this series on Khadas vim3 board and it's working fine

bcb ab_dump mmc 2#misc
Bootloader Control:       [misc]
Active Slot:              _a
Magic Number:             0x42414342
Version:                  1
Number of Slots:          2
Recovery Tries Remaining: 0
CRC:                      0xd438d1b9 (Valid)

Slot[0] Metadata:
         - Priority:         15
         - Tries Remaining:  6
         - Successful Boot:  0
         - Verity Corrupted: 0

Slot[1] Metadata:
         - Priority:         15
         - Tries Remaining:  7
         - Successful Boot:  0
         - Verity Corrupted: 0


Thanks for your patches.

Tested-by: Guillaume La Roque <glaroque@baylibre.com>


Le 08/10/2024 à 22:18, Dmitry Rokosov a écrit :
> The patch series include changes:
>      - move ab_select_slot() documentation to @ notation
>      - move ab_select command to bcb subcommands
>      - introduce the ab_dump command to print the content of the BCB
>        block; it's useful for debugging A/B logic on supported boards
>      - fix the slot suffix format in the ABC block to align with official
>        Android BCB specifications
>      - add a test for the ab_dump command to verify the accuracy of each
>        field within the ABC data displayed, it's also useful for testing
>        slot_suffix problem code paths
>
> Changes v3 since v2 at [2]:
>      - return "Legend" block for bcb command
>      - additionally, verify the CONFIG_ANDROID_AB configuration alongside
>        CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
>        designated board.
>
> Changes v2 since v1 at [1]:
>      - move ab_select_slot() documentation to @ notation
>      - move ab_select command to bcb subcommands per Simon and Mattijs
>        suggestions
>      - redesign ab_dump as bcb subcommand
>      - use spaces instead of tabs in the ab_dump command output
>      - print hex values in the lowercase
>      - add RvB tags
>
> Links:
>      [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
>      [2] https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
> Dmitry Rokosov (6):
>        include/android_ab: move ab_select_slot() documentation to @ notation
>        treewide: bcb: move ab_select command to bcb subcommands
>        cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>        cmd: bcb: introduce 'ab_dump' command to print BCB block content
>        common: android_ab: fix slot suffix for abc block
>        test/py: introduce test for ab_dump command
>
>   MAINTAINERS                               |   1 -
>   boot/android_ab.c                         | 116 ++++++++++++++++++++++++------
>   cmd/Kconfig                               |  15 +---
>   cmd/Makefile                              |   1 -
>   cmd/ab_select.c                           |  66 -----------------
>   cmd/bcb.c                                 |  98 +++++++++++++++++++++++++
>   configs/am57xx_hs_evm_usb_defconfig       |   1 -
>   configs/khadas-vim3_android_ab_defconfig  |   1 -
>   configs/khadas-vim3l_android_ab_defconfig |   1 -
>   configs/sandbox64_defconfig               |   4 +-
>   configs/sandbox_defconfig                 |   4 +-
>   doc/android/ab.rst                        |  12 ++--
>   include/android_ab.h                      |  17 ++++-
>   include/configs/khadas-vim3_android.h     |   2 +-
>   include/configs/khadas-vim3l_android.h    |   2 +-
>   include/configs/meson64_android.h         |   4 +-
>   include/configs/ti_omap5_common.h         |   4 +-
>   test/py/tests/test_android/test_ab.py     |  31 ++++++--
>   18 files changed, 252 insertions(+), 128 deletions(-)
> ---
> base-commit: fbe16bc28014dc1ed957f5fee7e53d6eee781aa9
> change-id: 20241008-android_ab_master-d86d71c839ae
>
> Best regards,



