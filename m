Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
 by mx.groups.io with SMTP id smtpd.web09.1327.1576056062236643837
 for <u-boot-amlogic@groups.io>;
 Wed, 11 Dec 2019 01:21:02 -0800
Received: by mail-pg1-f193.google.com with SMTP id k3so9832282pgc.3
        for <u-boot-amlogic@groups.io>; Wed, 11 Dec 2019 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ayRn0t4rsM9ctLF5MOzSmcAQ5vnHbpRM1wTDFHjo0/w=;
        b=ZXe0Qa7bnUziDaJwoTjPPF0oYAbga0x9e8jfZXnKH7agDzd0Xoga9qIa5uxg9VSwH6
         fBfFPBitikgJuEMIdCC7Mia1yyVkXuMouEgoL8KBy8uPyt//9MBUNfiAWsQyn4c+8FX3
         I2YObkeH4EATa+byFB0dNeHI8lDsYBOl9pmCMvzbg5jEUGB2IqpLKxVMncXCXRsjjhDr
         L0UTuuiUY/7EzQeMvqkTu4ZhNu/O9QD23GJM8J1UEElqSmyzOfJ2mvnypAPZ7rt6V3Eq
         Prq7dFg/Ja3fvAx+lRdM4AfOEmE4MbSP20d/OrHZ+uBxp7PMiBEIBLd7QWf9cC//FmxQ
         Ph+w==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
Date: Wed, 11 Dec 2019 13:20:53 +0400
Message-Id: <1576056054-4458-2-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
References: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Import the Khadas VIM3L device-tree from [1]

[1] e42617b825f8 ("Linux 5.5-rc1")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm/dts/Makefile                   |  1 +
 arch/arm/dts/meson-sm1-khadas-vim3l.dts | 95 +++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3dc9c4d..b6c9f82 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -152,6 +152,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-g12a-sei510.dtb \
 	meson-g12b-odroid-n2.dtb \
 	meson-g12b-a311d-khadas-vim3.dtb \
+	meson-sm1-khadas-vim3l.dtb \
 	meson-sm1-sei610.dtb
 dtb-$(CONFIG_TEGRA) += tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l.dts b/arch/arm/dts/meson-sm1-khadas-vim3l.dts
new file mode 100644
index 0000000..1001b37
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-khadas-vim3l.dts
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1.dtsi"
+#include "meson-khadas-vim3.dtsi"
+
+/ {
+	compatible = "khadas,vim3l", "amlogic,sm1";
+	model = "Khadas VIM3L";
+
+	vddcpu: regulator-vddcpu {
+		/*
+		 * Silergy SY8030DEC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
+
+		vin-supply = <&vsys_3v3>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU1_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU2_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU3_CLK>;
+	clock-latency = <50000>;
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
+/*
+ * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+ * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+ * an USB3.0 Type A connector and a M.2 Key M slot. The PHY driving
+ * these differential lines is shared between the USB3.0 controller
+ * and the PCIe Controller, thus only a single controller can use it.
+ * If the MCU is configured to mux the PCIe/USB3.0 differential lines
+ * to the M.2 Key M slot, uncomment the following block to disable
+ * USB3.0 from the USB Complex and enable the PCIe controller.
+ * The End User is not expected to uncomment the following except for
+ * testing purposes, but instead rely on the firmware/bootloader to
+ * update these nodes accordingly if PCIe mode is selected by the MCU.
+ */
+
+/*
+&pcie {
+	status = "okay";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
+ */
-- 
2.7.4

