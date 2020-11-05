Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.8011.1604585748960197013
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 06:15:49 -0800
Received: by mail-wm1-f54.google.com with SMTP id c18so1749869wme.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Nov 2020 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWnafsJMk+EYOFO3pmlH1GUZNVbMk7RsFIqztWubhkk=;
        b=mzwzAXfcIQmlsKuPAD/wbNAyh1f5cdMZnr4Sx+IspEEyPdValpqH3eQ2a/KnUrEKIX
         FcUzE2W1qHpxyKyWd1LI8wbRN1w2Z4N2QVUH65myWg7EwfnQTvvhpUT9TcTSXdr0BVxJ
         jucwXRKFXGcGmfLlhymqUHqr/lB6IfgKRbxlbUvtvIfEcIB54SuRB5KuHWuf8m4mCJUH
         xBN28xUB1sZk5GB82CxGzftYbCMatCcYbchta/UbFxCCU/5hFGfPa8ck9u+ueOZ+91sS
         QVk2mAci/XhzlrDxm0dnLW0LMgw2j3QFk09veUi9j8y8WdrygSvkBpdeVOPwXwwaNRYa
         NxJQ==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] arm64: meson: add libretech cc v2 support
Date: Thu,  5 Nov 2020 15:15:27 +0100
Message-Id: <20201105141529.666149-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the Amlogic based libretech cc v2.
Like the v1, this revised platform used the s905x SoC.

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

