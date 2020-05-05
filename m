Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.5899.1588710197538727565
 for <u-boot-amlogic@groups.io>;
 Tue, 05 May 2020 13:23:17 -0700
Received: by mail-wr1-f68.google.com with SMTP id x17so4301993wrt.5
        for <u-boot-amlogic@groups.io>; Tue, 05 May 2020 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTM2PyrVVlU/i2wae/GSpgc2Vvy32Qn8hCtIeuLnkrw=;
        b=gKVTTFyv78uuM2bpkQL2KTCjH7g8E+yTQ42Pw9trPTo+uxdrBuhlh2kV7lBmB8vw5y
         ysljaxWCsJFtLmIHiuPfXFnVvNk+VwmxrDfIywzteUOi2Uo2MCy2zV/6vK4wtSURLJwJ
         9qwG8zPDTD5XlGiW+ZHERyiHVRY2O6bmNfImdcPS7ctWp+DdEKNfNxTAlAy/UbJOQvr/
         naR4nSUd1cyWF1sT743Ajij/5kaKt44GfEKj8bRUlww3fw1pvFmi+tRbkf+BsfHhqpBu
         N76aLC8+i0XnLXktN3m1dsc/44Iug2Ae7bYsH7wkWjlDhpLqfqN148e8CZOEHIiQ7OG+
         Y8TQ==
Return-Path: <b.galvani@gmail.com>
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 1/2] arm: dts: import ODROID-C4 device tree
Date: Tue,  5 May 2020 22:22:16 +0200
Message-Id: <20200505202217.7849-2-b.galvani@gmail.com>
In-Reply-To: <20200505202217.7849-1-b.galvani@gmail.com>
References: <20200505202217.7849-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, Beniamino Galvani <b.galvani@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Import the device tree for ODROID-C4 as submitted in [1].

[1] https://lkml.org/lkml/2020/4/24/535

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/meson-sm1-odroid-c4.dts | 399 +++++++++++++++++++++++++++
 2 files changed, 400 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 559d3ab6a7..70ea72dfaf 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -161,6 +161,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-g12b-odroid-n2.dtb \
 	meson-g12b-a311d-khadas-vim3.dtb \
 	meson-sm1-khadas-vim3l.dtb \
+	meson-sm1-odroid-c4.dtb \
 	meson-sm1-sei610.dtb
 dtb-$(CONFIG_TEGRA) += tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
diff --git a/arch/arm/dts/meson-sm1-odroid-c4.dts b/arch/arm/dts/meson-sm1-odroid-c4.dts
new file mode 100644
index 0000000000..4882c604a7
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-odroid-c4.dts
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Dongjin Kim <tobetter@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1.dtsi"
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "hardkernel,odroid-c4", "amlogic,sm1";
+	model = "Hardkernel ODROID-C4";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+	};
+
+	tflash_vdd: regulator-tflash_vdd {
+		compatible = "regulator-fixed";
+
+		regulator-name = "TFLASH_VDD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	tf_io: gpio-regulator-tf_io {
+		compatible = "regulator-gpio";
+
+		regulator-name = "TF_IO";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+
+		states = <3300000 0>,
+			 <1800000 1>;
+	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&main_12v>;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vddcpu: regulator-vddcpu {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <721000>;
+		regulator-max-microvolt = <1022000>;
+
+		vin-supply = <&main_12v>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	hub_5v: regulator-hub_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "HUB_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
+		gpio = <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_pwr_en: regulator-usb_pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR_EN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		/* Connected to the microUSB port power enable */
+		gpio = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
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
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <30000>;
+		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+};
+
+&gpio {
+	gpio-line-names =
+		/* GPIOZ */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOH */
+		"", "", "", "", "",
+		"PIN_36", /* GPIOH_5 */
+		"PIN_26", /* GPIOH_6 */
+		"PIN_32", /* GPIOH_7 */
+		"",
+		/* BOOT */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOC */
+		"", "", "", "", "", "", "", "",
+		/* GPIOA */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "",
+		"PIN_27", /* GPIOA_14 */
+		"PIN_28", /* GPIOA_15 */
+		/* GPIOX */
+		"PIN_16", /* GPIOX_0 */
+		"PIN_18", /* GPIOX_1 */
+		"PIN_22", /* GPIOX_2 */
+		"PIN_11", /* GPIOX_3 */
+		"PIN_13", /* GPIOX_4 */
+		"PIN_7",  /* GPIOX_5 */
+		"PIN_33", /* GPIOX_6 */
+		"PIN_15", /* GPIOX_7 */
+		"PIN_19", /* GPIOX_8 */
+		"PIN_21", /* GPIOX_9 */
+		"PIN_24", /* GPIOX_10 */
+		"PIN_23", /* GPIOX_11 */
+		"PIN_8",  /* GPIOX_12 */
+		"PIN_10", /* GPIOX_13 */
+		"PIN_29", /* GPIOX_14 */
+		"PIN_31", /* GPIOX_15 */
+		"PIN_12", /* GPIOX_16 */
+		"PIN_3",  /* GPIOX_17 */
+		"PIN_5",  /* GPIOX_18 */
+		"PIN_35"; /* GPIOX_19 */
+
+	/*
+	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
+	 * to be turned high in order to be detected by the USB Controller
+	 * This signal should be handled by a USB specific power sequence
+	 * in order to reset the Hub when USB bus is powered down.
+	 */
+	usb-hub {
+		gpio-hog;
+		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-hub-reset";
+	};
+};
+
+&gpio_ao {
+	gpio-line-names =
+		/* GPIOAO */
+		"", "", "", "",
+		"PIN_47", /* GPIOAO_4 */
+		"", "",
+		"PIN_45", /* GPIOAO_7 */
+		"PIN_46", /* GPIOAO_8 */
+		"PIN_44", /* GPIOAO_9 */
+		"PIN_42", /* GPIOAO_10 */
+		"",
+		/* GPIOE */
+		"", "", "";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
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
+&saradc {
+	status = "okay";
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <200000000>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&tflash_vdd>;
+	vqmmc-supply = <&tf_io>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy0 {
+	phy-supply = <&vcc_5v>;
+};
+
+&usb2_phy1 {
+	/* Enable the hub which is connected to this port */
+	phy-supply = <&hub_5v>;
+};
-- 
2.25.1

