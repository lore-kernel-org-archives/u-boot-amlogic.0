Received: by mail-wm1-f68.google.com with SMTP id l2so7213952wmg.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtukr37FiCxlKh4MYQ/E3hEkkVO6vv+xzQqFk4vSfoM=;
        b=BeFxR3njd1HFKWxtPK5mkyQlNUytk3yJGQgVq6TA809HM8c34eR2/s1xs83LmHZKRT
         wwu2nB5gpwWP67dEgPoxh0WKWBufLexD88maK2Qxzvc9OSYgjsoEcJmnbRpsC3DUx95s
         rvpzYIUUFd7uK5xOdHCAuGu6kxdXtThqh6SN+xTnmOrKKNgZRD/w2ffpOtiI+SafZKKL
         jZoKpFM1TIX1nHMvt0qWMPNQEbno9GFFsD1L5fPRYo1j8eqg/q1zjNys3EXU24svmpO+
         NVPxedMLZUuYdiP9koSUqSsUulyZjIKz5RNtoG/OhYKRHAUdyxAKOU+leGPHad9vgmyY
         2uiA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 7/8] ARM: dts: meson-g12a: add U-Boot specific DT for graphics
Date: Fri, 30 Aug 2019 14:09:27 +0200
Message-Id: <20190830120928.23890-8-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Like the meson-gx support, add the U-Boot specific bits in DT
to support graphics on G12A SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi    |  7 +++++
 arch/arm/dts/meson-g12a-u-boot.dtsi           | 29 +++++++++++++++++++
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |  7 +++++
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |  7 +++++
 4 files changed, 50 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi b/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
new file mode 100644
index 0000000000..fddffd628c
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12a-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-g12a-u-boot.dtsi b/arch/arm/dts/meson-g12a-u-boot.dtsi
new file mode 100644
index 0000000000..38fd3d3feb
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-u-boot.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Maxime Jourdan <mjourdan@baylibre.com>
+ */
+
+/ {
+	soc {
+		u-boot,dm-pre-reloc;
+	};
+};
+
+&canvas {
+	status = "disabled";
+};
+
+&vpu {
+	reg = <0x0 0xff900000 0x0 0x100000>,
+	      <0x0 0xff63c000 0x0 0x1000>,
+	      <0x0 0xff638000 0x0 0x400>;
+	reg-names = "vpu", "hhi", "dmc";
+	u-boot,dm-pre-reloc;
+};
+
+&hdmi_tx {
+	reg = <0x0 0x0 0x0 0x10000>,
+	      <0x0 0x3c000 0x0 0x1000>;
+	reg-names = "hdmitx", "hhi";
+};
diff --git a/arch/arm/dts/meson-g12a-u200-u-boot.dtsi b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
new file mode 100644
index 0000000000..fddffd628c
--- /dev/null
+++ b/arch/arm/dts/meson-g12a-u200-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12a-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
new file mode 100644
index 0000000000..fddffd628c
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12a-u-boot.dtsi"
-- 
2.22.0

