Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.11700.1679312783648066262
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:32 -0700
Received: by mail-wr1-f47.google.com with SMTP id m2so10040606wrh.6
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIu2nkbZaeeSZVf/VpVNuKVvrHd1Zd4yr37NWjQNMt4=;
        b=o3tI3BPpIXyp9grPdHmQSJfOlQf1+8vIspFRes5hu7hgDI0EsE+/IZEM+Nf/jTM/Vt
         iaThXmlyOpswiIi2fMcxjivTyACJce5XV8B3JnZd3Pap4Jdi/IeHY0jwLuqdBLuxa20B
         jD2qxRJ03cOlCssa5uxkvp3WBukL/IwIvhK82eHv7Vgj2quRkMWcfuv5xzA7Cb86oIx8
         /eN57tnYNFLBBTZeWYOGYc/PRogdBJYIfBTwxF2lRXOPGBH9RhDT3sCgNhO2Stfjxm6S
         XT22a6QR/AA4Y4gNTES9H/8m70d22H6l6XNeLO6jj3ezV+VeP1YJm9/mNIUOlS83V5mt
         X1eQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 12/33] doc: boards: amlogic: update documentation for LaFrite
Date: Mon, 20 Mar 2023 11:45:48 +0000
Message-Id: <20230320114609.930145-13-christianshewitt@gmail.com>
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
 doc/board/amlogic/libretech-ac.rst | 77 ++++++++++++++++--------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/doc/board/amlogic/libretech-ac.rst b/doc/board/amlogic/libretech-ac.rst
index 7a915f9f26..6ebb7f646d 100644
--- a/doc/board/amlogic/libretech-ac.rst
+++ b/doc/board/amlogic/libretech-ac.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for LibreTech AC
-=======================
+U-Boot for LibreTech-AC 'LaFrite' (S805X)
+=========================================
 
-LibreTech AC is a single board computer manufactured by Libre Technology
+LibreTech-AC aka 'LaFrite' is a Single Board Computer manufactured by Libre Computer
 with the following specifications:
 
  - Amlogic S805X ARM Cortex-A53 quad-core SoC @ 1.2GHz
@@ -13,12 +13,13 @@ with the following specifications:
  - HDMI 2.0 4K/60Hz display
  - 40-pin GPIO header
  - 4 x USB 2.0 Host
- - eMMC, SPI NOR Flash
+ - SPI NOR Flash
+ - Removable eMMC module
  - Infrared receiver
 
 Schematics are available on the manufacturer website.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -27,14 +28,20 @@ U-Boot compilation
     $ make libretech-ac_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `lafrite`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh lafrite /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -50,7 +57,7 @@ the git tree published by the board vendor:
     $ make
     $ export UBOOTDIR=$PWD
 
-Download the latest Amlogic Buildroot package, and extract it :
+Download the latest Amlogic buildroot package and extract it:
 
 .. code-block:: bash
 
@@ -58,7 +65,7 @@ Download the latest Amlogic Buildroot package, and extract it :
     $ tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180418/bootloader
     $ export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180418
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -73,40 +80,40 @@ Go back to mainline U-Boot source tree then :
     $ cp u-boot.bin fip/bl33.bin
 
     $ sh $UBOOTDIR/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+                   fip/bl30.bin \
+                   fip/zero_tmp \
+                   fip/bl30_zero.bin \
+                   fip/bl301.bin \
+                   fip/bl301_zero.bin \
+                   fip/bl30_new.bin \
+                   bl30
 
     $ $BRDIR/bootloader/uboot-repo/fip/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
     $ sh $UBOOTDIR/blx_fix.sh \
-    	fip/bl2_acs.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/bl21.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
+                   fip/bl2_acs.bin \
+                   fip/zero_tmp \
+                   fip/bl2_zero.bin \
+                   fip/bl21.bin \
+                   fip/bl21_zero.bin \
+                   fip/bl2_new.bin \
+                   bl2
 
     $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
     $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
     $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
     $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
     $ $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc
+                   --output fip/u-boot.bin \
+                   --bl2 fip/bl2.n.bin.sig \
+                   --bl30 fip/bl30_new.bin.enc \
+                   --bl31 fip/bl31.img.enc \
+                   --bl33 fip/bl33.bin.enc
 
-and then write the image to SD with:
+Then write U-Boot to USB or SPI-NOR with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

