Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52119D374BA
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:52 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.1936.1729181450406185889
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Bf2fItpR;
 spf=pass (domain: baylibre.com, ip: 209.85.221.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso880300f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181449; x=1729786249; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygt+QlXmPz7QPvV/FOkEoevXTJvSaZYjqUPyEEMUWtE=;
        b=Bf2fItpRUWFy4p2HymQ0NxIpZrLGZAPc1P+QSjKGaDgTGy6fA3yzOvteLYYknNH0ec
         I19fDPhS+zW6YAClQO6wWFP5sTWFeQkZX13WWHan1K4O1lcjrptvvDtIL4t/ZCdywKDH
         pBM92w3EkYkYI1Nz6r345lpnk6LDuX3HlJ/d3AIHgAybOLiUHcV1epKGJ5Ei2zH3aoLz
         1aRXEUWF67xLcYZ3DDDBsbGBvTn/gkIN8YPIViSzs+mKvPtIxisyTAMV0GtxgJYQ06Tp
         fuY46bll2dhlPZK1V2VOuo+IwtheJtvy29aCcnAitgQ45ePZe6igNj3iTjapF9T5CGBs
         C+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181449; x=1729786249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygt+QlXmPz7QPvV/FOkEoevXTJvSaZYjqUPyEEMUWtE=;
        b=fFr6raQDfWqXvV6X72P45CeLqknU/7OSY3sSGJI6PE8YQ6LbiIA4E/NIzMG7ex1+CD
         xR5BDgdnW1zOrRi13NYjt2//C2TgCGLdlaH2jAP/3YzAgTxjuH8RCaYORaHDzPQq9RgA
         otQGSy+SXc1G1+dQYZNoxCU4Dddub4dJiX9SP9XGKFv4OQWw/DfOZF1FQTbNZ1HUueYp
         D9F5hts7rLppVr//Pz1aZEMcGMdE3cZy/V2BpDaw3VEwqOYhH2TMcP9A+yLzL8DL8meT
         n7l4WemwSXDDyfz3x32QNp02pCNYdb084PfjKM/H11xCD45G1YVDq0TZFJVuaMEOec3j
         MJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCV1oMZ6WeY1/IKnZNIqCWrsJWptE5Nso28MVPMRqCtQe3zC3wYD8Try8J1b0AP1arkgw8Y6/qJQU7uvuI62nQ==@groups.io
X-Gm-Message-State: AOJu0YwnizUGCYQa4uF0MyTD/AH9Infk1mxCgMkS5gefmZ0vn4RYUJGd
	9HRJIJQkbe9CrbwwarrBCQIsbjV+4FYUmDnd4w2B2VgZ/BZelQ3BRsJvJ+UEPy8=
X-Google-Smtp-Source: AGHT+IE7xXUS1THsS5Gj4Fay22Jjcvh2AWc8Xix4lHTywoo2brF9E6AVE0cXGMGZfIvkhce+ericUw==
X-Received: by 2002:adf:f591:0:b0:37d:482e:6197 with SMTP id ffacd0b85a97d-37d86bb873emr5638775f8f.17.1729181448677;
        Thu, 17 Oct 2024 09:10:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:47 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:28 +0200
Subject: [PATCH 4/6] configs: khadas-vim3l_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2506

Actually khadas vim3l use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3l android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 29 +++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

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
index f39a3782d663..4455898b5262 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -26,6 +26,7 @@
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+
 #else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
@@ -39,12 +40,32 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+
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


