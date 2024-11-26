Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424FD3B990
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 13:26:53 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.45938.1732627606324447803
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 05:26:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=ZjkovRN6;
 spf=pass (domain: baylibre.com, ip: 209.85.128.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a10588f3so15124005e9.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732627604; x=1733232404; darn=groups.io;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O92NB/UMO/Jh+pdNDJvs2hDdW61m5uHTYQMYcI4vG0A=;
        b=ZjkovRN6AGc4CYBkPpz1zmWMIrKDiQSJTzwyUdGuyk/XQK69/HawMCjpSD8khppqC0
         bEYbvK/MGLhZ7UoH7EKONCrY3ISpsCbjHrZKIp9j4IotOKxzVjHQ4Elkzcbg+B83NztS
         CDl+IjZ4OqOmCvSOVLc6sL2BPgEbQ/uL8CLU/Fle18MuzR5S3tPdxOuLyJ3Gl76y7wQO
         bSmR8APaSBbNi8MNH6GW7BC8HG+y4SEtEzyRhHh7jFoCYeov+WkgxEFVJEizQXOjaaNv
         loKzi4eEWKGzCfTn/VfeGNxRGiayVBukHC3ZkygRm2nlHQpUjFTp/7W0GSwHPKrW/zJb
         1JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627604; x=1733232404;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O92NB/UMO/Jh+pdNDJvs2hDdW61m5uHTYQMYcI4vG0A=;
        b=p1eDAAv0OBJgaZIZ2U7VKToNJv5k2uIZ2GOtD6dMp4r1DymYiu7H/JILlgMXhgvEKT
         WfmLuEkOc6evdfgipZ/tW3rQk05NPXmMfbG+jSTmnitSYHw7ExVLBjo7vpYQ5pJLFSaa
         aFoIZITHz0rnCIqQH5qHmh/6kmgFNXOo+tjl2H3wUMp8yUqKfE33Um3v1OAUgzRqDWUs
         ygN2lr2Jvqv+U7YjDIW+7/ofTE+Bmv1IBl/UZLdjWVzudw6xx76Qz7L0nkiZ8f6UByuV
         Jb5Vb10xPh9K/8G8mSQSxG2mtv9mW8wfFsTajO/a3OkTYWwBMoW3Io1FxmnEKgENynRu
         VRFw==
X-Forwarded-Encrypted: i=1; AJvYcCXEyaikPv3o5OvTQdzcRCUDE0UgSbNieIHyrsTY9HhHvg42vVzh6zKX7Q3lNTgjrVao1Zux0b9EL2UdOwaXDQ==@groups.io
X-Gm-Message-State: AOJu0YxiIzgj94sprXoySN2SNVwTT8IjBzkgzDPubFtbEQwPFMQCbdS7
	O/cMC4bMXXA1vkw7KVhgo2FW3GkqTcve8D4MAyU345gLZJCxnxhP2C3YUTs3vnE=
X-Gm-Gg: ASbGnctZSZT9ODNgq9atKgTkGFNba+BrT7Tt2UCIOTpxHoD/C7ibIfpvZTNuWxx2ISV
	Z8Tts7Tb2zBwVTA9+uNvfpE6aBZPOmoYRnLlJWCgTcFat7bBDNC0o4k8fBlbxmntVBXgQCDkfLI
	LwO9/DSPW6p90Y11/iDA45FJkrkOHxsnOip4wfrkKodBwztTyqT7us7Xq2dHKg3+zLDX1c0M0T6
	kXgNCf6Xet1FiwPqOKztwtGoQCNhHcb+tJvlZ/Flux0H4nmFOVOWQ==
X-Google-Smtp-Source: AGHT+IEl+iN2Kivah1mCQs/1LyUlmtvC/Qd4EKFLUrFl29QRYaFTYtfaF1YC5QLP+lJ5Tz/gSSmtJg==
X-Received: by 2002:a05:600c:4ed0:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-433ce4d4ad0mr158490285e9.30.1732627604254;
        Tue, 26 Nov 2024 05:26:44 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463abb4sm235438755e9.31.2024.11.26.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:26:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20241126
Date: Tue, 26 Nov 2024 14:26:41 +0100
Message-ID: <87plmip1m6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 13:26:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2590

Hi Tom,

Please find some new developments for next:

Android:
- bootstd: Implement bootimage v2 support
- bootstd: Support non-A/B in bootmeth_android
- Migrate VIM3 and VIM3L to use bootmeth_android
- bootstd: Additional test for bootimage v2
- bootstd: Optimize load time when reading partitions

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23573

Thanks,
Mattijs

The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d911:

  Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20241126

for you to fetch changes up to abadcda24b100b8eb0f138085cca6595518cec85:

  bootstd: android: don't read whole partition sizes (2024-11-26 10:04:40 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20241126

Android:
- bootstd: Implement bootimage v2 support
- bootstd: Support non-A/B in bootmeth_android
- Migrate VIM3 and VIM3L to use bootmeth_android
- bootstd: Additional test for bootimage v2
- bootstd: Optimize load time when reading partitions

----------------------------------------------------------------
Guillaume La Roque (5):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

Julien Masson (1):
      bootstd: android: don't read whole partition sizes

 arch/sandbox/dts/test.dts                 |  10 ++-
 boot/Kconfig                              |   1 -
 boot/bootmeth_android.c                   | 104 ++++++++++++++++++++++--------
 boot/image-android.c                      |  45 +++++++++++++
 configs/am62x_a53_android.config          |   1 +
 configs/khadas-vim3_android_ab_defconfig  |   7 +-
 configs/khadas-vim3_android_defconfig     |   7 +-
 configs/khadas-vim3l_android_ab_defconfig |   7 +-
 configs/khadas-vim3l_android_defconfig    |   7 +-
 configs/sandbox_defconfig                 |   1 +
 include/configs/khadas-vim3_android.h     |  25 +++++--
 include/configs/khadas-vim3l_android.h    |  25 +++++--
 include/configs/meson64_android.h         |   6 --
 include/image.h                           |  24 +++++++
 test/boot/bootflow.c                      |  29 ++++++++-
 test/py/tests/test_ut.py                  |  49 ++++++++++++++
 16 files changed, 297 insertions(+), 51 deletions(-)

