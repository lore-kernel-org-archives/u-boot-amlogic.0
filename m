Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE006D44148
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:59 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.18664.1732016271172256554
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:37:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=gR0pOlf5;
 spf=pass (domain: baylibre.com, ip: 209.85.128.42, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so26853495e9.3
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016269; x=1732621069; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
        b=gR0pOlf52uIqSfi38pV/mQnv4SMKJcHEJSpT8efhsEPk95I69vfwuMzg8PZb8VBXMe
         QdP1zRkwjmU6D6CkotZSPEzk2o/42IuuNVvsSUwHlzkbZ7tuttEHvB5VgcXvXhUwIP3l
         j/ag0Se3vSDUalslpiEiZpIChDq3wF+xxda1Q3AldDt8YR20kOosHs9AUbEDJVQhaaDK
         yfEA1tFYDxnfnfAkW4PidGC3Eb2VfwzXZcSW4YrnmX4Ohn5b+mH1bO+15ml8Ej4zqCVW
         iM7p/fJr5fGXALtQ/RTrheF4hoKlYxw8+dGoc/TtpI1nFcAPBGQzhRF5VBYSfFtxiNbb
         qobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016269; x=1732621069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
        b=e/RZ5KVF9JkzJ5GRJhTrK6bBExJSwg7bEKYrLgxvg+EfPojYOZMabSp6zTm1mFdmeg
         75m/M4nFLnZXhmJ05V08Pp/rGfZqS6Bt1oEYOwh3BWwjyP+lYOPSIwGPAf32LuigB63d
         cTco3id2TJ/Lkv6dX1dfKhzZVzR4MfIO1pDsI12ztce1TrSSAcVGqt5AR0zlg5jrS/0x
         aKoRH2Nv+gywfAw+IeiJpMh9bPVaqMtb6Yebt0zLskpw7iW4USjKoeRj14uZLhZIWi12
         NxDIjKgWJETJ+0Frr0HH19YwJZNOk6ceBisqJt0fa+juxkrhIW5g4tpYjXHHtXXgLOKp
         PCpA==
X-Forwarded-Encrypted: i=1; AJvYcCWWi0zzgCqEXiDD9hEo2PTubHu+k2MU8TaYgtUhl70ymVk3fnEYvMyVd1DPA66ivVk727fYZ2iR/vDfBPmIfA==@groups.io
X-Gm-Message-State: AOJu0Yzq/jjHGdAJ990M3L8UDb45JcTDNg34XIcOUSd94XF4DChjyzzC
	Max6ND7Cy3MDTJ38sBbp1GMT9eEV5zgAeCDkYRtnW5OwXK8V9zlAO1pg1RniE9M+tG/jVgLbH9K
	qZqM=
X-Google-Smtp-Source: AGHT+IFJD7Y6QHDgERzPvIonfz/heCYslK7Aeq7hlOGonUZB1mkCcMgK3PeQPX2PHoWo7mJwnobopg==
X-Received: by 2002:a5d:47a4:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-38225a931abmr13711831f8f.34.1732016269588;
        Tue, 19 Nov 2024 03:37:49 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:37:49 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:40 +0100
Subject: [PATCH v3 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-3-45baa486fb31@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2570

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


