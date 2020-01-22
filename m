Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web12.9995.1579694791633140604
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Jan 2020 04:06:31 -0800
Received: by mail-pj1-f65.google.com with SMTP id n96so3101612pjc.3
        for <u-boot-amlogic@groups.io>; Wed, 22 Jan 2020 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kk/ofKK+Q15/8NtWrrKsas2QAWdAtRoO0hCk44yTC4o=;
        b=cce6xPsSscjvw1aE25iVJ+vBZDj/RU69FRSPTy6evZ+LuQXTSnDho8Nx/6qlYDVwWb
         gWTmVmTxsoNIYNWqS8+xUypnyxarmCS82Ot0oxPffTD9Z4RO/mc4o3JayfZUEq1n2Z7l
         LSNaTW7LR7DDLKvdgp+mDFXrJWa4ftc1x41Mibvs8ukEvf3Bt5Iu/r9O16obSXtrj3L4
         YcNTEG+QDiNclPIE4+lRf95vBcPbxHxhvfYyw3yRZCFgbhDOP6pfwJO0ri9jW94q+vKP
         jlZMRM9sh/UaCSM50eFhTCCndjAEEwQhjFUaq5vsFoCLE++T502/+RrTx2DEi6eTRjug
         TWRQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [Patchv4 2/3] arm: dts: Add mmc alias to avoid warning
Date: Wed, 22 Jan 2020 12:06:19 +0000
Message-Id: <20200122120620.8699-3-linux.amoon@gmail.com>
In-Reply-To: <20200122120620.8699-1-linux.amoon@gmail.com>
References: <20200122120620.8699-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add missing mmc alias to dts nodes to avoid
below debug warning.

mmc_bind: alias ret=-2, devnum=-1
mmc_bind: alias ret=-2, devnum=-1

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/dts/meson-axg-s400.dts               | 2 ++
 arch/arm/dts/meson-g12a-sei510.dts            | 3 +++
 arch/arm/dts/meson-g12a-u200.dts              | 3 +++
 arch/arm/dts/meson-g12b-odroid-n2.dts         | 3 +++
 arch/arm/dts/meson-gxbb-odroidc2.dts          | 3 +++
 arch/arm/dts/meson-gxbb-p20x.dtsi             | 3 +++
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 3 +++
 arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 3 +++
 arch/arm/dts/meson-gxm-khadas-vim2.dts        | 3 +++
 arch/arm/dts/meson-sm1-sei610.dts             | 3 +++
 10 files changed, 29 insertions(+)

diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s400.dts
index 18778ada7b..b0192a9720 100644
--- a/arch/arm/dts/meson-axg-s400.dts
+++ b/arch/arm/dts/meson-axg-s400.dts
@@ -58,6 +58,8 @@
 	aliases {
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	linein: audio-codec@0 {
diff --git a/arch/arm/dts/meson-g12a-sei510.dts b/arch/arm/dts/meson-g12a-sei510.dts
index c7a8736885..0e6378a320 100644
--- a/arch/arm/dts/meson-g12a-sei510.dts
+++ b/arch/arm/dts/meson-g12a-sei510.dts
@@ -31,6 +31,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	mono_dac: audio-codec-0 {
diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a-u200.dts
index 8551fbd4a4..88b4d365f8 100644
--- a/arch/arm/dts/meson-g12a-u200.dts
+++ b/arch/arm/dts/meson-g12a-u200.dts
@@ -16,6 +16,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson-g12b-odroid-n2.dts
index 42f1540575..888429b1cc 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2.dts
+++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
@@ -18,6 +18,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
index 54954b314a..1436002013 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2.dts
+++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
@@ -17,6 +17,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxbb-p20x.dtsi
index 0be0f2a5d2..d55f5e1abb 100644
--- a/arch/arm/dts/meson-gxbb-p20x.dtsi
+++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
@@ -11,6 +11,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
index 82b1c48511..6422e11e5e 100644
--- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
@@ -20,6 +20,9 @@
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
 		spi0 = &spifc;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
index a1b31013ab..d712e9fa1d 100644
--- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
@@ -17,6 +17,9 @@
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
index 782e9edac8..723061f0e2 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
+++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
@@ -20,6 +20,9 @@
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
 		serial2 = &uart_AO_B;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/meson-sm1-sei610.dts b/arch/arm/dts/meson-sm1-sei610.dts
index 3435aaa4e8..3aafc20ccd 100644
--- a/arch/arm/dts/meson-sm1-sei610.dts
+++ b/arch/arm/dts/meson-sm1-sei610.dts
@@ -17,6 +17,9 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
 	};
 
 	chosen {
-- 
2.25.0

