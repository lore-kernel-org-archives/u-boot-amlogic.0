Received: by mail-wr1-f66.google.com with SMTP id l2so19259886wrb.9
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8SJWFuZ8HCsNEG+e3z6v9xNlw0hIcRt++7LJMm78AY=;
        b=lflJYwuIk88aQeMCqWx8NrGj6UcLW1yq7bB+YS/CAwFZDgyRrbmj4Hlw5h3sfGUQQt
         MVrbU7RqCIlsZobrjvdgZQeY5X8daeJQdV2lZtLbI5tqkHOICXrCvU/RtKCgdZn0U7kS
         G1p3EtEpdE9K3LoV4I9RkvTC3pwZkiuY4rV4nA/7x+J2yxqA8AvUl4tih3u/Un784kZf
         R39c+/lMnOyVsCGJGuQnFlVkicE2GRRq9bswlNAloNnL/buiWSUAJTpMASqkJcmeoMBr
         6H05D2yi7SAz6DY/AbgIAfyiOrs52uOTPMOFg/A38DelyC4piXGKgcANzPdwo678r8xz
         JD7w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] ARM: dts: Add missing DT for Meson G12A support
Date: Tue, 28 May 2019 10:50:38 +0200
Message-Id: <20190528085038.8088-4-narmstrong@baylibre.com>
In-Reply-To: <20190528085038.8088-1-narmstrong@baylibre.com>
References: <20190528085038.8088-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The following DT nodes in the process on review for Linux 5.3,
until Linux 5.3 is tagged, add the missing DT nodes in u-boot specific
DTSI files that will be dropped when the v5.3-rc1 DT is synced again.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12a-u-boot.dtsi      | 216 +++++++++++++++++++++++
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi |  63 +++++++
 2 files changed, 279 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12a-u-boot.dtsi b/arch/arm/dts/meson-g12a-u-boot.dtsi
new file mode 100644
index 0000000000..5065d8b65a
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-u-boot.dtsi
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Maxime Jourdan <mjourdan@baylibre.com>
+ */
+
+/ {
+	soc {
+		ethmac: ethernet@ff3f0000 {
+			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac-3.710",
+				     "snps,dwmac";
+			reg = <0x0 0xff3f0000 0x0 0x10000
+			       0x0 0xff634540 0x0 0x8>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clkc CLKID_ETH>,
+				 <&clkc CLKID_FCLK_DIV2>,
+				 <&clkc CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
+			status = "disabled";
+
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
+
+		sd_emmc_a: sd@ffe03000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe03000 0x0 0x800>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_A>;
+		};
+
+		sd_emmc_b: sd@ffe05000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe05000 0x0 0x800>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_B>,
+				 <&clkc CLKID_SD_EMMC_B_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_B>;
+		};
+
+		sd_emmc_c: mmc@ffe07000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe07000 0x0 0x800>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_C>,
+				 <&clkc CLKID_SD_EMMC_C_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_C>;
+		};
+	};
+};
+
+&periphs_pinctrl {
+	emmc_pins: emmc {
+		mux {
+			groups = "emmc_nand_d0",
+				 "emmc_nand_d1",
+				 "emmc_nand_d2",
+				 "emmc_nand_d3",
+				 "emmc_nand_d4",
+				 "emmc_nand_d5",
+				 "emmc_nand_d6",
+				 "emmc_nand_d7",
+				 "emmc_clk",
+				 "emmc_cmd";
+			function = "emmc";
+			bias-pull-up;
+		};
+	};
+
+	emmc_ds_pins: emmc-ds {
+		mux {
+			groups = "emmc_nand_ds";
+			function = "emmc";
+			bias-pull-down;
+		};
+	};
+
+	emmc_clk_gate_pins: emmc_clk_gate {
+		mux {
+			groups = "BOOT_8";
+			function = "gpio_periphs";
+			bias-pull-down;
+		};
+	};
+
+	eth_leds_pins: eth-leds {
+		mux {
+			groups = "eth_link_led",
+				 "eth_act_led";
+			function = "eth";
+			bias-disable;
+		};
+	};
+
+	eth_rmii_pins: eth-rmii {
+		mux {
+			groups = "eth_mdio",
+				 "eth_mdc",
+				 "eth_rgmii_rx_clk",
+				 "eth_rx_dv",
+				 "eth_rxd0",
+				 "eth_rxd1",
+				 "eth_txen",
+				 "eth_txd0",
+				 "eth_txd1";
+			function = "eth";
+			bias-disable;
+		};
+	};
+
+	eth_rgmii_pins: eth-rgmii {
+		mux {
+			groups = "eth_rxd2_rgmii",
+				 "eth_rxd3_rgmii",
+				 "eth_rgmii_tx_clk",
+				 "eth_txd2_rgmii",
+				 "eth_txd3_rgmii";
+			function = "eth";
+			bias-disable;
+		};
+	};
+
+	sdcard_c_pins: sdcard_c {
+		mux {
+			groups = "sdcard_d0_c",
+				 "sdcard_d1_c",
+				 "sdcard_d2_c",
+				 "sdcard_d3_c",
+				 "sdcard_cmd_c",
+				 "sdcard_clk_c";
+			function = "sdcard";
+			bias-pull-up;
+		};
+	};
+
+	sdcard_clk_gate_c_pins: sdcard_clk_gate_c {
+		mux {
+			groups = "GPIOC_4";
+			function = "gpio_periphs";
+			bias-pull-down;
+		};
+	};
+
+	sdcard_z_pins: sdcard_z {
+		mux {
+			groups = "sdcard_d0_z",
+				 "sdcard_d1_z",
+				 "sdcard_d2_z",
+				 "sdcard_d3_z",
+				 "sdcard_cmd_z",
+				 "sdcard_clk_z";
+			function = "sdcard";
+			bias-pull-up;
+		};
+	};
+
+	sdcard_clk_gate_z_pins: sdcard_clk_gate_z {
+		mux {
+			groups = "GPIOZ_6";
+			function = "gpio_periphs";
+			bias-pull-down;
+		};
+	};
+};
+
+&periphs {
+	eth_phy: mdio-multiplexer@4c000 {
+		compatible = "amlogic,g12a-mdio-mux";
+		reg = <0x0 0x4c000 0x0 0xa4>;
+		clocks = <&clkc CLKID_ETH_PHY>,
+			 <&xtal>,
+			 <&clkc CLKID_MPLL_5OM>;
+		clock-names = "pclk", "clkin0", "clkin1";
+		mdio-parent-bus = <&mdio0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ext_mdio: mdio@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		int_mdio: mdio@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			internal_ephy: ethernet_phy@8 {
+				compatible = "ethernet-phy-id0180.3300",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <8>;
+				max-speed = <100>;
+
+				/* FIXME: Add irq support */
+			};
+		};
+	};
+};
+
+
diff --git a/arch/arm/dts/meson-g12a-u200-u-boot.dtsi b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
new file mode 100644
index 0000000000..9486ab0c47
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12a-u-boot.dtsi"
+
+ / {
+	aliases {
+		ethernet0 = &ethmac;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_leds_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "rmii";
+};
+
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
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_3v3>;
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
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
-- 
2.21.0

