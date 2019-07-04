Received: by mail-wm1-f67.google.com with SMTP id c6so6299762wml.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xU2CkCALs7KGGS6n6LmgR4pVhprtnQR6e3XTZXYWvN4=;
        b=lCcJg+yv7mePdJuFNExw7MWerhfVIPcmD4Kkk7HNBgJaAkgbf6qx+I/U31ZFHsZZ8D
         2j4V1w5TMu+WLOwmr71HqFZBWpLqUKmX34IFgISaVRCRDUx0P0WgSJBtycy8pHiYYpwR
         ur8ob8y56hw92f+l7YZRJu9zlDB49sp1iyQFLdZ5ayJT1fTTlsFzRORmLkO518s+1oC2
         8382MCw//Ox+nHt7GCfooDUnOv0XJgzwXNnipHSv1lkBTFjzLDncVs7AGfq9WQ+F2Vn3
         Z5Wd0eY9cDtO6nBruGYzIa49oGpct/UxRxz3A9rOaKlCInJf7+YL8A/XSHBagegbmawJ
         QUVg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] board: amlogic: add mailing-list to MAINTAINERS
Date: Thu,  4 Jul 2019 15:59:38 +0200
Message-Id: <20190704135938.1193-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add missing mailing-list to the amlogic boards MAINTAINERS file.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/p200/MAINTAINERS | 1 +
 board/amlogic/p201/MAINTAINERS | 1 +
 board/amlogic/p212/MAINTAINERS | 1 +
 board/amlogic/q200/MAINTAINERS | 1 +
 board/amlogic/s400/MAINTAINERS | 1 +
 board/amlogic/u200/MAINTAINERS | 1 +
 6 files changed, 6 insertions(+)

diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
index 96fe92dd08..c20f056af2 100644
--- a/board/amlogic/p200/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -2,6 +2,7 @@ P200
 M:	Beniamino Galvani <b.galvani@gmail.com>
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p200/
 F:	configs/nanopi-k2_defconfig
 F:	configs/odroid-c2_defconfig
diff --git a/board/amlogic/p201/MAINTAINERS b/board/amlogic/p201/MAINTAINERS
index 3e84a8e2a2..f84984d7ab 100644
--- a/board/amlogic/p201/MAINTAINERS
+++ b/board/amlogic/p201/MAINTAINERS
@@ -1,5 +1,6 @@
 P201
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p201/
 F:	configs/p201_defconfig
diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index 74ad3716ec..8848df05b7 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -1,6 +1,7 @@
 P212
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
 F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index be86386619..d3c5a4617b 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -1,6 +1,7 @@
 Q200
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
 F:	include/configs/q200.h
 F:	configs/khadas-vim2_defconfig
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINERS
index 9ca9836016..da90cf9b6f 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -1,6 +1,7 @@
 S400
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
 F:	include/configs/s400.h
 F:	configs/s400_defconfig
diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index baf3813fd0..5ae7f5e66a 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -1,5 +1,6 @@
 U200
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
+L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
 F:	configs/u200_defconfig
-- 
2.21.0

