Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.11616.1679312782152739864
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:22 -0700
Received: by mail-wr1-f49.google.com with SMTP id h17so10026285wrt.8
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIelX5cDcYvZ2BR37oAOKw+1iFz4JqaD5QMst5RKypY=;
        b=csi7G6B4XNOqrJLgNY/qXrq4OJhKM37D1M8nJAtim+1Dvo12kebIqRDbpQ5tTxzHbt
         NwvT1pB5gIUmEojxd38is+SAetgOtDW/5yH82hwMxeLmfbwbaG5ugR43xtq28rU7vFAu
         7Dj/9WlpdTK0zXU/J2NHzBicmoGQB56qq1r0QPM7gqS3ZvKrW0LMgL1ZqZ91TZS51lSK
         ZvsRh0zSGxvIR1k6WsWx2D2rjjqgJLHUOaAU/Rg8DBfZZsqkTfB1DIZ8lFbAO5/IxEAe
         WUDuiBVSDLAaovprpGlNKXP8rqPgm47YVDDZ+PbJOKkyBdKFvlsVpOzF7mKx1jjusc0V
         tWdA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 05/33] doc: boards: amlogic: update documentation for Beelink GT-King Pro
Date: Mon, 20 Mar 2023 11:45:41 +0000
Message-Id: <20230320114609.930145-6-christianshewitt@gmail.com>
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
 doc/board/amlogic/beelink-gtkingpro.rst | 120 ++++++++++++------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/doc/board/amlogic/beelink-gtkingpro.rst b/doc/board/amlogic/beelink-gtkingpro.rst
index 07bb04bb36..541938b103 100644
--- a/doc/board/amlogic/beelink-gtkingpro.rst
+++ b/doc/board/amlogic/beelink-gtkingpro.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Beelink GT-King Pro
-==============================
+U-Boot for Beelink GT-King Pro (S922X)
+======================================
 
-The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
-board with an S922X-H chip.
+The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference board with
+an S922X-H chip and the following specifications:
 
 - 4GB LPDDR4 RAM
 - 64GB eMMC storage
@@ -19,10 +19,10 @@ board with an S922X-H chip.
 - 1x SD card slot
 - 1x Power on/off button
 
-Beelink do not provide public schematics, but have been willing
-to share them with known distro developers on request.
+Beelink do not provide public schematics, but have been willing to share them with known  
+distro developers to assist with development.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -31,21 +31,21 @@ U-Boot compilation
     $ make beelink-gtkingpro_defconfig
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
 
@@ -62,57 +62,57 @@ Go back to the mainline U-Boot source tree then:
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

