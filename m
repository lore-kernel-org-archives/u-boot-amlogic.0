Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.74801.1679583746626130738
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 08:02:27 -0700
Received: by mail-wr1-f43.google.com with SMTP id l27so12535387wrb.2
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679583745;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YuE/aZpyaWKm7h+mg+WnOEwFLwpv96gVOp1whUMDs1w=;
        b=lo5FUpYrKctPMBWmyChGqynpLzQcITxiVqwJWY9ZCa9NVbHxdJsTftpt6454TH65VY
         glTrsmGtdVpVaKpdg+a0R3LBiZBLSYVbzz7+xq6x9PGPwEvt7Y+rp9KSeWIsBAZfNZio
         xsmsGwRimy+C83GKv8Vh3ADrhbBWlmcbqSkc5tVrY6zAtArZLHFPeKsY/f3HWg4z0Z3F
         yQqupA9IjCD8+wZ0Wte+TCWR+FWSqlGwYTn1Dy8udJhq3ad/2c6M7wmPWZwdFJkQ6n4c
         b+jKz/7S/xvXwsPoTOalrvmWEpCyfcmIHHBAQiFdwUG4HzcOftu7xh0b0cZcrtU8oa2m
         eNVQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <936079de-a532-543d-4fa4-00beb850af58@linaro.org>
Date: Thu, 23 Mar 2023 16:02:22 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 14/14] doc: boards: amlogic: add documentation for WeTek Hub and WeTek Play2
References: <20230323143142.780306-1-christianshewitt@gmail.com>
 <20230323143142.780306-15-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323143142.780306-15-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 15:31, Christian Hewitt wrote:
> Add build instructions for the WeTek Hub and WeTek Play2 boards.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/p200/MAINTAINERS    |   2 +
>   doc/board/amlogic/index.rst       |   2 +
>   doc/board/amlogic/wetek-hub.rst   | 110 ++++++++++++++++++++++++++++
>   doc/board/amlogic/wetek-play2.rst | 115 ++++++++++++++++++++++++++++++
>   4 files changed, 229 insertions(+)
>   create mode 100644 doc/board/amlogic/wetek-hub.rst
>   create mode 100644 doc/board/amlogic/wetek-play2.rst
> 
> diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
> index 264218e3be..fe451dd7db 100644
> --- a/board/amlogic/p200/MAINTAINERS
> +++ b/board/amlogic/p200/MAINTAINERS
> @@ -12,3 +12,5 @@ F:	configs/wetek-play2_defconfig
>   F:	doc/board/amlogic/p200.rst
>   F:	doc/board/amlogic/nanopi-k2.rst
>   F:	doc/board/amlogic/odroid-c2.rst
> +F:      doc/board/amlogic/wetek-hub.rst
> +F:      doc/board/amlogic/wetek-play2.rst
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 71b7e1f3ed..deb7976436 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -118,4 +118,6 @@ Board Documentation
>      s400
>      u200
>      wetek-core2
> +   wetek-hub
> +   wetek-play2
>      w400
> diff --git a/doc/board/amlogic/wetek-hub.rst b/doc/board/amlogic/wetek-hub.rst
> new file mode 100644
> index 0000000000..378c6a6497
> --- /dev/null
> +++ b/doc/board/amlogic/wetek-hub.rst
> @@ -0,0 +1,110 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for WeTek Hub (S905)
> +===========================
> +
> +WeTek Hub is a small form-factor Android STB manufactured by WeTek with the following
> +specification:
> +
> + - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
> + - ARM Mali 450 GPU
> + - 1GB DDR3 SDRAM
> + - 8GB eMMC
> + - Gigabit Ethernet
> + - HDMI 2.0 4K/60Hz display
> + - 1x USB otg
> + - microSD
> + - UART jack
> + - Infrared receiver
> +
> +Schematics are not publicly available but have been shared privately to maintainers.
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make wetek-hub_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh wetek-hub /path/to/u-boot/u-boot.bin my-output-dir
> +
> +U-Boot Manual Signing
> +---------------------
> +
> +Amlogic does not provide sources for the firmware and tools needed to create a bootloader
> +image and WeTek has not publicly shared the U-Boot sources needed to build FIP binaries
> +for signing. However you can download them from the amlogic-fip-repo.
> +
> +.. code-block:: bash
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip/wetek-hub
> +    $ export FIPDIR=$PWD
> +
> +Go back to the mainline U-Boot source tree then:
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/bl2.bin fip/
> +    $ cp $FIPDIR/acs.bin fip/
> +    $ cp $FIPDIR/bl21.bin fip/
> +    $ cp $FIPDIR/bl30.bin fip/
> +    $ cp $FIPDIR/bl301.bin fip/
> +    $ cp $FIPDIR/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl30.bin \
> +              fip/zero_tmp \
> +              fip/bl30_zero.bin \
> +              fip/bl301.bin \
> +              fip/bl301_zero.bin \
> +              fip/bl30_new.bin \
> +              bl30
> +
> +    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin \
> +                         --bl31 fip/bl31.img \
> +                         --bl33 fip/bl33.bin \
> +                         fip/fip.bin
> +
> +    $ sed -i 's/\x73\x02\x08\x91/\x1F\x20\x03\xD5/' fip/bl2.bin
> +    $ python3 $FIPDIR/acs_tool.py fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl2_acs.bin \
> +              fip/zero_tmp \
> +              fip/bl2_zero.bin \
> +              fip/bl21.bin \
> +              fip/bl21_zero.bin \
> +              fip/bl2_new.bin \
> +              bl2
> +
> +    $ cat fip/bl2_new.bin fip/fip.bin > fip/boot_new.bin
> +
> +    $ $FIPDIR/aml_encrypt_gxb --bootsig \
> +                              --input fip/boot_new.bin
> +                              --output fip/u-boot.bin
> +
> +Then write U-Boot to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 conv=fsync
> +    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 seek=9 skip=8 count=87 conv=fsync,notrunc
> +    $ dd if=/dev/zero of=fip/u-boot.bin.gxbb bs=512 seek=8 count=1 conv=fsync,notrunc
> +    $ dd if=bl1.bin.hardkernel of=fip/u-boot.bin.gxbb bs=512 seek=2 skip=2 count=1 conv=fsync,notrunc
> +    $ ./aml_chksum fip/u-boot.bin.gxbb
> +    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=1 count=440
> diff --git a/doc/board/amlogic/wetek-play2.rst b/doc/board/amlogic/wetek-play2.rst
> new file mode 100644
> index 0000000000..cd7759f7f4
> --- /dev/null
> +++ b/doc/board/amlogic/wetek-play2.rst
> @@ -0,0 +1,115 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for WeTek Play2 (S905)
> +=============================
> +
> +WeTek Play2 is an Android STB manufactured by WeTek with the following specification:
> +
> + - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
> + - ARM Mali 450 GPU
> + - 2GB DDR3 SDRAM
> + - 8GB eMMC
> + - Gigabit Ethernet
> + - AP6335 (v1) or AP6255 (v2) WiFi (b/g/n) and BT 4.0
> + - HDMI 2.0 4K/60Hz display
> + - 2x USB 2.0 host
> + - 1x USB 2.0 otg
> + - microSD
> + - UART jack
> + - Infrared receiver
> + - Power LED (blue)
> + - Power button (case, front)
> + - Reset button (underside)
> + - DVB Card: DVB-S or DVB-T/C or ATSC
> +
> +Schematics are not publicly available but have been shared privately to maintainers.
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make wetek-play2_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh wetek-play2 /path/to/u-boot/u-boot.bin my-output-dir
> +
> +U-Boot Manual Signing
> +---------------------
> +
> +Amlogic does not provide sources for the firmware and tools needed to create a bootloader
> +image and WeTek has not publicly shared the U-Boot sources needed to build FIP binaries
> +for signing. However you can download them from the amlogic-fip-repo.
> +
> +.. code-block:: bash
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip/wetek-play2
> +    $ export FIPDIR=$PWD
> +
> +Go back to the mainline U-Boot source tree then:
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
> +
> +    $ cp $FIPDIR/bl2.bin fip/
> +    $ cp $FIPDIR/acs.bin fip/
> +    $ cp $FIPDIR/bl21.bin fip/
> +    $ cp $FIPDIR/bl30.bin fip/
> +    $ cp $FIPDIR/bl301.bin fip/
> +    $ cp $FIPDIR/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl30.bin \
> +              fip/zero_tmp \
> +              fip/bl30_zero.bin \
> +              fip/bl301.bin \
> +              fip/bl301_zero.bin \
> +              fip/bl30_new.bin \
> +              bl30
> +
> +    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin \
> +                         --bl31 fip/bl31.img \
> +                         --bl33 fip/bl33.bin \
> +                         fip/fip.bin
> +
> +    $ sed -i 's/\x73\x02\x08\x91/\x1F\x20\x03\xD5/' fip/bl2.bin
> +    $ python3 $FIPDIR/acs_tool.py fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl2_acs.bin \
> +              fip/zero_tmp \
> +              fip/bl2_zero.bin \
> +              fip/bl21.bin \
> +              fip/bl21_zero.bin \
> +              fip/bl2_new.bin \
> +              bl2
> +
> +    $ cat fip/bl2_new.bin fip/fip.bin > fip/boot_new.bin
> +
> +    $ $FIPDIR/aml_encrypt_gxb --bootsig \
> +                              --input fip/boot_new.bin
> +                              --output fip/u-boot.bin
> +
> +Then write U-Boot to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 conv=fsync
> +    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 seek=9 skip=8 count=87 conv=fsync,notrunc
> +    $ dd if=/dev/zero of=fip/u-boot.bin.gxbb bs=512 seek=8 count=1 conv=fsync,notrunc
> +    $ dd if=bl1.bin.hardkernel of=fip/u-boot.bin.gxbb bs=512 seek=2 skip=2 count=1 conv=fsync,notrunc
> +    $ ./aml_chksum fip/u-boot.bin.gxbb
> +    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=1 count=440

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
