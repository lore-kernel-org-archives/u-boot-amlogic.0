Received: by mail-wm1-f65.google.com with SMTP id 7so1879594wmo.2
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HojFouUCUeA2YaharOSS9fQi4gZZZuJo1Gwr0n3r7pg=;
        b=snRv5DQ2NYIkaHOxm35MGOjmdjF/CCPu3m/H+riKIR51hl1i2AVSNWojdu/rUyXuyB
         viklB7LnKFzUtAixJrAxj6Ob0LgVnZ3YlfpSapEa6AEK+RJKbDJoM+S4v76TCod+sqET
         bLRMWAf3nhesHRrtihY9v1YLcnjKUy5FxLsOCv32s8IPLDAum3AazLwQGlWe01VB9cEH
         m+frSy62VPdve+fxNJrzLEylSvWOjVcMgL+eQ1ZzrYlSoyxiBwk8KXknouB68NQ4MMUp
         0m4W9gHOY/6griYMyx0EmMx2uYTsTmyXwwN7UdRCnezbxFmoL/w8Otmw5AU/Jlc2jUjp
         XxrA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] ARM: meson-g12a: Add missing support from Linux 5.2-rc1
Date: Tue, 28 May 2019 10:50:35 +0200
Message-Id: <20190528085038.8088-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This patchset :
- Syncs the G12A DT from v5.2-rc1
- Add support for the G12A PCIE PLL, introduced in v5.2-rc1
- Add missing DT to fill the gaps, that will be synced in Linux 5.3-rc1

Neil Armstrong (3):
  ARM: dts: sync Amlogic G12A DT with Linux 5.2-rc1
  clk: meson-g12a: Add PCIE PLL support
  ARM: dts: Add missing DT for Meson G12A support

 arch/arm/dts/meson-g12a-u-boot.dtsi           | 216 ++++++++
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |  63 +++
 arch/arm/dts/meson-g12a-u200.dts              | 147 ++++++
 arch/arm/dts/meson-g12a.dtsi                  | 465 ++++++++++++++++++
 drivers/clk/meson/g12a.c                      | 103 ++++
 include/dt-bindings/clock/g12a-aoclkc.h       |   2 +
 include/dt-bindings/clock/g12a-clkc.h         |   5 +
 .../reset/amlogic,meson-g12a-reset.h          |   5 +-
 8 files changed, 1005 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi

-- 
2.21.0

