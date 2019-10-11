Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.1823.1570808048755180473
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:09 -0700
Received: by mail-wr1-f66.google.com with SMTP id y19so12437335wrd.3
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJLoPVPsh0M3m+7W85DmlzHjkc/RikvP2nWFMPd7aFo=;
        b=gMRP7EqPRN5x5WAovUQsNWVtNk/yQNRm12pVQmMtsdhpBHJL9LN83PNDusqF+XHVEb
         BXDmxvaVtg47Oslb77wCMqGeV2bGyF0OD3r+yh1Z0Sw2tevxYu++kRNEvbr8EkIDrSce
         ZCHQ5TAk0IoOB7WbwrPgk4Eih0kASy07B2b8TqAydzILTSOMYlckIfY+a51z2sBq3HV/
         Pn5RPnjldmgC55fc66PwRI5ucfTjucLplD2G9O56de/MnjCPtvAQOAR9vMdY9s4KpRWQ
         ldQrwrD+XwSRG08w6d9a2tFFcsCwlPbKnmhsTZwuUavEPuD29lHDinhWjQGGt0Kt8Nqe
         fRlw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 7/8] configs: sei510: rework header and fix userdata size
Date: Fri, 11 Oct 2019 17:33:57 +0200
Message-Id: <20191011153358.29739-8-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Guillaume La Roque <glaroque@baylibre.com>

Move android generic config and boot sequence in meson64_android header
and fix size of userdata to use all eMMC on SEI510.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS                       |   1 +
 include/configs/meson64_android.h | 136 ++++++++++++++++++++++++++++++
 include/configs/sei510.h          | 121 +-------------------------
 3 files changed, 139 insertions(+), 119 deletions(-)
 create mode 100644 include/configs/meson64_android.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c53656695a..e874a44c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -137,6 +137,7 @@ F:	drivers/pinctrl/meson/
 F:	drivers/power/domain/meson-gx-pwrc-vpu.c
 F:	drivers/video/meson/
 F:	include/configs/meson64.h
+F:	include/configs/meson64_android.h
 N:	meson
 
 ARM BROADCOM BCM283X
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
new file mode 100644
index 0000000000..055fb44e93
--- /dev/null
+++ b/include/configs/meson64_android.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for Android Amlogic Meson 64bits SoCs
+ *
+ * Copyright (C) 2019 Baylibre, SAS
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON64_ANDROID_CONFIG_H
+#define __MESON64_ANDROID_CONFIG_H
+
+#define CONFIG_SYS_MMC_ENV_DEV	2
+#define CONFIG_SYS_MMC_ENV_PART	1
+#define CONFIG_ENV_SIZE		0x10000
+#define CONFIG_ENV_OFFSET	(-0x10000)
+
+
+#define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
+	"bootcmd_fastboot=" \
+		"sm reboot_reason reason;" \
+		"setenv run_fastboot 0;" \
+		"if test \"${boot_source}\" = \"usb\"; then " \
+			"echo Fastboot forced by usb rom boot;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
+		"else " \
+			"echo Broken MMC partition scheme;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${reason}\" = \"bootloader\" -o " \
+			"\"${reason}\" = \"fastboot\"; then " \
+			"echo Fastboot asked by reboot reason;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${skip_fastboot}\" -eq 1; then " \
+			"echo Fastboot skipped by environment;" \
+			"setenv run_fastboot 0;" \
+		"fi;" \
+		"if test \"${force_fastboot}\" -eq 1; then " \
+			"echo Fastboot forced by environment;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${run_fastboot}\" -eq 1; then " \
+			"echo Running Fastboot...;" \
+			"fastboot 0;" \
+		"fi\0"
+
+#define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
+		"fastboot "
+
+/* TOFIX: Run actual recovery instead of fastboot */
+#define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
+	"bootcmd_recovery=" \
+		"pinmux dev pinctrl@14;" \
+		"pinmux dev pinctrl@40;" \
+		"sm reboot_reason reason;" \
+		"setenv run_recovery 0;" \
+		"if run check_button; then " \
+			"echo Recovery button is pressed;" \
+			"setenv run_recovery 1;" \
+		"elif test \"${reason}\" = \"recovery\" -o " \
+			  "\"${reason}\" = \"update\"; then " \
+			"echo Recovery asked by reboot reason;" \
+			"setenv run_recovery 1;" \
+		"fi;" \
+		"if test \"${skip_recovery}\" -eq 1; then " \
+			"echo Recovery skipped by environment;" \
+			"setenv run_recovery 0;" \
+		"fi;" \
+		"if test \"${force_recovery}\" -eq 1; then " \
+			"echo Recovery forced by environment;" \
+			"setenv run_recovery 1;" \
+		"fi;" \
+		"if test \"${run_recovery}\" -eq 1; then " \
+			"echo Running Recovery...;" \
+			"fastboot 0;" \
+		"fi\0"
+
+#define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
+		"recovery "
+
+#define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
+	"bootcmd_system=" \
+		"echo Loading Android boot partition...;" \
+		"mmc dev ${mmcdev};" \
+		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
+		"part start mmc ${mmcdev} ${bootpart} boot_start;" \
+		"part size mmc ${mmcdev} ${bootpart} boot_size;" \
+		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+			"echo Running Android...;" \
+			"bootm ${loadaddr};" \
+		"fi;" \
+		"echo Failed to boot Android...;" \
+		"reset\0"
+
+#define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
+		"system "
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(FASTBOOT, fastboot, na) \
+	func(RECOVERY, recovery, na) \
+	func(SYSTEM, system, na) \
+
+#define PREBOOT_LOAD_LOGO \
+	"mmc dev ${mmcdev};" \
+	"part start mmc ${mmcdev} ${logopart} boot_start;" \
+	"part size mmc ${mmcdev} ${logopart} boot_size;" \
+	"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+			"bmp display ${loadaddr} m m;" \
+	"fi;"
+
+#define CONFIG_EXTRA_ENV_SETTINGS                                     \
+	"partitions=" PARTS_DEFAULT "\0"                              \
+	"mmcdev=2\0"                                                  \
+	"bootpart=1\0"                                                \
+	"logopart=2\0"                                                \
+	"gpio_recovery=88\0"                                          \
+	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
+	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
+	"console=/dev/ttyAML0\0"                                      \
+	"bootargs=no_console_suspend\0"                               \
+	"stdin=" STDIN_CFG "\0"                                       \
+	"stdout=" STDOUT_CFG "\0"                                     \
+	"stderr=" STDOUT_CFG "\0"                                     \
+	"loadaddr=0x01000000\0"                                       \
+	"fdt_addr_r=0x01000000\0"                                     \
+	"scriptaddr=0x08000000\0"                                     \
+	"kernel_addr_r=0x01080000\0"                                  \
+	"pxefile_addr_r=0x01080000\0"                                 \
+	"ramdisk_addr_r=0x13000000\0"                                 \
+	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" BOOTENV
+
+#include <configs/meson64.h>
+
+#endif /* __MESON64_ANDROID_CONFIG_H */
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index 5bf982cada..d37b4c6405 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -9,11 +9,6 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#define CONFIG_SYS_MMC_ENV_DEV	2
-#define CONFIG_SYS_MMC_ENV_PART	1
-#define CONFIG_ENV_SIZE		0x10000
-#define CONFIG_ENV_OFFSET	(-0x10000)
-
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
 #define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
@@ -28,122 +23,10 @@
 	"name=cache,size=256M,uuid=" CACHE_UUID             \
 	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
 	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
-	"name=userdata,size=4746M,uuid=" USERDATA_UUID	\
+	"name=userdata,size=5341M,uuid=" USERDATA_UUID	\
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
-#define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
-	"bootcmd_fastboot=" \
-		"sm reboot_reason reason;" \
-		"setenv run_fastboot 0;" \
-		"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
-		"else " \
-			"echo Broken MMC partition scheme;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${reason}\" = \"bootloader\" -o " \
-			"\"${reason}\" = \"fastboot\"; then " \
-			"echo Fastboot asked by reboot reason;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${skip_fastboot}\" -eq 1; then " \
-			"echo Fastboot skipped by environment;" \
-			"setenv run_fastboot 0;" \
-		"fi;" \
-		"if test \"${force_fastboot}\" -eq 1; then " \
-			"echo Fastboot forced by environment;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 1; then " \
-			"echo Running Fastboot...;" \
-			"fastboot 0;" \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
-		"fastboot "
-
-/* TOFIX: Run actual recovery instead of fastboot */
-#define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
-	"bootcmd_recovery=" \
-		"pinmux dev pinctrl@14;" \
-		"pinmux dev pinctrl@40;" \
-		"sm reboot_reason reason;" \
-		"setenv run_recovery 0;" \
-		"if run check_button; then " \
-			"echo Recovery button is pressed;" \
-			"setenv run_recovery 1;" \
-		"elif test \"${reason}\" = \"recovery\" -o " \
-			  "\"${reason}\" = \"update\"; then " \
-			"echo Recovery asked by reboot reason;" \
-			"setenv run_recovery 1;" \
-		"fi;" \
-		"if test \"${skip_recovery}\" -eq 1; then " \
-			"echo Recovery skipped by environment;" \
-			"setenv run_recovery 0;" \
-		"fi;" \
-		"if test \"${force_recovery}\" -eq 1; then " \
-			"echo Recovery forced by environment;" \
-			"setenv run_recovery 1;" \
-		"fi;" \
-		"if test \"${run_recovery}\" -eq 1; then " \
-			"echo Running Recovery...;" \
-			"fastboot 0;" \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
-		"recovery "
-
-#define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
-	"bootcmd_system=" \
-		"echo Loading Android boot partition...;" \
-		"mmc dev ${mmcdev};" \
-		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
-		"part start mmc ${mmcdev} ${bootpart} boot_start;" \
-		"part size mmc ${mmcdev} ${bootpart} boot_size;" \
-		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			"echo Running Android...;" \
-			"bootm ${loadaddr};" \
-		"fi;" \
-		"echo Failed to boot Android...;" \
-		"reset\0"
-
-#define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
-		"system "
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(ROMUSB, romusb, na)  \
-	func(FASTBOOT, fastboot, na) \
-	func(RECOVERY, recovery, na) \
-	func(SYSTEM, system, na) \
-
-#define PREBOOT_LOAD_LOGO \
-	"mmc dev ${mmcdev};" \
-	"part start mmc ${mmcdev} ${logopart} boot_start;" \
-	"part size mmc ${mmcdev} ${logopart} boot_size;" \
-	"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			"bmp display ${loadaddr} m m;" \
-	"fi;"
-
-#define CONFIG_EXTRA_ENV_SETTINGS                                     \
-	"partitions=" PARTS_DEFAULT "\0"                              \
-	"mmcdev=2\0"                                                  \
-	"bootpart=1\0"                                                \
-	"logopart=2\0"                                                \
-	"gpio_recovery=88\0"                                          \
-	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
-	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-	"console=/dev/ttyAML0\0"                                      \
-	"bootargs=no_console_suspend\0"                               \
-	"stdin=" STDIN_CFG "\0"                                       \
-	"stdout=" STDOUT_CFG "\0"                                     \
-	"stderr=" STDOUT_CFG "\0"                                     \
-	"loadaddr=0x01000000\0"                                       \
-	"fdt_addr_r=0x01000000\0"                                     \
-	"scriptaddr=0x08000000\0"                                     \
-	"kernel_addr_r=0x01080000\0"                                  \
-	"pxefile_addr_r=0x01080000\0"                                 \
-	"ramdisk_addr_r=0x13000000\0"                                 \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" BOOTENV
 
-#include <configs/meson64.h>
+#include <configs/meson64_android.h>
 
 #endif /* __CONFIG_H */
-- 
2.22.0

