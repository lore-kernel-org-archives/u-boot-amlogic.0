Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.8746.1601967376093075462
 for <u-boot-amlogic@groups.io>;
 Mon, 05 Oct 2020 23:56:16 -0700
Received: by mail-wr1-f67.google.com with SMTP id k10so12115910wru.6
        for <u-boot-amlogic@groups.io>; Mon, 05 Oct 2020 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=N30hps9KiYYCzpuprf4YmYAO/8OwbFEqBgI7cuRJTOk=;
        b=vQaYzJvg19tWdJfTYrZc8ajHrsF63MrYsandm9slUCSPrIvnACD1SnIDvaXLnP453i
         MHvWaImyShRhSIYTC2/ToB4yxd2qT5zZClFxg7PipU4QoUCTLLqZnkRd0JQZJemYdxR7
         zqfJ2VqqNYHa64qRNguwg8ig1AdcGLR3EDdvRFQ4IA2LXuzT3KftpIqupsyu9ApexgGX
         a85Ihy8qaColDBqvFNhxw2TYrfox0ZP9xmBUE7H9+VtHQJict30ZRcc3YJ8CKf72JbId
         VAF/P/Y8zsjlm5OC+wo6V5f5mSLFljFtBFCpcuJ+CtZhIm0peNXMz1837gK6jp2hyYcg
         PoNQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20201005
Reply-To: narmstrong@baylibre.com
Message-ID: <857ef1d4-ff80-56fd-a34e-853c6a8ed151@baylibre.com>
Date: Tue, 6 Oct 2020 08:56:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds proper USB OTG support for GXL/GXM and AXG based boards with Linux 5.8 DT sync,
adds dynamic PCIe enable in OS DT for the VIM3/VIM3L boards with Linux 5.9 DT sync,
AXG pinctrl fixes, introduces the Amlogic PWM driver and enables an unique mac address
from SoC serial on S400 board.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/4915

Thanks,
Neil

The following changes since commit 050acee119b3757fee3bd128f55d720fdd9bb890:

  Prepare v2020.10 (2020-10-05 11:15:32 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20201005

for you to fetch changes up to 2d481b2e3e22f7be854d381a7bafd92a65e18b23:

  pwm: Add driver for Amlogic Meson PWM controller (2020-10-05 18:02:16 +0200)

----------------------------------------------------------------
- generate unique mac address from SoC serial on S400 board
- Add USB support for GXL and AXG SoCs
- Update Gadget code to use the new GXL and AXG USB glue driver
- Add a VIM3 board support to add dynamic PCIe enable in OS DT
- Fix AXG pinmux with requesting GPIOs
- Add missing GPIOA_18 for AXG pinctrl
- Add Amlogic PWM driver

----------------------------------------------------------------
Neil Armstrong (16):
      board: s400: generate unique mac address from SoC serial
      ARM: dts: sync amlogic AXG/GXL/GXM DT from Linux 5.8-rc1
      usb: dwc3: add Amlogic GXL & GXL DWC3 Glue
      ARM: mach-meson: use new DWC3 glue for GXL & GXM
      phy: meson-gxl: remove invalid USB3 PHY driver
      phy: meson-gxl-usb: depend on Meson AXG aswell
      arm: meson-axg: add board_usb_init()/cleanup() for USB gadget
      ARM: dts: meson-axg: add USB nodes for S400
      configs: s400: enable USB
      ARM: dts: sync amlogic G12A/SM1 DT from Linux 5.9-rc1
      board: amlogic: add a vim3 specific board support
      configs: vim3: use the vim3 board support
      board: amlogic: vim3: add support for dynamic PCIe enable
      pinctrl: meson-axg-pmx: fix gpio request
      pinctrl: meson-axg: add missing GPIOA_18
      pwm: Add driver for Amlogic Meson PWM controller

 arch/arm/dts/meson-axg-s400-u-boot.dtsi            |  12 +
 arch/arm/dts/meson-axg-u-boot.dtsi                 |  62 +++
 arch/arm/dts/meson-axg.dtsi                        |   6 +-
 arch/arm/dts/meson-g12-common.dtsi                 |  55 ++-
 arch/arm/dts/meson-g12b-odroid-n2.dts              | 136 +++++-
 arch/arm/dts/meson-gx-libretech-pc.dtsi            |  78 ++-
 arch/arm/dts/meson-gx.dtsi                         |  23 +-
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |   2 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               |   2 +-
 arch/arm/dts/meson-gxbb.dtsi                       |  23 +
 .../dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi   |   4 -
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  73 ++-
 .../dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi   |   4 -
 .../arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi |   4 -
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |   4 +
 .../dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi   |   4 -
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  77 ++-
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |   3 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi                 |  16 -
 arch/arm/dts/meson-gxl.dtsi                        |  79 ++-
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi     |   4 -
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |   3 +-
 .../dts/meson-gxm-s912-libretech-pc-u-boot.dtsi    |   4 -
 arch/arm/dts/meson-gxm.dtsi                        |   7 +-
 arch/arm/dts/meson-khadas-vim3.dtsi                |  26 +-
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  92 ++++
 arch/arm/dts/meson-sm1-odroid-c4.dts               |  88 ++++
 arch/arm/include/asm/arch-meson/usb-gx.h           |   3 +-
 arch/arm/mach-meson/board-axg.c                    | 128 +++++
 arch/arm/mach-meson/board-gx.c                     | 127 ++---
 board/amlogic/s400/s400.c                          |   2 +
 board/amlogic/vim3/MAINTAINERS                     |   9 +
 board/amlogic/vim3/Makefile                        |   6 +
 board/amlogic/vim3/khadas-mcu.h                    |  81 ++++
 board/amlogic/vim3/vim3.c                          | 137 ++++++
 board/amlogic/w400/MAINTAINERS                     |   4 -
 configs/khadas-vim2_defconfig                      |   2 +-
 configs/khadas-vim3_defconfig                      |   5 +-
 configs/khadas-vim3l_defconfig                     |   5 +-
 configs/khadas-vim_defconfig                       |   2 +-
 configs/libretech-ac_defconfig                     |   2 +-
 configs/libretech-cc_defconfig                     |   2 +-
 configs/libretech-s905d-pc_defconfig               |   2 +-
 configs/libretech-s912-pc_defconfig                |   2 +-
 configs/p212_defconfig                             |   2 +-
 configs/s400_defconfig                             |  15 +
 doc/board/amlogic/khadas-vim3.rst                  |  27 ++
 doc/board/amlogic/khadas-vim3l.rst                 |  27 ++
 drivers/phy/Kconfig                                |   2 +-
 drivers/phy/Makefile                               |   2 +-
 drivers/phy/meson-gxl-usb3.c                       | 219 ---------
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c      |   5 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |   1 +
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-meson.c                            | 528 +++++++++++++++++++++
 drivers/usb/dwc3/Kconfig                           |   8 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/dwc3-meson-gxl.c                  | 425 +++++++++++++++++
 include/dt-bindings/clock/g12a-clkc.h              |   2 +
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |   2 +-
 include/dt-bindings/sound/meson-aiu.h              |  18 +
 include/dt-bindings/sound/meson-g12a-toacodec.h    |  10 +
 63 files changed, 2315 insertions(+), 397 deletions(-)
 create mode 100644 arch/arm/dts/meson-axg-u-boot.dtsi
 create mode 100644 board/amlogic/vim3/MAINTAINERS
 create mode 100644 board/amlogic/vim3/Makefile
 create mode 100644 board/amlogic/vim3/khadas-mcu.h
 create mode 100644 board/amlogic/vim3/vim3.c
 delete mode 100644 drivers/phy/meson-gxl-usb3.c
 create mode 100644 drivers/pwm/pwm-meson.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-gxl.c
 create mode 100644 include/dt-bindings/sound/meson-aiu.h
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
