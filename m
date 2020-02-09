Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.6895.1581253144290887379
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 04:59:04 -0800
Received: by mail-wm1-f68.google.com with SMTP id g1so6948953wmh.4
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=CcWp3vAIwyTRGOql2V/MpTwXEUMpYdcOiWhJgbE8Hig=;
        b=Uq2mrMJJrB1az1CHXUano6vYzGUgqsp1tCFB5DoW3KQNkUAcIw7gEUAIR+Hl8kBK9J
         6Zj+g+lY3MODE97+FWtxWfNDy+Mtku1fz+JFM+u/9weSxu6YyjffI1RAfh1TX07CSmUm
         z6d+2XyUNDrsZlBNBH0RctYCYNMmEIKFsurEhUdFA49Vl/ManjHET4d/Rn3wXUXXLKR+
         BWbtkKollmkB00+nUFo0UWV5+UV9UWNziPBEleoQTzk7MRE62FnSt2iFLK7+OsNeMcYb
         09eVfHU+HfnrU+NmhmeqTMMBHnqxw+Buig2kEMA/wyhwiWnVU20zrawSnu3YzTlTn+Uy
         e2AQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 5/5] arm: dts: s400: Move common nodes to the -u-boot.dtsi
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-6-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b5b4e697-34e7-d99c-5196-179c0ae83fc8@baylibre.com>
Date: Sun, 9 Feb 2020 13:58:59 +0100
MIME-Version: 1.0
In-Reply-To: <20200209110557.1996-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 09/02/2020 =E0 12:05, Anand Moon a =E9crit :
> Move u-boot specific common nodes in the dts files to
> meson-axg-s400-u-boot.dtsi. This allows us to keep the basic
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
> no changes from previous changes
> ---
>  arch/arm/dts/meson-axg-s400-u-boot.dtsi | 16 ++++++++++++++++
>  arch/arm/dts/meson-axg-s400.dts         |  9 ---------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/dts/meson-axg-s400-u-boot.dtsi b/arch/arm/dts/meson=
-axg-s400-u-boot.dtsi
> index c46eb3f38d..74241e9fcd 100644
> --- a/arch/arm/dts/meson-axg-s400-u-boot.dtsi
> +++ b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
> @@ -2,6 +2,22 @@
>  /*
>   * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
>   */
> +/ {
> +	soc {
> +		u-boot,dm-pre-reloc;
> +	};
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		serial1 =3D &uart_A;
> +		mmc1 =3D &sd_emmc_b;
> +		mmc2 =3D &sd_emmc_c;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> =20
>  /* wifi module */
>  &sd_emmc_b {
> diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s40=
0.dts
> index 18778ada7b..feb84255ad 100644
> --- a/arch/arm/dts/meson-axg-s400.dts
> +++ b/arch/arm/dts/meson-axg-s400.dts
> @@ -55,11 +55,6 @@
>  		};
>  	};
> =20
> -	aliases {
> -		serial0 =3D &uart_AO;
> -		serial1 =3D &uart_A;
> -	};
> -
>  	linein: audio-codec@0 {
>  		#sound-dai-cells =3D <0>;
>  		compatible =3D "everest,es7241";
> @@ -100,10 +95,6 @@
>  		reset-gpios =3D <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
>  	};
> =20
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
>  	memory@0 {
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x0 0x0 0x40000000>;
>=20
