Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web08.12124.1632066750058929356
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Sep 2021 08:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632066745; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IaFZ8Z/dyLVlQswVzNXuw3FJYyiXq62TF+NwlkkZFAE=;
	b=GxUXYLoZL147841LutfKgAsbMQ16Tptl1B00J27GuJMQwhxfr4abXZAgD+1BqzEQIOnv3e
	pNni/VgxrWPYTkYgqLzOmWrgL1Ql6krrDesTVpbksw6xDEPUc/hpDsAaafL6osL4tNHcUg
	83bB8rlCjf0Wkh4VSJoUfWR2hvPhWGQ1Ew7ziFFdtYT29NAhIHoqCuLMpUkKVz5xab5MJf
	SM8pGyzZ+HsBC+BJbln/whcoKFmOpKLqEP+Kl81hcYySaP1tSETdWY8gU3yPKsUOf7RvTf
	n88OlcWlt7smGhDjF/11nB5mCbESrL8R2rJHbsT1rMJ5fqYyG0/U9OY6yzeGzA==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 2/3] ARM: amlogic: add JetHub D1/H1 device support
Date: Sun, 19 Sep 2021 18:52:15 +0300
Message-Id: <20210919155216.4000369-3-adeep@lexina.in>
In-Reply-To: <20210919155216.4000369-1-adeep@lexina.in>
References: <20210919155216.4000369-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add support for new home automation devices.

JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation cont=
roller with the following features:
- DIN Rail Mounting case
- Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 512Mb/1GB DDR3
- 8/16GB eMMC flash
- 1 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac=
, Bluetooth 4.2.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power=
 and Zigbee 3.0 support.
- 2 x gpio LEDS
- GPIO user Button
- 1 x 1-Wire
- 2 x RS-485
- 4 x dry contact digital GPIO inputs
- 3 x relay GPIO outputs
- DC source with a voltage of 9 to 56 V / Passive POE

JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation cont=
roller with the following features:
- Square plastic case
- Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 1GB DDR3
- 8/16GB eMMC flash
- 2 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power=
 and Zigbee 3.0 support.
- MicroSD 2.x/3.x/4.x DS/HS cards.
- 1 x gpio LED
- ADC user Button
- DC source 5V microUSB with serial console

Patches from:
- JetHub H1
  https://lore.kernel.org/r/20210915085715.1134940-4-adeep@lexina.in
  https://git.kernel.org/amlogic/c/abfaae24ecf3e7f00508b60fa05e2b6789b8f6=
07
- JetHub D1
  https://lore.kernel.org/r/20210915085715.1134940-5-adeep@lexina.in
  https://git.kernel.org/amlogic/c/8e279fb2903990cc6296ec56b3b80b2f854b6c=
79

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/Makefile                         |   2 +
 .../arm/dts/meson-axg-jethome-jethub-j100.dts | 361 ++++++++++++++++++
 .../meson-gxl-s905w-jethome-jethub-j80.dts    | 241 ++++++++++++
 board/amlogic/jethub-j80/MAINTAINERS          |   6 +
 board/amlogic/jethub-j80/Makefile             |   6 +
 board/amlogic/jethub-j80/jethub-j80.c         |  68 ++++
 configs/jethub_j100_defconfig                 |  55 +++
 configs/jethub_j80_defconfig                  |  63 +++
 8 files changed, 802 insertions(+)
 create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
 create mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
 create mode 100644 board/amlogic/jethub-j80/MAINTAINERS
 create mode 100644 board/amlogic/jethub-j80/Makefile
 create mode 100644 board/amlogic/jethub-j80/jethub-j80.c
 create mode 100644 configs/jethub_j100_defconfig
 create mode 100644 configs/jethub_j80_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index f0160d2dc0..d1893a9812 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -169,10 +169,12 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
 	meson-gxl-s905x-libretech-cc-v2.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
 	meson-gxl-s905d-libretech-pc.dtb \
+	meson-gxl-s905w-jethome-jethub-j80.dtb \
 	meson-gxm-khadas-vim2.dtb \
 	meson-gxm-s912-libretech-pc.dtb \
 	meson-gxm-wetek-core2.dtb \
 	meson-axg-s400.dtb \
+	meson-axg-jethome-jethub-j100.dtb \
 	meson-g12a-u200.dtb \
 	meson-g12a-sei510.dtb \
 	meson-g12b-gtking.dtb \
diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts b/arch/arm/dt=
s/meson-axg-jethome-jethub-j100.dts
new file mode 100644
index 0000000000..5783732dc6
--- /dev/null
+++ b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Vyacheslav Bocharov <adeep@lexina.in>
+ * Copyright (c) 2020 JetHome
+ * Author: Aleksandr Kazantsev <ak@tvip.ru>
+ * Author: Alexey Shevelkin <ash@tvip.ru>
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+/dts-v1/;
+
+#include "meson-axg.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible =3D "jethome,jethub-j100", "amlogic,a113d", "amlogic,meson-a=
xg";
+	model =3D "JetHome JetHub J100";
+	aliases {
+		serial0 =3D &uart_AO;   /* Console */
+		serial1 =3D &uart_AO_B; /* External UART (Wireless Module) */
+		ethernet0 =3D &ethmac;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	/* 1024MB RAM */
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		linux,cma {
+			size =3D <0x0 0x400000>;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible =3D "mmc-pwrseq-emmc";
+		reset-gpios =3D <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		vin-supply =3D <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC5V";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDAO_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		vin-supply =3D <&vcc_5v>;
+		regulator-always-on;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDIO_AO18";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		vin-supply =3D <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDIO_BOOT";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		vin-supply =3D <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	usb_pwr: regulator-usb_pwr {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "USB_PWR";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		vin-supply =3D <&vcc_5v>;
+		regulator-always-on;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		reset-gpios =3D <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
+		clocks =3D <&wifi32k>;
+		clock-names =3D "ext_clock";
+	};
+
+	wifi32k: wifi32k {
+		compatible =3D "pwm-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+		pwms =3D <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+			thermal-sensors =3D <&scpi_sensors 0>;
+			trips {
+				cpu_passive: cpu-passive {
+					temperature =3D <70000>; /* millicelsius */
+					hysteresis =3D <2000>; /* millicelsius */
+					type =3D "passive";
+				};
+
+				cpu_hot: cpu-hot {
+					temperature =3D <80000>; /* millicelsius */
+					hysteresis =3D <2000>; /* millicelsius */
+					type =3D "hot";
+				};
+
+				cpu_critical: cpu-critical {
+					temperature =3D <100000>; /* millicelsius */
+					hysteresis =3D <2000>; /* millicelsius */
+					type =3D "critical";
+				};
+			};
+		};
+
+		cpu_cooling_maps: cooling-maps {
+			map0 {
+				trip =3D <&cpu_passive>;
+				cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+
+			map1 {
+				trip =3D <&cpu_hot>;
+				cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+	onewire {
+		compatible =3D "w1-gpio";
+		gpios =3D <&gpio GPIOA_14 GPIO_ACTIVE_HIGH>;
+		#gpio-cells =3D <1>;
+	};
+};
+
+&efuse {
+	sn: sn@32 {
+		reg =3D <0x32 0x20>;
+	};
+
+	eth_mac: eth_mac@0 {
+		reg =3D <0x0 0x6>;
+	};
+
+	bt_mac: bt_mac@6 {
+		reg =3D <0x6 0x6>;
+	};
+
+	wifi_mac: wifi_mac@c {
+		reg =3D <0xc 0x6>;
+	};
+
+	bid: bid@12 {
+		reg =3D <0x12 0x20>;
+	};
+};
+
+&ethmac {
+	status =3D "okay";
+	pinctrl-0 =3D <&eth_rmii_x_pins>;
+	pinctrl-names =3D "default";
+	phy-handle =3D <&eth_phy0>;
+	phy-mode =3D "rmii";
+
+	mdio {
+		compatible =3D "snps,dwmac-mdio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		/* ICPlus IP101A/G Ethernet PHY (vendor_id=3D0x0243, model_id=3D0x0c54=
) */
+		eth_phy0: ethernet-phy@0 {
+			/* compatible =3D "ethernet-phy-id0243.0c54";*/
+			max-speed =3D <100>;
+			reg =3D <0>;
+
+			reset-assert-us =3D <10000>;
+			reset-deassert-us =3D <10000>;
+			reset-gpios =3D <&gpio GPIOZ_5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* Internal I2C bus (on CPU module) */
+&i2c1 {
+	status =3D "okay";
+	pinctrl-0 =3D <&i2c1_z_pins>;
+	pinctrl-names =3D "default";
+
+	/* RTC */
+	pcf8563: pcf8563@51 {
+		compatible =3D "nxp,pcf8563";
+		reg =3D <0x51>;
+		status =3D "okay";
+	};
+};
+
+/* Peripheral I2C bus (on motherboard) */
+&i2c_AO {
+	status =3D "okay";
+	pinctrl-0 =3D <&i2c_ao_sck_10_pins>, <&i2c_ao_sda_11_pins>;
+	pinctrl-names =3D "default";
+};
+
+&pwm_ab {
+	status =3D "okay";
+	pinctrl-0 =3D <&pwm_a_x20_pins>;
+	pinctrl-names =3D "default";
+};
+
+/* wifi module */
+&sd_emmc_b {
+	status =3D "okay";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+
+	pinctrl-0 =3D <&sdio_pins>;
+	pinctrl-1 =3D <&sdio_clk_gate_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr104;
+	max-frequency =3D <200000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq =3D <&sdio_pwrseq>;
+
+	vmmc-supply =3D <&vddao_3v3>;
+	vqmmc-supply =3D <&vddio_boot>;
+
+	brcmf: wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+	};
+};
+
+/* emmc storage */
+&sd_emmc_c {
+	status =3D "okay";
+	pinctrl-0 =3D <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 =3D <&emmc_clk_gate_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+
+	bus-width =3D <8>;
+	cap-mmc-highspeed;
+	max-frequency =3D <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq =3D <&emmc_pwrseq>;
+
+	vmmc-supply =3D <&vcc_3v3>;
+	vqmmc-supply =3D <&vddio_boot>;
+};
+
+/* UART Bluetooth */
+&uart_B {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_b_z_pins>, <&uart_b_z_cts_rts_pins>;
+	pinctrl-names =3D "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		shutdown-gpios =3D <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* UART Console */
+&uart_AO {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_ao_a_pins>;
+	pinctrl-names =3D "default";
+};
+
+/* UART Wireless module */
+&uart_AO_B {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_ao_b_pins>;
+	pinctrl-names =3D "default";
+};
+
+&usb {
+	status =3D "okay";
+	phy-supply =3D <&usb_pwr>;
+};
+
+&spicc1 {
+	status =3D "okay";
+	pinctrl-0 =3D <&spi1_x_pins>, <&spi1_ss0_x_pins>;
+	pinctrl-names =3D "default";
+};
+
+&gpio {
+	gpio-line-names =3D
+		"", "", "", "", "", // 0 - 4
+		"", "", "", "", "", // 5 - 9
+		"UserButton", "", "", "", "", // 10 - 14
+		"", "", "", "", "", // 15 - 19
+		"", "", "", "", "", // 20 - 24
+		"", "LedRed", "LedGreen", "Output3", "Output2", // 25 - 29
+		"Output1", "", "", "", "", // 30 - 34
+		"", "ZigBeeBOOT", "", "", "", // 35 - 39
+		"", "ZigBeeRESET", "", "Input4", "Input3", // 40 - 44
+		"Input2", "Input1", "", "", "", // 45 - 49
+		"", "", "", "", "", // 50 - 54
+		"", "", "", "", "", // 55 - 59
+		"", "", "", "", "", // 60 - 64
+		"", "", "", "", "", // 65 - 69
+		"", "", "", "", "", // 70 - 74
+		"", "", "", "", "", // 75 - 79
+		"", "", "", "", "", // 80 - 84
+		"", ""; // 85-86
+};
+
+&cpu0 {
+	#cooling-cells =3D <2>;
+};
+
+&cpu1 {
+	#cooling-cells =3D <2>;
+};
+
+&cpu2 {
+	#cooling-cells =3D <2>;
+};
+
+&cpu3 {
+	#cooling-cells =3D <2>;
+};
diff --git a/arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/a=
rm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
new file mode 100644
index 0000000000..6eafb90869
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Vyacheslav Bocharov <adeep@lexina.in>
+ * Copyright (c) 2020 JetHome
+ * Author: Aleksandr Kazantsev <ak@tvip.ru>
+ * Author: Alexey Shevelkin <ash@tvip.ru>
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl.dtsi"
+
+/ {
+	compatible =3D "jethome,jethub-j80", "amlogic,s905w", "amlogic,meson-gx=
l";
+	model =3D "JetHome JetHub J80";
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		linux,cma {
+			size =3D <0x0 0x1000000>;
+		};
+	};
+
+	aliases {
+		serial0 =3D &uart_AO;   /* Console */
+		serial1 =3D &uart_A;    /* Bluetooth */
+		serial2 =3D &uart_AO_B; /* Wireless module 1 */
+		serial3 =3D &uart_C;    /* Wireless module 2 */
+		ethernet0 =3D &ethmac;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDIO_AO18";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDIO_BOOT";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VDDAO_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VCC_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible =3D "mmc-pwrseq-emmc";
+		reset-gpios =3D <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi32k: wifi32k {
+		compatible =3D "pwm-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks =3D <&wifi32k>;
+		clock-names =3D "ext_clock";
+	};
+};
+
+&efuse {
+	bt_mac: bt_mac@6 {
+		reg =3D <0x6 0x6>;
+	};
+
+	wifi_mac: wifi_mac@C {
+		reg =3D <0xc 0x6>;
+	};
+};
+
+&sn {
+	reg =3D <0x32 0x20>;
+};
+
+&eth_mac {
+	reg =3D <0x0 0x6>;
+};
+
+&bid {
+	reg =3D <0x12 0x20>;
+};
+
+&usb {
+	status =3D "okay";
+	dr_mode =3D "host";
+};
+
+&pwm_ef {
+	status =3D "okay";
+	pinctrl-0 =3D <&pwm_e_pins>;
+	pinctrl-names =3D "default";
+	clocks =3D <&clkc CLKID_FCLK_DIV4>;
+	clock-names =3D "clkin0";
+};
+
+&saradc {
+	status =3D "okay";
+	vref-supply =3D <&vddio_ao18>;
+};
+
+/* Wireless SDIO Module */
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
+	max-frequency =3D <50000000>;
+
+	non-removable;
+	disable-wp;
+
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
+	mmc-pwrseq =3D <&sdio_pwrseq>;
+
+	vmmc-supply =3D <&vddao_3v3>;
+	vqmmc-supply =3D <&vddio_boot>;
+};
+
+/* SD card */
+&sd_emmc_b {
+	status =3D "okay";
+	pinctrl-0 =3D <&sdcard_pins>;
+	pinctrl-1 =3D <&sdcard_clk_gate_pins>;
+	pinctrl-names =3D "default", "clk-gate";
+
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	max-frequency =3D <50000000>;
+	disable-wp;
+
+	cd-gpios =3D <&gpio CARD_6 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply =3D <&vddao_3v3>;
+	vqmmc-supply =3D <&vddio_boot>;
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
+	max-frequency =3D <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq =3D <&emmc_pwrseq>;
+	vmmc-supply =3D <&vcc_3v3>;
+	vqmmc-supply =3D <&vddio_boot>;
+};
+
+/* Console UART */
+&uart_AO {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_ao_a_pins>;
+	pinctrl-names =3D "default";
+};
+
+/* S905W only has access to its internal PHY */
+&ethmac {
+	status =3D "okay";
+	phy-mode =3D "rmii";
+	phy-handle =3D <&internal_phy>;
+};
+
+&internal_phy {
+	status =3D "okay";
+	pinctrl-0 =3D <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names =3D "default";
+};
+
+&uart_A {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names =3D "default";
+	uart-has-rtscts;
+};
+
+&uart_C {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_c_pins>;
+	pinctrl-names =3D "default";
+};
+
+&uart_AO_B {
+	status =3D "okay";
+	pinctrl-0 =3D <&uart_ao_b_pins>, <&uart_ao_b_cts_rts_pins>;
+	pinctrl-names =3D "default";
+	uart-has-rtscts;
+};
+
+&i2c_B {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c_b_pins>;
+
+	pcf8563: pcf8563@51 {
+		compatible =3D "nxp,pcf8563";
+		reg =3D <0x51>;
+		status =3D "okay";
+	};
+};
diff --git a/board/amlogic/jethub-j80/MAINTAINERS b/board/amlogic/jethub-=
j80/MAINTAINERS
new file mode 100644
index 0000000000..1b8fbf8c35
--- /dev/null
+++ b/board/amlogic/jethub-j80/MAINTAINERS
@@ -0,0 +1,6 @@
+JetHome JetHub J80
+M:	Vyacheslav Bocharov <adeep@lexina.in>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/jethub-j80/
+F:	configs/jethub_j80_defconfig
diff --git a/board/amlogic/jethub-j80/Makefile b/board/amlogic/jethub-j80=
/Makefile
new file mode 100644
index 0000000000..a727a4b222
--- /dev/null
+++ b/board/amlogic/jethub-j80/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2021 Vyacheslav Bocharov
+# Author: Vyacheslav Bocharov <adeep@lexina.in>
+
+obj-y	:=3D jethub-j80.o
diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub=
-j80/jethub-j80.c
new file mode 100644
index 0000000000..2a9ffb794f
--- /dev/null
+++ b/board/amlogic/jethub-j80/jethub-j80.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Vyacheslav Bocharov
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <adc.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+#define EFUSE_SN_OFFSET		50
+#define EFUSE_SN_SIZE		32
+#define EFUSE_MAC_OFFSET	0
+#define EFUSE_MAC_SIZE		6
+#define EFUSE_USID_OFFSET	18
+#define EFUSE_USID_SIZE		32
+
+int misc_init_r(void)
+{
+	u8 mac_addr[EFUSE_MAC_SIZE];
+	char serial[EFUSE_SN_SIZE];
+	char usid[EFUSE_USID_SIZE];
+	ssize_t len;
+	unsigned int adcval;
+	int ret;
+	char value[16];
+
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		len =3D meson_sm_read_efuse(EFUSE_MAC_OFFSET,
+					  mac_addr, EFUSE_MAC_SIZE);
+		if (len =3D=3D EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
+			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
+	}
+
+	if (!env_get("serial")) {
+		len =3D meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,=20
+			EFUSE_SN_SIZE);
+		if (len =3D=3D EFUSE_SN_SIZE)
+			env_set("serial", serial);
+	}
+
+	if (!env_get("usid")) {
+		len =3D meson_sm_read_efuse(EFUSE_USID_OFFSET, usid,
+			EFUSE_USID_SIZE);
+		if (len =3D=3D EFUSE_USID_SIZE)
+			env_set("usid", usid);
+	}
+
+	ret =3D adc_channel_single_shot("adc@8680", 0, &adcval);
+	if (adcval < 3000)
+		env_set("userbutton", "true");
+	else
+		env_set("userbutton", "false");
+
+	return 0;
+}
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
new file mode 100644
index 0000000000..290ce4db85
--- /dev/null
+++ b/configs/jethub_j100_defconfig
@@ -0,0 +1,55 @@
+CONFIG_ARM=3Dy
+CONFIG_SYS_CONFIG_NAME=3D"jethub"
+CONFIG_ARCH_MESON=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x01000000
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_ENV_SIZE=3D0x2000
+CONFIG_DM_GPIO=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"meson-axg-jethome-jethub-j100"
+CONFIG_MESON_AXG=3Dy
+CONFIG_DEBUG_UART_BASE=3D0xff803000
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_IDENT_STRING=3D" jethubj100"
+CONFIG_DEBUG_UART=3Dy
+CONFIG_OF_BOARD_SETUP=3Dy
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=3Dy
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=3Dy
+CONFIG_RANDOM_UUID=3Dy
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+CONFIG_CMD_REGULATOR=3Dy
+CONFIG_PARTITION_TYPE_GUID=3Dy
+CONFIG_OF_CONTROL=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_MMC_MESON_GX=3Dy
+CONFIG_MTD_UBI=3Dy
+CONFIG_PHY_REALTEK=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
+CONFIG_MESON_GXL_USB_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_MESON_AXG=3Dy
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DM_RESET=3Dy
+CONFIG_DEBUG_UART_ANNOUNCE=3Dy
+CONFIG_DEBUG_UART_SKIP_INIT=3Dy
+CONFIG_MESON_SERIAL=3Dy
+CONFIG_USB=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_XHCI_DWC3=3Dy
+CONFIG_USB_DWC2=3Dy
+CONFIG_USB_DWC3=3Dy
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
+CONFIG_USB_GADGET_DWC2_OTG=3Dy
+CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
new file mode 100644
index 0000000000..7db05af3b0
--- /dev/null
+++ b/configs/jethub_j80_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=3Dy
+CONFIG_SYS_BOARD=3D"jethub-j80"
+CONFIG_SYS_CONFIG_NAME=3D"jethub"
+CONFIG_ARCH_MESON=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x01000000
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_ENV_SIZE=3D0x2000
+CONFIG_DM_GPIO=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxl-s905w-jethome-jethub-j80"
+CONFIG_MESON_GXL=3Dy
+CONFIG_DEBUG_UART_BASE=3D0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_IDENT_STRING=3D" jethubj80"
+CONFIG_DEBUG_UART=3Dy
+CONFIG_OF_BOARD_SETUP=3Dy
+CONFIG_CONSOLE_MUX=3Dy
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=3Dy
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=3Dy
+CONFIG_CMD_GPIO=3Dy
+CONFIG_RANDOM_UUID=3Dy
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+CONFIG_CMD_REGULATOR=3Dy
+CONFIG_PARTITION_TYPE_GUID=3Dy
+CONFIG_OF_CONTROL=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_SARADC_MESON=3Dy
+CONFIG_MMC_MESON_GX=3Dy
+CONFIG_MTD_UBI=3Dy
+CONFIG_PHY_MESON_GXL=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_DM_MDIO=3Dy
+CONFIG_DM_MDIO_MUX=3Dy
+CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
+CONFIG_MDIO_MUX_MMIOREG=3Dy
+CONFIG_MESON_GXL_USB_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_MESON_GXL=3Dy
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DM_RESET=3Dy
+CONFIG_DEBUG_UART_ANNOUNCE=3Dy
+CONFIG_DEBUG_UART_SKIP_INIT=3Dy
+CONFIG_MESON_SERIAL=3Dy
+CONFIG_USB=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_XHCI_DWC3=3Dy
+CONFIG_USB_DWC2=3Dy
+CONFIG_USB_DWC3=3Dy
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
+CONFIG_USB_GADGET_DWC2_OTG=3Dy
+CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
--=20
2.30.2

