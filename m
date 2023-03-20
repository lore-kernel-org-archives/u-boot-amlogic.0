Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.11612.1679312774262615127
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:19 -0700
Received: by mail-wr1-f54.google.com with SMTP id y14so10041851wrq.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGszLQhz+ukONY+m+KL8QiBbUNTXcMZFNhCjnvm98bU=;
        b=IpSqyp45p4SuKKwfu+deQAjdPLOjQLKpvHwxrRwyXQqYImtcX05eLeHlRkMv4RRnxh
         8SsyP8f5itE+Q1skxtI2NeGKzuFCkPGx2qYrm0tPdNIul8jeABwcuhJgWFpz6FjbGs8r
         D+VJEJE0CFOHPrCIJQB8MXP920y7LnZwp2bXNgeL+fAe74bhMZDCXuoaK3QDu8h+grtG
         BtIj9zXVD9aKL3HZWmSex8mAb7f9lX72uvVWfhHAsBVSMa5P/Ooyu8eAWBUTNlD0K5pG
         plGSNfV/fb428Tn00e46+1CrsOFyqa2ZxmHZT+y4RKlLLOn6hQT4yEksFfLjjCG/8bmS
         PONQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 04/33] doc: boards: amlogic: update documentation for Beelink GT-King
Date: Mon, 20 Mar 2023 11:45:40 +0000
Message-Id: <20230320114609.930145-5-christianshewitt@gmail.com>
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
 doc/board/amlogic/beelink-gtking.rst | 120 +++++++++++++--------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/doc/board/amlogic/beelink-gtking.rst b/doc/board/amlogic/beelink-gtking.rst
index 2fb50c5f7b..342887d584 100644
--- a/doc/board/amlogic/beelink-gtking.rst
+++ b/doc/board/amlogic/beelink-gtking.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Beelink GT-King
-==========================
+U-Boot for Beelink GT-King (S922X)
+==================================
 
-The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
-board with an S922X-H chip.
+The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference board with an
+S922X-H chip and the following specifications:
 
 - 4GB LPDDR4 RAM
 - 64GB eMMC storage
@@ -18,10 +18,10 @@ board with an S922X-H chip.
 - IR receiver
 - 1x micro SD card slot
 
-Beelink do not provide public schematics, but have been willing
-to share them with known distro developers on request.
+Beelink do not provide public schematics, but have been willing to share them with known
+distro developers to assist with development.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -30,21 +30,21 @@ U-Boot compilation
     $ make beelink-gtking_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-Amlogic does not provide sources for the firmware and for tools needed
-to create the bootloader image. Beelink have provided the Amlogic "SDK"
-in their forums, but the u-boot sources included result in 2GB RAM being
-detected. The following FIPs were generated with newer private sources
-and give correct (4GB) RAM detection:
-
-https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh beelink-s922x /path/to/u-boot/u-boot.bin my-output-dir
 
-NB: Beelink use a common board config for GT-King, GT-King Pro and the
-GS-King-X model, hence the "beelink-s922x" name.
+U-Boot Manual Signing
+---------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `beelink-s922x`
+Beelink released an Amlogic "SDK" dump in their forums, but the U-Boot sources included
+result in 2GB RAM detected. The following FIPs were generated with newer sources and
+detect 4GB RAM: https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
 
 .. code-block:: bash
 
@@ -61,57 +61,57 @@ Go back to the mainline U-Boot source tree then:
     $ cp u-boot.bin fip/bl33.bin
 
     $ sh fip/blx_fix.sh \
-    	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+         fip/bl30.bin \
+         fip/zero_tmp \
+         fip/bl30_zero.bin \
+         fip/bl301.bin \
+         fip/bl301_zero.bin \
+         fip/bl30_new.bin \
+         bl30
 
     $ sh fip/blx_fix.sh \
-    	fip/bl2.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/acs.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
+         fip/bl2.bin \
+         fip/zero_tmp \
+         fip/bl2_zero.bin \
+         fip/acs.bin \
+         fip/bl21_zero.bin \
+         fip/bl2_new.bin \
+         bl2
 
     $ fip/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
-    				--output fip/bl30_new.bin.g12a.enc \
-    				--level v3
+                           --output fip/bl30_new.bin.g12a.enc \
+                           --level v3
     $ fip/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
-    				--output fip/bl30_new.bin.enc \
-    				--level v3 --type bl30
+                           --output fip/bl30_new.bin.enc \
+                           --level v3 --type bl30
     $ fip/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
-    				--output fip/bl31.img.enc \
-    				--level v3 --type bl31
+                           --output fip/bl31.img.enc \
+                           --level v3 --type bl31
     $ fip/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
-    				--output fip/bl33.bin.enc \
-    				--level v3 --type bl33
+                           --output fip/bl33.bin.enc \
+                           --level v3 --type bl33
     $ fip/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
-    				--output fip/bl2.n.bin.sig
+                           --output fip/bl2.n.bin.sig
     $ fip/aml_encrypt_g12b --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc \
-    		--ddrfw1 fip/ddr4_1d.fw \
-    		--ddrfw2 fip/ddr4_2d.fw \
-    		--ddrfw3 fip/ddr3_1d.fw \
-    		--ddrfw4 fip/piei.fw \
-    		--ddrfw5 fip/lpddr4_1d.fw \
-    		--ddrfw6 fip/lpddr4_2d.fw \
-    		--ddrfw7 fip/diag_lpddr4.fw \
-    		--ddrfw8 fip/aml_ddr.fw \
-    		--level v3
-
-and then write the image to SD with:
+                           --output fip/u-boot.bin \
+                           --bl2 fip/bl2.n.bin.sig \
+                           --bl30 fip/bl30_new.bin.enc \
+                           --bl31 fip/bl31.img.enc \
+                           --bl33 fip/bl33.bin.enc \
+                           --ddrfw1 fip/ddr4_1d.fw \
+                           --ddrfw2 fip/ddr4_2d.fw \
+                           --ddrfw3 fip/ddr3_1d.fw \
+                           --ddrfw4 fip/piei.fw \
+                           --ddrfw5 fip/lpddr4_1d.fw \
+                           --ddrfw6 fip/lpddr4_2d.fw \
+                           --ddrfw7 fip/diag_lpddr4.fw \
+                           --ddrfw8 fip/aml_ddr.fw \
+                           --level v3
+
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

