Received: by mail-wm1-f65.google.com with SMTP id o10so6059450wmc.1
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBpIaDrUcBpHYvSphh1Yz0O6QwfOfNuMcHzGUqjEeBA=;
        b=uh91ER84koD173yIiM+ryEH6fqdo8kibrlGGUfxpIYsBB4GjTW8KzOj+iM1kBXfxCk
         QmWlmfhsC+7WubnsrvopmpeLHFGBdMN4fMNbqkmLq8o8Ye11OWGIHTBSNZVD9dpk0dsJ
         fVC9Dr2FlalqS5MZGBIH/Rlczlyq5dIiEwtyVHgwsXfMy3gzZYIlPzd3Za7ZpQoYvPTZ
         J0lWy9c8lUcW1tHABNquRxcJ6m/Bivtjg3Djfm57JP6NlXYJ9MLB9ydXededwsx6rsN4
         3C5Mm0EzRUJNh6OThKKpU8TvSrDdku/zfgGhy+TFR3FMvb9avxVjhlX+3h4fsmnhszTE
         BdXg==
Return-Path: <mohammad.rasim96@gmail.com>
From: "Mohammad Rasim" <mohammad.rasim96@gmail.com>
Subject: [PATCH v5 3/5] ARM: dts: meson: add u-boot.dtsi for p200 and p201
Date: Sat, 23 Mar 2019 14:54:49 +0300
Message-Id: <20190323115449.3320-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com, jbrunet@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This adds *-u-boot.dtsi files for p200 and p201 boards
These are just copies of arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
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

