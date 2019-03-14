Received: by mail-wm1-f67.google.com with SMTP id f3so4442852wmj.4
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=CQ3U41yt8dld7039fLP0sXFBx+zhfJmC6qGCDMLYAGI=;
        b=UZpHL5hWPDE2JJMx23g0T0sXIwk8CnhVFrzSdiPX61dNk86z4ACac9h3ZZT95JxLUf
         +Vr5k2cADlgmjJ5Nva0y8DNstHRRNnp+TP27lw3WfZXVWF05HLDiDIiNVVKbh6SJhM/1
         K/AMIKTrI4b7CeHwRE+iLSNr0B3yJZFlxknEA62Gp6bjJXqKpaX620z4+xTTDrjPTLsi
         BukMdOJoMGXBvaEOthCuWe+HBRm5wtEHfXa887PnDBitE6DP+8a9uYAASvbAxdOc7PjK
         20fGCgld5WqJ8JeXHziHftqhAOeU6R6hX/tPyk/aaieAHt0h85Vk7kOPCBB5NVeJVGsl
         r2Sw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C8AB5F2.6080801@baylibre.com>
Date: Thu, 14 Mar 2019 21:13:38 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] ARM: board: meson: add p200 board
References: <20190314170044.4844-1-mohammad.rasim96@gmail.com> <20190314170044.4844-4-mohammad.rasim96@gmail.com>
In-Reply-To: <20190314170044.4844-4-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 14/03/2019 18:00, Mohammad Rasim a =E9crit :
>=20
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++++++++++++++++++
>  configs/p200_defconfig              |  41 +++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 board/amlogic/odroid-c2/README.p200
>  create mode 100644 configs/p200_defconfig

You should also update the MAINTAINERS file in board/amlogic/odroid-c2/
for configs/p200_defconfig


Otherwise looks good

Neil

>=20
> diff --git a/board/amlogic/odroid-c2/README.p200 b/board/amlogic/odroid-c=
2/README.p200
> new file mode 100644
> index 0000000000..01d82d1e79
> --- /dev/null
> +++ b/board/amlogic/odroid-c2/README.p200
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
> diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> new file mode 100644
> index 0000000000..4011866140
> --- /dev/null
> +++ b/configs/p200_defconfig
> @@ -0,0 +1,41 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_SYS_TEXT_BASE=3D0x01000000
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" p200"
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-p200"
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_MESON=3Dy
> +CONFIG_DM_MMC=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_ETH_DESIGNWARE=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXBB=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_DEBUG_UART_MESON=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_SYS_BOARD=3D"odroid-c2"
> --
> 2.21.0
>=20
