Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.11700.1679312783648066262
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:23 -0700
Received: by mail-wr1-f47.google.com with SMTP id m2so10040131wrh.6
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPKSZKQAkxfQwjhbzG6pHQxSwGjcBFMBCf2hvSJPr+s=;
        b=dVf0vTeyD08DnCj6xy18uRRWYK5s8/g/T062gOM/YBcifxWIDDFZ2ydKffKFTfI0n4
         JDFmHIZ8dP9IvZnHddTIrx6Q922DmI4hLZc0/pNrwc91uYsa+i3DuLose53fq1rav09h
         YHny1QRoRQ1ZSJMtWyXRTlmU+QsOnyBSQIdDdMcTfPCaJw0uS9Nh8jXbGmz56d7hdCRL
         LA/MQWzXLpcJsBsiumQYk90TrIbd5t4f9xhzPNj8KhnPygKppjQ5pKpIEeLdSyeso9ib
         NRbJ69VqtNTL/k8Y1uKXnewR5rq7ddjtgYGGjuhQq4wFH5qxNsm0swKtsQ5H6JEFp8JO
         VbQg==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 06/33] doc: boards: amlogic: update documentation for JetHub J100
Date: Mon, 20 Mar 2023 11:45:42 +0000
Message-Id: <20230320114609.930145-7-christianshewitt@gmail.com>
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
 doc/board/amlogic/jethub-j100.rst | 66 ++++++++++++++++---------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index dd1ed68b9c..0d63976789 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,11 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for JetHub J100
-=======================
+U-Boot for JetHub J100 (A113X)
+==============================
 
-JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a series of home
-automation controller manufactured by JetHome with the following
-specifications:
+JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller device
+manufactured by JetHome with the following specifications:
 
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
  - no video out
@@ -22,16 +21,15 @@ specifications:
  - DC source with a voltage of 9 to 56 V / Passive POE
  - DIN Rail Mounting case
 
-Basic version also has:
+The basic version also has:
 
- - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
-   power and Zigbee 3.0 support.
+ - TI CC2538 + CC2592 Zigbee Wireless with upto 20dBm output power and Zigbee 3.0
  - 1 x 1-Wire
  - 2 x RS-485
  - 4 x dry contact digital GPIO inputs
  - 3 x relay GPIO outputs
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -40,14 +38,20 @@ U-Boot compilation
     $ make jethub_j100_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `jethub-j100`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh jethub-j100 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain binaries
-from the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -55,7 +59,7 @@ from the git tree published by the board vendor:
     $ cd jethub-u-boot
     $ export FIPDIR=$PWD
 
-Go back to mainline U-boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -90,27 +94,27 @@ Go back to mainline U-boot source tree then :
         bl2
 
     $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl30_new.bin \
-                                        --output fip/bl30_new.bin.enc \
-                                        --level v3 --type bl30
+                                   --output fip/bl30_new.bin.enc \
+                                   --level v3 --type bl30
     $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl31.img \
-                                        --output fip/bl31.img.enc \
-                                        --level v3 --type bl31
+                                   --output fip/bl31.img.enc \
+                                   --level v3 --type bl31
     $ $FIPDIR/j100/aml_encrypt_axg --bl3sig --input fip/bl33.bin --compress lz4 \
-                                        --output fip/bl33.bin.enc \
-                                        --level v3 --type bl33
+                                   --output fip/bl33.bin.enc \
+                                   --level v3 --type bl33
     $ $FIPDIR/j100/aml_encrypt_axg --bl2sig --input fip/bl2_new.bin \
-                                        --output fip/bl2.n.bin.sig
+                                   --output fip/bl2.n.bin.sig
     $ $FIPDIR/j100/aml_encrypt_axg --bootmk \
-                --output fip/u-boot.bin \
-                --bl2 fip/bl2.n.bin.sig \
-                --bl30 fip/bl30_new.bin.enc \
-                --bl31 fip/bl31.img.enc \
-                --bl33 fip/bl33.bin.enc --level v3
+                                   --output fip/u-boot.bin \
+                                   --bl2 fip/bl2.n.bin.sig \
+                                   --bl30 fip/bl30_new.bin.enc \
+                                   --bl31 fip/bl31.img.enc \
+                                   --bl33 fip/bl33.bin.enc --level v3
 
-and then write the image to eMMC with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_emmc_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

