Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.1821.1570808043617184962
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:04 -0700
Received: by mail-wm1-f67.google.com with SMTP id i16so10866825wmd.3
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvmDKD3KEDAfPy6WEdt2Eh3n5PUt/plWNnz3VgcO+6w=;
        b=GhakUyDUdObiQwWl47UK4ORJqmLI1hqbX7hZfv1zc/Q2qQUebiSIheJQw/J28M0x1s
         wV8fPfq0D7u19wnUueAuUx21CwlThDcjY0Q3uRiPWB+ZW2gElaJOfO0zCqsPSW6vbyGZ
         bIwCkTWpjMoYmaXbQRspv07AhgZNiavy/QkbRYjx5JT/VONNkkuLCvTVpDBj/P/2MVdX
         0zH83gEKLv56eEegODCUz1HM1Eqy0VRVq5DBOxtlTJ8JDNJbyOYYIR5+zLZDtFLEukXb
         ecsGPgmXIlhbH693SXSVexyplHlJTqR2k3bz4HUPlP+vW20kciYMUBFJPbVPpuxjiWKp
         dOFA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/8] amlogic: add SEI610 support
Date: Fri, 11 Oct 2019 17:33:50 +0200
Message-Id: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the customer board SEI610 manufactured by SEI Robotics
with the following specifications:
 - Amlogic S905X3 ARM Cortex-A35 quad-core SoC
 - 2GB DDR4 SDRAM
 - 10/100 Ethernet (Internal PHY)
 - 1 x USB 3.0 Host
 - 1 x USB Type-C DRD
 - 1 x FTDI USB Serial Debug Interface
 - eMMC
 - SDcard
 - Infrared receiver
 - SDIO WiFi Module

Like it's SEI510 counterpart, the boot flow is designed to boot
Android AOSP built for the Yukawa Android device.

The SM1 SoC is very close to G12A, so it uses the same arm board code
and reuses what was pushed for SEI510.

For that it needs to reuse the SEI510 android boot flow into
a common flow with custom partitions for each board.

Guillaume La Roque (2):
  configs: sei510: rework header and fix userdata size
  configs: sei610: Add config file to fix userdata size

Neil Armstrong (6):
  ARM: meson: add SM1 SoC id
  mmc: meson-gx: add support for mmc-pwrseq-emmc
  clk: meson-sm1: add compatible
  ARM: dts: Import SEI610 DT from Linux 5.4-rc2
  ARM: dts: meson-sm1: add U-Boot specific DT for graphics
  boards: amlogic: add SEI610 support

 MAINTAINERS                                   |   1 +
 arch/arm/dts/Makefile                         |   3 +-
 ...boot.dtsi => meson-g12-common-u-boot.dtsi} |   0
 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi    |   2 +-
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |   2 +-
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |   2 +-
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |   7 +
 arch/arm/dts/meson-sm1-sei610.dts             | 383 ++++++++++++++++++
 arch/arm/dts/meson-sm1.dtsi                   | 147 +++++++
 arch/arm/mach-meson/board-info.c              |   2 +
 board/amlogic/sei610/MAINTAINERS              |   7 +
 board/amlogic/sei610/Makefile                 |   6 +
 board/amlogic/sei610/README                   | 119 ++++++
 board/amlogic/sei610/sei610.c                 |  26 ++
 configs/sei610_defconfig                      |  76 ++++
 drivers/clk/meson/g12a.c                      |   1 +
 drivers/mmc/meson_gx_mmc.c                    |  51 +++
 include/configs/meson64_android.h             | 136 +++++++
 include/configs/sei510.h                      | 121 +-----
 include/configs/sei610.h                      |  31 ++
 include/dt-bindings/power/meson-sm1-power.h   |  18 +
 21 files changed, 1018 insertions(+), 123 deletions(-)
 rename arch/arm/dts/{meson-g12a-u-boot.dtsi => meson-g12-common-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-sei610.dts
 create mode 100644 arch/arm/dts/meson-sm1.dtsi
 create mode 100644 board/amlogic/sei610/MAINTAINERS
 create mode 100644 board/amlogic/sei610/Makefile
 create mode 100644 board/amlogic/sei610/README
 create mode 100644 board/amlogic/sei610/sei610.c
 create mode 100644 configs/sei610_defconfig
 create mode 100644 include/configs/meson64_android.h
 create mode 100644 include/configs/sei610.h
 create mode 100644 include/dt-bindings/power/meson-sm1-power.h

-- 
2.22.0

