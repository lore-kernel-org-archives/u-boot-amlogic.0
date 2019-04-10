Received: by mail-wr1-f65.google.com with SMTP id r4so3441448wrq.8
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjWExfHWMGxt2YsGiguYStLUfGPsO62+sOH0YZwJbQA=;
        b=JSeBLzu/Vbb5ZPJA6fXlHjNkIScuXidO5LPWhKRP3OwYXhAG4xFLvrMwMtHkF7X3Yy
         sEtu/rze09Z4+RygSvirn5aZRAynlG5UyIDYaN517XUiUEU5DKse68vOW61o+C0ZuU79
         KSKmMut/ul5ZcKvUPSGnT6Hfja81Orkm4KqeJkS9m6p6xDH0geqN0jA3+QfdFLOx5RpF
         1xjZ+jet0bVdEvO1A3Y+iTsfgAY7jmCkRQnkX7lFWEW0lllcRFMLV7ajk3V7cyoyCk3d
         CX5WNK8e84jsQ0APSgUL2/n5q3uEfmT3giIdzLg4iszfjYaSrf1l73MEAG+hd72CusfT
         zAbg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 5/6] ARM: dts: Import Amlogic G12A u200 DT from Linux 5.1-rc1
Date: Wed, 10 Apr 2019 17:23:47 +0200
Message-Id: <20190410152348.13777-6-narmstrong@baylibre.com>
In-Reply-To: <20190410152348.13777-1-narmstrong@baylibre.com>
References: <20190410152348.13777-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Import Linux 5.1-rc1 DT from 9e98c678c2d6 ("Linux 5.1-rc1") for the
meson-g12a-u200 board, the meson-g12a.dtsi and the corresponding bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/meson-g12a-u200.dts              |  29 +++
 arch/arm/dts/meson-g12a.dtsi                  | 192 ++++++++++++++++++
 include/dt-bindings/clock/g12a-aoclkc.h       |  34 ++++
 include/dt-bindings/clock/g12a-clkc.h         | 135 ++++++++++++
 include/dt-bindings/gpio/meson-g12a-gpio.h    | 114 +++++++++++
 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++
 include/dt-bindings/reset/g12a-aoclkc.h       |  18 ++
 8 files changed, 658 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-g12a-u200.dts
 create mode 100644 arch/arm/dts/meson-g12a.dtsi
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 36b969d6de..c5658d359f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -104,7 +104,8 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxl-s905x-libretech-cc.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
 	meson-gxm-khadas-vim2.dtb \
-	meson-axg-s400.dtb
+	meson-axg-s400.dtb \
+	meson-g12a-u200.dtb
 dtb-$(CONFIG_TEGRA) += tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a-u200.dts
new file mode 100644
index 0000000000..c44dbdddf2
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-u200.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "amlogic,u200", "amlogic,g12a";
+	model = "Amlogic Meson G12A U200 Development Board";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
+
diff --git a/arch/arm/dts/meson-g12a.dtsi b/arch/arm/dts/meson-g12a.dtsi
new file mode 100644
index 0000000000..17c6217f8a
--- /dev/null
+++ b/arch/arm/dts/meson-g12a.dtsi
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "amlogic,g12a";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon@5000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		apb: bus@ff600000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff600000 0x0 0x200000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
+
+			periphs: bus@34400 {
+				compatible = "simple-bus";
+				reg = <0x0 0x34400 0x0 0x400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
+			};
+
+			hiu: bus@3c000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x3c000 0x0 0x1400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+
+				hhi: system-controller@0 {
+					compatible = "amlogic,meson-gx-hhi-sysctrl",
+						     "simple-mfd", "syscon";
+					reg = <0 0 0 0x400>;
+
+					clkc: clock-controller {
+						compatible = "amlogic,g12a-clkc";
+						#clock-cells = <1>;
+						clocks = <&xtal>;
+						clock-names = "xtal";
+					};
+				};
+			};
+		};
+
+		aobus: bus@ff800000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff800000 0x0 0x100000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
+
+			uart_AO: serial@3000 {
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg = <0x0 0x3000 0x0 0x18>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_AO_B: serial@4000 {
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
+				reg = <0x0 0x4000 0x0 0x18>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+
+		gic: interrupt-controller@ffc01000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xffc01000 0 0x1000>,
+			      <0x0 0xffc02000 0 0x2000>,
+			      <0x0 0xffc04000 0 0x2000>,
+			      <0x0 0xffc06000 0 0x2000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+		};
+
+		cbus: bus@ffd00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffd00000 0x0 0x100000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
+
+			clk_msr: clock-measure@18000 {
+				compatible = "amlogic,meson-g12a-clk-measure";
+				reg = <0x0 0x18000 0x0 0x10>;
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
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
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+};
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
new file mode 100644
index 0000000000..8db01ffbeb
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+
+#define CLKID_AO_AHB		0
+#define CLKID_AO_IR_IN		1
+#define CLKID_AO_I2C_M0		2
+#define CLKID_AO_I2C_S0		3
+#define CLKID_AO_UART		4
+#define CLKID_AO_PROD_I2C	5
+#define CLKID_AO_UART2		6
+#define CLKID_AO_IR_OUT		7
+#define CLKID_AO_SAR_ADC	8
+#define CLKID_AO_MAILBOX	9
+#define CLKID_AO_M3		10
+#define CLKID_AO_AHB_SRAM	11
+#define CLKID_AO_RTI		12
+#define CLKID_AO_M4_FCLK	13
+#define CLKID_AO_M4_HCLK	14
+#define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_CLK	18
+#define CLKID_AO_32K		23
+#define CLKID_AO_CEC		27
+#define CLKID_AO_CTS_RTC_OSCIN	28
+
+#endif
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
new file mode 100644
index 0000000000..83b657038d
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Meson-G12A clock tree IDs
+ *
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __G12A_CLKC_H
+#define __G12A_CLKC_H
+
+#define CLKID_SYS_PLL				0
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_DIV2				2
+#define CLKID_FCLK_DIV3				3
+#define CLKID_FCLK_DIV4				4
+#define CLKID_FCLK_DIV5				5
+#define CLKID_FCLK_DIV7				6
+#define CLKID_GP0_PLL				7
+#define CLKID_CLK81				10
+#define CLKID_MPLL0				11
+#define CLKID_MPLL1				12
+#define CLKID_MPLL2				13
+#define CLKID_MPLL3				14
+#define CLKID_DDR				15
+#define CLKID_DOS				16
+#define CLKID_AUDIO_LOCKER			17
+#define CLKID_MIPI_DSI_HOST			18
+#define CLKID_ETH_PHY				19
+#define CLKID_ISA				20
+#define CLKID_PL301				21
+#define CLKID_PERIPHS				22
+#define CLKID_SPICC0				23
+#define CLKID_I2C				24
+#define CLKID_SANA				25
+#define CLKID_SD				26
+#define CLKID_RNG0				27
+#define CLKID_UART0				28
+#define CLKID_SPICC1				29
+#define CLKID_HIU_IFACE				30
+#define CLKID_MIPI_DSI_PHY			31
+#define CLKID_ASSIST_MISC			32
+#define CLKID_SD_EMMC_A				33
+#define CLKID_SD_EMMC_B				34
+#define CLKID_SD_EMMC_C				35
+#define CLKID_AUDIO_CODEC			36
+#define CLKID_AUDIO				37
+#define CLKID_ETH				38
+#define CLKID_DEMUX				39
+#define CLKID_AUDIO_IFIFO			40
+#define CLKID_ADC				41
+#define CLKID_UART1				42
+#define CLKID_G2D				43
+#define CLKID_RESET				44
+#define CLKID_PCIE_COMB				45
+#define CLKID_PARSER				46
+#define CLKID_USB				47
+#define CLKID_PCIE_PHY				48
+#define CLKID_AHB_ARB0				49
+#define CLKID_AHB_DATA_BUS			50
+#define CLKID_AHB_CTRL_BUS			51
+#define CLKID_HTX_HDCP22			52
+#define CLKID_HTX_PCLK				53
+#define CLKID_BT656				54
+#define CLKID_USB1_DDR_BRIDGE			55
+#define CLKID_MMC_PCLK				56
+#define CLKID_UART2				57
+#define CLKID_VPU_INTR				58
+#define CLKID_GIC				59
+#define CLKID_SD_EMMC_A_CLK0			60
+#define CLKID_SD_EMMC_B_CLK0			61
+#define CLKID_SD_EMMC_C_CLK0			62
+#define CLKID_HIFI_PLL				74
+#define CLKID_VCLK2_VENCI0			80
+#define CLKID_VCLK2_VENCI1			81
+#define CLKID_VCLK2_VENCP0			82
+#define CLKID_VCLK2_VENCP1			83
+#define CLKID_VCLK2_VENCT0			84
+#define CLKID_VCLK2_VENCT1			85
+#define CLKID_VCLK2_OTHER			86
+#define CLKID_VCLK2_ENCI			87
+#define CLKID_VCLK2_ENCP			88
+#define CLKID_DAC_CLK				89
+#define CLKID_AOCLK				90
+#define CLKID_IEC958				91
+#define CLKID_ENC480P				92
+#define CLKID_RNG1				93
+#define CLKID_VCLK2_ENCT			94
+#define CLKID_VCLK2_ENCL			95
+#define CLKID_VCLK2_VENCLMMC			96
+#define CLKID_VCLK2_VENCL			97
+#define CLKID_VCLK2_OTHER1			98
+#define CLKID_FCLK_DIV2P5			99
+#define CLKID_DMA				105
+#define CLKID_EFUSE				106
+#define CLKID_ROM_BOOT				107
+#define CLKID_RESET_SEC				108
+#define CLKID_SEC_AHB_APB3			109
+#define CLKID_VPU_0_SEL				110
+#define CLKID_VPU_0				112
+#define CLKID_VPU_1_SEL				113
+#define CLKID_VPU_1				115
+#define CLKID_VPU				116
+#define CLKID_VAPB_0_SEL			117
+#define CLKID_VAPB_0				119
+#define CLKID_VAPB_1_SEL			120
+#define CLKID_VAPB_1				122
+#define CLKID_VAPB_SEL				123
+#define CLKID_VAPB				124
+#define CLKID_HDMI_PLL				128
+#define CLKID_VID_PLL				129
+#define CLKID_VCLK				138
+#define CLKID_VCLK2				139
+#define CLKID_VCLK_DIV1				148
+#define CLKID_VCLK_DIV2				149
+#define CLKID_VCLK_DIV4				150
+#define CLKID_VCLK_DIV6				151
+#define CLKID_VCLK_DIV12			152
+#define CLKID_VCLK2_DIV1			153
+#define CLKID_VCLK2_DIV2			154
+#define CLKID_VCLK2_DIV4			155
+#define CLKID_VCLK2_DIV6			156
+#define CLKID_VCLK2_DIV12			157
+#define CLKID_CTS_ENCI				162
+#define CLKID_CTS_ENCP				163
+#define CLKID_CTS_VDAC				164
+#define CLKID_HDMI_TX				165
+#define CLKID_HDMI				168
+#define CLKID_MALI_0_SEL			169
+#define CLKID_MALI_0				171
+#define CLKID_MALI_1_SEL			172
+#define CLKID_MALI_1				174
+#define CLKID_MALI				175
+#define CLKID_MPLL_5OM				177
+
+#endif /* __G12A_CLKC_H */
diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
new file mode 100644
index 0000000000..f7bd69350d
--- /dev/null
+++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_G12A_GPIO_H
+#define _DT_BINDINGS_MESON_G12A_GPIO_H
+
+/* First GPIO chip */
+#define GPIOAO_0	0
+#define GPIOAO_1	1
+#define GPIOAO_2	2
+#define GPIOAO_3	3
+#define GPIOAO_4	4
+#define GPIOAO_5	5
+#define GPIOAO_6	6
+#define GPIOAO_7	7
+#define GPIOAO_8	8
+#define GPIOAO_9	9
+#define GPIOAO_10	10
+#define GPIOAO_11	11
+#define GPIOE_0		12
+#define GPIOE_1		13
+#define GPIOE_2		14
+
+/* Second GPIO chip */
+#define GPIOZ_0		0
+#define GPIOZ_1		1
+#define GPIOZ_2		2
+#define GPIOZ_3		3
+#define GPIOZ_4		4
+#define GPIOZ_5		5
+#define GPIOZ_6		6
+#define GPIOZ_7		7
+#define GPIOZ_8		8
+#define GPIOZ_9		9
+#define GPIOZ_10	10
+#define GPIOZ_11	11
+#define GPIOZ_12	12
+#define GPIOZ_13	13
+#define GPIOZ_14	14
+#define GPIOZ_15	15
+#define GPIOH_0		16
+#define GPIOH_1		17
+#define GPIOH_2		18
+#define GPIOH_3		19
+#define GPIOH_4		20
+#define GPIOH_5		21
+#define GPIOH_6		22
+#define GPIOH_7		23
+#define GPIOH_8		24
+#define BOOT_0		25
+#define BOOT_1		26
+#define BOOT_2		27
+#define BOOT_3		28
+#define BOOT_4		29
+#define BOOT_5		30
+#define BOOT_6		31
+#define BOOT_7		32
+#define BOOT_8		33
+#define BOOT_9		34
+#define BOOT_10		35
+#define BOOT_11		36
+#define BOOT_12		37
+#define BOOT_13		38
+#define BOOT_14		39
+#define BOOT_15		40
+#define GPIOC_0		41
+#define GPIOC_1		42
+#define GPIOC_2		43
+#define GPIOC_3		44
+#define GPIOC_4		45
+#define GPIOC_5		46
+#define GPIOC_6		47
+#define GPIOC_7		48
+#define GPIOA_0		49
+#define GPIOA_1		50
+#define GPIOA_2		51
+#define GPIOA_3		52
+#define GPIOA_4		53
+#define GPIOA_5		54
+#define GPIOA_6		55
+#define GPIOA_7		56
+#define GPIOA_8		57
+#define GPIOA_9		58
+#define GPIOA_10	59
+#define GPIOA_11	60
+#define GPIOA_12	61
+#define GPIOA_13	62
+#define GPIOA_14	63
+#define GPIOA_15	64
+#define GPIOX_0		65
+#define GPIOX_1		66
+#define GPIOX_2		67
+#define GPIOX_3		68
+#define GPIOX_4		69
+#define GPIOX_5		70
+#define GPIOX_6		71
+#define GPIOX_7		72
+#define GPIOX_8		73
+#define GPIOX_9		74
+#define GPIOX_10	75
+#define GPIOX_11	76
+#define GPIOX_12	77
+#define GPIOX_13	78
+#define GPIOX_14	79
+#define GPIOX_15	80
+#define GPIOX_16	81
+#define GPIOX_17	82
+#define GPIOX_18	83
+#define GPIOX_19	84
+
+#endif /* _DT_BINDINGS_MESON_G12A_GPIO_H */
diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
new file mode 100644
index 0000000000..8063e8314e
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
+
+/*	RESET0					*/
+#define RESET_HIU			0
+/*					1	*/
+#define RESET_DOS			2
+/*					3-4	*/
+#define RESET_VIU			5
+#define RESET_AFIFO			6
+#define RESET_VID_PLL_DIV		7
+/*					8-9	*/
+#define RESET_VENC			10
+#define RESET_ASSIST			11
+#define RESET_PCIE_CTRL_A		12
+#define RESET_VCBUS			13
+#define RESET_PCIE_PHY			14
+#define RESET_PCIE_APB			15
+#define RESET_GIC			16
+#define RESET_CAPB3_DECODE		17
+/*					18	*/
+#define RESET_HDMITX_CAPB3		19
+#define RESET_DVALIN_CAPB3		20
+#define RESET_DOS_CAPB3			21
+/*					22	*/
+#define RESET_CBUS_CAPB3		23
+#define RESET_AHB_CNTL			24
+#define RESET_AHB_DATA			25
+#define RESET_VCBUS_CLK81		26
+/*					27-31	*/
+/*	RESET1					*/
+/*					32	*/
+#define RESET_DEMUX			33
+#define RESET_USB			34
+#define RESET_DDR			35
+/*					36	*/
+#define RESET_BT656			37
+#define RESET_AHB_SRAM			38
+/*					39	*/
+#define RESET_PARSER			40
+/*					41	*/
+#define RESET_ISA			42
+#define RESET_ETHERNET			43
+#define RESET_SD_EMMC_A			44
+#define RESET_SD_EMMC_B			45
+#define RESET_SD_EMMC_C			46
+/*					47-60 */
+#define RESET_AUDIO_CODEC		61
+/*					62-63	*/
+/*	RESET2					*/
+/*					64	*/
+#define RESET_AUDIO			65
+#define RESET_HDMITX_PHY		66
+/*					67	*/
+#define RESET_MIPI_DSI_HOST		68
+#define RESET_ALOCKER			69
+#define RESET_GE2D			70
+#define RESET_PARSER_REG		71
+#define RESET_PARSER_FETCH		72
+#define RESET_CTL			73
+#define RESET_PARSER_TOP		74
+/*					75-77	*/
+#define RESET_DVALIN			78
+#define RESET_HDMITX			79
+/*					80-95	*/
+/*	RESET3					*/
+/*					96-95	*/
+#define RESET_DEMUX_TOP			105
+#define RESET_DEMUX_DES_PL		106
+#define RESET_DEMUX_S2P_0		107
+#define RESET_DEMUX_S2P_1		108
+#define RESET_DEMUX_0			109
+#define RESET_DEMUX_1			110
+#define RESET_DEMUX_2			111
+/*					112-127	*/
+/*	RESET4					*/
+/*					128-129	*/
+#define RESET_MIPI_DSI_PHY		130
+/*					131-132	*/
+#define RESET_RDMA			133
+#define RESET_VENCI			134
+#define RESET_VENCP			135
+/*					136	*/
+#define RESET_VDAC			137
+/*					138-139 */
+#define RESET_VDI6			140
+#define RESET_VENCL			141
+#define RESET_I2C_M1			142
+#define RESET_I2C_M2			143
+/*					144-159	*/
+/*	RESET5					*/
+/*					160-191	*/
+/*	RESET6					*/
+#define RESET_GEN			192
+#define RESET_SPICC0			193
+#define RESET_SC			194
+#define RESET_SANA_3			195
+#define RESET_I2C_M0			196
+#define RESET_TS_PLL			197
+#define RESET_SPICC1			198
+#define RESET_STREAM			199
+#define RESET_TS_CPU			200
+#define RESET_UART0			201
+#define RESET_UART1_2			202
+#define RESET_ASYNC0			203
+#define RESET_ASYNC1			204
+#define RESET_SPIFC0			205
+#define RESET_I2C_M3			206
+/*					207-223	*/
+/*	RESET7					*/
+#define RESET_USB_DDR_0			224
+#define RESET_USB_DDR_1			225
+#define RESET_USB_DDR_2			226
+#define RESET_USB_DDR_3			227
+#define RESET_TS_GPU			228
+#define RESET_DEVICE_MMC_ARB		229
+#define RESET_DVALIN_DMC_PIPL		230
+#define RESET_VID_LOCK			231
+#define RESET_NIC_DMC_PIPL		232
+#define RESET_DMC_VPU_PIPL		233
+#define RESET_GE2D_DMC_PIPL		234
+#define RESET_HCODEC_DMC_PIPL		235
+#define RESET_WAVE420_DMC_PIPL		236
+#define RESET_HEVCF_DMC_PIPL		237
+/*					238-255	*/
+
+#endif
diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-bindings/reset/g12a-aoclkc.h
new file mode 100644
index 0000000000..bd2e233713
--- /dev/null
+++ b/include/dt-bindings/reset/g12a-aoclkc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+
+#define RESET_AO_IR_IN		0
+#define RESET_AO_UART		1
+#define RESET_AO_I2C_M		2
+#define RESET_AO_I2C_S		3
+#define RESET_AO_SAR_ADC	4
+#define RESET_AO_UART2		5
+#define RESET_AO_IR_OUT		6
+
+#endif
-- 
2.21.0

