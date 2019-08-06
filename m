Received: by mail-wr1-f67.google.com with SMTP id c2so85157697wrm.8
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr350jbfby7U/zPfI9cYgWRZdVEtmxIPA2LusWQxczo=;
        b=1cJ+5GDzyQpVSbu0yvNr7nC/uxTn+WiYMm7LvHEs5htxhIulEAxkGoi7BufUke0jAj
         C1MiXQnoYuM4Qp6YmildMrhNtStJMTo+YHqcBuhhYue/WobnY2tctgfV+b2/Nty4xhhj
         vnyZ8bd5u4IMUmHbVLXL0HxpOppq7CeZAQImSx9PG1dEipx0YFF3R2y1jM4Wgs5XhCsF
         EV2zEEznkWruMA7QqW2zR2o0XL7FpGRB7Pw6Q0AuqHkztBm5sOSQhdPc0nBJM/AUv4Ve
         QQrZPIuC7OhxR93PLgYc84RyHfQpKHDAGwl6x92cUORxj3I2f9RJ3rhKIWexo7aHkthd
         lN2Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 6/7] ARM: meson: Add support for fastboot_set_reboot_flag()
Date: Tue,  6 Aug 2019 17:43:18 +0200
Message-Id: <20190806154319.10505-7-narmstrong@baylibre.com>
In-Reply-To: <20190806154319.10505-1-narmstrong@baylibre.com>
References: <20190806154319.10505-1-narmstrong@baylibre.com>
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
index 18383f774e..9b3fb4707d 100644
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

