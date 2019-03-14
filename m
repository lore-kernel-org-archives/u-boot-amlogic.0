Received: by mail-wm1-f67.google.com with SMTP id n19so3395767wmi.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jMVJjXDO/dIMyeoOLeWs1Ph+ytQieNOeohsFcqGT3iI=;
        b=Qr8z1rojmJ3ZR04r78llKmtdhgiGrMnpvd3KGh9iW3j8tpGS0+YRaKkFmUpxj4L/Ae
         m5AKGrMBZazjpDW+7VOrvVqG4BZ5sqrorZB/ziP+koA3avyTdR8MOPCoYQpUDWva03pn
         l/rZpi63pJx4aUtqBCVJgSyYYywyYQRgYIhjTj1DCYRsi37zsZuFiJUE3JShAaT/IAiX
         9qJkqbd35Rz5CW5CfAGlxbnxQ8sJP3+sE2/FU4eArc9IV1C7Hzuktp6k795tNQ/vcWIt
         MiLQ35bt06zKL4LyV/mB358Ij1WC6rPSXcocsIPkVp7p7KfFrfQVCXVsXOTyNkOle9qi
         JAYw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] ARM: board: meson: add p200 and p201 boards
References: <5c8a6af9.1c69fb81.470a7.65b9@mx.google.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9a7b4857-d9b0-c29f-a84a-995a377bc39a@baylibre.com>
Date: Thu, 14 Mar 2019 16:08:03 +0100
MIME-Version: 1.0
In-Reply-To: <5c8a6af9.1c69fb81.470a7.65b9@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Mohammad,

This look very good,

can you split the into 2 patches ? 1 for the p200 defconfig and a separate one for p201 ?

Thanks,
Neil


On 14/03/2019 14:54, Mohammad Rasim wrote:
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++++++++++++++++++
>  board/amlogic/p201/MAINTAINERS      |   6 ++
>  board/amlogic/p201/Makefile         |   5 ++
>  board/amlogic/p201/README.p201      | 103 ++++++++++++++++++++++++++++
>  board/amlogic/p201/p201.c           |  43 ++++++++++++
>  configs/p200_defconfig              |  41 +++++++++++
>  configs/p201_defconfig              |  41 +++++++++++
>  7 files changed, 342 insertions(+)
>  create mode 100644 board/amlogic/odroid-c2/README.p200
>  create mode 100644 board/amlogic/p201/MAINTAINERS
>  create mode 100644 board/amlogic/p201/Makefile
>  create mode 100644 board/amlogic/p201/README.p201
>  create mode 100644 board/amlogic/p201/p201.c
>  create mode 100644 configs/p200_defconfig
>  create mode 100644 configs/p201_defconfig
> 
> diff --git a/board/amlogic/odroid-c2/README.p200 b/board/amlogic/odroid-c2/README.p200
> new file mode 100644
> index 0000000000..01d82d1e79
> --- /dev/null
> +++ b/board/amlogic/odroid-c2/README.p200
> @@ -0,0 +1,103 @@
> +U-Boot for Amlogic P200
> +=======================
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
> +==================
> +
> + > export ARCH=arm
> + > export CROSS_COMPILE=aarch64-none-elf-
> + > make p200_defconfig
> + > make
> +
> +Image creation
> +==============
> +
> +Amlogic doesn't provide sources for the firmware and for tools needed
> +to create the bootloader image, so it is necessary to obtain them from
> +the git tree published by the board vendor:
> +
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> + > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> + > cd amlogic-u-boot
> + > make gxb_p200_v1_defconfig
> + > make
> + > export FIPDIR=$PWD/fip
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
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> + > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +		--output fip/u-boot.bin \
> +		--bl2 fip/bl2.n.bin.sig \
> +		--bl30 fip/bl30_new.bin.enc \
> +		--bl31 fip/bl31.img.enc \
> +		--bl33 fip/bl33.bin.enc
> +
> +and then write the image to SD with:
> +
> + > DEV=/dev/your_sd_device
> + > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> + > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p201/MAINTAINERS b/board/amlogic/p201/MAINTAINERS
> new file mode 100644
> index 0000000000..6ebb5f6396
> --- /dev/null
> +++ b/board/amlogic/p201/MAINTAINERS
> @@ -0,0 +1,6 @@
> +P201
> +M:	Beniamino Galvani <b.galvani@gmail.com>
> +M:	Neil Armstrong <narmstrong@baylibre.com>
> +S:	Maintained
> +F:	board/amlogic/p201/
> +F:	configs/p201_defconfig
> diff --git a/board/amlogic/p201/Makefile b/board/amlogic/p201/Makefile
> new file mode 100644
> index 0000000000..11de5396ab
> --- /dev/null
> +++ b/board/amlogic/p201/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
> +
> +obj-y	:= p201.o
> diff --git a/board/amlogic/p201/README.p201 b/board/amlogic/p201/README.p201
> new file mode 100644
> index 0000000000..c251096ce1
> --- /dev/null
> +++ b/board/amlogic/p201/README.p201
> @@ -0,0 +1,103 @@
> +U-Boot for Amlogic P201
> +=======================
> +
> +P201 is a reference board manufactured by Amlogic with the following
> +specifications:
> +
> + - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
> + - ARM Mali 450 GPU
> + - 2GB DDR3 SDRAM
> + - 10/100 Ethernet
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
> +==================
> +
> + > export ARCH=arm
> + > export CROSS_COMPILE=aarch64-none-elf-
> + > make p201_defconfig
> + > make
> +
> +Image creation
> +==============
> +
> +Amlogic doesn't provide sources for the firmware and for tools needed
> +to create the bootloader image, so it is necessary to obtain them from
> +the git tree published by the board vendor:
> +
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> + > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> + > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> + > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> + > cd amlogic-u-boot
> + > make gxb_p201_v1_defconfig
> + > make
> + > export FIPDIR=$PWD/fip
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
> + > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> + > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +		--output fip/u-boot.bin \
> +		--bl2 fip/bl2.n.bin.sig \
> +		--bl30 fip/bl30_new.bin.enc \
> +		--bl31 fip/bl31.img.enc \
> +		--bl33 fip/bl33.bin.enc
> +
> +and then write the image to SD with:
> +
> + > DEV=/dev/your_sd_device
> + > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> + > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p201/p201.c b/board/amlogic/p201/p201.c
> new file mode 100644
> index 0000000000..ef0c65cd9f
> --- /dev/null
> +++ b/board/amlogic/p201/p201.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <environment.h>
> +#include <asm/io.h>
> +#include <asm/arch/gx.h>
> +#include <asm/arch/sm.h>
> +#include <asm/arch/eth.h>
> +#include <asm/arch/mem.h>
> +
> +#define EFUSE_SN_OFFSET		20
> +#define EFUSE_SN_SIZE		16
> +#define EFUSE_MAC_OFFSET	52
> +#define EFUSE_MAC_SIZE		6
> +
> +int misc_init_r(void)
> +{
> +	u8 mac_addr[EFUSE_MAC_SIZE];
> +	char serial[EFUSE_SN_SIZE];
> +	ssize_t len;
> +
> +	meson_eth_init(PHY_INTERFACE_MODE_RMII, 0);
> +
> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> +		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> +					  mac_addr, EFUSE_MAC_SIZE);
> +		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
> +			eth_env_set_enetaddr("ethaddr", mac_addr);
> +	}
> +
> +	if (!env_get("serial#")) {
> +		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
> +			EFUSE_SN_SIZE);
> +		if (len == EFUSE_SN_SIZE)
> +			env_set("serial#", serial);
> +	}
> +
> +	return 0;
> +}
> diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> new file mode 100644
> index 0000000000..4011866140
> --- /dev/null
> +++ b/configs/p200_defconfig
> @@ -0,0 +1,41 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" p200"
> +CONFIG_DEBUG_UART=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_DM_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXBB=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_BOARD="odroid-c2"
> diff --git a/configs/p201_defconfig b/configs/p201_defconfig
> new file mode 100644
> index 0000000000..f6a821cf32
> --- /dev/null
> +++ b/configs/p201_defconfig
> @@ -0,0 +1,41 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_DEBUG_UART_BASE=0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" p201"
> +CONFIG_DEBUG_UART=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_DM_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MESON=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_GXBB=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_BOARD="p201"
> --
> 2.21.0
> 

