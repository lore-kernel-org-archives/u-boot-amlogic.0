Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.17579.1599727707436490663
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:27 -0700
Received: by mail-wr1-f66.google.com with SMTP id a17so5769143wrn.6
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5asj/zwRTcV60D0MGQlvBlaWAORoYlswDz/jG2Wv7S0=;
        b=izjis9BAoyD8ntqVuxw9THreF8dSsaq45TNn7xRM8W+jdD8NaM7mwJDaUrG323Ufls
         pIn8AuHsNBrfK2PMcuWrxaSSw/Nt6NjG0ozLHIQ5nPyn7WG0PLeJaJMErA/nFELWumfy
         G5u99r5HMi+IF5S+YaFN7zspQTHBu99g/DZW9j8qs4SaPl/6xdEzrhfMKUYZgvU9rn4z
         le0bu6LJ0nT4w9UZtvblkknbW+N38dP/1jLZ6m4XpV8leT2OntuwWuOAX44d5994GoHS
         jiNyebdkk+XN8lyIGmlULvODj2NizpHjd32X8L+ZgixqxAqhmrX28Jia5zhRIO+GWthn
         E3yg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/8] ARM: dts: sync amlogic AXG/GXL/GXM DT from Linux 5.8-rc1
Date: Thu, 10 Sep 2020 10:48:12 +0200
Message-Id: <20200910084819.25312-2-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This imports the AXG, GXL & GXM SoC and boards DT changes from the Linux
commit b3a9e3b9622a ("Linux 5.8-rc1").

This change also removes GXL & GXM u-boot.dtsi hacks for USB gadget.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-axg.dtsi                   |  6 +-
 arch/arm/dts/meson-gx-libretech-pc.dtsi       | 78 +++++++++++++++++-
 arch/arm/dts/meson-gx.dtsi                    | 23 ++++--
 arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  2 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts          |  2 +-
 arch/arm/dts/meson-gxbb.dtsi                  | 23 ++++++
 .../meson-gxl-s805x-libretech-ac-u-boot.dtsi  |  4 -
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 73 ++++++++++++++++-
 .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |  4 -
 .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    |  4 -
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  4 +
 .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  |  4 -
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts | 77 +++++++++++++++++-
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        |  3 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi            | 16 ----
 arch/arm/dts/meson-gxl.dtsi                   | 79 ++++++++++++++-----
 .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi |  4 -
 arch/arm/dts/meson-gxm-khadas-vim2.dts        |  3 +-
 .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |  4 -
 arch/arm/dts/meson-gxm.dtsi                   |  7 +-
 .../reset/amlogic,meson-gxbb-reset.h          |  2 +-
 include/dt-bindings/sound/meson-aiu.h         | 18 +++++
 22 files changed, 358 insertions(+), 82 deletions(-)
 create mode 100644 include/dt-bindings/sound/meson-aiu.h

diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
index aace3d32a3..8e6281c685 100644
--- a/arch/arm/dts/meson-axg.dtsi
+++ b/arch/arm/dts/meson-axg.dtsi
@@ -1735,18 +1735,18 @@
 		};
 
 		sram: sram@fffc0000 {
-			compatible = "amlogic,meson-axg-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xfffc0000 0x0 0x20000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xfffc0000 0x20000>;
 
-			cpu_scp_lpri: scp-shmem@13000 {
+			cpu_scp_lpri: scp-sram@13000 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@13400 {
+			cpu_scp_hpri: scp-sram@13400 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
diff --git a/arch/arm/dts/meson-gx-libretech-pc.dtsi b/arch/arm/dts/meson-gx-libretech-pc.dtsi
index 248b018c83..c2480bab8d 100644
--- a/arch/arm/dts/meson-gx-libretech-pc.dtsi
+++ b/arch/arm/dts/meson-gx-libretech-pc.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	adc-keys {
@@ -29,6 +30,13 @@
 		spi0 = &spifc;
 	};
 
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&vcc5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -96,14 +104,14 @@
 	leds {
 		compatible = "gpio-leds";
 
-		green {
+		led-green {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 		};
 
-		blue {
+		led-blue {
 			color = <LED_COLOR_ID_BLUE>;
 			function = LED_FUNCTION_STATUS;
 			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
@@ -175,6 +183,69 @@
 		regulator-settling-time-up-us = <200>;
 		regulator-settling-time-down-us = <50000>;
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-LIBRETECH-S9XX-PC";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Speaker", "7J4-14 LEFT",
+				"Speaker", "7J4-11 RIGHT";
+		audio-routing = "AU2 INL", "ACODEC LOLN",
+				"AU2 INR", "ACODEC LORN",
+				"7J4-14 LEFT", "AU2 OUTL",
+				"7J4-11 RIGHT", "AU2 OUTR";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
@@ -360,8 +431,9 @@
 	status = "okay";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm/dts/meson-gx.dtsi b/arch/arm/dts/meson-gx.dtsi
index 03f79fe045..ba63c36b22 100644
--- a/arch/arm/dts/meson-gx.dtsi
+++ b/arch/arm/dts/meson-gx.dtsi
@@ -278,6 +278,17 @@
 				#reset-cells = <1>;
 			};
 
+			aiu: audio-controller@5400 {
+				compatible = "amlogic,aiu";
+				#sound-dai-cells = <2>;
+				sound-name-prefix = "AIU";
+				reg = <0x0 0x5400 0x0 0x2ac>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "i2s", "spdif";
+				status = "disabled";
+			};
+
 			uart_A: serial@84c0 {
 				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84c0 0x0 0x18>;
@@ -398,20 +409,20 @@
 		};
 
 		sram: sram@c8000000 {
-			compatible = "amlogic,meson-gx-sram", "amlogic,meson-gxbb-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xc8000000 0x0 0x14000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xc8000000 0x14000>;
 
-			cpu_scp_lpri: scp-shmem@0 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_lpri: scp-sram@0 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@200 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_hpri: scp-sram@200 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
 		};
@@ -626,6 +637,8 @@
 			interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "HDMITX";
 			status = "disabled";
 
 			/* VPU VENC Input */
diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
index d6ca684e0e..7be3e35409 100644
--- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
@@ -29,7 +29,7 @@
 	leds {
 		compatible = "gpio-leds";
 
-		stat {
+		led-stat {
 			label = "nanopi-k2:blue:stat";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
index b46ef985bb..70fcfb7b06 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2.dts
+++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
@@ -49,7 +49,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		blue {
+		led-blue {
 			label = "c2:blue:alive";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/dts/meson-gxbb.dtsi b/arch/arm/dts/meson-gxbb.dtsi
index 0cb40326b0..234490d3ee 100644
--- a/arch/arm/dts/meson-gxbb.dtsi
+++ b/arch/arm/dts/meson-gxbb.dtsi
@@ -60,6 +60,29 @@
 	};
 };
 
+&aiu {
+	compatible = "amlogic,aiu-gxbb", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &aobus {
 	pinctrl_aobus: pinctrl@14 {
 		compatible = "amlogic,meson-gxbb-aobus-pinctrl";
diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
index 474a3e1604..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
@@ -5,7 +5,3 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
-
-&dwc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
index 4d59494965..6a226faab1 100644
--- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 #include "meson-gxl-s905x.dtsi"
 
@@ -97,6 +98,15 @@
 		regulator-always-on;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
@@ -105,6 +115,66 @@
 		vin-supply = <&vcc_3v3>;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-LIBRETECH-S805X-AC";
+		audio-widgets = "Speaker", "9J5-3 LEFT",
+				"Speaker", "9J5-2 RIGHT";
+		audio-routing = "9J5-3 LEFT", "ACODEC LOLN",
+				"9J5-2 RIGHT", "ACODEC LORN";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
@@ -243,6 +313,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
index 474a3e1604..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
@@ -5,7 +5,3 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
-
-&dwc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
index 474a3e1604..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
@@ -5,7 +5,3 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
-
-&dwc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
index 440bc23c73..8bcdffdf55 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
@@ -207,3 +207,7 @@
 	pinctrl-0 = <&uart_ao_b_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
index 474a3e1604..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
@@ -5,7 +5,3 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
-
-&dwc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
index e8348b2728..5ae7bb6209 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 #include "meson-gxl-s905x.dtsi"
 
@@ -21,6 +22,13 @@
 		ethernet0 = &ethmac;
 	};
 
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&hdmi_5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -54,14 +62,14 @@
 	leds {
 		compatible = "gpio-leds";
 
-		system {
+		led-system {
 			label = "librecomputer:system-status";
 			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			panic-indicator;
 		};
 
-		blue {
+		led-blue {
 			label = "librecomputer:blue";
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
@@ -124,6 +132,68 @@
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vcc_3v3>;
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-LIBRETECH-S905X-CC";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Line", "Lineout";
+		audio-routing = "AU2 INL", "ACODEC LOLN",
+				"AU2 INR", "ACODEC LORN",
+				"Lineout", "AU2 OUTL",
+				"Lineout", "AU2 OUTR";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
@@ -272,8 +342,9 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
index 6ac678f88b..05cb2f5e5c 100644
--- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
@@ -195,8 +195,9 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm/dts/meson-gxl-u-boot.dtsi b/arch/arm/dts/meson-gxl-u-boot.dtsi
index 9e88afd30e..c35158d7e9 100644
--- a/arch/arm/dts/meson-gxl-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-u-boot.dtsi
@@ -5,19 +5,3 @@
  */
 
 #include "meson-gx-u-boot.dtsi"
-
-&usb0 {
-	dwc2: usb@c9100000 {
-		compatible = "snps,dwc2";
-		reg = <0x0 0xc9100000 0x0 0x40000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
-		clock-names = "ddr";
-		phys = <&usb3_phy>, <&usb2_phy1>;
-		dr_mode = "peripheral";
-		g-rx-fifo-size = <192>;
-		g-np-tx-fifo-size = <128>;
-		g-tx-fifo-size = <128 128 16 16 16>;
-		status = "disabled";
-	};
-};
diff --git a/arch/arm/dts/meson-gxl.dtsi b/arch/arm/dts/meson-gxl.dtsi
index 259d863993..fc59c8534c 100644
--- a/arch/arm/dts/meson-gxl.dtsi
+++ b/arch/arm/dts/meson-gxl.dtsi
@@ -14,29 +14,57 @@
 	compatible = "amlogic,meson-gxl";
 
 	soc {
-		usb0: usb@c9000000 {
-			status = "disabled";
-			compatible = "amlogic,meson-gxl-dwc3";
+		usb: usb@d0078080 {
+			compatible = "amlogic,meson-gxl-usb-ctrl";
+			reg = <0x0 0xd0078080 0x0 0x20>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 
-			clocks = <&clkc CLKID_USB>;
-			clock-names = "usb_general";
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "usb_ctrl", "ddr";
 			resets = <&reset RESET_USB_OTG>;
-			reset-names = "usb_otg";
 
-			dwc3: dwc3@c9000000 {
+			dr_mode = "otg";
+
+			phys = <&usb2_phy0>, <&usb2_phy1>;
+			phy-names = "usb2-phy0", "usb2-phy1";
+
+			dwc2: usb@c9100000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xc9100000 0x0 0x40000>;
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
+			dwc3: usb@c9000000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xc9000000 0x0 0x100000>;
 				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				maximum-speed = "high-speed";
 				snps,dis_u2_susphy_quirk;
-				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
 			};
 		};
 
+		acodec: audio-controller@c8832000 {
+			compatible = "amlogic,t9015";
+			reg = <0x0 0xc8832000 0x0 0x14>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "ACODEC";
+			clocks = <&clkc CLKID_ACODEC>;
+			clock-names = "pclk";
+			resets = <&reset RESET_ACODEC>;
+			status = "disabled";
+		};
+
 		crypto: crypto@c883e000 {
 			compatible = "amlogic,gxl-crypto";
 			reg = <0x0 0xc883e000 0x0 0x36>;
@@ -49,6 +77,29 @@
 	};
 };
 
+&aiu {
+	compatible = "amlogic,aiu-gxl", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &apb {
 	usb2_phy0: phy@78000 {
 		compatible = "amlogic,meson-gxl-usb2-phy";
@@ -71,18 +122,6 @@
 		reset-names = "phy";
 		status = "okay";
 	};
-
-	usb3_phy: phy@78080 {
-		compatible = "amlogic,meson-gxl-usb3-phy";
-		#phy-cells = <0>;
-		reg = <0x0 0x78080 0x0 0x20>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clkc CLKID_USB>, <&clkc_AO CLKID_AO_CEC_32K>;
-		clock-names = "phy", "peripheral";
-		resets = <&reset RESET_USB_OTG>, <&reset RESET_USB_OTG>;
-		reset-names = "phy", "peripheral";
-		status = "okay";
-	};
 };
 
 &efuse {
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
index 7aecf2696b..c1763336cf 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
@@ -12,10 +12,6 @@
 	};
 };
 
-&dwc2 {
-	status = "okay";
-};
-
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
index 27eeab71ec..bff8ec2c1c 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
+++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
@@ -380,6 +380,7 @@
 	vref-supply = <&vddio_ao18>;
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "peripheral";
 };
diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
index 474a3e1604..39270ea71c 100644
--- a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
@@ -5,7 +5,3 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
-
-&dwc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/meson-gxm.dtsi b/arch/arm/dts/meson-gxm.dtsi
index b6f89f108e..40e3e123e0 100644
--- a/arch/arm/dts/meson-gxm.dtsi
+++ b/arch/arm/dts/meson-gxm.dtsi
@@ -169,8 +169,11 @@
 	compatible = "amlogic,meson-gxm-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
 };
 
-&dwc3 {
-	phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
+&usb {
+	compatible = "amlogic,meson-gxm-usb-ctrl";
+
+	phy-names = "usb2-phy0", "usb2-phy1", "usb2-phy2";
+	phys = <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
 };
 
 &vdec {
diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
index ea50586188..883bfd3bcb 100644
--- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
@@ -69,7 +69,7 @@
 #define RESET_SYS_CPU_L2		58
 #define RESET_SYS_CPU_P			59
 #define RESET_SYS_CPU_MBIST		60
-/*					61	*/
+#define RESET_ACODEC			61
 /*					62	*/
 /*					63	*/
 /*	RESET2					*/
diff --git a/include/dt-bindings/sound/meson-aiu.h b/include/dt-bindings/sound/meson-aiu.h
new file mode 100644
index 0000000000..1051b8af29
--- /dev/null
+++ b/include/dt-bindings/sound/meson-aiu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_MESON_AIU_H
+#define __DT_MESON_AIU_H
+
+#define AIU_CPU			0
+#define AIU_HDMI		1
+#define AIU_ACODEC		2
+
+#define CPU_I2S_FIFO		0
+#define CPU_SPDIF_FIFO		1
+#define CPU_I2S_ENCODER		2
+#define CPU_SPDIF_ENCODER	3
+
+#define CTRL_I2S		0
+#define CTRL_PCM		1
+#define CTRL_OUT		2
+
+#endif /* __DT_MESON_AIU_H */
-- 
2.22.0

