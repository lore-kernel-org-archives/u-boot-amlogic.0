Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.13986.1660643898496508555
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Aug 2022 02:58:19 -0700
Received: by mail-wm1-f41.google.com with SMTP id k17so4990545wmr.2
        for <u-boot-amlogic@groups.io>; Tue, 16 Aug 2022 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9wMsva0VxZ/uwRmr+FEJR3nSm7s7qLYvIqSsriOf6a0=;
        b=nIk14RdlkLmBOZ8ZglfYJIzRSTMpKiPmjCGA9NFyLxu1c4gb+edsiMvKGcgwWef6Yc
         wa68LcuMIdDo8ivy8yHP9gGDmPgBQ+UF7APJmEZruMNexKKZb7ST5b+n/wd+jOHpWmEc
         dz6JhtV50SWK+mNgt+kZsIuOR1P68H4+hGzNB4w6/AZll+EwVC+nqUt33rGcWtVXvZ/4
         pMSkyjjF8IxG180yJj3YE0jgFObssX72a81i3qEXmkHimp5I2BkbrOBytU5ltmC4fV2M
         Jh6UGvCWjD7ztwhDcRMl6n+3hoAG57jH04Mcm3k6TH6u+AvYLPWDb/1edaK5uE5hKXmI
         63AQ==
Return-Path: <narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] MAINTAINERS: Update email of Neil Armstrong
Date: Tue, 16 Aug 2022 11:58:08 +0200
Message-Id: <20220816095808.948933-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

From: Neil Armstrong <neil.armstrong@linaro.org>

My professional e-mail will change and the BayLibre one will
bounce after mid-september of 2022.

This updates the MAINTAINERS files and adds an entry in the
.mailmap file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .mailmap                            | 1 +
 MAINTAINERS                         | 2 +-
 board/amlogic/odroid-n2/MAINTAINERS | 2 +-
 board/amlogic/p200/MAINTAINERS      | 2 +-
 board/amlogic/p201/MAINTAINERS      | 2 +-
 board/amlogic/p212/MAINTAINERS      | 2 +-
 board/amlogic/q200/MAINTAINERS      | 2 +-
 board/amlogic/s400/MAINTAINERS      | 2 +-
 board/amlogic/sei510/MAINTAINERS    | 2 +-
 board/amlogic/sei610/MAINTAINERS    | 2 +-
 board/amlogic/u200/MAINTAINERS      | 2 +-
 board/amlogic/vim3/MAINTAINERS      | 2 +-
 board/amlogic/w400/MAINTAINERS      | 2 +-
 13 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/.mailmap b/.mailmap
index f27f366bcb..8acce4b2bf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -49,6 +49,7 @@ Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michal Simek <michal.simek@xilinx.com> <monstr@monstr.eu>
 Michal Simek <michal.simek@xilinx.com> <Monstr@seznam.cz>
 Michal Simek <michal.simek@xilinx.com> <root@monstr.eu>
+Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fa8c13fc7d..f0dfbc5450 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -143,7 +143,7 @@ F:	arch/arm/mach-socfpga/
 F:	drivers/sysreset/sysreset_socfpga*
 
 ARM AMLOGIC SOC SUPPORT
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
diff --git a/board/amlogic/odroid-n2/MAINTAINERS b/board/amlogic/odroid-n2/MAINTAINERS
index 43724e6fdd..23cc8e73b1 100644
--- a/board/amlogic/odroid-n2/MAINTAINERS
+++ b/board/amlogic/odroid-n2/MAINTAINERS
@@ -1,5 +1,5 @@
 ODROID-N2
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/odroid-n2/
diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
index 1df9b8b24b..33ca3df5c6 100644
--- a/board/amlogic/p200/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -1,6 +1,6 @@
 P200
 M:	Beniamino Galvani <b.galvani@gmail.com>
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p200/
diff --git a/board/amlogic/p201/MAINTAINERS b/board/amlogic/p201/MAINTAINERS
index 1501b6280d..4549d01cad 100644
--- a/board/amlogic/p201/MAINTAINERS
+++ b/board/amlogic/p201/MAINTAINERS
@@ -1,5 +1,5 @@
 P201
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p201/
diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index 3d622af29b..b2e3205fdf 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -1,5 +1,5 @@
 P212
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index ba7c12b2c1..9c84cca27e 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -1,5 +1,5 @@
 Q200
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINERS
index fb46b1bbbf..ca51bb6b3b 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -1,5 +1,5 @@
 S400
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
diff --git a/board/amlogic/sei510/MAINTAINERS b/board/amlogic/sei510/MAINTAINERS
index c01c1d60df..c6039bc82e 100644
--- a/board/amlogic/sei510/MAINTAINERS
+++ b/board/amlogic/sei510/MAINTAINERS
@@ -1,5 +1,5 @@
 SEI510
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei510/
diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
index 092178b2c8..799ad687f0 100644
--- a/board/amlogic/sei610/MAINTAINERS
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -1,5 +1,5 @@
 SEI610
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei610/
diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index a259d12886..47cec234a1 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -1,5 +1,5 @@
 U200
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
index d8848495c7..c5f8d9cc5c 100644
--- a/board/amlogic/vim3/MAINTAINERS
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -1,5 +1,5 @@
 VIM3
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim3/
diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 991590d9f2..96ccda2001 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -1,5 +1,5 @@
 W400
-M:	Neil Armstrong <narmstrong@baylibre.com>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
-- 
2.25.1

