Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.11705.1679312788537430076
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:28 -0700
Received: by mail-wr1-f48.google.com with SMTP id i9so10046002wrp.3
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9MwXvf+flhTQSJUpZFWyNrBWTEpWDup8ZklCGcRg7Y=;
        b=Lvk3881Fg8L26vamATTqBXKfs0MCW6Tbb+AqIlVBiqG7axe8CNJ4Fnf53akwXjQfMj
         mwXPES6KvBbl7PRpuZ/tR+cuA/WbPB6o80UtKJAxuwmeXMsUQtaMeTO0IrUmDV5rjEeh
         0QYGxqQOWnRAmq5Bbb5HeYktM5vbeiMISwRB8pe5VH+yCo1SzeJKPg6XJe98SBYSLBNx
         xHwrRPK4nR2u7p67espVh/KYzwmK1OPwgsNp51vTj30/PCgKLcQykkwvTmPuzbuRc06V
         wzOpAVLKq2pOiqftb3OM7ldWNJdo2uUnEn45SSTPznNJV6z2HhZLaqv2cYzj+LdQUpf3
         MrPg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 09/33] doc: boards: amlogic: update documentation for Khadas VIM2
Date: Mon, 20 Mar 2023 11:45:45 +0000
Message-Id: <20230320114609.930145-10-christianshewitt@gmail.com>
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
 doc/board/amlogic/khadas-vim2.rst | 76 +++++++++++++++++--------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/doc/board/amlogic/khadas-vim2.rst b/doc/board/amlogic/khadas-vim2.rst
index 7ac3bdcbaf..78d47f93fe 100644
--- a/doc/board/amlogic/khadas-vim2.rst
+++ b/doc/board/amlogic/khadas-vim2.rst
@@ -1,25 +1,25 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Khadas VIM2
-=======================
+U-Boot for Khadas VIM2 (S912)
+=============================
 
-Khadas VIM2 is an Open Source DIY Box manufactured by Shenzhen Wesion
-Technology Co., Ltd with the following specifications:
+Khadas VIM2 is a Single Board Computer manufactured by Shenzhen Wesion Technology Co. Ltd
+with the following specifications:
 
  - Amlogic S912 ARM Cortex-A53 octo-core SoC @ 1.5GHz
  - ARM Mali T860 GPU
- - 2/3GB DDR4 SDRAM
+ - 2GB/3GB DDR4 SDRAM
+ - 16GB/32GB/64GB eMMC
  - 10/100/1000 Ethernet
  - HDMI 2.0 4K/60Hz display
  - 40-pin GPIO header
  - 2 x USB 2.0 Host, 1 x USB 2.0 Type-C OTG
- - 16GB/32GB/64GB eMMC
  - 2MB SPI Flash
  - microSD
  - SDIO Wifi Module, Bluetooth
  - Two channels IR receiver
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -28,14 +28,20 @@ U-Boot compilation
     $ make khadas-vim2_defconfig
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
+    $ ./build-fip.sh khadas-vim2 /path/to/u-boot/u-boot.bin my-output-dir
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim2`
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -50,7 +56,7 @@ the git tree published by the board vendor:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -65,40 +71,40 @@ Go back to mainline U-Boot source tree then :
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
 
     $ DEV=/dev/your_sd_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

