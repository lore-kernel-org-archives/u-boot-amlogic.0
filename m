Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDBC79FB9
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:45 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15014.1789049079217030968
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 07:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=G6MPx4DQ;
 spf=pass (domain: baylibre.com, ip: 74.125.225.76, mailfrom: glaroque@baylibre.com)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356256so1408068f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789049077; x=1789653877; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
        b=G6MPx4DQYJr1KScW5itzxppXnYiWnHGjrNkSJSLezO+Zna05j7ZdvOruw69l0m6o7K
         AThPsKaPGjG0P+vExK6VDozAOAE0xmM+EVgS24lM9H9R+zjIPQ2EG50fnB7agdB2cMVH
         JFJmoVZOyD9VEJG4M5/5q7wWalNx3GHPcgVnuNSWxtq6Qd3ALGMalXUf98Tx88VpCQ4r
         GUr8aIcrAVFZybdTDTjjq/mopF2BINfx7rIvTzn3KyMO3fiChYA9JXAFJRewsAj1oX8b
         AorFjSDTl8gxazASEjf5xNP1sH0ePbIBS2vKK4Es8jOfrqJUUvkE8c/5dzxrZk9C3QbU
         iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049077; x=1789653877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
        b=C1k67NBvMpAsLG86aMuHUtfaupKNeZBfu+5cQKtKP48wRthC7BUpL/pvgxi7JzEV+W
         2GuhPoWSF+xEGFs4pDjgBPgJ4ffbvlBctkE5wOtAg6cq2N37cX0HrGcJcIkbq+3wRt2h
         OhO1Qe5AzPlKNTJUTznaMeg85x/oqykL8ShX/Bqx2cxy2PugqnK6jyyxt8E3j1ZxTP4o
         LI/vfS8ZVQYMBYXH3o647aCK5MaAWwPYlRQTC/ptIFOLe85xpOc4YKyzwVx6GSS8tL3B
         YBadnyWBxy8xeVPbxFP0Z66iwNZ54aiQNsu4sZdBZpSUYOXQAT5E7Ol0OTvogcIKcQXA
         y2zw==
X-Gm-Message-State: AFuF++mcBaD5PrfWU2xFfOAjlLOQajDYJVsfUr1pTOzQ0y6cfRBEGKiu
	N/c88LZhEl3v4KDIbt+GLNw+C52S/I1RQ7rTCswt/+pFJDY04oOOEdIkYanP7g1DSR0=
X-Gm-Gg: AYBFou3pRDGSIRPdT5zxUKJ460oIbkzbMvNWnYSJXkn5tFqTpThSuGQdZ7gTk8sOFRL
	8yagnO5aAO8cBKHPfBztDjG7pha1QrqMSoGRDcf4gCyvNBv2IyT5yOrJVq26he9yVfrds8tABJ3
	VUisZm9dd4iiTMHeVVzppKgqWqmlZZzPklWdMdzXPa0cg3/eT5UBUccdkv1aWH+JvqUpd2+xL+O
	fUH3oT2BWO18NYME0gqHzMhzhiLfDJlp1rc9C3lzZ7ukmm+8jcXVUuTpLU9SQO+Ic4ACRhUV1QN
	Fw2ywXDMboiQX7xhmx0BkQE/PWj5bE00DrLJiI6evfzG9+bBIfrL3788v4tEQi7VQG349JzPMRh
	otgeitNzvV/m7nZ9Ge3xN2TaH4+SdwtEq878rJHw5Iif/+g2zoFePsVjmmQ1xTozci6bBeMepq6
	xevLOJDeV8Tb+ALcItVA03orCnEYu38hfXB/YDwhBL/Q0SJVe1mqD5vaGZGQxMWld7sABypcg=
X-Received: by 2002:a05:600c:548f:b0:49d:2936:8ad1 with SMTP id 5b1f17b1804b1-49d29368cc2mr40579975e9.1.1789049077348;
        Thu, 10 Sep 2026 07:04:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:24 +0200
Subject: [PATCH 3/3] configs: remove unused meson64_android.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-3-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 14:04:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3091

SEI510 and SEI610 were the last users of meson64_android.h. Remove
this unused header now that both boards use meson64.h.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS                       |   1 -
 include/configs/meson64_android.h | 279 --------------------------------------
 2 files changed, 280 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9ccca5ca4..e5bf89afdec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -198,7 +198,6 @@ F:	drivers/power/domain/meson-gx-pwrc-vpu.c
 F:	drivers/video/meson/
 F:	drivers/watchdog/meson_gxbb_wdt.c
 F:	include/configs/meson64.h
-F:	include/configs/meson64_android.h
 F:	tools/amlimage*
 F:	doc/board/amlogic/
 N:	meson
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
deleted file mode 100644
index d6ef0a83a68..00000000000
--- a/include/configs/meson64_android.h
+++ /dev/null
@@ -1,279 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for Android Amlogic Meson 64bits SoCs
- *
- * Copyright (C) 2019 Baylibre, SAS
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __MESON64_ANDROID_CONFIG_H
-#define __MESON64_ANDROID_CONFIG_H
-
-#include <linux/sizes.h>
-
-#ifndef BOOT_PARTITION
-#define BOOT_PARTITION "boot"
-#endif
-
-#ifndef LOGO_PARTITION
-#define LOGO_PARTITION "logo"
-#endif
-
-#ifndef CONTROL_PARTITION
-#define CONTROL_PARTITION "misc"
-#endif
-
-#ifndef EXTRA_ANDROID_ENV_SETTINGS
-#define EXTRA_ANDROID_ENV_SETTINGS ""
-#endif
-
-#if defined(CONFIG_CMD_AVB)
-#define AVB_VERIFY_CHECK \
-	"if test \"${force_avb}\" -eq 1; then " \
-		"if run avb_verify; then " \
-			"echo AVB verification OK.;" \
-			"setenv bootargs \"$bootargs $avb_bootargs\";" \
-		"else " \
-			"echo AVB verification failed.;" \
-		"exit; fi;" \
-	"else " \
-		"setenv bootargs \"$bootargs androidboot.verifiedbootstate=orange\";" \
-		"echo Running without AVB...; "\
-	"fi;"
-
-#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify $slot_suffix;\0"
-#else
-#define AVB_VERIFY_CHECK ""
-#define AVB_VERIFY_CMD ""
-#endif
-
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
-#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD "get_current_slot=" \
-	"if part number mmc ${mmcdev} " CONTROL_PARTITION " control_part_number; " \
-	"then " \
-		"echo " CONTROL_PARTITION \
-			" partition number:${control_part_number};" \
-		"bcb ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
-	"else " \
-		"echo " CONTROL_PARTITION " partition not found;" \
-	"fi;\0"
-
-#define AB_SELECT_SLOT \
-	"run get_current_slot; " \
-	"if test -e \"${current_slot}\"; " \
-	"then " \
-		"setenv slot_suffix _${current_slot}; " \
-	"else " \
-		"echo current_slot not found;" \
-		"exit;" \
-	"fi;"
-
-#define AB_SELECT_ARGS \
-	"setenv bootargs_ab androidboot.slot_suffix=${slot_suffix}; " \
-	"echo A/B cmdline addition: ${bootargs_ab};" \
-	"setenv bootargs ${bootargs} ${bootargs_ab};"
-
-#define AB_BOOTARGS " androidboot.force_normal_boot=1"
-#define RECOVERY_PARTITION "boot"
-#else
-#define AB_SELECT_SLOT ""
-#define AB_SELECT_ARGS " "
-#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD ""
-#define AB_BOOTARGS " "
-#define RECOVERY_PARTITION "recovery"
-#endif
-
-#if defined(CONFIG_CMD_ABOOTIMG)
-/*
- * Prepares complete device tree blob for current board (for Android boot).
- *
- * Boot image or recovery image should be loaded into $loadaddr prior to running
- * these commands. The logic of these commnads is next:
- *
- *   1. Read correct DTB for current SoC/board from boot image in $loadaddr
- *      to $fdtaddr
- *   2. Merge all needed DTBO for current board from 'dtbo' partition into read
- *      DTB
- *   3. User should provide $fdtaddr as 3rd argument to 'bootm'
- */
-#define PREPARE_FDT \
-	"echo Preparing FDT...; " \
-	"if test $board_name = sei510; then " \
-		"echo \"  Reading DTB for sei510...\"; " \
-		"setenv dtb_index 0;" \
-	"elif test $board_name = sei610; then " \
-		"echo \"  Reading DTB for sei610...\"; " \
-		"setenv dtb_index 1;" \
-	"else " \
-		"echo Error: Android boot is not supported for $board_name; " \
-		"exit; " \
-	"fi; " \
-	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
-	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
-	"fdt addr $fdt_addr_r  0x80000; "
-
-#define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
-
-#else
-#define PREPARE_FDT " "
-#define BOOT_CMD "bootm ${loadaddr};"
-#endif
-
-#define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
-	"bootcmd_fastboot=" \
-		"setenv run_fastboot 0;" \
-		"if test \"${boot_source}\" = \"usb\"; then " \
-			"echo Fastboot forced by usb rom boot;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 0; then " \
-			"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
-			"else " \
-				"echo Broken MMC partition scheme;" \
-				"setenv run_fastboot 1;" \
-			"fi; " \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 0; then " \
-			"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-			CONTROL_PARTITION "; then " \
-				"if bcb test command = bootonce-bootloader; then " \
-					"echo BCB: Bootloader boot...; " \
-					"bcb clear command; bcb store; " \
-					"setenv run_fastboot 1;" \
-				"elif bcb test command = boot-fastboot; then " \
-					"echo BCB: fastboot userspace boot...; " \
-					"setenv force_recovery 1;" \
-				"fi; " \
-			"else " \
-				"echo Warning: BCB is corrupted or does not exist; " \
-			"fi;" \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 1; then " \
-			"echo Running Fastboot...;" \
-			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
-		"fastboot "
-
-#define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
-	"bootcmd_recovery=" \
-		"pinmux dev pinctrl@14;" \
-		"pinmux dev pinctrl@40;" \
-		"setenv run_recovery 0;" \
-		"if run check_button; then " \
-			"echo Recovery button is pressed;" \
-			"setenv run_recovery 1;" \
-		"fi; " \
-		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-		CONTROL_PARTITION "; then " \
-			"if bcb test command = boot-recovery; then " \
-				"echo BCB: Recovery boot...; " \
-				"setenv run_recovery 1;" \
-			"fi;" \
-		"else " \
-			"echo Warning: BCB is corrupted or does not exist; " \
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
-			"mmc dev ${mmcdev};" \
-			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
-			AB_SELECT_SLOT \
-			AB_SELECT_ARGS \
-			AVB_VERIFY_CHECK \
-			"part start mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_start;" \
-			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
-			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-				PREPARE_FDT \
-				"echo Running Android Recovery...;" \
-				BOOT_CMD \
-			"fi;" \
-			"echo Failed to boot Android...;" \
-			"reset;" \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
-		"recovery "
-
-#define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
-	"bootcmd_system=" \
-		"echo Loading Android " BOOT_PARTITION " partition...;" \
-		"mmc dev ${mmcdev};" \
-		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
-		AB_SELECT_SLOT \
-		AB_SELECT_ARGS \
-		AVB_VERIFY_CHECK \
-		"part start mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_start;" \
-		"part size mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_size;" \
-		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			PREPARE_FDT \
-			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
-			"echo Running Android...;" \
-			BOOT_CMD \
-		"fi;" \
-		"echo Failed to boot Android...;\0"
-
-#define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
-		"system "
-
-#define BOOTENV_DEV_PANIC(devtypeu, devtypel, instance) \
-	"bootcmd_panic=" \
-		"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
-		"reset\0"
-
-#define BOOTENV_DEV_NAME_PANIC(devtypeu, devtypel, instance)	\
-		"panic "
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(FASTBOOT, fastboot, na) \
-	func(RECOVERY, recovery, na) \
-	func(SYSTEM, system, na) \
-	func(PANIC, panic, na) \
-
-#define PREBOOT_LOAD_LOGO \
-	"if test \"${boot_source}\" != \"usb\" && " \
-		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
-		"mmc dev ${mmcdev};" \
-		"part start mmc ${mmcdev} " LOGO_PARTITION " boot_start;" \
-		"part size mmc ${mmcdev} " LOGO_PARTITION " boot_size;" \
-		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			"bmp display ${loadaddr} m m;" \
-		"fi;" \
-	"fi;"
-
-#define CFG_EXTRA_ENV_SETTINGS                                     \
-	EXTRA_ANDROID_ENV_SETTINGS                                    \
-	"partitions=" PARTS_DEFAULT "\0"                              \
-	"mmcdev=2\0"                                                  \
-	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
-	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
-	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
-	AVB_VERIFY_CMD                                                \
-	"force_avb=0\0"                                               \
-	"gpio_recovery=88\0"                                          \
-	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
-	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-	"stdin=" STDIN_CFG "\0"                                       \
-	"stdout=" STDOUT_CFG "\0"                                     \
-	"stderr=" STDOUT_CFG "\0"                                     \
-	"dtboaddr=0x08200000\0"                                       \
-	"loadaddr=0x01080000\0"                                       \
-	"fdt_addr_r=0x01000000\0"                                     \
-	"scriptaddr=0x08000000\0"                                     \
-	"kernel_addr_r=0x01080000\0"                                  \
-	"pxefile_addr_r=0x01080000\0"                                 \
-	"ramdisk_addr_r=0x13000000\0"                                 \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"        \
-	BOOTENV
-
-#include <configs/meson64.h>
-
-#endif /* __MESON64_ANDROID_CONFIG_H */

-- 
2.34.1


