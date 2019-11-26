Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web12.3488.1574802739898422866
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2019 13:12:19 -0800
Received: by mail-pg1-f194.google.com with SMTP id b137so7310498pga.6
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2019 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V1ZJmTUdD9Se0n8cj01R0Wag2ZVKLNJLdmFU6DS42KA=;
        b=teDUhfaH881miBcvyQ5akurVtU7EhjpDKVO+5Je9bKp9szI9JWQWR/j68ymkE4A3k+
         eEXWvBKJxnHs28eNsRRim/MSk/Mu/erxrGrZWhOW1EFEzL58cK2xrDhMUc7ZP01jDMuP
         uBfnUdG/RxNjwGpR2GCuxQ315OeYqyO5X1lNBh4iAsozDgWpSjhoISfPpp2dhpFa6KlR
         DyJHOwAcWzR5NDMQSZDMAG0pghSCg4u4i7iega752rW+uJJoaciy4poDt+P0FuM+rdxZ
         zqhosmpi0QfXdxrXX7G+4m9kq7KOSyuzR0/FPNpaju3a54YEbmAK9vtaGb120Z7FvS0A
         tnWw==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCH 3/4] board: amlogic: select PWRSEQ for all amlogic platform
Date: Tue, 26 Nov 2019 21:12:05 +0000
Message-Id: <20191126211206.4537-4-linux.amoon@gmail.com>
In-Reply-To: <20191126211206.4537-1-linux.amoon@gmail.com>
References: <20191126211206.4537-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

commit a10388dc6982 ("mmc: meson-gx: add support for mmc-pwrseq-emmc")
introduce CONFIG_PWESEQ for power sequence for eMMC module on
amlogic platform, so enable this to all amlogic boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
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
2.24.0

