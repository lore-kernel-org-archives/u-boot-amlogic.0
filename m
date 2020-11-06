Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.9392.1604653706367986297
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:08:27 -0800
Received: by mail-wr1-f43.google.com with SMTP id n18so506008wrs.5
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yr5H+702UqPx3nrBgniKOJuebPjdYUDNNSLu37kTMbM=;
        b=jPFzUyYtBsSyKwz/aei6sOczOoj0Qsoi+XMnaNQ8nNLsgVxfK+UIQ6LxI9O8Lh2kWk
         s6i9IZh5vLnshfbgSF/hvkkuC7p8FRYFl7nTHxD3H4/ze/g9e0o/yBPVXrot59BJXU8n
         /a5tROaFdOaWM3DBQIjWRFw+tFM0DxH35tZdMxJk90RbugRIJC/4o39js8Xh+Kfuk6+y
         64qZNzVcbwnao6bQruzJgNPfYUMHIxGJZ0HORujUyKEnyF/CiMzf1tni410ZtDir86nE
         1R5hKCQLv0b0gT1HxthqSQ/AESmQ/TfvYACv2UF3Mx7o8qDeXmGGJivGUbzidArZ94Ns
         nQBQ==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/2] arm64: meson: add libretech cc v2 support
Date: Fri,  6 Nov 2020 10:07:50 +0100
Message-Id: <20201106090752.31005-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the Amlogic based libretech cc v2.
Like the v1, this revised platform used the s905x SoC.

Changes since v1:
- Move Makefile change to patch #1
- Amend documentation for libretech cc v2

Jerome Brunet (2):
  arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
  arm64: meson: add support for libretech-cc v2

 arch/arm/dts/Makefile                         |   1 +
 ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 +
 .../dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 ++++++++++++++++++
 configs/libretech-cc_v2_defconfig             |  82 +++++
 4 files changed, 408 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
 create mode 100644 configs/libretech-cc_v2_defconfig

-- 
2.28.0

