Received: by mail-wr1-f67.google.com with SMTP id w13so5823206wru.11
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JnaopTsFT92U1r6FCKfeLVyHlfcplHEc4ddCBR5MEg=;
        b=EjcV2+PGVqKH7om9tRB+l36xNJZPTOE/t6E2FVdQkOxuDuI8BozLs9uR6k3UtXB+kZ
         nAJZaWo/wqEIead0tY2/0Fh55fgH52Tq35cNwd/agtcdMyXEFjrvqtExbAYT6uTNm7Lv
         xr4FGWW/se7nhR63uSMvWXtxfMYAaR8cxkY/0e8CrsRl3vId4u2l914MPNxk1FAh7YXk
         aqJZVYcs25SEmjRsKMtaEcRo70DW6/sv+Hj/9Q0I39SiY1e016NZrY0BVoofS3AyKIrc
         kBQta5g6U/j6HZHoQy/ANLu0v9vdhjICiD+zxC49l0IVgKPn1nKGYFbQmAs4BNuMpGbs
         XeMQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] configs: u200: enable support for USB Host & Gadget
Date: Fri, 31 May 2019 10:10:57 +0200
Message-Id: <20190531081057.8761-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Now the Amlogic G12A DT and drivers are present, enable full USB
on the U200 Reference Design board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/u200_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 13b6f41847..2c0999c707 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -37,3 +37,20 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_USB=y
+CONFIG_USB_HOST=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHY=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_DM_USB=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-- 
2.21.0

