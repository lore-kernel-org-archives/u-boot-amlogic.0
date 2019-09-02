From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 0/4] amlogic: Add Khadas VIM3 support
Date: Mon,  2 Sep 2019 14:19:06 +0200
Message-Id: <20190902121914.18946-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

This mini-series adds initial support for Amlogic A311D based Khadas VIM3=
.

v2 fixes an oversight and adds some cleanups.

Regards,
Andreas

v1 -> v2:
* Fixed branch name in README
* Mention linux-next tag for DT/header import (Neil)
* Avoid "Unknown" SoC output for A311D, fixing a typo while at it

Cc: Neil Armstrong <narmstrong@baylibre.com>

Andreas F=C3=A4rber (4):
  arm: dts: Import and update DT for Khadas VIM3
  configs: Add Khadas VIM3 defconfig
  arm: meson: Tidy SoC information output
  arm: meson: Recognize A311D SoC

 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++=
++++++
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
 arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
 arch/arm/dts/meson-g12b.dtsi                       |   39 +-
 arch/arm/mach-meson/board-info.c                   |    3 +-
 board/amlogic/w400/MAINTAINERS                     |    1 +
 board/amlogic/w400/README.khadas-vim3              |  132 ++
 configs/khadas-vim3_defconfig                      |   54 +
 include/dt-bindings/clock/g12a-clkc.h              |    6 +
 include/dt-bindings/power/meson-g12a-power.h       |   13 +
 .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
 13 files changed, 3427 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12-common.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
 create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
 create mode 100644 board/amlogic/w400/README.khadas-vim3
 create mode 100644 configs/khadas-vim3_defconfig
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-re=
set.h

--=20
2.16.4

