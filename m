Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.11624.1679312811465747821
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:51 -0700
Received: by mail-wr1-f52.google.com with SMTP id j2so10026596wrh.9
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7cjgEYI29KMpo57s2rb53lbtSRPUWD30me1nYvBnTc=;
        b=FnN/BII+srkmdFKf94GZ/ZocC6Tdd5uk6upz+b/KabXgMVGSwGzdAzQISOmTUiB4aT
         i5WYeSUrHDcE24OJab2R55h3m9xXSpRSegESwQjz+m0LyZsjkCQ4XReoxolwpY49tv5R
         09Pj0tJ8efu5tOrYLlnQp2g3iqUGy6kH4xhyyoo8jOjJtOSPDdT4Slo/OkhcAgsPpONA
         5HameRJfIAVVtUNDACCgSnp8MGITp77B1NXVFhZSY0aB+7ukLu63BmaR1aQFQOgkj4+F
         GMJ3Tthi+tc1i5pVHypcZb5zVI/djWeTNaZKiCgMpMjjju2uO/fcOwnChJ3W7QrwyhlW
         n6GQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 23/33] doc: boards: amlogic: update documentation for Radxa Zero
Date: Mon, 20 Mar 2023 11:45:59 +0000
Message-Id: <20230320114609.930145-24-christianshewitt@gmail.com>
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
 doc/board/amlogic/radxa-zero.rst | 45 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/doc/board/amlogic/radxa-zero.rst b/doc/board/amlogic/radxa-zero.rst
index f5611f52ec..e8a8d87320 100644
--- a/doc/board/amlogic/radxa-zero.rst
+++ b/doc/board/amlogic/radxa-zero.rst
@@ -1,14 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for Radxa Zero
-=====================
+U-Boot for Radxa Zero (S905Y2)
+==============================
 
-Radxa Zero is a small form factor SBC based on the Amlogic S905Y2
-chipset that ships in a number of RAM/eMMC configurations:
+Radxa Zero is a small form factor SBC based on the Amlogic S905Y2 chipset that ships in
+a number of RAM/eMMC configurations:
 
-Boards with 512MB/1GB LPDDR4 RAM have no eMMC storage and BCM43436
-wireless (2.4GHz b/g/n) while 2GB/4GB boards have 8/16/32/64/128GB
-eMMC storage and BCM4345 wireless (2.4/5GHz a/b/g/n/ac).
+512MB/1GB LPDDR4 RAM boards have no eMMC and BCM43436 wireless (2.4GHz b/g/n) while the
+2GB/4GB boards have 8/16/32/64/128GB eMMC and BCM4345 wireless (2.4/5GHz a/b/g/n/ac).
 
 - Amlogic S905Y2 quad-core Cortex-A53
 - Mali G31-MP2 GPU
@@ -18,11 +17,9 @@ eMMC storage and BCM4345 wireless (2.4/5GHz a/b/g/n/ac).
 - 1x micro SD Card slot
 - 40 Pin GPIO header
 
-Schematics are available on the manufacturer website:
+Schematics are available on the manufacturer website: https://dl.radxa.com/zero/docs/hw
 
-https://dl.radxa.com/zero/docs/hw/RADAX_ZERO_V13_SCH_20210309.pdf
-
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -31,14 +28,20 @@ U-Boot compilation
     $ make radxa-zero_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh radxa-zero /path/to/u-boot/u-boot.bin my-output-dir
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `radxa-zero`
+U-Boot Manual Signing
+---------------------
 
-Amlogic does not provide sources for the firmware and for tools needed
-to create the bootloader image, so it is necessary to obtain them from
-git trees published by the board vendor:
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
 
 .. code-block:: bash
 
@@ -61,16 +64,16 @@ git trees published by the board vendor:
     $ cd ../fip/radxa-zero
     $ make
 
-This will generate:
+This will generate the signed U-Boot binaries:
 
 .. code-block:: bash
 
     $ u-boot.bin u-boot.bin.sd.bin u-boot.bin.usb.bl2 u-boot.bin.usb.tpl
 
-Then write the image to SD with:
+Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/your_sd_device
+    $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

