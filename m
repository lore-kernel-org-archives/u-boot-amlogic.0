Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.11704.1679312786715928003
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:27 -0700
Received: by mail-wr1-f50.google.com with SMTP id d17so1608027wrb.11
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO4DLMa8pve8yBOZZSy2SbTPcwEaMc25HFl7WBtOZkQ=;
        b=fq03gNkl/3QMUef8M4c2UvAB1ZEaQwG//1Droz/0lHYyy8gHUfSBChvsdCDuy9nQk8
         s82VgqY3HzIY0IP+YIDR8UfgTCgQ3Wr+0jo6pF1t1E1vsInKCc7kjq2PcWdiJ90X5C1r
         40KVFwJziEL/4cYxhJpEMlzuDtF/6mI99uFB7kSESpG8m5oBqbVX+GmyrT/YYAswS+HK
         qu2NBPTVBUg0pYK8KJiWYNJcp7zy3lNr5CDQDhyvraGNET2scmQRs9wjElNNjC8S3o93
         /iD/vPhfB556OTlPcPOLdNQ2vCNsAzdeixMAUr3mU+4d+xRyRn8gfGh2Y7iow/YwGnDu
         lZsQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 08/33] doc: boards: amlogic: update documentation for Khadas VIM
Date: Mon, 20 Mar 2023 11:45:44 +0000
Message-Id: <20230320114609.930145-9-christianshewitt@gmail.com>
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
 doc/board/amlogic/khadas-vim.rst | 76 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/doc/board/amlogic/khadas-vim.rst b/doc/board/amlogic/khadas-vim.rst
index 04025d737c..f1fbe1a8a6 100644
--- a/doc/board/amlogic/khadas-vim.rst
+++ b/doc/board/amlogic/khadas-vim.rst
@@ -1,24 +1,24 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Khadas VIM
-======================
+U-Boot for Khadas VIM (S905X)
+=============================
 
-Khadas VIM is an Open Source DIY Box manufactured by Shenzhen Wesion
-Technology Co., Ltd with the following specifications:
+Khadas VIM is a Single Board Computer manufactured by Shenzhen Wesion Technology Co. Ltd
+with the following specifications:
 
  - Amlogic S905X ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
  - 2GB DDR3 SDRAM
+ - 8GB/16GB eMMC
  - 10/100 Ethernet
  - HDMI 2.0 4K/60Hz display
  - 40-pin GPIO header
  - 2 x USB 2.0 Host, 1 x USB 2.0 Type-C OTG
- - 8GB/16GBeMMC
  - microSD
  - SDIO Wifi Module, Bluetooth
- - Two channels IR receiver
+ - Two channel IR receiver
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -27,14 +27,20 @@ U-Boot compilation
     $ make khadas-vim_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh khadas-vim /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -64,40 +70,40 @@ Go back to mainline U-Boot source tree then :
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

