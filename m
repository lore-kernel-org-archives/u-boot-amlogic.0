Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.11617.1679312785070843563
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:36 -0700
Received: by mail-wr1-f50.google.com with SMTP id d17so1608576wrb.11
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxnHVYKNCE/GVy5zjfpoO6N7DVnCQIkYWWe8AnYCmdM=;
        b=fnSboEXCJulyFxFta06RIg6NksExFjstwLMrC71YYz2tA7+Dona8D09KXndbpVD1r4
         FjAsw8yarbYPLWYgP88IlB0m15Kpt937eVhQWkSCOONdrb85weV0bc6wzSGxWeVSzkRb
         dRETCFYClXARixjI32/l5HmIiNiFCHg9fti7i6FeVr0kEUwsblNGhXiIth0h8i7jkesC
         qNOJihnT4xCAFKChNYvenroosKFPbGr8RZGW9JvBgT8a3M9KDKYi5JLsfQXueFKZKalH
         bDCiYe7RV8fYXlwWSAAviPV/ljx7v3Vsm3+0Iow/Pvf/zB87IcnQBvruPBc2ignPRofY
         5CUA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 14/33] doc: boards: amlogic: update documentation for NanoPi-K2
Date: Mon, 20 Mar 2023 11:45:50 +0000
Message-Id: <20230320114609.930145-15-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Improve documentation. Notably we can now support U-Boot install to
the removable eMMC storage module in addition to SD cards.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/nanopi-k2.rst | 93 +++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/doc/board/amlogic/nanopi-k2.rst b/doc/board/amlogic/nanopi-k2.rst
index 76ff874434..2316dae0ec 100644
--- a/doc/board/amlogic/nanopi-k2.rst
+++ b/doc/board/amlogic/nanopi-k2.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for NanoPi-K2
-====================
+U-Boot for NanoPi-K2 (S905)
+===========================
 
-NanoPi-K2 is a single board computer manufactured by FriendlyElec
-with the following specifications:
+NanoPi-K2 is a single board computer manufactured by FriendlyElec with the following
+specifications:
 
  - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
@@ -18,7 +18,7 @@ with the following specifications:
 
 Schematics are available on the manufacturer website.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -27,14 +27,20 @@ U-Boot compilation
     $ make nanopi-k2_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `nanopi-k2`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh nanopi-k2 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -43,7 +49,6 @@ the git tree published by the board vendor:
     $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
     $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
     $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
-    $ git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
     $ git clone https://github.com/friendlyarm/u-boot.git -b nanopi-k2-v2015.01 amlogic-u-boot
     $ cd amlogic-u-boot
     $ sed -i 's/aarch64-linux-gnu-/aarch64-none-elf-/' Makefile
@@ -52,7 +57,7 @@ the git tree published by the board vendor:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -65,42 +70,52 @@ Go back to mainline U-Boot source tree then :
     $ cp $FIPDIR/gxb/bl301.bin fip/
     $ cp $FIPDIR/gxb/bl31.img fip/
     $ cp u-boot.bin fip/bl33.bin
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/raw/master/nanopi-k2/bl1.bin.hardkernel fip/bl1.bin.hardkernel
+    $ chmod +x fip/bl1.bin.hardkernel
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/raw/master/nanopi-k2/aml_chksum fip/aml_chksum
+    $ chmod +x fip/aml_chksum
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
-
-    $ $FIPDIR/fip_create \
-    	 --bl30 fip/bl30_new.bin \
-    	 --bl31 fip/bl31.img \
-    	 --bl33 fip/bl33.bin \
-    	 fip/fip.bin
-
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
+
+    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin \
+                         --bl31 fip/bl31.img \
+                         --bl33 fip/bl33.bin \
+                         fip/fip.bin
+
+    $ sed -i 's/\x73\x02\x08\x91/\x1F\x20\x03\xD5/' fip/bl2.bin
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
 
     $ cat fip/bl2_new.bin fip/fip.bin > fip/boot_new.bin
 
     $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig \
-    		--input fip/boot_new.bin
-    		--output fip/u-boot.bin
+                                  --input fip/boot_new.bin
+                                  --output fip/u-boot.bin
 
-and then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
-    $ dd if=fip/u-boot.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 conv=fsync
+    $ dd if=fip/u-boot.bin of=fip/u-boot.bin.gxbb bs=512 seek=9 skip=8 count=87 conv=fsync,notrunc
+    $ dd if=/dev/zero of=fip/u-boot.bin.gxbb bs=512 seek=8 count=1 conv=fsync,notrunc
+    $ dd if=bl1.bin.hardkernel of=fip/u-boot.bin.gxbb bs=512 seek=2 skip=2 count=1 conv=fsync,notrunc
+    $ ./aml_chksum fip/u-boot.bin.gxbb
+    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.gxbb of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

