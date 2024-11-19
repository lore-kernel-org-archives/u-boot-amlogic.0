Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E8D4414F
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:59 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.18864.1732016272381162371
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:37:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=OBVIkHdP;
 spf=pass (domain: baylibre.com, ip: 209.85.221.44, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382411ea5eeso1461573f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016271; x=1732621071; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
        b=OBVIkHdPKaxakbDgaGSwHhcayHR832ggEcdPRWjmwNx4rcFM8twVANWGb0qkYzGBm0
         M8YBRTor8gIuw1uplcSIN/MY2mvZpz0W4RXAWlxUh4lkpxGHK+P/5UJZm3dYFo5Y4ZtF
         U0Njzpwvuw38AmS5r9DluveGlPfXjOD6F4Qob1jwAEAac3BuM3UOjkQYTAR/kW97RXO3
         qvt6jmLUOGnZvsX7l4WBHvztZpzy5wkETgCSwbPcBjlATSQOkeRcSp4VtGlZi3p7MxGd
         iLFOH2JiqtTDoPiF4SPBA7ML3BUVgfM7KJInZV5LEL5LFfFbM4Ir6XEmPFfxSFA8GDjV
         8N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016271; x=1732621071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
        b=Z94DP/eN+0TPYXvZDTOksQBM57kT9A+k+uaHxPu1ujm6RG88NAPG2a2wLdQqpU8eED
         uOItzY6H7rwyylQmyUPDC6vLna0+PK5IT1Rdo9Y2DKeOd3X1y2UBHz6VVUPC+OsU4kmm
         jNXGhShErxokh/N2UdmpP66BAyITEHSaNXvunOyLRVfFmAIEOJdKtFbDgQXCe7gKEUq0
         C3UldBtIt02TH95qdvOHFRgwzJU6nqiJe/9qO+5IjhvqOFXSWsIPgu8Gl0uvgFIjCskW
         wXCh8g91rbM2NCyYDQgnAcD3w5/gp2g+HqPdb0VHuYl/UdPPdrev7hgd/qyYPMQGcf5P
         ZL9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSKCJoba/gqY95PCR6TkmmJVBs48TFGTqenGv86S9aCksxoiE7nouRDqjz7x7RXqgz6JTIVncdbcAkWfFvAQ==@groups.io
X-Gm-Message-State: AOJu0Yz18T2PbPstV7f1Ioi+UNnmuStq1VYxI6t6qoh8qRZB/JSlOayq
	bPmg4SYBqNWNjNfL56oiipSC57BkYV6arAIYBaFGzquMNSKk6Dbyrl2OcI/ASVpM+yrq7VyOGok
	N2ek=
X-Google-Smtp-Source: AGHT+IFf0RhDwz2n6osvzJqMliyLQGt2UO9s39f0Sbxdjub4qVJOOXdHH+whCwqLHZh+Lr4qNecu6A==
X-Received: by 2002:a05:6000:2a8:b0:382:2e9e:d695 with SMTP id ffacd0b85a97d-3824cd34013mr1707362f8f.24.1732016270857;
        Tue, 19 Nov 2024 03:37:50 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:37:49 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:41 +0100
Subject: [PATCH v3 4/5] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-4-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 11:37:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2571

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


