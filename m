Received: by mail-wm1-f53.google.com with SMTP id 4so6216876wmf.1
        for <u-boot-amlogic@groups.io>; Thu, 11 Apr 2019 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=9ZC0hdT6/oKIbWXAgjS6ZNZAWBozoKLKwnHdIXfFBU8=;
        b=wXYyMYkJpv2xpGsz5DOn4+hO8kKFq/9u32ZUDKyWSY5q2/nt2UF5WvMyg+dAta/Cry
         DtNa5RJMrJ86Z/MEsqqZUg9Fi7+TxEVpv0KOY7cbzV8RBKBRkm8CP9yDPtfJhtJYyEaG
         HPtSey/O1ZCGjgA65XvoQIUVV/0Rn36qRKl5ihFL4cUL+GKFX2hHPN3v6qN6ptsF6wUs
         ynE+YMnV8IreTQ7eoexiaG7s3QTdd36PElcA02TwXIko6q1o5/orYWJOQuLk8gR3uBvS
         kRQKWEBNIu9h5D7k1WxRoiZHECjfejAPsjv4hCMPVUaaXpSkqVlangieTdk5D+JXRWh3
         dhuw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190411
Message-ID: <0ccf82f4-9490-b40c-419a-93eea9691992@baylibre.com>
Date: Thu, 11 Apr 2019 13:16:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds support for 3 more Amlogic boards, support printing SoC
revision information, add AXG family support for I2C and Reset, then
fixup the AXG pinctrl defintions.

Thanks,
Neil

The following changes since commit 48ff1bc4f0a97c3291d0c87c2717fc1d79da5ef5:

  Merge branch '2019-04-09-master-imports-fs' (2019-04-10 08:18:18 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190411

for you to fetch changes up to 2c4e3cf21257f962e69264fe91ff2cc23cbd041a:

  pinctrl: meson: axg: Fix PIN and BANK offsets (2019-04-10 16:54:59 +0200)

----------------------------------------------------------------
- Add support for Amlogic p200 & p201 Reference Designs
- Add Amlogic SoC information display
- Add support for the Libretech-AC AML-S805X-AC board
- Add Amlogic AXG reset compatible
- Add I2C support for Amlogic AXG
- Fix AXG PIN and BANK pinctrl definitions

----------------------------------------------------------------
Guillaume La Roque (2):
      i2c: meson: add configurable divider factors
      pinctrl: meson: axg: Fix PIN and BANK offsets

Julien Masson (1):
      ARM: meson: display Amlogic SoC Information

Mohammad Rasim (5):
      ARM: board: meson: rename odroid-c2 to p200
      ARM: dts: meson: add p200 and p201 boards
      ARM: dts: meson: add u-boot.dtsi for p200 and p201
      ARM: board: meson: add p200 board
      ARM: board: meson: add p201 board

Neil Armstrong (3):
      ARM: dts: Import libretech-ac DT from Linux 5.0
      boards: Amlogic: Add support for Libretech-AC
      reset-meson: Add AXG reset compatible

 arch/arm/dts/Makefile                              |   3 +
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi           |   7 +
 arch/arm/dts/meson-gxbb-p200.dts                   |  99 ++++++
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi           |   7 +
 arch/arm/dts/meson-gxbb-p201.dts                   |  26 ++
 arch/arm/dts/meson-gxbb-p20x.dtsi                  | 247 ++++++++++++++
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      | 248 ++++++++++++++
 arch/arm/dts/meson-gxl.dtsi                        |  70 +++-
 arch/arm/mach-meson/Kconfig                        |   2 +-
 arch/arm/mach-meson/Makefile                       |   2 +-
 arch/arm/mach-meson/board-info.c                   | 166 ++++++++++
 board/amlogic/{odroid-c2 => p200}/MAINTAINERS      |   6 +-
 board/amlogic/{odroid-c2 => p200}/Makefile         |   2 +-
 board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 |   0
 board/amlogic/{odroid-c2 => p200}/README.odroid-c2 |   0
 board/amlogic/p200/README.p200                     | 103 ++++++
 .../amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} |   0
 board/amlogic/p201/MAINTAINERS                     |   5 +
 board/amlogic/p201/Makefile                        |   5 +
 board/amlogic/p201/README.p201                     | 103 ++++++
 board/amlogic/p201/p201.c                          |  43 +++
 board/amlogic/p212/MAINTAINERS                     |   1 +
 board/amlogic/p212/README.libretech-ac             | 103 ++++++
 configs/khadas-vim2_defconfig                      |   2 +-
 configs/khadas-vim_defconfig                       |   2 +-
 configs/libretech-ac_defconfig                     |  74 +++++
 configs/libretech-cc_defconfig                     |   2 +-
 configs/nanopi-k2_defconfig                        |   2 +-
 configs/odroid-c2_defconfig                        |   2 +-
 configs/p200_defconfig                             |  41 +++
 configs/p201_defconfig                             |  41 +++
 configs/p212_defconfig                             |   2 +-
 configs/s400_defconfig                             |   2 +-
 drivers/i2c/meson_i2c.c                            |  30 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c          | 358 ++++++++++-----------
 drivers/reset/reset-meson.c                        |   1 +
 include/configs/libretech-ac.h                     |  24 ++
 37 files changed, 1625 insertions(+), 206 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
 create mode 100644 arch/arm/mach-meson/board-info.c
 rename board/amlogic/{odroid-c2 => p200}/MAINTAINERS (70%)
 rename board/amlogic/{odroid-c2 => p200}/Makefile (82%)
 rename board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 (100%)
 rename board/amlogic/{odroid-c2 => p200}/README.odroid-c2 (100%)
 create mode 100644 board/amlogic/p200/README.p200
 rename board/amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} (100%)
 create mode 100644 board/amlogic/p201/MAINTAINERS
 create mode 100644 board/amlogic/p201/Makefile
 create mode 100644 board/amlogic/p201/README.p201
 create mode 100644 board/amlogic/p201/p201.c
 create mode 100644 board/amlogic/p212/README.libretech-ac
 create mode 100644 configs/libretech-ac_defconfig
 create mode 100644 configs/p200_defconfig
 create mode 100644 configs/p201_defconfig
 create mode 100644 include/configs/libretech-ac.h
