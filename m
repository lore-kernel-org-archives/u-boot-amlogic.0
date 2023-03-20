Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.11729.1679312826920002470
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:47:07 -0700
Received: by mail-wr1-f48.google.com with SMTP id h17so10028633wrt.8
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtzEjnqGRdFn/CH1z8MTrNU5zbERfjr+pOykLChRQ04=;
        b=BEGLFd/hT4H6FI8+yY2GEvin/zoPNE5H0D0xMvpSN1ChyNZif8tjqHM2mwb2miyIKK
         AUiszhMnqWoGe8UYXqI1hsbQ/PdqG0Z+UnQHAWg/NdCQOTLgs0lyztcR7cqvI/GozNE+
         FoSs2M6BThm9EEp0dHOvVaqa3NTnLb9fJseKvr8VQSdK0mVCclV+2sViOxoG38vXn6us
         +71gUHyL6h32lViRcz4z9BzSXSkuPZS3NoQiM3RN1RBrdQMdt/eyk36rU+sSjzoY/6ly
         1CqrYHK68OZPgnCXiuRNB+1NRqRe76PyRzY1GJi4dgKFXg7XB++U6leoKXQrx/DuU+BJ
         92eQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 33/33] doc: boards: amlogic: add documentation for ODROID-HC4
Date: Mon, 20 Mar 2023 11:46:09 +0000
Message-Id: <20230320114609.930145-34-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add separate documentation for the ODROID-HC4 board to ensure
users build U-Boot using the HC4 defconfig that enables PCIe
SATA boot. This avoids user frustration trying to boot after
using the C4 recipe which only works from SD card.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/index.rst      |   1 +
 doc/board/amlogic/odroid-hc4.rst | 141 +++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 doc/board/amlogic/odroid-hc4.rst

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 7c4c161e0d..9b76bca427 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -101,6 +101,7 @@ Board Documentation
    nanopi-k2
    odroid-c2
    odroid-c4
+   odroid-hc4
    odroid-n2
    odroid-n2l
    odroid-go-ultra
diff --git a/doc/board/amlogic/odroid-hc4.rst b/doc/board/amlogic/odroid-hc4.rst
new file mode 100644
index 0000000000..94c3312022
--- /dev/null
+++ b/doc/board/amlogic/odroid-hc4.rst
@@ -0,0 +1,141 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for ODROID-HC4 (S905X3)
+==============================
+
+ODROID-HC4 is a variant of the ODROID-C4 single board computer manufactured by Hardkernel
+with the following specification:
+
+ - Amlogic S905X3 Arm Cortex-A55 quad-core SoC
+ - 4GB DDR4 SDRAM
+ - 16MB XT25F128B SPI-NOR flash
+ - Gigabit Ethernet
+ - HDMI 2.1 display
+ - 7-pin GPIO header for OLED display and RTC
+ - 1x USB 2.0 host (micro)
+ - 2x SATA ports via ASM1061 PCIe to SATA controller
+ - microSD
+ - UART serial
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make odroid-hc4_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh odroid-hc4 /path/to/u-boot/u-boot.bin my-output-dir
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
+    $ DIR=odroid-hc4
+    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 $DIR
+
+    $ cd odroid-hc4
+    $ make odroidc4_defconfig
+    $ make
+    $ export UBOOTDIR=$PWD
+
+Go back to mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+
+    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
+    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+    $ cp $UBOOTDIR/build/board/hardkernel/odroidc4/firmware/acs.bin fip/
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
+                                                    --output fip/bl30_new.bin.g12a.enc \
+                                                    --level v3
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
+                                                   --output fip/bl30_new.bin.enc \
+                                                   --level v3 --type bl30
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
+                                                   --output fip/bl31.img.enc \
+                                                   --level v3 --type bl31
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
+                                                   --output fip/bl33.bin.enc \
+                                                   --level v3 --type bl33 --compress lz4
+    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
+                                                   --output fip/bl2.n.bin.sig
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
+Then write U-Boot to SD or SPI-NOR with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

