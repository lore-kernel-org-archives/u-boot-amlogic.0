Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.17319.1586966317934561262
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Apr 2020 08:58:38 -0700
Received: by mail-wr1-f66.google.com with SMTP id b11so475400wrs.6
        for <u-boot-amlogic@groups.io>; Wed, 15 Apr 2020 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zx5SNCkz7988dounmot9VMxJOVUBIbvPeV462rLowC4=;
        b=us7Olm5giMhXV+YSRUsXV9CRsLdYL6ok8QGu0TUry6fXEMoNuO48VmNy/um5ZJ96d8
         I9+a1zT4frh+S/wGbvwKQ06QB06CkBrZ88jTMHUxa6KbNCMfcA33GPlw75JYpeMne3Wr
         JRUh3Kulzz/O1L3XkhaEgnf1klktrJPzUX4JkUtaK3C2KycyIsQ3xir2AfBRDwgFIG0t
         Uktmv0L6AWi71M+GgpFOcf2/7EcVpquCwOUN0zn4PB1oq6LwJ6grR9DNs2yydp3BzsVc
         +ZbcQPlA2qTiuG8zIq3hezXDpN6PJDKgJqjslFsd7nParTaDyuNy0FvN/DLgGQtu6QcU
         mXEQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] ARM: dts: add missing meson-gxl-s805x-libretech-ac-u-boot.dtsi file
Date: Wed, 15 Apr 2020 17:58:30 +0200
Message-Id: <20200415155830.2649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The libretech-ac u-boot.dtsi file is missing to enabled DT nodes changes
to enable Video output on U-Boot.

Fixes: 671b1db8f8 ("arm64: dts: meson-gx: vpu should be probed before relocation")
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
new file mode 100644
index 0000000000..c35158d7e9
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
-- 
2.22.0

