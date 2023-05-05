Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.26256.1683291416467242784
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=jxSAFL+kc2P6mcYSYbKTWPW16sEvMrwMGbu5b1leKyA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PoKK0hG33Ph9NJSwyPMKi29OYYa3N48mA3rAytUw50Vh6VqyPBNyQ3O4PwmOg5V34
	 0i7j9g8rQTE5kM/MnkF6rucEAmMgwLwNN1EadaS7ZtFBy0ZHKXXBT+8NWpPBzPnZ9X
	 L8RloLzyKSD/etWxef/9/2ZCSW78MqwIhz0FsynUlIz3xs68Z6riuqURtNUSei+PPm
	 yDHzvB8tn19ONgW5jJiVelHt+//JNRTT1AcLBPC2/yxpI2Ovm5yOGvdG7BPkUZ7BhY
	 u//fhih7Zr4TFFDFe+Ral0PKLJmUw+K9nAWFuXUOlBLOWgfAhuNSdjPit7aL/VKqK8
	 Os2i70gilMsOw==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 1/5] ARM: dts: Add Amlogic Meson A1 DT from Linux 6.3-rc7
Date: Fri, 5 May 2023 15:56:35 +0300
Message-ID: <20230505125639.3605-2-ivprusov@sberdevices.ru>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Import Linux 6.3-rc7 Device tree and necessary bindings for Amlogic A1
board from 6a8f57ae2eb0 ("Linux 6.3-rc7").

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-a1.dtsi               | 161 +++++++++++++++++++++++
 include/dt-bindings/gpio/meson-a1-gpio.h |  73 ++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 arch/arm/dts/meson-a1.dtsi
 create mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
new file mode 100644
index 0000000000..6509329b85
--- /dev/null
+++ b/arch/arm/dts/meson-a1.dtsi
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/meson-a1-gpio.h>
+
+/ {
+	compatible =3D "amlogic,a1";
+
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a35";
+			reg =3D <0x0 0x0>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a35";
+			reg =3D <0x0 0x1>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+		};
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
+		linux,cma {
+			compatible =3D "shared-dma-pool";
+			reusable;
+			size =3D <0x0 0x800000>;
+			alignment =3D <0x0 0x400000>;
+			linux,cma-default;
+		};
+	};
+
+	sm: secure-monitor {
+		compatible =3D "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible =3D "amlogic,meson-a1-pwrc";
+			#power-domain-cells =3D <1>;
+			status =3D "okay";
+		};
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		apb: bus@fe000000 {
+			compatible =3D "simple-bus";
+			reg =3D <0x0 0xfe000000 0x0 0x1000000>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
+
+			reset: reset-controller@0 {
+				compatible =3D "amlogic,meson-a1-reset";
+				reg =3D <0x0 0x0 0x0 0x8c>;
+				#reset-cells =3D <1>;
+			};
+
+			periphs_pinctrl: pinctrl@400 {
+				compatible =3D "amlogic,meson-a1-periphs-pinctrl";
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges;
+
+				gpio: bank@400 {
+					reg =3D <0x0 0x0400 0x0 0x003c>,
+					      <0x0 0x0480 0x0 0x0118>;
+					reg-names =3D "mux", "gpio";
+					gpio-controller;
+					#gpio-cells =3D <2>;
+					gpio-ranges =3D <&periphs_pinctrl 0 0 62>;
+				};
+
+			};
+
+			uart_AO: serial@1c00 {
+				compatible =3D "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg =3D <0x0 0x1c00 0x0 0x18>;
+				interrupts =3D <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&xtal>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+
+			uart_AO_B: serial@2000 {
+				compatible =3D "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg =3D <0x0 0x2000 0x0 0x18>;
+				interrupts =3D <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				clocks =3D <&xtal>, <&xtal>, <&xtal>;
+				clock-names =3D "xtal", "pclk", "baud";
+				status =3D "disabled";
+			};
+		};
+
+		gic: interrupt-controller@ff901000 {
+			compatible =3D "arm,gic-400";
+			reg =3D <0x0 0xff901000 0x0 0x1000>,
+			      <0x0 0xff902000 0x0 0x2000>,
+			      <0x0 0xff904000 0x0 0x2000>,
+			      <0x0 0xff906000 0x0 0x2000>;
+			interrupt-controller;
+			interrupts =3D <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
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
+	};
+
+	xtal: xtal-clk {
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <24000000>;
+		clock-output-names =3D "xtal";
+		#clock-cells =3D <0>;
+	};
+};
diff --git a/include/dt-bindings/gpio/meson-a1-gpio.h b/include/dt-bindings=
/gpio/meson-a1-gpio.h
new file mode 100644
index 0000000000..40e57a5ff1
--- /dev/null
+++ b/include/dt-bindings/gpio/meson-a1-gpio.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Qianggui Song <qianggui.song@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_A1_GPIO_H
+#define _DT_BINDINGS_MESON_A1_GPIO_H
+
+#define GPIOP_0		0
+#define GPIOP_1		1
+#define GPIOP_2		2
+#define GPIOP_3		3
+#define GPIOP_4		4
+#define GPIOP_5		5
+#define GPIOP_6		6
+#define GPIOP_7		7
+#define GPIOP_8		8
+#define GPIOP_9		9
+#define GPIOP_10	10
+#define GPIOP_11	11
+#define GPIOP_12	12
+#define GPIOB_0		13
+#define GPIOB_1		14
+#define GPIOB_2		15
+#define GPIOB_3		16
+#define GPIOB_4		17
+#define GPIOB_5		18
+#define GPIOB_6		19
+#define GPIOX_0		20
+#define GPIOX_1		21
+#define GPIOX_2		22
+#define GPIOX_3		23
+#define GPIOX_4		24
+#define GPIOX_5		25
+#define GPIOX_6		26
+#define GPIOX_7		27
+#define GPIOX_8		28
+#define GPIOX_9		29
+#define GPIOX_10	30
+#define GPIOX_11	31
+#define GPIOX_12	32
+#define GPIOX_13	33
+#define GPIOX_14	34
+#define GPIOX_15	35
+#define GPIOX_16	36
+#define GPIOF_0		37
+#define GPIOF_1		38
+#define GPIOF_2		39
+#define GPIOF_3		40
+#define GPIOF_4		41
+#define GPIOF_5		42
+#define GPIOF_6		43
+#define GPIOF_7		44
+#define GPIOF_8		45
+#define GPIOF_9		46
+#define GPIOF_10	47
+#define GPIOF_11	48
+#define GPIOF_12	49
+#define GPIOA_0		50
+#define GPIOA_1		51
+#define GPIOA_2		52
+#define GPIOA_3		53
+#define GPIOA_4		54
+#define GPIOA_5		55
+#define GPIOA_6		56
+#define GPIOA_7		57
+#define GPIOA_8		58
+#define GPIOA_9		59
+#define GPIOA_10	60
+#define GPIOA_11	61
+
+#endif /* _DT_BINDINGS_MESON_A1_GPIO_H */
--=20
2.34.1

