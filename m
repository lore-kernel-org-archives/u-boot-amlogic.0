Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.11717.1679312812892309229
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:53 -0700
Received: by mail-wr1-f51.google.com with SMTP id o7so10044312wrg.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jleqg1TxYhdSHi2FXGuYOR0T5CjWp5CMTfwWaNHKtDY=;
        b=DOqDDE1wgCrnCRU0Q0Y1B8Hp4TepJulv0RpyfuGyXkPVc7REb5lQJCejYAPjUBa8W6
         jpSZglffbv2Sg8KlsKmq3KmVi/WKzusljQR7imz0NPJIEWvnTuQWc/24jQ/7iHQ2uDC3
         VMih+4lqCee+uQJBVkO5L/kpvmu95WvazW8ZZzGDEgSogj3frQqYLciydg8XEUpggQXO
         k3hUencfO8UNImP9WirucRSY93s536z++jik9GrXzsV9pjLSCY+PNBYRlwtHJqocDiQz
         BwtMDGqlb01XArqA4XZXIl3bG85xHgK059BtpJflXyxjbUh5jaxp6yok2hd7FdThRBcy
         xoow==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 24/33] doc: boards: amlogic: update documentation for S400
Date: Mon, 20 Mar 2023 11:46:00 +0000
Message-Id: <20230320114609.930145-25-christianshewitt@gmail.com>
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
 doc/board/amlogic/s400.rst | 89 ++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/doc/board/amlogic/s400.rst b/doc/board/amlogic/s400.rst
index c92817b421..b00fe64e1b 100644
--- a/doc/board/amlogic/s400.rst
+++ b/doc/board/amlogic/s400.rst
@@ -1,15 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Amlogic S400
-=======================
+U-Boot for Amlogic S400 (A113X)
+===============================
 
-S400 is a reference board manufactured by Amlogic with the following
-specifications:
+S400 is a reference board manufactured by Amlogic with the following specifications:
 
- - Amlogic A113DX ARM Cortex-A53 quad-core SoC @ 1.2GHz
+ - Amlogic A113X ARM Cortex-A53 quad-core SoC @ 1.2GHz
  - 1GB DDR4 SDRAM
  - 10/100 Ethernet
- - 2 x USB 2.0 Host
+ - 2x USB 2.0 Host
  - eMMC
  - Infrared receiver
  - SDIO WiFi Module
@@ -19,7 +18,7 @@ specifications:
 
 Schematics are available from Amlogic on demand.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -28,14 +27,20 @@ U-Boot compilation
     $ make s400_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `s400`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh s400 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
 
-Amlogic doesn't provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-the git tree published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image but sources have been shared by Linux development contractor, Baylibre:
 
 .. code-block:: bash
 
@@ -65,47 +70,47 @@ Go back to mainline U-boot source tree then :
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
 
     $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
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
 
     $ $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl30_new.bin \
-    					--output fip/bl30_new.bin.enc \
-    					--level v3 --type bl30
+                                           --output fip/bl30_new.bin.enc \
+                                           --level v3 --type bl30
     $ $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl31.img \
-    					--output fip/bl31.img.enc \
-    					--level v3 --type bl31
+                                           --output fip/bl31.img.enc \
+                                           --level v3 --type bl31
     $ $FIPDIR/axg/aml_encrypt_axg --bl3sig --input fip/bl33.bin --compress lz4 \
-    					--output fip/bl33.bin.enc \
-    					--level v3 --type bl33
+                                           --output fip/bl33.bin.enc \
+                                           --level v3 --type bl33
     $ $FIPDIR/axg/aml_encrypt_axg --bl2sig --input fip/bl2_new.bin \
-    					--output fip/bl2.n.bin.sig
+                                           --output fip/bl2.n.bin.sig
     $ $FIPDIR/axg/aml_encrypt_axg --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc --level v3
+                                  --output fip/u-boot.bin \
+                                  --bl2 fip/bl2.n.bin.sig \
+                                  --bl30 fip/bl30_new.bin.enc \
+                                  --bl31 fip/bl31.img.enc \
+                                  --bl33 fip/bl33.bin.enc --level v3
 
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

