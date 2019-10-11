Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web10.1858.1570808047275872893
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:07 -0700
Received: by mail-wr1-f65.google.com with SMTP id q9so12420901wrm.8
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgUkGkduoYyL477OGGAufRrrKJDKH4+PCbPRhb3yxd8=;
        b=QOHLLtD0PZRagHTnfRF39I8+YZ93NkNnKbdl0Xo4O1BOZNa2Me3fMH8AdC24SZ/pKJ
         F6zwhqg0vxRJ1bIMjQ0S6ZxTat18QSH4RGcMlhZGFFQIPN9SjdkOD0ujc0OMEvFRDwjM
         Ewx0u4wWVYCHWC/oy7dUF1SG9Ni/HRhYOjrFrV+dPfzrtfuBmebQGVfZ4lA4UwjXNY14
         GKw3Zlhl+m4P/3MT+MnNLANkwTqqMs9YAvaNhSbN2izs5ECauXo5aPThMBDrPRFfTVnw
         lrjsTNQTo7K6HWPoJJbdf818KRa2bc0ZTRs+dp2/lm0tPopIpJt42xxsIvUgilwDmwvp
         yNTQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/8] ARM: dts: meson-sm1: add U-Boot specific DT for graphics
Date: Fri, 11 Oct 2019 17:33:55 +0200
Message-Id: <20191011153358.29739-6-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Rename meson-g12a-u-boot.dtsi into meson-g12-common-u-boot.dtsi to
match the new DT architecture and add meson-sm1-sei610-u-boot.dtsi
to handle the U-Boot specific DT for graphics.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 ...meson-g12a-u-boot.dtsi => meson-g12-common-u-boot.dtsi} | 0
 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi                 | 2 +-
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi                   | 2 +-
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi              | 2 +-
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi                  | 7 +++++++
 5 files changed, 10 insertions(+), 3 deletions(-)
 rename arch/arm/dts/{meson-g12a-u-boot.dtsi => meson-g12-common-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12a-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/meson-g12a-u-boot.dtsi
rename to arch/arm/dts/meson-g12-common-u-boot.dtsi
diff --git a/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi b/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
index fddffd628c..236f2468dc 100644
--- a/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12a-u-boot.dtsi"
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-g12a-u200-u-boot.dtsi b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
index fddffd628c..236f2468dc 100644
--- a/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12a-u-boot.dtsi"
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
index fddffd628c..236f2468dc 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12a-u-boot.dtsi"
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi b/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
-- 
2.22.0

