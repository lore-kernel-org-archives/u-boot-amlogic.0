Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.23147.1593614606788245533
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 07:43:27 -0700
Received: by mail-wm1-f65.google.com with SMTP id g75so22690583wme.5
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQzOzhjZ5oMHTyEde0nts/8LTKC48UK7+2tWGlUk1gw=;
        b=Fsti24JEwS5K0tbHOThLz0X3ubbnyVny6hMQiRW6TIipP0rWS+xYj+j/n+rBfEi19x
         GXJAw+AjzqCkhzAFTABI7g00hH+IR+HT4K9htnAvzHPmlKu3lvyts9/VIEZdmAcRLNW5
         vatCXGU/IdBtayhkV4E90TnbqbOokdDHHvXrTc8VmNj7urUAGvAS+GOACg/t6KF3Ct6M
         p4n4RwkBe1Vo4vYUdqhN+QVS28LXAZOg66kG2S6505jMz6B3qNlCuZoup+BYj8EEqy+3
         fcjC+390zoV2ahsJKv9shFEvj4FsZmGJu5vnukr08CAfCWwzL/wXy8PGAhrNchX1ycip
         WLMg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset
Date: Wed,  1 Jul 2020 16:43:10 +0200
Message-Id: <20200701144310.25481-4-narmstrong@baylibre.com>
In-Reply-To: <20200701144310.25481-1-narmstrong@baylibre.com>
References: <20200701144310.25481-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, linux.amoon@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The PHY needs a reset in order to be functionnal for U-Boot, add the old
PHY reset bindings for dwmac until we support the new bindings in the PHY node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
index ee32c6f43d..2a8f0545b1 100644
--- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
@@ -5,3 +5,9 @@
  */
 
 #include "meson-g12-common-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
-- 
2.22.0

