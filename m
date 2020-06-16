Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web11.3929.1592282132704535060
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Jun 2020 21:35:32 -0700
Received: by mail-il1-f193.google.com with SMTP id x18so17606495ilp.1
        for <u-boot-amlogic@groups.io>; Mon, 15 Jun 2020 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qa6Cyse3e30LoUcGQU3rUwLkAVK0kbp6nwY8FDM3ueg=;
        b=qDTS0ENXGI0Tz10yDqdQ7/739qz+H8W+IaYQ9Jjz/gepWfj6COkrBt6UEHl4cOifnG
         WYqkMPNTKQdMkLNlHlgIqrOsSjAlpnY8qXgwu0wRiFp9EXhgG5jtlx03xZdwlR6j+TMB
         uKlqBshN0bNDkK1SlVN/lDvmpSadvyt1zbr4mIaijwQ720apQyah1IJmVVnhpV1SDmo0
         yfDiasV99OhWnlA3JbifbZ6axkjySjyvQBhA44Y/Lfa/4vINrV9UeddF1Hysn4KM+Jie
         anclmbPyO20tU1wRZjApgv8lnWky1kc8ltiFXjyz1bEan1b1RtmFjV3l8Cdl78ZpkPuS
         8vxw==
MIME-Version: 1.0
References: <20200611132841.6546-1-narmstrong@baylibre.com> <20200611132841.6546-2-narmstrong@baylibre.com>
In-Reply-To: <20200611132841.6546-2-narmstrong@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 16 Jun 2020 10:05:19 +0530
Message-ID: <CANAwSgT36eRRo5376Au7KgK8kJ=NkqPa4fsZPVakLt8MwcaLHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: amlogic: move boards doc into doc/board/amlogic
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, b.galvani@gmail.com, xypron.glpk@gmx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Thu, 11 Jun 2020 at 19:20, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Move the natural text Amlogic board README files to doc/board/amlogic
> into reStructuredText and :
> - add reStructuredText markup for bash code
> - fix secondary titles markup
> - move board support into global support matrix
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Can you also update the following information for flashing u-boot image for eMMC

# Binaries should be available in fip directory :
fip/
 | ...
 |------ u-boot.bin (for eMMC)
 |------ u-boot.bin.sd.bin (for SDCard)

And the following for eMMC

[0] https://github.com/BayLibre/u-boot/tree/readme#install-on-emmc

So that it's clear which image should be used for particular booting device.

-Anand

> ---
>  doc/board/amlogic/index.rst                   |  95 +++++++++
>  .../board/amlogic/khadas-vim.rst              | 138 +++++++------
>  .../board/amlogic/khadas-vim2.rst             | 138 ++++++-------
>  .../board/amlogic/khadas-vim3.rst             | 189 +++++++++--------
>  .../board/amlogic/khadas-vim3l.rst            | 189 +++++++++--------
>  .../board/amlogic/libretech-ac.rst            | 142 ++++++-------
>  .../board/amlogic/libretech-cc.rst            | 139 +++++++------
>  .../board/amlogic/nanopi-k2.rst               | 136 +++++++------
>  .../board/amlogic/odroid-c2.rst               |  50 +++--
>  .../board/amlogic/odroid-n2.rst               | 187 +++++++++--------
>  .../README.p200 => doc/board/amlogic/p200.rst | 136 ++++++-------
>  .../README.p201 => doc/board/amlogic/p201.rst | 136 ++++++-------
>  .../README.p212 => doc/board/amlogic/p212.rst | 136 ++++++-------
>  .../README.q200 => doc/board/amlogic/q200.rst | 136 ++++++-------
>  .../s400/README => doc/board/amlogic/s400.rst | 150 +++++++-------
>  .../README => doc/board/amlogic/sei510.rst    | 190 ++++++++---------
>  .../README => doc/board/amlogic/sei610.rst    | 185 +++++++++--------
>  .../u200/README => doc/board/amlogic/u200.rst | 188 ++++++++---------
>  .../README.w400 => doc/board/amlogic/w400.rst | 192 +++++++++---------
>  doc/board/index.rst                           |   1 +
>  20 files changed, 1484 insertions(+), 1369 deletions(-)
>  create mode 100644 doc/board/amlogic/index.rst
>  rename board/amlogic/p212/README.khadas-vim => doc/board/amlogic/khadas-vim.rst (24%)
>  rename board/amlogic/q200/README.khadas-vim2 => doc/board/amlogic/khadas-vim2.rst (26%)
>  rename board/amlogic/w400/README.khadas-vim3 => doc/board/amlogic/khadas-vim3.rst (20%)
>  rename board/amlogic/w400/README.khadas-vim3l => doc/board/amlogic/khadas-vim3l.rst (19%)
>  rename board/amlogic/p212/README.libretech-ac => doc/board/amlogic/libretech-ac.rst (21%)
>  rename board/amlogic/p212/README.libretech-cc => doc/board/amlogic/libretech-cc.rst (46%)
>  rename board/amlogic/p200/README.nanopi-k2 => doc/board/amlogic/nanopi-k2.rst (24%)
>  rename board/amlogic/p200/README.odroid-c2 => doc/board/amlogic/odroid-c2.rst (56%)
>  rename board/amlogic/w400/README.odroid-n2 => doc/board/amlogic/odroid-n2.rst (19%)
>  rename board/amlogic/p200/README.p200 => doc/board/amlogic/p200.rst (24%)
>  rename board/amlogic/p201/README.p201 => doc/board/amlogic/p201.rst (24%)
>  rename board/amlogic/p212/README.p212 => doc/board/amlogic/p212.rst (24%)
>  rename board/amlogic/q200/README.q200 => doc/board/amlogic/q200.rst (24%)
>  rename board/amlogic/s400/README => doc/board/amlogic/s400.rst (21%)
>  rename board/amlogic/sei510/README => doc/board/amlogic/sei510.rst (14%)
>  rename board/amlogic/sei610/README => doc/board/amlogic/sei610.rst (16%)
>  rename board/amlogic/u200/README => doc/board/amlogic/u200.rst (17%)
>  rename board/amlogic/w400/README.w400 => doc/board/amlogic/w400.rst (17%)
>
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> new file mode 100644
> index 0000000000..3730419167
> --- /dev/null
> +++ b/doc/board/amlogic/index.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Amlogic
> +=======
> +
> +Hardware Support Matrix
> +-----------------------
> +
> +An up-do-date matrix is also available on: http://linux-meson.com
> +
> +This matrix concerns the actual source code version.
> +
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +|                              | S905      | S905X        | S912         | A113X      | S905X2     | S922X       | S905X3       |
> +|                              |           | S805X        | S905D        |            | S905D2     | A311D       | S905D3       |
> +|                              |           |              |              |            | S905Y2     |             |              |
> ++===============================+===========+==============+==============+============+============+=============+==============+
> +| Boards                               | Odroid-C2 | P212         | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
> +|                              | Nanopi-K2 | Khadas-VIM   | Libretech-PC |            | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
> +|                              | P200      | LibreTech-CC |              |            |            |             |              |
> +|                              | P201      | LibreTech-AC |              |            |            |             |              |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| UART                         | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Pinctrl/GPIO                 | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Clock Control                | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| PWM                          | No        | No           | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Reset Control                | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Infrared Decoder             | No        | No           | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Ethernet                     | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Multi-core                   | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Fuse access                  | **Yes**   | **Yes**      |**Yes**       |**Yes**     |**Yes**     |**Yes**      | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| SPI (FC)                     | **Yes**   | **Yes**      | **Yes**      | **Yes**    |**Yes**     | **Yes**     | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| SPI (CC)                     | No        | No           | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| I2C                          | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| USB                          | **Yes**   | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| USB OTG                      | No        | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| eMMC                         | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| SDCard                       | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| NAND                         | No        | No           | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| ADC                          | **Yes**   | **Yes**      | **Yes**      | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| CVBS Output                  | **Yes**   | **Yes**      | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| HDMI Output                  | **Yes**   | **Yes**      | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| CEC                          | No        | No           | No           | *N/A*      | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| Thermal Sensor               | No        | No           | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| LCD/LVDS Output              | No        | *N/A*        | No           | No         | No         | No          | No           |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +| SoC (version) information            | **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
> +
> +Board Documentation
> +-------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   khadas-vim2
> +   khadas-vim3l
> +   khadas-vim3
> +   khadas-vim
> +   libretech-ac
> +   libretech-cc
> +   nanopi-k2
> +   odroid-c2
> +   odroid-n2
> +   p200
> +   p201
> +   p212
> +   q200
> +   s400
> +   sei510
> +   sei610
> +   u200
> +   w400
> diff --git a/board/amlogic/p212/README.khadas-vim b/doc/board/amlogic/khadas-vim.rst
> similarity index 24%
> rename from board/amlogic/p212/README.khadas-vim
> rename to doc/board/amlogic/khadas-vim.rst
> index ccf933861b..397382c375 100644
> --- a/board/amlogic/p212/README.khadas-vim
> +++ b/doc/board/amlogic/khadas-vim.rst
> @@ -1,5 +1,5 @@
>  U-Boot for Khadas VIM
> -=======================
> +======================
>
>  Khadas VIM is an Open Source DIY Box manufactured by Shenzhen Wesion
>  Technology Co., Ltd with the following specifications:
> @@ -16,86 +16,84 @@ Technology Co., Ltd with the following specifications:
>   - SDIO Wifi Module, Bluetooth
>   - Two channels IR receiver
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> -
>  U-Boot compilation
> -==================
> +------------------
> +
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make khadas-vim_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make khadas-vim_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/khadas/u-boot -b Vim vim-u-boot
> - > cd vim-u-boot
> - > make kvim_defconfig
> - > make CROSS_COMPILE=aarch64-none-elf-
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/khadas/u-boot -b Vim vim-u-boot
> +    $ cd vim-u-boot
> +    $ make kvim_defconfig
> +    $ make CROSS_COMPILE=aarch64-none-elf-
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/q200/README.khadas-vim2 b/doc/board/amlogic/khadas-vim2.rst
> similarity index 26%
> rename from board/amlogic/q200/README.khadas-vim2
> rename to doc/board/amlogic/khadas-vim2.rst
> index 595998c4fa..c57d96d8b0 100644
> --- a/board/amlogic/q200/README.khadas-vim2
> +++ b/doc/board/amlogic/khadas-vim2.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
>  U-Boot for Khadas VIM2
>  =======================
>
> @@ -17,86 +19,84 @@ Technology Co., Ltd with the following specifications:
>   - SDIO Wifi Module, Bluetooth
>   - Two channels IR receiver
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> -
>  U-Boot compilation
> -==================
> +------------------
> +
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make khadas-vim2_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make khadas-vim2_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/khadas/u-boot -b khadas-vim-v2015.01 vim-u-boot
> - > cd vim-u-boot
> - > make kvim2_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/khadas/u-boot -b khadas-vim-v2015.01 vim-u-boot
> +    $ cd vim-u-boot
> +    $ make kvim2_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/w400/README.khadas-vim3 b/doc/board/amlogic/khadas-vim3.rst
> similarity index 20%
> rename from board/amlogic/w400/README.khadas-vim3
> rename to doc/board/amlogic/khadas-vim3.rst
> index 399bf49295..161ccc3ca3 100644
> --- a/board/amlogic/w400/README.khadas-vim3
> +++ b/doc/board/amlogic/khadas-vim3.rst
> @@ -16,116 +16,115 @@ Technology Co., Ltd. with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the U-Boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make khadas-vim3_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make khadas-vim3_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>
> - > DIR=vim3-u-boot
> - > git clone --depth 1 \
> +    $ DIR=vim3-u-boot
> +    $ git clone --depth 1 \
>         https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
>         $DIR
>
> - > cd vim3-u-boot
> - > make kvim3_defconfig
> - > make
> - > export UBOOTDIR=$PWD
> +    $ cd vim3-u-boot
> +    $ make kvim3_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
>
>   Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> - > cp $UBOOTDIR/build/board/khadas/kvim3/firmware/acs.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl2.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl30.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl31.img fip/
> - > cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> - > cp $UBOOTDIR/fip/g12b/lpddr3_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/piei.fw fip/
> - > cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl2.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/acs.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
> -                                       --output fip/bl30_new.bin.g12a.enc \
> -                                       --level v3
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
> -                                       --output fip/bl30_new.bin.enc \
> -                                       --level v3 --type bl30
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
> -                                       --output fip/bl31.img.enc \
> -                                       --level v3 --type bl31
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
> -                                       --output fip/bl33.bin.enc \
> -                                       --level v3 --type bl33 --compress lz4
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
> -                                       --output fip/bl2.n.bin.sig
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc \
> -               --ddrfw1 fip/ddr4_1d.fw \
> -               --ddrfw2 fip/ddr4_2d.fw \
> -               --ddrfw3 fip/ddr3_1d.fw \
> -               --ddrfw4 fip/piei.fw \
> -               --ddrfw5 fip/lpddr4_1d.fw \
> -               --ddrfw6 fip/lpddr4_2d.fw \
> -               --ddrfw7 fip/diag_lpddr4.fw \
> -               --ddrfw8 fip/aml_ddr.fw \
> -               --ddrfw9 fip/lpddr3_1d.fw \
> -               --level v3
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/khadas/kvim3/firmware/acs.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/lpddr3_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
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
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
> +                                       --output fip/bl30_new.bin.g12a.enc \
> +                                       --level v3
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
> +                                       --output fip/bl30_new.bin.enc \
> +                                       --level v3 --type bl30
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
> +                                       --output fip/bl31.img.enc \
> +                                       --level v3 --type bl31
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
> +                                       --output fip/bl33.bin.enc \
> +                                       --level v3 --type bl33 --compress lz4
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
> +                                       --output fip/bl2.n.bin.sig
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
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
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/w400/README.khadas-vim3l b/doc/board/amlogic/khadas-vim3l.rst
> similarity index 19%
> rename from board/amlogic/w400/README.khadas-vim3l
> rename to doc/board/amlogic/khadas-vim3l.rst
> index b2d9abbfd9..9368359d5b 100644
> --- a/board/amlogic/w400/README.khadas-vim3l
> +++ b/doc/board/amlogic/khadas-vim3l.rst
> @@ -16,116 +16,113 @@ Technology Co., Ltd. with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the U-Boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - ADC
> -
> -u-boot compilation
> -==================
> +U-Boot compilation
> +------------------
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make khadas-vim3l_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make khadas-vim3l_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>
> - > DIR=vim3l-u-boot
> - > git clone --depth 1 \
> +    $ DIR=vim3l-u-boot
> +    $ git clone --depth 1 \
>         https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
>         $DIR
>
> - > cd vim3l-u-boot
> - > make kvim3l_defconfig
> - > make
> - > export UBOOTDIR=$PWD
> +    $ cd vim3l-u-boot
> +    $ make kvim3l_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
>
>   Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> - > cp $UBOOTDIR/build/board/khadas/kvim3l/firmware/acs.bin fip/
> - > cp $UBOOTDIR/fip/g12a/bl2.bin fip/
> - > cp $UBOOTDIR/fip/g12a/bl30.bin fip/
> - > cp $UBOOTDIR/fip/g12a/bl31.img fip/
> - > cp $UBOOTDIR/fip/g12a/ddr3_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/ddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/ddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/diag_lpddr4.fw fip/
> - > cp $UBOOTDIR/fip/g12a/lpddr3_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/lpddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/lpddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12a/piei.fw fip/
> - > cp $UBOOTDIR/fip/g12a/aml_ddr.fw fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl2.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/acs.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
> -                                       --output fip/bl30_new.bin.g12a.enc \
> -                                       --level v3
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
> -                                       --output fip/bl30_new.bin.enc \
> -                                       --level v3 --type bl30
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
> -                                       --output fip/bl31.img.enc \
> -                                       --level v3 --type bl31
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
> -                                       --output fip/bl33.bin.enc \
> -                                       --level v3 --type bl33 --compress lz4
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
> -                                       --output fip/bl2.n.bin.sig
> - > $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc \
> -               --ddrfw1 fip/ddr4_1d.fw \
> -               --ddrfw2 fip/ddr4_2d.fw \
> -               --ddrfw3 fip/ddr3_1d.fw \
> -               --ddrfw4 fip/piei.fw \
> -               --ddrfw5 fip/lpddr4_1d.fw \
> -               --ddrfw6 fip/lpddr4_2d.fw \
> -               --ddrfw7 fip/diag_lpddr4.fw \
> -               --ddrfw8 fip/aml_ddr.fw \
> -               --ddrfw9 fip/lpddr3_1d.fw \
> -               --level v3
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/khadas/kvim3l/firmware/acs.bin fip/
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
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p212/README.libretech-ac b/doc/board/amlogic/libretech-ac.rst
> similarity index 21%
> rename from board/amlogic/p212/README.libretech-ac
> rename to doc/board/amlogic/libretech-ac.rst
> index 3f713ec326..31fe4985e7 100644
> --- a/board/amlogic/p212/README.libretech-ac
> +++ b/doc/board/amlogic/libretech-ac.rst
> @@ -16,87 +16,93 @@ with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the U-Boot port supports the following devices:
> - - serial
> - - eMMC
> - - Ethernet
> - - USB
> -
>  U-Boot compilation
> -==================
> +------------------
> +
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make libretech-ac_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make libretech-ac_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b libretech-ac amlogic-u-boot
> - > cd amlogic-u-boot
> - > wget https://raw.githubusercontent.com/BayLibre/u-boot/libretech-cc/fip/blx_fix.sh
> - > make libretech_ac_defconfig
> - > make
> - > export UBOOTDIR=$PWD
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b libretech-ac amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ wget https://raw.githubusercontent.com/BayLibre/u-boot/libretech-cc/fip/blx_fix.sh
> +    $ make libretech_ac_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
>
>  Download the latest Amlogic Buildroot package, and extract it :
> - > wget http://openlinux2.amlogic.com:8000/ARM/filesystem/Linux_BSP/buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz
> - > tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180418/bootloader
> - > export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180418
> +
> +.. code-block:: bash
> +
> +    $ wget http://openlinux2.amlogic.com:8000/ARM/filesystem/Linux_BSP/buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz
> +    $ tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180418/bootloader
> +    $ export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180418
>
>  Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> - > cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/bl21.bin fip/
> - > cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/acs.bin fip/
> - > cp $BRDIR/bootloader/uboot-repo/bl2/bin/gxl/bl2.bin fip/
> - > cp $BRDIR/bootloader/uboot-repo/bl30/bin/gxl/bl30.bin fip/
> - > cp $BRDIR/bootloader/uboot-repo/bl31/bin/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > sh $UBOOTDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $BRDIR/bootloader/uboot-repo/fip/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > sh $UBOOTDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/bl21.bin fip/
> +    $ cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/acs.bin fip/
> +    $ cp $BRDIR/bootloader/uboot-repo/bl2/bin/gxl/bl2.bin fip/
> +    $ cp $BRDIR/bootloader/uboot-repo/bl30/bin/gxl/bl30.bin fip/
> +    $ cp $BRDIR/bootloader/uboot-repo/bl31/bin/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ sh $UBOOTDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $BRDIR/bootloader/uboot-repo/fip/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ sh $UBOOTDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p212/README.libretech-cc b/doc/board/amlogic/libretech-cc.rst
> similarity index 46%
> rename from board/amlogic/p212/README.libretech-cc
> rename to doc/board/amlogic/libretech-cc.rst
> index 74434d4435..5657f2c887 100644
> --- a/board/amlogic/p212/README.libretech-cc
> +++ b/doc/board/amlogic/libretech-cc.rst
> @@ -16,26 +16,17 @@ with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the U-Boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> -
>  U-Boot compilation
> -==================
> +------------------
> +
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make libretech-cc_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make libretech-cc_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  To boot the system, u-boot must be combined with several earlier stage
>  bootloaders:
> @@ -53,74 +44,82 @@ for convenience at <https://github.com/BayLibre/u-boot/releases/>
>  Download and extract the libretech-cc release from there, and set FIPDIR to
>  point to the `fip` subdirectory.
>
> - > export FIPDIR=/path/to/extracted/fip
> +.. code-block:: bash
> +
> +    $ export FIPDIR=/path/to/extracted/fip
>
>  Alternatively, you can obtain the original vendor u-boot tree which
>  contains the required blobs and sources, and build yourself.
>  Note that old compilers are required for this to build. The compilers here
>  are suggested by Amlogic, and they are 32-bit x86 binaries.
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
> - > cd amlogic-u-boot
> - > make libretech_cc_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make libretech_cc_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Once you have the binaries available (either through the prebuilt download,
>  or having built the vendor u-boot yourself), you can then proceed to glue
>  everything together. Go back to mainline U-Boot source tree then :
>
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
>
>  Note that Amlogic provides aml_encrypt_gxl as a 32-bit x86 binary with no
>  source code. Should you prefer to avoid that, there are open source reverse
> diff --git a/board/amlogic/p200/README.nanopi-k2 b/doc/board/amlogic/nanopi-k2.rst
> similarity index 24%
> rename from board/amlogic/p200/README.nanopi-k2
> rename to doc/board/amlogic/nanopi-k2.rst
> index c8dec3569b..b8147de61c 100644
> --- a/board/amlogic/p200/README.nanopi-k2
> +++ b/doc/board/amlogic/nanopi-k2.rst
> @@ -16,83 +16,87 @@ with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make nanopi-k2_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make nanopi-k2_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
> - > git clone https://github.com/friendlyarm/u-boot.git -b nanopi-k2-v2015.01 amlogic-u-boot
> - > cd amlogic-u-boot
> - > sed -i 's/aarch64-linux-gnu-/aarch64-none-elf-/' Makefile
> - > sed -i 's/arm-linux-/arm-none-eabi-/' arch/arm/cpu/armv8/gxb/firmware/scp_task/Makefile
> - > make nanopi-k2_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
> +    $ git clone https://github.com/friendlyarm/u-boot.git -b nanopi-k2-v2015.01 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ sed -i 's/aarch64-linux-gnu-/aarch64-none-elf-/' Makefile
> +    $ sed -i 's/arm-linux-/arm-none-eabi-/' arch/arm/cpu/armv8/gxb/firmware/scp_task/Makefile
> +    $ make nanopi-k2_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxb/bl2.bin fip/
> - > cp $FIPDIR/gxb/acs.bin fip/
> - > cp $FIPDIR/gxb/bl21.bin fip/
> - > cp $FIPDIR/gxb/bl30.bin fip/
> - > cp $FIPDIR/gxb/bl301.bin fip/
> - > cp $FIPDIR/gxb/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/fip_create \
> -        --bl30 fip/bl30_new.bin \
> -        --bl31 fip/bl31.img \
> -        --bl33 fip/bl33.bin \
> -        fip/fip.bin
> -
> - > python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > cat fip/bl2_new.bin fip/fip.bin > fip/boot_new.bin
> -
> - > $FIPDIR/gxb/aml_encrypt_gxb --bootsig \
> -               --input fip/boot_new.bin
> -               --output fip/u-boot.bin
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxb/bl2.bin fip/
> +    $ cp $FIPDIR/gxb/acs.bin fip/
> +    $ cp $FIPDIR/gxb/bl21.bin fip/
> +    $ cp $FIPDIR/gxb/bl30.bin fip/
> +    $ cp $FIPDIR/gxb/bl301.bin fip/
> +    $ cp $FIPDIR/gxb/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $FIPDIR/fip_create \
> +        --bl30 fip/bl30_new.bin \
> +        --bl31 fip/bl31.img \
> +        --bl33 fip/bl33.bin \
> +        fip/fip.bin
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ cat fip/bl2_new.bin fip/fip.bin > fip/boot_new.bin
> +
> +    $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig \
> +               --input fip/boot_new.bin
> +               --output fip/u-boot.bin
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
> diff --git a/board/amlogic/p200/README.odroid-c2 b/doc/board/amlogic/odroid-c2.rst
> similarity index 56%
> rename from board/amlogic/p200/README.odroid-c2
> rename to doc/board/amlogic/odroid-c2.rst
> index 3b9f80df29..7b518fc26a 100644
> --- a/board/amlogic/p200/README.odroid-c2
> +++ b/doc/board/amlogic/odroid-c2.rst
> @@ -16,50 +16,46 @@ Co. Ltd with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make odroid-c2_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make odroid-c2_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > DIR=odroid-c2
> - > git clone --depth 1 \
> +.. code-block:: bash
> +
> +    $ DIR=odroid-c2
> +    $ git clone --depth 1 \
>         https://github.com/hardkernel/u-boot.git -b odroidc2-v2015.01 \
>         $DIR
> - > $DIR/fip/fip_create --bl30  $DIR/fip/gxb/bl30.bin \
> +    $ $DIR/fip/fip_create --bl30  $DIR/fip/gxb/bl30.bin \
>                         --bl301 $DIR/fip/gxb/bl301.bin \
>                         --bl31  $DIR/fip/gxb/bl31.bin \
>                         --bl33  u-boot.bin \
>                         $DIR/fip.bin
> - > $DIR/fip/fip_create --dump $DIR/fip.bin
> - > cat $DIR/fip/gxb/bl2.package $DIR/fip.bin > $DIR/boot_new.bin
> - > $DIR/fip/gxb/aml_encrypt_gxb --bootsig \
> +    $ $DIR/fip/fip_create --dump $DIR/fip.bin
> +    $ cat $DIR/fip/gxb/bl2.package $DIR/fip.bin > $DIR/boot_new.bin
> +    $ $DIR/fip/gxb/aml_encrypt_gxb --bootsig \
>                                  --input $DIR/boot_new.bin \
>                                  --output $DIR/u-boot.img
> - > dd if=$DIR/u-boot.img of=$DIR/u-boot.gxbb bs=512 skip=96
> +    $ dd if=$DIR/u-boot.img of=$DIR/u-boot.gxbb bs=512 skip=96
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > BL1=$DIR/sd_fuse/bl1.bin.hardkernel
> - > dd if=$BL1 of=$DEV conv=fsync bs=1 count=442
> - > dd if=$BL1 of=$DEV conv=fsync bs=512 skip=1 seek=1
> - > dd if=$DIR/u-boot.gxbb of=$DEV conv=fsync bs=512 seek=97
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ BL1=$DIR/sd_fuse/bl1.bin.hardkernel
> +    $ dd if=$BL1 of=$DEV conv=fsync bs=1 count=442
> +    $ dd if=$BL1 of=$DEV conv=fsync bs=512 skip=1 seek=1
> +    $ dd if=$DIR/u-boot.gxbb of=$DEV conv=fsync bs=512 seek=97
> diff --git a/board/amlogic/w400/README.odroid-n2 b/doc/board/amlogic/odroid-n2.rst
> similarity index 19%
> rename from board/amlogic/w400/README.odroid-n2
> rename to doc/board/amlogic/odroid-n2.rst
> index 8142eebea0..b7b9cccfa8 100644
> --- a/board/amlogic/w400/README.odroid-n2
> +++ b/doc/board/amlogic/odroid-n2.rst
> @@ -15,115 +15,114 @@ Co. Ltd with the following specifications:
>
>  Schematics are available on the manufacturer website.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make odroid-n2_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make odroid-n2_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>
> - > DIR=odroid-n2
> - > git clone --depth 1 \
> +    $ DIR=odroid-n2
> +    $ git clone --depth 1 \
>         https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 \
>         $DIR
>
> - > cd odroid-n2
> - > make odroidn2_defconfig
> - > make
> - > export UBOOTDIR=$PWD
> +    $ cd odroid-n2
> +    $ make odroidn2_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
>
>   Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> - > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> - > cp $UBOOTDIR/build/board/hardkernel/odroidn2/firmware/acs.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl2.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl30.bin fip/
> - > cp $UBOOTDIR/fip/g12b/bl31.img fip/
> - > cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> - > cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
> - > cp $UBOOTDIR/fip/g12b/piei.fw fip/
> - > cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > sh fip/blx_fix.sh \
> -       fip/bl2.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/acs.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
> -                                       --output fip/bl30_new.bin.g12a.enc \
> -                                       --level v3
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
> -                                       --output fip/bl30_new.bin.enc \
> -                                       --level v3 --type bl30
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
> -                                       --output fip/bl31.img.enc \
> -                                       --level v3 --type bl31
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
> -                                       --output fip/bl33.bin.enc \
> -                                       --level v3 --type bl33 --compress lz4
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
> -                                       --output fip/bl2.n.bin.sig
> - > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc \
> -               --ddrfw1 fip/ddr4_1d.fw \
> -               --ddrfw2 fip/ddr4_2d.fw \
> -               --ddrfw3 fip/ddr3_1d.fw \
> -               --ddrfw4 fip/piei.fw \
> -               --ddrfw5 fip/lpddr4_1d.fw \
> -               --ddrfw6 fip/lpddr4_2d.fw \
> -               --ddrfw7 fip/diag_lpddr4.fw \
> -               --ddrfw8 fip/aml_ddr.fw \
> -               --level v3
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/hardkernel/odroidn2/firmware/acs.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
> +    $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
> +    $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
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
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
> +                                       --output fip/bl30_new.bin.g12a.enc \
> +                                       --level v3
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
> +                                       --output fip/bl30_new.bin.enc \
> +                                       --level v3 --type bl30
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
> +                                       --output fip/bl31.img.enc \
> +                                       --level v3 --type bl31
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
> +                                       --output fip/bl33.bin.enc \
> +                                       --level v3 --type bl33 --compress lz4
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
> +                                       --output fip/bl2.n.bin.sig
> +    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
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
> +               --level v3
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p200/README.p200 b/doc/board/amlogic/p200.rst
> similarity index 24%
> rename from board/amlogic/p200/README.p200
> rename to doc/board/amlogic/p200.rst
> index 84d5ca5356..b6103b25fe 100644
> --- a/board/amlogic/p200/README.p200
> +++ b/doc/board/amlogic/p200.rst
> @@ -17,86 +17,84 @@ specifications:
>
>  Schematics are available from Amlogic on demand.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make p200_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make p200_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> - > cd amlogic-u-boot
> - > make gxb_p200_v1_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make gxb_p200_v1_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p201/README.p201 b/doc/board/amlogic/p201.rst
> similarity index 24%
> rename from board/amlogic/p201/README.p201
> rename to doc/board/amlogic/p201.rst
> index 4bb5e95905..da14f84ac2 100644
> --- a/board/amlogic/p201/README.p201
> +++ b/doc/board/amlogic/p201.rst
> @@ -17,86 +17,84 @@ specifications:
>
>  Schematics are available from Amlogic on demand.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make p201_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make p201_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> - > cd amlogic-u-boot
> - > make gxb_p201_v1_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make gxb_p201_v1_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/p212/README.p212 b/doc/board/amlogic/p212.rst
> similarity index 24%
> rename from board/amlogic/p212/README.p212
> rename to doc/board/amlogic/p212.rst
> index 3776f24493..c6c375077d 100644
> --- a/board/amlogic/p212/README.p212
> +++ b/doc/board/amlogic/p212.rst
> @@ -17,86 +17,84 @@ specifications:
>
>  Schematics are available from Amlogic on demand.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make p212_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make p212_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> - > cd amlogic-u-boot
> - > make gxl_p212_v1_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make gxl_p212_v1_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/q200/README.q200 b/doc/board/amlogic/q200.rst
> similarity index 24%
> rename from board/amlogic/q200/README.q200
> rename to doc/board/amlogic/q200.rst
> index d4142c88bd..58ebe52a2a 100644
> --- a/board/amlogic/q200/README.q200
> +++ b/doc/board/amlogic/q200.rst
> @@ -16,86 +16,84 @@ specifications:
>   - SDIO Wifi Module, Bluetooth
>   - IR receiver
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC, microSD
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> -
>  U-Boot compilation
> -==================
> +------------------
> +
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make khadas-vim2_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make khadas-vim2_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> - > cd amlogic-u-boot
> - > make gxm_q200_v1_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make gxm_q200_v1_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-Boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/gxl/bl2.bin fip/
> - > cp $FIPDIR/gxl/acs.bin fip/
> - > cp $FIPDIR/gxl/bl21.bin fip/
> - > cp $FIPDIR/gxl/bl30.bin fip/
> - > cp $FIPDIR/gxl/bl301.bin fip/
> - > cp $FIPDIR/gxl/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> - > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> - > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> -               --output fip/u-boot.bin \
> -               --bl2 fip/bl2.n.bin.sig \
> -               --bl30 fip/bl30_new.bin.enc \
> -               --bl31 fip/bl31.img.enc \
> -               --bl33 fip/bl33.bin.enc
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/gxl/bl2.bin fip/
> +    $ cp $FIPDIR/gxl/acs.bin fip/
> +    $ cp $FIPDIR/gxl/bl21.bin fip/
> +    $ cp $FIPDIR/gxl/bl30.bin fip/
> +    $ cp $FIPDIR/gxl/bl301.bin fip/
> +    $ cp $FIPDIR/gxl/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl30.bin \
> +       fip/zero_tmp \
> +       fip/bl30_zero.bin \
> +       fip/bl301.bin \
> +       fip/bl301_zero.bin \
> +       fip/bl30_new.bin \
> +       bl30
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +       fip/bl2_acs.bin \
> +       fip/zero_tmp \
> +       fip/bl2_zero.bin \
> +       fip/bl21.bin \
> +       fip/bl21_zero.bin \
> +       fip/bl2_new.bin \
> +       bl2
> +
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
> +               --output fip/u-boot.bin \
> +               --bl2 fip/bl2.n.bin.sig \
> +               --bl30 fip/bl30_new.bin.enc \
> +               --bl31 fip/bl31.img.enc \
> +               --bl33 fip/bl33.bin.enc
>
>  and then write the image to SD with:
>
> - > DEV=/dev/your_sd_device
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> - > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +.. code-block:: bash
> +
> +    $ DEV=/dev/your_sd_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> diff --git a/board/amlogic/s400/README b/doc/board/amlogic/s400.rst
> similarity index 21%
> rename from board/amlogic/s400/README
> rename to doc/board/amlogic/s400.rst
> index a48db22a42..a1d5cac633 100644
> --- a/board/amlogic/s400/README
> +++ b/doc/board/amlogic/s400.rst
> @@ -17,93 +17,91 @@ specifications:
>
>  Schematics are available from Amlogic on demand.
>
> -Currently the u-boot port supports the following devices:
> - - serial
> - - eMMC
> - - Ethernet
> - - I2C
> - - Regulators
> - - Reset controller
> - - Clock controller
> - - USB Host
> - - ADC
> +U-Boot compilation
> +------------------
>
> -u-boot compilation
> -==================
> +.. code-block:: bash
>
> - > export CROSS_COMPILE=aarch64-none-elf-
> - > make s400_defconfig
> - > make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make s400_defconfig
> +    $ make
>
>  Image creation
> -==============
> +--------------
>
>  Amlogic doesn't provide sources for the firmware and for tools needed
>  to create the bootloader image, so it is necessary to obtain them from
>  the git tree published by the board vendor:
>
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> - > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> - > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> - > cd amlogic-u-boot
> - > make axg_s400_v1_defconfig
> - > make
> - > export FIPDIR=$PWD/fip
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    $ git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> +    $ cd amlogic-u-boot
> +    $ make axg_s400_v1_defconfig
> +    $ make
> +    $ export FIPDIR=$PWD/fip
>
>  Go back to mainline U-boot source tree then :
> - > mkdir fip
> -
> - > cp $FIPDIR/axg/bl2.bin fip/
> - > cp $FIPDIR/axg/acs.bin fip/
> - > cp $FIPDIR/axg/bl21.bin fip/
> - > cp $FIPDIR/axg/bl30.bin fip/
> - > cp $FIPDIR/axg/bl301.bin fip/
> - > cp $FIPDIR/axg/bl31.img fip/
> - > cp u-boot.bin fip/bl33.bin
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl30.bin \
> -       fip/zero_tmp \
> -       fip/bl30_zero.bin \
> -       fip/bl301.bin \
> -       fip/bl301_zero.bin \
> -       fip/bl30_new.bin \
> -       bl30
> -
> - > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> - > $FIPDIR/blx_fix.sh \
> -       fip/bl2_acs.bin \
> -       fip/zero_tmp \
> -       fip/bl2_zero.bin \
> -       fip/bl21.bin \
> -       fip/bl21_zero.bin \
> -       fip/bl2_new.bin \
> -       bl2
> -
> - > $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl30_new.bin \
> -                                       --output fip/bl30_new.bin.enc \
> -                                       --level v3 --type bl30
> - > $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl31.img \
> -                                       --output fip/bl31.img.enc \
> -                                       --level v3 --type bl31
> - > $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl33.bin --compress lz4 \
> -                                       --output fip/bl33.bin.enc \
> -                                       --level v3 --type bl33
> - > $FIPDIR/axg/aml_encrypt_axg --bl2sig --input fip/bl2_new.bin \
> -                                       --output f
