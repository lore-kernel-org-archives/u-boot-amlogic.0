Received: by mail-wr1-f65.google.com with SMTP id g17so88374884wrr.5
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vM6fbbIuJljoB68tmQmCgohv4rQ6AOwyTeLUU8qFVY=;
        b=1zSdOSFrbM1rR/UJzpxB+uznF9vM/EwuexG+cAe2IigXJefJsAiK5W+UMR3HeeaP+p
         E0unAYg0KjuXbSfOzpyBT6KLVMNkoox81nNJD0nY0z6uGCPnF2mgQFwx9QaHefC+VltQ
         l8LK7fI1+dWCfYXZK/NaWpLzHnxuRbPIOLmJ5PHef87NSsj2IcoiZeRQge6+ppm/DJL4
         lrAaNEXduyBXYpXAWipoPd+hyUcBU6ypZ2TOyUJjwLAh61Ss9HuvP/IHNDJfomCC+QQG
         Q7m2v8QnKN9NO8edXgDpO37wyVG+CZHm1yrKOsCkWT1mw8BDGTNLcUTMH8FTh7JJ47mO
         YmkA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 0/7] amlogic: add support for the SEI Robotic SEI510
Date: Tue,  6 Aug 2019 17:43:12 +0200
Message-Id: <20190806154319.10505-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SEI510 board is based on the Amlogic S905X2 SoC
from the Amlogic G12A SoC family.

The board has the following specifications :
- Amlogic S905X2 ARM Cortex-A53 quad-core SoC
- XGB DDR4 SDRAM
- 10/100 Ethernet (Internal PHY)
- 1 x USB 3.0 Host
- eMMC
- SDcard
- Infrared receiver
- SDIO WiFi Module

The board default behaviour is for booting Android and triggers
fastboot on recovery or reboot mode.

Changes since v1:
- moved sm and reboot_reason code into separate patches
- removed unused sm subcommand

Jerome Brunet (1):
  boards: meson: add g12a sei510

Neil Armstrong (6):
  ARM: dts: Import Amlogic G12A SEI510 DT from Linux 5.3-rc1
  configs: meson64: permit redefining ENV_SIZE
  arm: meson: add sm cmd to retrieve SoC serial
  arm: meson: add sm command to retrieve the reboot reason
  ARM: meson: Add support for fastboot_set_reboot_flag()
  configs: sei510: disable PSCI_RESET to support fastboot reboot_flag

 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/meson-g12a-sei510.dts   | 502 +++++++++++++++++++++++++++
 arch/arm/include/asm/arch-meson/sm.h |  18 +
 arch/arm/mach-meson/board-common.c   |  33 ++
 arch/arm/mach-meson/sm.c             | 133 +++++++
 board/amlogic/sei510/MAINTAINERS     |   5 +
 board/amlogic/sei510/Makefile        |   6 +
 board/amlogic/sei510/README          | 123 +++++++
 board/amlogic/sei510/sei510.c        |  26 ++
 configs/sei510_defconfig             |  75 ++++
 include/configs/meson64.h            |   2 +
 include/configs/sei510.h             | 137 ++++++++
 12 files changed, 1061 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12a-sei510.dts
 create mode 100644 board/amlogic/sei510/MAINTAINERS
 create mode 100644 board/amlogic/sei510/Makefile
 create mode 100644 board/amlogic/sei510/README
 create mode 100644 board/amlogic/sei510/sei510.c
 create mode 100644 configs/sei510_defconfig
 create mode 100644 include/configs/sei510.h

-- 
2.22.0

