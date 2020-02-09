Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
 by mx.groups.io with SMTP id smtpd.web12.6298.1581246382108057368
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:22 -0800
Received: by mail-pg1-f193.google.com with SMTP id z7so2299724pgk.7
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=x6DdqKCa1BEbXB4ySfgyK4s0ozsbPwGeQGTP+HnrqjQ=;
        b=YF5kkaagVJbKi+V6n2+n4lXeSpiCtiE9xPKKRaCUc4sLBGinrK1T1b0h6cOJxujHLA
         4BGg4JL7kY9Fh0yeen5B2mvnbZXYLUhpV4n/9sZBZEZMWMVtUrAsifD32rOABYw4OznK
         1Ip0Svmm41PMw5DG0ngIjkpOxd9vj/1D8zLJPLUrJGfnv75L/TMuKVpUAGfMwwnFfFBY
         +xoZ88dzSAEwkArE4RWjSCXtCM79SjExOj8yP5qIkYAsCQ73xAlA0u95euuKQnjHsPL9
         AlXuakODuwBEzvdYkgbb7VB86YVfu2bpJUBvoKXxsQYcRquhE6Q2ieZ3BhQQDqoDsr0y
         HXSA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 5/5] arm: dts: s400: Move common nodes to the -u-boot.dtsi
Date: Sun,  9 Feb 2020 11:05:57 +0000
Message-Id: <20200209110557.1996-6-linux.amoon@gmail.com>
In-Reply-To: <20200209110557.1996-1-linux.amoon@gmail.com>
References: <20200209110557.1996-1-linux.amoon@gmail.com>
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
no changes from previous changes
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

