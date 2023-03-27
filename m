Received: from knopi.disroot.org (knopi.disroot.org [178.21.23.139])
 by mx.groups.io with SMTP id smtpd.web10.41145.1679935836473810787
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 09:50:36 -0700
Message-ID: <3ccce46e-d8f1-9456-3875-b65547460c7e@getgoogleoff.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=getgoogleoff.me;
	s=mail; t=1679935833;
	bh=kOzY/iJluTxvwoPrQDmPaccAPSyyp7qOtXWmgIuU0qg=;
	h=Date:To:Cc:From:Subject;
	b=WfIn5p0xdUztmuH2PKN0aiLJ1oXclrjjlALxTdO0RZ2IPuLMiwdpG09SP4kl5PEii
	 lolzdg2b/Gil0Uyklqw8L9k7O6teumUUJuorwdT8bxVjLR6Z0A5ydKc1nqcFvw777F
	 dYKt6ua/VwguHsPec4fVU9s7WKWxGzAp3qV0h7Nz8wsFG7fhAbDJeI2A6rQc36O401
	 Flf0XHQTVI0z0mQchOKSTHyVEnJwvMxlKcmBtcV5xpk0EXNQOINm3IqCuhHhsGIWK3
	 jwWQX7oNlDC+hBA0HYMTNF2j7ggzklkoWyEGqBSLXacYcARQrkXCigc9P94gu5LHfZ
	 VBBJ8Avt25nhg==
Date: Tue, 28 Mar 2023 04:03:47 +0800
MIME-Version: 1.0
From: exkc <exxxxkc@getgoogleoff.me>
Subject: [PATCHv7 3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add build instructions for the Beelink GT1 Ultimate board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
 =C2=A0board/amlogic/q200/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
 =C2=A0doc/board/amlogic/beelink-gt1-ultimate.rst | 110 +++++++++++++++++++=
++
 =C2=A02 files changed, 112 insertions(+)
 =C2=A0create mode 100644 doc/board/amlogic/beelink-gt1-ultimate.rst

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINER=
S
index 9c84cca27e..aece8d5e05 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -4,9 +4,11 @@ S:=C2=A0=C2=A0 =C2=A0Maintained
 =C2=A0L:=C2=A0=C2=A0 =C2=A0u-boot-amlogic@groups.io
 =C2=A0F:=C2=A0=C2=A0 =C2=A0board/amlogic/q200/
 =C2=A0F:=C2=A0=C2=A0 =C2=A0include/configs/q200.h
+F:=C2=A0=C2=A0 =C2=A0configs/beelink-gt1-ultimate_defconfig
 =C2=A0F:=C2=A0=C2=A0 =C2=A0configs/khadas-vim2_defconfig
 =C2=A0F:=C2=A0=C2=A0 =C2=A0configs/libretech-s905d-pc_defconfig
 =C2=A0F:=C2=A0=C2=A0 =C2=A0configs/libretech-s912-pc_defconfig
 =C2=A0F:=C2=A0=C2=A0 =C2=A0configs/wetek-core2_defconfig
+F:=C2=A0=C2=A0 =C2=A0doc/board/amlogic/beelink-gt1-ultimate.rst
 =C2=A0F:=C2=A0=C2=A0 =C2=A0doc/board/amlogic/khadas-vim2.rst
 =C2=A0F:=C2=A0=C2=A0 =C2=A0doc/board/amlogic/wetek-core2.rst
diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst=20
b/doc/board/amlogic/beelink-gt1-ultimate.rst
new file mode 100644
index 0000000000..42779495df
--- /dev/null
+++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT1 Ultimate (S912)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Beelink GT1 Ultimate is an Android STB manufactured by Shenzen AZW=20
(Beelink) with the
+following specification:
+
+- 2GB or 3GB DDR3 RAM
+- 32GB eMMC
+- HDMI 2.1 video
+- S/PDIF optical output
+- 10/100/1000 Ethernet
+- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.2)
+- 3x USB 2.0 ports
+- IR receiver
+- 1x micro SD card slot
+- 1x Power LED (white)
+- 1x Reset button (internal)
+
+The GT1 (non-ultimate) board has QCA9377 WiFi/BT but is otherwise=20
identical and should
+be capable of booting images prepared for the Ultimate box (NB: there=20
are known clones
+of both boxes which may differ in specifications).
+
+Beelink do not provide public schematics, but have been willing to=20
share them with known
+distro developers on request.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+=C2=A0=C2=A0=C2=A0 $ export CROSS_COMPILE=3Daarch64-none-elf-
+=C2=A0=C2=A0=C2=A0 $ make beelink-gt1-ultimate_defconfig
+=C2=A0=C2=A0=C2=A0 $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+
+=C2=A0=C2=A0=C2=A0 $ git clone https://github.com/LibreELEC/amlogic-boot-f=
ip --depth=3D1
+=C2=A0=C2=A0=C2=A0 $ cd amlogic-boot-fip
+=C2=A0=C2=A0=C2=A0 $ mkdir my-output-dir
+=C2=A0=C2=A0=C2=A0 $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin=
 my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide firmware sources or tools needed to create the=20
bootloader image
+and Beelink has not publicly shared the U-Boot sources needed to build=20
the FIP binaries
+for signing. However you can download them from the amlogic-fip-repo.
+
+.. code-block:: bash
+
+=C2=A0=C2=A0=C2=A0 $ git clone https://github.com/LibreELEC/amlogic-boot-f=
ip --depth=3D1
+=C2=A0=C2=A0=C2=A0 $ cd amlogic-boot-fip/beelink-gt1
+=C2=A0=C2=A0=C2=A0 $ export FIPDIR=3D$PWD
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+=C2=A0=C2=A0=C2=A0 $ mkdir fip
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/bl2.bin fip/
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/acs.bin fip/
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/bl21.bin fip/
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/bl30.bin fip/
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/bl301.bin fip/
+=C2=A0=C2=A0=C2=A0 $ cp $FIPDIR/bl31.img fip/
+=C2=A0=C2=A0=C2=A0 $ cp u-boot.bin fip/bl33.bin
+
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/blx_fix.sh \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl30.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/zero_tmp \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl30_zero.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl301.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl301_zero.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl30_new.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bl30
+
+=C2=A0=C2=A0=C2=A0 $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.b=
in fip/acs.bin 0
+
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/blx_fix.sh \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl2_acs.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/zero_tmp \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl2_zero.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl21.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl21_zero.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fip/bl2_new.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bl2
+
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new=
.bin
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.=
bin --output=20
fip/bl2.n.bin.sig
+=C2=A0=C2=A0=C2=A0 $ $FIPDIR/aml_encrypt_gxl --bootmk \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 --output fip/u-boot.bin \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bl2 fip/bl2.n.bin.sig \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bl30 fip/bl30_new.bin.enc \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bl31 fip/bl31.img.enc \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bl33 fip/bl33.bin.enc
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+=C2=A0=C2=A0=C2=A0 $ DEV=3D/dev/boot_device
+=C2=A0=C2=A0=C2=A0 $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,=
notrunc bs=3D512=20
skip=3D1 seek=3D1
+=C2=A0=C2=A0=C2=A0 $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,=
notrunc bs=3D1 count=3D440
--=20
2.40.0
