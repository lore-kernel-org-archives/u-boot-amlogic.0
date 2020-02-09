Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web12.6295.1581246366216772414
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:06 -0800
Received: by mail-pf1-f195.google.com with SMTP id s1so2183734pfh.10
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhqH+4EUw9jFDVOabdBCFIo1UrbFgg4+reZQ7ZdUFXU=;
        b=PF02gkaKmRGi0BcBFhHrqstafTPHw3HFuUw0ZZBu/e3dz1VIVJA9FwpXS/rKSRizVm
         nX8z8sua/ztyYuasdjbm23UwyjArSwgicJ71/bIJIolST9mVu8M3qkLuUyGKJ/v6Ra3x
         UQ2R2GReXU9hSNLvxrN4XtDDet07QHicRNJpc6RccAsprGmWaUxECAE9orInaUfgLkLV
         oUfQIUyIYfkiye59A5K4YM82b9Xw+qoHwWx74838sZmtkYaF6sxUQIrpR2NYmB397r6m
         b31pRB80yVug98JrkdKaj6k7rMbY2Xvfz7cQOBLJM1UVmpMcvgokZCTmXtkXJkrnPA9+
         Um1A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 0/5] Odroid n2 using eMMC would fail to boot up
Date: Sun,  9 Feb 2020 11:05:52 +0000
Message-Id: <20200209110557.1996-1-linux.amoon@gmail.com>
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
[7]v5 https://patchwork.ozlabs.org/cover/1232879/

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
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ----
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 --
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ----
 arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ----
 arch/arm/dts/meson-khadas-vim3.dtsi           |  9 ---
 arch/arm/dts/meson-sm1-sei610.dts             |  9 ---
 arch/arm/include/asm/arch-meson/sd_emmc.h     | 31 +++++++---
 drivers/mmc/meson_gx_mmc.c                    | 58 ++++++++++++++++---
 19 files changed, 114 insertions(+), 143 deletions(-)

-- 
2.25.0

