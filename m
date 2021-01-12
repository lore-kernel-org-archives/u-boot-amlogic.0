Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.11787.1610469598273428389
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Jan 2021 08:39:59 -0800
Received: by mail-wr1-f52.google.com with SMTP id r7so3181983wrc.5
        for <u-boot-amlogic@groups.io>; Tue, 12 Jan 2021 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=opQp1F2+0m0gcbId8nauqil2wucoa+IjFw/ax4DGi+k=;
        b=2JgcP0lpYD3BBkVDCgBlZGfY5SGcJg8thP5+lCRT/YcRJGhCTZjyspVIOsfZ7kBukn
         41e8TJ0Zhqac5xOH16Bf7F+kIqSa4vb/7XVCUYaUliKGcN0f9jC5HQOohol6IDwZV33L
         a5RTpBwS+D9MY9DqIZRVqwll/2uKUDUOrUuGcsQvGQgHgYCq4PVhC33T50u2jt2tebGf
         FVrNYHGugB3IZzesdGu0sqj5ItgeCuffmSuLUVXRKQmI0ZgV3WprobowlOPoaM1gIQnL
         qUpq7zUSzua5Jw87oTr1QOOmDlNzLBwA11Vw+Etz/I8R/vhSJj2EnPLLv0n5vxuOpZD+
         qlbg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210112
Reply-To: narmstrong@baylibre.com
Message-ID: <c4315c42-2711-c40f-f843-9cef24a24f20@baylibre.com>
Date: Tue, 12 Jan 2021 17:39:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

These are the changes for the next release, in brief is adds some features to the VIM3 boards
(drivers fro function button detect using ADC, mac from efuses), new boards (V2 of libretech-cc,
GT-King/Pro and Wetek Core2), all this with DT sync'ed over Linux 5.10 with new Power Domain
driver support. A new DSI panel driver has been added, the rest of support will come next (PHYs, ...).

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/5836

Thanks,
Neil

The following changes since commit c8f2a060a15b8a21cef90c82cc49f70517356a50:

  xea: config: Disable CONFIG_SPL_OF_PLATDATA_PARENT on XEA (imx28) (2021-01-08 08:42:08 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210112

for you to fetch changes up to 6bfa331a6e22507ae839fb8474ce1b3fd58808df:

  board: amlogic: vim3: fix setup ethernet mac from efuse (2021-01-12 14:25:55 +0100)

----------------------------------------------------------------
- sync amlogic GX & AXG DT to Linux 5.10
- Add new MESON_EE driver support for GXBB & AXG
- Add support for Libretech-CC v2, Wetek Core2, Beelink GT-King/Pro boards
- add driver for TDO tl070wsh30 panel driver
- meson: isolate loading of socinfo
- Add soc_rev to environment
- Enable G12A support for saradc
- Add correct mmcdev on VIM3(L) & Odroid-N2(C4)
- Read MAC from fuses for VIM3 & VIM3L boards

----------------------------------------------------------------
Artem Lapkin (1):
      board: amlogic: vim3: fix setup ethernet mac from efuse

Christian Hewitt (8):
      ARM: dts: import WeTek Core2 DTs from Linux 5.10
      boards: amlogic: add WeTek Core2 support
      boards: amlogic: update documentation for WeTek Core2
      ARM: dts: import Beelink GT-King/Pro DTs from Linux 5.10
      boards: amlogic: add Beelink S922X board family support
      boards: amlogic: add Beelink GT-King defconfig
      boards: amlogic: add Beelink GT-King Pro defconfig
      boards: amlogic: update documentation for Beelink GT-King/Pro

Heinrich Schuchardt (1):
      adc: meson-saradc: use correct printf code

Jerome Brunet (2):
      arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
      arm64: meson: add support for libretech-cc v2

Marek Szyprowski (6):
      clk: meson: add minimal driver for g12a-ao clocks
      adc: meson-saradc: add G12A variant
      adc: meson-saradc: skip hardware init only if ADC is enabled
      configs: khadas-vim3: enable ADC device support
      board: amlogic: vim3: read ethernet MAC address from efuse
      board: amlogic: add MMC boot device detection for environment load

Neil Armstrong (5):
      ARM: dts: sync Amlogic GX & AXG from Linux 5.10-rc1
      power: domain: meson-ee-pwrc: add support for the Meson GX SoCs
      power: domain: meson-ee-pwrc: add support for the Meson AXG SoCs
      configs: use the new MESON_EE_POWER_DOMAIN driver for Amlogic GXBB/GXL/GXM boards
      video: add TDO tl070wsh30 panel driver

Pascal Vizeli (1):
      meson: Add soc_rev to environment

Stefan Agner (1):
      ARM: meson: isolate loading of socinfo

 arch/arm/dts/Makefile                              |   5 +
 arch/arm/dts/meson-axg.dtsi                        |   6 +-
 arch/arm/dts/meson-g12b-gtking-pro.dts             | 125 +++++
 arch/arm/dts/meson-g12b-gtking.dts                 | 145 +++++
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  88 ---
 arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |  31 +
 arch/arm/dts/meson-g12b-odroid-n2.dts              | 618 +-------------------
 arch/arm/dts/meson-g12b-odroid-n2.dtsi             | 625 +++++++++++++++++++++
 arch/arm/dts/meson-g12b-w400.dtsi                  | 425 ++++++++++++++
 arch/arm/dts/meson-gx-mali450.dtsi                 |  61 ++
 arch/arm/dts/meson-gx-p23x-q20x.dtsi               | 324 +++++++++++
 arch/arm/dts/meson-gx.dtsi                         |  18 +-
 arch/arm/dts/meson-gxbb.dtsi                       |  63 +--
 arch/arm/dts/meson-gxl-mali.dtsi                   |  46 +-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 arch/arm/dts/meson-gxl-s805x.dtsi                  |  23 +
 .../meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 +++++++++++
 arch/arm/dts/meson-gxl.dtsi                        |  17 +-
 arch/arm/dts/meson-gxm-wetek-core2-u-boot.dtsi     |   7 +
 arch/arm/dts/meson-gxm-wetek-core2.dts             |  87 +++
 arch/arm/dts/meson-gxm.dtsi                        |  45 +-
 arch/arm/dts/meson-khadas-vim3.dtsi                |  94 +++-
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  86 ---
 arch/arm/include/asm/arch-meson/boot.h             |   4 +
 arch/arm/mach-meson/board-info.c                   |  26 +-
 board/amlogic/beelink-s922x/MAINTAINERS            |   9 +
 board/amlogic/beelink-s922x/Makefile               |   6 +
 board/amlogic/beelink-s922x/beelink-s922x.c        |  54 ++
 board/amlogic/odroid-n2/odroid-n2.c                |  13 +
 board/amlogic/p212/MAINTAINERS                     |   1 +
 board/amlogic/q200/MAINTAINERS                     |   2 +
 board/amlogic/vim3/vim3.c                          |  39 ++
 configs/beelink-gtking_defconfig                   |  71 +++
 configs/beelink-gtkingpro_defconfig                |  71 +++
 configs/khadas-vim3_defconfig                      |   2 +
 configs/khadas-vim3l_defconfig                     |   2 +
 configs/libretech-ac_defconfig                     |   2 +-
 configs/libretech-cc_defconfig                     |   2 +-
 configs/libretech-cc_v2_defconfig                  |  82 +++
 configs/libretech-s905d-pc_defconfig               |   2 +-
 configs/libretech-s912-pc_defconfig                |   2 +-
 configs/odroid-c2_defconfig                        |   2 +-
 configs/wetek-core2_defconfig                      |  70 +++
 doc/board/amlogic/beelink-gtking.rst               | 115 ++++
 doc/board/amlogic/beelink-gtkingpro.rst            | 116 ++++
 doc/board/amlogic/index.rst                        | 123 ++--
 doc/board/amlogic/libretech-cc.rst                 |  17 +-
 doc/board/amlogic/wetek-core2.rst                  |  96 ++++
 drivers/adc/meson-saradc.c                         |  11 +-
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a-ao.c                        |  83 +++
 drivers/power/domain/meson-ee-pwrc.c               |  52 +-
 drivers/video/Kconfig                              |   9 +
 drivers/video/Makefile                             |   1 +
 drivers/video/tdo-tl070wsh30.c                     | 155 +++++
 include/dt-bindings/power/meson-axg-power.h        |  14 +
 include/dt-bindings/power/meson-gxbb-power.h       |  13 +
 58 files changed, 3556 insertions(+), 978 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm/dts/meson-g12b-gtking.dts
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-plus.dts
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-w400.dtsi
 create mode 100644 arch/arm/dts/meson-gx-mali450.dtsi
 create mode 100644 arch/arm/dts/meson-gx-p23x-q20x.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s805x.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
 create mode 100644 arch/arm/dts/meson-gxm-wetek-core2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-wetek-core2.dts
 create mode 100644 board/amlogic/beelink-s922x/MAINTAINERS
 create mode 100644 board/amlogic/beelink-s922x/Makefile
 create mode 100644 board/amlogic/beelink-s922x/beelink-s922x.c
 create mode 100644 configs/beelink-gtking_defconfig
 create mode 100644 configs/beelink-gtkingpro_defconfig
 create mode 100644 configs/libretech-cc_v2_defconfig
 create mode 100644 configs/wetek-core2_defconfig
 create mode 100644 doc/board/amlogic/beelink-gtking.rst
 create mode 100644 doc/board/amlogic/beelink-gtkingpro.rst
 create mode 100644 doc/board/amlogic/wetek-core2.rst
 create mode 100644 drivers/clk/meson/g12a-ao.c
 create mode 100644 drivers/video/tdo-tl070wsh30.c
 create mode 100644 include/dt-bindings/power/meson-axg-power.h
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
