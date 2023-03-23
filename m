Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.73880.1679581916465423284
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 07:31:56 -0700
Received: by mail-wm1-f47.google.com with SMTP id l37so692574wms.2
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h/2763svh6ihBG0Xd+NIIQFgOrvvoNuBA6EsnL0kkI=;
        b=CneGv29HUDskNeIKncdbmNM1lbXB14njwZFzCAsEYdvD1XHqzh9jcuraF5YfnZTPFo
         abnLsXQ1hfX2fgbtUHlptSGxfrqBTD3STg0dljEbzNkga5J0jlHPKV6fr0pFjgS935K4
         P6zUsUzwYO+PWIKjIJnko26k62XgL3vQ6msKlFJPdfB+GbtanAEld6ob6v4MPVGbJZzS
         pBk4WTpSUYCW8fOjYmThkY99dvU9e2zDPWXZyiAz24ss2A38Ran9PYQVATJPdYnKkCM5
         sIARvuxkt2JDPkxGa1rd3sQHiKDjNHU7j8QXIjfsd3/3rmqHuAkXOR23O40s3dzGoyC3
         3+Hw==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH v2 05/14] docs: boards: amlogic: add documentation for BananaPi M2-Pro
Date: Thu, 23 Mar 2023 14:31:33 +0000
Message-Id: <20230323143142.780306-6-christianshewitt@gmail.com>
In-Reply-To: <20230323143142.780306-1-christianshewitt@gmail.com>
References: <20230323143142.780306-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add build docs for the BPI-M2-PRO board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/u200/MAINTAINERS       |   2 +
 doc/board/amlogic/bananapi-m2pro.rst | 143 +++++++++++++++++++++++++++
 doc/board/amlogic/index.rst          |   1 +
 3 files changed, 146 insertions(+)
 create mode 100644 doc/board/amlogic/bananapi-m2pro.rst

diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index 919e349922..f429c212ba 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -4,8 +4,10 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
 F:	configs/u200_defconfig
+F:	configs/bananapi-m2pro_defconfig
 F:	configs/bananapi-m5_defconfig
 F:	configs/radxa-zero_defconfig
 F:	doc/board/amlogic/u200.rst
+F:	doc/board/amlogic/bananapi-m2pro.rst
 F:	doc/board/amlogic/bananapi-m5.rst
 F:	doc/board/amlogic/radxa-zero.rst
diff --git a/doc/board/amlogic/bananapi-m2pro.rst b/doc/board/amlogic/bananapi-m2pro.rst
new file mode 100644
index 0000000000..6c35943bac
--- /dev/null
+++ b/doc/board/amlogic/bananapi-m2pro.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for BananaPi BPI-M2-PRO (S905X3)
+=======================================
+
+BananaPi BPI-M2-PRO is a Single Board Computer manufactured by Sinovoip with the
+following specification:
+
+ - Amlogic S905X3 Arm Cortex-A55 quad-core SoC
+ - 2GB DDR4 SDRAM
+ - 16GB eMMC
+ - Gigabit Ethernet
+ - RTL8821CU USB WiFi (a/b/g/n/ac) + BT 5.0
+ - HDMI 2.1 display
+ - 40-pin GPIO header
+ - 2x USB 3.0 Host
+ - 1x DC Jack (power)
+ - microSD
+ - UART serial
+ - Infrared receiver
+
+Schematics are available from the manufacturer: https://wiki.banana-pi.org/Banana_Pi_BPI-M2_Pro
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make bananapi-m2pro_defconfig
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
+    $ ./build-fip.sh bananapi-m2pro /path/to/u-boot/u-boot.bin my-output-dir
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
+    $ DIR=bananapi-m2pro
+    $ git clone --depth 1 https://github.com/Dangku/amlogic-u-boot.git -b odroidg12-v2015.01-c4-m5 $DIR
+
+    $ cd $DIR
+    $ make bananapi_m2pro_defconfig
+    $ make
+    $ export UBOOTDIR=$PWD
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+
+    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
+    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+    $ cp $UBOOTDIR/build/board/bananapi/bananpi_m5/firmware/acs.bin fip/
+    $ cp $UBOOTDIR/fip/g12a/bl2.bin fip/
+    $ cp $UBOOTDIR/fip/g12a/bl30.bin fip/
+    $ cp $UBOOTDIR/fip/g12a/bl31.img fip/
+    $ cp $UBOOTDIR/fip/g12a/ddr3_1d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/ddr4_1d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/ddr4_2d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/diag_lpddr4.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/lpddr3_1d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/lpddr4_1d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/lpddr4_2d.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/piei.fw fip/
+    $ cp $UBOOTDIR/fip/g12a/aml_ddr.fw fip/
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
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
+                                          --output fip/bl30_new.bin.g12a.enc \
+                                          --level v3
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
+                                          --output fip/bl30_new.bin.enc \
+                                          --level v3 --type bl30
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
+                                          --output fip/bl31.img.enc \
+                                          --level v3 --type bl31
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
+                                          --output fip/bl33.bin.enc \
+                                          --level v3 --type bl33 --compress lz4
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
+                                          --output fip/bl2.n.bin.sig
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
+                                          --output fip/u-boot.bin \
+                                          --bl2 fip/bl2.n.bin.sig \
+                                          --bl30 fip/bl30_new.bin.enc \
+                                          --bl31 fip/bl31.img.enc \
+                                          --bl33 fip/bl33.bin.enc \
+                                          --ddrfw1 fip/ddr4_1d.fw \
+                                          --ddrfw2 fip/ddr4_2d.fw \
+                                          --ddrfw3 fip/ddr3_1d.fw \
+                                          --ddrfw4 fip/piei.fw \
+                                          --ddrfw5 fip/lpddr4_1d.fw \
+                                          --ddrfw6 fip/lpddr4_2d.fw \
+                                          --ddrfw7 fip/diag_lpddr4.fw \
+                                          --ddrfw8 fip/aml_ddr.fw \
+                                          --ddrfw9 fip/lpddr3_1d.fw \
+                                          --level v3
+
+Then write the image to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 9b76bca427..8388acdd11 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -86,6 +86,7 @@ Board Documentation
    :maxdepth: 1
 
    bananapi-cm4io
+   bananapi-m2pro
    bananapi-m5
    beelink-gskingx
    beelink-gtking
-- 
2.34.1

