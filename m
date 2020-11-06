Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.9529.1604655005185345143
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:30:05 -0800
Received: by mail-wm1-f52.google.com with SMTP id v5so690578wmh.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZXxXKv1o/OXMBOlAPV0583wkUDZ+PKP+fWiGr0q5fs=;
        b=tAymI5pnbnQ/a3MqHkrzwm2ylcp/dxTlU9wiRZKVPVDXX5R5xY2l/ThhvzuvoHZGQn
         B5uRWiWSHh3gCO05wyZwvMjxIglke0aHY8NEqTDNdFuOVdvwRjzSEsZLJ2Dzkpq+SqJr
         Rt8u0vCPaPaA31Rd8y6NhxcUpC7iQGZrIt5I/D8J31hhJ1w/04z8T+j/U1/DAPduWrFK
         6FxxFHo0DoQlrw/Ayfu/QTMZqgNXs808W6iCI8aRigsoOcP04LkBB9iha5wUvIrNHQa3
         ZYxmTD6cg1nKTWMbx/D77HAX0tMcx/6QWIx+o0jpqQqrUEaO0WsGEO52mVXl6h5cVofY
         oHRA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] ARM: dts: meson-sm1: add u-boot specific MMC controller compatible
Date: Fri,  6 Nov 2020 10:27:55 +0100
Message-Id: <20201106092755.2250773-4-narmstrong@baylibre.com>
In-Reply-To: <20201106092755.2250773-1-narmstrong@baylibre.com>
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to enable the Amlogic SM1 MMC controller fix, we need to add a u-boot specific
MMC controller compatible.

This adds a new meson-sm1-u-boot.dtsi and reworks the other -u-boot.dtsi
to use this for SM1 based boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |  1 +
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  2 --
 .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  1 +
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |  2 +-
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |  2 +-
 arch/arm/dts/meson-sm1-u-boot.dtsi            | 20 +++++++++++++++++++
 6 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
index f66eca14b1..489efa150a 100644
--- a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
@@ -4,4 +4,5 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include "meson-g12-common-u-boot.dtsi"
 #include "meson-khadas-vim3-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
index b5da4fdfc3..81fd5be378 100644
--- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
@@ -4,8 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12-common-u-boot.dtsi"
-
 / {
 	aliases {
 		spi0 = &spifc;
diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
index f66eca14b1..a591c0c9f2 100644
--- a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
@@ -4,4 +4,5 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include "meson-sm1-u-boot.dtsi"
 #include "meson-khadas-vim3-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
index 2a8f0545b1..c431988075 100644
--- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12-common-u-boot.dtsi"
+#include "meson-sm1-u-boot.dtsi"
 
 &ethmac {
 	snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
diff --git a/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi b/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
index 236f2468dc..8ebc1caa4a 100644
--- a/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12-common-u-boot.dtsi"
+#include "meson-sm1-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-sm1-u-boot.dtsi b/arch/arm/dts/meson-sm1-u-boot.dtsi
new file mode 100644
index 0000000000..e05d4c369a
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
+
+&sd_emmc_a {
+	compatible = "amlogic,meson-sm1-mmc";
+};
+
+&sd_emmc_b {
+	compatible = "amlogic,meson-sm1-mmc";
+};
+
+&sd_emmc_c {
+	compatible = "amlogic,meson-sm1-mmc";
+};
+
-- 
2.25.1

