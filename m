Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.2142.1587390298185243923
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:44:58 -0700
Received: by mail-wr1-f68.google.com with SMTP id x18so12265569wrq.2
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hzioNBAkLPB9qH8EH1h4hWzV1wZVNSWkFdIeNG2wKM=;
        b=oTsUQ7dvSyDAc3SxWFdgGHp7omWDcjBv/to/SmxCh7c+ltafjBNor+rJyALozKCVgn
         3PcqrZLVYEOh8XGWHYjO3/LtZsX4ftL3teYX1fWN0H5FkLZUtUVsOkT1+zgeNoG+xVPL
         abIfaZylWX30uNeo/5UTXSC5V6kb8hG+GrNlCalj1MZuLi01sd+rIbt2wsNe6uM5oPX/
         VVYGDXTtN508y85bv15Zy3V96dNppBQrdma7hFnbLF9xuAJJdlFhCPlcKC0SPq77COb5
         Ke71S2vWTddNsfLlRPBDHL28xa3qd0zhlT6U2Ya+8XyhffflGvcPYYlOJV7iZsKun5dw
         0dEA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/5] arm: khadas-vim: enable support for SPI NOR Flash
Date: Mon, 20 Apr 2020 15:44:40 +0200
Message-Id: <20200420134445.19704-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This serie enables support of the on-board SPI NOR Flash found on the
Khadas VIM2, VIM3 and VIM3L board.

Neil Armstrong (5):
  arm64: dts: meson: sync dt and bindings from v5.7-rc1
  arm: dts: meson-gxm-khadas-vim2-u-boot: enable SPI NOR flash
  configs: khadas-vim2: enable support for SPI NOR flash
  arm: dts: meson-khadas-vim3: enable SPI NOR flash
  configs: khadas-vim3: enable support for SPI NOR flash

 arch/arm/dts/meson-axg-s400.dts               |   6 +-
 arch/arm/dts/meson-g12-common.dtsi            | 136 ++++++++++++++++--
 arch/arm/dts/meson-g12.dtsi                   |   1 +
 arch/arm/dts/meson-g12a-sei510.dts            |   4 +-
 arch/arm/dts/meson-g12a-u200.dts              |   2 +-
 .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |   7 +
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi      |   4 +-
 arch/arm/dts/meson-g12b-odroid-n2.dts         |  25 +++-
 arch/arm/dts/meson-gx.dtsi                    |  52 +++++++
 arch/arm/dts/meson-gxbb-odroidc2.dts          |   1 +
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        |   9 +-
 .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi |  15 ++
 arch/arm/dts/meson-gxm-khadas-vim2.dts        |  89 +++---------
 arch/arm/dts/meson-gxm.dtsi                   |  28 ++++
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  21 +++
 arch/arm/dts/meson-khadas-vim3.dtsi           |  24 +++-
 .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-sm1-khadas-vim3l.dts       |   8 +-
 arch/arm/dts/meson-sm1-sei610.dts             |   3 +-
 arch/arm/dts/meson-sm1.dtsi                   |   1 +
 configs/khadas-vim2_defconfig                 |   8 ++
 configs/khadas-vim3_defconfig                 |   9 ++
 configs/khadas-vim3l_defconfig                |   9 ++
 include/dt-bindings/clock/g12a-clkc.h         |   2 +
 include/dt-bindings/clock/gxbb-clkc.h         |   1 +
 25 files changed, 371 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi

-- 
2.22.0

