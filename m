Received: by mail-wr1-f45.google.com with SMTP id b1so7927931wru.3
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=LU4HzE35frL41CHca/H9m8WCjrGhQrHZVkH/4CTkA88=;
        b=RJJDt7WpjOKdizl6IV83bZZ9eOrfyIfGeF3U23QUO38P2aehnBRkXKzseTrmgdyFAz
         P/i0geSsozkdSz1EdidiMqz6927h2evaHMll6UMFf6oR1+oWRhqOw+RVjotvLz2xWC4p
         QcQsElvKRtXCKVbFxarM71pnwlgiwYo+EaY2kvfGRa8RdqV5+rJNnAUkiFwRzm1BgnBK
         fXdzp+vSTd8w0JZBoqgjwNiv2M3mIPWvVRyLFZdrfOu8kHGzXaqppo8uBc05aJzSGYzu
         AtFatb2mlWnIamvDkEnfKA2jLu906T00u6IqmrdWkCQ51H6mZQXn6fq/xWY7US1QQFEe
         4b0Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190423
Message-ID: <e7d9cff0-66f0-43b4-7b24-7a5b149f15f6@baylibre.com>
Date: Tue, 23 Apr 2019 11:30:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR includes the previous nacked u-boot-amlogic-20190411 PR but include the
fix for the warning :
regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset

This PR adds support for 3 more Amlogic boards, support printing SoC
revision information, add AXG family support for I2C and Reset, then
fixup the AXG pinctrl defintions.

Then it also adds minimal support for G12A SoC and the U200 reference
design board, and 2 minor defconfig and README fixes.

Thanks,
Neil

The following changes since commit 48ff1bc4f0a97c3291d0c87c2717fc1d79da5ef5:

  Merge branch '2019-04-09-master-imports-fs' (2019-04-10 08:18:18 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190423

for you to fetch changes up to c6e4e8f99c1430e803dc2ef306935a93b46dad7c:

  board: amlogic-q200: fix Khadas VIM2 README (2019-04-23 11:19:59 +0200)

----------------------------------------------------------------
- Add support for Amlogic p200 & p201 Reference Designs
- Add Amlogic SoC information display
- Add support for the Libretech-AC AML-S805X-AC board
- Add Amlogic AXG reset compatible
- Add I2C support for Amlogic AXG
- Fix AXG PIN and BANK pinctrl definitions
- Fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
- Add initial support for Amlogic G12A SoC and U200 board
- Enable PHY_REALTEK for selected boards
- Fix Khadas VIM2 README

----------------------------------------------------------------
Guillaume La Roque (2):
      i2c: meson: add configurable divider factors
      pinctrl: meson: axg: Fix PIN and BANK offsets

Jerome Brunet (5):
      pinctrl: meson: add g12a support
      clk: create meson directory and move related drivers
      clk: meson: add g12a support
      ARM: meson: add G12a support
      boards: meson: add g12a u200

Julien Masson (1):
      ARM: meson: display Amlogic SoC Information

Mohammad Rasim (5):
      ARM: board: meson: rename odroid-c2 to p200
      ARM: dts: meson: add p200 and p201 boards
      ARM: dts: meson: add u-boot.dtsi for p200 and p201
      ARM: board: meson: add p200 board
      ARM: board: meson: add p201 board

Neil Armstrong (7):
      ARM: dts: Import libretech-ac DT from Linux 5.0
      boards: Amlogic: Add support for Libretech-AC
      reset-meson: Add AXG reset compatible
      regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
      ARM: dts: Import Amlogic G12A u200 DT from Linux 5.1-rc1
      board: amlogic: enable PHY_REALTEK for selected boards
      board: amlogic-q200: fix Khadas VIM2 README

 MAINTAINERS                                        |    2 +-
 arch/arm/dts/Makefile                              |    6 +-
 arch/arm/dts/meson-g12a-u200.dts                   |   29 +
 arch/arm/dts/meson-g12a.dtsi                       |  192 +++
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi           |    7 +
 arch/arm/dts/meson-gxbb-p200.dts                   |   99 ++
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi           |    7 +
 arch/arm/dts/meson-gxbb-p201.dts                   |   26 +
 arch/arm/dts/meson-gxbb-p20x.dtsi                  |  247 ++++
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  248 ++++
 arch/arm/dts/meson-gxl.dtsi                        |   70 +-
 arch/arm/include/asm/arch-meson/clock-g12a.h       |  104 ++
 arch/arm/include/asm/arch-meson/g12a.h             |   66 +
 arch/arm/mach-meson/Kconfig                        |   11 +-
 arch/arm/mach-meson/Makefile                       |    3 +-
 arch/arm/mach-meson/board-g12a.c                   |  150 +++
 arch/arm/mach-meson/board-info.c                   |  166 +++
 arch/sandbox/include/asm/test.h                    |    8 -
 board/amlogic/{odroid-c2 => p200}/MAINTAINERS      |    6 +-
 board/amlogic/{odroid-c2 => p200}/Makefile         |    2 +-
 board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 |    0
 board/amlogic/{odroid-c2 => p200}/README.odroid-c2 |    0
 board/amlogic/p200/README.p200                     |  103 ++
 .../amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} |    0
 board/amlogic/p201/MAINTAINERS                     |    5 +
 board/amlogic/p201/Makefile                        |    5 +
 board/amlogic/p201/README.p201                     |  103 ++
 board/amlogic/p201/p201.c                          |   43 +
 board/amlogic/p212/MAINTAINERS                     |    1 +
 board/amlogic/p212/README.libretech-ac             |  103 ++
 board/amlogic/q200/README.khadas-vim2              |    4 +-
 board/amlogic/u200/MAINTAINERS                     |    5 +
 board/amlogic/u200/Makefile                        |    6 +
 board/amlogic/u200/README                          |  128 ++
 board/amlogic/u200/u200.c                          |   22 +
 board/sandbox/sandbox.c                            |    2 +-
 configs/khadas-vim2_defconfig                      |    3 +-
 configs/khadas-vim_defconfig                       |    2 +-
 configs/libretech-ac_defconfig                     |   74 ++
 configs/libretech-cc_defconfig                     |    2 +-
 configs/nanopi-k2_defconfig                        |    3 +-
 configs/odroid-c2_defconfig                        |    3 +-
 configs/p200_defconfig                             |   41 +
 configs/p201_defconfig                             |   41 +
 configs/p212_defconfig                             |    2 +-
 configs/s400_defconfig                             |    3 +-
 configs/u200_defconfig                             |   40 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/meson/Kconfig                          |   23 +
 drivers/clk/meson/Makefile                         |    9 +
 drivers/clk/{clk_meson_axg.c => meson/axg.c}       |    0
 drivers/clk/{ => meson}/clk_meson.h                |    0
 drivers/clk/meson/g12a.c                           |  315 +++++
 drivers/clk/{clk_meson.c => meson/gxbb.c}          |    0
 drivers/i2c/meson_i2c.c                            |   30 +-
 drivers/net/sandbox.c                              |    2 +-
 drivers/pinctrl/meson/Kconfig                      |    4 +
 drivers/pinctrl/meson/Makefile                     |    1 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |  358 +++---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c         | 1294 ++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |   17 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |    1 +
 drivers/reset/reset-meson.c                        |    1 +
 drivers/timer/sandbox_timer.c                      |    2 +-
 include/configs/libretech-ac.h                     |   24 +
 include/dt-bindings/clock/g12a-aoclkc.h            |   34 +
 include/dt-bindings/clock/g12a-clkc.h              |  135 ++
 include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 ++
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  134 ++
 include/dt-bindings/reset/g12a-aoclkc.h            |   18 +
 include/regmap.h                                   |    2 +-
 include/time.h                                     |    8 +
 73 files changed, 4493 insertions(+), 229 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12a-u200.dts
 create mode 100644 arch/arm/dts/meson-g12a.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
 create mode 100644 arch/arm/include/asm/arch-meson/clock-g12a.h
 create mode 100644 arch/arm/include/asm/arch-meson/g12a.h
 create mode 100644 arch/arm/mach-meson/board-g12a.c
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
 create mode 100644 board/amlogic/u200/MAINTAINERS
 create mode 100644 board/amlogic/u200/Makefile
 create mode 100644 board/amlogic/u200/README
 create mode 100644 board/amlogic/u200/u200.c
 create mode 100644 configs/libretech-ac_defconfig
 create mode 100644 configs/p200_defconfig
 create mode 100644 configs/p201_defconfig
 create mode 100644 configs/u200_defconfig
 create mode 100644 drivers/clk/meson/Kconfig
 create mode 100644 drivers/clk/meson/Makefile
 rename drivers/clk/{clk_meson_axg.c => meson/axg.c} (100%)
 rename drivers/clk/{ => meson}/clk_meson.h (100%)
 create mode 100644 drivers/clk/meson/g12a.c
 rename drivers/clk/{clk_meson.c => meson/gxbb.c} (100%)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
 create mode 100644 include/configs/libretech-ac.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
