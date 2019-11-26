Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
 by mx.groups.io with SMTP id smtpd.web10.3583.1574802733829696340
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2019 13:12:13 -0800
Received: by mail-pg1-f193.google.com with SMTP id b10so9623462pgd.4
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2019 13:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12PGjxvghBVY4nTT8a91uxGT/upVEmhdfJWzf9vQDcA=;
        b=c90Uc86M86fRKnriMrZzmG3hpd+Ztrm9yyOVp/QHHdcDhiVS4AX0qitgOuK/bXuoZw
         pHdF7+7gJCKtGaQGqvxH2U19Nwdmqx+IEVV9LNpbDcoXaAHRHQ3GJvKoBVRPxlzuTJHe
         gKDGttnz7EmbTUjl5Z1B6W/T4Xr4oY0GxkoU6ccFzWPksKWN3D0VT4lGpxVRGUDeoKXI
         Wdxj5pP0Xt9OiMnX/SMYq73cTt03/6o7JgsX986jQ6SQBUAkQg0r9824Kb3HFIBfqeVW
         PiFkPLDkwDHrGii6u/I9KDb85DhzcU0eA1QYbzwub/Hy8V2/rGy/fKnM9tIVeMxPO1AO
         +qvg==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCH 0/4] Odroid n2 using eMMC would fail to boot up
Date: Tue, 26 Nov 2019 21:12:02 +0000
Message-Id: <20191126211206.4537-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Here are some small changes to fix booting of Odroid N2 

Tested on below eMMC module
new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
old back   - eMMC CGND3R 58.2 GiB MMC 5.0

-Anand

Anand Moon (4):
  mmc: meson-gx: Fix tx phase in the tuning process
  configs: meson64: enable GIC support for G12A/G12B
  board: amlogic: select PWRSEQ for all amlogic platform
  board: amlogic: Add missing config option

 arch/arm/mach-meson/Kconfig | 1 +
 configs/nanopi-k2_defconfig | 2 ++
 configs/odroid-c2_defconfig | 2 ++
 drivers/mmc/meson_gx_mmc.c  | 2 +-
 include/configs/meson64.h   | 2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.24.0

