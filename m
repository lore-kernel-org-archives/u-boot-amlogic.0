From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 1/2] arm: dts: Import and update DT for Khadas VIM3
Date: Mon,  2 Sep 2019 04:28:49 +0200
Message-Id: <20190902022851.9228-2-afaerber@suse.de>
In-Reply-To: <20190902022851.9228-1-afaerber@suse.de>
References: <20190902022851.9228-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Albert Aribaud <albert.u.boot@aribaud.net>
List-ID: <u-boot-amlogic@groups.io>

In Linux meson-g12-common.dtsi was introduced as well as new g12b nodes
and headers, as dependencies of new meson-g12b-a311d-khadas-vim3.dts.

Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++=
++++++
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
 arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
 arch/arm/dts/meson-g12b.dtsi                       |   39 +-
 include/dt-bindings/clock/g12a-clkc.h              |    6 +
 include/dt-bindings/power/meson-g12a-power.h       |   13 +
 .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
 9 files changed, 3238 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12-common.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
 create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-re=
set.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aac1b83d49..6de5e4c62a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -141,7 +141,8 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
 	meson-axg-s400.dtb \
 	meson-g12a-u200.dtb \
 	meson-g12a-sei510.dtb \
-	meson-g12b-odroid-n2.dtb
+	meson-g12b-odroid-n2.dtb \
+	meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_TEGRA) +=3D tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
diff --git a/arch/arm/dts/meson-g12-common.dtsi b/arch/arm/dts/meson-g12-=
common.dtsi
new file mode 100644
index 0000000000..3f39e020f7
--- /dev/null
+++ b/arch/arm/dts/meson-g12-common.dtsi
@@ -0,0 +1,2435 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/axg-audio-clkc.h>
+#include <dt-bindings/clock/g12a-clkc.h>
+#include <dt-bindings/clock/g12a-aoclkc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+
+/ {
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	tdmif_a: audio-controller-0 {
+		compatible =3D "amlogic,axg-tdm-iface";
+		#sound-dai-cells =3D <0>;
+		sound-name-prefix =3D "TDM_A";
+		clocks =3D <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+		clock-names =3D "mclk", "sclk", "lrclk";
+		status =3D "disabled";
+	};
+
+	tdmif_b: audio-controller-1 {
+		compatible =3D "amlogic,axg-tdm-iface";
+		#sound-dai-cells =3D <0>;
+		sound-name-prefix =3D "TDM_B";
+		clocks =3D <&clkc_audio AUD_CLKID_MST_B_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+		clock-names =3D "mclk", "sclk", "lrclk";
+		status =3D "disabled";
+	};
+
+	tdmif_c: audio-controller-2 {
+		compatible =3D "amlogic,axg-tdm-iface";
+		#sound-dai-cells =3D <0>;
+		sound-name-prefix =3D "TDM_C";
+		clocks =3D <&clkc_audio AUD_CLKID_MST_C_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
+		clock-names =3D "mclk", "sclk", "lrclk";
+		status =3D "disabled";
+	};
+
+	efuse: efuse {
+		compatible =3D "amlogic,meson-gxbb-efuse";
+		clocks =3D <&clkc CLKID_EFUSE>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		read-only;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0";
+		method =3D "smc";
+	};
+
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon@5000000 {
+			reg =3D <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+
+		linux,cma {
+			compatible =3D "shared-dma-pool";
+			reusable;
+			size =3D <0x0 0x10000000>;
+			alignment =3D <0x0 0x400000>;
+			linux,cma-default;
+		};
+	};
+
+	sm: secure-monitor {
+		compatible =3D "amlogic,meson-gxbb-sm";
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		ethmac: ethernet@ff3f0000 {
+			compatible =3D "amlogic,meson-axg-dwmac",
+				     "snps,dwmac-3.70a",
+				     "snps,dwmac";
+			reg =3D <0x0 0xff3f0000 0x0 0x10000>,
+			      <0x0 0xff634540 0x0 0x8>;
+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "macirq";
+			clocks =3D <&clkc CLKID_ETH>,
+				 <&clkc CLKID_FCLK_DIV2>,
+				 <&clkc CLKID_MPLL2>;
+			clock-names =3D "stmmaceth", "clkin0", "clkin1";
+			rx-fifo-depth =3D <4096>;
+			tx-fifo-depth =3D <2048>;
+			status =3D "disabled";
+
+			mdio0: mdio {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				compatible =3D "snps,dwmac-mdio";
+			};
+		};
+
+		apb: bus@ff600000 {
+			compatible =3D "simple-bus";
+			reg =3D <0x0 0xff600000 0x0 0x200000>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges =3D <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
+
+			hdmi_tx: hdmi-tx@0 {
+				compatible =3D "amlogic,meson-g12a-dw-hdmi";
+				reg =3D <0x0 0x0 0x0 0x10000>;
+				interrupts =3D <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
+				resets =3D <&reset RESET_HDMITX_CAPB3>,
+					 <&reset RESET_HDMITX_PHY>,
+					 <&reset RESET_HDMITX>;
+				reset-names =3D "hdmitx_apb", "hdmitx", "hdmitx_phy";
+				clocks =3D <&clkc CLKID_HDMI>,
+					 <&clkc CLKID_HTX_PCLK>,
+					 <&clkc CLKID_VPU_INTR>;
+				clock-names =3D "isfr", "iahb", "venci";
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				#sound-dai-cells =3D <0>;
+				status =3D "disabled";
+
+				/* VPU VENC Input */
+				hdmi_tx_venc_port: port@0 {
+					reg =3D <0>;
+
+					hdmi_tx_in: endpoint {
+						remote-endpoint =3D <&hdmi_tx_out>;
+					};
+				};
+
+				/* TMDS Output */
+				hdmi_tx_tmds_port: port@1 {
+					reg =3D <1>;
+				};
+			};
+
+			apb_efuse: bus@30000 {
+				compatible =3D "simple-bus";
+				reg =3D <0x0 0x30000 0x0 0x2000>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x30000 0x0 0x2000>;
+
+				hwrng: rng@218 {
+					compatible =3D "amlogic,meson-rng";
+					reg =3D <0x0 0x218 0x0 0x4>;
+				};
+			};
+
+			periphs: bus@34400 {
+				compatible =3D "simple-bus";
+				reg =3D <0x0 0x34400 0x0 0x400>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x34400 0x0 0x400>;
+
+				periphs_pinctrl: pinctrl@40 {
+					compatible =3D "amlogic,meson-g12a-periphs-pinctrl";
+					#address-cells =3D <2>;
+					#size-cells =3D <2>;
+					ranges;
+
+					gpio: bank@40 {
+						reg =3D <0x0 0x40  0x0 0x4c>,
+						      <0x0 0xe8  0x0 0x18>,
+						      <0x0 0x120 0x0 0x18>,
+						      <0x0 0x2c0 0x0 0x40>,
+						      <0x0 0x340 0x0 0x1c>;
+						reg-names =3D "gpio",
+							    "pull",
+							    "pull-enable",
+							    "mux",
+							    "ds";
+						gpio-controller;
+						#gpio-cells =3D <2>;
+						gpio-ranges =3D <&periphs_pinctrl 0 0 86>;
+					};
+
+					cec_ao_a_h_pins: cec_ao_a_h {
+						mux {
+							groups =3D "cec_ao_a_h";
+							function =3D "cec_ao_a_h";
+							bias-disable;
+						};
+					};
+
+					cec_ao_b_h_pins: cec_ao_b_h {
+						mux {
+							groups =3D "cec_ao_b_h";
+							function =3D "cec_ao_b_h";
+							bias-disable;
+						};
+					};
+
+					emmc_pins: emmc {
+						mux-0 {
+							groups =3D "emmc_nand_d0",
+								 "emmc_nand_d1",
+								 "emmc_nand_d2",
+								 "emmc_nand_d3",
+								 "emmc_nand_d4",
+								 "emmc_nand_d5",
+								 "emmc_nand_d6",
+								 "emmc_nand_d7",
+								 "emmc_cmd";
+							function =3D "emmc";
+							bias-pull-up;
+							drive-strength-microamp =3D <4000>;
+						};
+
+						mux-1 {
+							groups =3D "emmc_clk";
+							function =3D "emmc";
+							bias-disable;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					emmc_ds_pins: emmc-ds {
+						mux {
+							groups =3D "emmc_nand_ds";
+							function =3D "emmc";
+							bias-pull-down;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					emmc_clk_gate_pins: emmc_clk_gate {
+						mux {
+							groups =3D "BOOT_8";
+							function =3D "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					hdmitx_ddc_pins: hdmitx_ddc {
+						mux {
+							groups =3D "hdmitx_sda",
+								 "hdmitx_sck";
+							function =3D "hdmitx";
+							bias-disable;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					hdmitx_hpd_pins: hdmitx_hpd {
+						mux {
+							groups =3D "hdmitx_hpd_in";
+							function =3D "hdmitx";
+							bias-disable;
+						};
+					};
+
+
+					i2c0_sda_c_pins: i2c0-sda-c {
+						mux {
+							groups =3D "i2c0_sda_c";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+
+						};
+					};
+
+					i2c0_sck_c_pins: i2c0-sck-c {
+						mux {
+							groups =3D "i2c0_sck_c";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c0_sda_z0_pins: i2c0-sda-z0 {
+						mux {
+							groups =3D "i2c0_sda_z0";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c0_sck_z1_pins: i2c0-sck-z1 {
+						mux {
+							groups =3D "i2c0_sck_z1";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c0_sda_z7_pins: i2c0-sda-z7 {
+						mux {
+							groups =3D "i2c0_sda_z7";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c0_sda_z8_pins: i2c0-sda-z8 {
+						mux {
+							groups =3D "i2c0_sda_z8";
+							function =3D "i2c0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sda_x_pins: i2c1-sda-x {
+						mux {
+							groups =3D "i2c1_sda_x";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sck_x_pins: i2c1-sck-x {
+						mux {
+							groups =3D "i2c1_sck_x";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sda_h2_pins: i2c1-sda-h2 {
+						mux {
+							groups =3D "i2c1_sda_h2";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sck_h3_pins: i2c1-sck-h3 {
+						mux {
+							groups =3D "i2c1_sck_h3";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sda_h6_pins: i2c1-sda-h6 {
+						mux {
+							groups =3D "i2c1_sda_h6";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c1_sck_h7_pins: i2c1-sck-h7 {
+						mux {
+							groups =3D "i2c1_sck_h7";
+							function =3D "i2c1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c2_sda_x_pins: i2c2-sda-x {
+						mux {
+							groups =3D "i2c2_sda_x";
+							function =3D "i2c2";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c2_sck_x_pins: i2c2-sck-x {
+						mux {
+							groups =3D "i2c2_sck_x";
+							function =3D "i2c2";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c2_sda_z_pins: i2c2-sda-z {
+						mux {
+							groups =3D "i2c2_sda_z";
+							function =3D "i2c2";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c2_sck_z_pins: i2c2-sck-z {
+						mux {
+							groups =3D "i2c2_sck_z";
+							function =3D "i2c2";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c3_sda_h_pins: i2c3-sda-h {
+						mux {
+							groups =3D "i2c3_sda_h";
+							function =3D "i2c3";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c3_sck_h_pins: i2c3-sck-h {
+						mux {
+							groups =3D "i2c3_sck_h";
+							function =3D "i2c3";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c3_sda_a_pins: i2c3-sda-a {
+						mux {
+							groups =3D "i2c3_sda_a";
+							function =3D "i2c3";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c3_sck_a_pins: i2c3-sck-a {
+						mux {
+							groups =3D "i2c3_sck_a";
+							function =3D "i2c3";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					mclk0_a_pins: mclk0-a {
+						mux {
+							groups =3D "mclk0_a";
+							function =3D "mclk0";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					mclk1_a_pins: mclk1-a {
+						mux {
+							groups =3D "mclk1_a";
+							function =3D "mclk1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					mclk1_x_pins: mclk1-x {
+						mux {
+							groups =3D "mclk1_x";
+							function =3D "mclk1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					mclk1_z_pins: mclk1-z {
+						mux {
+							groups =3D "mclk1_z";
+							function =3D "mclk1";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					pdm_din0_a_pins: pdm-din0-a {
+						mux {
+							groups =3D "pdm_din0_a";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_c_pins: pdm-din0-c {
+						mux {
+							groups =3D "pdm_din0_c";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_x_pins: pdm-din0-x {
+						mux {
+							groups =3D "pdm_din0_x";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_z_pins: pdm-din0-z {
+						mux {
+							groups =3D "pdm_din0_z";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_a_pins: pdm-din1-a {
+						mux {
+							groups =3D "pdm_din1_a";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_c_pins: pdm-din1-c {
+						mux {
+							groups =3D "pdm_din1_c";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_x_pins: pdm-din1-x {
+						mux {
+							groups =3D "pdm_din1_x";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_z_pins: pdm-din1-z {
+						mux {
+							groups =3D "pdm_din1_z";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_a_pins: pdm-din2-a {
+						mux {
+							groups =3D "pdm_din2_a";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_c_pins: pdm-din2-c {
+						mux {
+							groups =3D "pdm_din2_c";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_x_pins: pdm-din2-x {
+						mux {
+							groups =3D "pdm_din2_x";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_z_pins: pdm-din2-z {
+						mux {
+							groups =3D "pdm_din2_z";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_a_pins: pdm-din3-a {
+						mux {
+							groups =3D "pdm_din3_a";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_c_pins: pdm-din3-c {
+						mux {
+							groups =3D "pdm_din3_c";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_x_pins: pdm-din3-x {
+						mux {
+							groups =3D "pdm_din3_x";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_z_pins: pdm-din3-z {
+						mux {
+							groups =3D "pdm_din3_z";
+							function =3D "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_dclk_a_pins: pdm-dclk-a {
+						mux {
+							groups =3D "pdm_dclk_a";
+							function =3D "pdm";
+							bias-disable;
+							drive-strength-microamp =3D <500>;
+						};
+					};
+
+					pdm_dclk_c_pins: pdm-dclk-c {
+						mux {
+							groups =3D "pdm_dclk_c";
+							function =3D "pdm";
+							bias-disable;
+							drive-strength-microamp =3D <500>;
+						};
+					};
+
+					pdm_dclk_x_pins: pdm-dclk-x {
+						mux {
+							groups =3D "pdm_dclk_x";
+							function =3D "pdm";
+							bias-disable;
+							drive-strength-microamp =3D <500>;
+						};
+					};
+
+					pdm_dclk_z_pins: pdm-dclk-z {
+						mux {
+							groups =3D "pdm_dclk_z";
+							function =3D "pdm";
+							bias-disable;
+							drive-strength-microamp =3D <500>;
+						};
+					};
+
+					pwm_a_pins: pwm-a {
+						mux {
+							groups =3D "pwm_a";
+							function =3D "pwm_a";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x7_pins: pwm-b-x7 {
+						mux {
+							groups =3D "pwm_b_x7";
+							function =3D "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x19_pins: pwm-b-x19 {
+						mux {
+							groups =3D "pwm_b_x19";
+							function =3D "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_c_c_pins: pwm-c-c {
+						mux {
+							groups =3D "pwm_c_c";
+							function =3D "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x5_pins: pwm-c-x5 {
+						mux {
+							groups =3D "pwm_c_x5";
+							function =3D "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x8_pins: pwm-c-x8 {
+						mux {
+							groups =3D "pwm_c_x8";
+							function =3D "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x3_pins: pwm-d-x3 {
+						mux {
+							groups =3D "pwm_d_x3";
+							function =3D "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x6_pins: pwm-d-x6 {
+						mux {
+							groups =3D "pwm_d_x6";
+							function =3D "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_e_pins: pwm-e {
+						mux {
+							groups =3D "pwm_e";
+							function =3D "pwm_e";
+							bias-disable;
+						};
+					};
+
+					pwm_f_x_pins: pwm-f-x {
+						mux {
+							groups =3D "pwm_f_x";
+							function =3D "pwm_f";
+							bias-disable;
+						};
+					};
+
+					pwm_f_h_pins: pwm-f-h {
+						mux {
+							groups =3D "pwm_f_h";
+							function =3D "pwm_f";
+							bias-disable;
+						};
+					};
+
+					sdcard_c_pins: sdcard_c {
+						mux-0 {
+							groups =3D "sdcard_d0_c",
+								 "sdcard_d1_c",
+								 "sdcard_d2_c",
+								 "sdcard_d3_c",
+								 "sdcard_cmd_c";
+							function =3D "sdcard";
+							bias-pull-up;
+							drive-strength-microamp =3D <4000>;
+						};
+
+						mux-1 {
+							groups =3D "sdcard_clk_c";
+							function =3D "sdcard";
+							bias-disable;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					sdcard_clk_gate_c_pins: sdcard_clk_gate_c {
+						mux {
+							groups =3D "GPIOC_4";
+							function =3D "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					sdcard_z_pins: sdcard_z {
+						mux-0 {
+							groups =3D "sdcard_d0_z",
+								 "sdcard_d1_z",
+								 "sdcard_d2_z",
+								 "sdcard_d3_z",
+								 "sdcard_cmd_z";
+							function =3D "sdcard";
+							bias-pull-up;
+							drive-strength-microamp =3D <4000>;
+						};
+
+						mux-1 {
+							groups =3D "sdcard_clk_z";
+							function =3D "sdcard";
+							bias-disable;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					sdcard_clk_gate_z_pins: sdcard_clk_gate_z {
+						mux {
+							groups =3D "GPIOZ_6";
+							function =3D "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					sdio_pins: sdio {
+						mux {
+							groups =3D "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_clk",
+								 "sdio_cmd";
+							function =3D "sdio";
+							bias-disable;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					sdio_clk_gate_pins: sdio_clk_gate {
+						mux {
+							groups =3D "GPIOX_4";
+							function =3D "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp =3D <4000>;
+						};
+					};
+
+					spdif_in_a10_pins: spdif-in-a10 {
+						mux {
+							groups =3D "spdif_in_a10";
+							function =3D "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_a12_pins: spdif-in-a12 {
+						mux {
+							groups =3D "spdif_in_a12";
+							function =3D "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_h_pins: spdif-in-h {
+						mux {
+							groups =3D "spdif_in_h";
+							function =3D "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_out_h_pins: spdif-out-h {
+						mux {
+							groups =3D "spdif_out_h";
+							function =3D "spdif_out";
+							drive-strength-microamp =3D <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a11_pins: spdif-out-a11 {
+						mux {
+							groups =3D "spdif_out_a11";
+							function =3D "spdif_out";
+							drive-strength-microamp =3D <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a13_pins: spdif-out-a13 {
+						mux {
+							groups =3D "spdif_out_a13";
+							function =3D "spdif_out";
+							drive-strength-microamp =3D <500>;
+							bias-disable;
+						};
+					};
+
+					tdm_a_din0_pins: tdm-a-din0 {
+						mux {
+							groups =3D "tdm_a_din0";
+							function =3D "tdm_a";
+							bias-disable;
+						};
+					};
+
+
+					tdm_a_din1_pins: tdm-a-din1 {
+						mux {
+							groups =3D "tdm_a_din1";
+							function =3D "tdm_a";
+							bias-disable;
+						};
+					};
+
+					tdm_a_dout0_pins: tdm-a-dout0 {
+						mux {
+							groups =3D "tdm_a_dout0";
+							function =3D "tdm_a";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_a_dout1_pins: tdm-a-dout1 {
+						mux {
+							groups =3D "tdm_a_dout1";
+							function =3D "tdm_a";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_a_fs_pins: tdm-a-fs {
+						mux {
+							groups =3D "tdm_a_fs";
+							function =3D "tdm_a";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_a_sclk_pins: tdm-a-sclk {
+						mux {
+							groups =3D "tdm_a_sclk";
+							function =3D "tdm_a";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_a_slv_fs_pins: tdm-a-slv-fs {
+						mux {
+							groups =3D "tdm_a_slv_fs";
+							function =3D "tdm_a";
+							bias-disable;
+						};
+					};
+
+
+					tdm_a_slv_sclk_pins: tdm-a-slv-sclk {
+						mux {
+							groups =3D "tdm_a_slv_sclk";
+							function =3D "tdm_a";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din0_pins: tdm-b-din0 {
+						mux {
+							groups =3D "tdm_b_din0";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din1_pins: tdm-b-din1 {
+						mux {
+							groups =3D "tdm_b_din1";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din2_pins: tdm-b-din2 {
+						mux {
+							groups =3D "tdm_b_din2";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din3_a_pins: tdm-b-din3-a {
+						mux {
+							groups =3D "tdm_b_din3_a";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din3_h_pins: tdm-b-din3-h {
+						mux {
+							groups =3D "tdm_b_din3_h";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_dout0_pins: tdm-b-dout0 {
+						mux {
+							groups =3D "tdm_b_dout0";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_dout1_pins: tdm-b-dout1 {
+						mux {
+							groups =3D "tdm_b_dout1";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_dout2_pins: tdm-b-dout2 {
+						mux {
+							groups =3D "tdm_b_dout2";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_dout3_a_pins: tdm-b-dout3-a {
+						mux {
+							groups =3D "tdm_b_dout3_a";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_dout3_h_pins: tdm-b-dout3-h {
+						mux {
+							groups =3D "tdm_b_dout3_h";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_fs_pins: tdm-b-fs {
+						mux {
+							groups =3D "tdm_b_fs";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_sclk_pins: tdm-b-sclk {
+						mux {
+							groups =3D "tdm_b_sclk";
+							function =3D "tdm_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_b_slv_fs_pins: tdm-b-slv-fs {
+						mux {
+							groups =3D "tdm_b_slv_fs";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_slv_sclk_pins: tdm-b-slv-sclk {
+						mux {
+							groups =3D "tdm_b_slv_sclk";
+							function =3D "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din0_a_pins: tdm-c-din0-a {
+						mux {
+							groups =3D "tdm_c_din0_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din0_z_pins: tdm-c-din0-z {
+						mux {
+							groups =3D "tdm_c_din0_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din1_a_pins: tdm-c-din1-a {
+						mux {
+							groups =3D "tdm_c_din1_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din1_z_pins: tdm-c-din1-z {
+						mux {
+							groups =3D "tdm_c_din1_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din2_a_pins: tdm-c-din2-a {
+						mux {
+							groups =3D "tdm_c_din2_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					eth_leds_pins: eth-leds {
+						mux {
+							groups =3D "eth_link_led",
+								 "eth_act_led";
+							function =3D "eth";
+							bias-disable;
+						};
+					};
+
+					eth_pins: eth {
+						mux {
+							groups =3D "eth_mdio",
+								 "eth_mdc",
+								 "eth_rgmii_rx_clk",
+								 "eth_rx_dv",
+								 "eth_rxd0",
+								 "eth_rxd1",
+								 "eth_txen",
+								 "eth_txd0",
+								 "eth_txd1";
+							function =3D "eth";
+							drive-strength-microamp =3D <4000>;
+							bias-disable;
+						};
+					};
+
+					eth_rgmii_pins: eth-rgmii {
+						mux {
+							groups =3D "eth_rxd2_rgmii",
+								 "eth_rxd3_rgmii",
+								 "eth_rgmii_tx_clk",
+								 "eth_txd2_rgmii",
+								 "eth_txd3_rgmii";
+							function =3D "eth";
+							drive-strength-microamp =3D <4000>;
+							bias-disable;
+						};
+					};
+
+					tdm_c_din2_z_pins: tdm-c-din2-z {
+						mux {
+							groups =3D "tdm_c_din2_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din3_a_pins: tdm-c-din3-a {
+						mux {
+							groups =3D "tdm_c_din3_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din3_z_pins: tdm-c-din3-z {
+						mux {
+							groups =3D "tdm_c_din3_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_dout0_a_pins: tdm-c-dout0-a {
+						mux {
+							groups =3D "tdm_c_dout0_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout0_z_pins: tdm-c-dout0-z {
+						mux {
+							groups =3D "tdm_c_dout0_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout1_a_pins: tdm-c-dout1-a {
+						mux {
+							groups =3D "tdm_c_dout1_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout1_z_pins: tdm-c-dout1-z {
+						mux {
+							groups =3D "tdm_c_dout1_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout2_a_pins: tdm-c-dout2-a {
+						mux {
+							groups =3D "tdm_c_dout2_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout2_z_pins: tdm-c-dout2-z {
+						mux {
+							groups =3D "tdm_c_dout2_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout3_a_pins: tdm-c-dout3-a {
+						mux {
+							groups =3D "tdm_c_dout3_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_dout3_z_pins: tdm-c-dout3-z {
+						mux {
+							groups =3D "tdm_c_dout3_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_fs_a_pins: tdm-c-fs-a {
+						mux {
+							groups =3D "tdm_c_fs_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_fs_z_pins: tdm-c-fs-z {
+						mux {
+							groups =3D "tdm_c_fs_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_sclk_a_pins: tdm-c-sclk-a {
+						mux {
+							groups =3D "tdm_c_sclk_a";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_sclk_z_pins: tdm-c-sclk-z {
+						mux {
+							groups =3D "tdm_c_sclk_z";
+							function =3D "tdm_c";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_c_slv_fs_a_pins: tdm-c-slv-fs-a {
+						mux {
+							groups =3D "tdm_c_slv_fs_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_fs_z_pins: tdm-c-slv-fs-z {
+						mux {
+							groups =3D "tdm_c_slv_fs_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_sclk_a_pins: tdm-c-slv-sclk-a {
+						mux {
+							groups =3D "tdm_c_slv_sclk_a";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_sclk_z_pins: tdm-c-slv-sclk-z {
+						mux {
+							groups =3D "tdm_c_slv_sclk_z";
+							function =3D "tdm_c";
+							bias-disable;
+						};
+					};
+
+					uart_a_pins: uart-a {
+						mux {
+							groups =3D "uart_a_tx",
+								 "uart_a_rx";
+							function =3D "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_a_cts_rts_pins: uart-a-cts-rts {
+						mux {
+							groups =3D "uart_a_cts",
+								 "uart_a_rts";
+							function =3D "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_b_pins: uart-b {
+						mux {
+							groups =3D "uart_b_tx",
+								 "uart_b_rx";
+							function =3D "uart_b";
+							bias-disable;
+						};
+					};
+
+					uart_c_pins: uart-c {
+						mux {
+							groups =3D "uart_c_tx",
+								 "uart_c_rx";
+							function =3D "uart_c";
+							bias-disable;
+						};
+					};
+
+					uart_c_cts_rts_pins: uart-c-cts-rts {
+						mux {
+							groups =3D "uart_c_cts",
+								 "uart_c_rts";
+							function =3D "uart_c";
+							bias-disable;
+						};
+					};
+				};
+			};
+
+			usb2_phy0: phy@36000 {
+				compatible =3D "amlogic,g12a-usb2-phy";
+				reg =3D <0x0 0x36000 0x0 0x2000>;
+				clocks =3D <&xtal>;
+				clock-names =3D "xtal";
+				resets =3D <&reset RESET_USB_PHY20>;
+				reset-names =3D "phy";
+				#phy-cells =3D <0>;
+			};
+
+			dmc: bus@38000 {
+				compatible =3D "simple-bus";
+				reg =3D <0x0 0x38000 0x0 0x400>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x38000 0x0 0x400>;
+
+				canvas: video-lut@48 {
+					compatible =3D "amlogic,canvas";
+					reg =3D <0x0 0x48 0x0 0x14>;
+				};
+			};
+
+			usb2_phy1: phy@3a000 {
+				compatible =3D "amlogic,g12a-usb2-phy";
+				reg =3D <0x0 0x3a000 0x0 0x2000>;
+				clocks =3D <&xtal>;
+				clock-names =3D "xtal";
+				resets =3D <&reset RESET_USB_PHY21>;
+				reset-names =3D "phy";
+				#phy-cells =3D <0>;
+			};
+
+			hiu: bus@3c000 {
+				compatible =3D "simple-bus";
+				reg =3D <0x0 0x3c000 0x0 0x1400>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+
+				hhi: system-controller@0 {
+					compatible =3D "amlogic,meson-gx-hhi-sysctrl",
+						     "simple-mfd", "syscon";
+					reg =3D <0 0 0 0x400>;
+
+					clkc: clock-controller {
+						compatible =3D "amlogic,g12a-clkc";
+						#clock-cells =3D <1>;
+						clocks =3D <&xtal>;
+						clock-names =3D "xtal";
+					};
+
+					pwrc: power-controller {
+						compatible =3D "amlogic,meson-g12a-pwrc";
+						#power-domain-cells =3D <1>;
+						amlogic,ao-sysctrl =3D <&rti>;
+						resets =3D <&reset RESET_VIU>,
+							 <&reset RESET_VENC>,
+							 <&reset RESET_VCBUS>,
+							 <&reset RESET_BT656>,
+							 <&reset RESET_RDMA>,
+							 <&reset RESET_VENCI>,
+							 <&reset RESET_VENCP>,
+							 <&reset RESET_VDAC>,
+							 <&reset RESET_VDI6>,
+							 <&reset RESET_VENCL>,
+							 <&reset RESET_VID_LOCK>;
+						reset-names =3D "viu", "venc", "vcbus", "bt656",
+							      "rdma", "venci", "vencp", "vdac",
+							      "vdi6", "vencl", "vid_lock";
+						clocks =3D <&clkc CLKID_VPU>,
+							 <&clkc CLKID_VAPB>;
+						clock-names =3D "vpu", "vapb";
+						/*
+						 * VPU clocking is provided by two identical clock paths
+						 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+						 * free mux to safely change frequency while running.
+						 * Same for VAPB but with a final gate after the glitch free mux.
+						 */
+						assigned-clocks =3D <&clkc CLKID_VPU_0_SEL>,
+								  <&clkc CLKID_VPU_0>,
+								  <&clkc CLKID_VPU>, /* Glitch free mux */
+								  <&clkc CLKID_VAPB_0_SEL>,
+								  <&clkc CLKID_VAPB_0>,
+								  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+						assigned-clock-parents =3D <&clkc CLKID_FCLK_DIV3>,
+									 <0>, /* Do Nothing */
+									 <&clkc CLKID_VPU_0>,
+									 <&clkc CLKID_FCLK_DIV4>,
+									 <0>, /* Do Nothing */
+									 <&clkc CLKID_VAPB_0>;
+						assigned-clock-rates =3D <0>, /* Do Nothing */
+								       <666666666>,
+								       <0>, /* Do Nothing */
+								       <0>, /* Do Nothing */
+								       <250000000>,
+								       <0>; /* Do Nothing */
+					};
+				};
+			};
+
+			pdm: audio-controller@40000 {
+				compatible =3D "amlogic,g12a-pdm",
+					     "amlogic,axg-pdm";
+				reg =3D <0x0 0x40000 0x0 0x34>;
+				#sound-dai-cells =3D <0>;
+				sound-name-prefix =3D "PDM";
+				clocks =3D <&clkc_audio AUD_CLKID_PDM>,
+					 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+					 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+				clock-names =3D "pclk", "dclk", "sysclk";
+				status =3D "disabled";
+			};
+
+			audio: bus@42000 {
+				compatible =3D "simple-bus";
+				reg =3D <0x0 0x42000 0x0 0x2000>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x42000 0x0 0x2000>;
+
+				clkc_audio: clock-controller@0 {
+					status =3D "disabled";
+					compatible =3D "amlogic,g12a-audio-clkc";
+					reg =3D <0x0 0x0 0x0 0xb4>;
+					#clock-cells =3D <1>;
+					#reset-cells =3D <1>;
+
+					clocks =3D <&clkc CLKID_AUDIO>,
+						 <&clkc CLKID_MPLL0>,
+						 <&clkc CLKID_MPLL1>,
+						 <&clkc CLKID_MPLL2>,
+						 <&clkc CLKID_MPLL3>,
+						 <&clkc CLKID_HIFI_PLL>,
+						 <&clkc CLKID_FCLK_DIV3>,
+						 <&clkc CLKID_FCLK_DIV4>,
+						 <&clkc CLKID_GP0_PLL>;
+					clock-names =3D "pclk",
+						      "mst_in0",
+						      "mst_in1",
+						      "mst_in2",
+						      "mst_in3",
+						      "mst_in4",
+						      "mst_in5",
+						      "mst_in6",
+						      "mst_in7";
+
+					resets =3D <&reset RESET_AUDIO>;
+				};
+
+				toddr_a: audio-controller@100 {
+					compatible =3D "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg =3D <0x0 0x100 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "TODDR_A";
+					interrupts =3D <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_TODDR_A>;
+					resets =3D <&arb AXG_ARB_TODDR_A>;
+					status =3D "disabled";
+				};
+
+				toddr_b: audio-controller@140 {
+					compatible =3D "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg =3D <0x0 0x140 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "TODDR_B";
+					interrupts =3D <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_TODDR_B>;
+					resets =3D <&arb AXG_ARB_TODDR_B>;
+					status =3D "disabled";
+				};
+
+				toddr_c: audio-controller@180 {
+					compatible =3D "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg =3D <0x0 0x180 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "TODDR_C";
+					interrupts =3D <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_TODDR_C>;
+					resets =3D <&arb AXG_ARB_TODDR_C>;
+					status =3D "disabled";
+				};
+
+				frddr_a: audio-controller@1c0 {
+					compatible =3D "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg =3D <0x0 0x1c0 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "FRDDR_A";
+					interrupts =3D <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_FRDDR_A>;
+					resets =3D <&arb AXG_ARB_FRDDR_A>;
+					status =3D "disabled";
+				};
+
+				frddr_b: audio-controller@200 {
+					compatible =3D "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg =3D <0x0 0x200 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "FRDDR_B";
+					interrupts =3D <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_FRDDR_B>;
+					resets =3D <&arb AXG_ARB_FRDDR_B>;
+					status =3D "disabled";
+				};
+
+				frddr_c: audio-controller@240 {
+					compatible =3D "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg =3D <0x0 0x240 0x0 0x1c>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "FRDDR_C";
+					interrupts =3D <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_FRDDR_C>;
+					resets =3D <&arb AXG_ARB_FRDDR_C>;
+					status =3D "disabled";
+				};
+
+				arb: reset-controller@280 {
+					status =3D "disabled";
+					compatible =3D "amlogic,meson-axg-audio-arb";
+					reg =3D <0x0 0x280 0x0 0x4>;
+					#reset-cells =3D <1>;
+					clocks =3D <&clkc_audio AUD_CLKID_DDR_ARB>;
+				};
+
+				tdmin_a: audio-controller@300 {
+					compatible =3D "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg =3D <0x0 0x300 0x0 0x40>;
+					sound-name-prefix =3D "TDMIN_A";
+					resets =3D <&clkc_audio AUD_RESET_TDMIN_A>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMIN_A>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				tdmin_b: audio-controller@340 {
+					compatible =3D "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg =3D <0x0 0x340 0x0 0x40>;
+					sound-name-prefix =3D "TDMIN_B";
+					resets =3D <&clkc_audio AUD_RESET_TDMIN_B>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMIN_B>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				tdmin_c: audio-controller@380 {
+					compatible =3D "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg =3D <0x0 0x380 0x0 0x40>;
+					sound-name-prefix =3D "TDMIN_C";
+					resets =3D <&clkc_audio AUD_RESET_TDMIN_C>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMIN_C>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				tdmin_lb: audio-controller@3c0 {
+					compatible =3D "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg =3D <0x0 0x3c0 0x0 0x40>;
+					sound-name-prefix =3D "TDMIN_LB";
+					resets =3D <&clkc_audio AUD_RESET_TDMIN_LB>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMIN_LB>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				spdifin: audio-controller@400 {
+					compatible =3D "amlogic,g12a-spdifin",
+						     "amlogic,axg-spdifin";
+					reg =3D <0x0 0x400 0x0 0x30>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "SPDIFIN";
+					interrupts =3D <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+					clocks =3D <&clkc_audio AUD_CLKID_SPDIFIN>,
+						 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+					clock-names =3D "pclk", "refclk";
+					status =3D "disabled";
+				};
+
+				spdifout: audio-controller@480 {
+					compatible =3D "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg =3D <0x0 0x480 0x0 0x50>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "SPDIFOUT";
+					clocks =3D <&clkc_audio AUD_CLKID_SPDIFOUT>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+					clock-names =3D "pclk", "mclk";
+					status =3D "disabled";
+				};
+
+				tdmout_a: audio-controller@500 {
+					compatible =3D "amlogic,g12a-tdmout";
+					reg =3D <0x0 0x500 0x0 0x40>;
+					sound-name-prefix =3D "TDMOUT_A";
+					resets =3D <&clkc_audio AUD_RESET_TDMOUT_A>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMOUT_A>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				tdmout_b: audio-controller@540 {
+					compatible =3D "amlogic,g12a-tdmout";
+					reg =3D <0x0 0x540 0x0 0x40>;
+					sound-name-prefix =3D "TDMOUT_B";
+					resets =3D <&clkc_audio AUD_RESET_TDMOUT_B>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMOUT_B>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				tdmout_c: audio-controller@580 {
+					compatible =3D "amlogic,g12a-tdmout";
+					reg =3D <0x0 0x580 0x0 0x40>;
+					sound-name-prefix =3D "TDMOUT_C";
+					resets =3D <&clkc_audio AUD_RESET_TDMOUT_C>;
+					clocks =3D <&clkc_audio AUD_CLKID_TDMOUT_C>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
+					clock-names =3D "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status =3D "disabled";
+				};
+
+				spdifout_b: audio-controller@680 {
+					compatible =3D "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg =3D <0x0 0x680 0x0 0x50>;
+					#sound-dai-cells =3D <0>;
+					sound-name-prefix =3D "SPDIFOUT_B";
+					clocks =3D <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
+					clock-names =3D "pclk", "mclk";
+					status =3D "disabled";
+				};
+
+				tohdmitx: audio-controller@744 {
+					compatible =3D "amlogic,g12a-tohdmitx";
+					reg =3D <0x0 0x744 0x0 0x4>;
+					#sound-dai-cells =3D <1>;
+					sound-name-prefix =3D "TOHDMITX";
+					status =3D "disabled";
+				};
+			};
+
+			usb3_pcie_phy: phy@46000 {
+				compatible =3D "amlogic,g12a-usb3-pcie-phy";
+				reg =3D <0x0 0x46000 0x0 0x2000>;
+				clocks =3D <&clkc CLKID_PCIE_PLL>;
+				clock-names =3D "ref_clk";
+				resets =3D <&reset RESET_PCIE_PHY>;
+				reset-names =3D "phy";
+				assigned-clocks =3D <&clkc CLKID_PCIE_PLL>;
+				assigned-clock-rates =3D <100000000>;
+				#phy-cells =3D <1>;
+			};
+
+			eth_phy: mdio-multiplexer@4c000 {
+				compatible =3D "amlogic,g12a-mdio-mux";
+				reg =3D <0x0 0x4c000 0x0 0xa4>;
+				clocks =3D <&clkc CLKID_ETH_PHY>,
+					 <&xtal>,
+					 <&clkc CLKID_MPLL_50M>;
+				clock-names =3D "pclk", "clkin0", "clkin1";
+				mdio-parent-bus =3D <&mdio0>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				ext_mdio: mdio@0 {
+					reg =3D <0>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg =3D <1>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					internal_ephy: ethernet_phy@8 {
+						compatible =3D "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+						reg =3D <8>;
+						max-speed =3D <100>;
+					};
+				};
+			};
+		};
+
+		aobus: bus@ff800000 {
+			compatible =3D "simple-bus";
+			reg =3D <0x0 0xff800000 0x0 0x100000>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges =3D <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
+
+			rti: sys-ctrl@0 {
+				compatible =3D "amlogic,meson-gx-ao-sysctrl",
+					     "simple-mfd", "syscon";
+				reg =3D <0x0 0x0 0x0 0x100>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x0 0x0 0x0 0x100>;
+
+				clkc_AO: clock-controller {
+					compatible =3D "amlogic,meson-g12a-aoclkc";
+					#clock-cells =3D <1>;
+					#reset-cells =3D <1>;
+					clocks =3D <&xtal>, <&clkc CLKID_CLK81>;
+					clock-names =3D "xtal", "mpeg-clk";
+				};
+
+				ao_pinctrl: pinctrl@14 {
+					compatible =3D "amlogic,meson-g12a-aobus-pinctrl";
+					#address-cells =3D <2>;
+					#size-cells =3D <2>;
+					ranges;
+
+					gpio_ao: bank@14 {
+						reg =3D <0x0 0x14 0x0 0x8>,
+						      <0x0 0x1c 0x0 0x8>,
+						      <0x0 0x24 0x0 0x14>;
+						reg-names =3D "mux",
+							    "ds",
+							    "gpio";
+						gpio-controller;
+						#gpio-cells =3D <2>;
+						gpio-ranges =3D <&ao_pinctrl 0 0 15>;
+					};
+
+					i2c_ao_sck_pins: i2c_ao_sck_pins {
+						mux {
+							groups =3D "i2c_ao_sck";
+							function =3D "i2c_ao";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c_ao_sda_pins: i2c_ao_sda {
+						mux {
+							groups =3D "i2c_ao_sda";
+							function =3D "i2c_ao";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c_ao_sck_e_pins: i2c_ao_sck_e {
+						mux {
+							groups =3D "i2c_ao_sck_e";
+							function =3D "i2c_ao";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					i2c_ao_sda_e_pins: i2c_ao_sda_e {
+						mux {
+							groups =3D "i2c_ao_sda_e";
+							function =3D "i2c_ao";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					mclk0_ao_pins: mclk0-ao {
+						mux {
+							groups =3D "mclk0_ao";
+							function =3D "mclk0_ao";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_din0_pins: tdm-ao-b-din0 {
+						mux {
+							groups =3D "tdm_ao_b_din0";
+							function =3D "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					spdif_ao_out_pins: spdif-ao-out {
+						mux {
+							groups =3D "spdif_ao_out";
+							function =3D "spdif_ao_out";
+							drive-strength-microamp =3D <500>;
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_din1_pins: tdm-ao-b-din1 {
+						mux {
+							groups =3D "tdm_ao_b_din1";
+							function =3D "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_din2_pins: tdm-ao-b-din2 {
+						mux {
+							groups =3D "tdm_ao_b_din2";
+							function =3D "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_dout0_pins: tdm-ao-b-dout0 {
+						mux {
+							groups =3D "tdm_ao_b_dout0";
+							function =3D "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_dout1_pins: tdm-ao-b-dout1 {
+						mux {
+							groups =3D "tdm_ao_b_dout1";
+							function =3D "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_dout2_pins: tdm-ao-b-dout2 {
+						mux {
+							groups =3D "tdm_ao_b_dout2";
+							function =3D "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_fs_pins: tdm-ao-b-fs {
+						mux {
+							groups =3D "tdm_ao_b_fs";
+							function =3D "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_sclk_pins: tdm-ao-b-sclk {
+						mux {
+							groups =3D "tdm_ao_b_sclk";
+							function =3D "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp =3D <3000>;
+						};
+					};
+
+					tdm_ao_b_slv_fs_pins: tdm-ao-b-slv-fs {
+						mux {
+							groups =3D "tdm_ao_b_slv_fs";
+							function =3D "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_slv_sclk_pins: tdm-ao-b-slv-sclk {
+						mux {
+							groups =3D "tdm_ao_b_slv_sclk";
+							function =3D "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_pins: uart-a-ao {
+						mux {
+							groups =3D "uart_ao_a_tx",
+								 "uart_ao_a_rx";
+							function =3D "uart_ao_a";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_cts_rts_pins: uart-ao-a-cts-rts {
+						mux {
+							groups =3D "uart_ao_a_cts",
+								 "uart_ao_a_rts";
+							function =3D "uart_ao_a";
+							bias-disable;
+						};
+					};
+
+					pwm_a_e_pins: pwm-a-e {
+						mux {
+							groups =3D "pwm_a_e";
+							function =3D "pwm_a_e";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_a_pins: pwm-ao-a {
+						mux {
+							groups =3D "pwm_ao_a";
+							function =3D "pwm_ao_a";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_b_pins: pwm-ao-b {
+						mux {
+							groups =3D "pwm_ao_b";
+							function =3D "pwm_ao_b";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_4_pins: pwm-ao-c-4 {
+						mux {
+							groups =3D "pwm_ao_c_4";
+							function =3D "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_6_pins: pwm-ao-c-6 {
+						mux {
+							groups =3D "pwm_ao_c_6";
+							function =3D "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_5_pins: pwm-ao-d-5 {
+						mux {
+							groups =3D "pwm_ao_d_5";
+							function =3D "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_10_pins: pwm-ao-d-10 {
+						mux {
+							groups =3D "pwm_ao_d_10";
+							function =3D "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_e_pins: pwm-ao-d-e {
+						mux {
+							groups =3D "pwm_ao_d_e";
+							function =3D "pwm_ao_d";
+						};
+					};
+
+					remote_input_ao_pins: remote-input-ao {
+						mux {
+							groups =3D "remote_ao_input";
+							function =3D "remote_ao_input";
+							bias-disable;
+						};
+					};
+				};
+			};
+
+			vrtc: rtc@0a8 {
+				compatible =3D "amlogic,meson-vrtc";
+				reg =3D <0x0 0x000a8 0x0 0x4>;
+			};
+
+			cec_AO: cec@100 {
+				compatible =3D "amlogic,meson-gx-ao-cec";
+				reg =3D <0x0 0x00100 0x0 0x14>;
+				interrupts =3D <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&clkc_AO CLKID_AO_CEC>;
+				clock-names =3D "core";
+				status =3D "disabled";
+			};
+
+			sec_AO: ao-secure@140 {
+				compatible =3D "amlogic,meson-gx-ao-secure", "syscon";
+				reg =3D <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
+			cecb_AO: cec@280 {
+				compatible =3D "amlogic,meson-g12a-ao-cec";
+				reg =3D <0x0 0x00280 0x0 0x1c>;
+				interrupts =3D <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&clkc_AO CLKID_AO_CTS_OSCIN>;
+				clock-names =3D "oscin";
+				status =3D "disabled";
+			};
+
+			pwm_AO_cd: pwm@2000 {
+				compatible =3D "amlogic,meson-g12a-ao-pwm-cd";
+				reg =3D <0x0 0x2000 0x0 0x20>;
+				#pwm-cells =3D <3>;
+				status =3D "disabled";
+			};
+
+			uart_AO: serial@3000 {
+				compatible =3D "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg =3D <0x0 0x3000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&clkc_AO CLKID_AO_UART>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+
+			uart_AO_B: serial@4000 {
+				compatible =3D "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg =3D <0x0 0x4000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+
+			i2c_AO: i2c@5000 {
+				compatible =3D "amlogic,meson-axg-i2c";
+				status =3D "disabled";
+				reg =3D <0x0 0x05000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				clocks =3D <&clkc CLKID_I2C>;
+			};
+
+			pwm_AO_ab: pwm@7000 {
+				compatible =3D "amlogic,meson-g12a-ao-pwm-ab";
+				reg =3D <0x0 0x7000 0x0 0x20>;
+				#pwm-cells =3D <3>;
+				status =3D "disabled";
+			};
+
+			ir: ir@8000 {
+				compatible =3D "amlogic,meson-gxbb-ir";
+				reg =3D <0x0 0x8000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
+				status =3D "disabled";
+			};
+
+			saradc: adc@9000 {
+				compatible =3D "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg =3D <0x0 0x9000 0x0 0x48>;
+				#io-channel-cells =3D <1>;
+				interrupts =3D <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>,
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names =3D "clkin", "core", "adc_clk", "adc_sel";
+				status =3D "disabled";
+			};
+		};
+
+		vpu: vpu@ff900000 {
+			compatible =3D "amlogic,meson-g12a-vpu";
+			reg =3D <0x0 0xff900000 0x0 0x100000>,
+			      <0x0 0xff63c000 0x0 0x1000>;
+			reg-names =3D "vpu", "hhi";
+			interrupts =3D <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			amlogic,canvas =3D <&canvas>;
+
+			/* CVBS VDAC output port */
+			cvbs_vdac_port: port@0 {
+				reg =3D <0>;
+			};
+
+			/* HDMI-TX output port */
+			hdmi_tx_port: port@1 {
+				reg =3D <1>;
+
+				hdmi_tx_out: endpoint {
+					remote-endpoint =3D <&hdmi_tx_in>;
+				};
+			};
+		};
+
+		gic: interrupt-controller@ffc01000 {
+			compatible =3D "arm,gic-400";
+			reg =3D <0x0 0xffc01000 0 0x1000>,
+			      <0x0 0xffc02000 0 0x2000>,
+			      <0x0 0xffc04000 0 0x2000>,
+			      <0x0 0xffc06000 0 0x2000>;
+			interrupt-controller;
+			interrupts =3D <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+		};
+
+		cbus: bus@ffd00000 {
+			compatible =3D "simple-bus";
+			reg =3D <0x0 0xffd00000 0x0 0x100000>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges =3D <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
+
+			reset: reset-controller@1004 {
+				compatible =3D "amlogic,meson-axg-reset";
+				reg =3D <0x0 0x1004 0x0 0x9c>;
+				#reset-cells =3D <1>;
+			};
+
+			gpio_intc: interrupt-controller@f080 {
+				compatible =3D "amlogic,meson-g12a-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg =3D <0x0 0xf080 0x0 0x10>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+				amlogic,channel-interrupts =3D <64 65 66 67 68 69 70 71>;
+			};
+
+			pwm_ef: pwm@19000 {
+				compatible =3D "amlogic,meson-g12a-ee-pwm";
+				reg =3D <0x0 0x19000 0x0 0x20>;
+				#pwm-cells =3D <3>;
+				status =3D "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible =3D "amlogic,meson-g12a-ee-pwm";
+				reg =3D <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells =3D <3>;
+				status =3D "disabled";
+			};
+
+			pwm_ab: pwm@1b000 {
+				compatible =3D "amlogic,meson-g12a-ee-pwm";
+				reg =3D <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells =3D <3>;
+				status =3D "disabled";
+			};
+
+			i2c3: i2c@1c000 {
+				compatible =3D "amlogic,meson-axg-i2c";
+				status =3D "disabled";
+				reg =3D <0x0 0x1c000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				clocks =3D <&clkc CLKID_I2C>;
+			};
+
+			i2c2: i2c@1d000 {
+				compatible =3D "amlogic,meson-axg-i2c";
+				status =3D "disabled";
+				reg =3D <0x0 0x1d000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				clocks =3D <&clkc CLKID_I2C>;
+			};
+
+			i2c1: i2c@1e000 {
+				compatible =3D "amlogic,meson-axg-i2c";
+				status =3D "disabled";
+				reg =3D <0x0 0x1e000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				clocks =3D <&clkc CLKID_I2C>;
+			};
+
+			i2c0: i2c@1f000 {
+				compatible =3D "amlogic,meson-axg-i2c";
+				status =3D "disabled";
+				reg =3D <0x0 0x1f000 0x0 0x20>;
+				interrupts =3D <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				clocks =3D <&clkc CLKID_I2C>;
+			};
+
+			clk_msr: clock-measure@18000 {
+				compatible =3D "amlogic,meson-g12a-clk-measure";
+				reg =3D <0x0 0x18000 0x0 0x10>;
+			};
+
+			uart_C: serial@22000 {
+				compatible =3D "amlogic,meson-gx-uart";
+				reg =3D <0x0 0x22000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+
+			uart_B: serial@23000 {
+				compatible =3D "amlogic,meson-gx-uart";
+				reg =3D <0x0 0x23000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+
+			uart_A: serial@24000 {
+				compatible =3D "amlogic,meson-gx-uart";
+				reg =3D <0x0 0x24000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+		};
+
+		sd_emmc_a: sd@ffe03000 {
+			compatible =3D "amlogic,meson-axg-mmc";
+			reg =3D <0x0 0xffe03000 0x0 0x800>;
+			interrupts =3D <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+			clocks =3D <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names =3D "core", "clkin0", "clkin1";
+			resets =3D <&reset RESET_SD_EMMC_A>;
+		};
+
+		sd_emmc_b: sd@ffe05000 {
+			compatible =3D "amlogic,meson-axg-mmc";
+			reg =3D <0x0 0xffe05000 0x0 0x800>;
+			interrupts =3D <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+			clocks =3D <&clkc CLKID_SD_EMMC_B>,
+				 <&clkc CLKID_SD_EMMC_B_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names =3D "core", "clkin0", "clkin1";
+			resets =3D <&reset RESET_SD_EMMC_B>;
+		};
+
+		sd_emmc_c: mmc@ffe07000 {
+			compatible =3D "amlogic,meson-axg-mmc";
+			reg =3D <0x0 0xffe07000 0x0 0x800>;
+			interrupts =3D <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+			clocks =3D <&clkc CLKID_SD_EMMC_C>,
+				 <&clkc CLKID_SD_EMMC_C_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names =3D "core", "clkin0", "clkin1";
+			resets =3D <&reset RESET_SD_EMMC_C>;
+		};
+
+		usb: usb@ffe09000 {
+			status =3D "disabled";
+			compatible =3D "amlogic,meson-g12a-usb-ctrl";
+			reg =3D <0x0 0xffe09000 0x0 0xa0>;
+			interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+
+			clocks =3D <&clkc CLKID_USB>;
+			resets =3D <&reset RESET_USB>;
+
+			dr_mode =3D "otg";
+
+			phys =3D <&usb2_phy0>, <&usb2_phy1>,
+			       <&usb3_pcie_phy PHY_TYPE_USB3>;
+			phy-names =3D "usb2-phy0", "usb2-phy1", "usb3-phy0";
+
+			dwc2: usb@ff400000 {
+				compatible =3D "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg =3D <0x0 0xff400000 0x0 0x40000>;
+				interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clkc CLKID_USB1_DDR_BRIDGE>;
+				clock-names =3D "ddr";
+				phys =3D <&usb2_phy1>;
+				phy-names =3D "usb2-phy";
+				dr_mode =3D "peripheral";
+				g-rx-fifo-size =3D <192>;
+				g-np-tx-fifo-size =3D <128>;
+				g-tx-fifo-size =3D <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff500000 {
+				compatible =3D "snps,dwc3";
+				reg =3D <0x0 0xff500000 0x0 0x100000>;
+				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode =3D "host";
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment;
+			};
+		};
+
+		mali: gpu@ffe40000 {
+			compatible =3D "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+			reg =3D <0x0 0xffe40000 0x0 0x40000>;
+			interrupt-parent =3D <&gic>;
+			interrupts =3D <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "gpu", "mmu", "job";
+			clocks =3D <&clkc CLKID_MALI>;
+			resets =3D <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+
+			/*
+			 * Mali clocking is provided by two identical clock paths
+			 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+			 * free mux to safely change frequency while running.
+			 */
+			assigned-clocks =3D <&clkc CLKID_MALI_0_SEL>,
+					  <&clkc CLKID_MALI_0>,
+					  <&clkc CLKID_MALI>; /* Glitch free mux */
+			assigned-clock-parents =3D <&clkc CLKID_FCLK_DIV2P5>,
+						 <0>, /* Do Nothing */
+						 <&clkc CLKID_MALI_0>;
+			assigned-clock-rates =3D <0>, /* Do Nothing */
+					       <800000000>,
+					       <0>; /* Do Nothing */
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,no-tick-in-suspend;
+	};
+
+	xtal: xtal-clk {
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <24000000>;
+		clock-output-names =3D "xtal";
+		#clock-cells =3D <0>;
+	};
+
+};
diff --git a/arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts b/arch/arm/dts=
/meson-g12b-a311d-khadas-vim3.dts
new file mode 100644
index 0000000000..73128ed243
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-a311d.dtsi"
+#include "meson-g12b-khadas-vim3.dtsi"
+
+/ {
+	compatible =3D "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
+};
diff --git a/arch/arm/dts/meson-g12b-a311d.dtsi b/arch/arm/dts/meson-g12b=
-a311d.dtsi
new file mode 100644
index 0000000000..d61f43052a
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-a311d.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12b.dtsi"
+
+/ {
+	cpu_opp_table_0: opp-table-0 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz =3D /bits/ 64 <100000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz =3D /bits/ 64 <250000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz =3D /bits/ 64 <500000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz =3D /bits/ 64 <667000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz =3D /bits/ 64 <1000000000>;
+			opp-microvolt =3D <761000>;
+		};
+
+		opp-1200000000 {
+			opp-hz =3D /bits/ 64 <1200000000>;
+			opp-microvolt =3D <781000>;
+		};
+
+		opp-1398000000 {
+			opp-hz =3D /bits/ 64 <1398000000>;
+			opp-microvolt =3D <811000>;
+		};
+
+		opp-1512000000 {
+			opp-hz =3D /bits/ 64 <1512000000>;
+			opp-microvolt =3D <861000>;
+		};
+
+		opp-1608000000 {
+			opp-hz =3D /bits/ 64 <1608000000>;
+			opp-microvolt =3D <901000>;
+		};
+
+		opp-1704000000 {
+			opp-hz =3D /bits/ 64 <1704000000>;
+			opp-microvolt =3D <951000>;
+		};
+
+		opp-1800000000 {
+			opp-hz =3D /bits/ 64 <1800000000>;
+			opp-microvolt =3D <1001000>;
+		};
+	};
+
+	cpub_opp_table_1: opp-table-1 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz =3D /bits/ 64 <100000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz =3D /bits/ 64 <250000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz =3D /bits/ 64 <500000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz =3D /bits/ 64 <667000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz =3D /bits/ 64 <1000000000>;
+			opp-microvolt =3D <731000>;
+		};
+
+		opp-1200000000 {
+			opp-hz =3D /bits/ 64 <1200000000>;
+			opp-microvolt =3D <751000>;
+		};
+
+		opp-1398000000 {
+			opp-hz =3D /bits/ 64 <1398000000>;
+			opp-microvolt =3D <771000>;
+		};
+
+		opp-1512000000 {
+			opp-hz =3D /bits/ 64 <1512000000>;
+			opp-microvolt =3D <771000>;
+		};
+
+		opp-1608000000 {
+			opp-hz =3D /bits/ 64 <1608000000>;
+			opp-microvolt =3D <781000>;
+		};
+
+		opp-1704000000 {
+			opp-hz =3D /bits/ 64 <1704000000>;
+			opp-microvolt =3D <791000>;
+		};
+
+		opp-1800000000 {
+			opp-hz =3D /bits/ 64 <1800000000>;
+			opp-microvolt =3D <831000>;
+		};
+
+                opp-1908000000 {
+                        opp-hz =3D /bits/ 64 <1908000000>;
+                        opp-microvolt =3D <861000>;
+                };
+
+                opp-2016000000 {
+                        opp-hz =3D /bits/ 64 <2016000000>;
+                        opp-microvolt =3D <911000>;
+                };
+
+                opp-2108000000 {
+                        opp-hz =3D /bits/ 64 <2108000000>;
+                        opp-microvolt =3D <951000>;
+                };
+
+                opp-2208000000 {
+                        opp-hz =3D /bits/ 64 <2208000000>;
+                        opp-microvolt =3D <1011000>;
+                };
+	};
+};
diff --git a/arch/arm/dts/meson-g12b-khadas-vim3.dtsi b/arch/arm/dts/meso=
n-g12b-khadas-vim3.dtsi
new file mode 100644
index 0000000000..9c3ca2edc7
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-khadas-vim3.dtsi
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	model =3D "Khadas VIM3";
+
+	aliases {
+		serial0 =3D &uart_AO;
+		ethernet0 =3D &ethmac;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x0 0x0 0x80000000>;
+	};
+
+	adc-keys {
+		compatible =3D "adc-keys";
+		io-channels =3D <&saradc 2>;
+		io-channel-names =3D "buttons";
+		keyup-threshold-microvolt =3D <1710000>;
+
+		button-function {
+			label =3D "Function";
+			linux,code =3D <KEY_FN>;
+			press-threshold-microvolt =3D <10000>;
+		};
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+
+		white {
+			label =3D "vim3:white:sys";
+			gpios =3D <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger =3D "heartbeat";
+		};
+
+		red {
+			label =3D "vim3:red";
+			gpios =3D <&gpio_expander 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible =3D "mmc-pwrseq-emmc";
+		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	gpio-keys-polled {
+		compatible =3D "gpio-keys-polled";
+		poll-interval =3D <100>;
+
+		power-button {
+			label =3D "power";
+			linux,code =3D <KEY_POWER>;
+			gpios =3D <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks =3D <&wifi32k>;
+		clock-names =3D "ext_clock";
+	};
+
+	dc_in: regulator-dc_in {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "DC_IN";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC_5V";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		vin-supply =3D <&dc_in>;
+
+		gpio =3D <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC_1V8";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		vin-supply =3D <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		vin-supply =3D <&vsys_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vddcpu_a: regulator-vddcpu-a {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible =3D "pwm-regulator";
+
+		regulator-name =3D "VDDCPU_A";
+		regulator-min-microvolt =3D <690000>;
+		regulator-max-microvolt =3D <1050000>;
+
+		vin-supply =3D <&dc_in>;
+
+		pwms =3D <&pwm_ab 0 1250 0>;
+		pwm-dutycycle-range =3D <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddcpu_b: regulator-vddcpu-b {
+		/*
+		 * Silergy SY8030DEC Regulator.
+		 */
+		compatible =3D "pwm-regulator";
+
+		regulator-name =3D "VDDCPU_B";
+		regulator-min-microvolt =3D <690000>;
+		regulator-max-microvolt =3D <1050000>;
+
+		vin-supply =3D <&vsys_3v3>;
+
+		pwms =3D <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range =3D <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDIO_AO1V8";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		vin-supply =3D <&vsys_3v3>;
+		regulator-always-on;
+	};
+
+	emmc_1v8: regulator-emmc_1v8 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "EMMC_AO1V8";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		vin-supply =3D <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vsys_3v3: regulator-vsys_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VSYS_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		vin-supply =3D <&dc_in>;
+		regulator-always-on;
+	};
+
+	usb_pwr: regulator-usb_pwr {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "USB_PWR";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		vin-supply =3D <&vcc_5v>;
+
+		gpio =3D <&gpio GPIOA_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	hdmi-connector {
+		compatible =3D "hdmi-connector";
+		type =3D "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint =3D <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	wifi32k: wifi32k {
+		compatible =3D "pwm-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	sound {
+		compatible =3D "amlogic,axg-sound-card";
+		model =3D "G12A-KHADAS-VIM3";
+		audio-aux-devs =3D <&tdmout_b>;
+		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks =3D <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents =3D <0>, <0>, <0>;
+		assigned-clock-rates =3D <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status =3D "okay";
+
+		dai-link-0 {
+			sound-dai =3D <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai =3D <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai =3D <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai =3D <&tdmif_b>;
+			dai-format =3D "i2s";
+			dai-tdm-slot-tx-mask-0 =3D <1 1>;
+			dai-tdm-slot-tx-mask-1 =3D <1 1>;
+			dai-tdm-slot-tx-mask-2 =3D <1 1>;
+			dai-tdm-slot-tx-mask-3 =3D <1 1>;
+			mclk-fs =3D <256>;
+
+			codec {
+				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai =3D <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status =3D "okay";
+};
+
+&cec_AO {
+	pinctrl-0 =3D <&cec_ao_a_h_pins>;
+	pinctrl-names =3D "default";
+	status =3D "disabled";
+	hdmi-phandle =3D <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 =3D <&cec_ao_b_h_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+	hdmi-phandle =3D <&hdmi_tx>;
+};
+
+&clkc_audio {
+	status =3D "okay";
+};
+
+&cpu0 {
+	cpu-supply =3D <&vddcpu_b>;
+	operating-points-v2 =3D <&cpu_opp_table_0>;
+	clocks =3D <&clkc CLKID_CPU_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&cpu1 {
+	cpu-supply =3D <&vddcpu_b>;
+	operating-points-v2 =3D <&cpu_opp_table_0>;
+	clocks =3D <&clkc CLKID_CPU_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&cpu100 {
+	cpu-supply =3D <&vddcpu_a>;
+	operating-points-v2 =3D <&cpub_opp_table_1>;
+	clocks =3D <&clkc CLKID_CPUB_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&cpu101 {
+	cpu-supply =3D <&vddcpu_a>;
+	operating-points-v2 =3D <&cpub_opp_table_1>;
+	clocks =3D <&clkc CLKID_CPUB_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&cpu102 {
+	cpu-supply =3D <&vddcpu_a>;
+	operating-points-v2 =3D <&cpub_opp_table_1>;
+	clocks =3D <&clkc CLKID_CPUB_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&cpu103 {
+	cpu-supply =3D <&vddcpu_a>;
+	operating-points-v2 =3D <&cpub_opp_table_1>;
+	clocks =3D <&clkc CLKID_CPUB_CLK>;
+	clock-latency =3D <50000>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg =3D <0>;
+		max-speed =3D <1000>;
+
+		interrupt-parent =3D <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ethmac {
+        pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
+        pinctrl-names =3D "default";
+        status =3D "okay";
+        phy-mode =3D "rgmii";
+        phy-handle =3D <&external_phy>;
+        amlogic,tx-delay-ns =3D <2>;
+};
+
+&frddr_a {
+	status =3D "okay";
+};
+
+&frddr_b {
+	status =3D "okay";
+};
+
+&frddr_c {
+	status =3D "okay";
+};
+
+&hdmi_tx {
+	status =3D "okay";
+	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names =3D "default";
+	hdmi-supply =3D <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint =3D <&hdmi_connector_in>;
+	};
+};
+
+&i2c_AO {
+	status =3D "okay";
+	pinctrl-0 =3D <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
+	pinctrl-names =3D "default";
+
+	gpio_expander: gpio-controller@20 {
+		compatible =3D "ti,tca6408";
+		reg =3D <0x20>;
+		vcc-supply =3D <&vcc_3v3>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+	};
+
+	rtc@51 {
+		compatible =3D "haoyu,hym8563";
+		reg =3D <0x51>;
+		#clock-cells =3D <0>;
+	};
+};
+
+&ir {
+	status =3D "okay";
+	pinctrl-0 =3D <&remote_input_ao_pins>;
+	pinctrl-names =3D "default";
+	linux,rc-map-name =3D "rc-khadas";
+};
+
+&pwm_ab {
+	pinctrl-0 =3D <&pwm_a_e_pins>;
+	pinctrl-names =3D "default";
+	clocks =3D <&xtal>;
+	clock-names =3D "clkin0";
+	status =3D "okay";
+};
+
+&pwm_AO_cd {
+	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
+	pinctrl-names =3D "default";
+	clocks =3D <&xtal>;
+	clock-names =3D "clkin1";
+	status =3D "okay";
+};
+
+&pwm_ef {
+        status =3D "okay";
+        pinctrl-0 =3D <&pwm_e_pins>;
+        pinctrl-names =3D "default";
+};
+
+&saradc {
+	status =3D "okay";
+	vref-supply =3D <&vddao_1v8>;
+};
+
+/* SDIO */
+&sd_emmc_a {
+	status =3D "okay";
+	pinctrl-0 =3D <&sdio_pins>;
+	pinctrl-1 =3D <&sdio_clk_gate_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	max-frequency =3D <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq =3D <&sdio_pwrseq>;
+
+	vmmc-supply =3D <&vsys_3v3>;
+	vqmmc-supply =3D <&vddao_1v8>;
+
+	brcmf: wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD card */
+&sd_emmc_b {
+	status =3D "okay";
+	pinctrl-0 =3D <&sdcard_c_pins>;
+	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	max-frequency =3D <50000000>;
+	disable-wp;
+
+	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply =3D <&vsys_3v3>;
+	vqmmc-supply =3D <&vsys_3v3>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status =3D "okay";
+	pinctrl-0 =3D <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 =3D <&emmc_clk_gate_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+
+	bus-width =3D <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency =3D <200000000>;
+	disable-wp;
+
+	mmc-pwrseq =3D <&emmc_pwrseq>;
+	vmmc-supply =3D <&vcc_3v3>;
+	vqmmc-supply =3D <&emmc_1v8>;
+};
+
+&tdmif_b {
+	status =3D "okay";
+};
+
+&tdmout_b {
+	status =3D "okay";
+};
+
+&tohdmitx {
+	status =3D "okay";
+};
+
+&uart_A {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names =3D "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		shutdown-gpios =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed =3D <2000000>;
+		clocks =3D <&wifi32k>;
+		clock-names =3D "lpo";
+	};
+};
+
+&uart_AO {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_ao_a_pins>;
+	pinctrl-names =3D "default";
+};
+
+&usb2_phy0 {
+	phy-supply =3D <&dc_in>;
+};
+
+&usb2_phy1 {
+	phy-supply =3D <&usb_pwr>;
+};
+
+&usb3_pcie_phy {
+	phy-supply =3D <&usb_pwr>;
+};
+
+&usb {
+	status =3D "okay";
+	dr_mode =3D "peripheral";
+};
diff --git a/arch/arm/dts/meson-g12b.dtsi b/arch/arm/dts/meson-g12b.dtsi
index 9e88e513b2..5628ccd545 100644
--- a/arch/arm/dts/meson-g12b.dtsi
+++ b/arch/arm/dts/meson-g12b.dtsi
@@ -4,12 +4,16 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
=20
-#include "meson-g12a.dtsi"
+#include "meson-g12-common.dtsi"
+#include <dt-bindings/power/meson-g12a-power.h>
=20
 / {
 	compatible =3D "amlogic,g12b";
=20
 	cpus {
+		#address-cells =3D <0x2>;
+		#size-cells =3D <0x0>;
+
 		cpu-map {
 			cluster0 {
 				core0 {
@@ -40,8 +44,21 @@
 			};
 		};
=20
-		/delete-node/ cpu@2;
-		/delete-node/ cpu@3;
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x0>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x1>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
=20
 		cpu100: cpu@100 {
 			device_type =3D "cpu";
@@ -74,9 +91,25 @@
 			enable-method =3D "psci";
 			next-level-cache =3D <&l2>;
 		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+		};
 	};
 };
=20
 &clkc {
 	compatible =3D "amlogic,g12b-clkc";
 };
+
+&ethmac {
+	power-domains =3D <&pwrc PWRC_G12A_ETH_ID>;
+};
+
+&vpu {
+	power-domains =3D <&pwrc PWRC_G12A_VPU_ID>;
+};
+
+&sd_emmc_a {
+	amlogic,dram-access-quirk;
+};
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/=
clock/g12a-clkc.h
index b6b127e456..0837c1a7ae 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -137,5 +137,11 @@
 #define CLKID_VDEC_HEVC				207
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
+#define CLKID_CPUB_CLK				224
+#define CLKID_GP1_PLL				243
+#define CLKID_DSU_CLK				252
+#define CLKID_CPU1_CLK				253
+#define CLKID_CPU2_CLK				254
+#define CLKID_CPU3_CLK				255
=20
 #endif /* __G12A_CLKC_H */
diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bi=
ndings/power/meson-g12a-power.h
new file mode 100644
index 0000000000..bb5e67a842
--- /dev/null
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_G12A_POWER_H
+#define _DT_BINDINGS_MESON_G12A_POWER_H
+
+#define PWRC_G12A_VPU_ID		0
+#define PWRC_G12A_ETH_ID		1
+
+#endif
diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h b=
/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
new file mode 100644
index 0000000000..14b78dabed
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
+
+#define AUD_RESET_PDM		0
+#define AUD_RESET_TDMIN_A	1
+#define AUD_RESET_TDMIN_B	2
+#define AUD_RESET_TDMIN_C	3
+#define AUD_RESET_TDMIN_LB	4
+#define AUD_RESET_LOOPBACK	5
+#define AUD_RESET_TODDR_A	6
+#define AUD_RESET_TODDR_B	7
+#define AUD_RESET_TODDR_C	8
+#define AUD_RESET_FRDDR_A	9
+#define AUD_RESET_FRDDR_B	10
+#define AUD_RESET_FRDDR_C	11
+#define AUD_RESET_TDMOUT_A	12
+#define AUD_RESET_TDMOUT_B	13
+#define AUD_RESET_TDMOUT_C	14
+#define AUD_RESET_SPDIFOUT	15
+#define AUD_RESET_SPDIFOUT_B	16
+#define AUD_RESET_SPDIFIN	17
+#define AUD_RESET_EQDRC		18
+#define AUD_RESET_RESAMPLE	19
+#define AUD_RESET_DDRARB	20
+#define AUD_RESET_POWDET	21
+#define AUD_RESET_TORAM		22
+#define AUD_RESET_TOACODEC	23
+#define AUD_RESET_TOHDMITX	24
+#define AUD_RESET_CLKTREE	25
+
+#endif
--=20
2.16.4

