Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.36199.1679927065057893389
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 07:24:25 -0700
Received: by mail-wm1-f45.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7533171wmb.0
        for <u-boot-amlogic@groups.io>; Mon, 27 Mar 2023 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927063;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ibhzo8iRzhNB6ZVHMZkxdKNb+Kqd8jDbkKIxKiIjvM=;
        b=e4Pn7/ml/007FLy1x4c8qrYanCDjirzVCzpx3oJVXTuOf/BQimg4s3uMBcUsNbQrxL
         ENmGtWhvkFqIanff5oi5i50Mwvh/1/TpdKqh73Ch6MxBiLznEMUeAhSBGDRvso0MjKUc
         /mVwmBW2KmB39xbkhnXBnq8pJ+Rlctja6pgknjtKDAN4zW3xCYrfv0Kz0DPOIwv5T3fI
         oTehEIgUHNDB/nkp0ofSoKKdB6EqrMd6Jv/ACwzdrnLu6sCvF6tJvgdFWzW7LMHf3Wqj
         GElBmc2f6nZO2sJI9B/Z9yvwK0F9CGfulvGcjSrAt1+UDwY7IQYWCvvPZ4nlrAuSH+1y
         klqw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <324249aa-0f20-d3c4-4515-2f52b4c99a1a@linaro.org>
Date: Mon, 27 Mar 2023 16:24:22 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv5 1/3] ARM: dts: add support for Beelink GT1 Ultimate
References: <CdyC.1679850665326358079.ekOu@groups.io>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <CdyC.1679850665326358079.ekOu@groups.io>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, exkc_maillist@list.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

Please CC the main u-boot@lists.denx.de list aswell.

On 26/03/2023 19:11, exkc_maillist via groups.io wrote:
> Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>

Please remove the leading space before Karl.

Thanks,
Neil

> ---
>   arch/arm/dts/Makefile                         |  1 +
>   .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
>   arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
>   3 files changed, 99 insertions(+)
>   create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
>   create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1c843882d1..b4ac7e9877 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
>   	meson-gxl-s905x-libretech-cc.dtb \
>   	meson-gxl-s905x-libretech-cc-v2.dtb \
>   	meson-gxl-s905x-p212.dtb \
> +	meson-gxm-gt1-ultimate.dtb \
>   	meson-gxm-khadas-vim2.dtb \
>   	meson-gxm-s912-libretech-pc.dtb \
>   	meson-gxm-wetek-core2.dtb \
> diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
> new file mode 100644
> index 0000000000..39270ea71c
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gxl-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
> new file mode 100644
> index 0000000000..2c267884cc
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxm.dtsi"
> +#include "meson-gx-p23x-q20x.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "azw,gt1-ultimate", "amlogic,s912", "amlogic,meson-gxm";
> +	model = "Beelink GT1 Ultimate";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-white {
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			panic-indicator;
> +		};
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1710000>;
> +
> +		button-function {
> +			label = "update";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <10000>;
> +		};
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +	phy-mode = "rgmii";
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_15 */
> +		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ir {
> +	linux,rc-map-name = "rc-beelink-gs1";
> +};
> +
> +&sd_emmc_a {
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +		clocks = <&wifi32k>;
> +		clock-names = "lpo";
> +	};
> +};

