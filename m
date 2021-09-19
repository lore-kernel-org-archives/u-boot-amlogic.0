Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web08.12125.1632066750339128056
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Sep 2021 08:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632066748; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fiGHo7FK6oXYowl/aCzgV7Hv1UvmrlBgcM5mWx6a1nU=;
	b=EuiIerQXNvB08iLGB1fgLPICpuMRX7dR0FCuOJv/4TwK0YVH9IutMpRFOMiZMT2rp9Wwpw
	gUQo5p5Ge5pzi2kEGb9N7lFnWstW1/PtKfQbbWRrpyM04lBmZVUuPK91pw3+p8dndAFjdX
	jYw25lertyesULslhTTDC0UhaKdgRB9AvtYFmAoUu8uO8PD9wduyAIsU7ZzXpLjKsRPbYT
	f8z9tnVBzpx1k8WLiCQpCfnQBLMVKAyMigM1qfAw3e/n3GVh35nTSGHDD3iBmVhvYD70Gq
	rnMT8IYIQbHERauq9l2nJZ3aVeXwknWClbD5VmiFFgEJzJRUZIemtF0G/ZJKtQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 3/3] ARM: amlogic: add JetHub D1/H1 docs
Date: Sun, 19 Sep 2021 18:52:16 +0300
Message-Id: <20210919155216.4000369-4-adeep@lexina.in>
In-Reply-To: <20210919155216.4000369-1-adeep@lexina.in>
References: <20210919155216.4000369-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Fix doc/board/amlogic/index.rst:
- Add S905W to S905X column.
- Add JetHub devices to the corresponding columns.
- Fix tabs to spaces for table alignment

Add doc/board/amlogic files:
- jethub-j100.rst
- jethub-j80.rst

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/index.rst       | 128 +++++++++++++++---------------
 doc/board/amlogic/jethub-j100.rst | 108 +++++++++++++++++++++++++
 doc/board/amlogic/jethub-j80.rst  |  97 ++++++++++++++++++++++
 3 files changed, 270 insertions(+), 63 deletions(-)
 create mode 100644 doc/board/amlogic/jethub-j100.rst
 create mode 100644 doc/board/amlogic/jethub-j80.rst

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 2913ab281a..c18f1b7e71 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -10,69 +10,69 @@ An up-do-date matrix is also available on: http://lin=
ux-meson.com
=20
 This matrix concerns the actual source code version.
=20
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-|                            	| S905      | S905X           | S912      =
   | A113X      | S905X2     | S922X       | S905X3       |
-|        			|	    | S805X   	      | S905D        |	          | S905D2  =
   | A311D       | S905D3       |
-|        			|	    |		      |	             |            | S905Y2     |	  =
   |              |
-+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
-| Boards                       	| Odroid-C2 | P212            | Khadas V=
IM2  | S400       | U200       | Odroid-N2   | SEI610       |
-|        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | S=
EI510     | Khadas-VIM3 | Khadas-VIM3L |
-|        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |   =
         | GT-King/Pro | Odroid-C4    |
-|        			| P201	    | LibreTech-AC v2 |	             |	          |   =
         | GSKing-X    | Odroid-HC4   |
-|                               |           |                 |         =
     |            |            |             | BananaPi-M5  |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| UART                       	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Pinctrl/GPIO               	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Clock Control              	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| PWM                        	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Reset Control              	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Infrared Decoder           	| No        | No              | No        =
   | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Ethernet                   	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Multi-core                 	| **Yes**   | **Yes**         | **Yes**   =
   | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Fuse access                	| **Yes**   | **Yes**         |**Yes**    =
   |**Yes**     |**Yes**     |**Yes**      | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| SPI (FC)                  	| **Yes**   | **Yes**         | **Yes**    =
  | **Yes**    |**Yes**     | **Yes**     | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| SPI (CC)                   	| No        | No              | No        =
   | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| I2C                       	| **Yes**   | **Yes**         | **Yes**    =
  | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| USB                       	| **Yes**   | **Yes**         | **Yes**    =
  | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| USB OTG                  	| No        | **Yes**         | **Yes**     =
 | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| eMMC                      	| **Yes**   | **Yes**         | **Yes**    =
  | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| SDCard                    	| **Yes**   | **Yes**         | **Yes**    =
  | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| NAND                      	| No        | No              | No         =
  | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| ADC                       	| **Yes**   | **Yes**         | **Yes**    =
  | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| CVBS Output                	| **Yes**   | **Yes**         | **Yes**   =
   | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| HDMI Output                	| **Yes**   | **Yes**         | **Yes**   =
   | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| CEC                        	| No        | No              | No        =
   | *N/A*      | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| Thermal Sensor             	| No        | No              | No        =
   | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| LCD/LVDS Output            	| No        | *N/A*           | No        =
   | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| MIPI DSI Output            	| *N/A*     | *N/A*           | *N/A*     =
   | No         | No         | No          | No           |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| SoC (version) information     | **Yes**   | **Yes**         | **Yes** =
     | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
-| PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*   =
     | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+-----------------+---------=
-----+------------+------------+-------------+--------------+
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+|                               | S905      | S905X           | S912    =
     | A113X       | S905X2     | S922X       | S905X3       |
+|                               |           | S805X           | S905D   =
     |             | S905D2     | A311D       | S905D3       |
+|                               |           | S905W           |         =
     |             | S905Y2     |             |              |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
+| Boards                        | Odroid-C2 | P212            | Khadas V=
IM2  | S400        | U200       | Odroid-N2   | SEI610       |
+|                               | Nanopi-K2 | Khadas-VIM      | Libretec=
h-PC | JetHub J100 | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
+|                               | P200      | LibreTech-CC v1 | WeTek Co=
re2  |             |            | GT-King/Pro | Odroid-C4    |
+|                               | P201      | LibreTech-AC v2 |         =
     |             |            | GSKing-X    | Odroid-HC4   |
+|                               |           | JetHub J80      |         =
     |             |            |             | BananaPi-M5  |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| UART                          | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Pinctrl/GPIO                  | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Clock Control                 | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| PWM                           | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Reset Control                 | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Infrared Decoder              | No        | No              | No      =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Ethernet                      | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Multi-core                    | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Fuse access                   | **Yes**   | **Yes**         |**Yes**  =
     |**Yes**      |**Yes**     |**Yes**      | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| SPI (FC)                      | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     |**Yes**     | **Yes**     | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| SPI (CC)                      | No        | No              | No      =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| I2C                           | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| USB                           | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| USB OTG                       | No        | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| eMMC                          | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| SDCard                        | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| NAND                          | No        | No              | No      =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| ADC                           | **Yes**   | **Yes**         | **Yes** =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| CVBS Output                   | **Yes**   | **Yes**         | **Yes** =
     | *N/A*       | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| HDMI Output                   | **Yes**   | **Yes**         | **Yes** =
     | *N/A*       | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| CEC                           | No        | No              | No      =
     | *N/A*       | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| Thermal Sensor                | No        | No              | No      =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| LCD/LVDS Output               | No        | *N/A*           | No      =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| MIPI DSI Output               | *N/A*     | *N/A*           | *N/A*   =
     | No          | No         | No          | No           |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| SoC (version) information     | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
+| PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*   =
     | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
=20
 Board Documentation
 -------------------
@@ -82,6 +82,8 @@ Board Documentation
=20
    beelink-gtking
    beelink-gtkingpro
+   jethub-j100
+   jethub-j80
    khadas-vim2
    khadas-vim3l
    khadas-vim3
diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub=
-j100.rst
new file mode 100644
index 0000000000..f728711c5c
--- /dev/null
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for JetHub J100
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
+controller manufactured by JetHome with the following specifications:
+
+ - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
+ - no video out
+ - 512Mb/1GB DDR3
+ - 8/16GB eMMC flash
+ - 1 x USB 2.0
+ - 1 x 10/100Mbps ethernet
+ - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE
+802.11a/b/g/n/ac, Bluetooth 4.2.
+ - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
+power and Zigbee 3.0 support.
+ - 2 x gpio LEDS
+ - GPIO user Button
+ - 1 x 1-Wire
+ - 2 x RS-485
+ - 4 x dry contact digital GPIO inputs
+ - 3 x relay GPIO outputs
+ - DC source with a voltage of 9 to 56 V / Passive POE
+ - DIN Rail Mounting case
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=3Daarch64-none-elf-
+    $ make jethub_j100_defconfig
+    $ make
+
+Image creation
+--------------
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain binaries
+from the git tree published by the board vendor:
+
+.. code-block:: bash
+
+    $ git clone https://github.com/jethome-ru/jethub-aml-tools jethub-u-=
boot
+    $ cd jethub-u-boot
+    $ export FIPDIR=3D$PWD
+
+Go back to mainline U-boot source tree then :
+
+.. code-block:: bash
+
+    $ mkdir fip
+
+    $ cp $FIPDIR/j100/bl2.bin fip/
+    $ cp $FIPDIR/j100/acs.bin fip/
+    $ cp $FIPDIR/j100/bl21.bin fip/
+    $ cp $FIPDIR/j100/bl30.bin fip/
+    $ cp $FIPDIR/j100/bl301.bin fip/
+    $ cp $FIPDIR/j100/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl30.bin \
+        fip/zero_tmp \
+        fip/bl30_zero.bin \
+        fip/bl301.bin \
+        fip/bl301_zero.bin \
+        fip/bl30_new.bin \
+        bl30
+
+    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl2_acs.bin \
+        fip/zero_tmp \
+        fip/bl2_zero.bin \
+        fip/bl21.bin \
+        fip/bl21_zero.bin \
+        fip/bl2_new.bin \
+        bl2
+
+    $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl30_new.bin \
+                                        --output fip/bl30_new.bin.enc \
+                                        --level v3 --type bl30
+    $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl31.img \
+                                        --output fip/bl31.img.enc \
+                                        --level v3 --type bl31
+    $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl33.bin --compr=
ess lz4 \
+                                        --output fip/bl33.bin.enc \
+                                        --level v3 --type bl33
+    $ $FIPDIR/j100/aml_encrypt_axg --bl2sig --input fip/bl2_new.bin \
+                                        --output fip/bl2.n.bin.sig
+    $ $FIPDIR/j100/aml_encrypt_axg --bootmk \
+                --output fip/u-boot.bin \
+                --bl2 fip/bl2.n.bin.sig \
+                --bl30 fip/bl30_new.bin.enc \
+                --bl31 fip/bl31.img.enc \
+                --bl33 fip/bl33.bin.enc --level v3
+
+and then write the image to eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=3D/dev/your_emmc_device
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
512 skip=3D1 seek=3D1
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
1 count=3D444
diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-=
j80.rst
new file mode 100644
index 0000000000..75a2136b20
--- /dev/null
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for JetHub J80
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation
+controller manufactured by JetHome with the following specifications:
+
+ - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
+ - No video out
+ - 1GB DDR3
+ - 8/16GB eMMC flash
+ - 2 x USB 2.0
+ - 1 x 10/100Mbps ethernet
+ - SDIO WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
+ - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
+power and Zigbee 3.0 support.
+ - MicroSD 2.x/3.x/4.x DS/HS cards.
+ - 1 x gpio LED
+ - ADC user Button
+ - DC source 5V microUSB
+ - Square plastic case
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=3Daarch64-none-elf-
+    $ make jethub_j80_defconfig
+    $ make
+
+Image creation
+--------------
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain binaries
+from the git tree published by the board vendor:
+
+.. code-block:: bash
+
+    $ git clone https://github.com/jethome-ru/jethub-aml-tools jethub-u-=
boot
+    $ cd jethub-u-boot
+    $ export FIPDIR=3D$PWD
+
+Go back to mainline U-Boot source tree then :
+
+.. code-block:: bash
+
+    $ mkdir fip
+
+    $ cp $FIPDIR/j80/bl2.bin fip/
+    $ cp $FIPDIR/j80/acs.bin fip/
+    $ cp $FIPDIR/j80/bl21.bin fip/
+    $ cp $FIPDIR/j80/bl30.bin fip/
+    $ cp $FIPDIR/j80/bl301.bin fip/
+    $ cp $FIPDIR/j80/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl30.bin \
+        fip/zero_tmp \
+        fip/bl30_zero.bin \
+        fip/bl301.bin \
+        fip/bl301_zero.bin \
+        fip/bl30_new.bin \
+        bl30
+
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bi=
n 0
+
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl2_acs.bin \
+        fip/zero_tmp \
+        fip/bl2_zero.bin \
+        fip/bl21.bin \
+        fip/bl21_zero.bin \
+        fip/bl2_new.bin \
+        bl2
+
+    $ $FIPDIR/j80/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+    $ $FIPDIR/j80/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+    $ $FIPDIR/j80/aml_encrypt_gxl --bl3enc --input fip/bl33.bin --compre=
ss lz4
+    $ $FIPDIR/j80/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --out=
put fip/bl2.n.bin.sig
+    $ $FIPDIR/j80/aml_encrypt_gxl --bootmk \
+                --output fip/u-boot.bin \
+                --bl2 fip/bl2.n.bin.sig \
+                --bl30 fip/bl30_new.bin.enc \
+                --bl31 fip/bl31.img.enc \
+                --bl33 fip/bl33.bin.enc
+
+and then write the image to SD/eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=3D/dev/your_sd_device
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
512 skip=3D1 seek=3D1
+    $ dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D=
1 count=3D444
--=20
2.30.2

