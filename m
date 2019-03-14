Received: by mail-ed1-f67.google.com with SMTP id d12so5892197edp.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klIoi1kbnZ4O+KkZOyw5lSlIiHyHcnVOkCdTe5i1CW0=;
        b=V6E+Qemhg9eKnaX2897gGgINjY0iED9mJe72mx5NPD/f85tE8plHTf/cXxTo6l6oaU
         B/uEsSwjMEz0wYLpJy9AuBCpwpBUekzeSy3Xnws/LeZ7SEdD036M4bR2iGUadefBXR7v
         d0ElxsGYYXeYjl9c1Nzaq0P6fc1keaBMLa+wm4uUyYoDHON5AFyzn+pnp0UzbZA6qcvs
         Gr7trNVT25JFnaxU0NE+4k9PKMLVMSykMFrUFf+X+w0RLHd5XwIbfbe3jWCfWM9Llwxx
         eSNxJ2/ilWIGNEH3j904FiylupxqTd7mkPal33nYxhahsyGjBCr+ifww16EHZrH7gqRa
         XSMQ==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v3 1/3] ARM: dts: meson: add p200 and p201 boards
Date: Fri, 15 Mar 2019 00:09:18 +0300
Message-Id: <20190314210920.11006-2-mohammad.rasim96@gmail.com>
In-Reply-To: <20190314210920.11006-1-mohammad.rasim96@gmail.com>
References: <20190314210920.11006-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>, narmstrong@baylibre.com
List-ID: <u-boot-amlogic@groups.io>


This adds the device trees for p200 and p201 boards.
Synced from kernel 5.0.0
Commit a667cb7a94d4 ("Merge branch 'akpm' (patches from Andrew)")

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/Makefile             |   2 +
 arch/arm/dts/meson-gxbb-p200.dts  |  99 ++++++++++++
 arch/arm/dts/meson-gxbb-p201.dts  |  26 ++++
 arch/arm/dts/meson-gxbb-p20x.dtsi | 247 ++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2a040b20a5..adf5f26fac 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -60,6 +60,8 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxbb-nanopi-k2.dtb \
 	meson-gxbb-odroidc2.dtb \
 	meson-gxbb-nanopi-k2.dtb \
+	meson-gxbb-p200.dtb \
+	meson-gxbb-p201.dtb \
 	meson-gxl-s905x-p212.dtb \
 	meson-gxl-s905x-libretech-cc.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
diff --git a/arch/arm/dts/meson-gxbb-p200.dts b/arch/arm/dts/meson-gxbb-p200.dts
new file mode 100644
index 0000000000..9d2406a7c4
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-p200.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016 Andreas Färber
+ * Copyright (c) 2016 BayLibre, Inc.
+ * Author: Kevin Hilman <khilman@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "meson-gxbb-p20x.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	compatible = "amlogic,p200", "amlogic,meson-gxbb";
+	model = "Amlogic Meson GXBB P200 Development Board";
+
+	avdd18_usb_adc: regulator-avdd18_usb_adc {
+		compatible = "regulator-fixed";
+		regulator-name = "AVDD18_USB_ADC";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-home {
+			label = "Home";
+			linux,code = <KEY_HOME>;
+			press-threshold-microvolt = <900000>; /* 50% */
+		};
+
+		button-esc {
+			label = "Esc";
+			linux,code = <KEY_ESC>;
+			press-threshold-microvolt = <684000>; /* 38% */
+		};
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <468000>; /* 26% */
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <252000>; /* 14% */
+		};
+
+		button-menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			press-threshold-microvolt = <0>; /* 0% */
+		};
+	};
+};
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	amlogic,tx-delay-ns = <2>;
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy@3 {
+			/* Micrel KSZ9031 (0x00221620) */
+			reg = <3>;
+			interrupt-parent = <&gpio_intc>;
+			/* MAC_INTR on GPIOZ_15 */
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&i2c_B {
+	status = "okay";
+	pinctrl-0 = <&i2c_b_pins>;
+	pinctrl-names = "default";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&avdd18_usb_adc>;
+};
diff --git a/arch/arm/dts/meson-gxbb-p201.dts b/arch/arm/dts/meson-gxbb-p201.dts
new file mode 100644
index 0000000000..56e0dd1ff5
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-p201.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016 Andreas Färber
+ * Copyright (c) 2016 BayLibre, Inc.
+ * Author: Kevin Hilman <khilman@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "meson-gxbb-p20x.dtsi"
+
+/ {
+	compatible = "amlogic,p201", "amlogic,meson-gxbb";
+	model = "Amlogic Meson GXBB P201 Development Board";
+};
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxbb-p20x.dtsi
new file mode 100644
index 0000000000..0be0f2a5d2
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016 Andreas Färber
+ * Copyright (c) 2016 BayLibre, Inc.
+ * Author: Kevin Hilman <khilman@kernel.org>
+ */
+
+#include "meson-gxbb.dtsi"
+
+/ {
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
+	usb_pwr: regulator-usb-pwrs {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		/* signal name in schematic: USB_PWR_EN */
+		gpio = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vddio_card: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "VDDIO_CARD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+
+		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
+		states = <1800000 0
+			  3300000 1>;
+
+		regulator-settling-time-up-us = <10000>;
+		regulator-settling-time-down-us = <150000>;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	cvbs_connector: cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
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
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
+/* Wireless SDIO Module */
+&sd_emmc_a {
+	status = "okay";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_card>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+/* This UART is brought out to the DB9 connector */
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_pwr>;
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
--
2.21.0

