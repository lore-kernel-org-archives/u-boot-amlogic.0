Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.9256.1586175369562903588
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2020 05:16:10 -0700
Received: by mail-wm1-f67.google.com with SMTP id y20so3646378wma.4
        for <u-boot-amlogic@groups.io>; Mon, 06 Apr 2020 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=lW9eP4xhYns2sfWpFANE8f1QP2uPBM7CzHym4tFNTbE=;
        b=nBh2ppB751jfbtYXzegBYFU6tApk3Ju2e70mLvtvoIz0xXddzz8roISK/tP2qSRsjG
         FciU/qGKmWq2cfqI7ocjH4sEgaUP9ebPFCQ7uv67tVvBbRmml3OYMzbeMbUSQkww9HQa
         SIPQXMMpTn6ftYoXDOLMek4P9pe9IhmYZZ5f8Vt5GK6sSoUZd3HW5yySHFEtgYsphvEY
         9kfwnX/BabHvLgEiyGXLSd8e3Fv7nRlqCWWokT/92BVbMZUyd4u7iVvGIyRMmb5b4j79
         k8eU4d6lCRpkQ+2skqVjqofG/NKVdam0pDOTVDNxG+ioDSFqGf0+5cxgq+SGa2rx7nQI
         eEdQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200406
Reply-To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Message-ID: <a4fa8d05-31c5-6b6a-3087-e2378f1c9296@baylibre.com>
Date: Mon, 6 Apr 2020 14:16:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds support for Libre Computer AML-S905D-PC and AML-S912-PC while
doing a full sync of Linux v5.6 DT plus fixups on MMC clocks and typos.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/2631

Thanks,
Neil

The following changes since commit 74bf17db394d49c7041ee01a277fcf8d99b9a514:

  Merge branch 'master' of git://git.denx.de/u-boot-sh (2020-04-04 19:20:45 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200406

for you to fetch changes up to e13e7c9daec54f387468098aa1f857e99a1333ec:

  arm64: dts: meson: add libretech-pc support (2020-04-06 09:56:35 +0200)

----------------------------------------------------------------
- clk: meson-g12a: missing break
- sync all Amlogic DT from Linux v5.6-rc2
- MMC clock fixups
- add support for Libre Computer AML-S905D-PC and AML-S912-PC

----------------------------------------------------------------
Heinrich Schuchardt (1):
      clk: meson-g12a: missing break

Jerome Brunet (6):
      dt-bindings: leds: import common led bindings from linux v5.5
      mmc: meson-gx: enable input clocks
      clk: meson: reset mmc clock on probe
      arm64: dts: meson: sync dt and bindings from v5.6-rc2
      arm64: dts: meson: import libretech-pc from linux v5.6-rc2
      arm64: dts: meson: add libretech-pc support

 arch/arm/dts/Makefile                              |   2 +
 arch/arm/dts/meson-axg-s400.dts                    |  70 ++-
 arch/arm/dts/meson-axg.dtsi                        | 273 ++++++++++--
 arch/arm/dts/meson-g12-common.dtsi                 | 478 +++++++--------------
 arch/arm/dts/meson-g12.dtsi                        | 398 +++++++++++++++++
 arch/arm/dts/meson-g12a-sei510.dts                 |  64 +++
 arch/arm/dts/meson-g12a-u200.dts                   |  54 +++
 arch/arm/dts/meson-g12a.dtsi                       |  33 +-
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |  25 ++
 arch/arm/dts/meson-g12b-odroid-n2.dts              |   2 +-
 arch/arm/dts/meson-g12b.dtsi                       |  26 +-
 arch/arm/dts/meson-gx-libretech-pc.dtsi            | 375 ++++++++++++++++
 arch/arm/dts/meson-gx.dtsi                         |  87 +++-
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  26 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               | 100 ++++-
 arch/arm/dts/meson-gxbb-p200.dts                   |   9 +-
 arch/arm/dts/meson-gxbb-p201.dts                   |   2 +-
 arch/arm/dts/meson-gxbb-p20x.dtsi                  |   9 +-
 arch/arm/dts/meson-gxbb.dtsi                       | 118 ++++-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 .../dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi   |   7 +
 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |  16 +
 arch/arm/dts/meson-gxl-s905d.dtsi                  |  12 +
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  20 +-
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  26 +-
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  10 +-
 arch/arm/dts/meson-gxl.dtsi                        |  76 +++-
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  71 +--
 .../dts/meson-gxm-s912-libretech-pc-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |  62 +++
 arch/arm/dts/meson-gxm.dtsi                        |  39 +-
 arch/arm/dts/meson-khadas-vim3.dtsi                |   7 +
 arch/arm/dts/meson-sm1-sei610.dts                  | 236 +++++++++-
 arch/arm/dts/meson-sm1.dtsi                        | 356 +++++++++++++++
 board/amlogic/q200/MAINTAINERS                     |   2 +
 configs/libretech-s905d-pc_defconfig               |  73 ++++
 configs/libretech-s912-pc_defconfig                |  73 ++++
 drivers/clk/meson/axg.c                            |   7 +
 drivers/clk/meson/g12a.c                           |   8 +
 drivers/clk/meson/gxbb.c                           |   7 +
 drivers/mmc/meson_gx_mmc.c                         |  14 +-
 include/dt-bindings/clock/axg-audio-clkc.h         |  10 +
 include/dt-bindings/clock/gxbb-aoclkc.h            |   7 +
 include/dt-bindings/clock/gxbb-clkc.h              |  21 +
 include/dt-bindings/gpio/meson-gxbb-gpio.h         |   8 +-
 include/dt-bindings/gpio/meson-gxl-gpio.h          |   8 +-
 include/dt-bindings/leds/common.h                  |  75 ++++
 .../reset/amlogic,meson-axg-audio-arb.h            |   2 +
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    |   3 +-
 .../reset/amlogic,meson-g12a-audio-reset.h         |  15 +
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  51 +--
 51 files changed, 2858 insertions(+), 624 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12.dtsi
 create mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
 create mode 100644 configs/libretech-s905d-pc_defconfig
 create mode 100644 configs/libretech-s912-pc_defconfig
 create mode 100644 include/dt-bindings/leds/common.h
