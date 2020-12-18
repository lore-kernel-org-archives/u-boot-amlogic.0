Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.7105.1608281159500517698
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 00:45:59 -0800
Received: by mail-wm1-f47.google.com with SMTP id 190so1532707wmz.0
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=thQ1R8dKB62JvkRRxk7WM2fZWynKL+qHRU9jjxKd5s4=;
        b=qzheN53i5WF0H2wqyWfIYMZUahcLOdohNusLC4uzVzcQli+OPxLF9AhG8B+1x9quZG
         JwQ+JAI4Z4F5D2OxrFA6XfVbMCUMmHD6dLIxLteAgHk9gahAC5efvICoAsgALu8K5zf/
         18CEVG7DOk6cCZiN+eg1HCw3tn0YCBjZv2rEvp0gCcLNueSzHhyOwtDDuLQ3N0NVyHI3
         u81MyMKQNooFTdN0x1pIWz4OcBcFzUFiKElZCl0a4w07CrhuAbVMGDNRRDvlUE254UHN
         FoyPpL1YOE7YO9qzUBeOJhHAXqqYt33hb9NA7dJSjjj4FZxXMGOwQC9DFVy1anFZ2uPT
         bmDQ==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 5/5] boards: amlogic: update documentation for Beelink GT-King/Pro
Date: Fri, 18 Dec 2020 08:45:45 +0000
Message-Id: <20201218084545.29135-6-christianshewitt@gmail.com>
In-Reply-To: <20201218084545.29135-1-christianshewitt@gmail.com>
References: <20201218084545.29135-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Update the device matrix and add build instructions.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/beelink-gtking.rst    | 115 +++++++++++++++++++++++
 doc/board/amlogic/beelink-gtkingpro.rst | 116 ++++++++++++++++++++++++
 doc/board/amlogic/index.rst             |   4 +-
 3 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/amlogic/beelink-gtking.rst
 create mode 100644 doc/board/amlogic/beelink-gtkingpro.rst

diff --git a/doc/board/amlogic/beelink-gtking.rst b/doc/board/amlogic/beelink-gtking.rst
new file mode 100644
index 0000000000..56ce2cb273
--- /dev/null
+++ b/doc/board/amlogic/beelink-gtking.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT-King
+==========================
+
+The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
+board with an S922X-H chip.
+
+- 4GB LPDDR4 RAM
+- 64GB eMMC storage
+- 10/100/1000 Base-T Ethernet
+- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
+- HDMI 2.1 video
+- S/PDIF optical output
+- Analogue audio output
+- 1x USB 2.0 port
+- 2x USB 3.0 ports
+- IR receiver
+- 1x micro SD card slot
+
+Beelink do not provide public schematics, but have been willing
+to share them with known distro developers on request.
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make beelink-gtking_defconfig
+    $ make
+
+Image creation
+--------------
+
+Amlogic does not provide sources for the firmware and for tools needed
+to create the bootloader image. Beelink have provided the Amlogic "SDK"
+in their forums, but the u-boot sources included result in 2GB RAM being
+detected. The following FIPs were generated with newer private sources
+and give correct (4GB) RAM detection:
+
+https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
+
+NB: Beelink use a common board config for GT-King, GT-King Pro and the
+GS-King-X model, hence the "beelink-s922x" name.
+
+.. code-block:: bash
+
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/archive/master.zip
+    $ unzip master.zip
+    $ export FIPDIR=$PWD/amlogic-boot-fip/beelink-s922x
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+    $ cp $FIPDIR/* fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ sh fip/blx_fix.sh \
+    	fip/bl30.bin \
+    	fip/zero_tmp \
+    	fip/bl30_zero.bin \
+    	fip/bl301.bin \
+    	fip/bl301_zero.bin \
+    	fip/bl30_new.bin \
+    	bl30
+
+    $ sh fip/blx_fix.sh \
+    	fip/bl2.bin \
+    	fip/zero_tmp \
+    	fip/bl2_zero.bin \
+    	fip/acs.bin \
+    	fip/bl21_zero.bin \
+    	fip/bl2_new.bin \
+    	bl2
+
+    $ fip/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
+    				--output fip/bl30_new.bin.g12a.enc \
+    				--level v3
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
+    				--output fip/bl30_new.bin.enc \
+    				--level v3 --type bl30
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+    				--output fip/bl31.img.enc \
+    				--level v3 --type bl31
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
+    				--output fip/bl33.bin.enc \
+    				--level v3 --type bl33
+    $ fip/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
+    				--output fip/bl2.n.bin.sig
+    $ fip/aml_encrypt_g12b --bootmk \
+    		--output fip/u-boot.bin \
+    		--bl2 fip/bl2.n.bin.sig \
+    		--bl30 fip/bl30_new.bin.enc \
+    		--bl31 fip/bl31.img.enc \
+    		--bl33 fip/bl33.bin.enc \
+    		--ddrfw1 fip/ddr4_1d.fw \
+    		--ddrfw2 fip/ddr4_2d.fw \
+    		--ddrfw3 fip/ddr3_1d.fw \
+    		--ddrfw4 fip/piei.fw \
+    		--ddrfw5 fip/lpddr4_1d.fw \
+    		--ddrfw6 fip/lpddr4_2d.fw \
+    		--ddrfw7 fip/diag_lpddr4.fw \
+    		--ddrfw8 fip/aml_ddr.fw \
+    		--level v3
+
+and then write the image to SD with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/your_sd_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/doc/board/amlogic/beelink-gtkingpro.rst b/doc/board/amlogic/beelink-gtkingpro.rst
new file mode 100644
index 0000000000..d750351361
--- /dev/null
+++ b/doc/board/amlogic/beelink-gtkingpro.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT-King Pro
+==============================
+
+The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
+board with an S922X-H chip.
+
+- 4GB LPDDR4 RAM
+- 64GB eMMC storage
+- 10/100/1000 Base-T Ethernet
+- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
+- HDMI 2.1 video
+- Analogue audio output
+- 1x RS232 port
+- 2x USB 2.0 port
+- 2x USB 3.0 ports
+- IR receiver
+- 1x SD card slot
+- 1x Power on/off button
+
+Beelink do not provide public schematics, but have been willing
+to share them with known distro developers on request.
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make beelink-gtkingpro_defconfig
+    $ make
+
+Image creation
+--------------
+
+Amlogic does not provide sources for the firmware and for tools needed
+to create the bootloader image. Beelink have provided the Amlogic "SDK"
+in their forums, but the u-boot sources included result in 2GB RAM being
+detected. The following FIPs were generated with newer private sources
+and give correct (4GB) RAM detection:
+
+https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
+
+NB: Beelink use a common board config for GT-King, GT-King Pro and the
+GS-King-X model, hence the "beelink-s922x" name.
+
+.. code-block:: bash
+
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/archive/master.zip
+    $ unzip master.zip
+    $ export FIPDIR=$PWD/amlogic-boot-fip/beelink-s922x
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+    $ cp $FIPDIR/* fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ sh fip/blx_fix.sh \
+    	fip/bl30.bin \
+    	fip/zero_tmp \
+    	fip/bl30_zero.bin \
+    	fip/bl301.bin \
+    	fip/bl301_zero.bin \
+    	fip/bl30_new.bin \
+    	bl30
+
+    $ sh fip/blx_fix.sh \
+    	fip/bl2.bin \
+    	fip/zero_tmp \
+    	fip/bl2_zero.bin \
+    	fip/acs.bin \
+    	fip/bl21_zero.bin \
+    	fip/bl2_new.bin \
+    	bl2
+
+    $ fip/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
+    				--output fip/bl30_new.bin.g12a.enc \
+    				--level v3
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
+    				--output fip/bl30_new.bin.enc \
+    				--level v3 --type bl30
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+    				--output fip/bl31.img.enc \
+    				--level v3 --type bl31
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
+    				--output fip/bl33.bin.enc \
+    				--level v3 --type bl33
+    $ fip/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
+    				--output fip/bl2.n.bin.sig
+    $ fip/aml_encrypt_g12b --bootmk \
+    		--output fip/u-boot.bin \
+    		--bl2 fip/bl2.n.bin.sig \
+    		--bl30 fip/bl30_new.bin.enc \
+    		--bl31 fip/bl31.img.enc \
+    		--bl33 fip/bl33.bin.enc \
+    		--ddrfw1 fip/ddr4_1d.fw \
+    		--ddrfw2 fip/ddr4_2d.fw \
+    		--ddrfw3 fip/ddr3_1d.fw \
+    		--ddrfw4 fip/piei.fw \
+    		--ddrfw5 fip/lpddr4_1d.fw \
+    		--ddrfw6 fip/lpddr4_2d.fw \
+    		--ddrfw7 fip/diag_lpddr4.fw \
+    		--ddrfw8 fip/aml_ddr.fw \
+    		--level v3
+
+and then write the image to SD with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/your_sd_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index a585d857df..275c3664b7 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -17,7 +17,7 @@ This matrix concerns the actual source code version.
 +===============================+===========+=================+==============+============+============+=============+==============+
 | Boards                       	| Odroid-C2 | P212            | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
 |        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
-|        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            |	     | Odroid-C4    |
+|        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            | GT-King/Pro | Odroid-C4    |
 |        			| P201	    | LibreTech-AC v2 |	             |	          |            |             |              |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | UART                       	| **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
@@ -77,6 +77,8 @@ Board Documentation
 .. toctree::
    :maxdepth: 1
 
+   beelink-gtking
+   beelink-gtkingpro
    khadas-vim2
    khadas-vim3l
    khadas-vim3
-- 
2.17.1

