Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.11621.1679312798296815692
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:38 -0700
Received: by mail-wm1-f42.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso7291375wmq.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTDW0SCqpNfpSHS0rXT+ze4p7/dNzF26TO6fxVNniNc=;
        b=N80UnbmLnO7fZ+2Rfqx2YXlz/Mf4DRMbP0vesJg1dDF4WsV68qmGqzlHBO2wKzby+l
         yny8EgifxdCiCRCKVxUHc8ON5OIatZITR31VSop4WBWUYvZnNMBCEzfFWk0SD1jV0xOO
         lqltDDnFKtvuIvBhS2mdXd1IeoK+HNFdsw6UYgRlME1Rm844XwI9rpNpdcxCnc1ecQ2a
         Ac6p4PXMB8Q7Xjurkpvxpr/MYDeRuxmJ8MdtR1BCQiJs3Jaq3IKd2tEzModPJ0RKXRTV
         36flo9HSXga1pWd92WqXUG62abjrKITwYcDznhPMeuinxkwk0dKnWQ70UMxJFlDKrzn7
         SXpg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 15/33] doc: boards: amlogic: update documentation for ODROID-C2
Date: Mon, 20 Mar 2023 11:45:51 +0000
Message-Id: <20230320114609.930145-16-christianshewitt@gmail.com>
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
 doc/board/amlogic/odroid-c2.rst | 54 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/doc/board/amlogic/odroid-c2.rst b/doc/board/amlogic/odroid-c2.rst
index 8a1be4bf55..82eea3820e 100644
--- a/doc/board/amlogic/odroid-c2.rst
+++ b/doc/board/amlogic/odroid-c2.rst
@@ -1,12 +1,12 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for ODROID-C2
-====================
+U-Boot for ODROID-C2 (S905)
+===========================
 
-ODROID-C2 is a single board computer manufactured by Hardkernel
-Co. Ltd with the following specifications:
+ODROID-C2 is a single board computer manufactured by Hardkernel with the following
+specifications:
 
- - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 2GHz
+ - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
  - 2GB DDR3 SDRAM
  - Gigabit Ethernet
@@ -16,9 +16,9 @@ Co. Ltd with the following specifications:
  - eMMC, microSD
  - Infrared receiver
 
-Schematics are available on the manufacturer website.
+Schematics are available on the manufacturer website: https://wiki.odroid.com
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -27,38 +27,44 @@ U-Boot compilation
     $ make odroid-c2_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-c2`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh odroid-c2 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
     $ DIR=odroid-c2
-    $ git clone --depth 1 \
-       https://github.com/hardkernel/u-boot.git -b odroidc2-v2015.01 \
-       $DIR
+    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidc2-v2015.01 $DIR
+
     $ $DIR/fip/fip_create --bl30  $DIR/fip/gxb/bl30.bin \
-                       --bl301 $DIR/fip/gxb/bl301.bin \
-                       --bl31  $DIR/fip/gxb/bl31.bin \
-                       --bl33  u-boot.bin \
-                       $DIR/fip.bin
+                          --bl301 $DIR/fip/gxb/bl301.bin \
+                          --bl31  $DIR/fip/gxb/bl31.bin \
+                          --bl33  u-boot.bin \
+                          $DIR/fip.bin
+
     $ $DIR/fip/fip_create --dump $DIR/fip.bin
     $ cat $DIR/fip/gxb/bl2.package $DIR/fip.bin > $DIR/boot_new.bin
     $ $DIR/fip/gxb/aml_encrypt_gxb --bootsig \
-                                --input $DIR/boot_new.bin \
-                                --output $DIR/u-boot.img
+                                   --input $DIR/boot_new.bin \
+                                   --output $DIR/u-boot.img
     $ dd if=$DIR/u-boot.img of=$DIR/u-boot.gxbb bs=512 skip=96
 
-and then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/your_boot_device
     $ BL1=$DIR/sd_fuse/bl1.bin.hardkernel
     $ dd if=$BL1 of=$DEV conv=fsync bs=1 count=442
     $ dd if=$BL1 of=$DEV conv=fsync bs=512 skip=1 seek=1
-- 
2.34.1

