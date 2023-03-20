Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.11711.1679312804687239775
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:44 -0700
Received: by mail-wr1-f45.google.com with SMTP id j24so1128917wrd.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCUlzkd+ZiUVoODVUj+CDP7kcBJvcDYrO0Lw0y8ZFBw=;
        b=k7ltuPeuVkrAen+lIpq9si4Pj3SgyStetVbU0fJ6sFbf5kGvyjEqI7cAzCtXTAKpdb
         YE6s7rtq1EV5LZf2wzrcKJFhjXY/mJBjfpsCQwnwnylgoJjx7RKKB0Y3D9H/4AaymKIx
         jTk2S4FbC8H+UF0CfSpw06mbaAmb2ig3WnNUJA//8CM+TuIcFdcuNQul2RRsts/d4KJF
         /SqmnSbyrsWxFfzrGWtI61W8JfjAtZW5Pa1mZAVPyGoCW8mDUbJhtL9CoBhnvQWGp8Ms
         Uxbr/qARsA4gnMneMpVgRhclQN+UgcaCg2eyj44GVCS/cOFNF1MgeGEivujzw4YRcezy
         o6wA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 19/33] doc: boards: amlogic: update documentation for ODROID-N2L
Date: Mon, 20 Mar 2023 11:45:55 +0000
Message-Id: <20230320114609.930145-20-christianshewitt@gmail.com>
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
 doc/board/amlogic/odroid-n2l.rst | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/doc/board/amlogic/odroid-n2l.rst b/doc/board/amlogic/odroid-n2l.rst
index afd4409d1b..b264ace7f5 100644
--- a/doc/board/amlogic/odroid-n2l.rst
+++ b/doc/board/amlogic/odroid-n2l.rst
@@ -1,22 +1,23 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for ODROID-N2L
-=====================
+U-Boot for ODROID-N2L (S922X)
+=============================
 
-ODROID-N2L is a single board computer manufactured by Hardkernel
-Co. Ltd with the following specifications:
+ODROID-N2L is a Single Board Computer manufactured by Hardkernel with the following
+specifications:
 
  - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
  - 4GB DDR4 SDRAM
  - HDMI 2.1 4K/60Hz display
  - 40-pin GPIO header
- - 1 x USB 3.0 Host, 1 x USB USB 2.0 Host
+ - 1x USB 3.0 Host
+ - 1x USB 2.0 Host
  - eMMC, microSD
  - MIPI DSI Port
 
-Schematics are available on the manufacturer website.
+Schematics are available on the manufacturer website: https://wiki.odroid.com
 
-U-Boot compilation
+U-Boot Compilation
 ------------------
 
 .. code-block:: bash
@@ -25,7 +26,19 @@ U-Boot compilation
     $ make odroid-n2l_defconfig
     $ make
 
-Image creation
---------------
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
 
-For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-n2l`
+.. code-block:: bash
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh odroid-n2l /path/to/u-boot/u-boot.bin my-output-dir
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

