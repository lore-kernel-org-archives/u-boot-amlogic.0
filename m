Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
 by mx.groups.io with SMTP id smtpd.web12.9994.1579694786974598198
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Jan 2020 04:06:27 -0800
Received: by mail-pj1-f68.google.com with SMTP id r67so3105995pjb.0
        for <u-boot-amlogic@groups.io>; Wed, 22 Jan 2020 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNJkc0DRqOQUAZwb5/Ovox4UoqUc1nROkfZdgEwZmrM=;
        b=FS9Lg4PQdFUzHOK2nRf2rf4rDKo2Mwx/AzWVb+CB3SVWTOCYVUOSZqkaJdzubTWULV
         9KPjefMfTrTHt5iYBmJM/BldFf/rCyeneUJwX3aCAp7h/5+z3Q7GvmzyXOY8lzP3+cYm
         Cyd90uj1HKHi8ePRSZwfJO6aMrxEToZS5a4a7VV/JnkvCml+RXMnvVEsOg++lJc68Xsw
         4bryWaeSdEvQBDlvoIoEKoRr7Jidd4K8WvNQq2gF0Bw8W5a1lRm6GDmQMimHOcHAHBlm
         cDIa5+XtKko80JYBwlQ/ujIN248eO1PZ78KNuzMC7kleBd/DbEfh2bHwFm/C+Me0CLsp
         +7BQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [Patchv4 0/3] Odroid n2 using eMMC would fail to boot up
Date: Wed, 22 Jan 2020 12:06:17 +0000
Message-Id: <20200122120620.8699-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
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

-Anand

Anand Moon (3):
  mmc: meson-gx: Fix clk phase tuning for MMC
  arm: dts: Add mmc alias to avoid warning
  arm: dts: Add cd-gpio for eMMC

 arch/arm/dts/meson-axg-s400.dts               |  2 +
 arch/arm/dts/meson-g12a-sei510.dts            |  3 ++
 arch/arm/dts/meson-g12a-u200.dts              |  3 ++
 arch/arm/dts/meson-g12b-odroid-n2.dts         |  4 ++
 arch/arm/dts/meson-gxbb-odroidc2.dts          |  3 ++
 arch/arm/dts/meson-gxbb-p20x.dtsi             |  3 ++
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |  3 ++
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        |  3 ++
 arch/arm/dts/meson-gxm-khadas-vim2.dts        |  3 ++
 arch/arm/dts/meson-sm1-sei610.dts             |  3 ++
 arch/arm/include/asm/arch-meson/sd_emmc.h     | 11 ++----
 drivers/mmc/meson_gx_mmc.c                    | 38 ++++++++++++++++---
 12 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.25.0

