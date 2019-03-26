Received: by mail-wr1-f66.google.com with SMTP id r4so5928955wrq.8
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsTFor0w2tpMk9wlyfFKntB2EYhdhUyAcmzeUEzYwqo=;
        b=Sv+NlrjvOf9Oyx+2yLCyuhwRHSRYytMWh4uQUuTDZCGjfwyLyZQyAHYxXwcvYrMXdB
         zMhGnSNpmQlk+XMn2wHdMROw/l+vDeD/uM8WSe2VQkd1nVgI7wJwvc/hfciAGWxbf4+P
         w7L+dLO0ZxIQSZpRip2A96R4qAtMc5cANhl0I13US2I7GarkyINCOYqaKTIN8CpatlLs
         PRUm/gtmmnIDNf8xeWdcOEFQ916Bfx2OuO4CZOdx4dm8EFr6z4aB6ecs5xp0uQpSd2ph
         AE//1K8Tr/a0HiaDGhBFySWDy90RT+ewO+/TKqultVN6ifuKQiqf7dkB/gDMzM0nuX5u
         Z46w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/2] ARM: meson: Add support for Libretech-AC
Date: Tue, 26 Mar 2019 11:20:33 +0100
Message-Id: <20190326102035.9239-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

LibreTech AC is a single board computer manufactured by Libre Technology
with the following specifications:

 - Amlogic S805X ARM Cortex-A53 quad-core SoC @ 1.2GHz
 - ARM Mali 450 GPU
 - 512MiB DDR4 SDRAM
 - 10/100 Ethernet
 - HDMI 2.0 4K/60Hz display
 - 40-pin GPIO header
 - 4 x USB 2.0 Host
 - eMMC, SPI NOR Flash
 - Infrared receiver

The u-boot specific code is the same as the P212 support,
so use the P212 board support code with a distinct defconfig
and config include files.

The patchset inports the DT from Linux 5.0 and add the corresponding
configs and update the MAINTAINERS files.

Neil Armstrong (2):
  ARM: dts: Import libretech-ac DT from Linux 5.0
  boards: Amlogic: Add support for Libretech-AC

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 248 ++++++++++++++++++
 arch/arm/dts/meson-gxl.dtsi                   |  70 ++++-
 board/amlogic/p212/MAINTAINERS                |   1 +
 board/amlogic/p212/README.libretech-ac        | 103 ++++++++
 configs/libretech-ac_defconfig                |  74 ++++++
 include/configs/libretech-ac.h                |  24 ++
 7 files changed, 512 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
 create mode 100644 board/amlogic/p212/README.libretech-ac
 create mode 100644 configs/libretech-ac_defconfig
 create mode 100644 include/configs/libretech-ac.h

-- 
2.21.0

