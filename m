Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
 by mx.groups.io with SMTP id smtpd.web12.6297.1581246376762815296
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:16 -0800
Received: by mail-pl1-f194.google.com with SMTP id b22so1616787pls.12
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sEsxWRlJgOpwrGh8xy88MFjsOFq/qEAWHGiQfzcBO+w=;
        b=IdgrmhL0K4OXRbi96OQRcErhODJpPa9oCnCNU8buIdpj9gokel3RVaL/OdHOagWCnt
         JQn5gsAWnwlJFC1iAKUbLxSz0ImqKVu7fz/tN2tJXPPN9clH9mGqthWD7rdZWcSEGqvG
         YsfpejsLLDOA0se3pjha1q2vqpxhlI86UNJVQaDF4aPp7egvawYAxMwAfnkXWg2ec+WQ
         KbbosGWhKNJCG1652bkzLW4K2zd2CgLI5JoRq4kNWaklkiKJJvYClqZedws3SjWWkukL
         yqA7eUTuKlFWRmZEicfkAdPi5O5w2ZwzplEz5BRlWJJdWCgUmbIQVaAYixhfa6g/x+4O
         rhpA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 3/5] arm: dts: gx: Move common nodes to the -u-boot.dtsi
Date: Sun,  9 Feb 2020 11:05:55 +0000
Message-Id: <20200209110557.1996-4-linux.amoon@gmail.com>
In-Reply-To: <20200209110557.1996-1-linux.amoon@gmail.com>
References: <20200209110557.1996-1-linux.amoon@gmail.com>
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
no changes from previous
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

