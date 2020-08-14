Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
 by mx.groups.io with SMTP id smtpd.web10.13042.1597386323238701945
 for <u-boot-amlogic@groups.io>;
 Thu, 13 Aug 2020 23:25:23 -0700
Received: by mail-pj1-f67.google.com with SMTP id c6so3935870pje.1
        for <u-boot-amlogic@groups.io>; Thu, 13 Aug 2020 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Fl7cjKa/727tFm8nHFFaKXN1n1VCtnkkf3zL9N+ekU=;
        b=QBYpUhYplz1Vqi8P/xAqmoyroN7ZNn6xFED2k9XT4cgqtrzNI/FQXPQ945VUKJX1+u
         lnI/QDTZTETgwCMPKuwK8kRCme9v4LaUvbtXTeBaG9THYJpRS5cU8R/sjhvauSBAk+hz
         +oWBqlIXAIm+tHDQyvQ28FbbdnW+6tu2mpkidn8tgYOrme08CBTtwJShkucMpWObsrGY
         L+5vLFj96THWRSjP3OxNUFM7+KZM5nEmatpaODn4NKl7BLuxDo2CfmXHlkYaNZ1wv9Gx
         baqk/or+Vpb33rLwtAXN852t060YsVeXYqvtEWAssFOQ2dEK/knIHwesANn/Rf6VnUDm
         7ftw==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 1/2] configs: odroid-n2: update for HDMI output & USB keyboard
Date: Fri, 14 Aug 2020 06:25:14 +0000
Message-Id: <20200814062515.1803-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>, Anand Moon <linux.amoon@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Enable options to permit HDMI output on Odroid-N2 G12B boards.
Enable VPU Power Domain.
Enable USB_KEYBOARD.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-n2_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 358d1fc630..e8b8da9084 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -34,6 +34,8 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
@@ -47,10 +49,17 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.28.0

