Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.21180.1683269538806806020
 for <u-boot-amlogic@groups.io>;
 Thu, 04 May 2023 23:52:19 -0700
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso9205035e9.3
        for <u-boot-amlogic@groups.io>; Thu, 04 May 2023 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269537; x=1685861537;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+XnwQQ3Rkc8KzOAPMyGWftVh32BRApUBjXezWe6kyI=;
        b=UDBu7fV+ErmJdAtELxQU+hPL8qyZEBBjYG6sBnyGS+pn6bslOHumqJ89pHFgW5OBNc
         1vKFAogzMGqQrd+fIT3k89VzFUN2Vp+gYxO1w21OqCp+98WNQQ0CeLIHXeTA6xu8mNow
         xl/FAY87zKLRH89YViYdq4elDD0alepOY5nGi5quGnSdEwAaQsnGDS2AHGL1uaOGrqe+
         eOD6Q7hdZHErVFBJa8QfwWYxmQTf9Epjex7OlBycndfaevSO0iPDzEoxiA6UMe0ZIzVX
         WjUWv0bEAPiMLXkDEeEOTnY4jbxEOgeYy1+CF834r4HCEXxCpP3q/BQe8hkCS78RniaL
         mBuQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3ad2726d-3341-0c6c-85f9-18c06214b97f@linaro.org>
Date: Fri, 5 May 2023 08:52:16 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1 1/5] ARM: dts: Add Amlogic Meson A1 DT from Linux 6.3-rc7
References: <20230424180151.9524-1-ivprusov@sberdevices.ru>
 <20230424180151.9524-2-ivprusov@sberdevices.ru>
In-Reply-To: <20230424180151.9524-2-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@sberdevices.ru>
Cc: kernel@sberdevices.ru, prusovigor@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2023 20:01, Igor Prusov wrote:
> Import Linux 6.3-rc7 Device tree and necessary bindings for Amlogic A1
> board from 6a8f57ae2eb0 ("Linux 6.3-rc7").
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   arch/arm/dts/meson-a1.dtsi               | 161 +++++++++++++++++++++++
>   include/dt-bindings/gpio/meson-a1-gpio.h |  73 ++++++++++
>   2 files changed, 234 insertions(+)
>   create mode 100644 arch/arm/dts/meson-a1.dtsi
>   create mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h
> 
> diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> new file mode 100644
> index 0000000000..6509329b85
> --- /dev/null
> +++ b/arch/arm/dts/meson-a1.dtsi
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/meson-a1-gpio.h>
> +
> +/ {
> +	compatible = "amlogic,a1";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0x800000>;
> +			alignment = <0x0 0x400000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,meson-a1-pwrc";
> +			#power-domain-cells = <1>;
> +			status = "okay";
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		apb: bus@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x1000000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
> +
> +			reset: reset-controller@0 {
> +				compatible = "amlogic,meson-a1-reset";
> +				reg = <0x0 0x0 0x0 0x8c>;
> +				#reset-cells = <1>;
> +			};
> +
> +			periphs_pinctrl: pinctrl@400 {
> +				compatible = "amlogic,meson-a1-periphs-pinctrl";
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +				ranges;
> +
> +				gpio: bank@400 {
> +					reg = <0x0 0x0400 0x0 0x003c>,
> +					      <0x0 0x0480 0x0 0x0118>;
> +					reg-names = "mux", "gpio";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&periphs_pinctrl 0 0 62>;
> +				};
> +
> +			};
> +
> +			uart_AO: serial@1c00 {
> +				compatible = "amlogic,meson-gx-uart",
> +					     "amlogic,meson-ao-uart";
> +				reg = <0x0 0x1c00 0x0 0x18>;
> +				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_AO_B: serial@2000 {
> +				compatible = "amlogic,meson-gx-uart",
> +					     "amlogic,meson-ao-uart";
> +				reg = <0x0 0x2000 0x0 0x18>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +		};
> +
> +		gic: interrupt-controller@ff901000 {
> +			compatible = "arm,gic-400";
> +			reg = <0x0 0xff901000 0x0 0x1000>,
> +			      <0x0 0xff902000 0x0 0x2000>,
> +			      <0x0 0xff904000 0x0 0x2000>,
> +			      <0x0 0xff906000 0x0 0x2000>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +};
> diff --git a/include/dt-bindings/gpio/meson-a1-gpio.h b/include/dt-bindings/gpio/meson-a1-gpio.h
> new file mode 100644
> index 0000000000..40e57a5ff1
> --- /dev/null
> +++ b/include/dt-bindings/gpio/meson-a1-gpio.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Qianggui Song <qianggui.song@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_MESON_A1_GPIO_H
> +#define _DT_BINDINGS_MESON_A1_GPIO_H
> +
> +#define GPIOP_0		0
> +#define GPIOP_1		1
> +#define GPIOP_2		2
> +#define GPIOP_3		3
> +#define GPIOP_4		4
> +#define GPIOP_5		5
> +#define GPIOP_6		6
> +#define GPIOP_7		7
> +#define GPIOP_8		8
> +#define GPIOP_9		9
> +#define GPIOP_10	10
> +#define GPIOP_11	11
> +#define GPIOP_12	12
> +#define GPIOB_0		13
> +#define GPIOB_1		14
> +#define GPIOB_2		15
> +#define GPIOB_3		16
> +#define GPIOB_4		17
> +#define GPIOB_5		18
> +#define GPIOB_6		19
> +#define GPIOX_0		20
> +#define GPIOX_1		21
> +#define GPIOX_2		22
> +#define GPIOX_3		23
> +#define GPIOX_4		24
> +#define GPIOX_5		25
> +#define GPIOX_6		26
> +#define GPIOX_7		27
> +#define GPIOX_8		28
> +#define GPIOX_9		29
> +#define GPIOX_10	30
> +#define GPIOX_11	31
> +#define GPIOX_12	32
> +#define GPIOX_13	33
> +#define GPIOX_14	34
> +#define GPIOX_15	35
> +#define GPIOX_16	36
> +#define GPIOF_0		37
> +#define GPIOF_1		38
> +#define GPIOF_2		39
> +#define GPIOF_3		40
> +#define GPIOF_4		41
> +#define GPIOF_5		42
> +#define GPIOF_6		43
> +#define GPIOF_7		44
> +#define GPIOF_8		45
> +#define GPIOF_9		46
> +#define GPIOF_10	47
> +#define GPIOF_11	48
> +#define GPIOF_12	49
> +#define GPIOA_0		50
> +#define GPIOA_1		51
> +#define GPIOA_2		52
> +#define GPIOA_3		53
> +#define GPIOA_4		54
> +#define GPIOA_5		55
> +#define GPIOA_6		56
> +#define GPIOA_7		57
> +#define GPIOA_8		58
> +#define GPIOA_9		59
> +#define GPIOA_10	60
> +#define GPIOA_11	61
> +
> +#endif /* _DT_BINDINGS_MESON_A1_GPIO_H */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
