Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.11617.1679312785070843563
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:25 -0700
Received: by mail-wr1-f50.google.com with SMTP id d17so1607943wrb.11
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDDPokm7BWMRXPNQJsOsLQ6+Agr/JtPpcM2AM4ODhyQ=;
        b=qAqxy0pI6FTuUZrUueK5qMIGhQytoskBnXtNXVPU5tUvbTcZaYUImnihylriZzJsdW
         qJA0EhJUR5vvILeiOQ274JxFCPOmitFC7Kt6aPdGuM4KInxI91e8EoB67mFloywhQoif
         UVjcFG2w0eZH4CCKluKPSwErOQwxhOoLYaA6BS0+3YBFCJ4IRr9HMxOLKcEjE72o5Zz0
         eFakHzmTbTyvpQkOYXQUphStuGfHIHH4pCZvEmm3TqAPnsuCfP86DZHZegRERUOFbUxu
         MZuN5/+OxlDKqSC+BQhl/6DgXHoI0wybthjscYscHGquArdwMQOZA+gp6miHWiPNSPp0
         9x9w==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 07/33] doc: boards: amlogic: update documentation for JetHub J80
Date: Mon, 20 Mar 2023 11:45:43 +0000
Message-Id: <20230320114609.930145-8-christianshewitt@gmail.com>
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
 doc/board/amlogic/jethub-j80.rst | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index f669a0118d..d20fbad4c5 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for JetHub J80
-======================
+U-Boot for JetHub J80 (S905W)
+=============================
 
-JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation
-controller manufactured by JetHome with the following specifications:
+JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller device
+manufactured by JetHome with the following specifications:
 
  - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
  - No video out
@@ -21,7 +21,7 @@ controller manufactured by JetHome with the following specifications:
  - DC source 5V microUSB
  - Square plastic case
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -30,14 +30,20 @@ U-Boot compilation
     $ make jethub_j80_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `jethub-j80`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh jethub-j80 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain binaries
-from the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -45,7 +51,7 @@ from the git tree published by the board vendor:
     $ cd jethub-u-boot
     $ export FIPDIR=$PWD
 
-Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -84,16 +90,16 @@ Go back to mainline U-Boot source tree then :
     $ $FIPDIR/j80/aml_encrypt_gxl --bl3enc --input fip/bl33.bin --compress lz4
     $ $FIPDIR/j80/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
     $ $FIPDIR/j80/aml_encrypt_gxl --bootmk \
-                --output fip/u-boot.bin \
-                --bl2 fip/bl2.n.bin.sig \
-                --bl30 fip/bl30_new.bin.enc \
-                --bl31 fip/bl31.img.enc \
-                --bl33 fip/bl33.bin.enc
+                                  --output fip/u-boot.bin \
+                                  --bl2 fip/bl2.n.bin.sig \
+                                  --bl30 fip/bl30_new.bin.enc \
+                                  --bl31 fip/bl31.img.enc \
+                                  --bl33 fip/bl33.bin.enc
 
-and then write the image to SD/eMMC with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

