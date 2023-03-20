Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.11709.1679312801345581356
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:41 -0700
Received: by mail-wm1-f51.google.com with SMTP id p16so7275014wmq.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8RZphyBX8i1O0montdtL5/Jas1xXVgSIZdOxXX4/e0=;
        b=VY9XJ+CGZDVB3V3QR7JXxW499vtk1P2wkMT1TLNEvjXV/nHRj6B719no8+r/e1X8zF
         +1+YgHFn1DGVN8ZEmqv394mO4vjAk3hrGG7ZApaeTFhEIX/VkTcGNpkhVlg+H397Msch
         n+JOtQNq/8pHOUoW9CP8FZukUSdw7FsYutrNnESNGrNz3CSkZ8TpPBiSkHfNOycJjzbC
         hNQ6X2TV5DvoEul4O1UmpRFAXr9VwJe/cE57zfZxjgoLIBdDfx11iRinQ/1gTpTtNIyj
         SaQSAHy81XV6ahfbVlC1Afp7TUvnibggPUTJU8z+azMQoIcJUin84EhxEUbhyOwTdaXw
         beHA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 17/33] doc: boards: amlogic: update documentation for ODROID GO ULTRA
Date: Mon, 20 Mar 2023 11:45:53 +0000
Message-Id: <20230320114609.930145-18-christianshewitt@gmail.com>
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
 doc/board/amlogic/odroid-go-ultra.rst | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/doc/board/amlogic/odroid-go-ultra.rst b/doc/board/amlogic/odroid-go-ultra.rst
index 8df9e0cb79..50d91394d4 100644
--- a/doc/board/amlogic/odroid-go-ultra.rst
+++ b/doc/board/amlogic/odroid-go-ultra.rst
@@ -1,10 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for ODROID-GO-ULTRA
+U-Boot for ODROID-GO-ULTRA (S922X)
 ==========================
 
-The Odroid Go Ultra is a portable gaming device with the following
-characteristics:
+The ODROID GO ULTRA is a portable gaming device with the following characteristics:
 
  - Amlogic S922X SoC
  - RK817 & RK818 PMICs
@@ -19,7 +18,7 @@ characteristics:
  - 2x ADC Analog Joysticks
  - USB-C Port for USB2 Device and Charging
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -28,7 +27,19 @@ U-Boot compilation
     $ make odroid-go-ultra_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-Pleaser refer to :doc:`pre-generated-fip` with codename `odroid-go-ultra`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh odroid-go-ultra /path/to/u-boot/u-boot.bin my-output-dir
+
+Then write the image to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.34.1

