Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.7203.1576837066635435622
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:17:47 -0800
Received: by mail-wr1-f67.google.com with SMTP id z7so8815244wrl.13
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6TuhCS6gM6ofecWvlzgKHZmN2Gmea5pBVwwYyMNKRcU=;
        b=TOkZBVBO65pqEB+G0UiRFiRkdgwpiYGcNWJzgEo51Rgw/tNCX3d93AcrTnl+WcwbmA
         lqgQij09hFfirgSjZwdjF8Hbxp/MQK19gkqMi7LjE0XTSbLQT2Or8kiz8BCtHhf8X720
         gbNYgUiEmjB7KL8eZECr8CdgBhun1JLNIRmeEKju2T4NgS1ivQReaGQjJPfzvWYepvBW
         6SHOzD1xNTVMVK06W/23N2tkn0OXJc85nxk/B5NGmmRozlNvl32TSczhXgCIxv5lBOwy
         wsCwAdTmhD7pmWZG+ytxhxcUjR2UmEaGJYZQ4qtK3a04lLdW4Jcj8B2EknfyOsKF90uR
         /kmA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson: add libretech-pc support
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
 <20191219183620.1423118-6-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2f8c648a-e174-7cc8-cba8-efb54c56c188@baylibre.com>
Date: Fri, 20 Dec 2019 11:17:43 +0100
MIME-Version: 1.0
In-Reply-To: <20191219183620.1423118-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 19/12/2019 19:36, Jerome Brunet wrote:
> Add support for the Amlogic based libretech-pc platform.
> This platform comes with 2 variant, based on the s905d or s912 SoC.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm/dts/Makefile                         |   2 +
>  arch/arm/dts/meson-gx-libretech-pc.dtsi       | 376 ++++++++++++++++++
>  .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |   7 +
>  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts |  17 +
>  arch/arm/dts/meson-gxl-s905d.dtsi             |  12 +
>  arch/arm/dts/meson-gxl.dtsi                   |  35 +-
>  .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |   7 +
>  arch/arm/dts/meson-gxm-s912-libretech-pc.dts  |  62 +++
>  configs/libretech-s905d-pc_defconfig          |  73 ++++
>  configs/libretech-s912-pc_defconfig           |  73 ++++
>  10 files changed, 654 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
>  create mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
>  create mode 100644 configs/libretech-s905d-pc_defconfig
>  create mode 100644 configs/libretech-s912-pc_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3dc9c4d41c8d..fca0834aa7c6 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -146,7 +146,9 @@ dtb-$(CONFIG_ARCH_MESON) += \
>  	meson-gxl-s805x-libretech-ac.dtb \
>  	meson-gxl-s905x-libretech-cc.dtb \
>  	meson-gxl-s905x-khadas-vim.dtb \
> +	meson-gxl-s905d-libretech-pc.dtb \
>  	meson-gxm-khadas-vim2.dtb \
> +	meson-gxm-s912-libretech-pc.dtb \
>  	meson-axg-s400.dtb \
>  	meson-g12a-u200.dtb \
>  	meson-g12a-sei510.dtb \
> diff --git a/arch/arm/dts/meson-gx-libretech-pc.dtsi b/arch/arm/dts/meson-gx-libretech-pc.dtsi
> new file mode 100644
> index 000000000000..2857c3b6b006
> --- /dev/null
> +++ b/arch/arm/dts/meson-gx-libretech-pc.dtsi
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 BayLibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/* Libretech Amlogic GX PC form factor - AKA: Tartiflette */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +
> +		update-button {
> +			label = "update";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <1300000>;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		ethernet0 = &ethmac;
> +		spi0 = &spifc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	cvbs-connector {
> +		compatible = "composite-video-connector";
> +		status = "disabled";
> +
> +		port {
> +			cvbs_connector_in: endpoint {
> +				remote-endpoint = <&cvbs_vdac_out>;
> +			};
> +		};
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		poll-interval = <100>;
> +
> +		power-button {
> +			label = "power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	ao_5v: regulator-ao_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "AO_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	dc_in: regulator-dc_in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DC_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "disk-activity";
> +		};
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			panic-indicator;
> +		};
> +	};
> +
> +	vcc_card: regulator-vcc_card {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_CARD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddio_ao3v3>;
> +
> +		gpio = <&gpio GPIODV_4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vcc5v: regulator-vcc5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&ao_5v>;
> +
> +		gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&ao_5v>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao3v3: regulator-vddio_ao3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ao_5v>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_boot: regulator-vddio_boot {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddio_ao3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_card: regulator-vddio-card {
> +		compatible = "regulator-gpio";
> +		regulator-name = "VDDIO_CARD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio GPIODV_5 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +
> +		states = <3300000 0>,
> +			 <1800000 1>;
> +
> +		regulator-settling-time-up-us = <200>;
> +		regulator-settling-time-down-us = <50000>;
> +	};
> +};
> +
> +&cec_AO {
> +	pinctrl-0 = <&ao_cec_pins>;
> +	pinctrl-names = "default";
> +	hdmi-phandle = <&hdmi_tx>;
> +	status = "okay";
> +};
> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>, <&eth_phy_irq_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		max-speed = <1000>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <30000>;
> +		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +		interrupt-parent = <&gpio_intc>;
> +		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&pinctrl_periphs {
> +	/*
> +	 * Make sure the reset pin of the usb HUB is driven high to take
> +	 * it out of reset.
> +	 */
> +	usb1_rst_pins: usb1_rst_irq {
> +		mux {
> +			groups = "GPIODV_3";
> +			function = "gpio_periphs";
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
> +	/* Make sure the phy irq pin is properly configured as input */
> +	eth_phy_irq_pins: eth_phy_irq {
> +		mux {
> +			groups = "GPIOZ_15";
> +			function = "gpio_periphs";
> +			bias-disable;
> +			output-disable;
> +		};
> +	};
> +};
> +
> +&hdmi_tx {
> +	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> +	pinctrl-names = "default";
> +	hdmi-supply = <&vcc5v>;
> +	status = "okay";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&i2c_C {
> +	pinctrl-0 = <&i2c_c_dv18_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	rtc: rtc@51 {
> +		reg = <0x51>;
> +		compatible = "nxp,pcf8563";
> +		#clock-cells = <0>;
> +		clock-output-names = "rtc_clkout";
> +	};
> +};
> +
> +&pwm_AO_ab {
> +	pinctrl-0 = <&pwm_ao_a_3_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +	status = "okay";
> +};
> +
> +&pwm_ab {
> +	pinctrl-0 = <&pwm_b_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +	status = "okay";
> +};
> +
> +&pwm_ef {
> +	pinctrl-0 = <&pwm_e_pins>, <&pwm_f_clk_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vddio_ao18>;
> +	status = "okay";
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> +
> +	vmmc-supply = <&vcc_card>;
> +	vqmmc-supply = <&vddio_card>;
> +
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	pinctrl-0 = <&emmc_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vddio_ao3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +
> +	status = "okay";
> +};
> +
> +&spifc {
> +	pinctrl-0 = <&nor_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	gd25lq128: spi-flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;
> +		spi-max-frequency = <12000000>;
> +	};
> +};
> +
> +&uart_AO {
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb2_phy0 {
> +	pinctrl-0 = <&usb1_rst_pins>;
> +	pinctrl-names = "default";
> +	phy-supply = <&vcc5v>;
> +};
> +
> +&usb2_phy1 {
> +	phy-supply = <&vcc5v>;
> +};
> +
> diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
> new file mode 100644
> index 000000000000..c35158d7e9ee
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc.dts b/arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
> new file mode 100644
> index 000000000000..269094d8b9b3
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 BayLibre SAS. All rights reserved.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d.dtsi"
> +#include "meson-gx-libretech-pc.dtsi"
> +
> +/ {
> +	compatible = "libretech,aml-s905d-pc", "amlogic,s905d",
> +		     "amlogic,meson-gxl";
> +	model = "Libre Computer AML-S905D-PC";
> +};
> +
> diff --git a/arch/arm/dts/meson-gxl-s905d.dtsi b/arch/arm/dts/meson-gxl-s905d.dtsi
> new file mode 100644
> index 000000000000..43321919547a
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxl-s905d.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + */
> +
> +#include "meson-gxl.dtsi"
> +#include "meson-gxl-mali.dtsi"
> +
> +/ {
> +	compatible = "amlogic,s905d", "amlogic,meson-gxl";
> +};
> diff --git a/arch/arm/dts/meson-gxl.dtsi b/arch/arm/dts/meson-gxl.dtsi
> index 4ef11e5381d8..1163a9539cb9 100644
> --- a/arch/arm/dts/meson-gxl.dtsi
> +++ b/arch/arm/dts/meson-gxl.dtsi
> @@ -326,10 +326,15 @@
>  		};
>  
>  		emmc_pins: emmc {
> -			mux {
> +			mux-0 {
>  				groups = "emmc_nand_d07",
> -				       "emmc_cmd",
> -				       "emmc_clk";
> +				       "emmc_cmd";
> +				function = "emmc";
> +				bias-pull-up;
> +			};
> +
> +			mux-1 {
> +				groups = "emmc_clk";
>  				function = "emmc";
>  				bias-disable;
>  			};
> @@ -339,7 +344,7 @@
>  			mux {
>  				groups = "emmc_ds";
>  				function = "emmc";
> -				bias-disable;
> +				bias-pull-down;
>  			};
>  		};
>  
> @@ -381,13 +386,18 @@
>  		};
>  
>  		sdcard_pins: sdcard {
> -			mux {
> +			mux-0 {
>  				groups = "sdcard_d0",
>  				       "sdcard_d1",
>  				       "sdcard_d2",
>  				       "sdcard_d3",
> -				       "sdcard_cmd",
> -				       "sdcard_clk";
> +				       "sdcard_cmd";
> +				function = "sdcard";
> +				bias-pull-up;
> +			};
> +
> +			mux-1 {
> +				groups = "sdcard_clk";
>  				function = "sdcard";
>  				bias-disable;
>  			};
> @@ -402,13 +412,18 @@
>  		};
>  
>  		sdio_pins: sdio {
> -			mux {
> +			mux-0 {
>  				groups = "sdio_d0",
>  				       "sdio_d1",
>  				       "sdio_d2",
>  				       "sdio_d3",
> -				       "sdio_cmd",
> -				       "sdio_clk";
> +				       "sdio_cmd";
> +				function = "sdio";
> +				bias-pull-up;
> +			};
> +
> +			mux-1 {
> +				groups = "sdio_clk";
>  				function = "sdio";
>  				bias-disable;
>  			};
> diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
> new file mode 100644
> index 000000000000..c35158d7e9ee
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc.dts b/arch/arm/dts/meson-gxm-s912-libretech-pc.dts
> new file mode 100644
> index 000000000000..444c249863cb
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxm-s912-libretech-pc.dts
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 BayLibre SAS. All rights reserved.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxm.dtsi"
> +#include "meson-gx-libretech-pc.dtsi"
> +
> +/ {
> +	compatible = "libretech,aml-s912-pc", "amlogic,s912",
> +		     "amlogic,meson-gxm";
> +	model = "Libre Computer AML-S912-PC";
> +
> +	typec2_vbus: regulator-typec2_vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "TYPEC2_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v>;
> +
> +		gpio = <&gpio GPIODV_1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&pinctrl_periphs {
> +	/*
> +	 * Make sure the irq pin of the TYPE C controller is not driven
> +	 * by the SoC.
> +	 */
> +	fusb302_irq_pins: fusb302_irq {
> +		mux {
> +			groups = "GPIODV_0";
> +			function = "gpio_periphs";
> +			bias-pull-up;
> +			output-disable;
> +		};
> +	};
> +};
> +
> +&i2c_C {
> +	fusb302@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +
> +		pinctrl-0 = <&fusb302_irq_pins>;
> +		pinctrl-names = "default";
> +		interrupt-parent = <&gpio_intc>;
> +		interrupts = <59 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vbus-supply = <&typec2_vbus>;
> +
> +		status = "okay";
> +	};
> +};
> +
> +&usb2_phy2 {
> +	phy-supply = <&typec2_vbus>;
> +};
> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
> new file mode 100644
> index 000000000000..7e0c95872a62
> --- /dev/null
> +++ b/configs/libretech-s905d-pc_defconfig
> @@ -0,0 +1,73 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="q200"
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_MESON_GXL=y
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0xFFFF0000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_IDENT_STRING=" libretech-s905d-pc"
> +CONFIG_DEBUG_UART=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="usb start"
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_SF=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905d-libretech-pc"
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_DM_GPIO=y
> +CONFIG_DM_KEYBOARD=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY=y
> +CONFIG_MESON_GXL_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXL=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_MESON_SPIFC=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_DM_VIDEO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
> new file mode 100644
> index 000000000000..5f4ee329e276
> --- /dev/null
> +++ b/configs/libretech-s912-pc_defconfig
> @@ -0,0 +1,73 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="q200"
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_MESON_GXM=y
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0xFFFF0000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_IDENT_STRING=" libretech-s912-pc"
> +CONFIG_DEBUG_UART=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="usb start"
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_SF=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-s912-libretech-pc"
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_DM_GPIO=y
> +CONFIG_DM_KEYBOARD=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY=y
> +CONFIG_MESON_GXL_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXL=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_MESON_SPIFC=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_DM_VIDEO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> 

Please separate the DT sync (I'll prefer a sync of Linux DT from a stable tag,
either from Linux tree, or Kevin's arm-soc PR) and the new defconfigs.

Neil

