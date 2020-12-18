Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.7205.1608281150773938192
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 00:45:51 -0800
Received: by mail-wr1-f53.google.com with SMTP id a12so1233409wrv.8
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 00:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/V6kRK58LlnO59vMsDPO/g4AAGgUL+SixCrZ+fN+04I=;
        b=rxY0ggxUCJi6cwQC6fcNfcTMFfxjp2Z83KsoS+2xggH4+uDx3h2MkgIpp9v63RTFgE
         v0cQlesCHZXnmH7vQuueyq8DljfrQcmLB31KTlHfX9FIX6baltbLXynXRcagtGU306Pv
         sVdktK9saCieuo89B0sYxY3oG4C8haoNcOzDbxKskytFO/XyM5LJ7JpagamcFGKVXzAc
         3jeYWZckKZTH0pAHRyLRwWb2V/Yc3E+nytA+ZYfb5puOlDBNBtMxGaRs+4ok/uIyziNS
         X8/j0fjFMc0d17oTOjGVhUsC8Z2rJOGpRyHGK4fXtWURvwLS7XMVt23tVy0soCJHrDOQ
         QyHQ==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/5] board: amlogic: add Beelink GT-King/Pro support
Date: Fri, 18 Dec 2020 08:45:40 +0000
Message-Id: <20201218084545.29135-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the Beelink GT-King and GT-King Pro boxes
based on the Amlogic S922X (G12B/W400) SoC. Patches are based on the
u-boot-amlogic-next branch in the custodians tree.

Christian Hewitt (5):
  ARM: dts: import Beelink GT-King/Pro DTs from Linux 5.10
  boards: amlogic: add Beelink S922X board family support
  boards: amlogic: add Beelink GT-King defconfig
  boards: amlogic: add Beelink GT-King Pro defconfig
  boards: amlogic: update documentation for Beelink GT-King/Pro

 arch/arm/dts/Makefile                       |   2 +
 arch/arm/dts/meson-g12b-gtking-pro.dts      | 125 ++++++
 arch/arm/dts/meson-g12b-gtking.dts          | 145 +++++++
 arch/arm/dts/meson-g12b-w400.dtsi           | 425 ++++++++++++++++++++
 board/amlogic/beelink-s922x/MAINTAINERS     |   9 +
 board/amlogic/beelink-s922x/Makefile        |   6 +
 board/amlogic/beelink-s922x/beelink-s922x.c |  54 +++
 configs/beelink-gtking_defconfig            |  71 ++++
 configs/beelink-gtkingpro_defconfig         |  71 ++++
 doc/board/amlogic/beelink-gtking.rst        | 115 ++++++
 doc/board/amlogic/beelink-gtkingpro.rst     | 116 ++++++
 doc/board/amlogic/index.rst                 |   4 +-
 12 files changed, 1142 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm/dts/meson-g12b-gtking.dts
 create mode 100644 arch/arm/dts/meson-g12b-w400.dtsi
 create mode 100644 board/amlogic/beelink-s922x/MAINTAINERS
 create mode 100644 board/amlogic/beelink-s922x/Makefile
 create mode 100644 board/amlogic/beelink-s922x/beelink-s922x.c
 create mode 100644 configs/beelink-gtking_defconfig
 create mode 100644 configs/beelink-gtkingpro_defconfig
 create mode 100644 doc/board/amlogic/beelink-gtking.rst
 create mode 100644 doc/board/amlogic/beelink-gtkingpro.rst

-- 
2.17.1

