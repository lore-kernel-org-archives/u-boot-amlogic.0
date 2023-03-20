Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.11717.1679312812892309229
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:47:00 -0700
Received: by mail-wr1-f51.google.com with SMTP id o7so10044696wrg.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaJQuomWRLKQE+KLyYWHiJ+/lNL7h9a/2ACaktG++Y8=;
        b=U/kATEcEU9ZVL6Htx5y1Bq6qyB++v97Z/XpiZttOL92NCul02iCwnqbxzbzxknNiVX
         YP5spkhamRU+xkGG3RM+dvyrTMB8n0FoL8K3X/GN4UE+16RAe8XFqNaAMhFT672mbvdd
         ioeprti0chDQP8wpnvijedHaPpbxaZHS2JXC5rpCDndDtVMinvoRXmNtkcRcU+hN/PjA
         UgcQ05M4CSNjtj0m4bGXSBXKWEIKfVYjWH6nSG17RNRX/9uLFa+2BZB/bwzgHqdvTZXj
         qXXAYKJtZ4owYuJUDA/tR/MyrgbHZBTkbsRENavE0D9geKNtnofoGKC/v3gsiSEKY9oD
         F3tQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 29/33] doc: boards: amlogic: update documentation for WeTek Core2
Date: Mon, 20 Mar 2023 11:46:05 +0000
Message-Id: <20230320114609.930145-30-christianshewitt@gmail.com>
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
 doc/board/amlogic/wetek-core2.rst | 83 +++++++++++++++++--------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/doc/board/amlogic/wetek-core2.rst b/doc/board/amlogic/wetek-core2.rst
index 0147d5fbe2..5eba566af4 100644
--- a/doc/board/amlogic/wetek-core2.rst
+++ b/doc/board/amlogic/wetek-core2.rst
@@ -1,23 +1,24 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for WeTek Core2
-======================
+U-Boot for WeTek Core2 (S912)
+=============================
 
-WeTek Core2 is an Android STB based on the Q200 reference design with
-the following specifications:
+WeTek Core2 is an Android STB based on the Q200 reference design with the following
+specifications:
 
  - Amlogic S912 ARM Cortex-A53 octo-core SoC @ 1.5GHz
  - ARM Mali T820 GPU
  - 3GB DDR4 SDRAM
  - 10/100 Realtek RTL8152 Ethernet (internal USB)
  - HDMI 2.0 4K/60Hz display
- - 2x USB 2.0 Host, 1x USB 2.0 OTG (internal)
+ - 2x USB 2.0 Host
+ - 1x USB 2.0 OTG (internal)
  - 32GB eMMC
  - microSD
  - SDIO Wifi Module, Bluetooth
  - Two channel IR receiver
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -26,15 +27,21 @@ U-Boot compilation
     $ make wetek-core2_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `wetek-core2`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh wetek-core2 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic does not provide sources for the firmware or the tools needed
-to create the bootloader image, and WeTek has not publicly shared the
-precompiled FIP binaries. However the public Khadas VIM2 sources also
-work with the Core2 box so we can use the Khadas git tree:
+Amlogic does not provide firmware sources or tools needed to create the bootloader image
+and WeTek has not publicly shared the precompiled FIP binaries. However the Khadas VIM2
+sources also work with the Core2 box so we can use the Khadas git tree:
 
 .. code-block:: bash
 
@@ -49,7 +56,7 @@ work with the Core2 box so we can use the Khadas git tree:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-Boot source tree then:
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -61,38 +68,42 @@ Go back to mainline U-Boot source tree then:
     $ cp $FIPDIR/gxl/bl301.bin fip/
     $ cp $FIPDIR/gxl/bl31.img fip/
     $ cp u-boot.bin fip/bl33.bin
+
     $ $FIPDIR/blx_fix.sh \
-        fip/bl30.bin \
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
+
     $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
     $ $FIPDIR/blx_fix.sh \
-        fip/bl2_acs.bin \
-        fip/zero_tmp \
-        fip/bl2_zero.bin \
-        fip/bl21.bin \
-        fip/bl21_zero.bin \
-        fip/bl2_new.bin \
-        bl2
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
+
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
     $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
-        --output fip/u-boot.bin \
-        --bl2 fip/bl2.n.bin.sig \
-        --bl30 fip/bl30_new.bin.enc \
-        --bl31 fip/bl31.img.enc \
-        --bl33 fip/bl33.bin.enc
+                                  --output fip/u-boot.bin \
+                                  --bl2 fip/bl2.n.bin.sig \
+                                  --bl30 fip/bl30_new.bin.enc \
+                                  --bl31 fip/bl31.img.enc \
+                                  --bl33 fip/bl33.bin.enc
 
-then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

