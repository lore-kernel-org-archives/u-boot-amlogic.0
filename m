Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web11.347.1580742827200684681
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:47 -0800
Received: by mail-pg1-f194.google.com with SMTP id l3so3881683pgi.8
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9yEEb71NOK5JqouLXlsp9C4/4W+6tXZOvVJTXOcTow=;
        b=OWodENBrl/OzgIbG7RP6KSPWab/mE4ctUYnsGzogW4v+rg81tZ4NtVzvsJFRdvDgR0
         iY6t5pHZEMA0AHTEewyvcBfjUvmeseW336v/1kYnlIB8uQ1YOAkyaXsXQ0cIXl1zTOIr
         3nRmKqZRlu0tuUSJb6Ck9q1hFHThO5NbkEL42dbSfNwEzqLvQvHqaBgHQKFRIIMB94IW
         y32bjlYLiu2x3SC2fAUibitS2VJ/JgDT9/rcKcmBraiY1qQ8IjXTFxQdnXz+5Yk3cBEA
         nwjGIis9lWXbLM+auuO3ESQQTic6Iy333zoEol53WfKe7mX9mWF41youmuoBoTrYXliV
         h7dg==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 3/5] arm: dts: gx: Move common nodes to the -u-boot.dtsi
Date: Mon,  3 Feb 2020 15:13:21 +0000
Message-Id: <20200203151323.4615-4-linux.amoon@gmail.com>
In-Reply-To: <20200203151323.4615-1-linux.amoon@gmail.com>
References: <20200203151323.4615-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Move u-boot specific common nodes in the dts files to
meson-gx-u-boot.dtsi. This allows us to keep the basic
dts[i] files up-to-date with the ones in kernel,
but at the same time allowing the u-boot to add its own
properties to the existing nodes.
Also add missing mmc alias to dts nodes to avoid
below debug warning.

mmc_bind: alias ret=-2, devnum=-1
mmc_bind: alias ret=-2, devnum=-1

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series
---
 arch/arm/dts/meson-gx-u-boot.dtsi             | 15 +++++++++++++++
 arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  9 ---------
 arch/arm/dts/meson-gxbb-odroidc2.dts          |  9 ---------
 arch/arm/dts/meson-gxbb-p20x.dtsi             |  9 ---------
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ----------
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 -----
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---------
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ----------
 arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ----------
 9 files changed, 15 insertions(+), 71 deletions(-)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index b84e5edba4..13be3a7b8f 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -8,6 +8,21 @@
 	soc {
 		u-boot,dm-pre-reloc;
 	};
+
+	aliases {
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_AO_B;
+		ethernet0 = &ethmac;
+		spi0 = &spifc;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &vpu {
diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
index cbe99bd4e0..11690d6c46 100644
--- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
@@ -11,15 +11,6 @@
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
index 54954b314a..f8cd76a2ef 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2.dts
+++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
@@ -14,15 +14,6 @@
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
 	model = "Hardkernel ODROID-C2";
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxbb-p20x.dtsi
index 0be0f2a5d2..c9822e50f9 100644
--- a/arch/arm/dts/meson-gxbb-p20x.dtsi
+++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
@@ -8,15 +8,6 @@
 #include "meson-gxbb.dtsi"
 
 / {
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
index 82b1c48511..4f9072a83e 100644
--- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
@@ -16,16 +16,6 @@
 		     "amlogic,meson-gxl";
 	model = "Libre Computer Board AML-S805X-AC";
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-		spi0 = &spifc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	cvbs-connector {
 		/*
 		 * The pads are present but no connector is soldered on
diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
index ceb34afe42..072e4575d2 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
@@ -26,11 +26,6 @@
 		};
 	};
 
-	aliases {
-		serial2 = &uart_AO_B;
-		ethernet0 = &ethmac;
-	};
-
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
index a23252efc6..8d3965ab42 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
@@ -15,15 +15,6 @@
 	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
 	model = "Libre Computer Board AML-S905X-CC";
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	cvbs-connector {
 		compatible = "composite-video-connector";
 
diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
index a1b31013ab..70f437fc3a 100644
--- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
@@ -13,16 +13,6 @@
 #include "meson-gxl-s905x.dtsi"
 
 / {
-	aliases {
-		serial0 = &uart_AO;
-		serial1 = &uart_A;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
index 782e9edac8..4e68e289d3 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
+++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
@@ -16,16 +16,6 @@
 	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
 	model = "Khadas VIM2";
 
-	aliases {
-		serial0 = &uart_AO;
-		serial1 = &uart_A;
-		serial2 = &uart_AO_B;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
-- 
2.25.0

