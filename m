Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.9723.1604658068598600858
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:21:08 -0800
Received: by mail-wr1-f65.google.com with SMTP id p1so716517wrf.12
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itJ9RRVbtqVrb+DUNSRChO29NTZ3/9oZi2mTh2ZkDYc=;
        b=FSTGBxrvDLVGYk7WHbton91EXa1dfKwRGVkBUFwlgQogn/r3WPstIWSic8MC3ApnRq
         +BD36tmRCZrx53vdu0cTry8Heb4+RnMbiDZ3WVxlIfrgpsRA0iGoYPZ7HzgIY+3yWuVx
         X60icVRgBO0GNK4DFPTOETAyPoKZ0m/ZFa3dWBsdPaPuGkHPKo+ygKsl6FG6wYgm8/Z9
         aN7nhUpf7FPws8AQvhkPg2ZtA1IYxlBsC/Eq82MvAsUWkBStCVEYt3d8CZrxK5LiGNYk
         yZpyUEte4EAUKbkXm89dgFkHD0l2KK2u8iv6GP6ZH0tscusRr9WG9/u56KB494mdih+f
         HFPQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/4] ARM: upgrade Amlogic DT to Linux 5.10
Date: Fri,  6 Nov 2020 11:18:57 +0100
Message-Id: <20201106101901.2472557-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This syncs the Amlogic DT to 5.10, and :
- adds support for the new common MESON_EE_POWER_DOMAIN synced on 5.10
- adds Odroid-N2+ DT using the Odroid-N2 DT as base

Neil Armstrong (4):
  ARM: dts: sync Amlogic GX & AXG from Linux 5.10-rc1
  power: domain: meson-ee-pwrc: add support for the Meson GX SoCs
  power: domain: meson-ee-pwrc: add support for the Meson AXG SoCs
  configs: use the new MESON_EE_POWER_DOMAIN driver for Amlogic
    GXBB/GXL/GXM boards

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/meson-axg.dtsi                   |   6 +-
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi      |  88 ---
 arch/arm/dts/meson-g12b-odroid-n2-plus.dts    |  31 +
 arch/arm/dts/meson-g12b-odroid-n2.dts         | 618 +----------------
 arch/arm/dts/meson-g12b-odroid-n2.dtsi        | 625 ++++++++++++++++++
 arch/arm/dts/meson-gx-mali450.dtsi            |  61 ++
 arch/arm/dts/meson-gx.dtsi                    |  18 +-
 arch/arm/dts/meson-gxbb.dtsi                  |  63 +-
 arch/arm/dts/meson-gxl-mali.dtsi              |  46 +-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |   2 +-
 arch/arm/dts/meson-gxl-s805x.dtsi             |  23 +
 arch/arm/dts/meson-gxl.dtsi                   |  17 +-
 arch/arm/dts/meson-gxm.dtsi                   |  45 +-
 arch/arm/dts/meson-khadas-vim3.dtsi           |  94 ++-
 arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  86 ---
 configs/libretech-ac_defconfig                |   2 +-
 configs/libretech-cc_defconfig                |   2 +-
 configs/libretech-s905d-pc_defconfig          |   2 +-
 configs/libretech-s912-pc_defconfig           |   2 +-
 configs/odroid-c2_defconfig                   |   2 +-
 drivers/power/domain/meson-ee-pwrc.c          |  52 +-
 include/dt-bindings/power/meson-axg-power.h   |  14 +
 include/dt-bindings/power/meson-gxbb-power.h  |  13 +
 24 files changed, 1002 insertions(+), 911 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-plus.dts
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dtsi
 create mode 100644 arch/arm/dts/meson-gx-mali450.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s805x.dtsi
 create mode 100644 include/dt-bindings/power/meson-axg-power.h
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h

-- 
2.25.1

