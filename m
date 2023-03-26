Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.4305.1679807585129994974
 for <u-boot-amlogic@groups.io>;
 Sat, 25 Mar 2023 22:13:05 -0700
Received: by mail-wm1-f52.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3221162wmo.0
        for <u-boot-amlogic@groups.io>; Sat, 25 Mar 2023 22:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679807583;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5u+Evob4jQzo7T/m8RKC16Icq18EKWJ689zZ63Y7uMQ=;
        b=DPDQazzeZT/P6G0pB3ffufhtmXcmQRwfyUwC3bbCx3PN4WQG6kGucpC1fD2gQNu7UK
         VkyM4JpwRqeK4h9Y05T//NLorO/B04i3aFrdi7HkM2iQUB9eDQj6PNf/Mx5wqsgMdITo
         6hEbszvSur3k4IYh0zgRH8G+FuaYytU6adhSgbqMb0vB6Oe0Ws/ss52k2BKtOwfKBd/i
         6cMvoNIak+EXR+X1AiMRC9pHXoe6GdflrMDnc2jofSQL4yXgyQcxROW5VATK5Jz3KQIw
         uDbrB51vp3NTx/LlR5h8iOHsL/Tsn9J1GeU4Q6Tya22zw8XmEBjl+HVZZaU4iVbLta9G
         NQQQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCHv3 3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
Date: Sun, 26 Mar 2023 09:13:00 +0400
References: <VmFj.1679807446518599359.Etqf@groups.io>
In-Reply-To: <VmFj.1679807446518599359.Etqf@groups.io>
Message-Id: <E5B061AF-2BFA-4402-9832-19B257EFB7D5@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, exkc_maillist@list.ru
List-ID: <u-boot-amlogic@groups.io>

> On 26 Mar 2023, at 9:10 am, exkc_maillist via groups.io <exkc_maillist=3D=
list.ru@groups.io> wrote:
>=20
> Add build instructions for the Beelink GT1 Ultimate board.
>=20
> Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>
> ---
> board/amlogic/q200/MAINTAINERS             |   2 +
> doc/board/amlogic/beelink-gt1-ultimate.rst | 109 +++++++++++++++++++++
> 2 files changed, 111 insertions(+)
> create mode 100644 doc/board/amlogic/beelink-gt1-ultimate.rst
>=20
> diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAIN=
ERS
> index 9c84cca27e..aece8d5e05 100644
> --- a/board/amlogic/q200/MAINTAINERS
> +++ b/board/amlogic/q200/MAINTAINERS
> @@ -4,9 +4,11 @@ S:	Maintained
> L:	u-boot-amlogic@groups.io
> F:	board/amlogic/q200/
> F:	include/configs/q200.h
> +F:	configs/beelink-gt1-ultimate_defconfig
> F:	configs/khadas-vim2_defconfig
> F:	configs/libretech-s905d-pc_defconfig
> F:	configs/libretech-s912-pc_defconfig
> F:	configs/wetek-core2_defconfig
> +F:	doc/board/amlogic/beelink-gt1-ultimate.rst
> F:	doc/board/amlogic/khadas-vim2.rst
> F:	doc/board/amlogic/wetek-core2.rst
> diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlog=
ic/beelink-gt1-ultimate.rst
> new file mode 100644
> index 0000000000..487b922650
> --- /dev/null
> +++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Beelink GT1 Ultimate (S912)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Beelink GT1 Ultimate is an Android STB manufactured by Shenzen AZW (Beel=
ink) with the
> +following specification:
> +
> +- 2GB or 3GB DDR3 RAM
> +- 32GB eMMC
> +- HDMI 2.1 video
> +- S/PDIF optical output
> +- 10/100/1000 Ethernet
> +- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.2)
> +- 3x USB 2.0 ports
> +- IR receiver
> +- 1x micro SD card slot
> +- 1x Power LED (white)
> +- 1x Reset button (internal)
> +
> +The GT1 (non-ultimate) board has QCA9377 WiFi/BT but is otherwise identi=
cal and should
> +be capable of booting images prepared for the Ultimate box (NB: there ar=
e known clones
> +of both boxes which may differ in specifications).
> +
> +Beelink do not provide public schematics, but have been willing to share=
 them with known
> +distro developers on request.
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=3Daarch64-none-elf-
> +    $ make beelink-gt1-ultimate_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=3D=
1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-di=
r
> +
> +U-Boot Manual Signing
> +---------------------
> +
> +Amlogic does not provide firmware sources or tools needed to create the =
bootloader image
> +and Beelink has not publicly shared the U-Boot sources needed to build t=
he FIP binaries
> +for signing. However you can download them from the amlogic-fip-repo.
> +
> +.. code-block:: bash

=3D> line space is needed here

> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=3D=
1
> +    $ cd amlogic-boot-fip/beelink-gt1
> +    $ export FIPDIR=3D$PWD
> +
> +Go back to the mainline U-Boot source tree then:
> +
> +.. code-block:: bash
> +
> +    $ mkdir fip
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
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bi=
n 0
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
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output =
fip/bl2.n.bin.sig
> +    $ $FIPDIR/aml_encrypt_gxl --bootmk \
> +                              --output fip/u-boot.bin \
> +                              --bl2 fip/bl2.n.bin.sig \
> +                              --bl30 fip/bl30_new.bin.enc \
> +                              --bl31 fip/bl31.img.enc \
> +                              --bl33 fip/bl33.bin.enc
> +
> +Then write U-Boot to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=3D/dev/boot_device
> +    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
512 skip=3D1 seek=3D1
> +    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
1 count=3D440
> --=20
> 2.39.2
>=20
>=20
>=20
>=20
>=20

