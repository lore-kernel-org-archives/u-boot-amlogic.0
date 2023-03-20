Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.11715.1679312807760223513
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:48 -0700
Received: by mail-wr1-f46.google.com with SMTP id l27so1720853wrb.2
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1j0pT0rKRqAnlEnQeXBE7k3l8qsVlNzG8h9gMj7DWs=;
        b=PQrApTLRE61ivCIyBZd6lx5aRXW34D4mUxpmI8Qco1rGy57Wt93drJf4lKRQNrtUgJ
         eS53AaOnOYOgGVzXCrRfIW0aO4miIGLiH+XXFrqhAmY+ft3t511UAlfFgdjZhybhfEK4
         1Jv0pcmPTuDUgYi7ozz5em506IF/aRLU+uJfKkYo4KzvooGImQZ+HwFwPAboOyTLdk3L
         VB2qY25WbyRMjOy/Ti5BYw9+WJFdLVAzH1OvLTL12LB5vfH+pIllETD93WA/Je4nZDJo
         lA51Fwfu8L71oz8VgkAPoasARDbHKqmdmFO/x0jN5LwMZ8FUNZGYopEcmynodFwZeGvv
         ewSg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 21/33] doc: boards: amlogic: update documentation for P201
Date: Mon, 20 Mar 2023 11:45:57 +0000
Message-Id: <20230320114609.930145-22-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Improve documentation. Notably we can now support U-Boot install to
the internal eMMC storage in addition to SD cards.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/p201.rst | 87 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/doc/board/amlogic/p201.rst b/doc/board/amlogic/p201.rst
index 2cd236582a..b3dce4204e 100644
--- a/doc/board/amlogic/p201.rst
+++ b/doc/board/amlogic/p201.rst
@@ -1,25 +1,24 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Amlogic P201
-=======================
+U-Boot for Amlogic P201 (S905)
+==============================
 
-P201 is a reference board manufactured by Amlogic with the following
-specifications:
+P201 is a reference board manufactured by Amlogic with the following specifications:
 
  - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
  - 2GB DDR3 SDRAM
  - 10/100 Ethernet
  - HDMI 2.0 4K/60Hz display
- - 2 x USB 2.0 Host
+ - 2x USB 2.0 Host
  - eMMC, microSD
  - Infrared receiver
  - SDIO WiFi Module
- - CVBS+Stereo Audio Jack
+ - CVBS + Stereo Audio Jack
 
 Schematics are available from Amlogic on demand.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -28,14 +27,20 @@ U-Boot compilation
     $ make p201_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `p201`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh p201 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image but sources have been shared by Linux development contractor, Baylibre:
 
 .. code-block:: bash
 
@@ -63,37 +68,51 @@ Go back to mainline U-boot source tree then :
     $ cp $FIPDIR/gxb/bl301.bin fip/
     $ cp $FIPDIR/gxb/bl31.img fip/
     $ cp u-boot.bin fip/bl33.bin
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/raw/master/nanopi-k2/bl1.bin.hardkernel fip/bl1.bin.hardkernel
+    $ chmod +x fip/bl1.bin.hardkernel
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/raw/master/nanopi-k2/aml_chksum fip/aml_chksum
+    $ chmod +x fip/aml_chksum
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl30.bin \
-        fip/zero_tmp \
-        fip/bl30_zero.bin \
-        fip/bl301.bin \
-        fip/bl301_zero.bin \
-        fip/bl30_new.bin \
-        bl30
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
 
     $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
     $ $FIPDIR/blx_fix.sh \
-        fip/bl2_acs.bin \
-        fip/zero_tmp \
-        fip/bl2_zero.bin \
-        fip/bl21.bin \
-        fip/bl21_zero.bin \
-        fip/bl2_new.bin \
-        bl2
-
-    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin --bl31 fip/bl31.img --bl33 fip/bl33.bin fip/fip.bin
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
+
+    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin \
+                         --bl31 fip/bl31.img \
+                         --bl33 fip/bl33.bin \
+                         fip/fip.bin
 
     $ cat fip/bl2_new.bin fip/fip.bin >fip/boot_new.bin
 
-    $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig --input fip/boot_new.bin --output fip/u-boot.bin
+    $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig \
+                                  --input fip/boot_new.bin \
+                                  --output fip/u-boot.bin
 
-and then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
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

