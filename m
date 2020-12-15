Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.10440.1608035545015217712
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 04:32:25 -0800
Received: by mail-wr1-f45.google.com with SMTP id y17so19652914wrr.10
        for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 04:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z9iUoQ4Wap4UDaUD9Nyn62MUTm5cihfXRRiq9AEQgeg=;
        b=mlgf6qe4S88imDnU/dtW/FEKtZrxQzMDx5FhOm01CnULODQzuWq9zrW6aKY7iDmwrt
         O7YuZzv0/tMoHli5oQMPVpdpEb/w9kjLNEDUNt51eI4BMBb5zO0l7e0UfdwAKKYPG8nS
         xryzoeRGdsB9OhKwLwgBGwSQKADyia67izve5T1Fyix5FraJXXX3zlqJiu8W49RfIDhC
         +fppLI7vGUhq18u0D/u72QW/Yv1VnNNXYaEQ93O18kKnA4ZOiAN6ORWID4DhECAjyBPP
         6vAtLEsyKp4Sei/JdnVKW8CB4vGx+ktviMZu4Ad9mfoIZuFnKplRd/vs3pbqkUgagCXE
         xh5g==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] boards: amlogic: update documentation for WeTek Core2
Date: Tue, 15 Dec 2020 12:32:14 +0000
Message-Id: <20201215123214.18661-4-christianshewitt@gmail.com>
In-Reply-To: <20201215123214.18661-1-christianshewitt@gmail.com>
References: <20201215123214.18661-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Update the device matrix and add build instructions.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/index.rst       |  3 +-
 doc/board/amlogic/wetek-core2.rst | 90 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/amlogic/wetek-core2.rst

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index cba1c7b726..a585d857df 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -17,7 +17,7 @@ This matrix concerns the actual source code version.
 +===============================+===========+=================+==============+============+============+=============+==============+
 | Boards                       	| Odroid-C2 | P212            | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
 |        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
-|        			| P200	    | LibreTech-CC v1 |	             |	          |            |	     | Odroid-C4    |
+|        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            |	     | Odroid-C4    |
 |        			| P201	    | LibreTech-AC v2 |	             |	          |            |             |              |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | UART                       	| **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
@@ -95,4 +95,5 @@ Board Documentation
    sei510
    sei610
    u200
+   wetek-core2
    w400
diff --git a/doc/board/amlogic/wetek-core2.rst b/doc/board/amlogic/wetek-core2.rst
new file mode 100644
index 0000000000..d2aeb90c3d
--- /dev/null
+++ b/doc/board/amlogic/wetek-core2.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0+
+U-Boot for WeTek Core2
+======================
+
+WeTek Core2 is an Android STB based on the Q200 reference design with
+the following specifications:
+
+ - Amlogic S912 ARM Cortex-A53 octo-core SoC @ 1.5GHz
+ - ARM Mali T820 GPU
+ - 3GB DDR4 SDRAM
+ - 10/100 Realtek RTL8152 Ethernet (internal USB)
+ - HDMI 2.0 4K/60Hz display
+ - 2x USB 2.0 Host, 1x USB 2.0 OTG (internal)
+ - 32GB eMMC
+ - microSD
+ - SDIO Wifi Module, Bluetooth
+ - Two channel IR receiver
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make wetek-core2_defconfig
+    $ make
+Image creation
+--------------
+
+Amlogic does not provide sources for the firmware or the tools needed
+to create the bootloader image, and WeTek has not publicly shared the
+precompiled FIP binaries. However the public Khadas VIM2 sources also
+work with the Core2 box so we can use the Khadas git tree:
+
+.. code-block:: bash
+    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
+    $ git clone https://github.com/khadas/u-boot -b khadas-vim-v2015.01 vim-u-boot
+    $ cd vim-u-boot
+    $ make kvim2_defconfig
+    $ make
+    $ export FIPDIR=$PWD/fip
+
+Go back to mainline U-Boot source tree then:
+
+.. code-block:: bash
+    $ mkdir fip
+    $ cp $FIPDIR/gxl/bl2.bin fip/
+    $ cp $FIPDIR/gxl/acs.bin fip/
+    $ cp $FIPDIR/gxl/bl21.bin fip/
+    $ cp $FIPDIR/gxl/bl30.bin fip/
+    $ cp $FIPDIR/gxl/bl301.bin fip/
+    $ cp $FIPDIR/gxl/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl30.bin \
+        fip/zero_tmp \
+        fip/bl30_zero.bin \
+        fip/bl301.bin \
+        fip/bl301_zero.bin \
+        fip/bl30_new.bin \
+        bl30
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+    $ $FIPDIR/blx_fix.sh \
+        fip/bl2_acs.bin \
+        fip/zero_tmp \
+        fip/bl2_zero.bin \
+        fip/bl21.bin \
+        fip/bl21_zero.bin \
+        fip/bl2_new.bin \
+        bl2
+    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+    $ $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+    $ $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
+    $ $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
+        --output fip/u-boot.bin \
+        --bl2 fip/bl2.n.bin.sig \
+        --bl30 fip/bl30_new.bin.enc \
+        --bl31 fip/bl31.img.enc \
+        --bl33 fip/bl33.bin.enc
+
+then write the image to SD with:
+
+.. code-block:: bash
+    $ DEV=/dev/your_sd_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
-- 
2.17.1

