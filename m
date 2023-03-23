Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.66611.1679554508222717633
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 23:55:18 -0700
Received: by mail-wr1-f41.google.com with SMTP id i9so19324828wrp.3
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlFxVkOUcTjIg+gr4Rq5oVtAcsKoR2mAEejaZ6YIadk=;
        b=gJfGIhqqWPTnk8er7dou4aF1OizKMazALo89TsgQVEYRN+PudMIbDyDTHxCJlfGDH8
         1VYck7N+aC++RK7dxiISwg0hGzENNTknzbrfEkgkg6QLtO2i6tRqnfiSvmIEHy9b+MFU
         9SqSr7zEwiAULp29l8G2VsRy07U8YjijJCj9gNSIZAL3syj/GsEdHbeHIaNdP0RWxuMA
         VkeG25enM3wNwkMl5Umrbah1Uzz7oeJ2wBhPDabym2LlSgCY0LYnQME8TfKrsOTT3Msy
         1BEty0XPa+AZp9d05L6gCgnEFO7Wy8Vx6mNAKp8S2aUxSPH+V4wLdLBSUx+/opDPAW7L
         jkaQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 10/13] doc: boards: amlogic: add documentation for Radxa Zero2
Date: Thu, 23 Mar 2023 06:54:55 +0000
Message-Id: <20230323065458.776029-11-christianshewitt@gmail.com>
In-Reply-To: <20230323065458.776029-1-christianshewitt@gmail.com>
References: <20230323065458.776029-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add build docs for the Radxa Zero2 board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/w400/MAINTAINERS    |  2 +
 doc/board/amlogic/index.rst       |  1 +
 doc/board/amlogic/radxa-zero2.rst | 79 +++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 doc/board/amlogic/radxa-zero2.rst

diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 042b523056..117f79ea04 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -5,6 +5,8 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
 F:	configs/bananapi-cm4-cm4io_defconfig
 F:	configs/bananapi-m2s_defconfig
+F:	configs/radxa-zero2_defconfig
 F:	doc/board/amlogic/w400.rst
 F:	doc/board/amlogic/bananapi-cm4io.rst
 F:	doc/board/amlogic/bananapi-m2s.rst
+F:	doc/board/amlogic/radxa-zero2.rst
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index fa1b362731..71b7e1f3ed 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -112,6 +112,7 @@ Board Documentation
    p212
    q200
    radxa-zero
+   radxa-zero2
    sei510
    sei610
    s400
diff --git a/doc/board/amlogic/radxa-zero2.rst b/doc/board/amlogic/radxa-zero2.rst
new file mode 100644
index 0000000000..3fb5d360e8
--- /dev/null
+++ b/doc/board/amlogic/radxa-zero2.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Radxa Zero2 (A311D)
+==============================
+
+Radxa Zero2 is a small form factor SBC based on the Amlogic A311D chipset with the
+following specification:
+
+- Amlogic A311D (Quad A73 + Dual A53) CPU
+- 4GB LPDDR4 RAM
+- 32/64/128GB eMMC
+- Mali G52-MP4 GPU
+- HDMI 2.1 output (micro)
+- BCM4345 WiFi (2.4/5GHz a/b/g/n/ac) and BT 5.0
+- 1x USB 2.0 port - Type C (OTG)
+- 1x USB 3.0 port - Type C (Host)
+- 1x micro SD Card slot
+- 40 Pin GPIO header
+
+Schematics are available on request from Radxa.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make radxa-zero2_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh radxa-zero2 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide sources for the firmware and tools needed to create a bootloader
+image so it is necessary to obtain binaries from sources published by the board vendor:
+
+.. code-block:: bash
+
+    $ git clone -b radxa-zero-v2021.07 https://github.com/radxa/u-boot.git
+    $ git clone https://github.com/radxa/fip.git
+
+    $ sudo apt-get install -y gcc-aarch64-linux-gnu device-tree-compiler libncurses5 libncurses5-dev
+    $ sudo apt-get install -y bc python dosfstools flex build-essential libssl-dev mtools
+
+    $ wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz
+    $ sudo tar xvf gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz -C /opt
+
+    $ export CROSS_COMPILE=/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin/aarch64-none-elf-
+    $ export ARCH=arm
+    $ cd u-boot
+    $ make radxa-zero2_defconfig
+    $ make
+
+    $ cp u-boot.bin ../fip/radxa-zero2/bl33.bin
+    $ cd ../fip/radxa-zero2
+    $ make
+
+This will generate the signed U-Boot binaries:
+
+.. code-block:: bash
+
+    $ u-boot.bin u-boot.bin.sd.bin u-boot.bin.usb.bl2 u-boot.bin.usb.tpl
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

