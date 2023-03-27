Received: from sonic305-47.consmr.mail.sg3.yahoo.com (sonic305-47.consmr.mail.sg3.yahoo.com [106.10.241.110])
 by mx.groups.io with SMTP id smtpd.web10.41520.1679936641200797777
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 10:04:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679936639; bh=tH9wJ6xGH9/EtYc7bbSFy0qsNNL+XXrvh8H3lvwWvNk=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=CnOaxR2w6MJoZYtRYuqh/vuZVwN7NJLOXyFbLezMTk9j9UByeVnMiZNkSgbhTqE+SjOUEvBR2BgBDX24Uq+PjKk4abV7RaM/KjYEpqkGLrMkqb6XZrNGiEjVaC5Wu/8GmoO4n4/pdKEh3jUZPmruByUFYd81gIMpxYZlRhSsrPY3YlfsIFJz6raSyquZh/8y5xvMpHfH3M5vqwdbxSjLTH8S1PbMIGnnwO4s+XpVG7MRKX9ZUpZy8VKev3xBkz8n91rcOH0cgcxi3uwYae2cPG5Yw6w8SQYPkfZa6Z+qWwxHc7Sgg1Km8uNR/BCEkeevidHedwx2C8TCIreDixk0ww==
Message-ID: <8760391a-3506-5ac5-8d55-92c23cccff44@yahoo.com>
Date: Tue, 28 Mar 2023 04:15:15 +0800
MIME-Version: 1.0
From: "Karl Chan" <exkcmailist@yahoo.com>
Subject: [PATCHv8 3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
References: <8760391a-3506-5ac5-8d55-92c23cccff44.ref@yahoo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add build instructions for the Beelink GT1 Ultimate board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
  board/amlogic/q200/MAINTAINERS             |   2 +
  doc/board/amlogic/beelink-gt1-ultimate.rst | 110 +++++++++++++++++++++
  2 files changed, 112 insertions(+)
  create mode 100644 doc/board/amlogic/beelink-gt1-ultimate.rst

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index 9c84cca27e..aece8d5e05 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -4,9 +4,11 @@ S:    Maintained
  L:    u-boot-amlogic@groups.io
  F:    board/amlogic/q200/
  F:    include/configs/q200.h
+F:    configs/beelink-gt1-ultimate_defconfig
  F:    configs/khadas-vim2_defconfig
  F:    configs/libretech-s905d-pc_defconfig
  F:    configs/libretech-s912-pc_defconfig
  F:    configs/wetek-core2_defconfig
+F:    doc/board/amlogic/beelink-gt1-ultimate.rst
  F:    doc/board/amlogic/khadas-vim2.rst
  F:    doc/board/amlogic/wetek-core2.rst
diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst 
b/doc/board/amlogic/beelink-gt1-ultimate.rst
new file mode 100644
index 0000000000..42779495df
--- /dev/null
+++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Beelink GT1 Ultimate (S912)
+======================================
+
+Beelink GT1 Ultimate is an Android STB manufactured by Shenzen AZW 
(Beelink) with the
+following specification:
+
+- 2GB or 3GB DDR3 RAM
+- 32GB eMMC
+- HDMI 2.1 video
+- S/PDIF optical output
+- 10/100/1000 Ethernet
+- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.2)
+- 3x USB 2.0 ports
+- IR receiver
+- 1x micro SD card slot
+- 1x Power LED (white)
+- 1x Reset button (internal)
+
+The GT1 (non-ultimate) board has QCA9377 WiFi/BT but is otherwise 
identical and should
+be capable of booting images prepared for the Ultimate box (NB: there 
are known clones
+of both boxes which may differ in specifications).
+
+Beelink do not provide public schematics, but have been willing to 
share them with known
+distro developers on request.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make beelink-gt1-ultimate_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
+
+U-Boot Manual Signing
+---------------------
+
+Amlogic does not provide firmware sources or tools needed to create the 
bootloader image
+and Beelink has not publicly shared the U-Boot sources needed to build 
the FIP binaries
+for signing. However you can download them from the amlogic-fip-repo.
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip/beelink-gt1
+    $ export FIPDIR=$PWD
+
+Go back to the mainline U-Boot source tree then:
+
+.. code-block:: bash
+
+    $ mkdir fip
+    $ cp $FIPDIR/bl2.bin fip/
+    $ cp $FIPDIR/acs.bin fip/
+    $ cp $FIPDIR/bl21.bin fip/
+    $ cp $FIPDIR/bl30.bin fip/
+    $ cp $FIPDIR/bl301.bin fip/
+    $ cp $FIPDIR/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
+
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
+
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output 
fip/bl2.n.bin.sig
+    $ $FIPDIR/aml_encrypt_gxl --bootmk \
+                              --output fip/u-boot.bin \
+                              --bl2 fip/bl2.n.bin.sig \
+                              --bl30 fip/bl30_new.bin.enc \
+                              --bl31 fip/bl31.img.enc \
+                              --bl33 fip/bl33.bin.enc
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 
skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.40.0
