Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D50D6A237
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:07 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.5706.1731619799177787108
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:29:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=riRLnjyl;
 spf=pass (domain: baylibre.com, ip: 209.85.128.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so327665e9.2
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619797; x=1732224597; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iaWsIQ/lrwU9hPfsnOvnB0kEn5LkE9AoLbBkdqoGBM=;
        b=riRLnjylg+O/mKEkNOEGF4ZDRybVHwtDUFry0T/ezmDR0zNi2dVXPPnktDkC2nM5zT
         K92JgGGnhB3Dt484bwFPpGbHUuNCK0imPFytQ2fPS1X7Vo7CsDL/b5OFcVGdZgJeyApc
         80sAvs7zxUfJ9kYeLH3wu3tMGEWHzpK1SQjcnadHeXgIY3QYD0mgpLYQcp5oqQMrV20z
         CB83qIW+Zg5RsztPt6xER2u7fzaD/wPuPEeycAcOOqhNPXcZu7saeEYP5QmzHvgrmQXR
         fRnRvBaeOSj/0hKB6DLqs+7Dat0ZB2fVsSGf2ZlOPL2MaDRgkEry4+acsyppVX58y6JC
         LRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619797; x=1732224597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iaWsIQ/lrwU9hPfsnOvnB0kEn5LkE9AoLbBkdqoGBM=;
        b=q3sihlX5IuL4GSrHwCMkjqY8MscZQTdORs+cAt5ISfYIdCsaetKEdYOczHDxAcf4dh
         z/UqKFvqYF+vcNeBXxNjCIjs8LAiGqrFiehj+akeeawKOAcnMYaUHcbOFk5+/+pQOZ9j
         vtfa1jIxMO+wqWaFkOnvtAyQ7ZOMvoqPR6nR+2/fA+gDr4y/VPs8DM+Io/sMdmrIH6x3
         FT/fAqn0jIad0QZc46JLAc5av+NS84eZbJ0TWn/YrmMWs/RbcqKXTyLbuncQQJ2M2tbU
         FLHrLh9ugcjUxciCE13iXMnYKbiMNErigH3/nbP2Upqkq5p5Y+iuBIMQgKAciSFcEfng
         9YuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRUVIcauWTNNCIV/fQUzcpRh5edeFCVybFKlVTMzALCAsDiYoHy5XlkZ2ARof1LELMWNvUTNdzFIbFhcyU6A==@groups.io
X-Gm-Message-State: AOJu0YxCOqrEUWzTmhlqGNc4PIhfCAyGRbTxIWfYmq/CEOGuLUK4Y1mI
	pEUbl3j+yMQXPabgXZgwemObd4xjhrbmJkE1A090D+IvKQiKgK2Yf1iOrtY6lzH+IceHkBeBZa8
	DXuU=
X-Google-Smtp-Source: AGHT+IEq9q+92CFNkTcQ6/3tmjw72APdCAo4TmnTMaIculUFoX3oRkUtZHZyK991nDz4dyTg1my3Ig==
X-Received: by 2002:a05:6000:788:b0:382:6f2:df7b with SMTP id ffacd0b85a97d-38225902408mr181539f8f.12.1731619797355;
        Thu, 14 Nov 2024 13:29:57 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:56 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:47 +0100
Subject: [PATCH v2 4/5] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 21:30:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2555

Actually khadas vim3 use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3 android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3_android.h    | 26 ++++++++++++++++++++++----
 include/configs/meson64_android.h        |  3 ---
 4 files changed, 34 insertions(+), 9 deletions(-)

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
index 0e2953fe71b3..096ab4e5fb1f 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -41,10 +41,28 @@
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


