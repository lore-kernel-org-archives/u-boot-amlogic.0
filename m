Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web10.4104.1593659357220747582
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 20:09:17 -0700
Received: by mail-il1-f196.google.com with SMTP id k6so22917440ili.6
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6BDOFg11Sr+C7cH7VvqCrsCbH1qIhhZebBzXYLLK/0=;
        b=Led05+BmrdUU8v1nF9hxkW/VNXKmn30lb3viQ+ILmv8m3CmlaBDpEAtA2Fnece522z
         0E+lArRryNUTgKF34aZ1B4VvnXSDuiTE35XDcj4e0VH9Ud9q2WYGrxF/WYUHiEPGrhd+
         +MxUmfysc9sj9GlYA8GzLCo3VAPFhLbw5IG03XTvWHe6kKork4u4Dj3n4shmuyoE9i1f
         midyQft3pC6lL+LTvb/u9Px/2NgQZoJQYc2qpGqai8RG8e7f3NpVKpVqM5el7SZdVl0F
         gPlUhmef6YNzY3SLjJ9MbrjgfrczGPgzbYMzIh8Fh73mz0jCMvn1AAmG3bwEKEIrjpAU
         AgaQ==
MIME-Version: 1.0
References: <20200701144310.25481-1-narmstrong@baylibre.com> <20200701144310.25481-3-narmstrong@baylibre.com>
In-Reply-To: <20200701144310.25481-3-narmstrong@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 2 Jul 2020 08:39:05 +0530
Message-ID: <CANAwSgRrqjObGzMZwBhS=5_n09Xjco6cF1Myj-XTM3w2hfd_GA@mail.gmail.com>
Subject: Re: [PATCH 2/3] boards: amlogic: add Odroid C4 support
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 1 Jul 2020 at 20:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Odroid C4 is an Amlogic SM1 device, the board config and board documentation
> are adapted from the Odroid-N2 support from the same vendor.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>

>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi |   7 +
>  board/amlogic/odroid-n2/MAINTAINERS          |   2 +
>  configs/odroid-c4_defconfig                  |  62 +++++++++
>  doc/board/amlogic/index.rst                  |   3 +-
>  doc/board/amlogic/odroid-c4.rst              | 133 +++++++++++++++++++
>  5 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
>  create mode 100644 configs/odroid-c4_defconfig
>  create mode 100644 doc/board/amlogic/odroid-c4.rst
>
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> new file mode 100644
> index 0000000000..ee32c6f43d
> --- /dev/null
> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-g12-common-u-boot.dtsi"
> diff --git a/board/amlogic/odroid-n2/MAINTAINERS b/board/amlogic/odroid-n2/MAINTAINERS
> index 5627e54058..77f7746346 100644
> --- a/board/amlogic/odroid-n2/MAINTAINERS
> +++ b/board/amlogic/odroid-n2/MAINTAINERS
> @@ -4,4 +4,6 @@ S:      Maintained
>  L:     u-boot-amlogic@groups.io
>  F:     board/amlogic/odroid-n2/
>  F:     configs/odroid-n2_defconfig
> +F:     configs/odroid-c4_defconfig
>  F:     doc/board/amlogic/odroid-n2.rst
> +F:     doc/board/amlogic/odroid-c4.rst
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> new file mode 100644
> index 0000000000..db9271916e
> --- /dev/null
> +++ b/configs/odroid-c4_defconfig
> @@ -0,0 +1,62 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="odroid-n2"
> +CONFIG_ARCH_MESON=y
> +CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_MESON_G12A=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING=" odroid-c4"
> +CONFIG_DEBUG_UART=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_MISC_INIT_R=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_MESON_G12A_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_RESET=y
> +CONFIG_DEBUG_UART_MESON=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_DM_VIDEO=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 3730419167..0e2f8c9aad 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -17,7 +17,7 @@ This matrix concerns the actual source code version.
>  +===============================+===========+==============+==============+============+============+=============+==============+
>  | Boards                               | Odroid-C2 | P212         | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
>  |                              | Nanopi-K2 | Khadas-VIM   | Libretech-PC |            | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
> -|                              | P200      | LibreTech-CC |              |            |            |             |              |
> +|                              | P200      | LibreTech-CC |              |            |            |             | Odroid-C4    |
>  |                              | P201      | LibreTech-AC |              |            |            |             |              |
>  +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
>  | UART                         | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> @@ -83,6 +83,7 @@ Board Documentation
>     libretech-cc
>     nanopi-k2
>     odroid-c2
> +   odroid-c4
>     odroid-n2
>     p200
>     p201
> diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
> new file mode 100644
> index 0000000000..4327d1913f
> --- /dev/null
> +++ b/doc/board/amlogic/odroid-c4.rst
> @@ -0,0 +1,133 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for ODROID-C4
> +====================
> +
> +ODROID-N2 is a single board computer manufactured by Hardkernel
> +Co. Ltd with the following specifications:
> +
> + - Amlogic S905X3 Arm Cortex-A55 quad-core SoC
> + - 2GB or 4GB LPDDR4 SDRAM
> + - Gigabit Ethernet
> + - HDMI 2.1 display
> + - 40-pin GPIO header
> + - 7-pin GPIO expansion header
> + - 4x USB 3.0 Host
> + - 1x USB 2.0 Host/OTG (micro)
> + - eMMC, microSD
> + - UART serial
> + - Infrared receiver
> +
> +Schematics are available on the manufacturer website.
> +
> +U-Boot compilation
> +------------------
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make odroid-c4_defconfig
> +    $ make
> +
> +Image creation
> +--------------
> +
> +Amlogic doesn't provide sources for the firmware and for tools needed
> +to create the bootloader image, so it is necessary to obtain them from
> +the git tree published by the board vendor:
> +
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +
> +    $ DIR=odroid-c4
> +    $ git clone --depth 1 \
> +       https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 \
> +       $DIR
> +
> +    $ cd odroid-c4
> +    $ make odroidc4_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
> +
> + Go back to mainline U-Boot source tree then :
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/hardkernel/odroidc4/firmware/acs.bin fip/
> +    $ cp $UBOOTDIR/fip/g12a/bl2.bin fip/
> +    $ cp $UBOOTDIR/fip/g12a/bl30.bin fip/
> +    $ cp $UBOOTDIR/fip/g12a/bl31.img fip/
> +    $ cp $UBOOTDIR/fip/g12a/ddr3_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/ddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/ddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/diag_lpddr4.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/lpddr3_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/lpddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/lpddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/piei.fw fip/
> +    $ cp $UBOOTDIR/fip/g12a/aml_ddr.fw fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ sh fip/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ sh fip/blx_fix.sh \
> +       fip/bl2.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/acs.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
> +                                       --output fip/bl30_new.bin.g12a.enc \
> +                                       --level v3
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
> +                                       --output fip/bl30_new.bin.enc \
> +                                       --level v3 --type bl30
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
> +                                       --output fip/bl31.img.enc \
> +                                       --level v3 --type bl31
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
> +                                       --output fip/bl33.bin.enc \
> +                                       --level v3 --type bl33 --compress lz4
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
> +                                       --output fip/bl2.n.bin.sig
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc \
> +               --ddrfw1 fip/ddr4_1d.fw \
> +               --ddrfw2 fip/ddr4_2d.fw \
> +               --ddrfw3 fip/ddr3_1d.fw \
> +               --ddrfw4 fip/piei.fw \
> +               --ddrfw5 fip/lpddr4_1d.fw \
> +               --ddrfw6 fip/lpddr4_2d.fw \
> +               --ddrfw7 fip/diag_lpddr4.fw \
> +               --ddrfw8 fip/aml_ddr.fw \
> +               --ddrfw9 fip/lpddr3_1d.fw \
> +               --level v3
> +
> +and then write the image to SD with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> --
> 2.22.0
>
