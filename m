Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B4D5A6F2
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:11 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.41175.1732608420684499630
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:07:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=GNqzqqXN;
 spf=pass (domain: baylibre.com, ip: 209.85.221.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382296631f1so4225634f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608419; x=1733213219; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
        b=GNqzqqXN+juO8OSRThqFUFHA07tD5hcM5u6vUJ/HOnpOZMn60pJndxugDxmZ31/dJo
         CDzfi1tnh9C5Fpns2YvFGqbQYDkRWXWqHxfMOhrweGDhWZR8M9U1hcgEX4wG24b4Ly2d
         sMWp2lD6iQ2mEDiO2Z0kQ/dREchfXZQX8fUMckRNq5WJyJev5MpUawKfLVge/lhg8sn6
         Oq5hsk9rbYwhKnfEUo4BpiGCJFOVy9BI/uO8yCm6zlFgkqSvbAqmYAOtwm1Edr4R4KuE
         gYTRnXmsvF9Bthnz/Upv/t9V/p6RGDrU8F9FLzN3EKonKO0ROQ1dL0kYR+jxiWcxH4ld
         ht8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608419; x=1733213219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
        b=gJDF1bE1dkBFR5iRC6gmmS/JtlCuErxcbjUq7IQkTnILkZa/t/lXB19Xknol9BycM3
         H1oSmCZtk8HgUWprjRWf8/BVDhSp4dvA0G6n8tcjIO+S+MXD14Cq2MAP6wKHKw4wKgMI
         BiCEs8zu6XaeZBUue6jkIj71c9lFA1gKEp2t8RzVwrixJQCLYG6eIlpO46Q3I4vgP5D5
         plpgbf8yjcLZLV5/np6aYc/sdVShWp0kQ/Z2Zns4vqflk0KpZIrjTY62dLRwH+LU72ay
         D8t0662p9sbWXT3yY6OPjpLnKm/atpQAf72Ka8oVqO1QnUQ1tnYBUxQnHiM3Vlq8ky/J
         OqDA==
X-Forwarded-Encrypted: i=1; AJvYcCXnDijqIi75gHds1zn33I5L/FAr6Y3m3ad6dtCZqit6GxNReKnmsEnFniu9M5YTklETEggnziIEBmqiKNQ7QA==@groups.io
X-Gm-Message-State: AOJu0YyEeU5qUxryJu/ruJogyi8+6kcmMzB3Fx7JmfGfLtvaofZ7teet
	CqinNXPnQfozpTsVepEUHeNn7r9bl/INyB1vm5R35LUtC4hgSpZ8ym9MgzgN+H/YeQQkFjQO7FX
	2L0A=
X-Gm-Gg: ASbGncsWQ6tlq58xWKgM8L1YPtDMAB67CUOujqZk8Rx6+EPwt05f6Aj33qC9M7WzBCr
	+6ERUAaLlUQ4PJfAVXfV8nLes6z7LCWDsBi8qSjaUwoPauGZ2OSoHZ0P2jctmTIJXSKvItbpp1x
	hFUiVmpDuI0RAOeGgRaA/qT/jnO3/bnQj7SrZSS+CsL/Ba2nSxLadLisJw/asDSZvLcp0DfnDnE
	6+p5tlLaQIo/vwMr/hV6xPIZTc4grFCfc8SpThwCq26FWEZvSelBA==
X-Google-Smtp-Source: AGHT+IEk8YFTSN+0QYxaFTbcAZYwTyrN1XV9QNgJGuVrL1D2z7KFtuGe+6VTqSFrwLU42h27V3eTPA==
X-Received: by 2002:a05:6000:18ae:b0:374:c847:852 with SMTP id ffacd0b85a97d-38260b806f8mr14209525f8f.29.1732608419050;
        Tue, 26 Nov 2024 00:06:59 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:58 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:12 +0100
Subject: [PATCH v4 4/5] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-4-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2587

Actually khadas vim3 use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3 android.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3_android.h    | 25 +++++++++++++++++++++----
 include/configs/meson64_android.h        |  3 ---
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index de5357c45cbf..a078c5d363ae 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTMETH_ANDROID=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
+# CONFIG_BOOTMETH_EFILOADER is not set
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index a0d9c423c3c3..b77a44ce859b 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTMETH_ANDROID=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
+# CONFIG_BOOTMETH_EFILOADER is not set
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 0e2953fe71b3..551ab51c8813 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -41,10 +41,27 @@
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
-#define EXTRA_ANDROID_ENV_SETTINGS \
-	"board=vim3\0" \
-	"board_name=vim3\0" \
+#define CFG_EXTRA_ENV_SETTINGS                                    \
+	"board=vim3\0"                                               \
+	"board_name=vim3\0"                                          \
+	"bootmeths=android\0"                                         \
+	"bootcmd=bootflow scan\0"                                     \
+	"adtb_idx=3\0"                                                \
+	"partitions=" PARTS_DEFAULT "\0"                              \
+	"mmcdev=2\0"                                                  \
+	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
+	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
+	"stdin=" STDIN_CFG "\0"                                       \
+	"stdout=" STDOUT_CFG "\0"                                     \
+	"stderr=" STDOUT_CFG "\0"                                     \
+	"dtboaddr=0x08200000\0"                                       \
+	"loadaddr=0x01080000\0"                                       \
+	"fdt_addr_r=0x01000000\0"                                     \
+	"scriptaddr=0x08000000\0"                                     \
+	"kernel_addr_r=0x01080000\0"                                  \
+	"pxefile_addr_r=0x01080000\0"                                 \
+	"ramdisk_addr_r=0x13000000\0"                                 \
 
-#include <configs/meson64_android.h>
+#include <configs/meson64.h>
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 37ef8b8f7a7e..d6ef0a83a686 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -104,9 +104,6 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTB for sei610...\"; " \
 		"setenv dtb_index 1;" \
-	"elif test $board_name = vim3; then " \
-		"echo \"  Reading DTB for vim3...\"; " \
-		"setenv dtb_index 3;" \
 	"else " \
 		"echo Error: Android boot is not supported for $board_name; " \
 		"exit; " \

-- 
2.34.1


