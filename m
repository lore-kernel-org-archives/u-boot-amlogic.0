Received: by mail-wr1-f66.google.com with SMTP id p17so61908461wrf.11
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ra2fFbiYdkqDO3lfNVBLZOd88RYMUqJ7Ndf/NUkkH8Q=;
        b=sLSXZzW2tmLtbgI6KE4Q4DZU+JL0Hw2woL22H91FiNBUQa16HjbDCErXRx5vatiaDx
         l1EP0cO6boJQiVBY0AlP3hK+PPqv6cV7fvvNgh91Wcb9xgZDics+517utEWOYdHHPk6G
         8efPRGSCS7HMb+0h1oNqMC06OSTbhakR+ileCpcyKUgQ37+pouTjgi16FEHtokW2csMN
         2CkjYj5L2zilEd5eUlwOmjbWMjkHSeTNGzHjwMcvtDuvEfSFV2kJvUfQvhlhPC1AztCo
         eUK8N3KRsBOQtGcDXDaiAz2Zl8bWgmrRgtEgjxDcNcXX7LasgGuHgyGfnM6Tk4zcPgfz
         Yk1g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] amlogic: Add support for Odroid-N2
Date: Mon, 29 Jul 2019 15:45:49 +0200
Message-Id: <20190729134552.8860-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

ODROID-N2 is a single board computer manufactured by Hardkernel Co. Ltd
with the following specifications:

 - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
 - 4GB DDR4 SDRAM
 - Gigabit Ethernet
 - HDMI 2.1 4K/60Hz display
 - 40-pin GPIO header
 - 4 x USB 3.0 Host, 1 x USB OTG
 - eMMC, microSD
 - Infrared receiver

This patchset :
- adds the Odroid-N2 from Linux 5.3-rc1
- fixes 4GiB memory support
- adds board support

The board directory is W400, the name of the Amlogic Reference Design
of Amlogic G12B with Gigabit boards, which will be used for similar
boards.

Changes since v1:
- Fix typo in README.odroid-n2

Neil Armstrong (3):
  ARM: dts: add support for Odroid-N2
  ARM: meson-g12a: Handle 4GiB DRAM size
  board: amlogic: add support for Odroid-N2

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/meson-g12b-odroid-n2.dts         | 386 ++++++++++++++++++
 arch/arm/dts/meson-g12b.dtsi                  |  82 ++++
 arch/arm/mach-meson/board-g12a.c              |  13 +-
 board/amlogic/w400/MAINTAINERS                |   6 +
 board/amlogic/w400/Makefile                   |   6 +
 board/amlogic/w400/README.odroid-n2           | 130 ++++++
 board/amlogic/w400/README.w400                | 130 ++++++
 board/amlogic/w400/w400.c                     |  18 +
 configs/odroid-n2_defconfig                   |  56 +++
 .../dt-bindings/sound/meson-g12a-tohdmitx.h   |  13 +
 11 files changed, 836 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm/dts/meson-g12b.dtsi
 create mode 100644 board/amlogic/w400/MAINTAINERS
 create mode 100644 board/amlogic/w400/Makefile
 create mode 100644 board/amlogic/w400/README.odroid-n2
 create mode 100644 board/amlogic/w400/README.w400
 create mode 100644 board/amlogic/w400/w400.c
 create mode 100644 configs/odroid-n2_defconfig
 create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h

-- 
2.22.0

