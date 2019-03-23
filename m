Received: by mail-wr1-f66.google.com with SMTP id g12so4862969wrm.5
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=McbJvPe92UQ2klCZq9D6+tkwArYqzTpovOni8e3lhtA=;
        b=EHsRtdqsdl4Wk/8MwJxG7LuXQCYbGBS4qz7XhmnDQ3mADvMrsmYsgkaqufj1KSHyU+
         dr5Xuw6FGpItam4PqmeAEQmaLGjn8KmAyY6mawD0cgzOTE5LbX1z49vpk1FdTFG0PCqq
         8pZkP62OPg/tvqWq8+cAw4W+hDppnC3+FGjh+sjWwP/uFlAEvFvaLikdTA+64qKONacp
         mpWOWF5ibWNHkKIKSy5xiFns2iPku+LE6LrnpLlOYf0JXNfZXEV16jNyHMn/bmdQ/nPo
         3SrjwDEWk/CUszyYQkjUlsDWfKL5o2s/8f+Ne051A7Bq/HyDVv7m/ifoIEcaV/cgxj3n
         DeAw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C960602.90100@baylibre.com>
Date: Sat, 23 Mar 2019 11:10:10 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] ARM: board: meson: rename odroid-c2 to p200
References: <20190315151109.17317-1-mohammad.rasim96@gmail.com> <20190315151109.17317-2-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151109.17317-2-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Beniamino Galvani <b.galvani@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, ARM AMLOGIC SOC SUPPORT <u-boot-amlogic@groups.io>, open list <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>



Le 15/03/2019 16:11, Mohammad Rasim a =E9crit :
> This renames the odroid-c2 to p200 and set it as the default GXBB board
> Other boards (odroid-c2 and nanopi-k2) will inherit from p200
>=20
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  arch/arm/mach-meson/Kconfig                   |   2 +-
>  board/amlogic/{odroid-c2 =3D> p200}/MAINTAINERS |   6 +-
>  board/amlogic/{odroid-c2 =3D> p200}/Makefile    |   2 +-
>  .../{odroid-c2 =3D> p200}/README.nanopi-k2      |   0
>  .../{odroid-c2 =3D> p200}/README.odroid-c2      |   0
>  board/amlogic/p200/README.p200                | 103 ++++++++++++++++++

This new file should go in patch 4

>  .../{odroid-c2/odroid-c2.c =3D> p200/p200.c}    |   0
>  configs/nanopi-k2_defconfig                   |   1 +
>  configs/odroid-c2_defconfig                   |   1 +
>  9 files changed, 110 insertions(+), 5 deletions(-)
>  rename board/amlogic/{odroid-c2 =3D> p200}/MAINTAINERS (70%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/Makefile (82%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/README.nanopi-k2 (100%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/README.odroid-c2 (100%)
>  create mode 100644 board/amlogic/p200/README.p200
>  rename board/amlogic/{odroid-c2/odroid-c2.c =3D> p200/p200.c} (100%)
>=20
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 11077bc6cc24..1b1d0aef0d22 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -61,7 +61,7 @@ config SYS_VENDOR
>=20
>  config SYS_BOARD
>  	string "Board name"
> -	default "odroid-c2" if MESON_GXBB
> +	default "p200" if MESON_GXBB
>  	default "p212" if MESON_GXL
>  	default "q200" if MESON_GXM
>  	default "s400" if MESON_AXG
> diff --git a/board/amlogic/odroid-c2/MAINTAINERS b/board/amlogic/p200/MAI=
NTAINERS
> similarity index 70%
> rename from board/amlogic/odroid-c2/MAINTAINERS
> rename to board/amlogic/p200/MAINTAINERS
> index 6a853066d781..96fe92dd0874 100644
> --- a/board/amlogic/odroid-c2/MAINTAINERS
> +++ b/board/amlogic/p200/MAINTAINERS
> @@ -1,8 +1,8 @@
> -ODROID-C2
> +P200
>  M:	Beniamino Galvani <b.galvani@gmail.com>
>  M:	Neil Armstrong <narmstrong@baylibre.com>
>  S:	Maintained
> -F:	board/amlogic/odroid-c2/
> -F:	include/configs/odroid-c2.h

Good catch here

> +F:	board/amlogic/p200/
>  F:	configs/nanopi-k2_defconfig
>  F:	configs/odroid-c2_defconfig
> +F:	configs/p200_defconfig

You should add this one in patch 4

> diff --git a/board/amlogic/odroid-c2/Makefile b/board/amlogic/p200/Makefi=
le
> similarity index 82%
> rename from board/amlogic/odroid-c2/Makefile
> rename to board/amlogic/p200/Makefile
> index a6a3db755f21..f82a7ea9ca6b 100644
> --- a/board/amlogic/odroid-c2/Makefile
> +++ b/board/amlogic/p200/Makefile
> @@ -2,4 +2,4 @@
>  #
>  # (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>=20
> -obj-y	:=3D odroid-c2.o
> +obj-y	:=3D p200.o
> diff --git a/board/amlogic/odroid-c2/README.nanopi-k2 b/board/amlogic/p20=
0/README.nanopi-k2
> similarity index 100%
> rename from board/amlogic/odroid-c2/README.nanopi-k2
> rename to board/amlogic/p200/README.nanopi-k2
> diff --git a/board/amlogic/odroid-c2/README.odroid-c2 b/board/amlogic/p20=
0/README.odroid-c2
> similarity index 100%
> rename from board/amlogic/odroid-c2/README.odroid-c2
> rename to board/amlogic/p200/README.odroid-c2
> diff --git a/board/amlogic/p200/README.p200 b/board/amlogic/p200/README.p=
200
> new file mode 100644
> index 000000000000..01d82d1e79e3
> --- /dev/null
> +++ b/board/amlogic/p200/README.p200
> @@ -0,0 +1,103 @@
> +U-Boot for Amlogic P200
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +P200 is a reference board manufactured by Amlogic with the following
> +specifications:
> +
> + - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
> + - ARM Mali 450 GPU
> + - 2GB DDR3 SDRAM
> + - Gigabit Ethernet
> + - HDMI 2.0 4K/60Hz display
> + - 2 x USB 2.0 Host
> + - eMMC, microSD
> + - Infrared receiver
> + - SDIO WiFi Module
> + - CVBS+Stereo Audio Jack
> +
> +Schematics are available from Amlogic on demand.
> +
> +Currently the u-boot port supports the following devices:
> + - serial
> + - eMMC, microSD
> + - Ethernet
> + - I2C
> + - Regulators
> + - Reset controller
> + - Clock controller
> + - USB Host
> + - ADC
> +
> +u-boot compilation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> + > export ARCH=3Darm
> + > export CROSS_COMPILE=3Daarch64-none-elf-
> + > make p200_defconfig
> + > make
> +
> +Image creation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Amlogic doesn't provide sources for the firmware and for tools needed
> +to create the bootloader image, so it is necessary to obtain them from
> +the git tree published by the board vendor:
> +
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/b=
inaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/b=
inaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > export PATH=3D$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:=
$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> + > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlin=
ux-20170606 amlogic-u-boot
> + > cd amlogic-u-boot
> + > make gxb_p200_v1_defconfig
> + > make
> + > export FIPDIR=3D$PWD/fip
> +
> +Go back to mainline U-boot source tree then :
> + > mkdir fip
> +
> + > cp $FIPDIR/gxl/bl2.bin fip/
> + > cp $FIPDIR/gxl/acs.bin fip/
> + > cp $FIPDIR/gxl/bl21.bin fip/
> + > cp $FIPDIR/gxl/bl30.bin fip/
> + > cp $FIPDIR/gxl/bl301.bin fip/
> + > cp $FIPDIR/gxl/bl31.img fip/
> + > cp u-boot.bin fip/bl33.bin
> +
> + > $FIPDIR/blx_fix.sh \
> +	fip/bl30.bin \
> +	fip/zero_tmp \
> +	fip/bl30_zero.bin \
> +	fip/bl301.bin \
> +	fip/bl301_zero.bin \
> +	fip/bl30_new.bin \
> +	bl30
> +
> + > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> + > $FIPDIR/blx_fix.sh \
> +	fip/bl2_acs.bin \
> +	fip/zero_tmp \
> +	fip/bl2_zero.bin \
> +	fip/bl21.bin \
> +	fip/bl21_zero.bin \
> +	fip/bl2_new.bin \
> +	bl2
> +
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output=
 fip/bl2.n.bin.sig
> + > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +		--output fip/u-boot.bin \
> +		--bl2 fip/bl2.n.bin.sig \
> +		--bl30 fip/bl30_new.bin.enc \
> +		--bl31 fip/bl31.img.enc \
> +		--bl33 fip/bl33.bin.enc
> +
> +and then write the image to SD with:
> +
> + > DEV=3D/dev/your_sd_device
> + > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D512=
 skip=3D1 seek=3D1
> + > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D1 c=
ount=3D444

> diff --git a/board/amlogic/odroid-c2/odroid-c2.c b/board/amlogic/p200/p20=
0.c
> similarity index 100%
> rename from board/amlogic/odroid-c2/odroid-c2.c
> rename to board/amlogic/p200/p200.c
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 8bbf48f41f7d..a513bc7cf8ce 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -38,3 +38,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=3Dy
>  CONFIG_DEBUG_UART_SKIP_INIT=3Dy
>  CONFIG_MESON_SERIAL=3Dy
>  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_SYS_BOARD=3D"p200"
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 747da184b3ad..f19b291164b7 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -39,3 +39,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=3Dy
>  CONFIG_DEBUG_UART_SKIP_INIT=3Dy
>  CONFIG_MESON_SERIAL=3Dy
>  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_SYS_BOARD=3D"p200"

No need for these last two changes, you changed the
default SYS_BOARD config to p200

> --
> 2.21.0
>=20

Neil
