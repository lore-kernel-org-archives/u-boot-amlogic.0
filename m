Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BED6A230
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:07 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.5705.1731619798121515471
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:29:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=cD82c4f6;
 spf=pass (domain: baylibre.com, ip: 209.85.221.49, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38221500c2bso447389f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619796; x=1732224596; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2GbAZq2WyogNnCPCqG20p+Ar0pP5Zd1VvJjZDymhh4=;
        b=cD82c4f6mdKAjq9Yxy5lH0YeQLW/uRGevYyOjpPrr22roqwmStiGvGXS7SQFQBIQHX
         4snFDJC7TqUu+U9a7dx09BQgCPJBKDIEOQnFSooFt0KSeoK4hURK5I46/wyA0iJzHq0P
         JcjP4a3c/PTjfUUD31tTOphUwCiwud4AHjZZDKDffzOS2+ZsBrqigOnfFIhB5GLbvDA8
         zu1THGbyfBvdUT8bislNVNVTkPj6A5h9q3WgPuvitiWdiuzmfWWJwFwD5uu400Wr1bVN
         aN/IU/dfvRHtVynzNJIh9gE+5SKwGBZ9tRtmd3NSzW8OuLnrbYFMnNFR/no2qJHUQctm
         560A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619796; x=1732224596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2GbAZq2WyogNnCPCqG20p+Ar0pP5Zd1VvJjZDymhh4=;
        b=WtRXxRNJaaOEyVGPTtGHRhhTX+8HuX1wN4OM7SFxxJCVfyRcepvTAq5u4hq8kpnVEs
         CAR8rcCrXcaTNYs4Xggj3k3qUEozQIBC116dVfwYHx9ayj7krRwBKaFYzRNgxnwq4+qr
         VhAfZIQ0TKoEUd8ZHD/A3SufGy9EOt8jMF+iFQXQ3FbwgdF5ipLILd2k3VRPO0o4y9d3
         GkMqw5s4gLyQADzDkA2SVOCYpVXfGaMdbuhiMvcARD6LV9K78jRxmyruqmVB5O4c2wcF
         M/CWulyO3x8SIwDYOLgogQMDMvhIcPoaoUJYyIYSmfX0h3WD8sMuPzm1dZXLckz9U9w0
         vE3w==
X-Forwarded-Encrypted: i=1; AJvYcCXUhh+MGB3Egtj9bOavsbH4S9iQvXdxDqEOzBAyxZp7xI+pGPWdBHummLAC6oFXsKLOU2fqFx9nS1gIIqavPg==@groups.io
X-Gm-Message-State: AOJu0Yxj78tDJZmAaqifiU2l4PZwV2bhPrA0KfFnsgw2Vj0wQ5S65V/Z
	dZhcq4USprRNL+BuHAEL8x5HBarLSIwdBBbwGP3hS2XScUCoPQ9HRpXAAC5xspgKWFjtwgEBehC
	RuHo=
X-Google-Smtp-Source: AGHT+IG9GCgLM1EbPsDM1gLbgpf/aloH98QNQiKb6YJtpv9lgcDziUXK6XWXPEdE30gUxK1KVmPldg==
X-Received: by 2002:a05:6000:1fa1:b0:37e:eee5:80dc with SMTP id ffacd0b85a97d-38224fd0506mr412941f8f.28.1731619796284;
        Thu, 14 Nov 2024 13:29:56 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:55 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:46 +0100
Subject: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2554

Actually khadas vim3l use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3l android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
 include/configs/meson64_android.h         |  3 ---
 4 files changed, 34 insertions(+), 9 deletions(-)

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
index f39a3782d663..31068c59d5ed 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -41,10 +41,28 @@
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


