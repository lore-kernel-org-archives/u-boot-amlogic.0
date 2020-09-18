Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.9030.1600421353396264568
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 02:29:14 -0700
Received: by mail-wr1-f67.google.com with SMTP id s12so4880993wrw.11
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ia39DQWWDnUmFNRPnpoekN+yXSP5NpYUPsFnXwZ0xOA=;
        b=ccSCLXI3KY3WhkgIMiYBwo6FXIF2+JGnGfERh2ZdY2aKC1t0PUg2XVZPBJezo41hhy
         4fc2NX5ZttD2Bb9LsGUqmxiguQrIbollZ0UW6kYSzxwgnUrFiJ1OUbJmFXYCvmYstctK
         NAyd2wrZILQeN6mJM37F+EiVGdTA6dS02Yjd7Dr4yWhuUzOu618Bcv5ijd0XVXIQwn43
         oTM2oyNp3oBOXpIe0OiRcfotxtO6ioSsa1qJ852Im7hyzRDa8nXeaohb2QleCYC/AiSn
         9C1yHH/VSQkt6NtxJRlA/qzjPRet9ggM5FE9CHQ3bQj62Mze5VZTWjmAgmKnqMAHMguQ
         KKDg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/4] amlogic: vim3: add support for dynamic PCIe enable
Date: Fri, 18 Sep 2020 11:28:58 +0200
Message-Id: <20200918092902.28028-1-narmstrong@baylibre.com>
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
 board/amlogic/vim3/vim3.c                     | 136 ++++++++++++++++++
 board/amlogic/w400/MAINTAINERS                |   4 -
 configs/khadas-vim3_defconfig                 |   5 +-
 configs/khadas-vim3l_defconfig                |   5 +-
 include/dt-bindings/clock/g12a-clkc.h         |   2 +
 .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 ++
 13 files changed, 544 insertions(+), 30 deletions(-)
 create mode 100644 board/amlogic/vim3/MAINTAINERS
 create mode 100644 board/amlogic/vim3/Makefile
 create mode 100644 board/amlogic/vim3/vim3.c
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h

-- 
2.22.0

