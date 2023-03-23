Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.66269.1679554503916756096
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 23:55:04 -0700
Received: by mail-wr1-f51.google.com with SMTP id m2so19335718wrh.6
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/rfveSi/7MiCJRpDSHMHlrwFV8N+wmoaO+LpWIFpDo=;
        b=VTJdtqhOYJ5ujZXkK5vmcAJe/A0eTKipaP0zuxDhfV4TPIn5NE6wPAd0JaYRu9ZpLB
         vyIJOnH+BT3OB2V8/BTKc8PSGLdy9GKLJ7rf/HubW93h6NfNLsitzNBWS0juWcg/QgKH
         SUvkab9G5UGhagxExqdEaZsjebEVfFllJk1F8OXnPRPFo7K1M23wVlQCzkK19ptur1E0
         gQdVvgII6NH5VY6W28IyipfMYZy4J/Ur4qTT1dtB3yfgUhRVdPPv4bhwzaL6agtkVkdF
         hE/0f7O9ekEGPmoahbKPr3HHHNsW9eT1I5tOKVeNhp7xAg0Nm2oYlyv7kiw3F8xMgSaE
         HHZQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 00/13] boards: amlogic: add BananaPi/Radxa/WeTek boards
Date: Thu, 23 Mar 2023 06:54:45 +0000
Message-Id: <20230323065458.776029-1-christianshewitt@gmail.com>
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

Christian Hewitt (13):
  docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
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
 doc/board/amlogic/bananapi-m2pro.rst          | 142 +++++
 doc/board/amlogic/bananapi-m2s.rst            | 152 +++++
 doc/board/amlogic/index.rst                   |   5 +
 doc/board/amlogic/radxa-zero2.rst             |  79 +++
 doc/board/amlogic/wetek-hub.rst               | 109 ++++
 doc/board/amlogic/wetek-play2.rst             | 114 ++++
 29 files changed, 3094 insertions(+), 428 deletions(-)
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

