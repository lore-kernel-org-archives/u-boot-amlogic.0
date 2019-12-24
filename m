Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web11.2696.1577193968287518590
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Dec 2019 05:26:08 -0800
Received: by mail-pj1-f66.google.com with SMTP id d5so1194159pjz.5
        for <u-boot-amlogic@groups.io>; Tue, 24 Dec 2019 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BYMmzpXvL8oqxmEw77WpupCIartJvUZ6xEZhbZ3DC+o=;
        b=Fd97yW7MIeoRLcD2dCyCTNg/CxPQQo7aHP2q5m+2pPkovQZ0t9sazQJpc7DctB09DA
         uBuBYM0JmA4B1XK3nQ2XmEHRrHLOMLHsakFBs/hqOrgM98bfbUW0UDmpXT9vuKpzwFap
         wfJxQmx6XyCma5ouS3Go+7g09+kPI3n0ZQe6YKIn7jx3bphoZSqOXE5Kdq6T8s6d/X3m
         /K2LtsF1yZrO7c6QRZsqkk91cJ/h5+ImyPZVyAHiSlhOZeLN7K3T2D6eyPbRsKYbbpwk
         CKMjyL/ayuJYmBbTUaBSlcm3aXqrL1QRRRiDngrwwrzQyzVRh7qYaHAS/AUa1sRJ93DL
         O3hw==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCHv2 3/3] board: amlogic: select PWRSEQ for all amlogic platform
Date: Tue, 24 Dec 2019 13:25:51 +0000
Message-Id: <20191224132551.1427-4-linux.amoon@gmail.com>
In-Reply-To: <20191224132551.1427-1-linux.amoon@gmail.com>
References: <20191224132551.1427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

commit a10388dc6982 ("mmc: meson-gx: add support for mmc-pwrseq-emmc")
introduce CONFIG_PWESEQ for power sequence for eMMC module on
amlogic platform, so enable this to all amlogic boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
no changes
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index e29e4c0acc..513a33dae2 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -8,6 +8,7 @@ config MESON64_COMMON
 	select DM_SERIAL
 	select SYSCON
 	select REGMAP
+	select PWRSEQ
 	select BOARD_LATE_INIT
 	imply CMD_DM
 
-- 
2.24.1

