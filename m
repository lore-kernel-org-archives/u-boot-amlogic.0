Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web12.19862.1577360040051321575
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 03:34:00 -0800
Received: by mail-pg1-f194.google.com with SMTP id b9so12730959pgk.12
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjFrBdTmNh3vpBzDywcpnEuVyTvDocQ/AyyscadJkVA=;
        b=RPc4/FA361TlLr2zrnlSpASYsb97YROHTiVD3F0xjfIji8GofDb13/YihJCrKtTW/o
         6eAPiN9DVW/KY9GQiu7vMEYzzcA86XLQsnm8/8/IjCNReSMf2bfIACbBlIlZSy2ozvWd
         rf7KTKPH/CNznmeOte7xUUxY5lzkhp8oqedstsH5xnT5jbR7BMVN8q4yfV5+z3QCRaG2
         Unc/CRLBAXgQztnhizVgi/hypaQ28UvokaYnLM5HH80XsZmQlVdCwUEF3DzeGkTZ1TsH
         G7UeEKzPMWdOgnbrc2UWZ2gugehSUbOZj5AhJHTBCorhVN3QbaxYvfpMpnAxCjwcurOk
         gXUQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 0/3] Odroid n2 using eMMC would fail to boot up
Date: Thu, 26 Dec 2019 11:33:50 +0000
Message-Id: <20191226113353.1757-1-linux.amoon@gmail.com>
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

Prevoius changes: 
Fixed the clk tuning as per mainline kernel
[3]v1 https://patchwork.ozlabs.org/cover/1201206/
[4]v2 https://patchwork.ozlabs.org/cover/1215217/

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

