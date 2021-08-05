Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web09.10172.1628176661915807437
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:42 -0700
Received: by mail-wm1-f42.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso6614304wmg.4
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irJ8LFOROTEsyHI5TdS5tpyiUn+QWoR8r1YZdEyDfE8=;
        b=u3U0URp5rRaeKvU+vgRwe5SX50tPJtJRUdCGkZOAlWl2McawVUL+8D2e4MqmidIn4Q
         as44whlHKn7h7IVBF9S+NyJ07iYl66LDw23ovexIk2n7IjnQMLOHKdJcsiHlvgHHDqoq
         rAsHCHgeadjeTH8MuzvF8uW9r0nxN1wCdNWG7dr6emVGAyNW97kX5bZik30aPEBy6Poq
         F9xA2pFTqvHtZRJ0zxofws4HW1oetnVFeguduJuqEQvltaOwjrcYGIDD4sPlyjYrFk9p
         tiMpNt5L7hcmQ60bDlEG9MxWvA91aLLrF2vIw1QPt2CNnCR75r++Q/900cWmGzDPDvXT
         Z5HA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 9/9] configs: sei510/610: android bootflow via abootimg
Date: Thu,  5 Aug 2021 17:17:28 +0200
Message-Id: <20210805151728.422329-10-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Guillaume La Roque <glaroque@baylibre.com>

Activate the following Kconfig options:
* AVB       for Android Verified Boot support
* ADTIMG    for merging DTBOs
* ABOOTIMG  for extracting Android boot image

Also rework the partitioning tables:
- add a misc partition to handle BCB messages
- add a dtbo partition to store various DTBOs
- add a vbmeta partition for AVB hashes
- Merge vendor and system into the "super" partition

Note: avb support is disables by default. To activate it:
 => setenv force_avb 1;
 => saveenv;

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/sei510_defconfig |  5 +++++
 configs/sei610_defconfig |  5 +++++
 include/configs/sei510.h | 11 +++++++----
 include/configs/sei610.h | 13 ++++++++-----
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 74328f2fd4..8099b40b55 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -20,7 +20,10 @@ CONFIG_PREBOOT="run load_logo"
 # CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
+CONFIG_AVB_VERIFY=y
 # CONFIG_CMD_BDI is not set
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
@@ -32,6 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_BMP=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
@@ -84,4 +88,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_LIBAVB=y
 CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 2a6d0e5995..e11f36ac79 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -20,7 +20,10 @@ CONFIG_PREBOOT="run load_logo"
 # CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
+CONFIG_AVB_VERIFY=y
 # CONFIG_CMD_BDI is not set
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
@@ -32,6 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_BMP=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
@@ -84,4 +88,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_LIBAVB=y
 CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index 5bf2668803..ea91a06157 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -14,12 +14,15 @@
 
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
 	"name=logo,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=128K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
+	"name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};" \
+	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
-	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
-	"name=userdata,size=5341M,uuid={uuid_gpt_userdata};" \
+	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=4820M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
index baace75a02..783eece271 100644
--- a/include/configs/sei610.h
+++ b/include/configs/sei610.h
@@ -14,12 +14,15 @@
 
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=logo,size=2M,uuid=" LOGO_UUID \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
+	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
+	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
-	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
-	"name=userdata,size=12795M,uuid=${uuid_gpt_userdata};" \
+	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=12274M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 #include <configs/meson64_android.h>
-- 
2.30.2

