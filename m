Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.2181.1587390306995947950
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:45:07 -0700
Received: by mail-wr1-f67.google.com with SMTP id j1so6809199wrt.1
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fm37ByoF/cfqkPB12ZsdgykHRpZdkVpXIsiM2xODgNk=;
        b=xMNoOyKgXVFREDmymtaLyjV+MJx1i7UvsjMOOKWkzLujQT73UwCOlkIw0GuQOZxGGn
         JcFgllwUwjuPp7WZRmeXmVmKbEqItb+Rs971I7nB4LFtFU4DpFWA/khVR3pM6dmam188
         Mb7pNSwjiCjFSsqiTRaqiyKWeRmeOhD74hkliJVJd4zGTAxTWn6ViGIXd76o0KJp5Zm+
         BNUmdDAm3oD+iha7vw5sct6/mH+mwbtWwIqcwuNZswqMwvW8ZuenAOz9yuxbngfxzt9L
         /VtnrG/KE2bH39x2hvSdScsUvDE/lbE0gWE6n52wtIdtfYYCnAHBVvm3az8lBrksDgm9
         wLpw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/5] configs: khadas-vim3: enable support for SPI NOR flash
Date: Mon, 20 Apr 2020 15:44:45 +0200
Message-Id: <20200420134445.19704-6-narmstrong@baylibre.com>
In-Reply-To: <20200420134445.19704-1-narmstrong@baylibre.com>
References: <20200420134445.19704-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable the necessary configs to make usage of the SPI NOR Flash.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim3_defconfig  | 9 +++++++++
 configs/khadas-vim3l_defconfig | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 72987d9523..692138eb11 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -18,6 +18,8 @@ CONFIG_MISC_INIT_R=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
@@ -28,6 +30,10 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
@@ -41,6 +47,9 @@ CONFIG_DEBUG_UART_MESON=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 7e2ad41bca..28c20c0d6d 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -18,6 +18,8 @@ CONFIG_MISC_INIT_R=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
@@ -28,6 +30,10 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
@@ -43,6 +49,9 @@ CONFIG_DEBUG_UART_MESON=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.22.0

