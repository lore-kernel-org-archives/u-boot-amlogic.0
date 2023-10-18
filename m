Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB9CDB483
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:43:55 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.276286.1697615028959657463
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:43:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=R7Yk2vWx;
 spf=pass (domain: linaro.org, ip: 209.85.221.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-323168869daso5869081f8f.2
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697615027; x=1698219827; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eXIxS6KrhrFL7VN31z7xlI6kDKbeps7I3pbGPHTitE=;
        b=R7Yk2vWxsujPlKh8rpLoAwGVhs8WWfcUoSQOh4sKbiHjRNEXWtdUZD/ZEQhR4kKtP5
         ywgD0kdJHqrKbgt4aVMcdhTx7m5/wZu3acu3gxvHFdt3Er0KMmx6PV8LrUqNqJbh94Jt
         anKdLh1745N2a/k/tJ08RwU+N6f2gUY/9LvwCAdv37XYINc8eaZsSr+IpyXYvM64DMWP
         N7/QRnm/JPA5FsNsLsyZhU3mORQUBaZct9rLY0ia7xBAVhmePSDLKpCnDGWS9v1vGVX7
         7HKMukSUb9dXpWH0gDag2QjEK2TvdC4BSTGDU0Q6YGBGb/e036/Bj4X75AtONoVywXt/
         qxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615027; x=1698219827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7eXIxS6KrhrFL7VN31z7xlI6kDKbeps7I3pbGPHTitE=;
        b=ZRndX40LlwH/sNg0o/LdjtScjqQ1Vst5s4kRF3Ai5y9yhzQ0F5ekay00gF2ZycRbpe
         1wSRx2JJuf4eXGSbdoYhdCq82TY2QlzT/0N/tknpBGRVH1fqgkDIey/LgRYEO8rTl0TF
         AZM6gDvMD9vVsWtAGWnkAScKgsXaneiXVpyeG08EV8/wisZTYq5klcd2mK0HH4Z0kSwi
         n0X9AfbgRAgWOjHf/ZrAmYhAIsundiFqYS6mk0oWtPWOSV3YjSdd5IGAqnJpWoTYSYjq
         GvS1phEbCubbJtgNFttlanlj/PzoipMNSTBDehkf4F5NnOTJt5RLMJTy/ajbrU3oEdu+
         h+kA==
X-Gm-Message-State: AOJu0YyEwbj3SZpzVCnigsE0HZFNtVsu7cGnqC3/na3vIL45HqBu3tdM
	gBJmIDL+BFohh3gjAcQrPOabrA==
X-Google-Smtp-Source: AGHT+IFiLuU8UIHK2cebySqmCRKQPMCPATx6w9h7Q8va4v31d4TWKXMDKrrVFMkSS0tbzR5IdHPJJw==
X-Received: by 2002:adf:e28d:0:b0:320:8d6:74f5 with SMTP id v13-20020adfe28d000000b0032008d674f5mr2982344wri.28.1697615027254;
        Wed, 18 Oct 2023 00:43:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05? ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
        by smtp.gmail.com with ESMTPSA id f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:43:46 -0700 (PDT)
Message-ID: <0410f762-384f-48be-a562-4ab65381626e@linaro.org>
Date: Wed, 18 Oct 2023 09:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] arm: meson-a1: dts: Sync DT with Linux
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
 <20231017213211.121550-3-ivprusov@salutedevices.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231017213211.121550-3-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:43:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1781

On 17/10/2023 23:32, Igor Prusov wrote:
> Import device tree changes from Linux v6.6-rc6 for Amlogic A1 board.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   arch/arm/dts/meson-a1.dtsi | 356 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 351 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> index e3a42c5b24..648e7f4942 100644
> --- a/arch/arm/dts/meson-a1.dtsi
> +++ b/arch/arm/dts/meson-a1.dtsi
> @@ -3,9 +3,13 @@
>    * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>    */
>   
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>   #include <dt-bindings/gpio/meson-a1-gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/power/meson-a1-power.h>
> +#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
>   
>   / {
>   	compatible = "amlogic,a1";
> @@ -37,9 +41,19 @@
>   		l2: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> +	efuse: efuse {
> +		compatible = "amlogic,meson-gxbb-efuse";
> +		clocks = <&clkc_periphs CLKID_OTP>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		secure-monitor = <&sm>;
> +		power-domains = <&pwrc PWRC_OTP_ID>;
> +	};
> +
>   	psci {
>   		compatible = "arm,psci-1.0";
>   		method = "smc";
> @@ -65,7 +79,6 @@
>   		pwrc: power-controller {
>   			compatible = "amlogic,meson-a1-pwrc";
>   			#power-domain-cells = <1>;
> -			status = "okay";
>   		};
>   	};
>   
> @@ -75,6 +88,16 @@
>   		#size-cells = <2>;
>   		ranges;
>   
> +		spifc: spi@fd000400 {
> +			compatible = "amlogic,a1-spifc";
> +			reg = <0x0 0xfd000400 0x0 0x290>;
> +			clocks = <&clkc_periphs CLKID_SPIFC>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			power-domains = <&pwrc PWRC_SPIFC_ID>;
> +			status = "disabled";
> +		};
> +
>   		apb: bus@fe000000 {
>   			compatible = "simple-bus";
>   			reg = <0x0 0xfe000000 0x0 0x1000000>;
> @@ -103,10 +126,200 @@
>   					gpio-ranges = <&periphs_pinctrl 0 0 62>;
>   				};
>   
> +				i2c0_f11_pins: i2c0-f11 {
> +					mux {
> +						groups = "i2c0_sck_f11",
> +							 "i2c0_sda_f12";
> +						function = "i2c0";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c0_f9_pins: i2c0-f9 {
> +					mux {
> +						groups = "i2c0_sck_f9",
> +							 "i2c0_sda_f10";
> +						function = "i2c0";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_x_pins: i2c1-x {
> +					mux {
> +						groups = "i2c1_sck_x",
> +							 "i2c1_sda_x";
> +						function = "i2c1";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_a_pins: i2c1-a {
> +					mux {
> +						groups = "i2c1_sck_a",
> +							 "i2c1_sda_a";
> +						function = "i2c1";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_x0_pins: i2c2-x0 {
> +					mux {
> +						groups = "i2c2_sck_x0",
> +							 "i2c2_sda_x1";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_x15_pins: i2c2-x15 {
> +					mux {
> +						groups = "i2c2_sck_x15",
> +							 "i2c2_sda_x16";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_a4_pins: i2c2-a4 {
> +					mux {
> +						groups = "i2c2_sck_a4",
> +							 "i2c2_sda_a5";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_a8_pins: i2c2-a8 {
> +					mux {
> +						groups = "i2c2_sck_a8",
> +							 "i2c2_sda_a9";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_x_pins: i2c3-x {
> +					mux {
> +						groups = "i2c3_sck_x",
> +							 "i2c3_sda_x";
> +						function = "i2c3";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_f_pins: i2c3-f {
> +					mux {
> +						groups = "i2c3_sck_f",
> +							 "i2c3_sda_f";
> +						function = "i2c3";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				uart_a_pins: uart-a {
> +					mux {
> +						groups = "uart_a_tx",
> +							 "uart_a_rx";
> +						function = "uart_a";
> +					};
> +				};
> +
> +				uart_a_cts_rts_pins: uart-a-cts-rts {
> +					mux {
> +						groups = "uart_a_cts",
> +							 "uart_a_rts";
> +						function = "uart_a";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				sdio_pins: sdio {
> +					mux0 {
> +						groups = "sdcard_d0_x",
> +							 "sdcard_d1_x",
> +							 "sdcard_d2_x",
> +							 "sdcard_d3_x",
> +							 "sdcard_cmd_x";
> +						function = "sdcard";
> +						bias-pull-up;
> +					};
> +
> +					mux1 {
> +						groups = "sdcard_clk_x";
> +						function = "sdcard";
> +						bias-disable;
> +					};
> +				};
> +
> +				sdio_clk_gate_pins: sdio-clk-gate {
> +					mux {
> +						groups = "sdcard_clk_x";
> +						function = "sdcard";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				spifc_pins: spifc {
> +					mux {
> +						groups = "spif_mo",
> +							 "spif_mi",
> +							 "spif_clk",
> +							 "spif_cs",
> +							 "spif_hold_n",
> +							 "spif_wp_n";
> +						function = "spif";
> +					};
> +				};
> +			};
> +
> +			gpio_intc: interrupt-controller@440 {
> +				compatible = "amlogic,meson-a1-gpio-intc",
> +					     "amlogic,meson-gpio-intc";
> +				reg = <0x0 0x0440 0x0 0x14>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				amlogic,channel-interrupts =
> +					<49 50 51 52 53 54 55 56>;
> +			};
> +
> +			clkc_periphs: clock-controller@800 {
> +				compatible = "amlogic,a1-peripherals-clkc";
> +				reg = <0 0x800 0 0x104>;
> +				#clock-cells = <1>;
> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +					 <&clkc_pll CLKID_FCLK_DIV3>,
> +					 <&clkc_pll CLKID_FCLK_DIV5>,
> +					 <&clkc_pll CLKID_FCLK_DIV7>,
> +					 <&clkc_pll CLKID_HIFI_PLL>,
> +					 <&xtal>;
> +				clock-names = "fclk_div2", "fclk_div3",
> +					      "fclk_div5", "fclk_div7",
> +					      "hifi_pll", "xtal";
> +			};
> +
> +			i2c0: i2c@1400 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x1400 0x0 0x20>;
> +				interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_A>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
>   			};
>   
>   			uart_AO: serial@1c00 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-a1-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x1c00 0x0 0x18>;
>   				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> @@ -116,7 +329,7 @@
>   			};
>   
>   			uart_AO_B: serial@2000 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-a1-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x2000 0x0 0x18>;
>   				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> @@ -125,9 +338,70 @@
>   				status = "disabled";
>   			};
>   
> +			saradc: adc@2c00 {
> +				compatible = "amlogic,meson-g12a-saradc",
> +					"amlogic,meson-saradc";
> +				reg = <0x0 0x2c00 0x0 0x48>;
> +				#io-channel-cells = <1>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>,
> +					<&clkc_periphs CLKID_SARADC_EN>,
> +					<&clkc_periphs CLKID_SARADC>,
> +					<&clkc_periphs CLKID_SARADC_SEL>;
> +				clock-names = "clkin", "core",
> +					"adc_clk", "adc_sel";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@5c00 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x5c00 0x0 0x20>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_B>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
> +			i2c2: i2c@6800 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x6800 0x0 0x20>;
> +				interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_C>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
> +			i2c3: i2c@6c00 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x6c00 0x0 0x20>;
> +				interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_D>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
> +			usb2_phy1: phy@4000 {
> +				compatible = "amlogic,a1-usb2-phy";
> +				clocks = <&clkc_periphs CLKID_USB_PHY_IN>;
> +				clock-names = "xtal";
> +				reg = <0x0 0x4000 0x0 0x60>;
> +				resets = <&reset RESET_USBPHY>;
> +				reset-names = "phy";
> +				#phy-cells = <0>;
> +				power-domains = <&pwrc PWRC_USB_ID>;
> +			};
> +
>   			hwrng: rng@5118 {
>   				compatible = "amlogic,meson-rng";
>   				reg = <0x0 0x5118 0x0 0x4>;
> +				power-domains = <&pwrc PWRC_OTP_ID>;
>   			};
>   
>   			sec_AO: ao-secure@5a20 {
> @@ -135,6 +409,78 @@
>   				reg = <0x0 0x5a20 0x0 0x140>;
>   				amlogic,has-chip-id;
>   			};
> +
> +			clkc_pll: pll-clock-controller@7c80 {
> +				compatible = "amlogic,a1-pll-clkc";
> +				reg = <0 0x7c80 0 0x18c>;
> +				#clock-cells = <1>;
> +				clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
> +					 <&clkc_periphs CLKID_HIFIPLL_IN>;
> +				clock-names = "fixpll_in", "hifipll_in";
> +			};
> +
> +			sd_emmc: sd@10000 {
> +				compatible = "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x10000 0x0 0x800>;
> +				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_SD_EMMC_A>,
> +					 <&clkc_periphs CLKID_SD_EMMC>,
> +					 <&clkc_pll CLKID_FCLK_DIV2>;
> +				clock-names = "core",
> +					      "clkin0",
> +					      "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_SEL2>;
> +				assigned-clock-parents = <&xtal>;
> +				resets = <&reset RESET_SD_EMMC_A>;
> +				power-domains = <&pwrc PWRC_SD_EMMC_ID>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		usb: usb@fe004400 {
> +			status = "disabled";
> +			compatible = "amlogic,meson-a1-usb-ctrl";
> +			reg = <0x0 0xfe004400 0x0 0xa0>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&clkc_periphs CLKID_USB_CTRL>,
> +				 <&clkc_periphs CLKID_USB_BUS>,
> +				 <&clkc_periphs CLKID_USB_CTRL_IN>;
> +			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
> +			resets = <&reset RESET_USBCTRL>;
> +			reset-name = "usb_ctrl";
> +
> +			dr_mode = "otg";
> +
> +			phys = <&usb2_phy1>;
> +			phy-names = "usb2-phy1";
> +
> +			dwc3: usb@ff400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xff400000 0x0 0x100000>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				dr_mode = "host";
> +				snps,dis_u2_susphy_quirk;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,parkmode-disable-ss-quirk;
> +			};
> +
> +			dwc2: usb@ff500000 {
> +				compatible = "amlogic,meson-a1-usb", "snps,dwc2";
> +				reg = <0x0 0xff500000 0x0 0x40000>;
> +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +				phys = <&usb2_phy1>;
> +				phy-names = "usb2-phy";
> +				clocks = <&clkc_periphs CLKID_USB_PHY>;
> +				clock-names = "otg";
> +				dr_mode = "peripheral";
> +				g-rx-fifo-size = <192>;
> +				g-np-tx-fifo-size = <128>;
> +				g-tx-fifo-size = <128 128 16 16 16>;
> +			};
>   		};
>   
>   		gic: interrupt-controller@ff901000 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

