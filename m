Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0DBD6A230
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:29:57 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.5704.1731619796317167845
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:29:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=I8/8coox;
 spf=pass (domain: baylibre.com, ip: 209.85.128.45, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so12359515e9.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619794; x=1732224594; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjN3qlgGFfhL4mVwuA/OEAAvF6xy8UbYiYCvSsUW5+8=;
        b=I8/8cooxDgn4cBlMVhzIMUIgYLDVavsu5XuaDhCbetPQS3su5vEa/xeHkgmBBB2HgY
         I3XaZ1v8ZTvh6tSnOKH0046VHuElShAr8rbumRzxnNQ4geFXKabYs5zEE4OpUmmu9W9e
         rXdD/AZS1rwhyuqMX8LXrvKJoNMUQ9OgwIewvAUk9dFASEBFht3Ss6/W7u32VkAVNpQd
         RmBT+hsZsJ+9a5MV6F0BB/tj7j9n11a9O+sd2ygn+R57HAopUzs/KG5DUzEtCaSrIm68
         ZH1LPvcVbCUjGX+MPIO+pvKYN2rfhzPp1OB6s4osVbeqz8D2CR6aDB5mZai4gh3bdNpM
         QuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619794; x=1732224594;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjN3qlgGFfhL4mVwuA/OEAAvF6xy8UbYiYCvSsUW5+8=;
        b=eeSbV4zPbhixVNMpTrOAgY51+fV0yeZT2M+sCTFyn/pPFXAVUZ/zShZIgGez6yvNm3
         XOUENUdIpArqrh4se5xQk3mjP4LRa8dNWHX4LE1M1tFleOl2RXKulfJk50Bd5pZg9Gck
         6SoyhZy4xjnddauLg715Bp3k3lUBS/M9Di2l/TNKyOVvfdA30RdTbzKZz8/kPVcT+34E
         Avi3E7rUG85uV5FcuWS5mB+YLp0dFSeVaoKGucPQLjllda6LRc1ODqrpCYrUP3eMT5OZ
         yr2DngLQG9OwMgo4+WaZZbnBYolc17ENCcoQIDgvWjakzICv9nFBdZktyQhtTAqxxGJP
         07rg==
X-Forwarded-Encrypted: i=1; AJvYcCWNsFAph/ijNKrVhPWv1V9YfganxvSX6sM4iGTrWyJpTaw/r63C+wJjrkc00nkF74BqLPbgDITiStbg06tmxA==@groups.io
X-Gm-Message-State: AOJu0Yw2cqbePCOgDpZarww5vEyavJAc0Uj9LRAZ/uxtzMFyV76w6JOC
	aF+HGsjb7qUAC4AURvE+i6v3TTkf0oGbZdH5ackMijXoeZbpJdSUQpM295y8zbcEWFc+PQBI+Xn
	1Tyk=
X-Google-Smtp-Source: AGHT+IEkIpw1ZEX9yT+w0svWDyxf20o1KQv18adjSSn6HL2sPd1WARXjXmP7/q6zSkO7GjGesqG83w==
X-Received: by 2002:a5d:64c7:0:b0:381:d890:b5b7 with SMTP id ffacd0b85a97d-38225ac47famr231167f8f.52.1731619793619;
        Thu, 14 Nov 2024 13:29:53 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:53 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v2 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Thu, 14 Nov 2024 22:29:43 +0100
Message-Id: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhrNmcC/02Nyw7CIBBFf6WZtZgBH4gr/8N0QQHtJFp0qMSm6
 b+LNUaX5+Tm3BFSYAoJ9tUIHDIlil0BtajAtbY7B0G+MChUa4lyI6zvOJLPSliU3tktGo0ayv7
 G4UTPuXWsP8zh/ijJ/idbSn3kYf7L8m2/af2XzlKg0DvpzMoYVM4cGjtcqOGwdPEK9TRNL1pl9
 JW6AAAA
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 21:29:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2552

Actually bootmethod android only support android boot image version 4
and with AB image, some old platform wtill use android boot image
version 2 with AB or without AB slot.

This patchset add support of both version 2 and non-AB slot images.
It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC

patchset was tested on khadas VIM3 and VIM3L with AOSP main branch and
android-mainline kernel and with TI AM62P with android release provided
by TI.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v2:
- Drop patch 3 (configs: khadas-vim3{l}: fix userdata size) already
  applied 
- Apply Tested-by and Reviewed-by from v1
- Fix comments
- Revert malloc/free for slot_suffix
- Remove vim3/vim3l stuff in meson64_android.h 
- Link to v1: https://lore.kernel.org/r/20241017-adnroidv2-v1-0-781c939902c9@baylibre.com

---
Guillaume La Roque (5):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

 arch/sandbox/dts/test.dts                 | 10 +++-
 boot/Kconfig                              |  1 -
 boot/bootmeth_android.c                   | 78 +++++++++++++++++++++----------
 configs/am62x_a53_android.config          |  1 +
 configs/khadas-vim3_android_ab_defconfig  |  7 ++-
 configs/khadas-vim3_android_defconfig     |  7 ++-
 configs/khadas-vim3l_android_ab_defconfig |  7 ++-
 configs/khadas-vim3l_android_defconfig    |  7 ++-
 configs/sandbox_defconfig                 |  1 +
 include/configs/khadas-vim3_android.h     | 26 +++++++++--
 include/configs/khadas-vim3l_android.h    | 26 +++++++++--
 include/configs/meson64_android.h         |  6 ---
 test/boot/bootflow.c                      | 29 ++++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 14 files changed, 208 insertions(+), 47 deletions(-)
---
base-commit: ce427e40a2422b75374ee3404e3f5c6536e8984a
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


