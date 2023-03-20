Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.11712.1679312806409388984
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:55 -0700
Received: by mail-wr1-f47.google.com with SMTP id j24so1129479wrd.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAtnln5Ywi5ePclZoX20T/TmZufEC2pp0oMOI8VQoEk=;
        b=bvOd/rEcJjOoDtiEErlMGACkOHq2Qm1X68QqDBX122FBiljfMNsPZAAbL15/ohCnY9
         0Kegu6JOK2QTtMslncC/L11N7R7DN1hxJ5OXYqMkW27aAiSsvBBqC1MY6mVC1uLoGl27
         XpLe9JNUyhWAYgHLzVKbXnGGRQuW2YgasQHN7LD4SwR8k/vbZ82H8euMB+usY6LeRhIB
         eOiWCuckF/bdSAClu+xVXX8t5qRtDLDXdeHBt9Nr/4EUn12UTD8EfmqpX+zJi6OoeH30
         bWXCYhpsRP28mkJ87KU39REtpwP7pzy2eEBgYrAUwjmEvi3snEV51tM/JxexHD3DSboY
         LW6Q==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 26/33] doc: boards: amlogic: update documentation for SEI610
Date: Mon, 20 Mar 2023 11:46:02 +0000
Message-Id: <20230320114609.930145-27-christianshewitt@gmail.com>
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
 doc/board/amlogic/sei610.rst | 118 ++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 57 deletions(-)

diff --git a/doc/board/amlogic/sei610.rst b/doc/board/amlogic/sei610.rst
index 2d754497cc..84aaeff4ed 100644
--- a/doc/board/amlogic/sei610.rst
+++ b/doc/board/amlogic/sei610.rst
@@ -1,23 +1,22 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Amlogic SEI610
-=========================
+U-Boot for Amlogic SEI610 (S905X3)
+==================================
 
-SEI610 is a customer board manufactured by SEI Robotics with the following
-specifications:
+SEI610 is a customer board manufactured by SEI Robotics with the following specification:
 
  - Amlogic S905X3 ARM Cortex-A55 quad-core SoC
  - 2GB DDR4 SDRAM
  - 10/100 Ethernet (Internal PHY)
- - 1 x USB 3.0 Host
- - 1 x USB Type-C DRD
- - 1 x FTDI USB Serial Debug Interface
+ - 1x USB 3.0 Host
+ - 1x USB Type-C DRD
+ - 1x FTDI USB Serial Debug Interface
  - eMMC
  - SDcard
  - Infrared receiver
  - SDIO WiFi Module
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -26,14 +25,20 @@ U-Boot compilation
     $ make sei610_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `sei610`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh sei610 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -48,7 +53,7 @@ the git tree published by the board vendor:
     $ make
     $ export UBOOTDIR=$PWD
 
-Download the latest Amlogic Buildroot package, and extract it :
+Download the latest Amlogic buildroot package and extract it:
 
 .. code-block:: bash
 
@@ -57,8 +62,7 @@ Download the latest Amlogic Buildroot package, and extract it :
     $ export BRDIR=$PWD/buildroot-openlinux-A113-201901
     $ export FIPDIR=$BRDIR/bootloader/uboot-repo/fip
 
-Go back to mainline U-Boot source tree then :
-
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -80,56 +84,56 @@ Go back to mainline U-Boot source tree then :
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
 
     $ $FIPDIR/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
-    					--output fip/bl30_new.bin.g12a.enc \
-    					--level v3
+                                              --output fip/bl30_new.bin.g12a.enc \
+                                              --level v3
     $ $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
-    					--output fip/bl30_new.bin.enc \
-    					--level v3 --type bl30
+                                             --output fip/bl30_new.bin.enc \
+                                             --level v3 --type bl30
     $ $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
-    					--output fip/bl31.img.enc \
-    					--level v3 --type bl31
+                                             --output fip/bl31.img.enc \
+                                             --level v3 --type bl31
     $ $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
-    					--output fip/bl33.bin.enc \
-    					--level v3 --type bl33
+                                             --output fip/bl33.bin.enc \
+                                             --level v3 --type bl33
     $ $FIPDIR/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
-    					--output fip/bl2.n.bin.sig
+                                             --output fip/bl2.n.bin.sig
     $ $FIPDIR/g12a/aml_encrypt_g12a --bootmk \
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

