Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.1020.1576780590719037962
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Dec 2019 10:36:31 -0800
Received: by mail-wr1-f68.google.com with SMTP id c14so7003946wrn.7
        for <u-boot-amlogic@groups.io>; Thu, 19 Dec 2019 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoI0UUC9jB4IsysSGL//6gEqu3qN6YAFg50wzbRsB5w=;
        b=k2UXNydKfp9u2zUUn6MOUWNtV0IAAZaa/cPth5P3yZvA2TKz7eDtQv9gB5U0T1p9Ik
         n4gMfuZOc7cktQMUAkXo/5JZdop5rs9/cVJI6AnPfS2hCu9m/nK2bUDHfg0uAkZ4A+Iv
         UN1Vgp64b9REXlVitVVFPTmE5GKGWXVmT/KBXRhsUloEExdhPu68KCdDJeI707eraUmd
         akzclt8M18zL1V62/jMvTmuDgo8X1HRrZc0jBN2xx/OtQAY0PjpP5b3/DbBox+oPCWJK
         KgrshH+6TKOVJLB9q7KI0fxmj1rPs5CGNQZBM2v3G/Dk5ocOUfzsewUaUrS1ebrtxCyg
         vNww==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/5] arm64: meson: add libretech-pc support
Date: Thu, 19 Dec 2019 19:36:15 +0100
Message-Id: <20191219183620.1423118-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add libretech PC platform support. This platform comes in 2 variants,
one with the s905d and the other s912.

The corresponding DT have been applied and should be merged during the
next merge window [0]

While working on these boards, I've found a problem related the mmc
clock. In some cases, the ROM code will leave the mmc clocks in such
a weird state that any access to the mmc controller would lock the
device.

Making sure the MMC clocks are properly reset and enabled is enough
to solve the problem.

[0]: https://lkml.kernel.org/r/7h5zig82ha.fsf@baylibre.com

Jerome Brunet (5):
  dt-bindings: leds: import common led bindings from linux v5.4
  mmc: meson-gx: enable input clocks
  clk: meson: reset mmc clock on probe
  arm64: dts: meson: gxl: add i2c C pins
  arm64: dts: meson: add libretech-pc support

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/meson-gx-libretech-pc.dtsi       | 376 ++++++++++++++++++
 .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |   7 +
 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts |  17 +
 arch/arm/dts/meson-gxl-s905d.dtsi             |  12 +
 arch/arm/dts/meson-gxl.dtsi                   |  44 +-
 .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |   7 +
 arch/arm/dts/meson-gxm-s912-libretech-pc.dts  |  62 +++
 configs/libretech-s905d-pc_defconfig          |  73 ++++
 configs/libretech-s912-pc_defconfig           |  73 ++++
 drivers/clk/meson/axg.c                       |   7 +
 drivers/clk/meson/g12a.c                      |   7 +
 drivers/clk/meson/gxbb.c                      |   7 +
 drivers/mmc/meson_gx_mmc.c                    |  14 +-
 include/dt-bindings/leds/common.h             |  75 ++++
 15 files changed, 772 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
 create mode 100644 configs/libretech-s905d-pc_defconfig
 create mode 100644 configs/libretech-s912-pc_defconfig
 create mode 100644 include/dt-bindings/leds/common.h

-- 
2.23.0

