Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.7008.1637316524026297137
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 02:08:44 -0800
Received: by mail-wr1-f42.google.com with SMTP id t30so17151141wra.10
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpIi6bqJnh3H8MtkL4uNqXaM7LkQ4kahQb2wOtESG+0=;
        b=YWD1MeCMWz9X4vqmzysDb7CTbHj06D4JxJKp/+mfRfT1peUqOIpbi+ZEaUS7GlWYqj
         a+SW+sKbQYfIdK/QieLIg5MAm71Bdjk86I/oD8aPdakQNmCoMUxNAj64/6LbEgySGtR1
         p70UKNFdKGH7e1cAA6Pe3QXdvSNsd67qe6/eDlT97kDapODhiIHgIh09kk8mYFkRD0g1
         Q0m1nE9z4MyMQB5ux4zhc1/+WSxwgLWXj/9PMPIbldE5G5PxXHrGu7qp0+FOyujCrC3b
         X1h8mWc48ft5WoLj5yS4Rqx7t52ePgM8DOnwCc2hKf/pPcjfWhZq3/uAQcu/GcsJh3uq
         2NcA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 5/5] configs: khadas-vim3{l}_android_ab: enable A/B support
Date: Fri, 19 Nov 2021 11:08:29 +0100
Message-Id: <20211119100829.843139-6-mkorpershoek@baylibre.com>
In-Reply-To: <20211119100829.843139-1-mkorpershoek@baylibre.com>
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

meson64_android.h also relies on CMD_AB_SELECT so enable that as well.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  |  2 ++
 configs/khadas-vim3l_android_ab_defconfig |  2 ++
 include/configs/khadas-vim3_android.h     | 16 ++++++++++++++++
 include/configs/khadas-vim3l_android.h    | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 9305a54b1b..88325c37db 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_AVB_VERIFY=y
+CONFIG_ANDROID_AB=y
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
@@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 5eed79b263..608b54dca2 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_AVB_VERIFY=y
+CONFIG_ANDROID_AB=y
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
@@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index a6f6dd0a7a..da6adf6c41 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -12,6 +12,21 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
+#if defined(CONFIG_CMD_AB_SELECT)
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
+	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
+	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
+	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+#else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
@@ -24,6 +39,7 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+#endif
 
 #define EXTRA_ANDROID_ENV_SETTINGS \
 	"board=vim3\0" \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 7affc3e448..b1768e2d82 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -12,6 +12,21 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
+#if defined(CONFIG_CMD_AB_SELECT)
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
+	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
+	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
+	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+#else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
@@ -24,6 +39,7 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+#endif
 
 #define EXTRA_ANDROID_ENV_SETTINGS \
 	"board=vim3l\0" \
-- 
2.32.0

