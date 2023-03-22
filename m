Subject: [PATCHv2 1/3] ARM: meson: Add initial support for beelink gt1
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Wed, 22 Mar 2023 12:18:06 -0700
Message-ID: <4JuV.1679512686557897034.0F26@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add initial support for beelink gt1

Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>

---

This patch is base on this patch from in pm os .

https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-boo=
t-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch

---

 .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
 arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
 board/amlogic/q200/MAINTAINERS                |  2 +
 configs/beelink_gt1_ultimate_defconfig        | 85 +++++++++++++++++
 doc/board/amlogic/beelink-gt1.rst             | 65 +++++++++++++
 doc/board/amlogic/index.rst                   |  3 +-
 6 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
 create mode 100644 configs/beelink_gt1_ultimate_defconfig
 create mode 100644 doc/board/amlogic/beelink-gt1.rst

diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi b/arch/arm/dts=
/meson-gxm-gt1-ultimate-u-boot.dtsi
new file mode 100644
index 000000000000..fb597c45376f
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Karl Chan <exxxxkc@getgoogleoff.me>=20
+ *
+ */
+
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts b/arch/arm/dts/meson-g=
xm-gt1-ultimate.dts
new file mode 100644
index 000000000000..2c267884cc16
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
--
2.39.1
