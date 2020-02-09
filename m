Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.6979.1581253099020018906
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 04:58:19 -0800
Received: by mail-wr1-f66.google.com with SMTP id z3so4205001wru.3
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=9I759yEvJHLfz9+OCiaNoxYORVtgNegwW0VuS/ZOndY=;
        b=1jilugWJlQ/4mWuGOYdxztd3P7UvYNVh+WnLgQIxeHB8WAWLbOuTHp+nM4RWEhgu3F
         QdZ9yUB/nNgDURazojtI5vF+2nYFfbH78iCFFIPexAKL/qWXUE4JDOTzGG1wGeCwzMsy
         Xsc/K9j4FiormxgARmPrk+5dyNyv5Gu9iY6J7qSb4Kz7QS5x/0LkpXsx1XEFkyqQly3p
         NMaZMJA20HePtKF6WUcvnyekjAieaiZIiCR7y0XBmWl6mm9+GX9T8hsyLTO2dxSEOlPl
         TsHsvfVy0AEO7X5JOOpADGviFhcPwG07jiLeUI1p2n58j/eD3+E2QMYk/AT2qVmOY1pd
         ZU/w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 3/5] arm: dts: gx: Move common nodes to the -u-boot.dtsi
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-4-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3a8d18d5-f253-8a15-9e5c-34f31bec6925@baylibre.com>
Date: Sun, 9 Feb 2020 13:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <20200209110557.1996-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 09/02/2020 =E0 12:05, Anand Moon a =E9crit :
> Move u-boot specific common nodes in the dts files to
> meson-gx-u-boot.dtsi. This allows us to keep the basic
> dts[i] files up-to-date with the ones in kernel,
> but at the same time allowing the u-boot to add its own
> properties to the existing nodes.
> Also add missing mmc alias to dts nodes to avoid
> below debug warning.
>=20
> mmc_bind: alias ret=3D-2, devnum=3D-1
> mmc_bind: alias ret=3D-2, devnum=3D-1

The mmc aliases are u-boot specific, so only those should be
moved into the meson-gx-u-boot.dtsi.

Please keep the other aliases in the their linux sync'ed files.

Neil

>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> no changes from previous
> ---
>  arch/arm/dts/meson-gx-u-boot.dtsi             | 15 +++++++++++++++
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  9 ---------
>  arch/arm/dts/meson-gxbb-odroidc2.dts          |  9 ---------
>  arch/arm/dts/meson-gxbb-p20x.dtsi             |  9 ---------
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ----------
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 -----
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---------
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ----------
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ----------
>  9 files changed, 15 insertions(+), 71 deletions(-)
>=20
> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-=
boot.dtsi
> index b84e5edba4..13be3a7b8f 100644
> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> @@ -8,6 +8,21 @@
>  	soc {
>  		u-boot,dm-pre-reloc;
>  	};
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		serial1 =3D &uart_A;
> +		serial2 =3D &uart_AO_B;
> +		ethernet0 =3D &ethmac;
> +		spi0 =3D &spifc;
> +		mmc0 =3D &sd_emmc_a;
> +		mmc1 =3D &sd_emmc_b;
> +		mmc2 =3D &sd_emmc_c;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
>  };
> =20
>  &vpu {
> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-g=
xbb-nanopi-k2.dts
> index cbe99bd4e0..11690d6c46 100644
> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> @@ -11,15 +11,6 @@
>  / {
>  	compatible =3D "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
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
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x80000000>;
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gx=
bb-odroidc2.dts
> index 54954b314a..f8cd76a2ef 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
> @@ -14,15 +14,6 @@
>  	compatible =3D "hardkernel,odroid-c2", "amlogic,meson-gxbb";
>  	model =3D "Hardkernel ODROID-C2";
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
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x80000000>;
> diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxbb-=
p20x.dtsi
> index 0be0f2a5d2..c9822e50f9 100644
> --- a/arch/arm/dts/meson-gxbb-p20x.dtsi
> +++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
> @@ -8,15 +8,6 @@
>  #include "meson-gxbb.dtsi"
> =20
>  / {
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		ethernet0 =3D &ethmac;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x40000000>;
> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts=
/meson-gxl-s805x-libretech-ac.dts
> index 82b1c48511..4f9072a83e 100644
> --- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> @@ -16,16 +16,6 @@
>  		     "amlogic,meson-gxl";
>  	model =3D "Libre Computer Board AML-S805X-AC";
> =20
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		ethernet0 =3D &ethmac;
> -		spi0 =3D &spifc;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	cvbs-connector {
>  		/*
>  		 * The pads are present but no connector is soldered on
> diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts/m=
eson-gxl-s905x-khadas-vim.dts
> index ceb34afe42..072e4575d2 100644
> --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> @@ -26,11 +26,6 @@
>  		};
>  	};
> =20
> -	aliases {
> -		serial2 =3D &uart_AO_B;
> -		ethernet0 =3D &ethmac;
> -	};
> -
>  	gpio-keys-polled {
>  		compatible =3D "gpio-keys-polled";
>  		#address-cells =3D <1>;
> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/dts=
/meson-gxl-s905x-libretech-cc.dts
> index a23252efc6..8d3965ab42 100644
> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> @@ -15,15 +15,6 @@
>  	compatible =3D "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
>  	model =3D "Libre Computer Board AML-S905X-CC";
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
>  	cvbs-connector {
>  		compatible =3D "composite-video-connector";
> =20
> diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meson-=
gxl-s905x-p212.dtsi
> index a1b31013ab..70f437fc3a 100644
> --- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
> @@ -13,16 +13,6 @@
>  #include "meson-gxl-s905x.dtsi"
> =20
>  / {
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		serial1 =3D &uart_A;
> -		ethernet0 =3D &ethmac;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x80000000>;
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-=
gxm-khadas-vim2.dts
> index 782e9edac8..4e68e289d3 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> @@ -16,16 +16,6 @@
>  	compatible =3D "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
>  	model =3D "Khadas VIM2";
> =20
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		serial1 =3D &uart_A;
> -		serial2 =3D &uart_AO_B;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x80000000>;
>=20
