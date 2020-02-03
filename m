Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web10.336.1580742810342384792
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:30 -0800
Received: by mail-pl1-f193.google.com with SMTP id y8so5961646pll.13
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJpLpxoMoVg2VZGirvtCFoPTbcE56xG+5HKp8PsqO2s=;
        b=s4/nlVfL65CMc0ALC77rj8/lRnLtYKxbm/IhkXBVq8udk2cX522WddYronwLcHH/4I
         4hXqz/boWvL+EuHV6/6FI4O1mDHz3sANJQe8dhtdfUnAKsILxj3Lnap7G4Bo/VKyN0KJ
         adWxnAS2Il9o6Hfo8DB43VVeNNhI5xjeVceEZipHKHCfvUrhozPDpBghMlybotYRD5sG
         bsFD2l/DTp4EGr+N85hAeqehlRSYAxDE1IrngPyFa10fo/zgnxijCsBUWouIcavG0vYz
         1XmytVgG5S/W9nw5qMgqVKKoZwbrMYuITA6LgkHBpMoCfzGm19Ejkd3+9xaXt9mkrlS0
         o35A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 0/5]Odroid n2 using eMMC would fail to boot up
Date: Mon,  3 Feb 2020 15:13:18 +0000
Message-Id: <20200203151323.4615-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Here are some small changes to fix booting of Odroid N2 using eMMC.
Fixed the clk tunnig during mmc initialization.
Added two new patches to fix warning

Build and tested on top of below patches
[0] https://patchwork.ozlabs.org/patch/1213648/
[1] https://patchwork.ozlabs.org/patch/1213650/

Tested on below eMMC module on Odroid N2 and C2
new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
old back   - eMMC CGND3R 58.2 GiB MMC 5.0

Prevoius changes: 
Fixed the clk tuning as per mainline kernel

[3]v1 https://patchwork.ozlabs.org/cover/1201206/
[4]v2 https://patchwork.ozlabs.org/cover/1215217/
[5]v3 https://www.mail-archive.com/u-boot@lists.denx.de/msg351859.html
[6]v4 https://patchwork.ozlabs.org/cover/1227205/

-Anand

Anand Moon (5):
  mmc: meson-gx: Fix clk phase tuning for MMC
  mmc: meson-gx: Use proper compatible string as per the dts
  arm: dts: gx: Move common nodes to the -u-boot.dtsi
  arm: dts: g12: Move common nodes to the -u-boot.dtsi
  arm: dts: s400: Move common nodes to the -u-boot.dtsi

 arch/arm/dts/meson-axg-s400-u-boot.dtsi       | 16 +++++
 arch/arm/dts/meson-axg-s400.dts               |  9 ---
 arch/arm/dts/meson-g12-common-u-boot.dtsi     | 12 ++++
 arch/arm/dts/meson-g12a-sei510.dts            |  9 ---
 arch/arm/dts/meson-g12a-u200.dts              |  9 ---
 arch/arm/dts/meson-g12b-odroid-n2.dts         |  9 ---
 arch/arm/dts/meson-gx-u-boot.dtsi             | 15 +++++
 arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  9 ---
 arch/arm/dts/meson-gxbb-odroidc2.dts          |  9 ---
 arch/arm/dts/meson-gxbb-p20x.dtsi             |  9 ---
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ---
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 --
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ---
 arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ---
 arch/arm/dts/meson-khadas-vim3.dtsi           |  9 ---
 arch/arm/dts/meson-sm1-sei610.dts             |  9 ---
 arch/arm/include/asm/arch-meson/sd_emmc.h     | 35 +++++++---
 drivers/mmc/meson_gx_mmc.c                    | 66 ++++++++++++++++---
 19 files changed, 126 insertions(+), 143 deletions(-)

-- 
2.25.0

