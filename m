Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.73869.1679581908329692156
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 07:31:48 -0700
Received: by mail-wr1-f44.google.com with SMTP id t15so20729461wrz.7
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtxHLyfxfeURVa6Qi3viuNcHaP6ddTRNB/n+wSrkxmM=;
        b=k8i1idWb+1qe0e4dzQXM6oqJkbuS45jmp4V5Z8O0vvtJ+8aWCZnSqH8odyh1n566SG
         X1diQNc1+PI5D4PxEpF+bCDAbRGDhnn8RYIhkAOPlM3IU3Y6lsUHNunqtPR6itxKEGK3
         ApdfLU2bqLMj65O14I/yiVQLRnqJGtSw/qjXAsmihkvIH4A83tvLxT80FeHMdkueVG7Y
         mVSkxmVb8ucvA6hStNGVOmdBj+i1UBTzHN5F1yP2V0VIQot7YtqWVMXLhAtHnO3FzWwg
         ZOiyDzK0ZP09ktqHcoxS2ACMOmLozwYo57zvv6W/kHI4LFDPeEHSondriO+zo2Mth/p7
         tUdA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH v2 00/14] boards: amlogic: add BananaPi/Radxa/WeTek boards
Date: Thu, 23 Mar 2023 14:31:28 +0000
Message-Id: <20230323143142.780306-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This series adds support for the following boards which are
tested and booting fine with 2023.04-rc4:

- BananaPi M2-Pro (S905X3)
- BananaPi M2S (A311D or S922X)
- Radxa Zero2 (A311D)
- WeTek Hub (S905)
- WeTek Play2 (S905)

I also spotted that bananapi-m5 wasn't referrences in the u200
maintainer file so there's a patch to correct that too.

Changes since v1:
- Add reviews on M2-Pro/M2S/Zero2 dts/config patches
- Add a patch to correct a missing blank line in recently updated docs
- Fix commit message for Hub/Play2 config patch

Christian Hewitt (14):
  docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
  docs: boards: amlogic: fix blank-line typo in recently updated docs
  ARM: dts: add support for BananaPi M2-Pro
  boards: add BananaPi M2-Pro defconfig
  docs: boards: amlogic: add documentation for BananaPi M2-Pro
  ARM: dts: add support for BananaPi M2S
  boards: add BananaPi M2S defconfig
  docs: boards: amlogic: add documentation for BananaPi M2S
  ARM: dts: add support for Radxa Zero2
  boards: amlogic: add Radxa Zero2 defconfig
  doc: boards: amlogic: add documentation for Radxa Zero2
  ARM: dts: add support for WeTek Hub and WeTek Play2
  boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
  doc: boards: amlogic: add documentation for WeTek Hub and WeTek Play2

 arch/arm/dts/Makefile                         |   9 +-
 .../arm/dts/meson-g12b-a311d-bananapi-m2s.dts |  33 ++
 arch/arm/dts/meson-g12b-bananapi-u-boot.dtsi  |   7 +
 arch/arm/dts/meson-g12b-bananapi.dtsi         | 521 ++++++++++++++++++
 .../dts/meson-g12b-radxa-zero2-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-g12b-radxa-zero2.dts       | 489 ++++++++++++++++
 .../arm/dts/meson-g12b-s922x-bananapi-m2s.dts |  14 +
 arch/arm/dts/meson-gxbb-wetek-hub.dts         |  58 ++
 arch/arm/dts/meson-gxbb-wetek-play2.dts       | 119 ++++
 arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi     |  13 +
 arch/arm/dts/meson-gxbb-wetek.dtsi            | 292 ++++++++++
 .../dts/meson-sm1-bananapi-m2-pro-u-boot.dtsi |  14 +
 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts    |  97 ++++
 arch/arm/dts/meson-sm1-bananapi-m5.dts        | 427 +-------------
 arch/arm/dts/meson-sm1-bananapi.dtsi          | 435 +++++++++++++++
 board/amlogic/p200/MAINTAINERS                |   4 +
 board/amlogic/u200/MAINTAINERS                |   3 +
 board/amlogic/w400/MAINTAINERS                |   4 +
 configs/bananapi-m2-pro_defconfig             |  76 +++
 configs/bananapi-m2s_defconfig                |  82 +++
 configs/radxa-zero2_defconfig                 |  77 +++
 configs/wetek-hub_defconfig                   |  70 +++
 configs/wetek-play2_defconfig                 |  70 +++
 doc/board/amlogic/bananapi-cm4io.rst          |   1 +
 doc/board/amlogic/bananapi-m2pro.rst          | 143 +++++
 doc/board/amlogic/bananapi-m2s.rst            | 153 +++++
 doc/board/amlogic/bananapi-m5.rst             |   1 +
 doc/board/amlogic/beelink-gskingx.rst         |   1 +
 doc/board/amlogic/beelink-gtking.rst          |   1 +
 doc/board/amlogic/beelink-gtkingpro.rst       |   1 +
 doc/board/amlogic/index.rst                   |   5 +
 doc/board/amlogic/jethub-j100.rst             |   1 +
 doc/board/amlogic/jethub-j80.rst              |   1 +
 doc/board/amlogic/khadas-vim.rst              |   1 +
 doc/board/amlogic/khadas-vim2.rst             |   1 +
 doc/board/amlogic/khadas-vim3.rst             |   1 +
 doc/board/amlogic/khadas-vim3l.rst            |   1 +
 doc/board/amlogic/libretech-ac.rst            |   1 +
 doc/board/amlogic/libretech-cc.rst            |   1 +
 doc/board/amlogic/nanopi-k2.rst               |   1 +
 doc/board/amlogic/odroid-c2.rst               |   1 +
 doc/board/amlogic/odroid-c4.rst               |   1 +
 doc/board/amlogic/odroid-go-ultra.rst         |   1 +
 doc/board/amlogic/odroid-hc4.rst              |   1 +
 doc/board/amlogic/odroid-n2.rst               |   1 +
 doc/board/amlogic/odroid-n2l.rst              |   1 +
 doc/board/amlogic/p200.rst                    |   1 +
 doc/board/amlogic/p201.rst                    |   1 +
 doc/board/amlogic/q200.rst                    |   1 +
 doc/board/amlogic/radxa-zero.rst              |   1 +
 doc/board/amlogic/radxa-zero2.rst             |  80 +++
 doc/board/amlogic/s400.rst                    |   1 +
 doc/board/amlogic/sei510.rst                  |   1 +
 doc/board/amlogic/sei610.rst                  |   1 +
 doc/board/amlogic/u200.rst                    |   1 +
 doc/board/amlogic/w400.rst                    |   1 +
 doc/board/amlogic/wetek-core2.rst             |   1 +
 doc/board/amlogic/wetek-hub.rst               | 110 ++++
 doc/board/amlogic/wetek-play2.rst             | 115 ++++
 59 files changed, 3129 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts
 create mode 100644 arch/arm/dts/meson-g12b-bananapi-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-bananapi.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-radxa-zero2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-radxa-zero2.dts
 create mode 100644 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts
 create mode 100644 arch/arm/dts/meson-sm1-bananapi.dtsi
 create mode 100644 configs/bananapi-m2-pro_defconfig
 create mode 100644 configs/bananapi-m2s_defconfig
 create mode 100644 configs/radxa-zero2_defconfig
 create mode 100644 configs/wetek-hub_defconfig
 create mode 100644 configs/wetek-play2_defconfig
 create mode 100644 doc/board/amlogic/bananapi-m2pro.rst
 create mode 100644 doc/board/amlogic/bananapi-m2s.rst
 create mode 100644 doc/board/amlogic/radxa-zero2.rst
 create mode 100644 doc/board/amlogic/wetek-hub.rst
 create mode 100644 doc/board/amlogic/wetek-play2.rst

-- 
2.34.1

