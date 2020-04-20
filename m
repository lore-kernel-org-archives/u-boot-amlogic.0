Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.2181.1587390304243040372
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:45:04 -0700
Received: by mail-wr1-f67.google.com with SMTP id j2so12211831wrs.9
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aplaMIaff1OIeYNF7AAHHFJuQuBcuEc4y1Wti1YdShM=;
        b=oISBadZShr2/KfzV/BMHItr3Ko0Zw4YXj9g1dyTD1zK0Sx/Fq89En6ScXxhYXOXsoo
         PWs5euT0EhkTJ0LVgOiGVX3gwVy03JISdK+fsbX+bJX1FEFl+Pvx6sZUNYIrJJ8MVKJJ
         mQMcjcyv1cIrNdrbk97VN7cxuPD3oLhSO/3ormmllhVOjEzJRetAgdBIkd3UgRhUecOx
         PKz3wcfAcDITBuA/q13B4IOBJy+9OvmiZ2T/ynC+BYKrNf8xtPw4wFCRQ2xTmnC21qSZ
         nLc8DrtIGOpc0mEl4HakU7OzxQCSOhB3bOv7zIkQbWfCGc6TJcZx+JyD+7CRZrp0aKQN
         6HjQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/5] arm: dts: meson-khadas-vim3: enable SPI NOR flash
Date: Mon, 20 Apr 2020 15:44:44 +0200
Message-Id: <20200420134445.19704-5-narmstrong@baylibre.com>
In-Reply-To: <20200420134445.19704-1-narmstrong@baylibre.com>
References: <20200420134445.19704-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable the SPI flash controller and reduce the usable eMMC data pins to 4
to permit using the on-board SPI NOR Flash.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |  7 +++++++
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    | 21 +++++++++++++++++++
 .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  7 +++++++
 3 files changed, 35 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
new file mode 100644
index 0000000000..f66eca14b1
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-khadas-vim3-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
new file mode 100644
index 0000000000..81fd5be378
--- /dev/null
+++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/ {
+	aliases {
+		spi0 = &spifc;
+	};
+};
+
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_4b_pins>, <&emmc_ds_pins>;
+	bus-width = <4>;
+};
+
+&spifc {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
new file mode 100644
index 0000000000..f66eca14b1
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-khadas-vim3-u-boot.dtsi"
-- 
2.22.0

