Received: by mail-wr1-f66.google.com with SMTP id h7so5393978wrt.13
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPD0j54rVuEZFuKvRpHoQCj3j/4oXr+QweIQnOCNHwg=;
        b=eAVl7+vhgbeSLUc5QdC3D3dgT3re2y43LNRF/igorQtX4InnzgmBaHmZqMF1/FWa5Z
         GW7LF4ebia8p1q2ybSRxlgMu5YlLWzrGvqkFw2tNjPuhOb+3HcXl6gj8Sv1C8jdxiLXc
         eRmgJMSxQ38SHHhhomW6epcxeIha4SJcpzYPzcRIEmBBiOAhq5S0qEZD1IM7DAlsnZFk
         vsMNHBoj97P9LTG87spftp5TFWiSohCFOHDAl/yuoVYWzpPgKZSMaRIDwoLoZ97sPEfb
         NqNnn+gNbrQlwOPyjFvzwbqOQC2OGYLlkAyYFr34cvPKYmcVhcb/t+K2kWpEz2L2RTee
         5QeQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 8/8] configs: sei510: enable Video Display support
Date: Fri, 30 Aug 2019 14:09:28 +0200
Message-Id: <20190830120928.23890-9-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add the necessary config options to support BMP display over HDMI,
and add a preboot command to load the BMP file from a predefined
eMMC partition.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/sei510_defconfig | 11 +++++++++++
 include/configs/sei510.h | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 5aea81d873..9eb205bc63 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -11,6 +11,9 @@ CONFIG_IDENT_STRING=" sei510"
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="run load_logo"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_MISC_INIT_R=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_CMD_BDI is not set
@@ -23,6 +26,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_BMP=y
 CONFIG_OF_CONTROL=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-sei510"
 CONFIG_ENV_IS_IN_MMC=y
@@ -33,6 +37,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_GPIO=y
+# CONFIG_INPUT is not set
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_ADDR_ENABLE=y
@@ -42,6 +47,12 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index 9957902250..5bf982cada 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -14,6 +14,7 @@
 #define CONFIG_ENV_SIZE		0x10000
 #define CONFIG_ENV_OFFSET	(-0x10000)
 
+#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
 #define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
 #define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
@@ -23,6 +24,7 @@
 #define PARTS_DEFAULT                                        \
 	"uuid_disk=${uuid_gpt_disk};"  			\
 	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=logo,size=2M,uuid=" LOGO_UUID             \
 	"name=cache,size=256M,uuid=" CACHE_UUID             \
 	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
 	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
@@ -113,12 +115,22 @@
 	func(RECOVERY, recovery, na) \
 	func(SYSTEM, system, na) \
 
+#define PREBOOT_LOAD_LOGO \
+	"mmc dev ${mmcdev};" \
+	"part start mmc ${mmcdev} ${logopart} boot_start;" \
+	"part size mmc ${mmcdev} ${logopart} boot_size;" \
+	"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+			"bmp display ${loadaddr} m m;" \
+	"fi;"
+
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	"bootpart=1\0"                                                \
+	"logopart=2\0"                                                \
 	"gpio_recovery=88\0"                                          \
 	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
+	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
 	"console=/dev/ttyAML0\0"                                      \
 	"bootargs=no_console_suspend\0"                               \
 	"stdin=" STDIN_CFG "\0"                                       \
-- 
2.22.0

