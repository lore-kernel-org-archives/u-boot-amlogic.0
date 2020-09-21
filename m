Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.36988.1600673660856593838
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Sep 2020 00:34:21 -0700
Received: by mail-wm1-f67.google.com with SMTP id e11so10888991wme.0
        for <u-boot-amlogic@groups.io>; Mon, 21 Sep 2020 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgXxSPwXG+NkSlP8YNPtHXK1BS6Q9gCnuvq885/HkGA=;
        b=q1ZZ7rVQMcyQT8Wte3kyxzro0NZdjFLkmmUpW3VfHe279X151lirwp7hAGiLHSfZZ/
         7e2odJLrx1epk7WNht9BZIi3jRwv8wT396Q6w3GCZjxSyUVjmv4sWXtGkY12JzHv9FAI
         D8JlXhQq8C+IZTLdK0Q774pbGi9ZvvYAf6QfhElgiLh4Rdpcxn84BSHzdvNdardT2kv9
         uX3kVyhIZ5koILVe/yadDpGU7QncnT/KvvMuzZq47ohjz1XxamJFWzkEsHpHqSzwrB3G
         NYUuVJSBmtD0X6CmuK//GjmrtFPyVGmz33kj072KHdxiomM3btfgOg8W+oT+cTmKSX9s
         lRlA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 0/4] amlogic: vim3: add support for dynamic PCIe enable
Date: Mon, 21 Sep 2020 09:34:11 +0200
Message-Id: <20200921073415.24211-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
an USB3.0 Type A connector and a M.2 Key M slot.
The PHY driving these differential lines is shared between
the USB3.0 controller and the PCIe Controller, thus only
a single controller can use it.

This serie adds a VIM3 specific board support and adds this dynamic
switching right before booting Linux.

Changes since v1:
- add missing khadas-mcu.h
- add documentation to switch pcie on/off

Neil Armstrong (4):
  ARM: dts: sync amlogic G12A/SM1 DT from Linux 5.9-rc1
  board: amlogic: add a vim3 specific board support
  configs: vim3: use the vim3 board support
  board: amlogic: vim3: add support for dynamic PCIe enable

 arch/arm/dts/meson-g12-common.dtsi            |  55 ++++---
 arch/arm/dts/meson-g12b-odroid-n2.dts         | 136 +++++++++++++++++-
 arch/arm/dts/meson-khadas-vim3.dtsi           |  26 +++-
 arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  92 ++++++++++++
 arch/arm/dts/meson-sm1-odroid-c4.dts          |  88 ++++++++++++
 board/amlogic/vim3/MAINTAINERS                |   9 ++
 board/amlogic/vim3/Makefile                   |   6 +
 board/amlogic/vim3/khadas-mcu.h               |  81 +++++++++++
 board/amlogic/vim3/vim3.c                     | 136 ++++++++++++++++++
 board/amlogic/w400/MAINTAINERS                |   4 -
 configs/khadas-vim3_defconfig                 |   5 +-
 configs/khadas-vim3l_defconfig                |   5 +-
 doc/board/amlogic/khadas-vim3.rst             |  27 ++++
 doc/board/amlogic/khadas-vim3l.rst            |  27 ++++
 include/dt-bindings/clock/g12a-clkc.h         |   2 +
 .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 ++
 16 files changed, 679 insertions(+), 30 deletions(-)
 create mode 100644 board/amlogic/vim3/MAINTAINERS
 create mode 100644 board/amlogic/vim3/Makefile
 create mode 100644 board/amlogic/vim3/khadas-mcu.h
 create mode 100644 board/amlogic/vim3/vim3.c
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h

-- 
2.22.0

