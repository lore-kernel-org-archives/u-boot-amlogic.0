Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.11711.1679312804687239775
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:49 -0700
Received: by mail-wr1-f45.google.com with SMTP id j24so1129157wrd.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atcu05uLW0E88v6JSwvj9fA2sSk5Aok0ROhgBvPOm2I=;
        b=g5/cPjWuMR0nNDgt0w5e7OWk9a8phhD9XO8WdCMKHuPWkqmAt01zEysRrx4ZON5cf+
         5noUhZc6cnRAEg3gDFrqQUteLaXhRrO56pEyywLfz0zLV5caaOBJshRNgi0hBsARTaSP
         iz/ZjQmExa9c5pzp/6T9WB+IuTvTInnZEZ6d1JiIrPprP9JJyxklCgbvugXtw/npIHiw
         HOfZCX9rhZgXxpspxCy9ZEq1TEBJxCmcbMNhJW+nNqpB3NrqaRwNOQZBBnn+TJ3ah+xu
         RcjFxT+qQ9dWk41yGYxMUj4p7WbO5Yk93IKn+4FdZLdBra3wUpdGsNoLimoIvuqtqG28
         x9Hg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 22/33] doc: boards: amlogic: update documentation for Q200
Date: Mon, 20 Mar 2023 11:45:58 +0000
Message-Id: <20230320114609.930145-23-christianshewitt@gmail.com>
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
 doc/board/amlogic/q200.rst | 76 +++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/doc/board/amlogic/q200.rst b/doc/board/amlogic/q200.rst
index 3ac4116be4..c304980579 100644
--- a/doc/board/amlogic/q200.rst
+++ b/doc/board/amlogic/q200.rst
@@ -1,24 +1,24 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Amlogic Q200
-=======================
+U-Boot for Amlogic Q200 (S912)
+==============================
 
-Q200 is a reference board manufactured by Amlogic with the following
-specifications:
+Q200 is a reference board manufactured by Amlogic with the following specifications:
 
  - Amlogic S912 ARM Cortex-A53 octo-core SoC @ 1.5GHz
  - ARM Mali T860 GPU
  - 2/3GB DDR4 SDRAM
  - 10/100/1000 Ethernet
  - HDMI 2.0 4K/60Hz display
- - 2 x USB 2.0 Host, 1 x USB 2.0 Device
+ - 2x USB 2.0 Host
+ - 1x USB 2.0 Device
  - 16GB/32GB/64GB eMMC
  - 2MB SPI Flash
  - microSD
  - SDIO Wifi Module, Bluetooth
  - IR receiver
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -27,12 +27,20 @@ U-Boot compilation
     $ make khadas-vim2_defconfig
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
+    $ ./build-fip.sh q200 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image but sources have been shared by Linux development contractor, Baylibre:
 
 .. code-block:: bash
 
@@ -47,7 +55,7 @@ the git tree published by the board vendor:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -62,40 +70,40 @@ Go back to mainline U-Boot source tree then :
     $ cp u-boot.bin fip/bl33.bin
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
 
     $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl2_acs.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/bl21.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
 
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
     $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc
+                                  --output fip/u-boot.bin \
+                                  --bl2 fip/bl2.n.bin.sig \
+                                  --bl30 fip/bl30_new.bin.enc \
+                                  --bl31 fip/bl31.img.enc \
+                                  --bl33 fip/bl33.bin.enc
 
-and then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

