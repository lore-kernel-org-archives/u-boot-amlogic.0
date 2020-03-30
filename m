Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.46270.1585560467728493970
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:48 -0700
Received: by mail-wm1-f65.google.com with SMTP id c187so19201917wme.1
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VXg1uvl87VMlzzxP16nPfI7zzCX4dU6ebjl8zTZFK4=;
        b=Y6S3vcojIRhXaftT7bIjgha/OVvK38cOmJxH7V+QLet2BLc+48x1uxwPiyT5DCrC5K
         eFZ7RdHP0zP4Tn40nnASYkTRbgLCbOGicrgLRC4Z3CQqEwnnFlQ3keB4apjPfPFrUJeE
         Xv9wLyto6I4cKVSLDwCxZXhcO81D+400UCxS4DJ6AXHFGB/LDeCvyND3+tKSUZjmNDNP
         XsigBAAMtOpYt7f7vZ5oAkB8DOpJxQxxEfyKHq8ae1IqXigKljVq7y8kvZqKNNAJQwEf
         3Ju91QmFlMf6Y+gga3RwV1wYDyBf2XmimAe4Jx8bGOwDcR5td7r1G/OPt5oUXxEV7rlp
         ZkOA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 04/10] arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot
Date: Mon, 30 Mar 2020 11:27:26 +0200
Message-Id: <20200330092732.7198-5-narmstrong@baylibre.com>
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the USB DWC2 node to u-boot specific dtsi files since Gadget
support is not (yet) available in upstream Linux yet.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    |  2 +-
 .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  |  6 ++++-
 arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi |  2 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi            | 23 +++++++++++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
index c35158d7e9..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
index c35158d7e9..474a3e1604 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
@@ -4,4 +4,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
+
+&dwc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi
index c35158d7e9..39270ea71c 100644
--- a/arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxl-u-boot.dtsi b/arch/arm/dts/meson-gxl-u-boot.dtsi
new file mode 100644
index 0000000000..9e88afd30e
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-u-boot.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
+
+&usb0 {
+	dwc2: usb@c9100000 {
+		compatible = "snps,dwc2";
+		reg = <0x0 0xc9100000 0x0 0x40000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
+		clock-names = "ddr";
+		phys = <&usb3_phy>, <&usb2_phy1>;
+		dr_mode = "peripheral";
+		g-rx-fifo-size = <192>;
+		g-np-tx-fifo-size = <128>;
+		g-tx-fifo-size = <128 128 16 16 16>;
+		status = "disabled";
+	};
+};
-- 
2.22.0

