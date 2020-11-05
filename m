Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web09.8951.1604589663983891590
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 07:21:04 -0800
Received: by mail-wr1-f66.google.com with SMTP id 33so2207209wrl.7
        for <u-boot-amlogic@groups.io>; Thu, 05 Nov 2020 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/7NSMAZLQjWUa/wlmECxSCCBnBjRJuU+l0xkM0jGlY=;
        b=xOSROOKn5HRrHtXpY1AwuVPoZb9JTPzPZq3lzPiadI2hQRn7zM+9SG4TpKvBTM9VKo
         BGpk9/gS+LAdTR7IimjKU/nyDpXDx7jbsiULybG1DO9iBwX6olmHX581xU/94atb1gCA
         vkwcqDinTJrbzYUIdH67OZiunIIjNWTE0vuOXeyS8IH1WyhCV5ikItSVRvrqno3qFnhG
         Pvo11dZJuGzyjp32URDWY6eJY1CCyKrba9D4uyi9eQRqleJCbB3iNo9fAQc3JTRBefl4
         m8d+YIkQTyZcc13pTLQgdxS6HIE9TiYRfmrUu8FzVdU+XuuZ2ANW125ajNeQbsr2P8VX
         lUYw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] doc: board: vim3: Fix build instructions
Date: Thu,  5 Nov 2020 16:18:57 +0100
Message-Id: <20201105151857.1985411-2-narmstrong@baylibre.com>
In-Reply-To: <20201105151857.1985411-1-narmstrong@baylibre.com>
References: <20201105151857.1985411-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The build instructions were buggy and changed a little since they
were written.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/khadas-vim3.rst  |  9 +++++----
 doc/board/amlogic/khadas-vim3l.rst | 11 +++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/board/amlogic/khadas-vim3.rst b/doc/board/amlogic/khadas-vim3.rst
index d6a9642ad6..8b7196d988 100644
--- a/doc/board/amlogic/khadas-vim3.rst
+++ b/doc/board/amlogic/khadas-vim3.rst
@@ -76,15 +76,16 @@ the git tree published by the board vendor:
 
     $ cd vim3-u-boot
     $ make kvim3_defconfig
-    $ make
+    $ make CROSS_COMPILE=aarch64-none-elf-
     $ export UBOOTDIR=$PWD
 
- Go back to mainline U-Boot source tree then :
+Go back to mainline U-Boot source tree then :
 
 .. code-block:: bash
 
     $ mkdir fip
 
+    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
     $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
     $ cp $UBOOTDIR/build/board/khadas/kvim3/firmware/acs.bin fip/
     $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
@@ -101,7 +102,7 @@ the git tree published by the board vendor:
     $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
     $ cp u-boot.bin fip/bl33.bin
 
-    $ sh fip/blx_fix.sh \
+    $ bash fip/blx_fix.sh \
     	fip/bl30.bin \
     	fip/zero_tmp \
     	fip/bl30_zero.bin \
@@ -110,7 +111,7 @@ the git tree published by the board vendor:
     	fip/bl30_new.bin \
     	bl30
 
-    $ sh fip/blx_fix.sh \
+    $ bash fip/blx_fix.sh \
     	fip/bl2.bin \
     	fip/zero_tmp \
     	fip/bl2_zero.bin \
diff --git a/doc/board/amlogic/khadas-vim3l.rst b/doc/board/amlogic/khadas-vim3l.rst
index 3c0a415a87..aed8955391 100644
--- a/doc/board/amlogic/khadas-vim3l.rst
+++ b/doc/board/amlogic/khadas-vim3l.rst
@@ -48,6 +48,8 @@ Then power-cycle the board.
 U-Boot compilation
 ------------------
 
+.. code-block:: bash
+
     $ export CROSS_COMPILE=aarch64-none-elf-
     $ make khadas-vim3l_defconfig
     $ make
@@ -74,15 +76,16 @@ the git tree published by the board vendor:
 
     $ cd vim3l-u-boot
     $ make kvim3l_defconfig
-    $ make
+    $ make CROSS_COMPILE=aarch64-none-elf-
     $ export UBOOTDIR=$PWD
 
- Go back to mainline U-Boot source tree then :
+Go back to mainline U-Boot source tree then :
 
 .. code-block:: bash
 
     $ mkdir fip
 
+    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
     $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
     $ cp $UBOOTDIR/build/board/khadas/kvim3l/firmware/acs.bin fip/
     $ cp $UBOOTDIR/fip/g12a/bl2.bin fip/
@@ -99,7 +102,7 @@ the git tree published by the board vendor:
     $ cp $UBOOTDIR/fip/g12a/aml_ddr.fw fip/
     $ cp u-boot.bin fip/bl33.bin
 
-    $ sh fip/blx_fix.sh \
+    $ bash fip/blx_fix.sh \
     	fip/bl30.bin \
     	fip/zero_tmp \
     	fip/bl30_zero.bin \
@@ -108,7 +111,7 @@ the git tree published by the board vendor:
     	fip/bl30_new.bin \
     	bl30
 
-    $ sh fip/blx_fix.sh \
+    $ bash fip/blx_fix.sh \
     	fip/bl2.bin \
     	fip/zero_tmp \
     	fip/bl2_zero.bin \
-- 
2.25.1

