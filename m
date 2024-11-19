Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE17D44147
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:49 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.18862.1732016268851811190
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:37:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=aRLknIIm;
 spf=pass (domain: baylibre.com, ip: 209.85.221.47, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3823cf963f1so1705277f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016267; x=1732621067; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4B7InArHQu0ADiydUZLTVxC1H9B3Rgd/GxItu7hDcI=;
        b=aRLknIImWVZqtfzePSLXZC5umu19KTYmcga9oY8Ew+c4alfomUoS6XG9gUtc6wwJxz
         oZ5WG63A0E1qchTCg3yJXaPVOPncFDzvgWwKn5A8Jpve+68Lmn0FniNZRsCi6Nwuwd+l
         cOB6str/DBjuzHLY3ZVbLMECvAiKzMTTKDde0e1h0Hq5BtmdwCKl57hHVnI1Y9gyDYW3
         X9FYogmLGHrXptkGTPH78KdiLxkPDoOOL2Kuo5qbz4eXAiKriVwicKgyka3NhQE4XUIj
         FiXM4DpQMgKsmfkKdz/Rbu0mBFqWau2MSYOfJ4Mft0BWu8DavODpNw7jv+QMT+fDf289
         CoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016267; x=1732621067;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4B7InArHQu0ADiydUZLTVxC1H9B3Rgd/GxItu7hDcI=;
        b=Xf3jPxz52RTkfTEvLgriqOSvOu9CW5pnXqjSLy+hfVkk3UTvgNAcUDJ+0IYjCSdXXf
         zGf2l+7CT162dV4YCcP4ctcdaqVkWPTUIwBVxxAOMOcZSjdiq1khnd6k4vzywG2oNsdC
         qArD8ibkLZdAxWNG2RirVSRjmlG7FSd6pu2bS3xLOfh0sO6ZWM19aakOvBEKzG1IiXsr
         zFzaaJ6I9a7peR6Kyfju8s9qw9hzwnAdC1b7jElffW7l6lcFboglwPVzLAiUgdREbwOA
         +ZusoONmQzsw6vfNHZ0+OBeXqo3XsGvh5BG1G16avcae16+QcToPmJY2wezauFIfy3b6
         sarQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIYqh+NowBCqJv0DZyZqpQBcn9Ei9DoIkp9dO1JQ/z7jErymJ0/ZpOWHBnnpZSjpcIPGSLrZTYoC/GS1aEtw==@groups.io
X-Gm-Message-State: AOJu0Yz3b4GIYJas7SgWLNot0tmivBDFBm8pTkDSDZgbAztMzKgisFBb
	+M5FmuHRWDhMTggI+YSX0gHl46P3fg/NbPa8LrTLHN0YR8zhuc3kRynvSOaPeduTKk8plN0R/KD
	roJU=
X-Google-Smtp-Source: AGHT+IEl9L8wStCKHPWYefOQya9aVXw0r2Kl7gSfRgCQF/LbioEz1c+jtJuPnNg2k1eAqVXDK55hOg==
X-Received: by 2002:a05:6000:1568:b0:382:4926:98e6 with SMTP id ffacd0b85a97d-38249269a44mr5093987f8f.55.1732016267318;
        Tue, 19 Nov 2024 03:37:47 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:37:47 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Tue, 19 Nov 2024 12:37:37 +0100
Message-Id: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIF4PGcC/12Oyw6CMBBFf4V0bU2nRWtd+R/GRV/IJEq1YCMh/
 LsFYyAu782cc2cgrY/oW3IsBhJ9whZDk4PYFMTWurl6ii5nwhkvgcGOatfEgC5xqhk4q/dMSSZ
 Jvn9EX+F7dp0v3xz985WV3VLW2HYh9vNegqn9qeVKnYAyKg9glVCKcatORvc3NNFvbbiTSZT4A
 gOUa5hnOL9qqsqAkEL/weM4fgAIW/S09wAAAA==
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 11:37:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2567

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
Changes in v3:
- Remove gpio recovery stuff not needed anymore. 
- Link to v2: https://lore.kernel.org/r/20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com

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
 include/configs/khadas-vim3_android.h     | 25 ++++++++--
 include/configs/khadas-vim3l_android.h    | 25 ++++++++--
 include/configs/meson64_android.h         |  6 ---
 test/boot/bootflow.c                      | 29 ++++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 14 files changed, 206 insertions(+), 47 deletions(-)
---
base-commit: ce427e40a2422b75374ee3404e3f5c6536e8984a
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


