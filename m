Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.21607.1679246100534874241
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:15:00 -0700
Received: by mail-wr1-f48.google.com with SMTP id l12so8366672wrm.10
        for <u-boot-amlogic@groups.io>; Sun, 19 Mar 2023 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679246099;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXN2GmPpvgj1yQBcQsXCZxG/FJseE2gV8AnI1TQ3kXQ=;
        b=lpNxBceSWaU1WX1OqDpw80XbtipOeXjbCXY6n4c77ckLjvjahZPIjcGOPurG7BuS+M
         3Qyp5SwFzsXiEwyZ0BoMHGSWkjeNZQwgDaZBaj/Y/NHJb6/7VwsWlGWbxuCT7lOjw1b8
         MRSGgeQdMOSZsPRko7IGisj873fny5gWu4a7avpAh1ouwtRWDqIWe852WS/Hq5HGJc7y
         9aVg66re+QgVQsDyEePJ9dPgTIT7LOcDZXzQLG1SJM1NHqqmbr92ooj0jNGqGMNEqR/6
         R3PJPdHY4Xghm3+6UCFndDohLR1P1TORZrXJUjoXdMVS+D54dS6txFvUrmeat40Hxfy5
         gGTg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH 1/1] ARM: meson: Add initial support for beelink gt1
Date: Sun, 19 Mar 2023 21:14:55 +0400
References: <jgjE.1679121338252818194.cXld@groups.io>
In-Reply-To: <jgjE.1679121338252818194.cXld@groups.io>
Message-Id: <2FCFD5F6-2C5C-4687-8DF8-E2BE0658A3DA@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, exxxxkc@getgoogleoff.me
List-ID: <u-boot-amlogic@groups.io>


> On 18 Mar 2023, at 10:35 am, exxxxkc@getgoogleoff.me wrote:
>=20
> Add initial support for beelink gt1

^ This describes the change and is fine.

> This is used in pm os btw.

^ This does not described the change; comments should be placed below
the --- marks of the patch, not in the commit message.

> https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-b=
oot-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch
>=20
> Signed-off-by:  exkc <exxxxkc@getgoogleoff.me>

^ You need to provide a real name here, not a nickname.

> ---
> .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
> arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
> configs/gt1_ultimate_defconfig                | 85 +++++++++++++++++
> 3 files changed, 183 insertions(+)
> create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
> create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
> create mode 100644 configs/gt1_ultimate_defconfig
>=20
> diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi b/arch/arm/d=
ts/meson-gxm-gt1-ultimate-u-boot.dtsi
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
> diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts b/arch/arm/dts/meson=
-gxm-gt1-ultimate.dts
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
> +	compatible =3D "azw,gt1-ultimate", "amlogic,s912", "amlogic,meson-gxm";
> +	model =3D "Beelink GT1 Ultimate";
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-white {
> +			color =3D <LED_COLOR_ID_WHITE>;
> +			function =3D LED_FUNCTION_POWER;
> +			gpios =3D <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> +			default-state =3D "on";
> +			panic-indicator;
> +		};
> +	};
> +
> +	adc-keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D <&saradc 0>;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D <1710000>;
> +
> +		button-function {
> +			label =3D "update";
> +			linux,code =3D <KEY_VENDOR>;
> +			press-threshold-microvolt =3D <10000>;
> +		};
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 =3D <&eth_pins>;
> +	pinctrl-names =3D "default";
> +	phy-handle =3D <&external_phy>;
> +	amlogic,tx-delay-ns =3D <2>;
> +	phy-mode =3D "rgmii";
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg =3D <0>;
> +		max-speed =3D <1000>;
> +
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <80000>;
> +		reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +
> +		interrupt-parent =3D <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_15 */
> +		interrupts =3D <25 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ir {
> +	linux,rc-map-name =3D "rc-beelink-gs1";
> +};
> +
> +&sd_emmc_a {
> +	brcmf: wifi@1 {
> +		reg =3D <1>;
> +		compatible =3D "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&uart_A {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names =3D "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible =3D "brcm,bcm43438-bt";
> +		shutdown-gpios =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		max-speed =3D <2000000>;
> +		clocks =3D <&wifi32k>;
> +		clock-names =3D "lpo";
> +	};
> +};
> diff --git a/configs/beelink_gt1_ultimate_defconfig b/configs/beelink_gt1=
_ultimate_defconfig
> new file mode 100644
> index 0000000000..b5ed30fab4
> --- /dev/null
> +++ b/configs/beelink_gt1_ultimate_defconfig
> @@ -0,0 +1,85 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> +CONFIG_ENV_SIZE=3D0x10000
> +CONFIG_ENV_OFFSET=3D0xFFFF0000
> +CONFIG_ENV_SECT_SIZE=3D0x10000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxm-gt1-ultimate"
> +CONFIG_DM_RESET=3Dy
> +CONFIG_MESON_GXM=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" gt1-ultimate"
> +CONFIG_SYS_LOAD_ADDR=3D0x1000000
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_USE_PREBOOT=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=3Dy
> +CONFIG_SYS_MAXARGS=3D32
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_SF_TEST=3Dy
> +CONFIG_CMD_SPI=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_USB_MASS_STORAGE=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> +CONFIG_SARADC_MESON=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_SPI_FLASH=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_MDIO_MUX=3Dy
> +CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
> +CONFIG_MDIO_MUX_MMIOREG=3Dy
> +CONFIG_MESON_GXL_USB_PHY=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXL=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_MESON_EE_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MESON_SPIFC=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
> +CONFIG_USB_DWC3=3Dy
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_MESON_GXL=3Dy
> +CONFIG_USB_KEYBOARD=3Dy
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
> +CONFIG_USB_GADGET_DWC2_OTG=3Dy
> +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> +CONFIG_VIDEO=3Dy
> +CONFIG_SYS_WHITE_ON_BLACK=3Dy
> +CONFIG_VIDEO_MESON=3Dy
> +CONFIG_VIDEO_DT_SIMPLEFB=3Dy
> +CONFIG_SPLASH_SCREEN=3Dy
> +CONFIG_SPLASH_SCREEN_ALIGN=3Dy
> +CONFIG_VIDEO_BMP_RLE8=3Dy
> +CONFIG_BMP_16BPP=3Dy
> +CONFIG_BMP_24BPP=3Dy
> +CONFIG_BMP_32BPP=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy

^ defconfig should be submitted in a separate patch from the dts
files. Please have a look at the config that I created for this
board last summer (after I got the FIP sources from Beelink and
extracted/shared them):

https://github.com/chewitt/u-boot/commits/amlogic-2022.10

It doesn=E2=80=99t enable things like SPIFC (which the board doesn=E2=80=99=
t have)
and uses a more minimal environment size (no need for larger). You
will also find a patch for board documentation in that repo that
could be included with a v2 submission.

Christian

