Subject: [PATCHv2 3/3] ARM: meson: Add initial support for beelink gt1
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Wed, 22 Mar 2023 12:21:18 -0700
Message-ID: <jVsb.1679512878745007811.ZQlP@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add initial support for beelink gt1

Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>

---

This patch is base on this patch from in pm os .

https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-boo=
t-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch

---

 .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
 arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
 board/amlogic/q200/MAINTAINERS                |  2 +
 configs/beelink_gt1_ultimate_defconfig        | 85 +++++++++++++++++
 doc/board/amlogic/beelink-gt1.rst             | 65 +++++++++++++
 doc/board/amlogic/index.rst                   |  3 +-
 6 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
 create mode 100644 configs/beelink_gt1_ultimate_defconfig
 create mode 100644 doc/board/amlogic/beelink-gt1.rst

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINER=
S
index 9c84cca27e85..46beffe17feb 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -4,9 +4,11 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
 F:	include/configs/q200.h
+F:	configs/beelink-gt1_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
 F:	configs/libretech-s912-pc_defconfig
 F:	configs/wetek-core2_defconfig
+F:	doc/board/amlogic/beelink-gt1.rst
 F:	doc/board/amlogic/khadas-vim2.rst
 F:	doc/board/amlogic/wetek-core2.rst
diff --git a/doc/board/amlogic/beelink-gt1.rst b/doc/board/amlogic/beelink-=
gt1.rst
new file mode 100644
index 000000000000..dca7165933b5
--- /dev/null
+++ b/doc/board/amlogic/beelink-gt1.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT1/GT1-Ultimate
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Shenzen AZW (Beelink) GT1 and GT1-Ultimate are based on the Amlogic
+Q200 reference board with an S912 chip.
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
+Beelink do not provide public schematics, but have been willing
+to share them with known distro developers on request.
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=3Daarch64-none-elf-
+    $ make beelink_gt1_ultimate_defconfig
+    $ make
+
+Image creation
+--------------
+
+Amlogic does not provide sources for the firmware and for tools needed
+to create the bootloader image. Beelink have provided the Amlogic SDK
+u-boot sources to known distro developers on-request, allowing FIPs to
+be generated. The GT1 (2GB) and GT1-Ultimate (3GB) models differ in=20
+RAM size and original Beelink devices use the same spec RAM chips and
+can share the same boot FIPs:
+
+https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-gt1
+
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with coden=
ame `beelink-gt1`
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip
+    $ mkdir ./fip
+    $ ./build-fip.sh beelink-gt1 ../u-boot.bin ./fip
+
+This will generate:
+
+.. code-block:: bash
+
+    $ u-boot.bin u-boot.bin.sd.bin u-boot.bin.usb.bl2 u-boot.bin.usb.tpl
+
+And then write the image to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=3D/dev/your_sd_device
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D51=
2 skip=3D1 seek=3D1
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D1 =
count=3D440
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index f945f672ddb0..6013588e8aa7 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -18,7 +18,7 @@ This matrix concerns the actual source code version.
 | Boards                        | Odroid-C2 | P212            | Khadas VIM=
2  | S400        | U200       | Odroid-N2   | SEI610       |
 |                               | Nanopi-K2 | Khadas-VIM      | Libretech-=
PC | JetHub J100 | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
 |                               | P200      | LibreTech-CC v1 | WeTek Core=
2  |             | Radxa Zero | GT-King/Pro | Odroid-C4    |
-|                               | P201      | LibreTech-AC v2 |           =
   |             |            | GSKing-X    | Odroid-HC4   |
+|                               | P201      | LibreTech-AC v2 | Beelink GT=
1  |             |            | GSKing-X    | Odroid-HC4   |
 |                               |           | JetHub J80      |           =
   |             |            | Odroid-Go-  | BananaPi-M5  |
 |                               |           |                 |           =
   |             |            | Ultra       |              |
 |                               |           |                 |           =
   |             |            | Odroid-N2L  |              |
@@ -95,6 +95,7 @@ Board Documentation
=20
    beelink-gtking
    beelink-gtkingpro
+   beelink-gt1
    jethub-j100
    jethub-j80
    khadas-vim2
--=20
2.39.1
