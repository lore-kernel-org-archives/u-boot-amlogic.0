Received: by mail-ed1-f65.google.com with SMTP id r23so7924957edm.7
        for <u-boot-amlogic@groups.io>; Fri, 15 Mar 2019 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPBPT6FbOrC/87GbK9lrHhzTdPmXcpj24jxCyB8gcRQ=;
        b=mn2wHFye5FlO0dtAfO45cimG5TntH04tmWREUvjys+s1u8/eGADUm8xHT3HwxqNILj
         AgEw1XMceWOSTDooIYdxaZxpJjRLOtdCKEhk2QGrJC9v7KTMv893GAHx3cgfDT/a70rt
         ejmHqTCah2CmWaqdnUGNzkplRFOJKoqByocrFgiQrgjUwlGPnt8+4p99NTzPNbAhvsTg
         mAHdo/EpqNIR1Z+JHdBSkAZcpKSe9LJWIuUu/XM4qnym1IuSrzjC4RAdVJMh+OTcW3S0
         jpnduGivTflJZ8K0vL5MRARcSW6NH/huBmDq9+rTOFcC8r3BP7eY+AiEbKA5IQ2mp5AV
         DVMg==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v4 3/5] Arm: dts: meson: add u-boot.dtsi for p200 and p201
Date: Fri, 15 Mar 2019 18:19:44 +0300
Message-Id: <20190315151946.23105-2-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151946.23105-1-mohammad.rasim96@gmail.com>
References: <20190315151946.23105-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com, jbrunet@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This adds *-u-boot.dtsi files for p200 and p201 boards
These are just copies of arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
---
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi | 7 +++++++
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
new file mode 100644
index 000000000000..c35158d7e9ee
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
new file mode 100644
index 000000000000..c35158d7e9ee
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
--
2.21.0

