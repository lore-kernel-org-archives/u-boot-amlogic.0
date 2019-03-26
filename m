Received: by mail-wr1-f67.google.com with SMTP id r4so5929031wrq.8
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBYXXmWYHX1NJM/zkI1cic87AdZmlP/egyoOXBMc7+s=;
        b=Xn4+uIqAhGEF3541RnevIDIZKi7diFE0aFMDMadjXl7b5P8UHtEthjkfX2kzk/ykMS
         cSIb/+44vgPdM89Ah8SfWVYfyry5W3tVCwlNeFuFHfPJR3NLcT4BlNn3tIWKWjyCyDAr
         wmyU42Id36uvdTlpBdIFlxF9/ZCZLChvq8m/jB9GUUJedPUCCl51sEFNQi+epsL6gIJs
         +Tj7A17Y08pBmZrLE1p/fq++deFYmXtC2dY9rWk2nNV/YcL8N/juAnK6qIUlM/vazDyD
         yTomdVcGS6sCSIgiXXSzdYsuyIHfrH4oQChilLesWLP5Dm4hdilznqiID9yBTR+m7G21
         CC8Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] ARM: dts: Import libretech-ac DT from Linux 5.0
Date: Tue, 26 Mar 2019 11:20:34 +0100
Message-Id: <20190326102035.9239-2-narmstrong@baylibre.com>
In-Reply-To: <20190326102035.9239-1-narmstrong@baylibre.com>
References: <20190326102035.9239-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Import Linux 5.0 DT from 1c163f4c7b3f ("Linux 5.0") for the
meson-gxl-s805x-libretech-ac board and the corresponding changes
in meson-gxl.dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 248 ++++++++++++++++++
 arch/arm/dts/meson-gxl.dtsi                   |  70 ++++-
 3 files changed, 310 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 103ff75f01..ab2fc795c0 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxbb-p200.dtb \
 	meson-gxbb-p201.dtb \
 	meson-gxl-s905x-p212.dtb \
+	meson-gxl-s805x-libretech-ac.dtb \
 	meson-gxl-s905x-libretech-cc.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
 	meson-gxm-khadas-vim2.dtb \
diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
new file mode 100644
index 0000000000..82b1c48511
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
+		     "amlogic,meson-gxl";
+	model = "Libre Computer Board AML-S805X-AC";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		spi0 = &spifc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cvbs-connector {
+		/*
+		 * The pads are present but no connector is soldered on
+		 * 2J2, so keep this off by default.
+		 */
+		status = "disabled";
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	dc_5v: regulator-dc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
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
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+
+	vcck: regulator-vcck {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCK";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_5v>;
+
+		/*
+		 * This is controlled by GPIOAO_9 we reserve this but
+		 * claiming it as done below reset the board anyway
+		 * Need to investigate this
+		 *
+		 * gpio = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+		 * enable-active-high;
+		 */
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_5v>;
+		regulator-always-on;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
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
+&ethmac {
+	status = "okay";
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
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
+&gpio_ao {
+	gpio-line-names = "UART TX",
+			  "UART RX",
+			  "7J1 Header Pin31",
+			  "", "", "", "",
+			  "IR In",
+			  "HDMI CEC",
+			  "5V VCCK Regulator",
+			  /* GPIO_TEST_N */
+			  "";
+};
+
+&gpio {
+	gpio-line-names = /* Bank GPIOZ */
+			  "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "",
+			  "Eth Link LED", "Eth Activity LED",
+			  /* Bank GPIOH */
+			  "HDMI HPD", "HDMI SDA", "HDMI SCL",
+			  "", "7J1 Header Pin13",
+			  "7J1 Header Pin15",
+			  "7J1 Header Pin7",
+			  "7J1 Header Pin12",
+			  "7J1 Header Pin16",
+			  "7J1 Header Pin18",
+			  /* Bank BOOT */
+			  "eMMC D0", "eMMC D1", "eMMC D2", "eMMC D3",
+			  "eMMC D4", "eMMC D5", "eMMC D6", "eMMC D7",
+			  "eMMC Clk", "eMMC Reset", "eMMC CMD",
+			  "SPI NOR MOSI", "SPI NOR MISO", "SPI NOR Clk",
+			  "", "SPI NOR Chip Select",
+			  /* Bank CARD */
+			  "", "", "", "", "", "", "",
+			  /* Bank GPIODV */
+			  "", "", "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "", "", "",
+			  "7J1 Header Pin27", "7J1 Header Pin28", "",
+			  "7J1 Header Pin29",
+			  "VCCK Regulator", "VDDEE Regulator",
+			  /* Bank GPIOX */
+			  "7J1 Header Pin22", "7J1 Header Pin26",
+			  "7J1 Header Pin36", "7J1 Header Pin38",
+			  "7J1 Header Pin40", "7J1 Header Pin37",
+			  "7J1 Header Pin33", "7J1 Header Pin35",
+			  "7J1 Header Pin19", "7J1 Header Pin21",
+			  "7J1 Header Pin24", "7J1 Header Pin23",
+			  "7J1 Header Pin8", "7J1 Header Pin10",
+			  "", "", "7J1 Header Pin32", "", "",
+			  /* Bank GPIOCLK */
+			  "", "";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_boot>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
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
+	vqmmc-supply = <&vddio_boot>;
+};
+
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	w25q32: spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <3000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-gxl.dtsi b/arch/arm/dts/meson-gxl.dtsi
index 8f0bb3c44b..d5c3d78aaf 100644
--- a/arch/arm/dts/meson-gxl.dtsi
+++ b/arch/arm/dts/meson-gxl.dtsi
@@ -75,6 +75,10 @@
 	};
 };
 
+&efuse {
+	clocks = <&clkc CLKID_EFUSE>;
+};
+
 &ethmac {
 	reg = <0x0 0xc9410000 0x0 0x10000
 	       0x0 0xc8834540 0x0 0x4>;
@@ -112,6 +116,7 @@
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -120,6 +125,7 @@
 				groups = "uart_cts_ao_a",
 				       "uart_rts_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -127,6 +133,7 @@
 			mux {
 				groups = "uart_tx_ao_b", "uart_rx_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -134,6 +141,7 @@
 			mux {
 				groups = "uart_tx_ao_b_0", "uart_rx_ao_b_1";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -142,6 +150,7 @@
 				groups = "uart_cts_ao_b",
 				       "uart_rts_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -149,6 +158,7 @@
 			mux {
 				groups = "remote_input_ao";
 				function = "remote_input_ao";
+				bias-disable;
 			};
 		};
 
@@ -157,6 +167,7 @@
 				groups = "i2c_sck_ao",
 				       "i2c_sda_ao";
 				function = "i2c_ao";
+				bias-disable;
 			};
 		};
 
@@ -164,6 +175,7 @@
 			mux {
 				groups = "pwm_ao_a_3";
 				function = "pwm_ao_a";
+				bias-disable;
 			};
 		};
 
@@ -171,6 +183,7 @@
 			mux {
 				groups = "pwm_ao_a_8";
 				function = "pwm_ao_a";
+				bias-disable;
 			};
 		};
 
@@ -178,6 +191,7 @@
 			mux {
 				groups = "pwm_ao_b";
 				function = "pwm_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -185,6 +199,7 @@
 			mux {
 				groups = "pwm_ao_b_6";
 				function = "pwm_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -192,6 +207,7 @@
 			mux {
 				groups = "i2s_out_ch23_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -199,6 +215,7 @@
 			mux {
 				groups = "i2s_out_ch45_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -206,6 +223,7 @@
 			mux {
 				groups = "spdif_out_ao_6";
 				function = "spdif_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -213,6 +231,7 @@
 			mux {
 				groups = "spdif_out_ao_9";
 				function = "spdif_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -220,6 +239,7 @@
 			mux {
 				groups = "ao_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 
@@ -227,6 +247,7 @@
 			mux {
 				groups = "ee_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 	};
@@ -239,6 +260,8 @@
 
 &clkc_AO {
 	compatible = "amlogic,meson-gxl-aoclkc", "amlogic,meson-gx-aoclkc";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "mpeg-clk";
 };
 
 &gpio_intc {
@@ -263,6 +286,8 @@
 	clkc: clock-controller {
 		compatible = "amlogic,gxl-clkc";
 		#clock-cells = <1>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
 	};
 };
 
@@ -306,6 +331,7 @@
 				       "emmc_cmd",
 				       "emmc_clk";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -313,6 +339,7 @@
 			mux {
 				groups = "emmc_ds";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -320,9 +347,6 @@
 			mux {
 				groups = "BOOT_8";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "BOOT_8";
 				bias-pull-down;
 			};
 		};
@@ -334,6 +358,7 @@
 				       "nor_c",
 				       "nor_cs";
 				function = "nor";
+				bias-disable;
 			};
 		};
 
@@ -343,6 +368,7 @@
 					"spi_mosi",
 					"spi_sclk";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -350,6 +376,7 @@
 			mux {
 				groups = "spi_ss0";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -362,6 +389,7 @@
 				       "sdcard_cmd",
 				       "sdcard_clk";
 				function = "sdcard";
+				bias-disable;
 			};
 		};
 
@@ -369,9 +397,6 @@
 			mux {
 				groups = "CARD_2";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "CARD_2";
 				bias-pull-down;
 			};
 		};
@@ -385,6 +410,7 @@
 				       "sdio_cmd",
 				       "sdio_clk";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
@@ -392,9 +418,6 @@
 			mux {
 				groups = "GPIOX_4";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "GPIOX_4";
 				bias-pull-down;
 			};
 		};
@@ -403,6 +426,7 @@
 			mux {
 				groups = "sdio_irq";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
@@ -411,6 +435,7 @@
 				groups = "uart_tx_a",
 				       "uart_rx_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -419,6 +444,7 @@
 				groups = "uart_cts_a",
 				       "uart_rts_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -427,6 +453,7 @@
 				groups = "uart_tx_b",
 				       "uart_rx_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -435,6 +462,7 @@
 				groups = "uart_cts_b",
 				       "uart_rts_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -443,6 +471,7 @@
 				groups = "uart_tx_c",
 				       "uart_rx_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -451,6 +480,7 @@
 				groups = "uart_cts_c",
 				       "uart_rts_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -459,6 +489,7 @@
 				groups = "i2c_sck_a",
 				     "i2c_sda_a";
 				function = "i2c_a";
+				bias-disable;
 			};
 		};
 
@@ -467,6 +498,7 @@
 				groups = "i2c_sck_b",
 				      "i2c_sda_b";
 				function = "i2c_b";
+				bias-disable;
 			};
 		};
 
@@ -475,6 +507,7 @@
 				groups = "i2c_sck_c",
 				      "i2c_sda_c";
 				function = "i2c_c";
+				bias-disable;
 			};
 		};
 
@@ -495,6 +528,7 @@
 				       "eth_txd2",
 				       "eth_txd3";
 				function = "eth";
+				bias-disable;
 			};
 		};
 
@@ -502,6 +536,7 @@
 			mux {
 				groups = "eth_link_led";
 				function = "eth_led";
+				bias-disable;
 			};
 		};
 
@@ -516,6 +551,7 @@
 			mux {
 				groups = "pwm_a";
 				function = "pwm_a";
+				bias-disable;
 			};
 		};
 
@@ -523,6 +559,7 @@
 			mux {
 				groups = "pwm_b";
 				function = "pwm_b";
+				bias-disable;
 			};
 		};
 
@@ -530,6 +567,7 @@
 			mux {
 				groups = "pwm_c";
 				function = "pwm_c";
+				bias-disable;
 			};
 		};
 
@@ -537,6 +575,7 @@
 			mux {
 				groups = "pwm_d";
 				function = "pwm_d";
+				bias-disable;
 			};
 		};
 
@@ -544,6 +583,7 @@
 			mux {
 				groups = "pwm_e";
 				function = "pwm_e";
+				bias-disable;
 			};
 		};
 
@@ -551,6 +591,7 @@
 			mux {
 				groups = "pwm_f_clk";
 				function = "pwm_f";
+				bias-disable;
 			};
 		};
 
@@ -558,6 +599,7 @@
 			mux {
 				groups = "pwm_f_x";
 				function = "pwm_f";
+				bias-disable;
 			};
 		};
 
@@ -565,6 +607,7 @@
 			mux {
 				groups = "hdmi_hpd";
 				function = "hdmi_hpd";
+				bias-disable;
 			};
 		};
 
@@ -572,6 +615,7 @@
 			mux {
 				groups = "hdmi_sda", "hdmi_scl";
 				function = "hdmi_i2c";
+				bias-disable;
 			};
 		};
 
@@ -579,6 +623,7 @@
 			mux {
 				groups = "i2s_am_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -586,6 +631,7 @@
 			mux {
 				groups = "i2s_out_ao_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -593,6 +639,7 @@
 			mux {
 				groups = "i2s_out_lr_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -600,12 +647,14 @@
 			mux {
 				groups = "i2s_out_ch01";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 		i2sout_ch23_z_pins: i2sout_ch23_z {
 			mux {
 				groups = "i2sout_ch23_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -613,6 +662,7 @@
 			mux {
 				groups = "i2sout_ch45_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -620,6 +670,7 @@
 			mux {
 				groups = "i2sout_ch67_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -627,6 +678,7 @@
 			mux {
 				groups = "spdif_out_h";
 				function = "spdif_out";
+				bias-disable;
 			};
 		};
 	};
-- 
2.21.0

