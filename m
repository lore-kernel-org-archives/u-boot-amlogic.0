Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.5302.1608196022191242424
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Dec 2020 01:07:03 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201217090644euoutp028634157e95e9834c19340f97712d1b30~Rdb7deiG50613906139euoutp02b
	for <u-boot-amlogic@groups.io>; Thu, 17 Dec 2020 09:06:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201217090644euoutp028634157e95e9834c19340f97712d1b30~Rdb7deiG50613906139euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608196004;
	bh=rO6ZtC7/2GfmHNLyS/Wh+JO9DwZo/WFi/2UPkH05UR4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=s/bRUfMRB8lvieoXjRi2rQnPIRy16T8j+9DLy6iZ1Hv7TmTxPGCZ1tmu5wY0fm9Kh
	 Mz75sMky+uVWD+KgGNOVKdIwSqw7KhEvlN2qCIvhuzZGjJTx/hgmfJlKIf2Q5uqx0d
	 aPPhsYeuoEgVSJ4xWJQx5cJT3zE/YVyIUvPaxtC4=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
Date: Thu, 17 Dec 2020 10:06:24 +0100
Message-Id: <20201217090624.14902-1-m.szyprowski@samsung.com>
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
pin to the input (high impedance?) mode, otherwise the board is stuck
in the middle of loading early stages of the bootloader from SD card.

This has been achieved by hijacking reset_misc() callback from the PSCI
firmware in the Odroid board code. The common meson cpu_reset() function,
which is called later during the reboot procedure, will call PSCI reboot
anyway.

This issue doesn't happen if board is booted from eMMC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 board/amlogic/odroid-n2/odroid-n2.c | 15 +++++++++++++++
 configs/odroid-c4_defconfig         |  1 +
 2 files changed, 16 insertions(+)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index caf7fd6810..ad91de7ac5 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -10,6 +10,7 @@
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
+#include <asm/gpio.h>
 #include <asm/arch/sm.h>
 #include <asm/arch/eth.h>
 
@@ -47,3 +48,17 @@ int misc_init_r(void)
 
 	return 0;
 }
+
+#ifndef CONFIG_PSCI_RESET
+void reset_misc(void)
+{
+	if (of_machine_is_compatible("hardkernel,odroid-c4")) {
+		unsigned int gpio;
+		const char *str_gpio = "aobus-banks3";
+
+		gpio_lookup_name(str_gpio, NULL, NULL, &gpio);
+		gpio_request(gpio, "reboot");
+		gpio_direction_input(gpio);
+	}
+}
+#endif
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 367d22db0b..ca0ab71a7a 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -14,6 +14,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
+# CONFIG_PSCI_RESET is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_GPIO=y
-- 
2.17.1

