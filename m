Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.11612.1679312774262615127
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:34 -0700
Received: by mail-wr1-f54.google.com with SMTP id y14so10042700wrq.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/1NGisBICDWKySTthh8leLs4mxW+Mpv+VVXG9ecVfo=;
        b=RTOji96/oYV6kpRrT9EEicTs7jEAbtTfreSo0mosAjuVZRoIqYAZVFjwDO6fal6lq1
         vA9yftIpzbWRcbIwUyHJQG4jh1ij2QEeRGdbQoiYWAQo4xfiGXalUGEn9q4U4Q4Muxmh
         FrihhCHypXoc0zj+XFUV7ArpSI1rAyyFNlugWbjoXOCTv2SYsrpHMEjgsk6Jf3jHiMdk
         1J680ld10dajPk98gOlh8Y0XQWFnzg+PFZluGtu2v2ikRqv/bqei4xGJPN7qBwjGIwHA
         JbVga9qwrO/oA8Pk3/swnw94tgyDaJ4gvVRysoSXxwZxArvhtccEya3S02RyKyyRJWj+
         l81w==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 13/33] doc: boards: amlogic: update documentation for LePotato
Date: Mon, 20 Mar 2023 11:45:49 +0000
Message-Id: <20230320114609.930145-14-christianshewitt@gmail.com>
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
 doc/board/amlogic/libretech-cc.rst | 109 +++++++++++------------------
 1 file changed, 40 insertions(+), 69 deletions(-)

diff --git a/doc/board/amlogic/libretech-cc.rst b/doc/board/amlogic/libretech-cc.rst
index 596ce45dc4..d1d3ce49f6 100644
--- a/doc/board/amlogic/libretech-cc.rst
+++ b/doc/board/amlogic/libretech-cc.rst
@@ -1,12 +1,12 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for LibreTech CCs
-========================
+U-Boot for LibreTech CC 'LePotato' (S905X)
+==========================================
 
-LibreTech CC is a single board computer manufactured by Libre Technology
-with the following specifications:
+LibreTech CC is a Single Board Computer manufactured by Libre Computer Technology with
+the following specifications:
 
-V1:
+v1:
 
  - Amlogic S905X ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
@@ -19,14 +19,14 @@ V1:
  - Infrared receiver
  - Jack for CVBS and Audio
 
-V2:
+v2:
 
  - Added SPI NOR
  - Removed Jack
 
 Schematics are available on the manufacturer website.
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -37,36 +37,20 @@ U-Boot compilation
 
 Use libretech-cc_v2_defconfig for v2.
 
-Image creation
---------------
-
-To boot the system, u-boot must be combined with several earlier stage
-bootloaders:
-
-* bl2.bin: vendor-provided binary blob
-* bl21.bin: built from vendor u-boot source
-* bl30.bin: vendor-provided binary blob
-* bl301.bin: built from vendor u-boot source
-* bl31.bin: vendor-provided binary blob
-* acs.bin: built from vendor u-boot source
-
-These binaries and the tools required below have been collected and prebuilt
-for convenience at <https://github.com/BayLibre/u-boot/releases/>. These
-apply to both v1 and v2.
-
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `lepotato`
-
-Download and extract the libretech-cc release from there, and set FIPDIR to
-point to the `fip` subdirectory.
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
 .. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh lepotato /path/to/u-boot/u-boot.bin my-output-dir
 
-    $ export FIPDIR=/path/to/extracted/fip
+U-Boot Manual Signing
+---------------------
 
-Alternatively, you can obtain the original vendor u-boot tree which
-contains the required blobs and sources, and build yourself.
-Note that old compilers are required for this to build. The compilers here
-are suggested by Amlogic, and they are 32-bit x86 binaries.
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -81,9 +65,7 @@ are suggested by Amlogic, and they are 32-bit x86 binaries.
     $ make
     $ export FIPDIR=$PWD/fip
 
-Once you have the binaries available (either through the prebuilt download,
-or having built the vendor u-boot yourself), you can then proceed to glue
-everything together. Go back to mainline U-Boot source tree then :
+Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
@@ -98,51 +80,40 @@ everything together. Go back to mainline U-Boot source tree then :
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
 
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
     $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
     $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
-    		--output fip/u-boot.bin \
-    		--bl2 fip/bl2.n.bin.sig \
-    		--bl30 fip/bl30_new.bin.enc \
-    		--bl31 fip/bl31.img.enc \
-    		--bl33 fip/bl33.bin.enc
+                                  --output fip/u-boot.bin \
+                                  --bl2 fip/bl2.n.bin.sig \
+                                  --bl30 fip/bl30_new.bin.enc \
+                                  --bl31 fip/bl31.img.enc \
+                                  --bl33 fip/bl33.bin.enc
 
-and then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
-
-Note that Amlogic provides aml_encrypt_gxl as a 32-bit x86 binary with no
-source code. Should you prefer to avoid that, there are open source reverse
-engineered versions available:
-
-1. gxlimg <https://github.com/repk/gxlimg>, which comes with a handy
-   Makefile that automates the whole process.
-2. meson-tools <https://github.com/afaerber/meson-tools>
-
-However, these community-developed alternatives are not endorsed by or
-supported by Amlogic.
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

