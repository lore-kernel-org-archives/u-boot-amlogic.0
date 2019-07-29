Received: by mail-wm1-f66.google.com with SMTP id p74so53939204wme.4
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bm0WfA6USY8ij3P3Yuv/wGc4d8WlXw4CuY4WHjJL7I=;
        b=I5QULaeoFiDdfyhA9rR7ShDFa4EGRnN5jPem8pLzbkYbTTsSE44A3PP8EG7dcRO1Nj
         sD/gf1ykEHbMhspy5qrUYqNVGao1Ybnaw8jy/5lhcv6bd5k9pnMdgUbseqoWIrMsjfoX
         MjpbbYEr02CwP1/YV9ab15i8CMN1/YVukkXuyFGYVCmO3PMycXNNx7kFkZtL2+qFL+p7
         Pmay9WCmQbFjlRpr5mLSu8ffdzTFyuHA7zSrhSzNXYmvtUKfy8CwrUkrlbYeNOIgc0rb
         +FuFsYpZxr4bJqFobhsEUHWTXvekFrNI8z5uT9s87I1//E5YVPp52K615+1HvNDuE8M/
         7T/A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/5] ARM: meson: Add support for fastboot_set_reboot_flag()
Date: Mon, 29 Jul 2019 16:01:57 +0200
Message-Id: <20190729140158.6954-5-narmstrong@baylibre.com>
In-Reply-To: <20190729140158.6954-1-narmstrong@baylibre.com>
References: <20190729140158.6954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for fastboot_set_reboot_flag() by storing the reboot
flag in the common code to be used by the custom PSCI reboot handler.
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

