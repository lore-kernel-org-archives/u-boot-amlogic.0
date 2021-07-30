Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.21818.1627635347737050346
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:48 -0700
Received: by mail-wm1-f49.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so3246109wms.2
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhZU1MEvhq9Au8U6h5DkcWcsx3nWd0Vn2MtScqSSeqk=;
        b=yk2cjWBmq8mNlO9r73q3Zmw9C0TUDx1U6FpvjSlkdcmUGX0SZxcpXch/8uYyPPaigP
         LpbDBOf/xFRjEgIxeTm41+TzOcYoOKa3ZW0BZZSCpNCIWyCbivFjZW7Jr9vbcT4j+1ka
         x/b1zfT452p2hQi58RLNEJ7HUbF4eIRPx9S2d1CeZsxG+GfEsd7sWtHJFytSlP3DnzN0
         OZc6Q5WQcmbrlcYbEAj5qivxKbgaohCKUKaIwKxJNwaCDEK7g3eqjVS4QI9Sm35lw4oz
         K8pFlWA+5G1CqOiX3dFCUjwqapMOqLGeU5wa/p9t+w00sgJwZvPTAxdBhBCWc3s4bmXY
         57vA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 1/5] Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
Date: Fri, 30 Jul 2021 10:55:27 +0200
Message-Id: <20210730085531.2849834-2-mkorpershoek@baylibre.com>
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

With the introduction of a generic reboot flag implemented in commit
a362ce214f ("fastboot: Implement generic fastboot_set_reboot_flag"), we
no longer need the custom PSCI implementation to handle the reboot reason.

This reverts commit 9a34dedfae0ebb031a45324c2fed8c39b2c6fcf2.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 arch/arm/mach-meson/board-common.c | 34 ------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 1690b6b1e6..7ceba7cede 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -22,10 +22,7 @@
 #include <efi_loader.h>
 #include <u-boot/crc.h>
 
-#if CONFIG_IS_ENABLED(FASTBOOT)
 #include <asm/psci.h>
-#include <fastboot.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -152,38 +149,7 @@ int board_late_init(void)
 	return meson_board_late_init();
 }
 
-#if CONFIG_IS_ENABLED(FASTBOOT)
-static unsigned int reboot_reason = REBOOT_REASON_NORMAL;
-
-int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
-{
-	if (reason != FASTBOOT_REBOOT_REASON_BOOTLOADER)
-		return -ENOTSUPP;
-
-	reboot_reason = REBOOT_REASON_BOOTLOADER;
-
-	printf("Using reboot reason: 0x%x\n", reboot_reason);
-
-	return 0;
-}
-
-void reset_cpu(void)
-{
-	struct pt_regs regs;
-
-	regs.regs[0] = ARM_PSCI_0_2_FN_SYSTEM_RESET;
-	regs.regs[1] = reboot_reason;
-
-	printf("Rebooting with reason: 0x%lx\n", regs.regs[1]);
-
-	smc_call(&regs);
-
-	while (1)
-		;
-}
-#else
 void reset_cpu(void)
 {
 	psci_system_reset();
 }
-#endif
-- 
2.30.2

