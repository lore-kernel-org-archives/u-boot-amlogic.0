Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web10.340.1580742832817531735
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:52 -0800
Received: by mail-pl1-f195.google.com with SMTP id t14so5970352plr.8
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TsoQgyAvC2ZuEc7HBxOV+gcWnhjiA8D0hmQfC2JXCDc=;
        b=fZHg7w8F5HCzTqYIeRsE1hUvdW5VGVAdXdUY0pS2SaYziE0uhmNPLBDed9H/KgFI8Y
         bZMuBAnK8xtS1ndsyWitSKo5FnibfR92rdmPch3UBxYM+p4Gh5prsNFacMA0GRI0ovjQ
         C7TMtViwFhOct6S4m6JEPb9qeGvQRDdrIgKo0JgXAVMikrQxZbwlgVfSBoAQ5G2Q0+Eg
         gv2g1zccOBxMgHKiBzQMjmVeJcwYpI+gbWKrr7KKKT1wfs99kNB+AFhYjDodLHGT4pys
         7CuKBvuI6wX0snl2iXovw3KPHE5MUR2c16yrHILWqQ3atfvviPDQtwO8GL219ExALvP8
         XwDQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 5/5] arm: dts: s400: Move common nodes to the -u-boot.dtsi
Date: Mon,  3 Feb 2020 15:13:23 +0000
Message-Id: <20200203151323.4615-6-linux.amoon@gmail.com>
In-Reply-To: <20200203151323.4615-1-linux.amoon@gmail.com>
References: <20200203151323.4615-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Move u-boot specific common nodes in the dts files to
meson-axg-s400-u-boot.dtsi. This allows us to keep the basic
dts[i] files up-to-date with the ones in kernel,
but at the same time allowing the u-boot to add its own
properties to the existing nodes.
Also add missing mmc alias to dts nodes to avoid
below debug warning.

mmc_bind: alias ret=-2, devnum=-1
mmc_bind: alias ret=-2, devnum=-1

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch is the series
---
 arch/arm/dts/meson-axg-s400-u-boot.dtsi | 16 ++++++++++++++++
 arch/arm/dts/meson-axg-s400.dts         |  9 ---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/meson-axg-s400-u-boot.dtsi b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
index c46eb3f38d..74241e9fcd 100644
--- a/arch/arm/dts/meson-axg-s400-u-boot.dtsi
+++ b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
@@ -2,6 +2,22 @@
 /*
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  */
+/ {
+	soc {
+		u-boot,dm-pre-reloc;
+	};
+
+	aliases {
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		mmc1 = &sd_emmc_b;
+		mmc2 = &sd_emmc_c;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
 
 /* wifi module */
 &sd_emmc_b {
diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s400.dts
index 18778ada7b..feb84255ad 100644
--- a/arch/arm/dts/meson-axg-s400.dts
+++ b/arch/arm/dts/meson-axg-s400.dts
@@ -55,11 +55,6 @@
 		};
 	};
 
-	aliases {
-		serial0 = &uart_AO;
-		serial1 = &uart_A;
-	};
-
 	linein: audio-codec@0 {
 		#sound-dai-cells = <0>;
 		compatible = "everest,es7241";
@@ -100,10 +95,6 @@
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
-- 
2.25.0

