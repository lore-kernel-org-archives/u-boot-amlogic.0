Received: by mail-wr1-f68.google.com with SMTP id n4so62095689wrs.3
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfS1KarqMiDlhrcCVVOeXBSiyZ6gwq51CSNmjufcvFY=;
        b=UyDoYKFUoPr1eV2kvAxdlzCsPVRdH0U3jA5aYYMjUqR/jg90NzzGqfti4saFsj66cR
         opH2a8EiXvdht23NrRNsT2y6iG7pEUSCNwoqEhWNTddFbNDcNZe17EnfSElxQWTHu2ba
         yOeo7jkJ8tyUTlMXfxIlnXWsSEbiOvxcLa/yef5burBOssIrM9WJVvdiTBw/RVkvTFYN
         U0aCQEAD+8yLm8dOv1F9O2O85GP3xBoHuPUXJbBB/OWm2Ab3Cu1vfKnW4tnmnHcGXyQZ
         rg1bb2K87XgOlVXfcyQCCY9gZ2JKlvW5hYednhXnA4nb67Q2JHdIRNjL/2+CWFEcb/5m
         r7DA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RESEND PATCH 4/5] ARM: meson: Add support for fastboot_set_reboot_flag()
Date: Mon, 29 Jul 2019 16:07:50 +0200
Message-Id: <20190729140751.7851-5-narmstrong@baylibre.com>
In-Reply-To: <20190729140751.7851-1-narmstrong@baylibre.com>
References: <20190729140751.7851-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for fastboot_set_reboot_flag() by storing the reboot
flag in the common code to be used by the custom PSCI reboot handler.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-common.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 18383f774e..c39643fc17 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -14,6 +14,11 @@
 #include <asm/unaligned.h>
 #include <efi_loader.h>
 
+#if CONFIG_IS_ENABLED(FASTBOOT)
+#include <asm/psci.h>
+#include <fastboot.h>
+#endif
+
 DECLARE_GLOBAL_DATA_PTR;
 
 __weak int board_init(void)
@@ -142,7 +147,35 @@ int board_late_init(void)
 	return meson_board_late_init();
 }
 
+#if CONFIG_IS_ENABLED(FASTBOOT)
+static unsigned int reboot_reason = REBOOT_REASON_NORMAL;
+
+int fastboot_set_reboot_flag()
+{
+	reboot_reason = REBOOT_REASON_BOOTLOADER;
+
+	printf("Using reboot reason: 0x%x\n", reboot_reason);
+
+	return 0;
+}
+
+void reset_cpu(ulong addr)
+{
+	struct pt_regs regs;
+
+	regs.regs[0] = ARM_PSCI_0_2_FN_SYSTEM_RESET;
+	regs.regs[1] = reboot_reason;
+
+	printf("Rebooting with reason: 0x%lx\n", regs.regs[1]);
+
+	smc_call(&regs);
+
+	while (1)
+		;
+}
+#else
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();
 }
+#endif
-- 
2.22.0

