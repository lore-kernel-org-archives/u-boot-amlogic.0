Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E1D5A6F5
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:01 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.40856.1732608419789588944
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:07:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Wccvot/V;
 spf=pass (domain: baylibre.com, ip: 209.85.221.53, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3824aef833bso3854593f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608418; x=1733213218; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
        b=Wccvot/VQ6sVMuiaN2KkaDc8cm3Ivc3VMdH3VcoxZiK7YY5V0dYE1MxdflLanmT67W
         KJuG9oqvQncY1mBDk0JYspq5JRN6vAtqu38b2ZDmDXQ0OYsyJQkGkLioeerSHgYlk39Y
         5JKGFZgYCDYv9RXvaVVftVPUAB6r0ldalCuV9NuF2CESJlS+VuR7uQKIQ2hr1sqv8czn
         YF2y6heCeSq7Dw8KjoB+/NhnXhcoEi7g1uDtRQKfR7QW714/Z7M+1pkxdmd/qAS195Ep
         +3Wr+WQi1f26LJg/gu4CUGtnNPCRCrEqflLgshTyHoYYCRN2T1gAO2Kd6sll7CijwowZ
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608418; x=1733213218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
        b=q2ixzNctv5P+GA+/qGs7tUXx3Nsl5i1jrwjfjNuJz/ED4LfgWYYLmGespkJDApfLCF
         2HKv4T6oPNlglD1vPzhX4FAE30wKsIyfK1y4LZ+aNIzdK5o3O2S4SdGgsb1E/s0KVy1j
         QjaQ8yGlHlAUzBJcyLOkiKJQDBT00Tnin8I1VopeVv813IMhYzm1j9WsuuideVEHhs97
         HVT0YMyq27c2VhUNJZ0X4BW26U+7oC2SxVFAri2tqSsAbNaH6xK1WXbDfUqDkuHhm/sZ
         HKlKeWycspSNaMKD5xGW4lSfZnKYpdWwaayOteMyug7uHMdDXJF3GnLj1J8880CWaPBd
         XxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCOPH0AzoK9hBb6uPFJcn7tbFl1WlSFMD3mt31xbIQAr242szASYEzZQ7pmYDL0ffEEIAgZKlBQI96LYIeUg==@groups.io
X-Gm-Message-State: AOJu0YyOE33MUY68L9zHTfwDop2n9mkpnz31IobR0xLFTWkVSxebFodA
	tAtnlY1GkquTN5j99WeQhMrPrIV1ogE1b9ZtOnRvlMNN5m3GPJ77QKSE/5YLOnY=
X-Gm-Gg: ASbGncsJ1kMXiz8QcIP3KxKTsPfoL2YpRg/R1HiME24LmRyHmGxyWkp+Ofdub+VACql
	FVqd2/2cSqelLTwP13w/8/Uc1QUXnPfhgnJ4l1jev64Bg0AX2/jkTYpDNzx8O1Fxj+72ZSYjV3Q
	mLipeNIsP2j8H/xn9WFbOIydau/rdFY7uc+R6idbXPAzfB8AxRDOFEN2t+gw7OjynASPIdaZbZA
	pIjh74SmrYQ+JjrIulQxae/rXE5CRugVwuhfho2FqLJqvBUHc6eaQ==
X-Google-Smtp-Source: AGHT+IGeSfFme87wY8h9zJjOPAIhwCvNmqre2uOfc3DOi+CUJOHPcQSYIlU59S2Lmy02eOIvWevQfw==
X-Received: by 2002:a05:6000:4402:b0:382:4300:34d1 with SMTP id ffacd0b85a97d-38260b6e937mr9711368f8f.31.1732608418200;
        Tue, 26 Nov 2024 00:06:58 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:57 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:11 +0100
Subject: [PATCH v4 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-3-11636106dc69@baylibre.com>
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
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2586

Actually khadas vim3l use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3l android.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 25 +++++++++++++++++++++----
 include/configs/meson64_android.h         |  3 ---
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 4d7b90f23002..43db61056baf 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
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
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 4ec27262cdc7..32d57a5b9090 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
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
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index f39a3782d663..1869249e7c9e 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -41,10 +41,27 @@
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
-#define EXTRA_ANDROID_ENV_SETTINGS \
-	"board=vim3l\0" \
-	"board_name=vim3l\0" \
+#define CFG_EXTRA_ENV_SETTINGS                                    \
+	"board=vim3l\0"                                               \
+	"board_name=vim3l\0"                                          \
+	"bootmeths=android\0"                                         \
+	"bootcmd=bootflow scan\0"                                     \
+	"adtb_idx=2\0"                                                \
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
index 77364bbf9cf0..37ef8b8f7a7e 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -104,9 +104,6 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTB for sei610...\"; " \
 		"setenv dtb_index 1;" \
-	"elif test $board_name = vim3l; then " \
-		"echo \"  Reading DTB for vim3l...\"; " \
-		"setenv dtb_index 2;" \
 	"elif test $board_name = vim3; then " \
 		"echo \"  Reading DTB for vim3...\"; " \
 		"setenv dtb_index 3;" \

-- 
2.34.1


