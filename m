Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.11705.1679312788537430076
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:58 -0700
Received: by mail-wr1-f48.google.com with SMTP id i9so10047664wrp.3
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bugdDMHDRSrJ0SoWYmfBOUKMC6hXV0hF4DSwnKaEycw=;
        b=PymzN8ZDc0V0y27EX4+AH7pL9qAairBwP+7pLRF2gcz+e/ynD0tIWMh4G+GKV5kZj2
         /3wcV7IIev9Ys8q3EcXsnjBM/5oIoup2NNAN+C3xn+Io1Ysytp14acP1uYVe3jNlOtgC
         hWdcmq8G8GGvkq8XrrGR+9edES1sq30TNWzj/tree6kZ1sbXVOAJV8MheR4YzBh1oI1q
         zRx9JQd2L3wD0bVUxqvgWQGqA5CyoVfhJzXqHPB6fsH03TMvHXwJWuLDUYIbYMcXcp/F
         qLMnJ9LJ0B3vlemkjJJXLM+5cLai/vsslKKnQxWQX0e9TRNc12jhYAfYED8CA6qJGEJm
         2Oiw==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 28/33] doc: boards: amlogic: update documentation for W400
Date: Mon, 20 Mar 2023 11:46:04 +0000
Message-Id: <20230320114609.930145-29-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Improve documentation.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/w400.rst | 115 ++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/doc/board/amlogic/w400.rst b/doc/board/amlogic/w400.rst
index 38dbf52fb9..634fe1298d 100644
--- a/doc/board/amlogic/w400.rst
+++ b/doc/board/amlogic/w400.rst
@@ -1,15 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Amlogic W400
-=======================
+U-Boot for Amlogic W400 (S922X)
+===============================
 
-U200 is a reference board manufactured by Amlogic with the following
-specifications:
+W400 is a reference board manufactured by Amlogic with the following specification:
 
  - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
  - 2GB DDR4 SDRAM
  - 10/100 Ethernet (Internal PHY)
- - 1 x USB 3.0 Host
+ - 1x USB 3.0 Host
  - eMMC
  - SDcard
  - Infrared receiver
@@ -20,7 +19,7 @@ specifications:
 
 Schematics are available from Amlogic on demand.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -29,12 +28,20 @@ U-Boot compilation
     $ make w400_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh jethub-j100 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -49,7 +56,7 @@ the git tree published by the board vendor:
     $ make
     $ export UBOOTDIR=$PWD
 
-Download the latest Amlogic Buildroot package, and extract it :
+Download the latest Amlogic buildroot package and extract it:
 
 .. code-block:: bash
 
@@ -58,7 +65,7 @@ Download the latest Amlogic Buildroot package, and extract it :
     $ export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180706
     $ export FIPDIR=$BRDIR/bootloader/uboot-repo/fip
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -81,57 +88,57 @@ Go back to mainline U-Boot source tree then :
     $ cp u-boot.bin fip/bl33.bin
 
     $ sh fip/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+         fip/bl30.bin \
+         fip/zero_tmp \
+         fip/bl30_zero.bin \
+         fip/bl301.bin \
+         fip/bl301_zero.bin \
+         fip/bl30_new.bin \
+         bl30
 
     $ sh fip/blx_fix.sh \
-    	fip/bl2.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/acs.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
+         fip/bl2.bin \
+         fip/zero_tmp \
+         fip/bl2_zero.bin \
+         fip/acs.bin \
+         fip/bl21_zero.bin \
+         fip/bl2_new.bin \
+         bl2
 
     $ $FIPDIR/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
-    					--output fip/bl30_new.bin.g12a.enc \
-    					--level v3
+                                              --output fip/bl30_new.bin.g12a.enc \
+                                              --level v3
     $ $FIPDIR/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
-    					--output fip/bl30_new.bin.enc \
-    					--level v3 --type bl30
+                                             --output fip/bl30_new.bin.enc \
+                                             --level v3 --type bl30
     $ $FIPDIR/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
-    					--output fip/bl31.img.enc \
-    					--level v3 --type bl31
+                                             --output fip/bl31.img.enc \
+                                             --level v3 --type bl31
     $ $FIPDIR/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
-    					--output fip/bl33.bin.enc \
-    					--level v3 --type bl33
+                                             --output fip/bl33.bin.enc \
+                                             --level v3 --type bl33
     $ $FIPDIR/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
-    					--output fip/bl2.n.bin.sig
+                                             --output fip/bl2.n.bin.sig
     $ $FIPDIR/g12b/aml_encrypt_g12b --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc \
-    		--ddrfw1 fip/ddr4_1d.fw \
-    		--ddrfw2 fip/ddr4_2d.fw \
-    		--ddrfw3 fip/ddr3_1d.fw \
-    		--ddrfw4 fip/piei.fw \
-    		--ddrfw5 fip/lpddr4_1d.fw \
-    		--ddrfw6 fip/lpddr4_2d.fw \
-    		--ddrfw7 fip/diag_lpddr4.fw \
-    		--ddrfw8 fip/aml_ddr.fw \
-    		--level v3
-
-and then write the image to SD with:
+                                    --output fip/u-boot.bin \
+                                    --bl2 fip/bl2.n.bin.sig \
+                                    --bl30 fip/bl30_new.bin.enc \
+                                    --bl31 fip/bl31.img.enc \
+                                    --bl33 fip/bl33.bin.enc \
+                                    --ddrfw1 fip/ddr4_1d.fw \
+                                    --ddrfw2 fip/ddr4_2d.fw \
+                                    --ddrfw3 fip/ddr3_1d.fw \
+                                    --ddrfw4 fip/piei.fw \
+                                    --ddrfw5 fip/lpddr4_1d.fw \
+                                    --ddrfw6 fip/lpddr4_2d.fw \
+                                    --ddrfw7 fip/diag_lpddr4.fw \
+                                    --ddrfw8 fip/aml_ddr.fw \
+                                    --level v3
+
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

