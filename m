Received: by mail-ed1-f65.google.com with SMTP id x10so1826469edh.11
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9RR4LNWjfaWkwHFLtHdUrYcDaoo1CrNqbAyn1lOfZMk=;
        b=N6Tf4JK+PKFCDqIBjazwQOeEiA8DiMZsgsXxtcFXlOrZX3/bPAndHc9XhlL4gyPK8u
         wo3zmFkTq5YjvdMdEdSZuULznTxm2DC0PhZREwRDthlyu06471DUQOQ58BfMKNop8isV
         DLWXPteWfuL/IlB27R8rv4nsrMud/OyYjja2/l9d4SYkmAtg7LTgWG9oxquWhBD+Mj9t
         /jkDZ+nem+zr6H4REjnf/WQh4h/FmCG2qMu8o+QGvTBD8HuZ65BXYHRVVs2jqpYGdYiD
         ml/aYRpnmr2zKsZXp2BTcUdZ+0hLnr/P0/5MT11HYi7w7nkFfFjDFEG76NMc+EqE6iSE
         By9w==
Return-Path: <mohammad.rasim96@gmail.com>
Date: Thu, 14 Mar 2019 18:29:27 +0300
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson: add p200 and p201 boards
Message-ID: <20190314152927.tverwqehmewx7ic6@manjaro.localdomain>
Reply-To: narmstrong@baylibre.com
References: <5c8a6ae5.1c69fb81.b636.6c84@mx.google.com>
 <146c1875-4578-8dc0-c5ef-32fc16428314@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <146c1875-4578-8dc0-c5ef-32fc16428314@baylibre.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 19/03/14 04:05, Neil Armstrong wrote:
> Hi Mohammad,
>
> Thanks for patches,
>
> Can you specify from which kernel release you sync'ed the DT ?
kernel version: 5.0.0
revision: a667cb7a94d48a483fb5d6006fe04a440f1a42ce

Should I include this information in V2?
>
> On 14/03/2019 14:52, Mohammad Rasim wrote:
> > Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> > ---
> >  arch/arm/dts/Makefile             |   2 +
> >  arch/arm/dts/meson-gxbb-p200.dts  |  99 ++++++++++++
> >  arch/arm/dts/meson-gxbb-p201.dts  |  26 ++++
> >  arch/arm/dts/meson-gxbb-p20x.dtsi | 247 ++++++++++++++++++++++++++++++
> >  4 files changed, 374 insertions(+)
> >  create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
> >  create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
> >  create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 2a040b20a5..adf5f26fac 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -60,6 +60,8 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
> >  	meson-gxbb-nanopi-k2.dtb \
> >  	meson-gxbb-odroidc2.dtb \
> >  	meson-gxbb-nanopi-k2.dtb \
> > +	meson-gxbb-p200.dtb \
> > +	meson-gxbb-p201.dtb \
> >  	meson-gxl-s905x-p212.dtb \
> >  	meson-gxl-s905x-libretech-cc.dtb \
> >  	meson-gxl-s905x-khadas-vim.dtb \
> > diff --git a/arch/arm/dts/meson-gxbb-p200.dts b/arch/arm/dts/meson-gxbb=
-p200.dts
> > new file mode 100644
> > index 0000000000..9d2406a7c4
> > --- /dev/null
> > +++ b/arch/arm/dts/meson-gxbb-p200.dts
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2016 Andreas F=C3=A4rber
>
> You should use format-patch and git send-email to send this patch, it wil=
l keep the UTF-8 encoding.
I used format-patch but with my own smtp client (msmtp) which apparently
corrupted the message
>
> > + * Copyright (c) 2016 BayLibre, Inc.
> > + * Author: Kevin Hilman <khilman@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "meson-gxbb-p20x.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +	compatible =3D "amlogic,p200", "amlogic,meson-gxbb";
> > +	model =3D "Amlogic Meson GXBB P200 Development Board";
> > +
> > +	avdd18_usb_adc: regulator-avdd18_usb_adc {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "AVDD18_USB_ADC";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +	};
> > +
> > +	adc_keys {
> > +		compatible =3D "adc-keys";
> > +		io-channels =3D <&saradc 0>;
> > +		io-channel-names =3D "buttons";
> > +		keyup-threshold-microvolt =3D <1800000>;
> > +
> > +		button-home {
> > +			label =3D "Home";
> > +			linux,code =3D <KEY_HOME>;
> > +			press-threshold-microvolt =3D <900000>; /* 50% */
> > +		};
> > +
> > +		button-esc {
> > +			label =3D "Esc";
> > +			linux,code =3D <KEY_ESC>;
> > +			press-threshold-microvolt =3D <684000>; /* 38% */
> > +		};
> > +
> > +		button-up {
> > +			label =3D "Volume Up";
> > +			linux,code =3D <KEY_VOLUMEUP>;
> > +			press-threshold-microvolt =3D <468000>; /* 26% */
> > +		};
> > +
> > +		button-down {
> > +			label =3D "Volume Down";
> > +			linux,code =3D <KEY_VOLUMEDOWN>;
> > +			press-threshold-microvolt =3D <252000>; /* 14% */
> > +		};
> > +
> > +		button-menu {
> > +			label =3D "Menu";
> > +			linux,code =3D <KEY_MENU>;
> > +			press-threshold-microvolt =3D <0>; /* 0% */
> > +		};
> > +	};
> > +};
> > +
> > +&ethmac {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&eth_rgmii_pins>;
> > +	pinctrl-names =3D "default";
> > +	phy-handle =3D <&eth_phy0>;
> > +	phy-mode =3D "rgmii";
> > +
> > +	amlogic,tx-delay-ns =3D <2>;
> > +
> > +	snps,reset-gpio =3D <&gpio GPIOZ_14 0>;
> > +	snps,reset-delays-us =3D <0 10000 1000000>;
> > +	snps,reset-active-low;
> > +
> > +	mdio {
> > +		compatible =3D "snps,dwmac-mdio";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		eth_phy0: ethernet-phy@3 {
> > +			/* Micrel KSZ9031 (0x00221620) */
> > +			reg =3D <3>;
> > +			interrupt-parent =3D <&gpio_intc>;
> > +			/* MAC_INTR on GPIOZ_15 */
> > +			interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
> > +		};
> > +	};
> > +};
> > +
> > +&i2c_B {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&i2c_b_pins>;
> > +	pinctrl-names =3D "default";
> > +};
> > +
> > +&saradc {
> > +	status =3D "okay";
> > +	vref-supply =3D <&avdd18_usb_adc>;
> > +};
> > diff --git a/arch/arm/dts/meson-gxbb-p201.dts b/arch/arm/dts/meson-gxbb=
-p201.dts
> > new file mode 100644
> > index 0000000000..56e0dd1ff5
> > --- /dev/null
> > +++ b/arch/arm/dts/meson-gxbb-p201.dts
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2016 Andreas F=C3=A4rber
> > + * Copyright (c) 2016 BayLibre, Inc.
> > + * Author: Kevin Hilman <khilman@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "meson-gxbb-p20x.dtsi"
> > +
> > +/ {
> > +	compatible =3D "amlogic,p201", "amlogic,meson-gxbb";
> > +	model =3D "Amlogic Meson GXBB P201 Development Board";
> > +};
> > +
> > +&ethmac {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&eth_rmii_pins>;
> > +	pinctrl-names =3D "default";
> > +	phy-mode =3D "rmii";
> > +
> > +	snps,reset-gpio =3D <&gpio GPIOZ_14 0>;
> > +	snps,reset-delays-us =3D <0 10000 1000000>;
> > +	snps,reset-active-low;
> > +};
> > diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxb=
b-p20x.dtsi
> > new file mode 100644
> > index 0000000000..0be0f2a5d2
> > --- /dev/null
> > +++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2016 Andreas F=C3=A4rber
> > + * Copyright (c) 2016 BayLibre, Inc.
> > + * Author: Kevin Hilman <khilman@kernel.org>
> > + */
> > +
> > +#include "meson-gxbb.dtsi"
> > +
> > +/ {
> > +	aliases {
> > +		serial0 =3D &uart_AO;
> > +		ethernet0 =3D &ethmac;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@0 {
> > +		device_type =3D "memory";
> > +		reg =3D <0x0 0x0 0x0 0x40000000>;
> > +	};
> > +
> > +	usb_pwr: regulator-usb-pwrs {
> > +		compatible =3D "regulator-fixed";
> > +
> > +		regulator-name =3D "USB_PWR";
> > +
> > +		regulator-min-microvolt =3D <5000000>;
> > +		regulator-max-microvolt =3D <5000000>;
> > +
> > +		/* signal name in schematic: USB_PWR_EN */
> > +		gpio =3D <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	vddio_card: gpio-regulator {
> > +		compatible =3D "regulator-gpio";
> > +
> > +		regulator-name =3D "VDDIO_CARD";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +
> > +		gpios =3D <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +		gpios-states =3D <1>;
> > +
> > +		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
> > +		states =3D <1800000 0
> > +			  3300000 1>;
> > +
> > +		regulator-settling-time-up-us =3D <10000>;
> > +		regulator-settling-time-down-us =3D <150000>;
> > +	};
> > +
> > +	vddio_boot: regulator-vddio_boot {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "VDDIO_BOOT";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +	};
> > +
> > +	vddao_3v3: regulator-vddao_3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "VDDAO_3V3";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +	};
> > +
> > +	vcc_3v3: regulator-vcc_3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "VCC_3V3";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +	};
> > +
> > +	emmc_pwrseq: emmc-pwrseq {
> > +		compatible =3D "mmc-pwrseq-emmc";
> > +		reset-gpios =3D <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> > +	wifi32k: wifi32k {
> > +		compatible =3D "pwm-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <32768>;
> > +		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> > +	};
> > +
> > +	sdio_pwrseq: sdio-pwrseq {
> > +		compatible =3D "mmc-pwrseq-simple";
> > +		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> > +		clocks =3D <&wifi32k>;
> > +		clock-names =3D "ext_clock";
> > +	};
> > +
> > +	cvbs_connector: cvbs-connector {
> > +		compatible =3D "composite-video-connector";
> > +
> > +		port {
> > +			cvbs_connector_in: endpoint {
> > +				remote-endpoint =3D <&cvbs_vdac_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	hdmi-connector {
> > +		compatible =3D "hdmi-connector";
> > +		type =3D "a";
> > +
> > +		port {
> > +			hdmi_connector_in: endpoint {
> > +				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&cec_AO {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&ao_cec_pins>;
> > +	pinctrl-names =3D "default";
> > +	hdmi-phandle =3D <&hdmi_tx>;
> > +};
> > +
> > +&cvbs_vdac_port {
> > +	cvbs_vdac_out: endpoint {
> > +		remote-endpoint =3D <&cvbs_connector_in>;
> > +	};
> > +};
> > +
> > +&hdmi_tx {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> > +	pinctrl-names =3D "default";
> > +};
> > +
> > +&hdmi_tx_tmds_port {
> > +	hdmi_tx_tmds_out: endpoint {
> > +		remote-endpoint =3D <&hdmi_connector_in>;
> > +	};
> > +};
> > +
> > +&ir {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&remote_input_ao_pins>;
> > +	pinctrl-names =3D "default";
> > +};
> > +
> > +&pwm_ef {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&pwm_e_pins>;
> > +	pinctrl-names =3D "default";
> > +	clocks =3D <&clkc CLKID_FCLK_DIV4>;
> > +	clock-names =3D "clkin0";
> > +};
> > +
> > +/* Wireless SDIO Module */
> > +&sd_emmc_a {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&sdio_pins>;
> > +	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> > +	pinctrl-names =3D "default", "clk-gate";
> > +	#address-cells =3D <1>;
> > +	#size-cells =3D <0>;
> > +
> > +	bus-width =3D <4>;
> > +	cap-sd-highspeed;
> > +	max-frequency =3D <100000000>;
> > +
> > +	non-removable;
> > +	disable-wp;
> > +
> > +	mmc-pwrseq =3D <&sdio_pwrseq>;
> > +
> > +	vmmc-supply =3D <&vddao_3v3>;
> > +	vqmmc-supply =3D <&vddio_boot>;
> > +
> > +	brcmf: wifi@1 {
> > +		reg =3D <1>;
> > +		compatible =3D "brcm,bcm4329-fmac";
> > +	};
> > +};
> > +
> > +/* SD card */
> > +&sd_emmc_b {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&sdcard_pins>;
> > +	pinctrl-1 =3D <&sdcard_clk_gate_pins>;
> > +	pinctrl-names =3D "default", "clk-gate";
> > +
> > +	bus-width =3D <4>;
> > +	cap-sd-highspeed;
> > +	sd-uhs-sdr12;
> > +	sd-uhs-sdr25;
> > +	sd-uhs-sdr50;
> > +	max-frequency =3D <100000000>;
> > +	disable-wp;
> > +
> > +	cd-gpios =3D <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> > +
> > +	vmmc-supply =3D <&vddao_3v3>;
> > +	vqmmc-supply =3D <&vddio_card>;
> > +};
> > +
> > +/* eMMC */
> > +&sd_emmc_c {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&emmc_pins>, <&emmc_ds_pins>;
> > +	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> > +	pinctrl-names =3D "default", "clk-gate";
> > +
> > +	bus-width =3D <8>;
> > +	cap-mmc-highspeed;
> > +	max-frequency =3D <200000000>;
> > +	non-removable;
> > +	disable-wp;
> > +	mmc-ddr-1_8v;
> > +	mmc-hs200-1_8v;
> > +
> > +	mmc-pwrseq =3D <&emmc_pwrseq>;
> > +	vmmc-supply =3D <&vcc_3v3>;
> > +	vqmmc-supply =3D <&vddio_boot>;
> > +};
> > +
> > +/* This UART is brought out to the DB9 connector */
> > +&uart_AO {
> > +	status =3D "okay";
> > +	pinctrl-0 =3D <&uart_ao_a_pins>;
> > +	pinctrl-names =3D "default";
> > +};
> > +
> > +&usb0_phy {
> > +	status =3D "okay";
> > +	phy-supply =3D <&usb_pwr>;
> > +};
> > +
> > +&usb1_phy {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb1 {
> > +	status =3D "okay";
> > +};
> > --
> > 2.21.0
> >
>
