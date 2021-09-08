Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web09.13313.1631115970620186286
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 08:46:10 -0700
Received: by mail-qt1-f170.google.com with SMTP id s32so2215136qtc.12
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SoRHBYzjZRwkZFzSRomGBbRSrhecTuGDzUuaAtSlV0Q=;
        b=DPf7c2N0qie7aEfW/77jdPVxPWbF4aosgbokBtqcuCAZWn6DOQScqhVEBRsb2mTnZc
         nTPp9X+zfArulEDnUOIKRruDjYqhznfhs3S/h2p+m6vuwlVAJleFtCnFmgQXaKmr1Smh
         E/OsXeX9tV9KE7CNJIzGMsOnsTxKT0tZ0wDkI=
Return-Path: <trini@konsulko.com>
Date: Wed, 8 Sep 2021 11:46:06 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/9] ARM: meson: Sync Amlogic DT from Linux 5.14
Message-ID: <20210908154606.GF12964@bill-the-cat>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQa200R4EO7jAQ6Z"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--fQa200R4EO7jAQ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 08, 2021 at 04:17:20PM +0200, Neil Armstrong wrote:

> Import Amlogic DT changes from Linux commit 7d2a07b76933 ("Linux 5.14"),
> dt-bindings clock changes and new meson-g12b-gsking-x.dts,
> meson-sm1-bananapi-m5 & odroid-hc4 boards.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Given some other related email threads, I'm curious.  Does this mean
that everything U-Boot specific is currently in -u-boot.dtsi files?  Or
is there some manual syncing within the main dts files (aside from
perhaps needing to #include a -u-boot.dtsi) ?  Thanks!

> ---

>  arch/arm/dts/Makefile                         |   3 +
>  arch/arm/dts/meson-axg-s400.dts               |  16 +
>  arch/arm/dts/meson-axg.dtsi                   | 181 +++++
>  arch/arm/dts/meson-g12-common.dtsi            |  31 +-
>  arch/arm/dts/meson-g12a-sei510.dts            |   2 +-
>  arch/arm/dts/meson-g12b-gsking-x.dts          | 133 ++++
>  arch/arm/dts/meson-g12b-gtking-pro.dts        |  23 +-
>  arch/arm/dts/meson-g12b-gtking.dts            |  22 +-
>  arch/arm/dts/meson-g12b-odroid-n2-plus.dts    |   2 +-
>  arch/arm/dts/meson-g12b-odroid-n2.dtsi        |  74 +-
>  arch/arm/dts/meson-g12b-w400.dtsi             |   2 +-
>  arch/arm/dts/meson-g12b.dtsi                  |   4 +
>  arch/arm/dts/meson-gx-libretech-pc.dtsi       |   2 +-
>  arch/arm/dts/meson-gx-p23x-q20x.dtsi          |   2 +-
>  arch/arm/dts/meson-gx.dtsi                    |   7 +
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  42 +-
>  arch/arm/dts/meson-gxbb-odroidc2.dts          |  44 +-
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |   2 +-
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  50 +-
>  .../dts/meson-gxl-s905x-libretech-cc-v2.dts   |   6 +-
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |   2 +-
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        |  55 +-
>  arch/arm/dts/meson-gxm-wetek-core2.dts        |   2 +-
>  arch/arm/dts/meson-gxm.dtsi                   |  20 +
>  arch/arm/dts/meson-khadas-vim3.dtsi           |  73 +-
>  arch/arm/dts/meson-sm1-bananapi-m5.dts        | 646 ++++++++++++++++++
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  20 +-
>  arch/arm/dts/meson-sm1-odroid-c4.dts          | 448 +-----------
>  arch/arm/dts/meson-sm1-odroid-hc4.dts         | 140 ++++
>  arch/arm/dts/meson-sm1-odroid.dtsi            | 449 ++++++++++++
>  arch/arm/dts/meson-sm1-sei610.dts             |  10 +-
>  arch/arm/dts/meson-sm1.dtsi                   |  12 +-
>  include/dt-bindings/clock/axg-clkc.h          |  26 +-
>  include/dt-bindings/clock/g12a-clkc.h         |   2 +
>  34 files changed, 2030 insertions(+), 523 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12b-gsking-x.dts
>  create mode 100644 arch/arm/dts/meson-sm1-bananapi-m5.dts
>  create mode 100644 arch/arm/dts/meson-sm1-odroid-hc4.dts
>  create mode 100644 arch/arm/dts/meson-sm1-odroid.dtsi
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index fc16a57e60..f0160d2dc0 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -177,11 +177,14 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
>  	meson-g12a-sei510.dtb \
>  	meson-g12b-gtking.dtb \
>  	meson-g12b-gtking-pro.dtb \
> +	meson-g12b-gsking-x.dtb \
>  	meson-g12b-odroid-n2.dtb \
>  	meson-g12b-odroid-n2-plus.dtb \
>  	meson-g12b-a311d-khadas-vim3.dtb \
> +	meson-sm1-bananapi-m5.dtb \
>  	meson-sm1-khadas-vim3l.dtb \
>  	meson-sm1-odroid-c4.dtb \
> +	meson-sm1-odroid-hc4.dtb \
>  	meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) +=3D tegra20-harmony.dtb \
>  	tegra20-medcom-wide.dtb \
> diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s40=
0.dts
> index cb1360ae12..359589d1df 100644
> --- a/arch/arm/dts/meson-axg-s400.dts
> +++ b/arch/arm/dts/meson-axg-s400.dts
> @@ -441,6 +441,16 @@
>  	status =3D "okay";
>  };
> =20
> +&pcieA {
> +	reset-gpios =3D <&gpio GPIOX_19 GPIO_ACTIVE_LOW>;
> +	status =3D "okay";
> +};
> +
> +&pcieB {
> +	reset-gpios =3D <&gpio GPIOZ_10 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +	status =3D "okay";
> +};
> +
>  &pwm_ab {
>  	status =3D "okay";
>  	pinctrl-0 =3D <&pwm_a_x20_pins>;
> @@ -584,3 +594,9 @@
>  	pinctrl-0 =3D <&uart_ao_a_pins>;
>  	pinctrl-names =3D "default";
>  };
> +
> +&usb {
> +	status =3D "okay";
> +	dr_mode =3D "otg";
> +	vbus-supply =3D <&usb_pwr>;
> +};
> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
> index b9efc84692..3f5254eeb4 100644
> --- a/arch/arm/dts/meson-axg.dtsi
> +++ b/arch/arm/dts/meson-axg.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
> +#include <dt-bindings/power/meson-axg-power.h>
> =20
>  / {
>  	compatible =3D "amlogic,meson-axg";
> @@ -171,6 +172,98 @@
>  		#size-cells =3D <2>;
>  		ranges;
> =20
> +		pcieA: pcie@f9800000 {
> +			compatible =3D "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg =3D <0x0 0xf9800000 0x0 0x400000>,
> +			      <0x0 0xff646000 0x0 0x2000>,
> +			      <0x0 0xf9f00000 0x0 0x100000>;
> +			reg-names =3D "elbi", "cfg", "config";
> +			interrupts =3D <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 0>;
> +			interrupt-map =3D <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +			bus-range =3D <0x0 0xff>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges =3D <0x82000000 0 0xf9c00000 0x0 0xf9c00000 0 0x00300000>;
> +
> +			clocks =3D <&clkc CLKID_USB>, <&clkc CLKID_PCIE_A>, <&clkc CLKID_PCIE=
_CML_EN0>;
> +			clock-names =3D "general", "pclk", "port";
> +			resets =3D <&reset RESET_PCIE_A>, <&reset RESET_PCIE_APB>;
> +			reset-names =3D "port", "apb";
> +			num-lanes =3D <1>;
> +			phys =3D <&pcie_phy>;
> +			phy-names =3D "pcie";
> +			status =3D "disabled";
> +		};
> +
> +		pcieB: pcie@fa000000 {
> +			compatible =3D "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg =3D <0x0 0xfa000000 0x0 0x400000>,
> +			      <0x0 0xff648000 0x0 0x2000>,
> +			      <0x0 0xfa400000 0x0 0x100000>;
> +			reg-names =3D "elbi", "cfg", "config";
> +			interrupts =3D <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 0>;
> +			interrupt-map =3D <0 0 0 0 &gic GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +			bus-range =3D <0x0 0xff>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges =3D <0x82000000 0 0xfa500000 0x0 0xfa500000 0 0x00300000>;
> +
> +			clocks =3D <&clkc CLKID_USB>, <&clkc CLKID_PCIE_B>, <&clkc CLKID_PCIE=
_CML_EN1>;
> +			clock-names =3D "general", "pclk", "port";
> +			resets =3D <&reset RESET_PCIE_B>, <&reset RESET_PCIE_APB>;
> +			reset-names =3D "port", "apb";
> +			num-lanes =3D <1>;
> +			phys =3D <&pcie_phy>;
> +			phy-names =3D "pcie";
> +			status =3D "disabled";
> +		};
> +
> +		usb: usb@ffe09080 {
> +			compatible =3D "amlogic,meson-axg-usb-ctrl";
> +			reg =3D <0x0 0xffe09080 0x0 0x20>;
> +			interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells =3D <2>;
> +			#size-cells =3D <2>;
> +			ranges;
> +
> +			clocks =3D <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
> +			clock-names =3D "usb_ctrl", "ddr";
> +			resets =3D <&reset RESET_USB_OTG>;
> +
> +			dr_mode =3D "otg";
> +
> +			phys =3D <&usb2_phy1>;
> +			phy-names =3D "usb2-phy1";
> +
> +			dwc2: usb@ff400000 {
> +				compatible =3D "amlogic,meson-g12a-usb", "snps,dwc2";
> +				reg =3D <0x0 0xff400000 0x0 0x40000>;
> +				interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clkc CLKID_USB1>;
> +				clock-names =3D "otg";
> +				phys =3D <&usb2_phy1>;
> +				dr_mode =3D "peripheral";
> +				g-rx-fifo-size =3D <192>;
> +				g-np-tx-fifo-size =3D <128>;
> +				g-tx-fifo-size =3D <128 128 16 16 16>;
> +			};
> +
> +			dwc3: usb@ff500000 {
> +				compatible =3D "snps,dwc3";
> +				reg =3D <0x0 0xff500000 0x0 0x100000>;
> +				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +				dr_mode =3D "host";
> +				maximum-speed =3D "high-speed";
> +				snps,dis_u2_susphy_quirk;
> +			};
> +		};
> +
>  		ethmac: ethernet@ff3f0000 {
>  			compatible =3D "amlogic,meson-axg-dwmac",
>  				     "snps,dwmac-3.70a",
> @@ -187,9 +280,19 @@
>  				      "timing-adjustment";
>  			rx-fifo-depth =3D <4096>;
>  			tx-fifo-depth =3D <2048>;
> +			power-domains =3D <&pwrc PWRC_AXG_ETHERNET_MEM_ID>;
>  			status =3D "disabled";
>  		};
> =20
> +		pcie_phy: phy@ff644000 {
> +			compatible =3D "amlogic,axg-pcie-phy";
> +			reg =3D <0x0 0xff644000 0x0 0x1c>;
> +			resets =3D <&reset RESET_PCIE_PHY>;
> +			phys =3D <&mipi_pcie_analog_dphy>;
> +			phy-names =3D "analog";
> +			#phy-cells =3D <0>;
> +		};
> +
>  		pdm: audio-controller@ff632000 {
>  			compatible =3D "amlogic,axg-pdm";
>  			reg =3D <0x0 0xff632000 0x0 0x34>;
> @@ -1117,6 +1220,52 @@
>  					clocks =3D <&xtal>;
>  					clock-names =3D "xtal";
>  				};
> +
> +				pwrc: power-controller {
> +					compatible =3D "amlogic,meson-axg-pwrc";
> +					#power-domain-cells =3D <1>;
> +					amlogic,ao-sysctrl =3D <&sysctrl_AO>;
> +					resets =3D <&reset RESET_VIU>,
> +						 <&reset RESET_VENC>,
> +						 <&reset RESET_VCBUS>,
> +						 <&reset RESET_VENCL>,
> +						 <&reset RESET_VID_LOCK>;
> +					reset-names =3D "viu", "venc", "vcbus",
> +						      "vencl", "vid_lock";
> +					clocks =3D <&clkc CLKID_VPU>,
> +						 <&clkc CLKID_VAPB>;
> +					clock-names =3D "vpu", "vapb";
> +					/*
> +					 * VPU clocking is provided by two identical clock paths
> +					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
> +					 * free mux to safely change frequency while running.
> +					 * Same for VAPB but with a final gate after the glitch free mux.
> +					 */
> +					assigned-clocks =3D <&clkc CLKID_VPU_0_SEL>,
> +							  <&clkc CLKID_VPU_0>,
> +							  <&clkc CLKID_VPU>, /* Glitch free mux */
> +							  <&clkc CLKID_VAPB_0_SEL>,
> +							  <&clkc CLKID_VAPB_0>,
> +							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
> +					assigned-clock-parents =3D <&clkc CLKID_FCLK_DIV4>,
> +								 <0>, /* Do Nothing */
> +								 <&clkc CLKID_VPU_0>,
> +								 <&clkc CLKID_FCLK_DIV4>,
> +								 <0>, /* Do Nothing */
> +								 <&clkc CLKID_VAPB_0>;
> +					assigned-clock-rates =3D <0>, /* Do Nothing */
> +							       <250000000>,
> +							       <0>, /* Do Nothing */
> +							       <0>, /* Do Nothing */
> +							       <250000000>,
> +							       <0>; /* Do Nothing */
> +				};
> +
> +				mipi_pcie_analog_dphy: phy {
> +					compatible =3D "amlogic,axg-mipi-pcie-analog-phy";
> +					#phy-cells =3D <0>;
> +					status =3D "disabled";
> +				};
>  			};
>  		};
> =20
> @@ -1129,6 +1278,19 @@
>  			#mbox-cells =3D <1>;
>  		};
> =20
> +		mipi_dphy: phy@ff640000 {
> +			compatible =3D "amlogic,axg-mipi-dphy";
> +			reg =3D <0x0 0xff640000 0x0 0x100>;
> +			clocks =3D <&clkc CLKID_MIPI_DSI_PHY>;
> +			clock-names =3D "pclk";
> +			resets =3D <&reset RESET_MIPI_PHY>;
> +			reset-names =3D "phy";
> +			phys =3D <&mipi_pcie_analog_dphy>;
> +			phy-names =3D "analog";
> +			#phy-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
>  		audio: bus@ff642000 {
>  			compatible =3D "simple-bus";
>  			reg =3D <0x0 0xff642000 0x0 0x2000>;
> @@ -1563,6 +1725,14 @@
>  			};
>  		};
> =20
> +		ge2d: ge2d@ff940000 {
> +			compatible =3D "amlogic,axg-ge2d";
> +			reg =3D <0x0 0xff940000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
> +			clocks =3D <&clkc CLKID_VAPB>;
> +			resets =3D <&reset RESET_GE2D>;
> +		};
> +
>  		gic: interrupt-controller@ffc01000 {
>  			compatible =3D "arm,gic-400";
>  			reg =3D <0x0 0xffc01000 0 0x1000>,
> @@ -1701,6 +1871,7 @@
>  				status =3D "disabled";
>  				clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
>  				clock-names =3D "xtal", "pclk", "baud";
> +				fifo-size =3D <128>;
>  			};
>  		};
> =20
> @@ -1734,6 +1905,16 @@
>  				clock-names =3D "core", "clkin0", "clkin1";
>  				resets =3D <&reset RESET_SD_EMMC_C>;
>  			};
> +
> +			usb2_phy1: phy@9020 {
> +				compatible =3D "amlogic,meson-gxl-usb2-phy";
> +				#phy-cells =3D <0>;
> +				reg =3D <0x0 0x9020 0x0 0x20>;
> +				clocks =3D <&clkc CLKID_USB>;
> +				clock-names =3D "phy";
> +				resets =3D <&reset RESET_USB_OTG>;
> +				reset-names =3D "phy";
> +			};
>  		};
> =20
>  		sram: sram@fffc0000 {
> diff --git a/arch/arm/dts/meson-g12-common.dtsi b/arch/arm/dts/meson-g12-=
common.dtsi
> index 1e83ec5b8c..00c6f53290 100644
> --- a/arch/arm/dts/meson-g12-common.dtsi
> +++ b/arch/arm/dts/meson-g12-common.dtsi
> @@ -17,6 +17,12 @@
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
> =20
> +	aliases {
> +		mmc0 =3D &sd_emmc_b; /* SD card */
> +		mmc1 =3D &sd_emmc_c; /* eMMC */
> +		mmc2 =3D &sd_emmc_a; /* SDIO */
> +	};
> +
>  	chosen {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> @@ -122,9 +128,9 @@
> =20
>  		pcie: pcie@fc000000 {
>  			compatible =3D "amlogic,g12a-pcie", "snps,dw-pcie";
> -			reg =3D <0x0 0xfc000000 0x0 0x400000
> -			       0x0 0xff648000 0x0 0x2000
> -			       0x0 0xfc400000 0x0 0x200000>;
> +			reg =3D <0x0 0xfc000000 0x0 0x400000>,
> +			      <0x0 0xff648000 0x0 0x2000>,
> +			      <0x0 0xfc400000 0x0 0x200000>;
>  			reg-names =3D "elbi", "cfg", "config";
>  			interrupts =3D <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			#interrupt-cells =3D <1>;
> @@ -134,8 +140,8 @@
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
>  			device_type =3D "pci";
> -			ranges =3D <0x81000000 0 0 0x0 0xfc600000 0 0x00100000
> -				  0x82000000 0 0xfc700000 0x0 0xfc700000 0 0x1900000>;
> +			ranges =3D <0x81000000 0 0 0x0 0xfc600000 0 0x00100000>,
> +				 <0x82000000 0 0xfc700000 0x0 0xfc700000 0 0x1900000>;
> =20
>  			clocks =3D <&clkc CLKID_PCIE_PHY
>  				  &clkc CLKID_PCIE_COMB
> @@ -209,7 +215,7 @@
>  		};
> =20
>  		ethmac: ethernet@ff3f0000 {
> -			compatible =3D "amlogic,meson-axg-dwmac",
> +			compatible =3D "amlogic,meson-g12a-dwmac",
>  				     "snps,dwmac-3.70a",
>  				     "snps,dwmac";
>  			reg =3D <0x0 0xff3f0000 0x0 0x10000>,
> @@ -282,6 +288,8 @@
>  				hwrng: rng@218 {
>  					compatible =3D "amlogic,meson-rng";
>  					reg =3D <0x0 0x218 0x0 0x4>;
> +					clocks =3D <&clkc CLKID_RNG0>;
> +					clock-names =3D "core";
>  				};
>  			};
> =20
> @@ -2001,7 +2009,7 @@
>  				};
>  			};
> =20
> -			vrtc: rtc@0a8 {
> +			vrtc: rtc@a8 {
>  				compatible =3D "amlogic,meson-vrtc";
>  				reg =3D <0x0 0x000a8 0x0 0x4>;
>  			};
> @@ -2179,6 +2187,12 @@
>  				amlogic,channel-interrupts =3D <64 65 66 67 68 69 70 71>;
>  			};
> =20
> +			watchdog: watchdog@f0d0 {
> +				compatible =3D "amlogic,meson-gxbb-wdt";
> +				reg =3D <0x0 0xf0d0 0x0 0x10>;
> +				clocks =3D <&xtal>;
> +			};
> +
>  			spicc0: spi@13000 {
>  				compatible =3D "amlogic,meson-g12a-spicc";
>  				reg =3D <0x0 0x13000 0x0 0x44>;
> @@ -2303,6 +2317,7 @@
>  				clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
>  				clock-names =3D "xtal", "pclk", "baud";
>  				status =3D "disabled";
> +				fifo-size =3D <128>;
>  			};
>  		};
> =20
> @@ -2380,7 +2395,7 @@
>  				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,dis_u2_susphy_quirk;
> -				snps,quirk-frame-length-adjustment;
> +				snps,quirk-frame-length-adjustment =3D <0x20>;
>  				snps,parkmode-disable-ss-quirk;
>  			};
>  		};
> diff --git a/arch/arm/dts/meson-g12a-sei510.dts b/arch/arm/dts/meson-g12a=
-sei510.dts
> index b00d0468c7..81269ccc24 100644
> --- a/arch/arm/dts/meson-g12a-sei510.dts
> +++ b/arch/arm/dts/meson-g12a-sei510.dts
> @@ -181,7 +181,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "G12A-SEI510";
> +		model =3D "SEI510";
>  		audio-aux-devs =3D <&tdmout_a>, <&tdmout_b>,
>  				 <&tdmin_a>, <&tdmin_b>;
>  		audio-routing =3D "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> diff --git a/arch/arm/dts/meson-g12b-gsking-x.dts b/arch/arm/dts/meson-g1=
2b-gsking-x.dts
> new file mode 100644
> index 0000000000..6c7bfacbad
> --- /dev/null
> +++ b/arch/arm/dts/meson-g12b-gsking-x.dts
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12b-w400.dtsi"
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible =3D "azw,gsking-x", "amlogic,s922x", "amlogic,g12b";
> +	model =3D "Beelink GS-King X";
> +
> +	aliases {
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
> +	};
> +
> +	gpio-keys-polled {
> +		compatible =3D "gpio-keys-polled";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		poll-interval =3D <100>;
> +
> +		power-button {
> +			label =3D "power";
> +			linux,code =3D <KEY_POWER>;
> +			gpios =3D <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	sound {
> +		compatible =3D "amlogic,axg-sound-card";
> +		model =3D "GSKING-X";
> +		audio-aux-devs =3D <&tdmout_a>;
> +		audio-routing =3D "TDMOUT_A IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 1",
> +				"TDM_A Playback", "TDMOUT_A OUT";
> +
> +		assigned-clocks =3D <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai =3D <&tdmif_a>;
> +			dai-format =3D "i2s";
> +			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-1 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-2 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-3 =3D <1 1>;
> +			mclk-fs =3D <256>;
> +
> +			codec {
> +				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_A>;
> +			};
> +		};
> +
> +		dai-link-4 {
> +			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&arb {
> +	status =3D "okay";
> +};
> +
> +&clkc_audio {
> +	status =3D "okay";
> +};
> +
> +&frddr_a {
> +	status =3D "okay";
> +};
> +
> +&frddr_b {
> +	status =3D "okay";
> +};
> +
> +&frddr_c {
> +	status =3D "okay";
> +};
> +
> +&i2c3 {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> +	pinctrl-names =3D "default";
> +
> +	rtc: rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		wakeup-source;
> +	};
> +};
> +
> +&tdmif_a {
> +	status =3D "okay";
> +};
> +
> +&tdmout_a {
> +	status =3D "okay";
> +};
> +
> +&tohdmitx {
> +	status =3D "okay";
> +};
> diff --git a/arch/arm/dts/meson-g12b-gtking-pro.dts b/arch/arm/dts/meson-=
g12b-gtking-pro.dts
> index f0c56a16af..707daf9278 100644
> --- a/arch/arm/dts/meson-g12b-gtking-pro.dts
> +++ b/arch/arm/dts/meson-g12b-gtking-pro.dts
> @@ -11,9 +11,14 @@
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> =20
>  / {
> -	compatible =3D "azw,gtking", "amlogic,g12b";
> +	compatible =3D "azw,gtking", "amlogic,s922x", "amlogic,g12b";
>  	model =3D "Beelink GT-King Pro";
> =20
> +	aliases {
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
> +	};
> +
>  	gpio-keys-polled {
>  		compatible =3D "gpio-keys-polled";
>  		#address-cells =3D <1>;
> @@ -30,7 +35,7 @@
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> -		white {
> +		led-white {
>  			label =3D "power:white";
>  			gpios =3D <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
>  			default-state =3D "on";
> @@ -39,7 +44,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "G12B-GTKING-PRO";
> +		model =3D "GTKING-PRO";
>  		audio-aux-devs =3D <&tdmout_b>;
>  		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>  				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> @@ -112,6 +117,18 @@
>  	status =3D "okay";
>  };
> =20
> +&i2c3 {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> +	pinctrl-names =3D "default";
> +
> +	rtc: rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		wakeup-source;
> +	};
> +};
> +
>  &tdmif_b {
>  	status =3D "okay";
>  };
> diff --git a/arch/arm/dts/meson-g12b-gtking.dts b/arch/arm/dts/meson-g12b=
-gtking.dts
> index eeb7bc5539..5d96c14490 100644
> --- a/arch/arm/dts/meson-g12b-gtking.dts
> +++ b/arch/arm/dts/meson-g12b-gtking.dts
> @@ -11,9 +11,14 @@
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> =20
>  / {
> -	compatible =3D "azw,gtking", "amlogic,g12b";
> +	compatible =3D "azw,gtking", "amlogic,s922x", "amlogic,g12b";
>  	model =3D "Beelink GT-King";
> =20
> +	aliases {
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
> +	};
> +
>  	spdif_dit: audio-codec-1 {
>  		#sound-dai-cells =3D <0>;
>  		compatible =3D "linux,spdif-dit";
> @@ -23,7 +28,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "G12B-GTKING";
> +		model =3D "GTKING";
>  		audio-aux-devs =3D <&tdmout_b>;
>  		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>  				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> @@ -122,6 +127,19 @@
>  	status =3D "okay";
>  };
> =20
> +
> +&i2c3 {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> +	pinctrl-names =3D "default";
> +
> +	rtc: rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		wakeup-source;
> +	};
> +};
> +
>  &spdifout {
>  	pinctrl-0 =3D <&spdif_out_h_pins>;
>  	pinctrl-names =3D "default";
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2-plus.dts b/arch/arm/dts/me=
son-g12b-odroid-n2-plus.dts
> index 5de2815ba9..ce1198ad34 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2-plus.dts
> +++ b/arch/arm/dts/meson-g12b-odroid-n2-plus.dts
> @@ -19,7 +19,7 @@
>  	regulator-min-microvolt =3D <680000>;
>  	regulator-max-microvolt =3D <1040000>;
> =20
> -	pwms =3D <&pwm_AO_cd 1 1500 0>;
> +	pwms =3D <&pwm_ab 0 1500 0>;
>  };
> =20
>  &vddcpu_b {
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dtsi b/arch/arm/dts/meson-=
g12b-odroid-n2.dtsi
> index 6982632ae6..344573e157 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
> @@ -13,6 +13,8 @@
>  	aliases {
>  		serial0 =3D &uart_AO;
>  		ethernet0 =3D &ethmac;
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
>  	};
> =20
>  	dioo2133: audio-amplifier-0 {
> @@ -40,7 +42,7 @@
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> -		blue {
> +		led-blue {
>  			label =3D "n2:blue";
>  			gpios =3D <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger =3D "heartbeat";
> @@ -211,7 +213,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "G12B-ODROID-N2";
> +		model =3D "ODROID-N2";
>  		audio-widgets =3D "Line", "Lineout";
>  		audio-aux-devs =3D <&tdmout_b>, <&tdmout_c>, <&tdmin_a>,
>  				 <&tdmin_b>, <&tdmin_c>, <&tdmin_lb>,
> @@ -408,12 +410,12 @@
> =20
>  &ext_mdio {
>  	external_phy: ethernet-phy@0 {
> -		/* Realtek RTL8211F (0x001cc916) */=09
> +		/* Realtek RTL8211F (0x001cc916) */
>  		reg =3D <0>;
>  		max-speed =3D <1000>;
> =20
>  		reset-assert-us =3D <10000>;
> -		reset-deassert-us =3D <30000>;
> +		reset-deassert-us =3D <80000>;
>  		reset-gpios =3D <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> =20
>  		interrupt-parent =3D <&gpio_intc>;
> @@ -444,13 +446,58 @@
>  };
> =20
>  &gpio {
> +	gpio-line-names =3D
> +		/* GPIOZ */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOH */
> +		"", "", "", "", "", "", "", "",
> +		"",
> +		/* BOOT */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOC */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOA */
> +		"PIN_44", /* GPIOA_0 */
> +		"PIN_46", /* GPIOA_1 */
> +		"PIN_45", /* GPIOA_2 */
> +		"PIN_47", /* GPIOA_3 */
> +		"PIN_26", /* GPIOA_4 */
> +		"", "", "", "", "", "",
> +		"PIN_42", /* GPIOA_11 */
> +		"PIN_32", /* GPIOA_12 */
> +		"PIN_7",  /* GPIOA_13 */
> +		"PIN_27", /* GPIOA_14 */
> +		"PIN_28", /* GPIOA_15 */
> +		/* GPIOX */
> +		"PIN_16", /* GPIOX_0 */
> +		"PIN_18", /* GPIOX_1 */
> +		"PIN_22", /* GPIOX_2 */
> +		"PIN_11", /* GPIOX_3 */
> +		"PIN_13", /* GPIOX_4 */
> +		"PIN_33", /* GPIOX_5 */
> +		"PIN_35", /* GPIOX_6 */
> +		"PIN_15", /* GPIOX_7 */
> +		"PIN_19", /* GPIOX_8 */
> +		"PIN_21", /* GPIOX_9 */
> +		"PIN_24", /* GPIOX_10 */
> +		"PIN_23", /* GPIOX_11 */
> +		"PIN_8",  /* GPIOX_12 */
> +		"PIN_10", /* GPIOX_13 */
> +		"PIN_29", /* GPIOX_14 */
> +		"PIN_31", /* GPIOX_15 */
> +		"PIN_12", /* GPIOX_16 */
> +		"PIN_3",  /* GPIOX_17 */
> +		"PIN_5",  /* GPIOX_18 */
> +		"PIN_36"; /* GPIOX_19 */
>  	/*
>  	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
>  	 * to be turned high in order to be detected by the USB Controller
>  	 * This signal should be handled by a USB specific power sequence
>  	 * in order to reset the Hub when USB bus is powered down.
>  	 */
> -	usb-hub {
> +	hog-0 {
>  		gpio-hog;
>  		gpios =3D <GPIOH_4 GPIO_ACTIVE_HIGH>;
>  		output-high;
> @@ -478,6 +525,18 @@
>  	linux,rc-map-name =3D "rc-odroid";
>  };
> =20
> +&i2c3 {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> +	pinctrl-names =3D "default";
> +
> +	rtc: rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		wakeup-source;
> +	};
> +};
> +
>  &pwm_ab {
>  	pinctrl-0 =3D <&pwm_a_e_pins>;
>  	pinctrl-names =3D "default";
> @@ -494,6 +553,11 @@
>  	status =3D "okay";
>  };
> =20
> +&saradc {
> +	status =3D "okay";
> +	vref-supply =3D <&vddao_1v8>;
> +};
> +
>  /* SD card */
>  &sd_emmc_b {
>  	status =3D "okay";
> diff --git a/arch/arm/dts/meson-g12b-w400.dtsi b/arch/arm/dts/meson-g12b-=
w400.dtsi
> index 2802ddbb83..feb0885047 100644
> --- a/arch/arm/dts/meson-g12b-w400.dtsi
> +++ b/arch/arm/dts/meson-g12b-w400.dtsi
> @@ -264,7 +264,7 @@
>  		max-speed =3D <1000>;
> =20
>  		reset-assert-us =3D <10000>;
> -		reset-deassert-us =3D <30000>;
> +		reset-deassert-us =3D <80000>;
>  		reset-gpios =3D <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> =20
>  		interrupt-parent =3D <&gpio_intc>;
> diff --git a/arch/arm/dts/meson-g12b.dtsi b/arch/arm/dts/meson-g12b.dtsi
> index 9b8548e5f6..ee8fcae9f9 100644
> --- a/arch/arm/dts/meson-g12b.dtsi
> +++ b/arch/arm/dts/meson-g12b.dtsi
> @@ -135,3 +135,7 @@
>  		};
>  	};
>  };
> +
> +&mali {
> +	dma-coherent;
> +};
> diff --git a/arch/arm/dts/meson-gx-libretech-pc.dtsi b/arch/arm/dts/meson=
-gx-libretech-pc.dtsi
> index c2480bab8d..2d7032f41e 100644
> --- a/arch/arm/dts/meson-gx-libretech-pc.dtsi
> +++ b/arch/arm/dts/meson-gx-libretech-pc.dtsi
> @@ -186,7 +186,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,gx-sound-card";
> -		model =3D "GXL-LIBRETECH-S9XX-PC";
> +		model =3D "LIBRETECH-PC";
>  		audio-aux-devs =3D <&dio2133>;
>  		audio-widgets =3D "Speaker", "7J4-14 LEFT",
>  				"Speaker", "7J4-11 RIGHT";
> diff --git a/arch/arm/dts/meson-gx-p23x-q20x.dtsi b/arch/arm/dts/meson-gx=
-p23x-q20x.dtsi
> index 6b57e15aad..dafc841f7c 100644
> --- a/arch/arm/dts/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm/dts/meson-gx-p23x-q20x.dtsi
> @@ -121,7 +121,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,gx-sound-card";
> -		model =3D "GX-P230-Q200";
> +		model =3D "P230-Q200";
>  		audio-aux-devs =3D <&dio2133>;
>  		audio-widgets =3D "Line", "Lineout";
>  		audio-routing =3D "AU2 INL", "ACODEC LOLP",
> diff --git a/arch/arm/dts/meson-gx.dtsi b/arch/arm/dts/meson-gx.dtsi
> index 0edd137151..6b457b2c30 100644
> --- a/arch/arm/dts/meson-gx.dtsi
> +++ b/arch/arm/dts/meson-gx.dtsi
> @@ -20,6 +20,12 @@
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
> =20
> +	aliases {
> +		mmc0 =3D &sd_emmc_b; /* SD card */
> +		mmc1 =3D &sd_emmc_c; /* eMMC */
> +		mmc2 =3D &sd_emmc_a; /* SDIO */
> +	};
> +
>  	reserved-memory {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> @@ -295,6 +301,7 @@
>  				reg =3D <0x0 0x84c0 0x0 0x18>;
>  				interrupts =3D <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>  				status =3D "disabled";
> +				fifo-size =3D <128>;
>  			};
> =20
>  			uart_B: serial@84dc {
> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-g=
xbb-nanopi-k2.dts
> index 7be3e35409..7273eed529 100644
> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> @@ -7,6 +7,7 @@
> =20
>  #include "meson-gxbb.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/meson-aiu.h>
> =20
>  / {
>  	compatible =3D "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
> @@ -130,6 +131,45 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible =3D "amlogic,gx-sound-card";
> +		model =3D "NANOPI-K2";
> +		assigned-clocks =3D <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format =3D "i2s";
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status =3D "okay";
>  };
> =20
>  &cec_AO {
> @@ -165,7 +205,7 @@
>  			reg =3D <0>;
> =20
>  			reset-assert-us =3D <10000>;
> -			reset-deassert-us =3D <30000>;
> +			reset-deassert-us =3D <80000>;
>  			reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> =20
>  			interrupt-parent =3D <&gpio_intc>;
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gx=
bb-odroidc2.dts
> index 70fcfb7b06..201596247f 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
> @@ -9,6 +9,7 @@
> =20
>  #include "meson-gxbb.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/meson-aiu.h>
> =20
>  / {
>  	compatible =3D "hardkernel,odroid-c2", "amlogic,meson-gxbb";
> @@ -172,6 +173,45 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible =3D "amlogic,gx-sound-card";
> +		model =3D "ODROID-C2";
> +		assigned-clocks =3D <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format =3D "i2s";
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status =3D "okay";
>  };
> =20
>  &cec_AO {
> @@ -200,7 +240,7 @@
>  			reg =3D <0>;
> =20
>  			reset-assert-us =3D <10000>;
> -			reset-deassert-us =3D <30000>;
> +			reset-deassert-us =3D <80000>;
>  			reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> =20
>  			interrupt-parent =3D <&gpio_intc>;
> @@ -217,7 +257,7 @@
>  	 * This signal should be handled by a USB specific power sequence
>  	 * in order to reset the Hub when USB bus is powered down.
>  	 */
> -	usb-hub {
> +	hog-0 {
>  		gpio-hog;
>  		gpios =3D <GPIOAO_4 GPIO_ACTIVE_HIGH>;
>  		output-high;
> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts=
/meson-gxl-s805x-libretech-ac.dts
> index 9e43f4dca9..2d769203f6 100644
> --- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> @@ -118,7 +118,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,gx-sound-card";
> -		model =3D "GXL-LIBRETECH-S805X-AC";
> +		model =3D "LIBRETECH-AC";
>  		audio-widgets =3D "Speaker", "9J5-3 LEFT",
>  				"Speaker", "9J5-2 RIGHT";
>  		audio-routing =3D "9J5-3 LEFT", "ACODEC LOLN",
> diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts/m=
eson-gxl-s905x-khadas-vim.dts
> index 8bcdffdf55..60feac0179 100644
> --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> @@ -5,9 +5,9 @@
> =20
>  /dts-v1/;
> =20
> -#include <dt-bindings/input/input.h>
> -
>  #include "meson-gxl-s905x-p212.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/sound/meson-aiu.h>
> =20
>  / {
>  	compatible =3D "khadas,vim", "amlogic,s905x", "amlogic,meson-gxl";
> @@ -42,10 +42,10 @@
>  		};
>  	};
> =20
> -	pwmleds {
> +	led-controller {
>  		compatible =3D "pwm-leds";
> =20
> -		power {
> +		led-1 {
>  			label =3D "vim:red:power";
>  			pwms =3D <&pwm_AO_ab 1 7812500 0>;
>  			max-brightness =3D <255>;
> @@ -63,6 +63,45 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible =3D "amlogic,gx-sound-card";
> +		model =3D "KHADAS-VIM";
> +		assigned-clocks =3D <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format =3D "i2s";
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status =3D "okay";
>  };
> =20
>  &cec_AO {
> @@ -97,8 +136,7 @@
>  	pinctrl-names =3D "default";
> =20
>  	rtc: rtc@51 {
> -		/* has to be enabled manually when a battery is connected: */
> -		status =3D "disabled";
> +		status =3D "okay";
>  		compatible =3D "haoyu,hym8563";
>  		reg =3D <0x51>;
>  		#clock-cells =3D <0>;
> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm/=
dts/meson-gxl-s905x-libretech-cc-v2.dts
> index 675eaa8796..93d8f8aff7 100644
> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
> @@ -84,7 +84,6 @@
>  		regulator-always-on;
>  	};
> =20
> -
>  	vcck: regulator-vcck {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "VCCK";
> @@ -124,7 +123,6 @@
>  		regulator-always-on;
>  	};
> =20
> -
>  	vddio_card: regulator-vddio-card {
>  		compatible =3D "regulator-gpio";
>  		regulator-name =3D "VDDIO_CARD";
> @@ -161,7 +159,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,gx-sound-card";
> -		model =3D "GXL-LIBRETECH-S905X-CC-V2";
> +		model =3D "LIBRETECH-CC-V2";
>  		assigned-clocks =3D <&clkc CLKID_MPLL0>,
>  				  <&clkc CLKID_MPLL1>,
>  				  <&clkc CLKID_MPLL2>;
> @@ -195,7 +193,6 @@
>  	};
>  };
> =20
> -
>  &aiu {
>  	status =3D "okay";
>  };
> @@ -207,7 +204,6 @@
>  	hdmi-phandle =3D <&hdmi_tx>;
>  };
> =20
> -
>  &ethmac {
>  	status =3D "okay";
>  };
> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/dts=
/meson-gxl-s905x-libretech-cc.dts
> index 5ae7bb6209..82bfabfbd3 100644
> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> @@ -135,7 +135,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,gx-sound-card";
> -		model =3D "GXL-LIBRETECH-S905X-CC";
> +		model =3D "LIBRETECH-CC";
>  		audio-aux-devs =3D <&dio2133>;
>  		audio-widgets =3D "Line", "Lineout";
>  		audio-routing =3D "AU2 INL", "ACODEC LOLN",
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-=
gxm-khadas-vim2.dts
> index bff8ec2c1c..18a4b7a6c5 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> @@ -7,9 +7,9 @@
> =20
>  /dts-v1/;
> =20
> -#include <dt-bindings/input/input.h>
> -
>  #include "meson-gxm.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/sound/meson-aiu.h>
> =20
>  / {
>  	compatible =3D "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
> @@ -81,10 +81,10 @@
>  		};
>  	};
> =20
> -	pwmleds {
> +	led-controller {
>  		compatible =3D "pwm-leds";
> =20
> -		power {
> +		led-1 {
>  			label =3D "vim:red:power";
>  			pwms =3D <&pwm_AO_ab 1 7812500 0>;
>  			max-brightness =3D <255>;
> @@ -145,6 +145,45 @@
>  		clock-frequency =3D <32768>;
>  		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
>  	};
> +
> +	sound {
> +		compatible =3D "amlogic,gx-sound-card";
> +		model =3D "KHADAS-VIM2";
> +		assigned-clocks =3D <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format =3D "i2s";
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status =3D "okay";
>  };
> =20
>  &cec_AO {
> @@ -154,7 +193,6 @@
>  	hdmi-phandle =3D <&hdmi_tx>;
>  };
> =20
> -
>  &cpu_cooling_maps {
>  	map0 {
>  		cooling-device =3D <&gpio_fan THERMAL_NO_LIMIT 1>;
> @@ -194,7 +232,7 @@
>  		reg =3D <0>;
> =20
>  		reset-assert-us =3D <10000>;
> -		reset-deassert-us =3D <30000>;
> +		reset-deassert-us =3D <80000>;
>  		reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> =20
>  		interrupt-parent =3D <&gpio_intc>;
> @@ -228,8 +266,7 @@
>  	pinctrl-names =3D "default";
> =20
>  	rtc: rtc@51 {
> -		/* has to be enabled manually when a battery is connected: */
> -		status =3D "disabled";
> +		status =3D "okay";
>  		compatible =3D "haoyu,hym8563";
>  		reg =3D <0x51>;
>  		#clock-cells =3D <0>;
> @@ -341,7 +378,7 @@
>  		#size-cells =3D <1>;
>  		compatible =3D "winbond,w25q16", "jedec,spi-nor";
>  		reg =3D <0>;
> -		spi-max-frequency =3D <3000000>;
> +		spi-max-frequency =3D <104000000>;
>  	};
>  };
> =20
> diff --git a/arch/arm/dts/meson-gxm-wetek-core2.dts b/arch/arm/dts/meson-=
gxm-wetek-core2.dts
> index ec794c134c..1e7f77f9b5 100644
> --- a/arch/arm/dts/meson-gxm-wetek-core2.dts
> +++ b/arch/arm/dts/meson-gxm-wetek-core2.dts
> @@ -22,7 +22,7 @@
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> -		blue {
> +		led-blue {
>  			color =3D <LED_COLOR_ID_BLUE>;
>  			function =3D LED_FUNCTION_STATUS;
>  			gpios =3D <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/dts/meson-gxm.dtsi b/arch/arm/dts/meson-gxm.dtsi
> index fe41451122..411cc312fc 100644
> --- a/arch/arm/dts/meson-gxm.dtsi
> +++ b/arch/arm/dts/meson-gxm.dtsi
> @@ -42,11 +42,28 @@
>  			};
>  		};
> =20
> +		cpu0: cpu@0 {
> +			capacity-dmips-mhz =3D <1024>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			capacity-dmips-mhz =3D <1024>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			capacity-dmips-mhz =3D <1024>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			capacity-dmips-mhz =3D <1024>;
> +		};
> +
>  		cpu4: cpu@100 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a53";
>  			reg =3D <0x0 0x100>;
>  			enable-method =3D "psci";
> +			capacity-dmips-mhz =3D <1024>;
>  			next-level-cache =3D <&l2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			#cooling-cells =3D <2>;
> @@ -57,6 +74,7 @@
>  			compatible =3D "arm,cortex-a53";
>  			reg =3D <0x0 0x101>;
>  			enable-method =3D "psci";
> +			capacity-dmips-mhz =3D <1024>;
>  			next-level-cache =3D <&l2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			#cooling-cells =3D <2>;
> @@ -67,6 +85,7 @@
>  			compatible =3D "arm,cortex-a53";
>  			reg =3D <0x0 0x102>;
>  			enable-method =3D "psci";
> +			capacity-dmips-mhz =3D <1024>;
>  			next-level-cache =3D <&l2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			#cooling-cells =3D <2>;
> @@ -77,6 +96,7 @@
>  			compatible =3D "arm,cortex-a53";
>  			reg =3D <0x0 0x103>;
>  			enable-method =3D "psci";
> +			capacity-dmips-mhz =3D <1024>;
>  			next-level-cache =3D <&l2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			#cooling-cells =3D <2>;
> diff --git a/arch/arm/dts/meson-khadas-vim3.dtsi b/arch/arm/dts/meson-kha=
das-vim3.dtsi
> index 7b46555ac5..3cf4ecb6d5 100644
> --- a/arch/arm/dts/meson-khadas-vim3.dtsi
> +++ b/arch/arm/dts/meson-khadas-vim3.dtsi
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> =20
> @@ -13,6 +14,8 @@
>  	aliases {
>  		serial0 =3D &uart_AO;
>  		ethernet0 =3D &ethmac;
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
>  	};
> =20
>  	chosen {
> @@ -41,13 +44,15 @@
>  		compatible =3D "gpio-leds";
> =20
>  		led-white {
> -			label =3D "vim3:white:sys";
> +			color =3D <LED_COLOR_ID_WHITE>;
> +			function =3D LED_FUNCTION_STATUS;
>  			gpios =3D <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger =3D "heartbeat";
>  		};
> =20
>  		led-red {
> -			label =3D "vim3:red";
> +			color =3D <LED_COLOR_ID_RED>;
> +			function =3D LED_FUNCTION_STATUS;
>  			gpios =3D <&gpio_expander 5 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> @@ -165,12 +170,17 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "G12B-KHADAS-VIM3";
> -		audio-aux-devs =3D <&tdmout_a>;
> +		model =3D "KHADAS-VIM3";
> +		audio-aux-devs =3D <&tdmin_a>, <&tdmout_a>;
>  		audio-routing =3D "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>  				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>  				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> -				"TDM_A Playback", "TDMOUT_A OUT";
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 3", "TDM_A Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT";
> =20
>  		assigned-clocks =3D <&clkc CLKID_MPLL2>,
>  				  <&clkc CLKID_MPLL0>,
> @@ -193,8 +203,20 @@
>  			sound-dai =3D <&frddr_c>;
>  		};
> =20
> -		/* 8ch hdmi interface */
>  		dai-link-3 {
> +			sound-dai =3D <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai =3D <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai =3D <&toddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-6 {
>  			sound-dai =3D <&tdmif_a>;
>  			dai-format =3D "i2s";
>  			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> @@ -209,7 +231,7 @@
>  		};
> =20
>  		/* hdmi glue */
> -		dai-link-4 {
> +		dai-link-7 {
>  			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> =20
>  			codec {
> @@ -278,12 +300,12 @@
>  };
> =20
>  &ethmac {
> -        pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> -        pinctrl-names =3D "default";
> -        status =3D "okay";
> -        phy-mode =3D "rgmii";
> -        phy-handle =3D <&external_phy>;
> -        amlogic,tx-delay-ns =3D <2>;
> +	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&external_phy>;
> +	amlogic,tx-delay-ns =3D <2>;
>  };
> =20
>  &frddr_a {
> @@ -330,7 +352,7 @@
>  		#gpio-cells =3D <2>;
>  	};
> =20
> -	rtc@51 {
> +	rtc: rtc@51 {
>  		compatible =3D "haoyu,hym8563";
>  		reg =3D <0x51>;
>  		#clock-cells =3D <0>;
> @@ -349,9 +371,9 @@
>  };
> =20
>  &pwm_ef {
> -        status =3D "okay";
> -        pinctrl-0 =3D <&pwm_e_pins>;
> -        pinctrl-names =3D "default";
> +	status =3D "okay";
> +	pinctrl-0 =3D <&pwm_e_pins>;
> +	pinctrl-names =3D "default";
>  };
> =20
>  &saradc {
> @@ -445,15 +467,30 @@
>  	};
>  };
> =20
> -
>  &tdmif_a {
>  	status =3D "okay";
>  };
> =20
> +&tdmin_a {
> +	status =3D "okay";
> +};
> +
>  &tdmout_a {
>  	status =3D "okay";
>  };
> =20
> +&toddr_a {
> +	status =3D "okay";
> +};
> +
> +&toddr_b {
> +	status =3D "okay";
> +};
> +
> +&toddr_c {
> +	status =3D "okay";
> +};
> +
>  &tohdmitx {
>  	status =3D "okay";
>  };
> diff --git a/arch/arm/dts/meson-sm1-bananapi-m5.dts b/arch/arm/dts/meson-=
sm1-bananapi-m5.dts
> new file mode 100644
> index 0000000000..effaa138b5
> --- /dev/null
> +++ b/arch/arm/dts/meson-sm1-bananapi-m5.dts
> @@ -0,0 +1,646 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 BayLibre SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1.dtsi"
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible =3D "bananapi,bpi-m5", "amlogic,sm1";
> +	model =3D "Banana Pi BPI-M5";
> +
> +	adc_keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D <&saradc 2>;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D <1800000>;
> +
> +		key {
> +			label =3D "SW3";
> +			linux,code =3D <BTN_3>;
> +			press-threshold-microvolt =3D <1700000>;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		ethernet0 =3D &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	/* TOFIX: handle CVBS_DET on SARADC channel 0 */
> +	cvbs-connector {
> +		compatible =3D "composite-video-connector";
> +
> +		port {
> +			cvbs_connector_in: endpoint {
> +				remote-endpoint =3D <&cvbs_vdac_out>;
> +			};
> +		};
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible =3D "mmc-pwrseq-emmc";
> +		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		key {
> +			label =3D "SW1";
> +			linux,code =3D <BTN_1>;
> +			gpios =3D <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
> +			interrupt-parent =3D <&gpio_intc>;
> +			interrupts =3D <3 IRQ_TYPE_EDGE_BOTH>;
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		green {
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		blue {
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_11 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	emmc_1v8: regulator-emmc_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "EMMC_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	dc_in: regulator-dc_in {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "DC_IN";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_c: regulator-vddio_c {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "VDDIO_C";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		enable-gpio =3D <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +
> +		gpios =3D <&gpio_ao GPIOAO_6 GPIO_OPEN_DRAIN>;
> +		gpios-states =3D <1>;
> +
> +		states =3D <1800000 0>,
> +			 <3300000 1>;
> +	};
> +
> +	tflash_vdd: regulator-tflash_vdd {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "TFLASH_VDD";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&dc_in>;
> +		gpio =3D <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	vddao_1v8: regulator-vddao_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	vddcpu: regulator-vddcpu {
> +		/*
> +		 * SY8120B1ABC DC/DC Regulator.
> +		 */
> +		compatible =3D "pwm-regulator";
> +
> +		regulator-name =3D "VDDCPU";
> +		regulator-min-microvolt =3D <690000>;
> +		regulator-max-microvolt =3D <1050000>;
> +
> +		vin-supply =3D <&dc_in>;
> +
> +		pwms =3D <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range =3D <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	/* USB Hub Power Enable */
> +	vl_pwr_en: regulator-vl_pwr_en {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VL_PWR_EN";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		vin-supply =3D <&dc_in>;
> +
> +		gpio =3D <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible =3D "amlogic,axg-sound-card";
> +		model =3D "BPI-M5";
> +		audio-widgets =3D "Line", "Lineout";
> +		audio-aux-devs =3D <&tdmout_b>, <&tdmout_c>,
> +				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>;
> +		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT",
> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
> +				"TDM_C Playback", "TDMOUT_C OUT",
> +				"TDMIN_A IN 4", "TDM_B Loopback",
> +				"TDMIN_B IN 4", "TDM_B Loopback",
> +				"TDMIN_C IN 4", "TDM_B Loopback",
> +				"TDMIN_A IN 5", "TDM_C Loopback",
> +				"TDMIN_B IN 5", "TDM_C Loopback",
> +				"TDMIN_C IN 5", "TDM_C Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT",
> +				"TODDR_A IN 1", "TDMIN_B OUT",
> +				"TODDR_B IN 1", "TDMIN_B OUT",
> +				"TODDR_C IN 1", "TDMIN_B OUT",
> +				"TODDR_A IN 2", "TDMIN_C OUT",
> +				"TODDR_B IN 2", "TDMIN_C OUT",
> +				"TODDR_C IN 2", "TDMIN_C OUT",
> +				"Lineout", "ACODEC LOLP",
> +				"Lineout", "ACODEC LORP";
> +
> +		assigned-clocks =3D <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&frddr_c>;
> +		};
> +
> +		dai-link-3 {
> +			sound-dai =3D <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai =3D <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai =3D <&toddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-6 {
> +			sound-dai =3D <&tdmif_b>;
> +			dai-format =3D "i2s";
> +			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-1 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-2 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-3 =3D <1 1>;
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +
> +			codec-1 {
> +				sound-dai =3D <&toacodec TOACODEC_IN_B>;
> +			};
> +		};
> +
> +		/* i2s jack output interface */
> +		dai-link-7 {
> +			sound-dai =3D <&tdmif_c>;
> +			dai-format =3D "i2s";
> +			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> +			mclk-fs =3D <256>;
> +
> +			codec-0 {
> +				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_C>;
> +			};
> +
> +			codec-1 {
> +				sound-dai =3D <&toacodec TOACODEC_IN_C>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-8 {
> +			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +
> +		/* acodec glue */
> +		dai-link-9 {
> +			sound-dai =3D <&toacodec TOACODEC_OUT>;
> +
> +			codec {
> +				sound-dai =3D <&acodec>;
> +			};
> +		};
> +	};
> +};
> +
> +&acodec {
> +	AVDD-supply =3D <&vddao_1v8>;
> +	status =3D "okay";
> +};
> +
> +&arb {
> +	status =3D "okay";
> +};
> +
> +&clkc_audio {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU1_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu2 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU2_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu3 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU3_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint =3D <&cvbs_connector_in>;
> +	};
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg =3D <0>;
> +		max-speed =3D <1000>;
> +
> +		interrupt-parent =3D <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +	phy-mode =3D "rgmii-txid";
> +	phy-handle =3D <&external_phy>;
> +};
> +
> +&frddr_a {
> +	status =3D "okay";
> +};
> +
> +&frddr_b {
> +	status =3D "okay";
> +};
> +
> +&frddr_c {
> +	status =3D "okay";
> +};
> +
> +&gpio {
> +	gpio-line-names =3D
> +		/* GPIOZ */
> +		"ETH_MDIO", /* GPIOZ_0 */
> +		"ETH_MDC", /* GPIOZ_1 */
> +		"ETH_RXCLK", /* GPIOZ_2 */
> +		"ETH_RX_DV", /* GPIOZ_3 */
> +		"ETH_RXD0", /* GPIOZ_4 */
> +		"ETH_RXD1", /* GPIOZ_5 */
> +		"ETH_RXD2", /* GPIOZ_6 */
> +		"ETH_RXD3", /* GPIOZ_7 */
> +		"ETH_TXCLK", /* GPIOZ_8 */
> +		"ETH_TXEN", /* GPIOZ_9 */
> +		"ETH_TXD0", /* GPIOZ_10 */
> +		"ETH_TXD1", /* GPIOZ_11 */
> +		"ETH_TXD2", /* GPIOZ_12 */
> +		"ETH_TXD3", /* GPIOZ_13 */
> +		"ETH_INTR", /* GPIOZ_14 */
> +		"ETH_NRST", /* GPIOZ_15 */
> +		/* GPIOH */
> +		"HDMI_SDA", /* GPIOH_0 */
> +		"HDMI_SCL", /* GPIOH_1 */
> +		"HDMI_HPD", /* GPIOH_2 */
> +		"HDMI_CEC", /* GPIOH_3 */
> +		"VL-RST_N", /* GPIOH_4 */
> +		"CON1-P36", /* GPIOH_5 */
> +		"VL-PWREN", /* GPIOH_6 */
> +		"WiFi_3V3_1V8", /* GPIOH_7 */
> +		"TFLASH_VDD_EN", /* GPIOH_8 */
> +		/* BOOT */
> +		"eMMC_D0", /* BOOT_0 */
> +		"eMMC_D1", /* BOOT_1 */
> +		"eMMC_D2", /* BOOT_2 */
> +		"eMMC_D3", /* BOOT_3 */
> +		"eMMC_D4", /* BOOT_4 */
> +		"eMMC_D5", /* BOOT_5 */
> +		"eMMC_D6", /* BOOT_6 */
> +		"eMMC_D7", /* BOOT_7 */
> +		"eMMC_CLK", /* BOOT_8 */
> +		"",
> +		"eMMC_CMD", /* BOOT_10 */
> +		"",
> +		"eMMC_RST#", /* BOOT_12 */
> +		"eMMC_DS", /* BOOT_13 */
> +		/* GPIOC */
> +		"SD_D0_B", /* GPIOC_0 */
> +		"SD_D1_B", /* GPIOC_1 */
> +		"SD_D2_B", /* GPIOC_2 */
> +		"SD_D3_B", /* GPIOC_3 */
> +		"SD_CLK_B", /* GPIOC_4 */
> +		"SD_CMD_B", /* GPIOC_5 */
> +		"CARD_EN_DET", /* GPIOC_6 */
> +		"",
> +		/* GPIOA */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "",
> +		"CON1-P27", /* GPIOA_14 */
> +		"CON1-P28", /* GPIOA_15 */
> +		/* GPIOX */
> +		"CON1-P16", /* GPIOX_0 */
> +		"CON1-P18", /* GPIOX_1 */
> +		"CON1-P22", /* GPIOX_2 */
> +		"CON1-P11", /* GPIOX_3 */
> +		"CON1-P13", /* GPIOX_4 */
> +		"CON1-P07", /* GPIOX_5 */
> +		"CON1-P33", /* GPIOX_6 */
> +		"CON1-P15", /* GPIOX_7 */
> +		"CON1-P19", /* GPIOX_8 */
> +		"CON1-P21", /* GPIOX_9 */
> +		"CON1-P24", /* GPIOX_10 */
> +		"CON1-P23", /* GPIOX_11 */
> +		"CON1-P08", /* GPIOX_12 */
> +		"CON1-P10", /* GPIOX_13 */
> +		"CON1-P29", /* GPIOX_14 */
> +		"CON1-P31", /* GPIOX_15 */
> +		"CON1-P26", /* GPIOX_16 */
> +		"CON1-P03", /* GPIOX_17 */
> +		"CON1-P05", /* GPIOX_18 */
> +		"CON1-P32"; /* GPIOX_19 */
> +
> +	/*
> +	 * WARNING: The USB Hub on the BPI-M5 needs a reset signal
> +	 * to be turned high in order to be detected by the USB Controller
> +	 * This signal should be handled by a USB specific power sequence
> +	 * in order to reset the Hub when USB bus is powered down.
> +	 */
> +	usb-hub {
> +		gpio-hog;
> +		gpios =3D <GPIOH_4 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name =3D "usb-hub-reset";
> +	};
> +};
> +
> +&gpio_ao {
> +	gpio-line-names =3D
> +		/* GPIOAO */
> +		"DEBUG TX", /* GPIOAO_0 */
> +		"DEBUG RX", /* GPIOAO_1 */
> +		"SYS_LED2", /* GPIOAO_2 */
> +		"UPDATE_KEY", /* GPIOAO_3 */
> +		"CON1-P40", /* GPIOAO_4 */
> +		"IR_IN", /* GPIOAO_5 */
> +		"TF_3V3N_1V8_EN", /* GPIOAO_6 */
> +		"CON1-P35", /* GPIOAO_7 */
> +		"CON1-P12", /* GPIOAO_8 */
> +		"CON1-P37", /* GPIOAO_9 */
> +		"CON1-P38", /* GPIOAO_10 */
> +		"SYS_LED", /* GPIOAO_11 */
> +		/* GPIOE */
> +		"VDDEE_PWM", /* GPIOE_0 */
> +		"VDDCPU_PWM", /* GPIOE_1 */
> +		"TF_PWR_EN"; /* GPIOE_2 */
> +};
> +
> +&hdmi_tx {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-supply =3D <&dc_in>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint =3D <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&remote_input_ao_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&pwm_AO_cd {
> +	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
> +	pinctrl-names =3D "default";
> +	clocks =3D <&xtal>;
> +	clock-names =3D "clkin1";
> +	status =3D "okay";
> +};
> +
> +&saradc {
> +	status =3D "okay";
> +	vref-supply =3D <&vddao_1v8>;
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&sdcard_c_pins>;
> +	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	max-frequency =3D <50000000>;
> +	disable-wp;
> +
> +	/* TOFIX: SD card is barely usable in SDR modes */
> +
> +	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&tflash_vdd>;
> +	vqmmc-supply =3D <&vddio_c>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency =3D <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq =3D <&emmc_pwrseq>;
> +	vmmc-supply =3D <&vddao_3v3>;
> +	vqmmc-supply =3D <&emmc_1v8>;
> +};
> +
> +&tdmif_b {
> +	status =3D "okay";
> +};
> +
> +&tdmif_c {
> +	status =3D "okay";
> +};
> +
> +&tdmin_a {
> +	status =3D "okay";
> +};
> +
> +&tdmin_b {
> +	status =3D "okay";
> +};
> +
> +&tdmin_c {
> +	status =3D "okay";
> +};
> +
> +&tdmout_b {
> +	status =3D "okay";
> +};
> +
> +&tdmout_c {
> +	status =3D "okay";
> +};
> +
> +&toacodec {
> +	status =3D "okay";
> +};
> +
> +&tohdmitx {
> +	status =3D "okay";
> +};
> +
> +&toddr_a {
> +	status =3D "okay";
> +};
> +
> +&toddr_b {
> +	status =3D "okay";
> +};
> +
> +&toddr_c {
> +	status =3D "okay";
> +};
> +
> +&uart_AO {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&uart_ao_a_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&usb {
> +	status =3D "okay";
> +};
> +
> +&usb2_phy0 {
> +	phy-supply =3D <&dc_in>;
> +};
> +
> +&usb2_phy1 {
> +	/* Enable the hub which is connected to this port */
> +	phy-supply =3D <&vl_pwr_en>;
> +};
> diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l.dts b/arch/arm/dts/meson=
-sm1-khadas-vim3l.dts
> index 4b517ca720..f2c0981435 100644
> --- a/arch/arm/dts/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm/dts/meson-sm1-khadas-vim3l.dts
> @@ -32,6 +32,19 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	sound {
> +		model =3D "G12B-KHADAS-VIM3L";
> +		audio-routing =3D "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 13", "TDM_A Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT";
> +	};
>  };
> =20
>  &cpu0 {
> @@ -89,13 +102,12 @@
>  	status =3D "okay";
>  };
> =20
> -&sd_emmc_a {
> -	sd-uhs-sdr50;
> -};
> -
>  &usb {
>  	phys =3D <&usb2_phy0>, <&usb2_phy1>;
>  	phy-names =3D "usb2-phy0", "usb2-phy1";
>  };
>   */
> =20
> +&sd_emmc_a {
> +	sd-uhs-sdr50;
> +};
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4.dts b/arch/arm/dts/meson-sm=
1-odroid-c4.dts
> index cf5a98f0e4..8c30ce6368 100644
> --- a/arch/arm/dts/meson-sm1-odroid-c4.dts
> +++ b/arch/arm/dts/meson-sm1-odroid-c4.dts
> @@ -5,34 +5,12 @@
> =20
>  /dts-v1/;
> =20
> -#include "meson-sm1.dtsi"
> -#include <dt-bindings/gpio/meson-g12a-gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +#include "meson-sm1-odroid.dtsi"
> =20
>  / {
>  	compatible =3D "hardkernel,odroid-c4", "amlogic,sm1";
>  	model =3D "Hardkernel ODROID-C4";
> =20
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		ethernet0 =3D &ethmac;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type =3D "memory";
> -		reg =3D <0x0 0x0 0x0 0x40000000>;
> -	};
> -
> -	emmc_pwrseq: emmc-pwrseq {
> -		compatible =3D "mmc-pwrseq-emmc";
> -		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> -	};
> -
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> @@ -45,324 +23,19 @@
>  		};
>  	};
> =20
> -	tflash_vdd: regulator-tflash_vdd {
> -		compatible =3D "regulator-fixed";
> -
> -		regulator-name =3D "TFLASH_VDD";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -
> -		gpio =3D <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		regulator-always-on;
> -	};
> -
> -	tf_io: gpio-regulator-tf_io {
> -		compatible =3D "regulator-gpio";
> -
> -		regulator-name =3D "TF_IO";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <3300000>;
> -
> -		gpios =3D <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
> -		gpios-states =3D <0>;
> -
> -		states =3D <3300000 0>,
> -			 <1800000 1>;
> -	};
> -
> -	flash_1v8: regulator-flash_1v8 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "FLASH_1V8";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <1800000>;
> -		vin-supply =3D <&vcc_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	main_12v: regulator-main_12v {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "12V";
> -		regulator-min-microvolt =3D <12000000>;
> -		regulator-max-microvolt =3D <12000000>;
> -		regulator-always-on;
> -	};
> -
> -	vcc_5v: regulator-vcc_5v {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "5V";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		regulator-always-on;
> -		vin-supply =3D <&main_12v>;
> -	};
> -
> -	vcc_1v8: regulator-vcc_1v8 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "VCC_1V8";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <1800000>;
> -		vin-supply =3D <&vcc_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	vcc_3v3: regulator-vcc_3v3 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "VCC_3V3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -		vin-supply =3D <&vddao_3v3>;
> -		regulator-always-on;
> -		/* FIXME: actually controlled by VDDCPU_B_EN */
> -	};
> -
> -	vddcpu: regulator-vddcpu {
> -		/*
> -		 * MP8756GD Regulator.
> -		 */
> -		compatible =3D "pwm-regulator";
> -
> -		regulator-name =3D "VDDCPU";
> -		regulator-min-microvolt =3D <721000>;
> -		regulator-max-microvolt =3D <1022000>;
> -
> -		vin-supply =3D <&main_12v>;
> -
> -		pwms =3D <&pwm_AO_cd 1 1250 0>;
> -		pwm-dutycycle-range =3D <100 0>;
> -
> -		regulator-boot-on;
> -		regulator-always-on;
> -	};
> -
> -	hub_5v: regulator-hub_5v {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "HUB_5V";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&vcc_5v>;
> -
> -		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
> -		gpio =3D <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	usb_pwr_en: regulator-usb_pwr_en {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "USB_PWR_EN";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&vcc_5v>;
> -
> -		/* Connected to the microUSB port power enable */
> -		gpio =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	vddao_1v8: regulator-vddao_1v8 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "VDDAO_1V8";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <1800000>;
> -		vin-supply =3D <&vddao_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	vddao_3v3: regulator-vddao_3v3 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "VDDAO_3V3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -		vin-supply =3D <&main_12v>;
> -		regulator-always-on;
> -	};
> -
> -	hdmi-connector {
> -		compatible =3D "hdmi-connector";
> -		type =3D "a";
> -
> -		port {
> -			hdmi_connector_in: endpoint {
> -				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> -			};
> -		};
> -	};
> -
>  	sound {
> -		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "SM1-ODROID-C4";
> -		audio-aux-devs =3D <&tdmout_b>;
> -		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks =3D <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents =3D <0>, <0>, <0>;
> -		assigned-clock-rates =3D <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -		status =3D "okay";
> -
> -		dai-link-0 {
> -			sound-dai =3D <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai =3D <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai =3D <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai =3D <&tdmif_b>;
> -			dai-format =3D "i2s";
> -			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> -			dai-tdm-slot-tx-mask-1 =3D <1 1>;
> -			dai-tdm-slot-tx-mask-2 =3D <1 1>;
> -			dai-tdm-slot-tx-mask-3 =3D <1 1>;
> -			mclk-fs =3D <256>;
> -
> -			codec {
> -				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai =3D <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status =3D "okay";
> -};
> -
> -&clkc_audio {
> -	status =3D "okay";
> -};
> -
> -&cpu0 {
> -	cpu-supply =3D <&vddcpu>;
> -	operating-points-v2 =3D <&cpu_opp_table>;
> -	clocks =3D <&clkc CLKID_CPU_CLK>;
> -	clock-latency =3D <50000>;
> -};
> -
> -&cpu1 {
> -	cpu-supply =3D <&vddcpu>;
> -	operating-points-v2 =3D <&cpu_opp_table>;
> -	clocks =3D <&clkc CLKID_CPU1_CLK>;
> -	clock-latency =3D <50000>;
> -};
> -
> -&cpu2 {
> -	cpu-supply =3D <&vddcpu>;
> -	operating-points-v2 =3D <&cpu_opp_table>;
> -	clocks =3D <&clkc CLKID_CPU2_CLK>;
> -	clock-latency =3D <50000>;
> -};
> -
> -&cpu3 {
> -	cpu-supply =3D <&vddcpu>;
> -	operating-points-v2 =3D <&cpu_opp_table>;
> -	clocks =3D <&clkc CLKID_CPU3_CLK>;
> -	clock-latency =3D <50000>;
> -};
> -
> -&ext_mdio {
> -	external_phy: ethernet-phy@0 {
> -		/* Realtek RTL8211F (0x001cc916) */
> -		reg =3D <0>;
> -		max-speed =3D <1000>;
> -
> -		interrupt-parent =3D <&gpio_intc>;
> -		/* MAC_INTR on GPIOZ_14 */
> -		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> +		model =3D "ODROID-C4";
>  	};
>  };
> =20
> -&ethmac {
> -	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> -	pinctrl-names =3D "default";
> -	status =3D "okay";
> -	phy-mode =3D "rgmii";
> -	phy-handle =3D <&external_phy>;
> -	amlogic,tx-delay-ns =3D <2>;
> -};
> -
> -&frddr_a {
> -	status =3D "okay";
> -};
> -
> -&frddr_b {
> -	status =3D "okay";
> -};
> -
> -&frddr_c {
> -	status =3D "okay";
> -};
> -
>  &gpio {
> -	gpio-line-names =3D
> -		/* GPIOZ */
> -		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "", "", "",
> -		/* GPIOH */
> -		"", "", "", "", "",
> -		"PIN_36", /* GPIOH_5 */
> -		"PIN_26", /* GPIOH_6 */
> -		"PIN_32", /* GPIOH_7 */
> -		"",
> -		/* BOOT */
> -		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "", "", "",
> -		/* GPIOC */
> -		"", "", "", "", "", "", "", "",
> -		/* GPIOA */
> -		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "",
> -		"PIN_27", /* GPIOA_14 */
> -		"PIN_28", /* GPIOA_15 */
> -		/* GPIOX */
> -		"PIN_16", /* GPIOX_0 */
> -		"PIN_18", /* GPIOX_1 */
> -		"PIN_22", /* GPIOX_2 */
> -		"PIN_11", /* GPIOX_3 */
> -		"PIN_13", /* GPIOX_4 */
> -		"PIN_7",  /* GPIOX_5 */
> -		"PIN_33", /* GPIOX_6 */
> -		"PIN_15", /* GPIOX_7 */
> -		"PIN_19", /* GPIOX_8 */
> -		"PIN_21", /* GPIOX_9 */
> -		"PIN_24", /* GPIOX_10 */
> -		"PIN_23", /* GPIOX_11 */
> -		"PIN_8",  /* GPIOX_12 */
> -		"PIN_10", /* GPIOX_13 */
> -		"PIN_29", /* GPIOX_14 */
> -		"PIN_31", /* GPIOX_15 */
> -		"PIN_12", /* GPIOX_16 */
> -		"PIN_3",  /* GPIOX_17 */
> -		"PIN_5",  /* GPIOX_18 */
> -		"PIN_35"; /* GPIOX_19 */
> -
>  	/*
>  	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
>  	 * to be turned high in order to be detected by the USB Controller
>  	 * This signal should be handled by a USB specific power sequence
>  	 * in order to reset the Hub when USB bus is powered down.
>  	 */
> -	usb-hub {
> +	hog-0 {
>  		gpio-hog;
>  		gpios =3D <GPIOH_4 GPIO_ACTIVE_HIGH>;
>  		output-high;
> @@ -370,121 +43,6 @@
>  	};
>  };
> =20
> -&gpio_ao {
> -	gpio-line-names =3D
> -		/* GPIOAO */
> -		"", "", "", "",
> -		"PIN_47", /* GPIOAO_4 */
> -		"", "",
> -		"PIN_45", /* GPIOAO_7 */
> -		"PIN_46", /* GPIOAO_8 */
> -		"PIN_44", /* GPIOAO_9 */
> -		"PIN_42", /* GPIOAO_10 */
> -		"",
> -		/* GPIOE */
> -		"", "", "";
> -};
> -
> -&hdmi_tx {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> -	pinctrl-names =3D "default";
> -	hdmi-supply =3D <&vcc_5v>;
> -};
> -
> -&hdmi_tx_tmds_port {
> -	hdmi_tx_tmds_out: endpoint {
> -		remote-endpoint =3D <&hdmi_connector_in>;
> -	};
> -};
> -
>  &ir {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&remote_input_ao_pins>;
> -	pinctrl-names =3D "default";
>  	linux,rc-map-name =3D "rc-odroid";
>  };
> -
> -&pwm_AO_cd {
> -	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
> -	pinctrl-names =3D "default";
> -	clocks =3D <&xtal>;
> -	clock-names =3D "clkin1";
> -	status =3D "okay";
> -};
> -
> -&saradc {
> -	status =3D "okay";
> -};
> -
> -/* SD card */
> -&sd_emmc_b {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&sdcard_c_pins>;
> -	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
> -	pinctrl-names =3D "default", "clk-gate";
> -
> -	bus-width =3D <4>;
> -	cap-sd-highspeed;
> -	max-frequency =3D <200000000>;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-sdr104;
> -	disable-wp;
> -
> -	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> -	vmmc-supply =3D <&tflash_vdd>;
> -	vqmmc-supply =3D <&tf_io>;
> -};
> -
> -/* eMMC */
> -&sd_emmc_c {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> -	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> -	pinctrl-names =3D "default", "clk-gate";
> -
> -	bus-width =3D <8>;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	max-frequency =3D <200000000>;
> -	disable-wp;
> -
> -	mmc-pwrseq =3D <&emmc_pwrseq>;
> -	vmmc-supply =3D <&vcc_3v3>;
> -	vqmmc-supply =3D <&flash_1v8>;
> -};
> -
> -&tdmif_b {
> -	status =3D "okay";
> -};
> -
> -&tdmout_b {
> -	status =3D "okay";
> -};
> -
> -&tohdmitx {
> -	status =3D "okay";
> -};
> -
> -&uart_AO {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&uart_ao_a_pins>;
> -	pinctrl-names =3D "default";
> -};
> -
> -&usb {
> -	status =3D "okay";
> -	vbus-supply =3D <&usb_pwr_en>;
> -};
> -
> -&usb2_phy0 {
> -	phy-supply =3D <&vcc_5v>;
> -};
> -
> -&usb2_phy1 {
> -	/* Enable the hub which is connected to this port */
> -	phy-supply =3D <&hub_5v>;
> -};
> diff --git a/arch/arm/dts/meson-sm1-odroid-hc4.dts b/arch/arm/dts/meson-s=
m1-odroid-hc4.dts
> new file mode 100644
> index 0000000000..f3f953225b
> --- /dev/null
> +++ b/arch/arm/dts/meson-sm1-odroid-hc4.dts
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Dongjin Kim <tobetter@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1-odroid.dtsi"
> +
> +/ {
> +	compatible =3D "hardkernel,odroid-hc4", "amlogic,sm1";
> +	model =3D "Hardkernel ODROID-HC4";
> +
> +	aliases {
> +		rtc0 =3D &rtc;
> +		rtc1 =3D &vrtc;
> +	};
> +
> +	fan0: pwm-fan {
> +		compatible =3D "pwm-fan";
> +		#cooling-cells =3D <2>;
> +		cooling-min-state =3D <0>;
> +		cooling-max-state =3D <3>;
> +		cooling-levels =3D <0 120 170 220>;
> +		pwms =3D <&pwm_cd 1 40000 0>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-blue {
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +			panic-indicator;
> +		};
> +
> +		led-red {
> +			color =3D <LED_COLOR_ID_RED>;
> +			function =3D LED_FUNCTION_POWER;
> +			gpios =3D <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
> +			default-state =3D "on";
> +		};
> +	};
> +
> +	/* Powers the SATA Disk 0 regulator, which is enabled when a disk load =
is detected */
> +	p12v_0: regulator-p12v_0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "P12V_0";
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-max-microvolt =3D <12000000>;
> +		vin-supply =3D <&main_12v>;
> +
> +		gpio =3D <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	/* Powers the SATA Disk 1 regulator, which is enabled when a disk load =
is detected */
> +	p12v_1: regulator-p12v_1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "P12V_1";
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-max-microvolt =3D <12000000>;
> +		vin-supply =3D <&main_12v>;
> +
> +		gpio =3D <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		model =3D "ODROID-HC4";
> +	};
> +};
> +
> +&cpu_thermal {
> +	cooling-maps {
> +		map {
> +			trip =3D <&cpu_passive>;
> +			cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
> +&ir {
> +	linux,rc-map-name =3D "rc-odroid";
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
> +	pinctrl-names =3D "default";
> +
> +	rtc: rtc@51 {
> +		status =3D "okay";
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		wakeup-source;
> +	};
> +};
> +
> +&pcie {
> +	status =3D "okay";
> +	reset-gpios =3D <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pwm_cd {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm_d_x6_pins>;
> +};
> +
> +&sd_emmc_c {
> +	status =3D "disabled";
> +};
> +
> +&spifc {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&nor_pins>;
> +	pinctrl-names =3D "default";
> +
> +	spi-flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <104000000>;
> +	};
> +};
> +
> +&usb {
> +	phys =3D <&usb2_phy1>;
> +	phy-names =3D "usb2-phy1";
> +};
> +
> +&usb2_phy0 {
> +	status =3D "disabled";
> +};
> diff --git a/arch/arm/dts/meson-sm1-odroid.dtsi b/arch/arm/dts/meson-sm1-=
odroid.dtsi
> new file mode 100644
> index 0000000000..fd0ad85c16
> --- /dev/null
> +++ b/arch/arm/dts/meson-sm1-odroid.dtsi
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Dongjin Kim <tobetter@gmail.com>
> + */
> +
> +#include "meson-sm1.dtsi"
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		ethernet0 =3D &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible =3D "mmc-pwrseq-emmc";
> +		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	tflash_vdd: regulator-tflash_vdd {
> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "TFLASH_VDD";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpio =3D <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	tf_io: gpio-regulator-tf_io {
> +		compatible =3D "regulator-gpio";
> +
> +		regulator-name =3D "TF_IO";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&vcc_5v>;
> +
> +		enable-gpio =3D <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +
> +		gpios =3D <&gpio_ao GPIOAO_6 GPIO_OPEN_SOURCE>;
> +		gpios-states =3D <0>;
> +
> +		states =3D <3300000 0>,
> +			 <1800000 1>;
> +	};
> +
> +	flash_1v8: regulator-flash_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "FLASH_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	main_12v: regulator-main_12v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "12V";
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-max-microvolt =3D <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_5v: regulator-vcc_5v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "5V";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +		vin-supply =3D <&main_12v>;
> +		gpio =3D <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +	};
> +
> +	vcc_1v8: regulator-vcc_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VCC_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VCC_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +		/* FIXME: actually controlled by VDDCPU_B_EN */
> +	};
> +
> +	vddcpu: regulator-vddcpu {
> +		/*
> +		 * MP8756GD Regulator.
> +		 */
> +		compatible =3D "pwm-regulator";
> +
> +		regulator-name =3D "VDDCPU";
> +		regulator-min-microvolt =3D <721000>;
> +		regulator-max-microvolt =3D <1022000>;
> +
> +		vin-supply =3D <&main_12v>;
> +
> +		pwms =3D <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range =3D <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	usb_pwr_en: regulator-usb_pwr_en {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "USB_PWR_EN";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		vin-supply =3D <&vcc_5v>;
> +
> +		/* Connected to the microUSB port power enable */
> +		gpio =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vddao_1v8: regulator-vddao_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&main_12v>;
> +		regulator-always-on;
> +	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible =3D "amlogic,axg-sound-card";
> +		audio-aux-devs =3D <&tdmout_b>;
> +		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks =3D <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status =3D "okay";
> +
> +		dai-link-0 {
> +			sound-dai =3D <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai =3D <&tdmif_b>;
> +			dai-format =3D "i2s";
> +			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-1 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-2 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-3 =3D <1 1>;
> +			mclk-fs =3D <256>;
> +
> +			codec {
> +				sound-dai =3D <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&arb {
> +	status =3D "okay";
> +};
> +
> +&clkc_audio {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU1_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu2 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU2_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu3 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU3_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg =3D <0>;
> +		max-speed =3D <1000>;
> +
> +		interrupt-parent =3D <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&external_phy>;
> +	amlogic,tx-delay-ns =3D <2>;
> +};
> +
> +&frddr_a {
> +	status =3D "okay";
> +};
> +
> +&frddr_b {
> +	status =3D "okay";
> +};
> +
> +&frddr_c {
> +	status =3D "okay";
> +};
> +
> +&gpio {
> +	gpio-line-names =3D
> +		/* GPIOZ */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOH */
> +		"", "", "", "", "",
> +		"PIN_36", /* GPIOH_5 */
> +		"PIN_26", /* GPIOH_6 */
> +		"PIN_32", /* GPIOH_7 */
> +		"",
> +		/* BOOT */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOC */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOA */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "",
> +		"PIN_27", /* GPIOA_14 */
> +		"PIN_28", /* GPIOA_15 */
> +		/* GPIOX */
> +		"PIN_16", /* GPIOX_0 */
> +		"PIN_18", /* GPIOX_1 */
> +		"PIN_22", /* GPIOX_2 */
> +		"PIN_11", /* GPIOX_3 */
> +		"PIN_13", /* GPIOX_4 */
> +		"PIN_7",  /* GPIOX_5 */
> +		"PIN_33", /* GPIOX_6 */
> +		"PIN_15", /* GPIOX_7 */
> +		"PIN_19", /* GPIOX_8 */
> +		"PIN_21", /* GPIOX_9 */
> +		"PIN_24", /* GPIOX_10 */
> +		"PIN_23", /* GPIOX_11 */
> +		"PIN_8",  /* GPIOX_12 */
> +		"PIN_10", /* GPIOX_13 */
> +		"PIN_29", /* GPIOX_14 */
> +		"PIN_31", /* GPIOX_15 */
> +		"PIN_12", /* GPIOX_16 */
> +		"PIN_3",  /* GPIOX_17 */
> +		"PIN_5",  /* GPIOX_18 */
> +		"PIN_35"; /* GPIOX_19 */
> +};
> +
> +&gpio_ao {
> +	gpio-line-names =3D
> +		/* GPIOAO */
> +		"", "", "", "",
> +		"PIN_47", /* GPIOAO_4 */
> +		"", "",
> +		"PIN_45", /* GPIOAO_7 */
> +		"PIN_46", /* GPIOAO_8 */
> +		"PIN_44", /* GPIOAO_9 */
> +		"PIN_42", /* GPIOAO_10 */
> +		"",
> +		/* GPIOE */
> +		"", "", "";
> +};
> +
> +&hdmi_tx {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-supply =3D <&vcc_5v>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint =3D <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&remote_input_ao_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&pwm_AO_cd {
> +	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
> +	pinctrl-names =3D "default";
> +	clocks =3D <&xtal>;
> +	clock-names =3D "clkin1";
> +	status =3D "okay";
> +};
> +
> +&saradc {
> +	status =3D "okay";
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&sdcard_c_pins>;
> +	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	max-frequency =3D <200000000>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	disable-wp;
> +
> +	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&tflash_vdd>;
> +	vqmmc-supply =3D <&tf_io>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency =3D <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq =3D <&emmc_pwrseq>;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&flash_1v8>;
> +};
> +
> +&tdmif_b {
> +	status =3D "okay";
> +};
> +
> +&tdmout_b {
> +	status =3D "okay";
> +};
> +
> +&tohdmitx {
> +	status =3D "okay";
> +};
> +
> +&uart_AO {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&uart_ao_a_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&usb {
> +	status =3D "okay";
> +	vbus-supply =3D <&usb_pwr_en>;
> +};
> +
> +&usb2_phy0 {
> +	phy-supply =3D <&vcc_5v>;
> +};
> +
> diff --git a/arch/arm/dts/meson-sm1-sei610.dts b/arch/arm/dts/meson-sm1-s=
ei610.dts
> index 5ab139a34c..2194a77897 100644
> --- a/arch/arm/dts/meson-sm1-sei610.dts
> +++ b/arch/arm/dts/meson-sm1-sei610.dts
> @@ -101,20 +101,20 @@
>  		};
>  	};
> =20
> -	leds {
> +	led-controller-1 {
>  		compatible =3D "gpio-leds";
> =20
> -		led-bluetooth {
> +		led-1 {
>  			label =3D "sei610:blue:bt";
>  			gpios =3D <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>  			default-state =3D "off";
>  		};
>  	};
> =20
> -	pwmleds {
> +	led-controller-2 {
>  		compatible =3D "pwm-leds";
> =20
> -		power {
> +		led-2 {
>  			label =3D "sei610:red:power";
>  			pwms =3D <&pwm_AO_ab 0 30518 0>;
>  			max-brightness =3D <255>;
> @@ -220,7 +220,7 @@
> =20
>  	sound {
>  		compatible =3D "amlogic,axg-sound-card";
> -		model =3D "SM1-SEI610";
> +		model =3D "SEI610";
>  		audio-aux-devs =3D <&tdmout_a>, <&tdmout_b>,
>  				 <&tdmin_a>, <&tdmin_b>;
>  		audio-routing =3D "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> diff --git a/arch/arm/dts/meson-sm1.dtsi b/arch/arm/dts/meson-sm1.dtsi
> index 71317f5aad..3d8b1f4f20 100644
> --- a/arch/arm/dts/meson-sm1.dtsi
> +++ b/arch/arm/dts/meson-sm1.dtsi
> @@ -130,7 +130,7 @@
>  			opp-microvolt =3D <790000>;
>  		};
> =20
> -		opp-1512000000 {
> +		opp-1500000000 {
>  			opp-hz =3D /bits/ 64 <1500000000>;
>  			opp-microvolt =3D <800000>;
>  		};
> @@ -401,6 +401,16 @@
>  			status =3D "disabled";
>  		};
> =20
> +		toacodec: audio-controller@740 {
> +			compatible =3D "amlogic,sm1-toacodec",
> +				     "amlogic,g12a-toacodec";
> +			reg =3D <0x0 0x740 0x0 0x4>;
> +			#sound-dai-cells =3D <1>;
> +			sound-name-prefix =3D "TOACODEC";
> +			resets =3D <&clkc_audio AUD_RESET_TOACODEC>;
> +			status =3D "disabled";
> +		};
> +
>  		tohdmitx: audio-controller@744 {
>  			compatible =3D "amlogic,sm1-tohdmitx",
>  				     "amlogic,g12a-tohdmitx";
> diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/c=
lock/axg-clkc.h
> index fd1f938c38..93752ea107 100644
> --- a/include/dt-bindings/clock/axg-clkc.h
> +++ b/include/dt-bindings/clock/axg-clkc.h
> @@ -70,7 +70,31 @@
>  #define CLKID_HIFI_PLL				69
>  #define CLKID_PCIE_CML_EN0			79
>  #define CLKID_PCIE_CML_EN1			80
> -#define CLKID_MIPI_ENABLE			81
>  #define CLKID_GEN_CLK				84
> +#define CLKID_VPU_0_SEL				92
> +#define CLKID_VPU_0				93
> +#define CLKID_VPU_1_SEL				95
> +#define CLKID_VPU_1				96
> +#define CLKID_VPU				97
> +#define CLKID_VAPB_0_SEL			99
> +#define CLKID_VAPB_0				100
> +#define CLKID_VAPB_1_SEL			102
> +#define CLKID_VAPB_1				103
> +#define CLKID_VAPB_SEL				104
> +#define CLKID_VAPB				105
> +#define CLKID_VCLK				106
> +#define CLKID_VCLK2				107
> +#define CLKID_VCLK_DIV1				122
> +#define CLKID_VCLK_DIV2				123
> +#define CLKID_VCLK_DIV4				124
> +#define CLKID_VCLK_DIV6				125
> +#define CLKID_VCLK_DIV12			126
> +#define CLKID_VCLK2_DIV1			127
> +#define CLKID_VCLK2_DIV2			128
> +#define CLKID_VCLK2_DIV4			129
> +#define CLKID_VCLK2_DIV6			130
> +#define CLKID_VCLK2_DIV12			131
> +#define CLKID_CTS_ENCL				133
> +#define CLKID_VDIN_MEAS				136
> =20
>  #endif /* __AXG_CLKC_H */
> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/=
clock/g12a-clkc.h
> index 40d49940d8..a93b58c5e1 100644
> --- a/include/dt-bindings/clock/g12a-clkc.h
> +++ b/include/dt-bindings/clock/g12a-clkc.h
> @@ -147,5 +147,7 @@
>  #define CLKID_SPICC1_SCLK			261
>  #define CLKID_NNA_AXI_CLK			264
>  #define CLKID_NNA_CORE_CLK			267
> +#define CLKID_MIPI_DSI_PXCLK_SEL		269
> +#define CLKID_MIPI_DSI_PXCLK			270
> =20
>  #endif /* __G12A_CLKC_H */
> --=20
> 2.25.1
>=20

--=20
Tom

--fQa200R4EO7jAQ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmE42rUACgkQFHw5/5Y0
tyzh0Qv+JbVMz3UTl2oeBlxG01s6xMBKN6o8JCWYsIKSaFAOKkGIz0JUuRoFVadl
FG/R+4Bpaw8L36tfa0yL/Wm6PdbXNxCFhRxaT6GySwnrvNm3aAzhsfX62NiXAZVy
EML4dZgVT2keRX/8Mrq9ED7/YexYiwT1dd1sH/yZwE0qJz5fDJXHByUd3rEbkRDX
EI5PoVENFQusNz0UoWYUo+hZ56NFAg0FOE/GAc/CMtuLaiEBKqI0LJ5eeigCBe+L
FFSPUPPhxFWO7zHaipr9XxOQrqrH2ivBtihxnWZ8xtHRoN5qWtKVH+PmbhOojyI1
RX8gC3KLIHKKQp7nlYnP2zbGyzBXFGkbuRrMWK1hB2QTrqf0WGUdo0uGLXI27aF8
L9JqJuqXSjxfK3CGRV3AXZgkM/3HVx4s2aiQ4aPWoSIVS0+GgleQxgV/rrj2ItUU
rGrnN8sQZT5q4ZBRJ6HafYVTgYK2oDoIZ7ziZR8PepjDgy19Nc9XQBTGgDO4+1OF
AB/PE5US
=sIUB
-----END PGP SIGNATURE-----

--fQa200R4EO7jAQ6Z--
