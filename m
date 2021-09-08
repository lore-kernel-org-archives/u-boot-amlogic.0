Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web09.11829.1631110656804972400
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:37 -0700
Received: by mail-wr1-f49.google.com with SMTP id i28so3587237wrb.2
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMJu7ts8y0V6Flwy+Zm6cAgvaWKumV5xHWJVht263Xo=;
        b=eJIloVcvyvq3kM7455ZNdKQiIPmUR9+hRY5kpd/9/aL5gczYggO12s8ISN8WzmJjq6
         JndqZo5hD+rdAIOLDcgjbsyrv+BxxZNZma9kEy9fIu3lgMwOclAHt1TYpld+uUKmlGcT
         vgzqfEGc624UhaWQgQXSNp+jkRq3dccH1wYjyMqNGABodsCaXFM5uAy1KgXWkw+ey/8r
         aeDJcQHG0UPKCI+TH15sXIXjcnTpPQ3lykrio1uluXoYNPP180i+qMVTD45a5N/x6tXd
         bWihBH56n0g/ybywETbs66UNQOi5slzGrFwhAZNKqRpAKXxzwXUdWSn7bloOnq46Z9mz
         M5IQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 3/9] ARM: meson-axg: remove local USB nodes
Date: Wed,  8 Sep 2021 16:17:22 +0200
Message-Id: <20210908141728.585797-3-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Drop the local USB nodes after Linux 5.14 sync.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-axg-s400-u-boot.dtsi |  8 ----
 arch/arm/dts/meson-axg-u-boot.dtsi      | 62 -------------------------
 2 files changed, 70 deletions(-)
 delete mode 100644 arch/arm/dts/meson-axg-u-boot.dtsi

diff --git a/arch/arm/dts/meson-axg-s400-u-boot.dtsi b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
index 2c4b06f140..334650d610 100644
--- a/arch/arm/dts/meson-axg-s400-u-boot.dtsi
+++ b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
@@ -3,8 +3,6 @@
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  */
 
-#include "meson-axg-u-boot.dtsi"
-
 /* wifi module */
 &sd_emmc_b {
 	status = "disabled";
@@ -15,12 +13,6 @@
 	status = "okay";
 };
 
-&usb {
-	status = "okay";
-	dr_mode = "otg";
-	vbus-supply = <&usb_pwr>;
-};
-
 &usb2_phy1 {
 	phy-supply = <&vcc_5v>;
 };
diff --git a/arch/arm/dts/meson-axg-u-boot.dtsi b/arch/arm/dts/meson-axg-u-boot.dtsi
deleted file mode 100644
index cb1c71e78c..0000000000
--- a/arch/arm/dts/meson-axg-u-boot.dtsi
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-/ {
-	soc {
-		usb: usb@ffe09080 {
-			compatible = "amlogic,meson-gxl-usb-ctrl";
-			reg = <0x0 0xffe09080 0x0 0x20>;
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
-			clock-names = "usb_ctrl", "ddr";
-			resets = <&reset RESET_USB_OTG>;
-
-			dr_mode = "otg";
-
-			phys = <&usb2_phy1>;
-			phy-names = "usb2-phy1";
-
-			dwc2: usb@ff400000 {
-				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
-				reg = <0x0 0xff400000 0x0 0x40000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clkc CLKID_USB1>;
-				clock-names = "otg";
-				phys = <&usb2_phy1>;
-				dr_mode = "peripheral";
-				g-rx-fifo-size = <192>;
-				g-np-tx-fifo-size = <128>;
-				g-tx-fifo-size = <128 128 16 16 16>;
-			};
-
-			dwc3: usb@ff500000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xff500000 0x0 0x100000>;
-				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode = "host";
-				maximum-speed = "high-speed";
-				snps,dis_u2_susphy_quirk;
-			};
-		};
-	};
-};
-
-&apb {
-	usb2_phy1: phy@9020 {
-		compatible = "amlogic,meson-gxl-usb2-phy";
-		#phy-cells = <0>;
-		reg = <0x0 0x9020 0x0 0x20>;
-		clocks = <&clkc CLKID_USB>;
-		clock-names = "phy";
-		resets = <&reset RESET_USB_OTG>;
-		reset-names = "phy";
-		status = "okay";
-	};
-};
-- 
2.25.1

