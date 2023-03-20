Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.11612.1679312774262615127
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:29 -0700
Received: by mail-wr1-f54.google.com with SMTP id y14so10042403wrq.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsncpsLbv6Sdy2201gEVqEmK6Z5ULiz02P3xkFi5QSI=;
        b=SKmNseR7A3WoUf51Rxt7ISgUi4LE52+OM0M0yWCvNALl9QyT2e2OK5XOfrn8EpswOd
         KGekvTkZs/FTaca4J0V4esMu4akjRWRtMGM2B1uAlsMbrlb0BwcgZN4ITINUDjN5ZO86
         g+j79zt9WFME6eYa9ri4Kt2rqy+o4Pl46+9vRqH0rf0mgX6mKyPQp2Rn0mdGO6Qn4SKk
         zVnCAAFC1Wfq4wI6yw5knkzpM77gtw7UsFFWMMzqYzAxh1OYyO+6ioV/P+6rDyUAdfw+
         MfU2Zmv5UF8Bo6OE+iHpHhZ9Cd72hwT8c8F6x+PJCmhPQsjamBuyBbLUHCUIkOOvy0mN
         kwrA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 10/33] doc: boards: amlogic: update documentation for Khadas VIM3
Date: Mon, 20 Mar 2023 11:45:46 +0000
Message-Id: <20230320114609.930145-11-christianshewitt@gmail.com>
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
 doc/board/amlogic/khadas-vim3.rst | 137 +++++++++++++++---------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/doc/board/amlogic/khadas-vim3.rst b/doc/board/amlogic/khadas-vim3.rst
index 73dc32b79b..88f2e0ebbe 100644
--- a/doc/board/amlogic/khadas-vim3.rst
+++ b/doc/board/amlogic/khadas-vim3.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Khadas VIM3
-======================
+U-Boot for Khadas VIM3 (A311D)
+==============================
 
-Khadas VIM3 is a single board computer manufactured by Shenzhen Wesion
-Technology Co., Ltd. with the following specifications:
+Khadas VIM3 is a Single Board Computer manufactured by Shenzhen Wesion Technology Co. Ltd
+with the following specifications:
 
  - Amlogic A311D Arm Cortex-A53 dual-core + Cortex-A73 quad-core SoC
  - 4GB LPDDR4 SDRAM
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
+3.1 SuperSpeed Data Switch between a USB3.0 Type-A connector and an M.2 Key M slot. The
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
     $ make khadas-vim3_defconfig
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
+    $ ./build-fip.sh khadas-vim3 /path/to/u-boot/u-boot.bin my-output-dir
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim3`
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
 
     $ DIR=vim3-u-boot
-    $ git clone --depth 1 \
-       https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
-       $DIR
+    $ git clone --depth 1 https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 $DIR
 
     $ cd vim3-u-boot
     $ make kvim3_defconfig
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
 
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
-    					--output fip/bl30_new.bin.g12a.enc \
-    					--level v3
+                                          --output fip/bl30_new.bin.g12a.enc \
+                                          --level v3
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
-    					--output fip/bl30_new.bin.enc \
-    					--level v3 --type bl30
+                                          --output fip/bl30_new.bin.enc \
+                                          --level v3 --type bl30
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
-    					--output fip/bl31.img.enc \
-    					--level v3 --type bl31
+                                          --output fip/bl31.img.enc \
+                                          --level v3 --type bl31
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
-    					--output fip/bl33.bin.enc \
-    					--level v3 --type bl33 --compress lz4
+                                          --output fip/bl33.bin.enc \
+                                          --level v3 --type bl33 --compress lz4
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
-    					--output fip/bl2.n.bin.sig
+                                          --output fip/bl2.n.bin.sig
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
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

