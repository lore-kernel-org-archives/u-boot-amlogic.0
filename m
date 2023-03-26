Subject: [PATCHv4 3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Sun, 26 Mar 2023 05:44:49 -0700
Message-ID: <LZnU.1679834689060423329.KDvX@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add build instructions for the Beelink GT1 Ultimate board.

Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>
---
 board/amlogic/q200/MAINTAINERS             |   2 +
 doc/board/amlogic/beelink-gt1-ultimate.rst | 110 +++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 doc/board/amlogic/beelink-gt1-ultimate.rst

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINER=
S
index 9c84cca27e..aece8d5e05 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -4,9 +4,11 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
 F:	include/configs/q200.h
+F:	configs/beelink-gt1-ultimate_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
 F:	configs/libretech-s912-pc_defconfig
 F:	configs/wetek-core2_defconfig
+F:	doc/board/amlogic/beelink-gt1-ultimate.rst
 F:	doc/board/amlogic/khadas-vim2.rst
 F:	doc/board/amlogic/wetek-core2.rst
diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlogic=
/beelink-gt1-ultimate.rst
new file mode 100644
index 0000000000..5161bdb609
--- /dev/null
+++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT1 Ultimate (S912)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Beelink GT1 Ultimate is an Android STB manufactured by Shenzen AZW (Beelin=
k) with the
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
+The GT1 (non-ultimate) board has QCA9377 WiFi/BT but is otherwise identica=
l and should
+be capable of booting images prepared for the Ultimate box (NB: there are =
known clones
+of both boxes which may differ in specifications).
+
+Beelink do not provide public schematics, but have been willing to share t=
hem with known
+distro developers on request.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=3Daarch64-none-elf-
+    $ make beelink-gt1-ultimate_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=3D1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide firmware sources or tools needed to create the bo=
otloader image
+and Beelink has not publicly shared the U-Boot sources needed to build the=
 FIP binaries
+for signing. However you can download them from the amlogic-fip-repo.
+
+.. code-block:: bash
+  =20
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=3D1
+    $ cd amlogic-boot-fip/beelink-gt1
+    $ export FIPDIR=3D$PWD
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+    $ cp $FIPDIR/bl2.bin fip/
+    $ cp $FIPDIR/acs.bin fip/
+    $ cp $FIPDIR/bl21.bin fip/
+    $ cp $FIPDIR/bl30.bin fip/
+    $ cp $FIPDIR/bl301.bin fip/
+    $ cp $FIPDIR/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
+
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin =
0
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
+
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fi=
p/bl2.n.bin.sig
+    $ $FIPDIR/aml_encrypt_gxl --bootmk \
+                              --output fip/u-boot.bin \
+                              --bl2 fip/bl2.n.bin.sig \
+                              --bl30 fip/bl30_new.bin.enc \
+                              --bl31 fip/bl31.img.enc \
+                              --bl33 fip/bl33.bin.enc
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=3D/dev/boot_device
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D51=
2 skip=3D1 seek=3D1
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D1 =
count=3D440
--=20
2.39.2
