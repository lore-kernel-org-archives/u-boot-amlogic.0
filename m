Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.956.1576780596133057047
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Dec 2019 10:36:36 -0800
Received: by mail-wr1-f67.google.com with SMTP id d16so6986443wre.10
        for <u-boot-amlogic@groups.io>; Thu, 19 Dec 2019 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1V6Uzti5xlaWOtmEMc351cskkokiV0Edy9oRPVugjE=;
        b=uy2EnqywbZM0/AVBIFSHuEkCil3C8UD4V6i8Xs1Lz+7IkKzE2bC+hNZvogX2h9G+j/
         ljpZ/VljhChO2zDHs5Vgv/bphamGcQfmq6s2ZxCMGcvjZ73zQ07l3eB2M/url1AO1WTw
         B5VWTHPB0umSwi92Hk9gIN/YmAcEIanimHXBQScNjahReIHCR+weLebFBtagPXdORVrM
         CYFM4UbDc6M00h1PMtB9kh+XCMV6MK/H5b1xHGe7bchO+O5Nd7uN8nkubVX4fH17tkHt
         XOOUm3Gn+z2cV6YB20C0jNs+mjLk6et6WiV2NV7VeS1olKpyunxGGfMZGGsJ0fVPtMv9
         XG9w==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4/5] arm64: dts: meson: gxl: add i2c C pins
Date: Thu, 19 Dec 2019 19:36:19 +0100
Message-Id: <20191219183620.1423118-5-jbrunet@baylibre.com>
In-Reply-To: <20191219183620.1423118-1-jbrunet@baylibre.com>
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add dv18 i2c C pins on the gxl SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/dts/meson-gxl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/meson-gxl.dtsi b/arch/arm/dts/meson-gxl.dtsi
index d5c3d78aafeb..4ef11e5381d8 100644
--- a/arch/arm/dts/meson-gxl.dtsi
+++ b/arch/arm/dts/meson-gxl.dtsi
@@ -511,6 +511,15 @@
 			};
 		};
 
+		i2c_c_dv18_pins: i2c_c_dv18 {
+			mux {
+				groups = "i2c_sck_c_dv19",
+				      "i2c_sda_c_dv18";
+				function = "i2c_c";
+				bias-disable;
+			};
+		};
+
 		eth_pins: eth_c {
 			mux {
 				groups = "eth_mdio",
-- 
2.23.0

