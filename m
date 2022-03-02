Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.5657.1646214149801029828
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Mar 2022 01:42:31 -0800
Received: by mail-wr1-f46.google.com with SMTP id p9so1726813wra.12
        for <u-boot-amlogic@groups.io>; Wed, 02 Mar 2022 01:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9RwUvUx9wJswzP/aAHXuCt/5HuLMWUFoKK5eQFzbYE=;
        b=jHeS7x45oJqAs/r2fe8x8Xfl7lZNrMyu9GUVRhPzUogdhrAagscrcqfPw9FkTI7bqr
         W0E1asDDwx032BsHuToJuFD1G1X/EcS6yU3WfodHrENk+e+OnmTsvLTv2Acm+qLYc8qT
         L5G+vH3xiGlpgvCfK4YnRVjks25iqlKsngRhBJAr8CHth9VdyGtw3Z0TnIgCOFFksLRF
         oOzO6+2jAcA0225z90K11yi/KqtHZJWUvt0hmmUd4zdA+kzzw0Jhl8IqRmVUcfuPQ3p+
         gv9Egw2KmPsB+WX3/SR+GlqHmHYpDKyyor3RUXVM1s0E7VzVUFJgULtro5nccVOk1x8f
         ShCA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] doc: board: amlogic-p20x: fix FIP generation doc
Date: Wed,  2 Mar 2022 10:42:21 +0100
Message-Id: <20220302094222.566314-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: christianshewitt@gmail.com, adeep@lexina.in, b.galvani@gmail.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The doc used GXL instructions, which couldn't work on GXBB SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/p200.rst | 57 +++++++++++++++++---------------------
 doc/board/amlogic/p201.rst | 57 +++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/doc/board/amlogic/p200.rst b/doc/board/amlogic/p200.rst
index c3d6441fd3..1c84f1c9d0 100644
--- a/doc/board/amlogic/p200.rst
+++ b/doc/board/amlogic/p200.rst
@@ -54,44 +54,39 @@ Go back to mainline U-boot source tree then :
 
     $ mkdir fip
 
-    $ cp $FIPDIR/gxl/bl2.bin fip/
-    $ cp $FIPDIR/gxl/acs.bin fip/
-    $ cp $FIPDIR/gxl/bl21.bin fip/
-    $ cp $FIPDIR/gxl/bl30.bin fip/
-    $ cp $FIPDIR/gxl/bl301.bin fip/
-    $ cp $FIPDIR/gxl/bl31.img fip/
+    $ cp $FIPDIR/gxb/bl2.bin fip/
+    $ cp $FIPDIR/gxb/acs.bin fip/
+    $ cp $FIPDIR/gxb/bl21.bin fip/
+    $ cp $FIPDIR/gxb/bl30.bin fip/
+    $ cp $FIPDIR/gxb/bl301.bin fip/
+    $ cp $FIPDIR/gxb/bl31.img fip/
     $ cp u-boot.bin fip/bl33.bin
 
     $ $FIPDIR/blx_fix.sh \
     	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+        fip/zero_tmp \
+        fip/bl30_zero.bin \
+        fip/bl301.bin \
+        fip/bl301_zero.bin \
+        fip/bl30_new.bin \
+        bl30
 
-    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl2_acs.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/bl21.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
-
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc
+        fip/bl2_acs.bin \
+        fip/zero_tmp \
+        fip/bl2_zero.bin \
+        fip/bl21.bin \
+        fip/bl21_zero.bin \
+        fip/bl2_new.bin \
+        bl2
+
+    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin --bl31 fip/bl31.img --bl33 fip/bl33.bin fip/fip.bin
+
+    $ cat fip/bl2_new.bin fip/fip.bin >fip/boot_new.bin
+
+    $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig --input fip/boot_new.bin --output fip/u-boot.bin
 
 and then write the image to SD with:
 
diff --git a/doc/board/amlogic/p201.rst b/doc/board/amlogic/p201.rst
index 06da933a2a..a3d451c6e6 100644
--- a/doc/board/amlogic/p201.rst
+++ b/doc/board/amlogic/p201.rst
@@ -54,44 +54,39 @@ Go back to mainline U-boot source tree then :
 
     $ mkdir fip
 
-    $ cp $FIPDIR/gxl/bl2.bin fip/
-    $ cp $FIPDIR/gxl/acs.bin fip/
-    $ cp $FIPDIR/gxl/bl21.bin fip/
-    $ cp $FIPDIR/gxl/bl30.bin fip/
-    $ cp $FIPDIR/gxl/bl301.bin fip/
-    $ cp $FIPDIR/gxl/bl31.img fip/
+    $ cp $FIPDIR/gxb/bl2.bin fip/
+    $ cp $FIPDIR/gxb/acs.bin fip/
+    $ cp $FIPDIR/gxb/bl21.bin fip/
+    $ cp $FIPDIR/gxb/bl30.bin fip/
+    $ cp $FIPDIR/gxb/bl301.bin fip/
+    $ cp $FIPDIR/gxb/bl31.img fip/
     $ cp u-boot.bin fip/bl33.bin
 
     $ $FIPDIR/blx_fix.sh \
     	fip/bl30.bin \
-    	fip/zero_tmp \
-    	fip/bl30_zero.bin \
-    	fip/bl301.bin \
-    	fip/bl301_zero.bin \
-    	fip/bl30_new.bin \
-    	bl30
+        fip/zero_tmp \
+        fip/bl30_zero.bin \
+        fip/bl301.bin \
+        fip/bl301_zero.bin \
+        fip/bl30_new.bin \
+        bl30
 
-    $ $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
 
     $ $FIPDIR/blx_fix.sh \
-    	fip/bl2_acs.bin \
-    	fip/zero_tmp \
-    	fip/bl2_zero.bin \
-    	fip/bl21.bin \
-    	fip/bl21_zero.bin \
-    	fip/bl2_new.bin \
-    	bl2
-
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
-    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc
+        fip/bl2_acs.bin \
+        fip/zero_tmp \
+        fip/bl2_zero.bin \
+        fip/bl21.bin \
+        fip/bl21_zero.bin \
+        fip/bl2_new.bin \
+        bl2
+
+    $ $FIPDIR/fip_create --bl30 fip/bl30_new.bin --bl31 fip/bl31.img --bl33 fip/bl33.bin fip/fip.bin
+
+    $ cat fip/bl2_new.bin fip/fip.bin >fip/boot_new.bin
+
+    $ $FIPDIR/gxb/aml_encrypt_gxb --bootsig --input fip/boot_new.bin --output fip/u-boot.bin
 
 and then write the image to SD with:
 
-- 
2.25.1

