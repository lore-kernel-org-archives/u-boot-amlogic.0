Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.10220.1628176659643899259
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:39 -0700
Received: by mail-wm1-f45.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so3264840wms.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2lwFXADWfP5zTMXe/UkJdc14yXHUPx3Z9ewkD8R6dw=;
        b=neyi9oeRNbtmyjt0xfwOgzfaIEttxOhPJGyPfOsuN61fwKdTZOxSzZKzeF+ypkl+z7
         koy3NWjiLKivgSw2mXEq83l49UOrxlDL+vsdRJOBs6dY3SBdJsH1+ol6tdvhU+QEieWS
         ZwqFpsZpFQVhKjKPYL1vMGCnNST+3dEmmh5Nouave4LgXJZoMUTAWnTBzCiLTKarSCuV
         X1TItOKz9pDIz5bSr6SU+BDHnKAs3aeViuLBGS51MfeRTN8e9UW5O59GIxbRIOSA2h9q
         MQwmQqWzSgghXQSNF818d+CoqhDHy7M2TpNrSR370H4u375LL3csSz9zN2jU3Nf9rwOc
         mlrA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 6/9] configs: meson64_android: boot android via abootimg
Date: Thu,  5 Aug 2021 17:17:25 +0200
Message-Id: <20210805151728.422329-7-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Guillaume La Roque <glaroque@baylibre.com>

Since Android 10, we are required to use a "dtbo" partition which
includes the various device-tree overlays [1].
It's also possible to provide a "dtb" partition.

This is supported via the "abootimg" command.

On Yukawa, the assumption is that we have only a "dtbo" partition, which
includes all board dtbs and their dtbos [2]

[1] https://source.android.com/devices/architecture/dto/partitions
[2] https://android.googlesource.com/device/amlogic/yukawa/+/refs/heads/master/build/tasks/dtimages.mk#16
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 57 ++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 0ce616c17e..358e0a5c71 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -81,7 +81,59 @@
 #define RECOVERY_PARTITION "recovery"
 #endif
 
+#if defined(CONFIG_CMD_ABOOTIMG)
+/*
+ * Prepares complete device tree blob for current board (for Android boot).
+ *
+ * Boot image or recovery image should be loaded into $loadaddr prior to running
+ * these commands. The logic of these commnads is next:
+ *
+ *   1. Read correct DTB for current SoC/board from boot image in $loadaddr
+ *      to $fdtaddr
+ *   2. Merge all needed DTBO for current board from 'dtbo' partition into read
+ *      DTB
+ *   3. User should provide $fdtaddr as 3rd argument to 'bootm'
+ */
+#define PREPARE_FDT \
+	"echo Preparing FDT...; " \
+	"if test $board_name = sei510; then " \
+		"echo \"  Reading DTB for sei510...\"; " \
+		"setenv dtb_index 0;" \
+	"elif test $board_name = sei610; then " \
+		"echo \"  Reading DTB for sei610...\"; " \
+		"setenv dtb_index 1;" \
+	"else " \
+		"echo Error: Android boot is not supported for $board_name; " \
+		"exit; " \
+	"fi; " \
+	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
+	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
+	"fdt addr $fdt_addr_r  0x80000; " \
+	"if test $board_name = sei510; then " \
+		"echo \"  Reading DTBO for sei510...\"; " \
+		"setenv dtbo_index 0;" \
+	"elif test $board_name = sei610; then " \
+		"echo \"  Reading DTBO for sei610...\"; " \
+		"setenv dtbo_index 1;" \
+	"else " \
+		"echo Error: Android boot is not supported for $board_name; " \
+		"exit; " \
+	"fi; " \
+	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
+	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
+	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
+	"echo \"  Applying DTBOs...\"; " \
+	"adtimg addr $dtboaddr; " \
+	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
+	"fdt apply $dtbo0_addr;" \
+	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
+
+#define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
+
+#else
+#define PREPARE_FDT " "
 #define BOOT_CMD "bootm ${loadaddr};"
+#endif
 
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
@@ -153,6 +205,7 @@
 			"part start mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_start;" \
 			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
 			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+				PREPARE_FDT \
 				"echo Running Android Recovery...;" \
 				BOOT_CMD \
 			"fi;" \
@@ -174,6 +227,7 @@
 		"part start mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_start;" \
 		"part size mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_size;" \
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+			PREPARE_FDT \
 			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
 			"echo Running Android...;" \
 			BOOT_CMD \
@@ -212,7 +266,8 @@
 	"stdin=" STDIN_CFG "\0"                                       \
 	"stdout=" STDOUT_CFG "\0"                                     \
 	"stderr=" STDOUT_CFG "\0"                                     \
-	"loadaddr=0x01000000\0"                                       \
+	"dtboaddr=0x08200000\0"                                       \
+	"loadaddr=0x01080000\0"                                       \
 	"fdt_addr_r=0x01000000\0"                                     \
 	"scriptaddr=0x08000000\0"                                     \
 	"kernel_addr_r=0x01080000\0"                                  \
-- 
2.30.2

