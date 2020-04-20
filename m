Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.2178.1587390302789361577
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:45:03 -0700
Received: by mail-wr1-f67.google.com with SMTP id j2so12211739wrs.9
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2dCFZAoj4l+wl/qLoS8mZl7XWYoE2Fwv4BIPZmVxe4=;
        b=i5vAiZnUoW60kxoeKhFf0eYNmSW8Mr+6YnV68E0A/1JXvhx8NPYtHD1DrG1W0+odyf
         gVjcUpffEukzZPd5JOC2fszxt0i7wy16Md3p6SLNTjsfy7zTCRgD47Z4/72nVXOwDBpK
         vHmxae7IvJ3JVCaRvoaWXVzwbr+cf6bi4Mi6KGSqlxiydU0lK5u+k4kgVdIw9goC+hJ7
         kL3Ht+N6bjC/iHeXqsX299XOV+UtPdPWk8cB2GNTap0Qnl/r4wnLWKQMZioh8Pg+cBdI
         cmQ0YEOAv1JKN1gzcU0/TfOPiGEABB88hcbP7Xj6Ef2FDLWhMy9JZThsQ/icdroC078A
         QKdA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/5] configs: khadas-vim2: enable support for SPI NOR flash
Date: Mon, 20 Apr 2020 15:44:43 +0200
Message-Id: <20200420134445.19704-4-narmstrong@baylibre.com>
In-Reply-To: <20200420134445.19704-1-narmstrong@baylibre.com>
References: <20200420134445.19704-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the necessary configs to use the SPI NOR flash.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim2_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index a533566410..5633f6da9c 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -19,6 +19,8 @@ CONFIG_CMD_ADC=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
@@ -30,7 +32,10 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
@@ -44,6 +49,9 @@ CONFIG_DEBUG_UART_MESON=y
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

