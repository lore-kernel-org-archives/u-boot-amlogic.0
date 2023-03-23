Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.73884.1679581921622853097
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 07:32:01 -0700
Received: by mail-wm1-f52.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso1325038wms.3
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMCeWO2z5mPpG59rixBQ2tZtb1ZTvrk1m2t8iONKbu8=;
        b=Wbmb0UBWPKowXBWzOWd/ostYrSr+wTe7yKJnnbeej1bY0aDBQRhVzfpa58jaSkAHlo
         DCuhXyhdqgl7fliV3eFI1fDgUHJ8iivVc68+2+VgqBFe1qiW0uY2ef2ZMkCVNVTGYh5U
         vGIZeaoKFpGXWZBwu49PWy8SkPryKps99grMKT3ZGxkJDLMYdTRSHdEm/evM7B7VypKc
         OZU2TUEm47vG2lVdiMZIrhATR1pvhTBTxM0OigEu0nSC4LoxJjC1eVCCxjPDdv5YPGZ1
         sJ0NzuuwxbTWdaCaVPnZuNjiXypMAQJwm5TBVkczc/t9s6T1+BqFEPisvAbeEfIGwLdD
         yQDw==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH v2 08/14] docs: boards: amlogic: add documentation for BananaPi M2S
Date: Thu, 23 Mar 2023 14:31:36 +0000
Message-Id: <20230323143142.780306-9-christianshewitt@gmail.com>
In-Reply-To: <20230323143142.780306-1-christianshewitt@gmail.com>
References: <20230323143142.780306-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add build docs for the BPI-M2S board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/w400/MAINTAINERS     |   2 +
 doc/board/amlogic/bananapi-m2s.rst | 153 +++++++++++++++++++++++++++++
 doc/board/amlogic/index.rst        |   1 +
 3 files changed, 156 insertions(+)
 create mode 100644 doc/board/amlogic/bananapi-m2s.rst

diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 26a4c2c587..042b523056 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -4,5 +4,7 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
 F:	configs/bananapi-cm4-cm4io_defconfig
+F:	configs/bananapi-m2s_defconfig
 F:	doc/board/amlogic/w400.rst
 F:	doc/board/amlogic/bananapi-cm4io.rst
+F:	doc/board/amlogic/bananapi-m2s.rst
diff --git a/doc/board/amlogic/bananapi-m2s.rst b/doc/board/amlogic/bananapi-m2s.rst
new file mode 100644
index 0000000000..4a1be47b35
--- /dev/null
+++ b/doc/board/amlogic/bananapi-m2s.rst
@@ -0,0 +1,153 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for BananaPi M2S (A311D & S922X)
+=======================================
+
+BananaPi BPI-M2S ships is a Single Board Computer manufactured by Sinovoip that ships in
+two variants with Amlogic S922X or A311D SoC and the following common specification:
+
+- 16GB eMMC
+- HDMI 2.1a video
+- 2x 10/100/1000 Base-T Ethernet (1x RTL8211F, 1x RTL811H)
+- 2x USB 2.0 ports
+- 2x Status LED's (green/blue)
+- 1x Power/Reset button
+- 1x micro SD card slot
+- 40-pin GPIO header
+- PWM fan header
+- UART header
+
+The S992X variant has:
+- 2GB LPDDR4 RAM
+
+The A311D variant has:
+
+- 4GB LPDDR4 RAM
+- NPU (5.0 TOPS)
+- MIPI DSI header
+- MIPI CSI header
+
+An optional RTL8822CS SDIO WiFi/BT mezzanine is available for both board variants.
+
+Schematics are available from the manufacturer: https://wiki.banana-pi.org/Banana_Pi_BPI-M2S
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make bananapi-m2s_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh bananapi-m2s /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
+
+.. code-block:: bash
+
+    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
+
+    $ DIR=bananapi-m2s
+    $ git clone --depth 1 https://github.com/Dangku/amlogic-u-boot.git -b khadas-g12b-v2015.01-m2s $DIR
+
+    $ cd $DIR
+    $ make bananapi_m2s_defconfig
+    $ make
+    $ export UBDIR=$PWD
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+
+    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
+    $ cp $UBDIR/build/scp_task/bl301.bin fip/
+    $ cp $UBDIR/build/board/bananapi/bananpi_m2s/firmware/acs.bin fip/
+    $ cp $UBDIR/fip/g12a/bl2.bin fip/
+    $ cp $UBDIR/fip/g12a/bl30.bin fip/
+    $ cp $UBDIR/fip/g12a/bl31.img fip/
+    $ cp $UBDIR/fip/g12a/ddr3_1d.fw fip/
+    $ cp $UBDIR/fip/g12a/ddr4_1d.fw fip/
+    $ cp $UBDIR/fip/g12a/ddr4_2d.fw fip/
+    $ cp $UBDIR/fip/g12a/diag_lpddr4.fw fip/
+    $ cp $UBDIR/fip/g12a/lpddr3_1d.fw fip/
+    $ cp $UBDIR/fip/g12a/lpddr4_1d.fw fip/
+    $ cp $UBDIR/fip/g12a/lpddr4_2d.fw fip/
+    $ cp $UBDIR/fip/g12a/piei.fw fip/
+    $ cp $UBDIR/fip/g12a/aml_ddr.fw fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ sh fip/blx_fix.sh \
+         fip/bl30.bin \
+         fip/zero_tmp \
+         fip/bl30_zero.bin \
+         fip/bl301.bin \
+         fip/bl301_zero.bin \
+         fip/bl30_new.bin \
+         bl30
+
+    $ sh fip/blx_fix.sh \
+         fip/bl2.bin \
+         fip/zero_tmp \
+         fip/bl2_zero.bin \
+         fip/acs.bin \
+         fip/bl21_zero.bin \
+         fip/bl2_new.bin \
+         bl2
+
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
+                                       --output fip/bl30_new.bin.g12a.enc \
+                                       --level v3
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
+                                       --output fip/bl30_new.bin.enc \
+                                       --level v3 --type bl30
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+                                       --output fip/bl31.img.enc \
+                                       --level v3 --type bl31
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
+                                       --output fip/bl33.bin.enc \
+                                       --level v3 --type bl33 --compress lz4
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
+                                       --output fip/bl2.n.bin.sig
+    $ $UBDIR/fip/g12b/aml_encrypt_g12b --bootmk \
+                                       --output fip/u-boot.bin \
+                                       --bl2 fip/bl2.n.bin.sig \
+                                       --bl30 fip/bl30_new.bin.enc \
+                                       --bl31 fip/bl31.img.enc \
+                                       --bl33 fip/bl33.bin.enc \
+                                       --ddrfw1 fip/ddr4_1d.fw \
+                                       --ddrfw2 fip/ddr4_2d.fw \
+                                       --ddrfw3 fip/ddr3_1d.fw \
+                                       --ddrfw4 fip/piei.fw \
+                                       --ddrfw5 fip/lpddr4_1d.fw \
+                                       --ddrfw6 fip/lpddr4_2d.fw \
+                                       --ddrfw7 fip/diag_lpddr4.fw \
+                                       --ddrfw8 fip/aml_ddr.fw \
+                                       --ddrfw9 fip/lpddr3_1d.fw \
+                                       --level v3
+
+Then write the image to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 8388acdd11..fa1b362731 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -87,6 +87,7 @@ Board Documentation
 
    bananapi-cm4io
    bananapi-m2pro
+   bananapi-m2s
    bananapi-m5
    beelink-gskingx
    beelink-gtking
-- 
2.34.1

