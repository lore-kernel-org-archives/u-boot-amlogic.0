Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.20861.1641976836821107331
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jan 2022 00:40:37 -0800
Received: by mail-wm1-f54.google.com with SMTP id e5so1028928wmq.1
        for <u-boot-amlogic@groups.io>; Wed, 12 Jan 2022 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIzt+qTMpT3YQvVnFkcuOJIc1tDrcbhIYZEWI7AfCV0=;
        b=pg2g6Li8j2qx4/g1AAV6qkzcY7kc16oUtUfsCzAjSwO3UH0RAezYpJSbl85HJSy3e3
         tEEwls2lX4xCaB3vB1EosOawyWZf0za1sWDBgoAIFYV4v5NYgiaGdD4fIkGztkGUDx8H
         wZNB5hcIvoH7AeeT0PVovUpCH8rkC7WeJ46bbX3qBLE1Mqr8Q3BtlmWOx081Y2O/GpVe
         EFoLEIbwLnhiUrjI3Pg+AA2CTzNaShUuzL+zv/ty3bVFlA9SbVOqPbAQCJKEBGeS+scw
         Ej2RkwvPcr3Y2rruaS2TbbD2a1j0XApMqNNsLRWgwC9sOtYhJlEhLA9GqUJZVPmiU/E2
         p90Q==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH] configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR for android
Date: Wed, 12 Jan 2022 09:40:23 +0100
Message-Id: <20220112084023.2858375-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Khadas vim3 and vim3l defconfigs introduced with:
* f89b90d2d9 ("configs: add khadas-vim3{l}_android for AOSP support")
* 425f06f86e ("configs: prepare khadas-vim3{l}_ab_android for AOSP support")

were based on an outdated defconfig prior to the ede1f4f297 ("configs:
amlogic: Disable CONFIG_NET_RANDOM_ETHADDR when unnecessary") cleanup.

Disable CONFIG_NET_RANDOM_ETHADDR for the android configs as well to
stay consistent.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 1 -
 configs/khadas-vim3_android_defconfig     | 1 -
 configs/khadas-vim3l_android_ab_defconfig | 1 -
 configs/khadas-vim3l_android_defconfig    | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 88325c37db..c5aaaf3ce7 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 9305a54b1b..f0b2c205a7 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -37,7 +37,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 608b54dca2..3401c51721 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 5eed79b263..429db2b344 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -37,7 +37,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
-- 
2.32.0

