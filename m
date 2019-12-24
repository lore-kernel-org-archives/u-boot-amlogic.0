Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web09.2623.1577193958912895345
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Dec 2019 05:25:58 -0800
Received: by mail-pf1-f193.google.com with SMTP id p14so10771923pfn.4
        for <u-boot-amlogic@groups.io>; Tue, 24 Dec 2019 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0f1qFpwxL+brFBYEYLEO41QRhsMI3QFu30chGF0LQa8=;
        b=EIcEv/G38SZ85JaGD0FnFGRtCot/4MZMTre8vvEU77WkDFqe7gjiOODjMGy2AiuPk0
         nEVYUsKFeTF+S4Sejh4oY0R+pXapXnLDUlEh92npYGoZc1WDYAkgnYYq2In0LhOjHGJ9
         63KHerpufleIHu/40immCvcFQIGWoWZfyjQGMz3SX5jffp71haND1hWTNKkpqcPvfYKk
         ezYozp5+zODitrkBrdUfoUr54ky3zwuETloD0vMd1ah3x2Cl3qkmp41C+vSBLXEpHmaH
         m6lr67g4HY6mmGepr3MScqF6+zknrquylthLnC56tpBHCR3O0uxzq0ewXSPklaBqx2ad
         880A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCHv2 0/3] Odroid n2 using eMMC would fail to boot up
Date: Tue, 24 Dec 2019 13:25:48 +0000
Message-Id: <20191224132551.1427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Here are some small changes to fix booting of Odroid N2 using eMMC.
Fixed the clk tunnig during mmc initialization.

Build and tested on top of below patches
[0] https://patchwork.ozlabs.org/patch/1213648/
[1] https://patchwork.ozlabs.org/patch/1213650/

Tested on below eMMC module on Odroid N2 and C2
new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
old back   - eMMC CGND3R 58.2 GiB MMC 5.0

Prevoius changes: [3] https://patchwork.ozlabs.org/cover/1201206/

-Anand

Anand Moon (3):
  mmc: meson-gx: Fix clk phase tuning for MMC
  configs: meson64: enable GIC support for G12A/G12B
  board: amlogic: select PWRSEQ for all amlogic platform

 arch/arm/include/asm/arch-meson/sd_emmc.h | 14 ++++++--------
 arch/arm/mach-meson/Kconfig               |  1 +
 drivers/mmc/meson_gx_mmc.c                |  9 +++++----
 include/configs/meson64.h                 |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.24.1

