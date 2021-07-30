Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.23218.1627648103933534050
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:28:24 -0700
Received: by mail-wr1-f51.google.com with SMTP id b13so242769wrs.3
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAPWITdfytWB3WSOGm9UhvBKEIUsc0K86kBMnUQRzpw=;
        b=WrNJC7ink4vYxTH0euXjJnBlBoTj2eKhJTLrTzc1/PYN4+hfXzl7v5rnlWoIQv1ysH
         mYA74h7AduDnlO85oAQLGqr7vXC4ph2uYtI5wWDlrIlwlzWrbQe/IO7BCzTPLOxEZUbu
         h8tjqPLdmlofTpvUX/rZHxr8YPDWKv20650PsjCVYPU/2ua6EgOF6nEvd3vf9lxVrh2K
         uxsfNC7JANI7bYX6dQCDgerhrDlQ4D2HZK9ILB4KNx+Nqn4GUek3pUM6W7G34yQpUtA2
         nz7l/gBrymz9g9Hsj+io6wD3j/5xs/1WxDN6QP9bACLiNkdCJyN/48CE1+vwa59XLhcp
         FjvQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 5/5] Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
Date: Fri, 30 Jul 2021 14:28:12 +0200
Message-Id: <20210730122812.3011529-6-mkorpershoek@baylibre.com>
In-Reply-To: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
References: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
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
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
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

