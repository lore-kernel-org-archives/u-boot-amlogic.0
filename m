Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.7777.1618908440228066078
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Apr 2021 01:47:20 -0700
Received: by mail-wr1-f51.google.com with SMTP id a4so36742889wrr.2
        for <u-boot-amlogic@groups.io>; Tue, 20 Apr 2021 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIp0NTGyqoQJR9OzfORE+yoqAj8B39xQvC4oyNrBiaM=;
        b=ADFsLR7js0h6IcTHREqcRNR9Q19nS8KYGcD0Jm1Jzxd3FOKBAx/vZ6jH1/ZHdH8p70
         OYFw/PPENrZTSeyyV3ow/EnIslNJKu6f9+7AxcPDjLdrStnm2O3G+yyhdOryBA10XQao
         TV7F1d5e/f78CoO8HQ/rEuNtC2M8KxWGcMfIEACt5YX5FF/29UUHyKsSLAD18uvwIoYA
         I3JyHPsi0kEFSdiHeOg/CcnBfhtS87KRju4qxJIZgAhmD0lpEaiISGmqT0Q+RCkM8cXX
         ryBRl1BrrQp4co5bmhV1b2YIkEk7NdEg+WAJecRM7EYdWPzpS6Kty4uBQe66cLpUYKvN
         OBUA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] ARM: dts: add missing -u-boot.dtsi to enable HDMI on Beelink GTKing/King-Pro
Date: Tue, 20 Apr 2021 10:47:16 +0200
Message-Id: <20210420084716.2997327-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, B1oHazard <ty3uk@mail.ua>
List-ID: <u-boot-amlogic@groups.io>

This lacks the right u-boot specific DT include to make HDMI work.

Reported-by: B1oHazard <ty3uk@mail.ua>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi | 7 +++++++
 arch/arm/dts/meson-g12b-gtking-u-boot.dtsi     | 7 +++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-gtking-u-boot.dtsi

diff --git a/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi b/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi b/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
-- 
2.25.1

