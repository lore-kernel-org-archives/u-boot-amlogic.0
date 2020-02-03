Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web09.335.1580742830341420470
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:50 -0800
Received: by mail-pl1-f193.google.com with SMTP id a6so5980191plm.3
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=huudZzwu3Yl/gDTN6kJsoLrBVTNjt0FX0UnzIBynbL0=;
        b=b3UJIxg1nvUCOVU4paiGsJu58tzRWDkIT0MWirs7u8RQMhqTMwlGkMzH5Q4QhmV8tR
         01WrJz/iYbDlPL2MnM/70FSV1BRZeRbsElJHz+M4Ggm/YKKJ1l9+vjO7FD95TcJ5t43c
         6dmZhQLK9AD99fIazwEbX9ISeIvFYX8NhL/FWX8XmZ/v4DT3p6sC66BVm8xk9lCHhkta
         HFstY6Mw/pSGSjcPxLaDzfs/D1PBfRDZJ50qOWZ0wLqNNJZk9ZVks070fRfqG3/hr90m
         UDJNvSaw25gMB1GQnU9ZVHVWECAABal2e+2p2qNf5kxflzKnNrZa/p/ds2DDHo8HbySh
         BD4Q==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 4/5] arm: dts: g12: Move common nodes to the -u-boot.dtsi
Date: Mon,  3 Feb 2020 15:13:22 +0000
Message-Id: <20200203151323.4615-5-linux.amoon@gmail.com>
In-Reply-To: <20200203151323.4615-1-linux.amoon@gmail.com>
References: <20200203151323.4615-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Move u-boot specific common nodes in the dts files to
meson-g12-common-u-boot.dtsi. This allows us to keep the basic
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
 arch/arm/dts/meson-g12-common-u-boot.dtsi | 12 ++++++++++++
 arch/arm/dts/meson-g12a-sei510.dts        |  9 ---------
 arch/arm/dts/meson-g12a-u200.dts          |  9 ---------
 arch/arm/dts/meson-g12b-odroid-n2.dts     |  9 ---------
 arch/arm/dts/meson-khadas-vim3.dtsi       |  9 ---------
 arch/arm/dts/meson-sm1-sei610.dts         |  9 ---------
 6 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
index 38fd3d3feb..347b8ded22 100644
--- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
@@ -8,6 +8,18 @@
 	soc {
 		u-boot,dm-pre-reloc;
 	};
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		mmc0 = &sd_emmc_a;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &canvas {
diff --git a/arch/arm/dts/meson-g12a-sei510.dts b/arch/arm/dts/meson-g12a-sei510.dts
index c7a8736885..c6a48ebbe5 100644
--- a/arch/arm/dts/meson-g12a-sei510.dts
+++ b/arch/arm/dts/meson-g12a-sei510.dts
@@ -28,11 +28,6 @@
 		};
 	};
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
 	mono_dac: audio-codec-0 {
 		compatible = "maxim,max98357a";
 		#sound-dai-cells = <0>;
@@ -49,10 +44,6 @@
 		sound-name-prefix = "MIC";
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	cvbs-connector {
 		compatible = "composite-video-connector";
 
diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a-u200.dts
index 8551fbd4a4..8be7b6985b 100644
--- a/arch/arm/dts/meson-g12a-u200.dts
+++ b/arch/arm/dts/meson-g12a-u200.dts
@@ -13,15 +13,6 @@
 	compatible = "amlogic,u200", "amlogic,g12a";
 	model = "Amlogic Meson G12A U200 Development Board";
 
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
 
diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson-g12b-odroid-n2.dts
index 42f1540575..a37f66a5e0 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2.dts
+++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
@@ -15,15 +15,6 @@
 	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
 	model = "Hardkernel ODROID-N2";
 
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
diff --git a/arch/arm/dts/meson-khadas-vim3.dtsi b/arch/arm/dts/meson-khadas-vim3.dtsi
index 8647da7d66..c6b0ce9a88 100644
--- a/arch/arm/dts/meson-khadas-vim3.dtsi
+++ b/arch/arm/dts/meson-khadas-vim3.dtsi
@@ -11,15 +11,6 @@
 / {
 	model = "Khadas VIM3";
 
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
diff --git a/arch/arm/dts/meson-sm1-sei610.dts b/arch/arm/dts/meson-sm1-sei610.dts
index 3435aaa4e8..4372708811 100644
--- a/arch/arm/dts/meson-sm1-sei610.dts
+++ b/arch/arm/dts/meson-sm1-sei610.dts
@@ -14,15 +14,6 @@
 	compatible = "seirobotics,sei610", "amlogic,sm1";
 	model = "SEI Robotics SEI610";
 
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
-- 
2.25.0

