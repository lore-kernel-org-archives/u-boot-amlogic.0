Received: from sonic308-20.consmr.mail.sg3.yahoo.com (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
 by mx.groups.io with SMTP id smtpd.web10.40821.1679935240897767509
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 09:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679935237; bh=OQljBJqvKQ7V14RJcTUU6+fKvlO3hdaC1+ETYtIbPhE=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=BXMeX3+jlX5dMlX6AtSJjorPnyJkslIIdQ4O7p1rjdL+bTHw5LHFNjNT7G3L75djVlf/rlMrQV9EbcqLquH2ItxivwPn2RVT5Ij/IZ0XNsB1f6k8pa4atvjmcucwb//1R7uRKC2fB9ktDFPUIbeM5p9bCG90rQuDVdLqLhCYfSdmUjcZ4BEs+wwgMU8RTSmUqvYXi/WNXG66QsNgTCmvp4BOPoosrAvfx2rkPTqzJKC1e8VUjldzqcbnzho83Kw+0dFUlT7CVUOdvi4R3ZR/Ed+FHSsxyI/Sp7dF6S7nGPgXjegua2Vdc36vY/MoJC2KeDF0sMRMsrhNyJce066F2A==
Message-ID: <4fed34dd-fe33-cc69-4fca-c79ad005fff3@yahoo.com>
Date: Tue, 28 Mar 2023 03:53:55 +0800
MIME-Version: 1.0
From: exkcmailist@yahoo.com
Subject: [PATCHv6 1/3] ARM: dts: add support for Beelink GT1 Ultimate
References: <4fed34dd-fe33-cc69-4fca-c79ad005fff3.ref@yahoo.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

﻿

Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).

Signed-off-by: Christian Hewitt<christianshewitt@gmail.com>
Signed-off-by:  Karl Chan<exxxxkc@getgoogleoff.me>
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
+ * Author: Neil Armstrong<narmstrong@baylibre.com>
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
+ * Copyright (c) Christian Hewitt<christianshewitt@gmail.com>
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
