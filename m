Subject: [PATCHv5 1/3] ARM: dts: add support for Beelink GT1 Ultimate
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Sun, 26 Mar 2023 10:11:05 -0700
Message-ID: <CdyC.1679850665326358079.ekOu@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>
---
 arch/arm/dts/Makefile                         |  1 +
 .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
 arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1c843882d1..b4ac7e9877 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
 	meson-gxl-s905x-libretech-cc.dtb \
 	meson-gxl-s905x-libretech-cc-v2.dtb \
 	meson-gxl-s905x-p212.dtb \
+	meson-gxm-gt1-ultimate.dtb \
 	meson-gxm-khadas-vim2.dtb \
 	meson-gxm-s912-libretech-pc.dtb \
 	meson-gxm-wetek-core2.dtb \
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi b/arch/arm/dts=
/meson-gxm-gt1-ultimate-u-boot.dtsi
new file mode 100644
index 0000000000..39270ea71c
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts b/arch/arm/dts/meson-g=
xm-gt1-ultimate.dts
new file mode 100644
index 0000000000..2c267884cc
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible =3D "azw,gt1-ultimate", "amlogic,s912", "amlogic,meson-gxm";
+	model =3D "Beelink GT1 Ultimate";
+
+	leds {
+		compatible =3D "gpio-leds";
+
+		led-white {
+			color =3D <LED_COLOR_ID_WHITE>;
+			function =3D LED_FUNCTION_POWER;
+			gpios =3D <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			default-state =3D "on";
+			panic-indicator;
+		};
+	};
+
+	adc-keys {
+		compatible =3D "adc-keys";
+		io-channels =3D <&saradc 0>;
+		io-channel-names =3D "buttons";
+		keyup-threshold-microvolt =3D <1710000>;
+
+		button-function {
+			label =3D "update";
+			linux,code =3D <KEY_VENDOR>;
+			press-threshold-microvolt =3D <10000>;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 =3D <&eth_pins>;
+	pinctrl-names =3D "default";
+	phy-handle =3D <&external_phy>;
+	amlogic,tx-delay-ns =3D <2>;
+	phy-mode =3D "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg =3D <0>;
+		max-speed =3D <1000>;
+
+		reset-assert-us =3D <10000>;
+		reset-deassert-us =3D <80000>;
+		reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent =3D <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_15 */
+		interrupts =3D <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ir {
+	linux,rc-map-name =3D "rc-beelink-gs1";
+};
+
+&sd_emmc_a {
+	brcmf: wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+	};
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
--=20
2.40.0
