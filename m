Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.254.1571410689134616446
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Oct 2019 07:58:09 -0700
Received: by mail-wm1-f67.google.com with SMTP id r19so6526803wmh.2
        for <u-boot-amlogic@groups.io>; Fri, 18 Oct 2019 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=1IymGzKA9gGgK5wYYr7KfkoDSRqX4eDRD89uwLTbBKs=;
        b=Gb+Gt8wsrRzqLmC5k6gE/jBp2D2/HHFjTR46T9i8iZ9NtClAPnTgH9Ci2jm7KSwcLP
         v/eGgBwnaLd1pumbt4EYvQx3nYACqENwDlFVNIae2h+rXEybwUMa1FLwk/rTZuLDZ651
         icsHsvXYHapPY+mrLtc3AqIP3KWzT/XWpyNEK8iyiBem6M9ZgKI1xRLSlKQHrcQ0qawe
         jeV8yz/qeunkcv0Saxf4s6jg9rlMuIzvZrN4PL4oMlv8PQcygTzmzKR24GAYBfXLekYD
         FVJDXEtXSHBWCNklSSD+JKP5TX8O+pHvwD8BPNTG2l0ZI0RdmtoPMnO/iMxVuQWD9mUW
         CcEg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20191018
Message-ID: <e59e20b3-8cda-06a5-eae7-a97c419c1657@baylibre.com>
Date: Fri, 18 Oct 2019 16:58:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds more support for Amlogic G12A and derivatives SoCs based boards, by enabling
HDMI/CVBS display support and 2 new boards, Khadas VIM3, and the SEI610 little brother of
the already supported SEI510.
Daniel also pushed a documentation update to explicit the available alternatives to the currently
used blobs and tools to created a bootable binary.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/1012

Thanks,
Neil

The following changes since commit a2fce50455c9831f36765e5813b0b5e98f55d70b:

  Merge tag 'for-v2020.01' of https://gitlab.denx.de/u-boot/custodians/u-boot-ubi (2019-10-17 07:26:16 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20191018

for you to fetch changes up to be2ffa1656509cc974910224a87443868d7037d9:

  configs: sei610: Add config file to fix userdata size (2019-10-18 14:54:37 +0200)

----------------------------------------------------------------
- document alternative libretech-cc installation methods, including upstream TF-A and opensource tools
- add HDMI/CVBS display support for Amlogic G12A SoCs and SEI510 board
- add support for Amlogic A311D based Khadas VIM3
- add support for Amlogic S905X3 based SEI610 board, targeting Android support like SEI510

----------------------------------------------------------------
Andreas Färber (4):
      arm: dts: Import and update DT for Khadas VIM3
      configs: Add Khadas VIM3 defconfig
      arm: meson: Tidy SoC information output
      arm: meson: Recognize A311D SoC

Daniel Drake (1):
      board: amlogic: document alternative libretech-cc installation methods

Guillaume La Roque (2):
      configs: sei510: rework header and fix userdata size
      configs: sei610: Add config file to fix userdata size

Neil Armstrong (16):
      power: domain: meson-gx-pwrc: add G12A support
      clk: meson: g12a: add support for VPU/HDMI clocks
      video: meson: remove power domain get
      video: meson: sync with linux drm-misc tree
      video: meson: add compatible for Amlogic G12A
      arm: meson: board-g12a: Setup VPU in fdt
      ARM: dts: meson-g12a: add U-Boot specific DT for graphics
      configs: sei510: enable Video Display support
      ARM: meson: add SM1 SoC id
      mmc: meson-gx: add support for mmc-pwrseq-emmc
      clk: meson-sm1: add compatible
      ARM: dts: Import SEI610 DT from Linux 5.4-rc2
      power: domain: add Amlogic Everything-Else power domain driver
      configs: sei510: enable everything-else power domain
      ARM: dts: meson-sm1: add U-Boot specific DT for graphics
      boards: amlogic: add SEI610 support

 MAINTAINERS                                        |    1 +
 arch/arm/dts/Makefile                              |    4 +-
 arch/arm/dts/meson-g12-common-u-boot.dtsi          |   29 +
 arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++++++++
 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi         |    7 +
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi           |    7 +
 arch/arm/dts/meson-g12a.dtsi                       | 2422 +------------------
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   16 +
 arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  189 ++
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi      |    7 +
 arch/arm/dts/meson-g12b-odroid-n2.dts              |  104 +-
 arch/arm/dts/meson-g12b-s922x.dtsi                 |  124 +
 arch/arm/dts/meson-g12b.dtsi                       |   39 +-
 arch/arm/dts/meson-khadas-vim3.dtsi                |  360 +++
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi          |    7 +
 arch/arm/dts/meson-sm1-sei610.dts                  |  383 +++
 arch/arm/dts/meson-sm1.dtsi                        |  147 ++
 arch/arm/mach-meson/board-g12a.c                   |    5 +
 arch/arm/mach-meson/board-info.c                   |    5 +-
 board/amlogic/p212/README.libretech-cc             |   41 +-
 board/amlogic/sei610/MAINTAINERS                   |    7 +
 board/amlogic/sei610/Makefile                      |    6 +
 board/amlogic/sei610/README                        |  119 +
 board/amlogic/sei610/sei610.c                      |   26 +
 board/amlogic/w400/MAINTAINERS                     |    1 +
 board/amlogic/w400/README.khadas-vim3              |  132 ++
 configs/khadas-vim3_defconfig                      |   54 +
 configs/sei510_defconfig                           |   11 +
 configs/sei610_defconfig                           |   76 +
 drivers/clk/meson/g12a.c                           |  621 ++++-
 drivers/mmc/meson_gx_mmc.c                         |   51 +
 drivers/power/domain/Kconfig                       |    7 +
 drivers/power/domain/Makefile                      |    1 +
 drivers/power/domain/meson-ee-pwrc.c               |  430 ++++
 drivers/power/domain/meson-gx-pwrc-vpu.c           |  155 +-
 drivers/video/meson/meson_dw_hdmi.c                |   61 +-
 drivers/video/meson/meson_plane.c                  |   47 +-
 drivers/video/meson/meson_registers.h              |  373 ++-
 drivers/video/meson/meson_vclk.c                   |  233 +-
 drivers/video/meson/meson_venc.c                   |  169 +-
 drivers/video/meson/meson_vpu.c                    |   11 +-
 drivers/video/meson/meson_vpu.h                    |    2 +
 drivers/video/meson/meson_vpu_init.c               |  205 +-
 include/configs/meson64_android.h                  |  136 ++
 include/configs/sei510.h                           |  113 +-
 include/configs/sei610.h                           |   31 +
 include/dt-bindings/clock/g12a-clkc.h              |    6 +
 include/dt-bindings/power/meson-g12a-power.h       |   13 +
 include/dt-bindings/power/meson-sm1-power.h        |   18 +
 .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
 51 files changed, 6941 insertions(+), 2693 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12-common.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
 create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-s922x.dtsi
 create mode 100644 arch/arm/dts/meson-khadas-vim3.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-sei610.dts
 create mode 100644 arch/arm/dts/meson-sm1.dtsi
 create mode 100644 board/amlogic/sei610/MAINTAINERS
 create mode 100644 board/amlogic/sei610/Makefile
 create mode 100644 board/amlogic/sei610/README
 create mode 100644 board/amlogic/sei610/sei610.c
 create mode 100644 board/amlogic/w400/README.khadas-vim3
 create mode 100644 configs/khadas-vim3_defconfig
 create mode 100644 configs/sei610_defconfig
 create mode 100644 drivers/power/domain/meson-ee-pwrc.c
 create mode 100644 include/configs/meson64_android.h
 create mode 100644 include/configs/sei610.h
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/power/meson-sm1-power.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
