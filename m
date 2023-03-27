Received: from knopi.disroot.org (knopi.disroot.org [178.21.23.139])
 by mx.groups.io with SMTP id smtpd.web10.41059.1679935678383457980
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 09:47:59 -0700
Message-ID: <c826746c-a599-f1d4-e148-c5974b9639d9@getgoogleoff.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=getgoogleoff.me;
	s=mail; t=1679935675;
	bh=XhKpgcuBQ3rEydx4pp5wWqkEmmrxoii1sHp4oV4XCyE=;
	h=Date:To:Cc:From:Subject;
	b=F6KgPaEIEbXL/btVGDePrJR8hk/exy0LoP0cSfB9cq+M15/Drdh/n5YXUadkEg6t6
	 EaEmrGDP+ewkTLp45LivmdemLbCFylenNWbZVwXYBYhL+WqI69b+zXMyb+hCGvJ492
	 y3QNVrhqWztVwVtxjx8jw33EZ/UIyYrubTBiBpsJBVsYWmtDAAVgm3tVCsGmiyhtra
	 D88+2v3eSw9Cv+GGECaDM+PALM2bbhjy27YV0WmE6mS2G9W7Zo4DrN7AtWl0eGTlhD
	 74UCDS5U8YFVku3pT+IUwz+9dLpBqEh6Or7wL5I4+X4vR0tkzEcIo+KQlvWWGCbbsR
	 qfzgmkkbcKQ9w==
Date: Tue, 28 Mar 2023 04:01:10 +0800
MIME-Version: 1.0
From: exkc <exxxxkc@getgoogleoff.me>
Subject: [PATCHv7 1/3] ARM: dts: add support for Beelink GT1 Ultimate
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
 =C2=A0arch/arm/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
 =C2=A0.../dts/meson-gxm-gt1-ultimate-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=C2=A0=
 7 ++
 =C2=A0arch/arm/dts/meson-gxm-gt1-ultimate.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 91 +++++++++++++++++++
 =C2=A03 files changed, 99 insertions(+)
 =C2=A0create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 =C2=A0create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1c843882d1..b4ac7e9877 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxl-s905x-libretech-cc.dtb \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxl-s905x-libretech-cc-v2.dtb \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxl-s905x-p212.dtb \
+=C2=A0=C2=A0 =C2=A0meson-gxm-gt1-ultimate.dtb \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxm-khadas-vim2.dtb \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxm-s912-libretech-pc.dtb \
 =C2=A0=C2=A0=C2=A0 =C2=A0meson-gxm-wetek-core2.dtb \
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi=20
b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
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
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts=20
b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
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
+=C2=A0=C2=A0 =C2=A0compatible =3D "azw,gt1-ultimate", "amlogic,s912", "aml=
ogic,meson-gxm";
+=C2=A0=C2=A0 =C2=A0model =3D "Beelink GT1 Ultimate";
+
+=C2=A0=C2=A0 =C2=A0leds {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0compatible =3D "gpio-leds";
+
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0led-white {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0color =3D <LED_CO=
LOR_ID_WHITE>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0function =3D LED_=
FUNCTION_POWER;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0gpios =3D <&gpio_=
ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0default-state =3D=
 "on";
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0panic-indicator;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0};
+=C2=A0=C2=A0 =C2=A0};
+
+=C2=A0=C2=A0 =C2=A0adc-keys {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0compatible =3D "adc-keys";
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0io-channels =3D <&saradc 0>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0io-channel-names =3D "buttons";
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0keyup-threshold-microvolt =3D <17100=
00>;
+
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0button-function {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0label =3D "update=
";
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0linux,code =3D <K=
EY_VENDOR>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0press-threshold-m=
icrovolt =3D <10000>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0};
+=C2=A0=C2=A0 =C2=A0};
+};
+
+&ethmac {
+=C2=A0=C2=A0 =C2=A0pinctrl-0 =3D <&eth_pins>;
+=C2=A0=C2=A0 =C2=A0pinctrl-names =3D "default";
+=C2=A0=C2=A0 =C2=A0phy-handle =3D <&external_phy>;
+=C2=A0=C2=A0 =C2=A0amlogic,tx-delay-ns =3D <2>;
+=C2=A0=C2=A0 =C2=A0phy-mode =3D "rgmii";
+};
+
+&external_mdio {
+=C2=A0=C2=A0 =C2=A0external_phy: ethernet-phy@0 {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0/* Realtek RTL8211F (0x001cc916) */
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0reg =3D <0>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0max-speed =3D <1000>;
+
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0reset-assert-us =3D <10000>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0reset-deassert-us =3D <80000>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0reset-gpios =3D <&gpio GPIOZ_14 GPIO=
_ACTIVE_LOW>;
+
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0interrupt-parent =3D <&gpio_intc>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0/* MAC_INTR on GPIOZ_15 */
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0interrupts =3D <25 IRQ_TYPE_LEVEL_LO=
W>;
+=C2=A0=C2=A0 =C2=A0};
+};
+
+&ir {
+=C2=A0=C2=A0 =C2=A0linux,rc-map-name =3D "rc-beelink-gs1";
+};
+
+&sd_emmc_a {
+=C2=A0=C2=A0 =C2=A0brcmf: wifi@1 {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0reg =3D <1>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0compatible =3D "brcm,bcm4329-fmac";
+=C2=A0=C2=A0 =C2=A0};
+};
+
+&uart_A {
+=C2=A0=C2=A0 =C2=A0status =3D "okay";
+=C2=A0=C2=A0 =C2=A0pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+=C2=A0=C2=A0 =C2=A0pinctrl-names =3D "default";
+=C2=A0=C2=A0 =C2=A0uart-has-rtscts;
+
+=C2=A0=C2=A0 =C2=A0bluetooth {
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0compatible =3D "brcm,bcm43438-bt";
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0shutdown-gpios =3D <&gpio GPIOX_17 G=
PIO_ACTIVE_HIGH>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0max-speed =3D <2000000>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0clocks =3D <&wifi32k>;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0clock-names =3D "lpo";
+=C2=A0=C2=A0 =C2=A0};
+};
--=20
2.40.0
