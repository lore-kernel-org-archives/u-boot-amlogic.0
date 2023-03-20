Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.11707.1679312791591760481
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:31 -0700
Received: by mail-wm1-f52.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so2210664wmq.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXxkF+XbVbc4FJBnwx+bZ4z+3Rqpu6bv55HLEWO0AlI=;
        b=gZfN6ARN5/zMky3GK8v7su3CaiqX8Pf/cUtrb1nHIn3i9OULU9rda+X62KjmPdG3O9
         /arAdmhO3WJxCBuFw7g3dpOEAd+tUAvPdE2s2LKR7QZl43RdB6N60RzeGUnqRLJXHGv/
         GQwJT18gbFpd7N/sxNVoqBTGAeeHQdE1veA8SbWeW8ZNoVKQ+fyorVoiF+bVcvKPA7Ca
         ViOXvMAQAt5BIMhuRKGb8uDCDjROb6ZewvwOEZXX3QUDjioFj4ZrlZnSyUexEAoeD56I
         H2HZRl//Tu0Z+fYje7Ua4n7S440Qfe9xZKkoAA0ZAiPur805SMfXZn2NnQAiHb94C7oo
         Xk1w==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 11/33] doc: boards: amlogic: update documentation for Khadas VIM3L
Date: Mon, 20 Mar 2023 11:45:47 +0000
Message-Id: <20230320114609.930145-12-christianshewitt@gmail.com>
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
 doc/board/amlogic/khadas-vim3l.rst | 137 ++++++++++++++---------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/doc/board/amlogic/khadas-vim3l.rst b/doc/board/amlogic/khadas-vim3l.rst
index 692ab3d21d..935f43c725 100644
--- a/doc/board/amlogic/khadas-vim3l.rst
+++ b/doc/board/amlogic/khadas-vim3l.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Khadas VIM3L
-=======================
+U-Boot for Khadas VIM3L (S905D3)
+================================
 
-Khadas VIM3L is a single board computer manufactured by Shenzhen Wesion
-Technology Co., Ltd. with the following specifications:
+Khadas VIM3L is a Single Board Computer manufactured by Shenzhen Wesion Technology Co. Ltd
+with the following specifications:
 
  - Amlogic S905D3 Arm Cortex-A55 quad-core SoC
  - 2GB LPDDR4 SDRAM
@@ -20,32 +20,27 @@ Schematics are available on the manufacturer website.
 
 PCIe Setup
 ----------
-The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
-lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
-an USB3.0 Type A connector and a M.2 Key M slot.
-The PHY driving these differential lines is shared between
-the USB3.0 controller and the PCIe Controller, thus only
-a single controller can use it.
 
-To setup for PCIe, run the following commands from U-Boot:
+The on-board MCU can mux the PCIe/USB3.0 shared differential lines using a FUSB340TMX USB
+3.1 SuperSpeed Data Switch between a USB3.0 Type-A connector and an M.2 Key-M slot. The
+PHY driving these differential lines is shared between the USB3.0 controller and the PCIe
+Controller, thus only a single controller can use it.
+
+To setup for PCIe run the following commands from U-Boot then power-cycle the board:
 
 .. code-block:: none
 
     i2c dev i2c@5000
     i2c mw 0x18 0x33 1
 
-Then power-cycle the board.
-
-To set back to USB3.0, run the following commands from U-Boot:
+To revert to USB3.0 run the following commands from U-Boot then power-cycle the board:
 
 .. code-block:: none
 
     i2c dev i2c@5000
     i2c mw 0x18 0x33 0
 
-Then power-cycle the board.
-
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -54,14 +49,20 @@ U-Boot compilation
     $ make khadas-vim3l_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh khadas-vim3l /path/to/u-boot/u-boot.bin my-output-dir
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim3l`
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -72,16 +73,14 @@ the git tree published by the board vendor:
     $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
 
     $ DIR=vim3l-u-boot
-    $ git clone --depth 1 \
-       https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
-       $DIR
+    $ git clone --depth 1 https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 $DIR
 
     $ cd vim3l-u-boot
     $ make kvim3l_defconfig
     $ make CROSS_COMPILE=aarch64-none-elf-
     $ export UBOOTDIR=$PWD
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -105,58 +104,58 @@ Go back to mainline U-Boot source tree then :
     $ cp u-boot.bin fip/bl33.bin
 
     $ bash fip/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+           fip/bl30.bin \
+           fip/zero_tmp \
+           fip/bl30_zero.bin \
+           fip/bl301.bin \
+           fip/bl301_zero.bin \
+           fip/bl30_new.bin \
+           bl30
 
     $ bash fip/blx_fix.sh \
-    	fip/bl2.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/acs.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
+           fip/bl2.bin \
+           fip/zero_tmp \
+           fip/bl2_zero.bin \
+           fip/acs.bin \
+           fip/bl21_zero.bin \
+           fip/bl2_new.bin \
+           bl2
 
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
-    					--output fip/bl30_new.bin.g12a.enc \
-    					--level v3
+                                          --output fip/bl30_new.bin.g12a.enc \
+                                          --level v3
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
-    					--output fip/bl30_new.bin.enc \
-    					--level v3 --type bl30
+                                          --output fip/bl30_new.bin.enc \
+                                          --level v3 --type bl30
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
-    					--output fip/bl31.img.enc \
-    					--level v3 --type bl31
+                                          --output fip/bl31.img.enc \
+                                          --level v3 --type bl31
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
-    					--output fip/bl33.bin.enc \
-    					--level v3 --type bl33 --compress lz4
+                                          --output fip/bl33.bin.enc \
+                                          --level v3 --type bl33 --compress lz4
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
-    					--output fip/bl2.n.bin.sig
+                                          --output fip/bl2.n.bin.sig
     $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
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
-    		--ddrfw9 fip/lpddr3_1d.fw \
-    		--level v3
-
-and then write the image to SD with:
+                                          --output fip/u-boot.bin \
+                                          --bl2 fip/bl2.n.bin.sig \
+                                          --bl30 fip/bl30_new.bin.enc \
+                                          --bl31 fip/bl31.img.enc \
+                                          --bl33 fip/bl33.bin.enc \
+                                          --ddrfw1 fip/ddr4_1d.fw \
+                                          --ddrfw2 fip/ddr4_2d.fw \
+                                          --ddrfw3 fip/ddr3_1d.fw \
+                                          --ddrfw4 fip/piei.fw \
+                                          --ddrfw5 fip/lpddr4_1d.fw \
+                                          --ddrfw6 fip/lpddr4_2d.fw \
+                                          --ddrfw7 fip/diag_lpddr4.fw \
+                                          --ddrfw8 fip/aml_ddr.fw \
+                                          --ddrfw9 fip/lpddr3_1d.fw \
+                                          --level v3
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

