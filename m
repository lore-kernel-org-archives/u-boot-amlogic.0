Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D18D2A53A
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:52 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.1937.1729181451026781904
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=CKwcCp3Z;
 spf=pass (domain: baylibre.com, ip: 209.85.221.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1530151f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181449; x=1729786249; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jMPduaHSnMoSJU1wxTBgjV7EM8SwG+3sbFMb1YVjfM=;
        b=CKwcCp3ZbcwqWfmWH0oprColHU2Tu36YVVCXQVLXNiqK6loVOst5m4okFQKeNfuXhd
         qamZvc+70NPucsQWvtoUxWz3yejhcG7HGQdPMh+CGgNyBbzMthJS7iyCcCgHNJ97ynoh
         U+WjMmqJosrdsB4T2tPsdIK0lZLlGVOu2g5TffSDv/87Q8UFGiBidbicFRofXysu5Tse
         ozQROGrqzU3yTVxgcaIvKLOWnJOd6WcNCZT7Rh4Xv8i6vbNy11K45cy8mW2TxYqy73tt
         Rp3BY8M+vp2zxjZxnDMdLc7hVT+nMox+siSM3CB5zdLJKzhigagykkM6vomE/aB6hcrR
         Ndiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181449; x=1729786249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jMPduaHSnMoSJU1wxTBgjV7EM8SwG+3sbFMb1YVjfM=;
        b=uJgtw+lI0B2iyx9yrJurW/LhxrGU3mgDN8Ufy3XzpE5hWF69uHuLpifjAHUp9MivR8
         PtIgHc/y9WUKun4KtHP8kvi8+BxcuAF0oIlT7zemznCI2Q1oKFNzgXkhuHxjLOOg2rcz
         iIwq2fVvMQXa7UXQAK6ApUWxkDROtG3Z3PlZSJ+q70ruXj/nCm5zgM6ZHhmVMBvpOoF9
         SdyQxa+Sjl4RGRH6cLvLmuzQ14pAElFIEYG8rVNNyMeDw3Gozr0m99x4bAb2b6b0DUUh
         LBro/bGApwfN/Q2EajHCGUuK6/6LfSpFp3TEvfkxrJSIRLkQWlOYlmf6yr2P+wM0H77Z
         o5xg==
X-Forwarded-Encrypted: i=1; AJvYcCVdq5G/G7v41SiR02kPFIPYoeqfB0cewdA6W/w0o3Hu8ADNyftBsgVCqdJYTSGAHgqKoMN9P4H+gvnvGJp6oA==@groups.io
X-Gm-Message-State: AOJu0YybVSng8LDTcgFWItBuMzZdQjhdwgFi/UP7ibjBokBFAXpcES27
	dzkxnivuG820YZRtaWL+R7NSdn9AMvIgUEWnzxS0+x7XNFxevUxn7amgK8MHDlQ=
X-Google-Smtp-Source: AGHT+IEDxzKg/75P+DbakFyTokzsakG6zyx488jXHOowit/cI4jtM/5UmIZi1jmkhFuryt2+xomcrA==
X-Received: by 2002:adf:a192:0:b0:37c:ffdd:6d5a with SMTP id ffacd0b85a97d-37d93dcc0e0mr2828546f8f.6.1729181449350;
        Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:29 +0200
Subject: [PATCH 5/6] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 16:10:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2507

Actually khadas vim3 use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3 android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3_android.h    | 27 +++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

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
index 0e2953fe71b3..498afd0287f4 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -41,10 +41,29 @@
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
+	"gpio_recovery=88\0"                                          \
+	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
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

-- 
2.34.1


