Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF2D42B9B
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.86295.1731416338056654931
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Nov 2024 04:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=LkTkhbeI;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 950B3120009;
	Tue, 12 Nov 2024 15:58:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 950B3120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731416335;
	bh=M1/27UQFJYX2mv1LdPJCpITY8WG5YKsuw+fpAC4aIkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LkTkhbeIuG+4PPWSEp7VZWwDLwzSUsTlgfoJZdVeqekr9DG2OjwUfPB1QRr10EyKU
	 hctJ7El5kiB8zd8mQ0KbXVaDPzz8835CuB+xfvIcViQAOtoWJ8Y9kFJbmD537dzUl+
	 D8AQWxH6vkKtS5oCqe/i5VJFiI0j3KqqopZfqngKK/UfEd048fUqEqtwO4G8IXw1kl
	 Z3coeHGooAUg7lpbze2omG/Uevdu1uNaXShSaDpwbCni/LHFLHnQu/FyctnJBJj3CJ
	 p/bhxVxzwBMuHDlgWJcJ2mr8q8+CzumeZ7osVtBPvzEE1K3591MtMgSTi1OPjROmTB
	 OfVyAJIGlwdYw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Nov 2024 15:58:55 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 1/4] arm: dts: meson: remove meson-a1.dtsi
Date: Tue, 12 Nov 2024 15:58:33 +0300
Message-ID: <20241112125836.3239832-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.130.77]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189115 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 09:54:00 #26847665
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2545

For Amlogic A1, we have to use dtsi from dts/upstream folder.
The only difference between this two files is the added cpu temperature
node definition in upstream version and additional assigned-clock for
USB. This patch is tested on a device with A113L SoC (AD401-like) and
everything is okay.

So, we can remove legacy arch/arm/dts/meson-a1.dtsi file.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/dts/meson-a1.dtsi | 518 -------------------------------------
 1 file changed, 518 deletions(-)
 delete mode 100644 arch/arm/dts/meson-a1.dtsi

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
deleted file mode 100644
index 648e7f4942..0000000000
--- a/arch/arm/dts/meson-a1.dtsi
+++ /dev/null
@@ -1,518 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- */
-
-#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
-#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
-#include <dt-bindings/gpio/meson-a1-gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/power/meson-a1-power.h>
-#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
-
-/ {
-	compatible =3D "amlogic,a1";
-
-	interrupt-parent =3D <&gic>;
-	#address-cells =3D <2>;
-	#size-cells =3D <2>;
-
-	cpus {
-		#address-cells =3D <2>;
-		#size-cells =3D <0>;
-
-		cpu0: cpu@0 {
-			device_type =3D "cpu";
-			compatible =3D "arm,cortex-a35";
-			reg =3D <0x0 0x0>;
-			enable-method =3D "psci";
-			next-level-cache =3D <&l2>;
-		};
-
-		cpu1: cpu@1 {
-			device_type =3D "cpu";
-			compatible =3D "arm,cortex-a35";
-			reg =3D <0x0 0x1>;
-			enable-method =3D "psci";
-			next-level-cache =3D <&l2>;
-		};
-
-		l2: l2-cache0 {
-			compatible =3D "cache";
-			cache-level =3D <2>;
-			cache-unified;
-		};
-	};
-
-	efuse: efuse {
-		compatible =3D "amlogic,meson-gxbb-efuse";
-		clocks =3D <&clkc_periphs CLKID_OTP>;
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
-		secure-monitor =3D <&sm>;
-		power-domains =3D <&pwrc PWRC_OTP_ID>;
-	};
-
-	psci {
-		compatible =3D "arm,psci-1.0";
-		method =3D "smc";
-	};
-
-	reserved-memory {
-		#address-cells =3D <2>;
-		#size-cells =3D <2>;
-		ranges;
-
-		linux,cma {
-			compatible =3D "shared-dma-pool";
-			reusable;
-			size =3D <0x0 0x800000>;
-			alignment =3D <0x0 0x400000>;
-			linux,cma-default;
-		};
-	};
-
-	sm: secure-monitor {
-		compatible =3D "amlogic,meson-gxbb-sm";
-
-		pwrc: power-controller {
-			compatible =3D "amlogic,meson-a1-pwrc";
-			#power-domain-cells =3D <1>;
-		};
-	};
-
-	soc {
-		compatible =3D "simple-bus";
-		#address-cells =3D <2>;
-		#size-cells =3D <2>;
-		ranges;
-
-		spifc: spi@fd000400 {
-			compatible =3D "amlogic,a1-spifc";
-			reg =3D <0x0 0xfd000400 0x0 0x290>;
-			clocks =3D <&clkc_periphs CLKID_SPIFC>;
-			#address-cells =3D <1>;
-			#size-cells =3D <0>;
-			power-domains =3D <&pwrc PWRC_SPIFC_ID>;
-			status =3D "disabled";
-		};
-
-		apb: bus@fe000000 {
-			compatible =3D "simple-bus";
-			reg =3D <0x0 0xfe000000 0x0 0x1000000>;
-			#address-cells =3D <2>;
-			#size-cells =3D <2>;
-			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
-
-			reset: reset-controller@0 {
-				compatible =3D "amlogic,meson-a1-reset";
-				reg =3D <0x0 0x0 0x0 0x8c>;
-				#reset-cells =3D <1>;
-			};
-
-			periphs_pinctrl: pinctrl@400 {
-				compatible =3D "amlogic,meson-a1-periphs-pinctrl";
-				#address-cells =3D <2>;
-				#size-cells =3D <2>;
-				ranges;
-
-				gpio: bank@400 {
-					reg =3D <0x0 0x0400 0x0 0x003c>,
-					      <0x0 0x0480 0x0 0x0118>;
-					reg-names =3D "mux", "gpio";
-					gpio-controller;
-					#gpio-cells =3D <2>;
-					gpio-ranges =3D <&periphs_pinctrl 0 0 62>;
-				};
-
-				i2c0_f11_pins: i2c0-f11 {
-					mux {
-						groups =3D "i2c0_sck_f11",
-							 "i2c0_sda_f12";
-						function =3D "i2c0";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c0_f9_pins: i2c0-f9 {
-					mux {
-						groups =3D "i2c0_sck_f9",
-							 "i2c0_sda_f10";
-						function =3D "i2c0";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c1_x_pins: i2c1-x {
-					mux {
-						groups =3D "i2c1_sck_x",
-							 "i2c1_sda_x";
-						function =3D "i2c1";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c1_a_pins: i2c1-a {
-					mux {
-						groups =3D "i2c1_sck_a",
-							 "i2c1_sda_a";
-						function =3D "i2c1";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c2_x0_pins: i2c2-x0 {
-					mux {
-						groups =3D "i2c2_sck_x0",
-							 "i2c2_sda_x1";
-						function =3D "i2c2";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c2_x15_pins: i2c2-x15 {
-					mux {
-						groups =3D "i2c2_sck_x15",
-							 "i2c2_sda_x16";
-						function =3D "i2c2";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c2_a4_pins: i2c2-a4 {
-					mux {
-						groups =3D "i2c2_sck_a4",
-							 "i2c2_sda_a5";
-						function =3D "i2c2";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c2_a8_pins: i2c2-a8 {
-					mux {
-						groups =3D "i2c2_sck_a8",
-							 "i2c2_sda_a9";
-						function =3D "i2c2";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c3_x_pins: i2c3-x {
-					mux {
-						groups =3D "i2c3_sck_x",
-							 "i2c3_sda_x";
-						function =3D "i2c3";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				i2c3_f_pins: i2c3-f {
-					mux {
-						groups =3D "i2c3_sck_f",
-							 "i2c3_sda_f";
-						function =3D "i2c3";
-						bias-pull-up;
-						drive-strength-microamp =3D <3000>;
-					};
-				};
-
-				uart_a_pins: uart-a {
-					mux {
-						groups =3D "uart_a_tx",
-							 "uart_a_rx";
-						function =3D "uart_a";
-					};
-				};
-
-				uart_a_cts_rts_pins: uart-a-cts-rts {
-					mux {
-						groups =3D "uart_a_cts",
-							 "uart_a_rts";
-						function =3D "uart_a";
-						bias-pull-down;
-					};
-				};
-
-				sdio_pins: sdio {
-					mux0 {
-						groups =3D "sdcard_d0_x",
-							 "sdcard_d1_x",
-							 "sdcard_d2_x",
-							 "sdcard_d3_x",
-							 "sdcard_cmd_x";
-						function =3D "sdcard";
-						bias-pull-up;
-					};
-
-					mux1 {
-						groups =3D "sdcard_clk_x";
-						function =3D "sdcard";
-						bias-disable;
-					};
-				};
-
-				sdio_clk_gate_pins: sdio-clk-gate {
-					mux {
-						groups =3D "sdcard_clk_x";
-						function =3D "sdcard";
-						bias-pull-down;
-					};
-				};
-
-				spifc_pins: spifc {
-					mux {
-						groups =3D "spif_mo",
-							 "spif_mi",
-							 "spif_clk",
-							 "spif_cs",
-							 "spif_hold_n",
-							 "spif_wp_n";
-						function =3D "spif";
-					};
-				};
-			};
-
-			gpio_intc: interrupt-controller@440 {
-				compatible =3D "amlogic,meson-a1-gpio-intc",
-					     "amlogic,meson-gpio-intc";
-				reg =3D <0x0 0x0440 0x0 0x14>;
-				interrupt-controller;
-				#interrupt-cells =3D <2>;
-				amlogic,channel-interrupts =3D
-					<49 50 51 52 53 54 55 56>;
-			};
-
-			clkc_periphs: clock-controller@800 {
-				compatible =3D "amlogic,a1-peripherals-clkc";
-				reg =3D <0 0x800 0 0x104>;
-				#clock-cells =3D <1>;
-				clocks =3D <&clkc_pll CLKID_FCLK_DIV2>,
-					 <&clkc_pll CLKID_FCLK_DIV3>,
-					 <&clkc_pll CLKID_FCLK_DIV5>,
-					 <&clkc_pll CLKID_FCLK_DIV7>,
-					 <&clkc_pll CLKID_HIFI_PLL>,
-					 <&xtal>;
-				clock-names =3D "fclk_div2", "fclk_div3",
-					      "fclk_div5", "fclk_div7",
-					      "hifi_pll", "xtal";
-			};
-
-			i2c0: i2c@1400 {
-				compatible =3D "amlogic,meson-axg-i2c";
-				status =3D "disabled";
-				reg =3D <0x0 0x1400 0x0 0x20>;
-				interrupts =3D <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
-				#address-cells =3D <1>;
-				#size-cells =3D <0>;
-				clocks =3D <&clkc_periphs CLKID_I2C_M_A>;
-				power-domains =3D <&pwrc PWRC_I2C_ID>;
-			};
-
-			uart_AO: serial@1c00 {
-				compatible =3D "amlogic,meson-a1-uart",
-					     "amlogic,meson-ao-uart";
-				reg =3D <0x0 0x1c00 0x0 0x18>;
-				interrupts =3D <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
-				clocks =3D <&xtal>, <&xtal>, <&xtal>;
-				clock-names =3D "xtal", "pclk", "baud";
-				status =3D "disabled";
-			};
-
-			uart_AO_B: serial@2000 {
-				compatible =3D "amlogic,meson-a1-uart",
-					     "amlogic,meson-ao-uart";
-				reg =3D <0x0 0x2000 0x0 0x18>;
-				interrupts =3D <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-				clocks =3D <&xtal>, <&xtal>, <&xtal>;
-				clock-names =3D "xtal", "pclk", "baud";
-				status =3D "disabled";
-			};
-
-			saradc: adc@2c00 {
-				compatible =3D "amlogic,meson-g12a-saradc",
-					"amlogic,meson-saradc";
-				reg =3D <0x0 0x2c00 0x0 0x48>;
-				#io-channel-cells =3D <1>;
-				power-domains =3D <&pwrc PWRC_I2C_ID>;
-				interrupts =3D <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
-				clocks =3D <&xtal>,
-					<&clkc_periphs CLKID_SARADC_EN>,
-					<&clkc_periphs CLKID_SARADC>,
-					<&clkc_periphs CLKID_SARADC_SEL>;
-				clock-names =3D "clkin", "core",
-					"adc_clk", "adc_sel";
-				status =3D "disabled";
-			};
-
-			i2c1: i2c@5c00 {
-				compatible =3D "amlogic,meson-axg-i2c";
-				status =3D "disabled";
-				reg =3D <0x0 0x5c00 0x0 0x20>;
-				interrupts =3D <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
-				#address-cells =3D <1>;
-				#size-cells =3D <0>;
-				clocks =3D <&clkc_periphs CLKID_I2C_M_B>;
-				power-domains =3D <&pwrc PWRC_I2C_ID>;
-			};
-
-			i2c2: i2c@6800 {
-				compatible =3D "amlogic,meson-axg-i2c";
-				status =3D "disabled";
-				reg =3D <0x0 0x6800 0x0 0x20>;
-				interrupts =3D <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>;
-				#address-cells =3D <1>;
-				#size-cells =3D <0>;
-				clocks =3D <&clkc_periphs CLKID_I2C_M_C>;
-				power-domains =3D <&pwrc PWRC_I2C_ID>;
-			};
-
-			i2c3: i2c@6c00 {
-				compatible =3D "amlogic,meson-axg-i2c";
-				status =3D "disabled";
-				reg =3D <0x0 0x6c00 0x0 0x20>;
-				interrupts =3D <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
-				#address-cells =3D <1>;
-				#size-cells =3D <0>;
-				clocks =3D <&clkc_periphs CLKID_I2C_M_D>;
-				power-domains =3D <&pwrc PWRC_I2C_ID>;
-			};
-
-			usb2_phy1: phy@4000 {
-				compatible =3D "amlogic,a1-usb2-phy";
-				clocks =3D <&clkc_periphs CLKID_USB_PHY_IN>;
-				clock-names =3D "xtal";
-				reg =3D <0x0 0x4000 0x0 0x60>;
-				resets =3D <&reset RESET_USBPHY>;
-				reset-names =3D "phy";
-				#phy-cells =3D <0>;
-				power-domains =3D <&pwrc PWRC_USB_ID>;
-			};
-
-			hwrng: rng@5118 {
-				compatible =3D "amlogic,meson-rng";
-				reg =3D <0x0 0x5118 0x0 0x4>;
-				power-domains =3D <&pwrc PWRC_OTP_ID>;
-			};
-
-			sec_AO: ao-secure@5a20 {
-				compatible =3D "amlogic,meson-gx-ao-secure", "syscon";
-				reg =3D <0x0 0x5a20 0x0 0x140>;
-				amlogic,has-chip-id;
-			};
-
-			clkc_pll: pll-clock-controller@7c80 {
-				compatible =3D "amlogic,a1-pll-clkc";
-				reg =3D <0 0x7c80 0 0x18c>;
-				#clock-cells =3D <1>;
-				clocks =3D <&clkc_periphs CLKID_FIXPLL_IN>,
-					 <&clkc_periphs CLKID_HIFIPLL_IN>;
-				clock-names =3D "fixpll_in", "hifipll_in";
-			};
-
-			sd_emmc: sd@10000 {
-				compatible =3D "amlogic,meson-axg-mmc";
-				reg =3D <0x0 0x10000 0x0 0x800>;
-				interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clkc_periphs CLKID_SD_EMMC_A>,
-					 <&clkc_periphs CLKID_SD_EMMC>,
-					 <&clkc_pll CLKID_FCLK_DIV2>;
-				clock-names =3D "core",
-					      "clkin0",
-					      "clkin1";
-				assigned-clocks =3D <&clkc_periphs CLKID_SD_EMMC_SEL2>;
-				assigned-clock-parents =3D <&xtal>;
-				resets =3D <&reset RESET_SD_EMMC_A>;
-				power-domains =3D <&pwrc PWRC_SD_EMMC_ID>;
-				status =3D "disabled";
-			};
-		};
-
-		usb: usb@fe004400 {
-			status =3D "disabled";
-			compatible =3D "amlogic,meson-a1-usb-ctrl";
-			reg =3D <0x0 0xfe004400 0x0 0xa0>;
-			interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells =3D <2>;
-			#size-cells =3D <2>;
-			ranges;
-
-			clocks =3D <&clkc_periphs CLKID_USB_CTRL>,
-				 <&clkc_periphs CLKID_USB_BUS>,
-				 <&clkc_periphs CLKID_USB_CTRL_IN>;
-			clock-names =3D "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
-			resets =3D <&reset RESET_USBCTRL>;
-			reset-name =3D "usb_ctrl";
-
-			dr_mode =3D "otg";
-
-			phys =3D <&usb2_phy1>;
-			phy-names =3D "usb2-phy1";
-
-			dwc3: usb@ff400000 {
-				compatible =3D "snps,dwc3";
-				reg =3D <0x0 0xff400000 0x0 0x100000>;
-				interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode =3D "host";
-				snps,dis_u2_susphy_quirk;
-				snps,quirk-frame-length-adjustment =3D <0x20>;
-				snps,parkmode-disable-ss-quirk;
-			};
-
-			dwc2: usb@ff500000 {
-				compatible =3D "amlogic,meson-a1-usb", "snps,dwc2";
-				reg =3D <0x0 0xff500000 0x0 0x40000>;
-				interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-				phys =3D <&usb2_phy1>;
-				phy-names =3D "usb2-phy";
-				clocks =3D <&clkc_periphs CLKID_USB_PHY>;
-				clock-names =3D "otg";
-				dr_mode =3D "peripheral";
-				g-rx-fifo-size =3D <192>;
-				g-np-tx-fifo-size =3D <128>;
-				g-tx-fifo-size =3D <128 128 16 16 16>;
-			};
-		};
-
-		gic: interrupt-controller@ff901000 {
-			compatible =3D "arm,gic-400";
-			reg =3D <0x0 0xff901000 0x0 0x1000>,
-			      <0x0 0xff902000 0x0 0x2000>,
-			      <0x0 0xff904000 0x0 0x2000>,
-			      <0x0 0xff906000 0x0 0x2000>;
-			interrupt-controller;
-			interrupts =3D <GIC_PPI 9
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-			#interrupt-cells =3D <3>;
-			#address-cells =3D <0>;
-		};
-	};
-
-	timer {
-		compatible =3D "arm,armv8-timer";
-		interrupts =3D <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	xtal: xtal-clk {
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <24000000>;
-		clock-output-names =3D "xtal";
-		#clock-cells =3D <0>;
-	};
-};
--=20
2.34.1


