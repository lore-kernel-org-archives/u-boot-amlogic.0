Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.46455.1585560465018925640
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:45 -0700
Received: by mail-wr1-f67.google.com with SMTP id h9so20663712wrc.8
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiTKarC/pK/jtSXxuciHtqY1XaBgFHLLJSgwxfrBMB0=;
        b=aGgpgSdPp3rZzH57IMBRhCWmw+fgJHrvWi7RiSwKjZiyyY3ITajKzhyEEPSMdnGrSb
         710GBNaCOPj0OJYHWSlsNvhXT37xXwxSYlXqHG3gLx6lF+d1Zc2WNYJU3aKTByN/0t8K
         lSW4dVy3NSghFu22sYZM24HTtAfC6a9lQu+bwEEas9B6//eJrm3jAi/wILuQRrSN6nk7
         loKeyxzhbJdy7HD8hD1FXANYskiK6vY3+dHK+X0r/v3m1baP65vLL4KFnl27aWaUHDNN
         X9bW2r1pc8LyixFL885jjzovj8tmR2MYS0Ks8zzB6+uLqKZooyVzS2bje5f0PtxHO0p0
         RSrQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 00/10] meson: enable USB Gadget support fot GXL/GXM SoCs
Date: Mon, 30 Mar 2020 11:27:22 +0200
Message-Id: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Thit patchset adds support for OTG Gadget mode on the GXL/GXM SoCs.

It adds a new API generic_phy_get_by_node() to get the PHY by it's node.

It enabled Gadget and USB Mass Storage for libretech-cc, libretech-ac,
khadas-vim, khadas-vim2, libretech-s905d-pc and libretech-s912-pc boards.

Neil Armstrong (10):
  generic-phy: add generic_phy_get_by_node()
  phy: meson-gxl-usb: add set_mode call to force switch to peripheral
    mode
  arm: meson-gx: add board_usb_init()/cleanup() for USB gadget
  arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot
  configs: libretech-cc: Enable USB gadget with Mass Storage function
  configs: libretech-ac: Enable USB gadget with Mass Storage function
  configs: khadas-vim2: Enable USB gadget with Mass Storage function
  configs: khadas-vim: Enable USB gadget with Mass Storage function
  configs: libretech-s905d-pc: Enable USB gadget with Mass Storage
    function
  configs: libretech-s912-pc: Enable USB gadget with Mass Storage
    function

 .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    |   2 +-
 .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  |   6 +-
 arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi |   2 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi            |  23 ++++
 arch/arm/include/asm/arch-meson/usb-gx.h      |  16 +++
 arch/arm/mach-meson/board-gx.c                | 118 ++++++++++++++++++
 configs/khadas-vim2_defconfig                 |   7 ++
 configs/khadas-vim_defconfig                  |   7 ++
 configs/libretech-ac_defconfig                |   7 ++
 configs/libretech-cc_defconfig                |   7 ++
 configs/libretech-s905d-pc_defconfig          |   7 ++
 configs/libretech-s912-pc_defconfig           |   7 ++
 drivers/phy/meson-gxl-usb2.c                  |  30 ++++-
 drivers/phy/meson-gxl-usb3.c                  |  44 +++++--
 drivers/phy/phy-uclass.c                      |  17 ++-
 include/generic-phy.h                         |  27 ++++
 16 files changed, 301 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h

-- 
2.22.0

