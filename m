Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.67828.1679561404050994691
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:50:04 -0700
Received: by mail-wm1-f49.google.com with SMTP id w11so11912376wmo.2
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561402;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jLNoDw6pma3I8nwXuPPLrjvN+IRgSB5RYrZ+ink7bXQ=;
        b=DXysjfFet7Qy5sKeGEMuDSyoqiXxWBNwlH5gzHSWIJoplQektLT40+fMrkktkfxC5x
         N/86hMQRC4ti7oLt9lzxmEDw1KoVQyo0eCvKSsY2zK2IHbpQpP5ZzpSBzFf+7TF+0Wcs
         Bpu15rCx/3rYAKgzzhJ26rXhhhABLvisHgXjJ2g34weG8/OVlF32iU9qqc+MwKO232xT
         BU/bEG53fjaAX59zhJvlWwVC6i7g4pDNmFWCWO9AJlsrIQyYOudjgXfkbEKT3Rplhtki
         hbrYv2ihTcJ49wdUZ6rUnd3RNMWTW26puTRKMW22VL9/W/jlb7SNKQvYfzAdNIuGlU0D
         0oRw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <27cd7e3b-24ba-9174-0154-c61257178a8a@linaro.org>
Date: Thu, 23 Mar 2023 09:50:01 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 04/13] docs: boards: amlogic: add documentation for BananaPi M2-Pro
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <20230323065458.776029-5-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323065458.776029-5-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 07:54, Christian Hewitt wrote:
> Add build docs for the BPI-M2-PRO board.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/u200/MAINTAINERS       |   2 +
>   doc/board/amlogic/bananapi-m2pro.rst | 142 +++++++++++++++++++++++++++
>   doc/board/amlogic/index.rst          |   1 +
>   3 files changed, 145 insertions(+)
>   create mode 100644 doc/board/amlogic/bananapi-m2pro.rst
> 
> diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
> index 919e349922..f429c212ba 100644
> --- a/board/amlogic/u200/MAINTAINERS
> +++ b/board/amlogic/u200/MAINTAINERS
> @@ -4,8 +4,10 @@ S:	Maintained
>   L:	u-boot-amlogic@groups.io
>   F:	board/amlogic/u200/
>   F:	configs/u200_defconfig
> +F:	configs/bananapi-m2pro_defconfig
>   F:	configs/bananapi-m5_defconfig
>   F:	configs/radxa-zero_defconfig
>   F:	doc/board/amlogic/u200.rst
> +F:	doc/board/amlogic/bananapi-m2pro.rst
>   F:	doc/board/amlogic/bananapi-m5.rst
>   F:	doc/board/amlogic/radxa-zero.rst
> diff --git a/doc/board/amlogic/bananapi-m2pro.rst b/doc/board/amlogic/bananapi-m2pro.rst
> new file mode 100644
> index 0000000000..6c2974f323
> --- /dev/null
> +++ b/doc/board/amlogic/bananapi-m2pro.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for BananaPi BPI-M2-PRO (S905X3)
> +=======================================
> +
> +BananaPi BPI-M2-PRO is a Single Board Computer manufactured by Sinovoip with the
> +following specification:
> +
> + - Amlogic S905X3 Arm Cortex-A55 quad-core SoC
> + - 2GB DDR4 SDRAM
> + - 16GB eMMC
> + - Gigabit Ethernet
> + - RTL8821CU USB WiFi (a/b/g/n/ac) + BT 5.0
> + - HDMI 2.1 display
> + - 40-pin GPIO header
> + - 2x USB 3.0 Host
> + - 1x DC Jack (power)
> + - microSD
> + - UART serial
> + - Infrared receiver
> +
> +Schematics are available from the manufacturer: https://wiki.banana-pi.org/Banana_Pi_BPI-M2_Pro
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make bananapi-m2pro_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash

Please add a newline here otherwise the doc fails to build, here and the other doc patches.

Thanks,

Neil

> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh bananapi-m2pro /path/to/u-boot/u-boot.bin my-output-dir
> +
> +U-Boot Manual Signing
> +---------------------
> +
> +Amlogic does not provide sources for the firmware and tools needed to create a bootloader
> +image so it is necessary to obtain binaries from sources published by the board vendor:
> +
> +.. code-block:: bash
> +
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +
> +    $ DIR=bananapi-m2pro
> +    $ git clone --depth 1 https://github.com/Dangku/amlogic-u-boot.git -b odroidg12-v2015.01-c4-m5 $DIR
> +
> +    $ cd $DIR
> +    $ make bananapi_m2pro_defconfig
> +    $ make
> +    $ export UBOOTDIR=$PWD
> +
> +Go back to the mainline U-Boot source tree then:
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> +    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> +    $ cp $UBOOTDIR/build/board/bananapi/bananpi_m5/firmware/acs.bin fip/
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
> +         fip/bl30.bin \
> +         fip/zero_tmp \
> +         fip/bl30_zero.bin \
> +         fip/bl301.bin \
> +         fip/bl301_zero.bin \
> +         fip/bl30_new.bin \
> +         bl30
> +
> +    $ sh fip/blx_fix.sh \
> +         fip/bl2.bin \
> +         fip/zero_tmp \
> +         fip/bl2_zero.bin \
> +         fip/acs.bin \
> +         fip/bl21_zero.bin \
> +         fip/bl2_new.bin \
> +         bl2
> +
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
> +                                          --output fip/bl30_new.bin.g12a.enc \
> +                                          --level v3
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
> +                                          --output fip/bl30_new.bin.enc \
> +                                          --level v3 --type bl30
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
> +                                          --output fip/bl31.img.enc \
> +                                          --level v3 --type bl31
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
> +                                          --output fip/bl33.bin.enc \
> +                                          --level v3 --type bl33 --compress lz4
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
> +                                          --output fip/bl2.n.bin.sig
> +    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
> +                                          --output fip/u-boot.bin \
> +                                          --bl2 fip/bl2.n.bin.sig \
> +                                          --bl30 fip/bl30_new.bin.enc \
> +                                          --bl31 fip/bl31.img.enc \
> +                                          --bl33 fip/bl33.bin.enc \
> +                                          --ddrfw1 fip/ddr4_1d.fw \
> +                                          --ddrfw2 fip/ddr4_2d.fw \
> +                                          --ddrfw3 fip/ddr3_1d.fw \
> +                                          --ddrfw4 fip/piei.fw \
> +                                          --ddrfw5 fip/lpddr4_1d.fw \
> +                                          --ddrfw6 fip/lpddr4_2d.fw \
> +                                          --ddrfw7 fip/diag_lpddr4.fw \
> +                                          --ddrfw8 fip/aml_ddr.fw \
> +                                          --ddrfw9 fip/lpddr3_1d.fw \
> +                                          --level v3
> +
> +Then write the image to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 9b76bca427..8388acdd11 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -86,6 +86,7 @@ Board Documentation
>      :maxdepth: 1
>   
>      bananapi-cm4io
> +   bananapi-m2pro
>      bananapi-m5
>      beelink-gskingx
>      beelink-gtking

