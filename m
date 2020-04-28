Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.7028.1588079661463115163
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Apr 2020 06:14:22 -0700
Received: by mail-wm1-f65.google.com with SMTP id x25so2722055wmc.0
        for <u-boot-amlogic@groups.io>; Tue, 28 Apr 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=9nQfdYBNts+N5cKVWGNsfpcLxeasByioh7eMzici65Q=;
        b=pWUIoP/wLw9u6kB7CmoVdhlYul6o+mGKABX+kseKf8WqcjziE10K3l4dCChpGLqFWc
         qz4+dJeHqBa45kY9NhxivIiuatOedh7HzRNntsDjuWK+xbodkQ5jOCneAvEAgkP9zYpL
         vZqGLcOiIi5TDYmMnOGcV6q4Z57WK8n348CrsASNU2ww+KvnPdEEgYM6whP4ZLVexfGc
         ExtV46yg+9/wj8N+aI/LBQvDde0SlEOy6UHP+lchYAjrKG9lHjchgEDoUXtRGh+WmMsC
         duSX6Tw493MJFMwJx++T5vYFLSFYO94Cp4JPHVqVqxfud3TOmiexqfJWTdIERjqCEmNf
         mBSw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200428
Reply-To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Message-ID: <6acb7fbf-a4b0-b020-0451-d3daaa70f7e6@baylibre.com>
Date: Tue, 28 Apr 2020 15:14:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR enables access to SPI NOR flash on the Khadas VIM2 & VIM3, adds the GXBB USB PHY driver,
fixes MMC driver init freeze on G12A/G12B/SM1 SoCs and finally fixes USB PHY power-up on
Khadas VIM3/VIM3L boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/2972

Thanks,
Neil

The following changes since commit d16d37bcd4087b8ea0f66cb76a73edad182d151a:

  Merge tag 'video-for-v2020.07-rc1' of https://gitlab.denx.de/u-boot/custodians/u-boot-video (2020-04-27 09:41:51 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200428

for you to fetch changes up to 3dc4f8397015dac7c343f86a93bfb962ff4e8d6f:

  usb: dwc3-meson-g12a: add power-on/off of the PHYs (2020-04-28 10:23:10 +0200)

----------------------------------------------------------------
- fix sd-emmc controller A init on G12A/G12B/SM1 SoCs
- add GXBB USB PHY driver
- enable access to SPI NOR Flash on VIM2 and VIM3/VIM3L boards
- fix USB PHYs Power-Up on on VIM3/VIM3L boards

----------------------------------------------------------------
Beniamino Galvani (1):
      phy: meson: add GXBB PHY driver

Neil Armstrong (7):
      clk: meson: g12a: add missing SD_EMMC_A controller gates
      arm64: dts: meson: sync dt and bindings from v5.7-rc1
      arm: dts: meson-gxm-khadas-vim2-u-boot: enable SPI NOR flash
      configs: khadas-vim2: enable support for SPI NOR flash
      arm: dts: meson-khadas-vim3: enable SPI NOR flash
      configs: khadas-vim3: enable support for SPI NOR flash
      usb: dwc3-meson-g12a: add power-on/off of the PHYs

 arch/arm/dts/meson-axg-s400.dts                    |   6 +-
 arch/arm/dts/meson-g12-common.dtsi                 | 136 +++++++++++-
 arch/arm/dts/meson-g12.dtsi                        |   1 +
 arch/arm/dts/meson-g12a-sei510.dts                 |   4 +-
 arch/arm/dts/meson-g12a-u200.dts                   |   2 +-
 .../dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi   |   7 +
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |   4 +-
 arch/arm/dts/meson-g12b-odroid-n2.dts              |  25 ++-
 arch/arm/dts/meson-gx.dtsi                         |  52 +++++
 arch/arm/dts/meson-gxbb-odroidc2.dts               |   1 +
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |   9 +-
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi     |  15 ++
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  89 ++------
 arch/arm/dts/meson-gxm.dtsi                        |  28 +++
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi         |  21 ++
 arch/arm/dts/meson-khadas-vim3.dtsi                |  24 ++-
 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |   8 +-
 arch/arm/dts/meson-sm1-sei610.dts                  |   3 +-
 arch/arm/dts/meson-sm1.dtsi                        |   1 +
 configs/khadas-vim2_defconfig                      |   8 +
 configs/khadas-vim3_defconfig                      |   9 +
 configs/khadas-vim3l_defconfig                     |   9 +
 drivers/clk/meson/g12a.c                           |   2 +
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/meson-gxbb-usb2.c                      | 235 +++++++++++++++++++++
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  16 ++
 include/dt-bindings/clock/g12a-clkc.h              |   2 +
 include/dt-bindings/clock/gxbb-clkc.h              |   1 +
 30 files changed, 633 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
 create mode 100644 drivers/phy/meson-gxbb-usb2.c
