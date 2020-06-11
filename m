Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.7347.1591882132086756828
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Jun 2020 06:28:52 -0700
Received: by mail-wm1-f68.google.com with SMTP id r15so5054129wmh.5
        for <u-boot-amlogic@groups.io>; Thu, 11 Jun 2020 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6PyXQH2FWfcbnW9OctBhNMzGv1IOU2d7N0hxC52CFs=;
        b=pyNQqne86XSDbax/aF/syjgptrkDg1p+CDnBUzFLPSDBBh8Cs6pNXGUgHSgOJTiAxW
         DDRMgxq+XV7gc4kl9/ESYDHRkMuwW7fpbRcaTNaeeaXh+fNJqjkJILXjk10BUSCN5cM8
         CenJ2VcLSLFARB96kJEpQyoovxeUTpOxYH3JKMLtWsuJltrUZRPoiW5RFMSrLN/ARMoZ
         7ARIxoTHPQChwwmT2Vbv4E42L+9GZphS8DBJwfcd4iznCviFvWfmED9FPOVbDm86k2r6
         0qmftCk/zy286vSXKvjL+x9q7avpaMRf9YS3wCkWxEfE0QIh2UnND987QC69YlYS9yFD
         zelA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] board: amlogic: add board doc files to MAINTAINERS
Date: Thu, 11 Jun 2020 15:28:41 +0200
Message-Id: <20200611132841.6546-3-narmstrong@baylibre.com>
In-Reply-To: <20200611132841.6546-1-narmstrong@baylibre.com>
References: <20200611132841.6546-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, xypron.glpk@gmx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the recently added reStructuredText board documentation in the
appropriate MAINTAINERS files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS                      | 1 +
 board/amlogic/p200/MAINTAINERS   | 3 +++
 board/amlogic/p201/MAINTAINERS   | 1 +
 board/amlogic/p212/MAINTAINERS   | 4 ++++
 board/amlogic/q200/MAINTAINERS   | 1 +
 board/amlogic/s400/MAINTAINERS   | 1 +
 board/amlogic/sei510/MAINTAINERS | 1 +
 board/amlogic/sei610/MAINTAINERS | 1 +
 board/amlogic/u200/MAINTAINERS   | 1 +
 board/amlogic/w400/MAINTAINERS   | 4 ++++
 10 files changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fd975c72f..fb904ba7db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -145,6 +145,7 @@ F:	drivers/power/domain/meson-gx-pwrc-vpu.c
 F:	drivers/video/meson/
 F:	include/configs/meson64.h
 F:	include/configs/meson64_android.h
+F:	doc/board/amlogic/
 N:	meson
 
 ARM BROADCOM BCM283X
diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
index c20f056af2..1df9b8b24b 100644
--- a/board/amlogic/p200/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -7,3 +7,6 @@ F:	board/amlogic/p200/
 F:	configs/nanopi-k2_defconfig
 F:	configs/odroid-c2_defconfig
 F:	configs/p200_defconfig
+F:	doc/board/amlogic/p200.rst
+F:	doc/board/amlogic/nanopi-k2.rst
+F:	doc/board/amlogic/odroid-c2.rst
diff --git a/board/amlogic/p201/MAINTAINERS b/board/amlogic/p201/MAINTAINERS
index f84984d7ab..1501b6280d 100644
--- a/board/amlogic/p201/MAINTAINERS
+++ b/board/amlogic/p201/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p201/
 F:	configs/p201_defconfig
+F:	doc/board/amlogic/p201.rst
diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index 8848df05b7..cae6994393 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -8,3 +8,7 @@ F:	configs/khadas-vim_defconfig
 F:	configs/libretech-ac_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/p212_defconfig
+F:	doc/board/amlogic/p212.rst
+F:	doc/board/amlogic/libretech-ac.rst
+F:	doc/board/amlogic/libretech-cc.rst
+F:	doc/board/amlogic/khadas-vim.rst
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index 6f00f87386..ec05aa6f4c 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -7,3 +7,4 @@ F:	include/configs/q200.h
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
 F:	configs/libretech-s912-pc_defconfig
+F:	doc/board/amlogic/khadas-vim2.rst
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINERS
index da90cf9b6f..fb46b1bbbf 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -5,3 +5,4 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
 F:	include/configs/s400.h
 F:	configs/s400_defconfig
+F:	doc/board/amlogic/s400.rst
diff --git a/board/amlogic/sei510/MAINTAINERS b/board/amlogic/sei510/MAINTAINERS
index 8dc655e8cc..c01c1d60df 100644
--- a/board/amlogic/sei510/MAINTAINERS
+++ b/board/amlogic/sei510/MAINTAINERS
@@ -5,3 +5,4 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei510/
 F:	configs/sei510_defconfig
 F:	include/configs/sei510.h
+F:	doc/board/amlogic/sei510.rst
diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
index da77aafa41..092178b2c8 100644
--- a/board/amlogic/sei610/MAINTAINERS
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -5,3 +5,4 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei610/
 F:	configs/sei610_defconfig
 F:	include/configs/sei610.h
+F:	doc/board/amlogic/sei610.rst
diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index 5ae7f5e66a..8c23f9a7d3 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
 F:	configs/u200_defconfig
+F:	doc/board/amlogic/u200.rst
diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 2ff90039ca..5e837cfaef 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -6,3 +6,7 @@ F:	board/amlogic/w400/
 F:	configs/khadas-vim3_defconfig
 F:	configs/khadas-vim3l_defconfig
 F:	configs/odroid-n2_defconfig
+F:	doc/board/amlogic/w400.rst
+F:	doc/board/amlogic/khadas-vim3.rst
+F:	doc/board/amlogic/khadas-vim3l.rst
+F:	doc/board/amlogic/odroid-n2.rst
-- 
2.22.0

