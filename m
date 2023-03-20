Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.11710.1679312803007072354
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:47:04 -0700
Received: by mail-wr1-f42.google.com with SMTP id r29so10019808wra.13
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcpHorJlJda5nW//a0yVnoGJJXcKO2Y9Lk0g22JcFtE=;
        b=MQP62o7Uwihx4W/czKQHpX8N4RbqpjB4JI17TRrTXKtwuADXQALHgSKm8MuhN7EsIg
         z/MahH2YCuUvW2VmQs2anCFBLc+gQJAe8K2JDoHkfCZJe/IqMAwmStcVhKzwTHaiydQu
         mGe2zX+MOx4zKRSVuJHGGmTFBxZ4wBMSdu5IGqslJPIa6OMyODyIlqjEKOZWpR1oTfSU
         90F+RfkdHXcYYMt0rzQFrRndLlXA9GVaw0YsQkWPoqdX2tlXgkHW0UdjUXdVAFFwj60d
         DaMwSQ5SmcWrygOL9Am2vg3oi9Cj5lHvDrIixKl9GYR8ckO6tYHIOTfzckwC38GhtWu+
         ueiA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 32/33] doc: boards: amlogic: add documentation for GS-King-X
Date: Mon, 20 Mar 2023 11:46:08 +0000
Message-Id: <20230320114609.930145-33-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

GS-King-X is also supported with the beelink-s922x FIP sources and can use
the GT-King defconfig. Add a board document with instructions.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/beelink-s922x/MAINTAINERS |   3 +-
 doc/board/amlogic/beelink-gskingx.rst   | 121 ++++++++++++++++++++++++
 doc/board/amlogic/index.rst             |   1 +
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/amlogic/beelink-gskingx.rst

diff --git a/board/amlogic/beelink-s922x/MAINTAINERS b/board/amlogic/beelink-s922x/MAINTAINERS
index 47b622765a..8dddeb91d5 100644
--- a/board/amlogic/beelink-s922x/MAINTAINERS
+++ b/board/amlogic/beelink-s922x/MAINTAINERS
@@ -3,8 +3,9 @@ M:	Christian Hewitt <christianshewitt@gmail.com>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/beelink-s922x/
+F:	configs/beelink-gsking-x_defconfig
 F:	configs/beelink-gtking_defconfig
 F:	configs/beelink-gtkingpro_defconfig
-F:	configs/beelink-gsking-x_defconfig
+F:	doc/board/amlogic/beelink-gskingx.rst
 F:	doc/board/amlogic/beelink-gtking.rst
 F:	doc/board/amlogic/beelink-gtkingpro.rst
diff --git a/doc/board/amlogic/beelink-gskingx.rst b/doc/board/amlogic/beelink-gskingx.rst
new file mode 100644
index 0000000000..987d358c77
--- /dev/null
+++ b/doc/board/amlogic/beelink-gskingx.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GS-King-X (S922X)
+====================================
+
+The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference board with an
+S922X-H chip and the following specifications:
+
+- 4GB LPDDR4 RAM
+- 64GB eMMC storage
+- 10/100/1000 Base-T Ethernet
+- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
+- HDMI 2.1 video
+- S/PDIF optical output
+- 2x ESS9018 audio DACs
+- 4x Ricor RT6862 audio amps
+- Analogue headphone output
+- 1x USB 2.0 OTG port
+- 3x USB 3.0 ports
+- IR receiver
+- 1x micro SD card slot (internal)
+- USB SATA controller with 2x 3.5" drive bays
+- 1x Power on/off button
+
+Beelink do not provide public schematics, but have been willing to share them with known
+distro developers to assist with development.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make beelink-gsking-x_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh beelink-s922x /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Beelink released an Amlogic "SDK" dump in their forums but the U-Boot sources included
+result in 2GB RAM detected. The following FIPs were generated with newer sources and
+detect 4GB RAM: https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
+
+.. code-block:: bash
+
+    $ wget https://github.com/LibreELEC/amlogic-boot-fip/archive/master.zip
+    $ unzip master.zip
+    $ export FIPDIR=$PWD/amlogic-boot-fip/beelink-s922x
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+    $ cp $FIPDIR/* fip/
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
+    $ fip/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
+                           --output fip/bl30_new.bin.g12a.enc \
+                           --level v3
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
+                           --output fip/bl30_new.bin.enc \
+                           --level v3 --type bl30
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+                           --output fip/bl31.img.enc \
+                           --level v3 --type bl31
+    $ fip/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
+                           --output fip/bl33.bin.enc \
+                           --level v3 --type bl33
+    $ fip/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
+                           --output fip/bl2.n.bin.sig
+    $ fip/aml_encrypt_g12b --bootmk \
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
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 808c857622..7c4c161e0d 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -87,6 +87,7 @@ Board Documentation
 
    bananapi-cm4io
    bananapi-m5
+   beelink-gskingx
    beelink-gtking
    beelink-gtkingpro
    jethub-j80
-- 
2.34.1

