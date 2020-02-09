Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.6773.1581253130337679230
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 04:58:50 -0800
Received: by mail-wm1-f46.google.com with SMTP id c84so7513116wme.4
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 04:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=moGki1DmaKSrz1UekvuDWMFYz7ot78W+WAdWZGi8OOE=;
        b=bma8dzI30rCQ6sojCq8l98K4espjS+HBeSAt8ojKtRu+x8P6ZJnjGVxFmhZNz0acrz
         PysaigJvdqhgtEcWvyr60vzITUFOKIxoerVqa6iuFIRGVXG34O7YJYrm+k4njlvoJjly
         izs6gnQFK7eWgF73zUflRnQxYIBxmVRtNFdtVJYGBZ4KP0KOcXtGBrGwAkmUf1QoEhAq
         4Nk0wZyWOjbzF5LYEEACVARClnRXG+SUsrmkxNlk3znNyjT+837IMK2kbFjvxFEk6oVl
         UKo/4csOZNSNLNicnn68VVbfOrOR5EZLQJRmqCKLfbBvxZPtGJnhd4XWXar0m/aSD+Ht
         G1Og==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 4/5] arm: dts: g12: Move common nodes to the -u-boot.dtsi
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-5-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9056c007-eb79-d031-ac41-02d8f6ef09f2@baylibre.com>
Date: Sun, 9 Feb 2020 13:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200209110557.1996-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 09/02/2020 =E0 12:05, Anand Moon a =E9crit :
> Move u-boot specific common nodes in the dts files to
> meson-g12-common-u-boot.dtsi. This allows us to keep the basic
> dts[i] files up-to-date with the ones in kernel,
> but at the same time allowing the u-boot to add its own
> properties to the existing nodes.
> Also add missing mmc alias to dts nodes to avoid
> below debug warning.
>=20
> mmc_bind: alias ret=3D-2, devnum=3D-1
> mmc_bind: alias ret=3D-2, devnum=3D-1

Same as patch 4.

Neil

>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> No changes from previous patch
> ---
>  arch/arm/dts/meson-g12-common-u-boot.dtsi | 12 ++++++++++++
>  arch/arm/dts/meson-g12a-sei510.dts        |  9 ---------
>  arch/arm/dts/meson-g12a-u200.dts          |  9 ---------
>  arch/arm/dts/meson-g12b-odroid-n2.dts     |  9 ---------
>  arch/arm/dts/meson-khadas-vim3.dtsi       |  9 ---------
>  arch/arm/dts/meson-sm1-sei610.dts         |  9 ---------
>  6 files changed, 12 insertions(+), 45 deletions(-)
>=20
> diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/mes=
on-g12-common-u-boot.dtsi
> index 38fd3d3feb..347b8ded22 100644
> --- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
> +++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
> @@ -8,6 +8,18 @@
>  	soc {
>  		u-boot,dm-pre-reloc;
>  	};
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		ethernet0 =3D &ethmac;
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
>  &canvas {
> diff --git a/arch/arm/dts/meson-g12a-sei510.dts b/arch/arm/dts/meson-g12a=
-sei510.dts
> index c7a8736885..c6a48ebbe5 100644
> --- a/arch/arm/dts/meson-g12a-sei510.dts
> +++ b/arch/arm/dts/meson-g12a-sei510.dts
> @@ -28,11 +28,6 @@
>  		};
>  	};
> =20
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		ethernet0 =3D &ethmac;
> -	};
> -
>  	mono_dac: audio-codec-0 {
>  		compatible =3D "maxim,max98357a";
>  		#sound-dai-cells =3D <0>;
> @@ -49,10 +44,6 @@
>  		sound-name-prefix =3D "MIC";
>  	};
> =20
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	cvbs-connector {
>  		compatible =3D "composite-video-connector";
> =20
> diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a-u=
200.dts
> index 8551fbd4a4..8be7b6985b 100644
> --- a/arch/arm/dts/meson-g12a-u200.dts
> +++ b/arch/arm/dts/meson-g12a-u200.dts
> @@ -13,15 +13,6 @@
>  	compatible =3D "amlogic,u200", "amlogic,g12a";
>  	model =3D "Amlogic Meson G12A U200 Development Board";
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
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson-g=
12b-odroid-n2.dts
> index 42f1540575..a37f66a5e0 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2.dts
> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
> @@ -15,15 +15,6 @@
>  	compatible =3D "hardkernel,odroid-n2", "amlogic,g12b";
>  	model =3D "Hardkernel ODROID-N2";
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
>  		reg =3D <0x0 0x0 0x0 0x40000000>;
> diff --git a/arch/arm/dts/meson-khadas-vim3.dtsi b/arch/arm/dts/meson-kha=
das-vim3.dtsi
> index 8647da7d66..c6b0ce9a88 100644
> --- a/arch/arm/dts/meson-khadas-vim3.dtsi
> +++ b/arch/arm/dts/meson-khadas-vim3.dtsi
> @@ -11,15 +11,6 @@
>  / {
>  	model =3D "Khadas VIM3";
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
> diff --git a/arch/arm/dts/meson-sm1-sei610.dts b/arch/arm/dts/meson-sm1-s=
ei610.dts
> index 3435aaa4e8..4372708811 100644
> --- a/arch/arm/dts/meson-sm1-sei610.dts
> +++ b/arch/arm/dts/meson-sm1-sei610.dts
> @@ -14,15 +14,6 @@
>  	compatible =3D "seirobotics,sei610", "amlogic,sm1";
>  	model =3D "SEI Robotics SEI610";
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
>  	emmc_pwrseq: emmc-pwrseq {
>  		compatible =3D "mmc-pwrseq-emmc";
>  		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
>=20
