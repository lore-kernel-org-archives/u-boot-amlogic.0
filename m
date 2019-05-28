Received: by mail-wr1-f67.google.com with SMTP id t4so10975869wrx.7
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYFJxRyJsT7KEJWeIqnxPVVfyX0j5FC85WakreqXNoU=;
        b=WCbUOj6NuxQZL0A2ttX0Krt9VYsoY37uqf8in5TmDd+BLSjsP62R7+Tu27meJZcM2q
         olaq0+gAIZh+Y1LzUrsJkrZ+UHExNkd7rQEIDP7QIMR88tPEbNAY3cjQg1YiNEt/8a43
         7kV2CHEkSPXgydcr7VrEdi1B67Ugn2ggz1q3G6gHw3rrPA2Na59xcaeCvuDDDPDVzlr1
         G+/sKvKbnrisvA0GT9ftqUA/r0ZzGjL5waMjawAsVOiIzLgriwhzXYDrquqGus+HfHCv
         ANhiei2Ye+DCCTXQgOodzpCPuXkTMX/3SUMXHoH9rcLd8E+OB5bruW/YsaRuZdLOFwan
         sfMA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/3] ARM: dts: sync Amlogic G12A DT with Linux 5.2-rc1
Date: Tue, 28 May 2019 10:50:36 +0200
Message-Id: <20190528085038.8088-2-narmstrong@baylibre.com>
In-Reply-To: <20190528085038.8088-1-narmstrong@baylibre.com>
References: <20190528085038.8088-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Sync from Linux commit a188339ca5a3 ("Linux 5.2-rc1")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12a-u200.dts              | 147 ++++++
 arch/arm/dts/meson-g12a.dtsi                  | 465 ++++++++++++++++++
 include/dt-bindings/clock/g12a-aoclkc.h       |   2 +
 include/dt-bindings/clock/g12a-clkc.h         |   5 +
 .../reset/amlogic,meson-g12a-reset.h          |   5 +-
 5 files changed, 623 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a-u200.dts
index c44dbdddf2..0e8045b8a9 100644
--- a/arch/arm/dts/meson-g12a-u200.dts
+++ b/arch/arm/dts/meson-g12a-u200.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
 	compatible = "amlogic,u200", "amlogic,g12a";
@@ -21,9 +23,154 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
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
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
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
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
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
+		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
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
+};
+
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
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
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
 };
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
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
+	phy-supply = <&vcc_5v>;
+};
diff --git a/arch/arm/dts/meson-g12a.dtsi b/arch/arm/dts/meson-g12a.dtsi
index 17c6217f8a..9f72396ba7 100644
--- a/arch/arm/dts/meson-g12a.dtsi
+++ b/arch/arm/dts/meson-g12a.dtsi
@@ -3,9 +3,13 @@
  * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
  */
 
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/g12a-clkc.h>
+#include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
 	compatible = "amlogic,g12a";
@@ -55,6 +59,14 @@
 		};
 	};
 
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		clocks = <&clkc CLKID_EFUSE>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		read-only;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -70,6 +82,18 @@
 			reg = <0x0 0x05000000 0x0 0x300000>;
 			no-map;
 		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x10000000>;
+			alignment = <0x0 0x400000>;
+			linux,cma-default;
+		};
+	};
+
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
 	};
 
 	soc {
@@ -85,12 +109,177 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
 
+			hdmi_tx: hdmi-tx@0 {
+				compatible = "amlogic,meson-g12a-dw-hdmi";
+				reg = <0x0 0x0 0x0 0x10000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
+				resets = <&reset RESET_HDMITX_CAPB3>,
+					 <&reset RESET_HDMITX_PHY>,
+					 <&reset RESET_HDMITX>;
+				reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
+				clocks = <&clkc CLKID_HDMI>,
+					 <&clkc CLKID_HTX_PCLK>,
+					 <&clkc CLKID_VPU_INTR>;
+				clock-names = "isfr", "iahb", "venci";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				/* VPU VENC Input */
+				hdmi_tx_venc_port: port@0 {
+					reg = <0>;
+
+					hdmi_tx_in: endpoint {
+						remote-endpoint = <&hdmi_tx_out>;
+					};
+				};
+
+				/* TMDS Output */
+				hdmi_tx_tmds_port: port@1 {
+					reg = <1>;
+				};
+			};
+
 			periphs: bus@34400 {
 				compatible = "simple-bus";
 				reg = <0x0 0x34400 0x0 0x400>;
 				#address-cells = <2>;
 				#size-cells = <2>;
 				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
+
+				periphs_pinctrl: pinctrl@40 {
+					compatible = "amlogic,meson-g12a-periphs-pinctrl";
+					#address-cells = <2>;
+					#size-cells = <2>;
+					ranges;
+
+					gpio: bank@40 {
+						reg = <0x0 0x40  0x0 0x4c>,
+						      <0x0 0xe8  0x0 0x18>,
+						      <0x0 0x120 0x0 0x18>,
+						      <0x0 0x2c0 0x0 0x40>,
+						      <0x0 0x340 0x0 0x1c>;
+						reg-names = "gpio",
+							    "pull",
+							    "pull-enable",
+							    "mux",
+							    "ds";
+						gpio-controller;
+						#gpio-cells = <2>;
+						gpio-ranges = <&periphs_pinctrl 0 0 86>;
+					};
+
+					cec_ao_a_h_pins: cec_ao_a_h {
+						mux {
+							groups = "cec_ao_a_h";
+							function = "cec_ao_a_h";
+							bias-disable;
+						};
+					};
+
+					cec_ao_b_h_pins: cec_ao_b_h {
+						mux {
+							groups = "cec_ao_b_h";
+							function = "cec_ao_b_h";
+							bias-disable;
+						};
+					};
+
+					hdmitx_ddc_pins: hdmitx_ddc {
+						mux {
+							groups = "hdmitx_sda",
+								 "hdmitx_sck";
+							function = "hdmitx";
+							bias-disable;
+						};
+					};
+
+					hdmitx_hpd_pins: hdmitx_hpd {
+						mux {
+							groups = "hdmitx_hpd_in";
+							function = "hdmitx";
+							bias-disable;
+						};
+					};
+
+					uart_a_pins: uart-a {
+						mux {
+							groups = "uart_a_tx",
+								 "uart_a_rx";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_a_cts_rts_pins: uart-a-cts-rts {
+						mux {
+							groups = "uart_a_cts",
+								 "uart_a_rts";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_b_pins: uart-b {
+						mux {
+							groups = "uart_b_tx",
+								 "uart_b_rx";
+							function = "uart_b";
+							bias-disable;
+						};
+					};
+
+					uart_c_pins: uart-c {
+						mux {
+							groups = "uart_c_tx",
+								 "uart_c_rx";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
+
+					uart_c_cts_rts_pins: uart-c-cts-rts {
+						mux {
+							groups = "uart_c_cts",
+								 "uart_c_rts";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
+				};
+			};
+
+			usb2_phy0: phy@36000 {
+				compatible = "amlogic,g12a-usb2-phy";
+				reg = <0x0 0x36000 0x0 0x2000>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				resets = <&reset RESET_USB_PHY20>;
+				reset-names = "phy";
+				#phy-cells = <0>;
+			};
+
+			dmc: bus@38000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x38000 0x0 0x400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x38000 0x0 0x400>;
+
+				canvas: video-lut@48 {
+					compatible = "amlogic,canvas";
+					reg = <0x0 0x48 0x0 0x14>;
+				};
+			};
+
+			usb2_phy1: phy@3a000 {
+				compatible = "amlogic,g12a-usb2-phy";
+				reg = <0x0 0x3a000 0x0 0x2000>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				resets = <&reset RESET_USB_PHY21>;
+				reset-names = "phy";
+				#phy-cells = <0>;
 			};
 
 			hiu: bus@3c000 {
@@ -113,6 +302,18 @@
 					};
 				};
 			};
+
+			usb3_pcie_phy: phy@46000 {
+				compatible = "amlogic,g12a-usb3-pcie-phy";
+				reg = <0x0 0x46000 0x0 0x2000>;
+				clocks = <&clkc CLKID_PCIE_PLL>;
+				clock-names = "ref_clk";
+				resets = <&reset RESET_PCIE_PHY>;
+				reset-names = "phy";
+				assigned-clocks = <&clkc CLKID_PCIE_PLL>;
+				assigned-clock-rates = <100000000>;
+				#phy-cells = <1>;
+			};
 		};
 
 		aobus: bus@ff800000 {
@@ -122,6 +323,128 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			rti: sys-ctrl@0 {
+				compatible = "amlogic,meson-gx-ao-sysctrl",
+					     "simple-mfd", "syscon";
+				reg = <0x0 0x0 0x0 0x100>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
+
+				clkc_AO: clock-controller {
+					compatible = "amlogic,meson-g12a-aoclkc";
+					#clock-cells = <1>;
+					#reset-cells = <1>;
+					clocks = <&xtal>, <&clkc CLKID_CLK81>;
+					clock-names = "xtal", "mpeg-clk";
+				};
+
+				pwrc_vpu: power-controller-vpu {
+					compatible = "amlogic,meson-g12a-pwrc-vpu";
+					#power-domain-cells = <0>;
+					amlogic,hhi-sysctrl = <&hhi>;
+					resets = <&reset RESET_VIU>,
+						 <&reset RESET_VENC>,
+						 <&reset RESET_VCBUS>,
+						 <&reset RESET_BT656>,
+						 <&reset RESET_RDMA>,
+						 <&reset RESET_VENCI>,
+						 <&reset RESET_VENCP>,
+						 <&reset RESET_VDAC>,
+						 <&reset RESET_VDI6>,
+						 <&reset RESET_VENCL>,
+						 <&reset RESET_VID_LOCK>;
+					clocks = <&clkc CLKID_VPU>,
+						 <&clkc CLKID_VAPB>;
+					clock-names = "vpu", "vapb";
+					/*
+					 * VPU clocking is provided by two identical clock paths
+					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+					 * free mux to safely change frequency while running.
+					 * Same for VAPB but with a final gate after the glitch free mux.
+					 */
+					assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
+							  <&clkc CLKID_VPU_0>,
+							  <&clkc CLKID_VPU>, /* Glitch free mux */
+							  <&clkc CLKID_VAPB_0_SEL>,
+							  <&clkc CLKID_VAPB_0>,
+							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+					assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VPU_0>,
+								 <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VAPB_0>;
+					assigned-clock-rates = <0>, /* Do Nothing */
+							       <666666666>,
+							       <0>, /* Do Nothing */
+							       <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>; /* Do Nothing */
+				};
+
+				ao_pinctrl: pinctrl@14 {
+					compatible = "amlogic,meson-g12a-aobus-pinctrl";
+					#address-cells = <2>;
+					#size-cells = <2>;
+					ranges;
+
+					gpio_ao: bank@14 {
+						reg = <0x0 0x14 0x0 0x8>,
+						      <0x0 0x1c 0x0 0x8>,
+						      <0x0 0x24 0x0 0x14>;
+						reg-names = "mux",
+							    "ds",
+							    "gpio";
+						gpio-controller;
+						#gpio-cells = <2>;
+						gpio-ranges = <&ao_pinctrl 0 0 15>;
+					};
+
+					uart_ao_a_pins: uart-a-ao {
+						mux {
+							groups = "uart_ao_a_tx",
+								 "uart_ao_a_rx";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_cts_rts_pins: uart-ao-a-cts-rts {
+						mux {
+							groups = "uart_ao_a_cts",
+								 "uart_ao_a_rts";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
+				};
+			};
+
+			cec_AO: cec@100 {
+				compatible = "amlogic,meson-gx-ao-cec";
+				reg = <0x0 0x00100 0x0 0x14>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_AO CLKID_AO_CEC>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
+			sec_AO: ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
+			cecb_AO: cec@280 {
+				compatible = "amlogic,meson-g12a-ao-cec";
+				reg = <0x0 0x00280 0x0 0x1c>;
+				interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_AO CLKID_AO_CTS_OSCIN>;
+				clock-names = "oscin";
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
@@ -141,6 +464,46 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x48>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
+		};
+
+		vpu: vpu@ff900000 {
+			compatible = "amlogic,meson-g12a-vpu";
+			reg = <0x0 0xff900000 0x0 0x100000>,
+			      <0x0 0xff63c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			amlogic,canvas = <&canvas>;
+			power-domains = <&pwrc_vpu>;
+
+			/* CVBS VDAC output port */
+			cvbs_vdac_port: port@0 {
+				reg = <0>;
+			};
+
+			/* HDMI-TX output port */
+			hdmi_tx_port: port@1 {
+				reg = <1>;
+
+				hdmi_tx_out: endpoint {
+					remote-endpoint = <&hdmi_tx_in>;
+				};
+			};
 		};
 
 		gic: interrupt-controller@ffc01000 {
@@ -163,10 +526,112 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 
+			reset: reset-controller@1004 {
+				compatible = "amlogic,meson-g12a-reset",
+					     "amlogic,meson-axg-reset";
+				reg = <0x0 0x1004 0x0 0x9c>;
+				#reset-cells = <1>;
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
 			};
+
+			uart_C: serial@22000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x22000 0x0 0x18>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_B: serial@23000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x23000 0x0 0x18>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_A: serial@24000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x24000 0x0 0x18>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+
+		usb: usb@ffe09000 {
+			status = "disabled";
+			compatible = "amlogic,meson-g12a-usb-ctrl";
+			reg = <0x0 0xffe09000 0x0 0xa0>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>;
+			resets = <&reset RESET_USB>;
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy0>, <&usb2_phy1>,
+			       <&usb3_pcie_phy PHY_TYPE_USB3>;
+			phy-names = "usb2-phy0", "usb2-phy1", "usb3-phy0";
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
+				clock-names = "ddr";
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
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment;
+			};
+		};
+
+		mali: gpu@ffe40000 {
+			compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+			reg = <0x0 0xffe40000 0x0 0x40000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpu", "mmu", "job";
+			clocks = <&clkc CLKID_MALI>;
+			resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+
+			/*
+			 * Mali clocking is provided by two identical clock paths
+			 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+			 * free mux to safely change frequency while running.
+			 */
+			assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+					  <&clkc CLKID_MALI_0>,
+					  <&clkc CLKID_MALI>; /* Glitch free mux */
+			assigned-clock-parents = <&clkc CLKID_FCLK_DIV2P5>,
+						 <0>, /* Do Nothing */
+						 <&clkc CLKID_MALI_0>;
+			assigned-clock-rates = <0>, /* Do Nothing */
+					       <800000000>,
+					       <0>; /* Do Nothing */
 		};
 	};
 
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
index 8db01ffbeb..e916e49ff2 100644
--- a/include/dt-bindings/clock/g12a-aoclkc.h
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -26,7 +26,9 @@
 #define CLKID_AO_M4_FCLK	13
 #define CLKID_AO_M4_HCLK	14
 #define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_SEL	16
 #define CLKID_AO_SAR_ADC_CLK	18
+#define CLKID_AO_CTS_OSCIN	19
 #define CLKID_AO_32K		23
 #define CLKID_AO_CEC		27
 #define CLKID_AO_CTS_RTC_OSCIN	28
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 83b657038d..82c9e0c020 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -131,5 +131,10 @@
 #define CLKID_MALI_1				174
 #define CLKID_MALI				175
 #define CLKID_MPLL_5OM				177
+#define CLKID_CPU_CLK				187
+#define CLKID_PCIE_PLL				201
+#define CLKID_VDEC_1				204
+#define CLKID_VDEC_HEVC				207
+#define CLKID_VDEC_HEVCF			210
 
 #endif /* __G12A_CLKC_H */
diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
index 8063e8314e..6d487c5eba 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -51,7 +51,10 @@
 #define RESET_SD_EMMC_A			44
 #define RESET_SD_EMMC_B			45
 #define RESET_SD_EMMC_C			46
-/*					47-60 */
+/*					47	*/
+#define RESET_USB_PHY20			48
+#define RESET_USB_PHY21			49
+/*					50-60	*/
 #define RESET_AUDIO_CODEC		61
 /*					62-63	*/
 /*	RESET2					*/
-- 
2.21.0

