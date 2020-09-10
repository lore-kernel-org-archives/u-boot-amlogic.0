Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.17582.1599727718276362781
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:38 -0700
Received: by mail-wm1-f66.google.com with SMTP id x23so4788947wmi.3
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKLw4Y76xIwdfYqWjScyqCw4jE0ok2y3/hANSrKAz9I=;
        b=rGh211i6XK1mc/h43nRNHhB9aqwaeEJc7HoTCoMBycMRTaqyocJEHmALFsS18YsHHC
         56qSZmNjgT2nf1j0OXQTnLOIV4WbYiGyjR0EQGJYICRCkQdv7EGAkq1fhtBo+tgh2Qj4
         v3ccgXHah8X3sSn0J3xueI5F+WhoDhOr44BAhVGG0NSJsL9jB2ZY/oPTFGGx2WUEvPD6
         LjpYTl+Fvy9YMNGseVIVqMmk0SUK23OGI9iJ3X+gmbbIFcPf3Uk0xJTWotOS+IWvSOWw
         AJjZPPZXHh4LcK8CUULSbUp0nsV3XJ9UFhGeC5Gv+kSG9Qq/akbEs9rdjovM9x61ZmOM
         vwtw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 7/8] ARM: dts: meson-axg: add USB nodes for S400
Date: Thu, 10 Sep 2020 10:48:18 +0200
Message-Id: <20200910084819.25312-8-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the correcly architectured USB Glue node for Meson AXG and the
S400 board in -u-boot.dtsi until support in upstream Linux then
backported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-axg-s400-u-boot.dtsi | 12 +++++
 arch/arm/dts/meson-axg-u-boot.dtsi      | 62 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 arch/arm/dts/meson-axg-u-boot.dtsi

diff --git a/arch/arm/dts/meson-axg-s400-u-boot.dtsi b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
index c46eb3f38d..2c4b06f140 100644
--- a/arch/arm/dts/meson-axg-s400-u-boot.dtsi
+++ b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  */
 
+#include "meson-axg-u-boot.dtsi"
+
 /* wifi module */
 &sd_emmc_b {
 	status = "disabled";
@@ -12,3 +14,13 @@
 &sd_emmc_c {
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+	vbus-supply = <&usb_pwr>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
diff --git a/arch/arm/dts/meson-axg-u-boot.dtsi b/arch/arm/dts/meson-axg-u-boot.dtsi
new file mode 100644
index 0000000000..cb1c71e78c
--- /dev/null
+++ b/arch/arm/dts/meson-axg-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/ {
+	soc {
+		usb: usb@ffe09080 {
+			compatible = "amlogic,meson-gxl-usb-ctrl";
+			reg = <0x0 0xffe09080 0x0 0x20>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "usb_ctrl", "ddr";
+			resets = <&reset RESET_USB_OTG>;
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy1>;
+			phy-names = "usb2-phy1";
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1>;
+				clock-names = "otg";
+				phys = <&usb2_phy1>;
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff500000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff500000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+			};
+		};
+	};
+};
+
+&apb {
+	usb2_phy1: phy@9020 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x9020 0x0 0x20>;
+		clocks = <&clkc CLKID_USB>;
+		clock-names = "phy";
+		resets = <&reset RESET_USB_OTG>;
+		reset-names = "phy";
+		status = "okay";
+	};
+};
-- 
2.22.0

