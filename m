Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.6187.1581246379349348060
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:19 -0800
Received: by mail-pl1-f193.google.com with SMTP id y1so1627174plp.7
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vZW09IQMWhYrO3olH94SZBTnlWl0PSOgPWpmoLf5aqU=;
        b=U9mkn8jSpxuBYFsIIJUO6Y+1RE/Dm2FlQwW+sqrznivgKXZs14cxL/wbCmxstO0CB5
         wNpCDShZyNKM1h2N9C3S5GY9aaC/Yl1thJ2SIhuxsjJVmXbcl8nP0OS9S04rocDJnNEf
         UdgnMmbDaEF87QjZxsyfQJMYZAad7qORNr7CPmSsvj5nFSW595N3LMIPWQLdAx1xoZAi
         OqMe46bRuuMiifdeymmUcmFfRVyE7JB847aMbMb1l7ET39+bS0JDLn/6FQZVpgnfI5s0
         UtE/T9uxoCD42Q7TLBFK4NXTklBA9tQ6d2VcOG4F33T3PicPQ7/YJJQPT2pO1pS4GXTr
         bFCQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 4/5] arm: dts: g12: Move common nodes to the -u-boot.dtsi
Date: Sun,  9 Feb 2020 11:05:56 +0000
Message-Id: <20200209110557.1996-5-linux.amoon@gmail.com>
In-Reply-To: <20200209110557.1996-1-linux.amoon@gmail.com>
References: <20200209110557.1996-1-linux.amoon@gmail.com>
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
No changes from previous patch
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

