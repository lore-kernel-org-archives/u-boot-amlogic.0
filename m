Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.2178.1587390301197972912
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:45:01 -0700
Received: by mail-wr1-f68.google.com with SMTP id s10so3084961wrr.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1pzCPYFUNXYddjOIDYgg+jtk9SunoZ2EvOVi3qTBec=;
        b=14nMyiwzKhy0QYJeB+uzQRkTzRviZrD1goPr7asA3CqqRXOq7bLr6AGgAn3s8fBez9
         OcObA68JElqmxvMbmNgWzwzTTmtuVStfUDaAq1yUin5U90A1pRDqsU5Q5WC+TtJC8O0h
         47PFUzNzF/6aSontvJbCYAnfNGecUJN3Tpw+EJGz5kSl5YQHgNmZ5RZwwfs84Zmizv4E
         WExPbL86ptpyAyDpvXBCLil7WqcgVAvBiNNhnDVtXD82z1wmnsaTaJqh42TzjGmgO9uC
         2hCaVPv7xD5+micCHPXd7JJeAy7d1MtkJNRS8zsOpLbVQsAwFguTX45kIWvKXxcKg9H2
         bxtQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/5] arm: dts: meson-gxm-khadas-vim2-u-boot: enable SPI NOR flash
Date: Mon, 20 Apr 2020 15:44:42 +0200
Message-Id: <20200420134445.19704-3-narmstrong@baylibre.com>
In-Reply-To: <20200420134445.19704-1-narmstrong@baylibre.com>
References: <20200420134445.19704-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Activate the on-board SPI NOR Flash by enabling the SPI controller and
disabling the DS eMMC pin in the VIM2 u-boot.dtsi file.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
index c35158d7e9..bec9e05b09 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
@@ -5,3 +5,18 @@
  */
 
 #include "meson-gx-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &spifc;
+	};
+};
+
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+};
+
+&spifc {
+	status = "okay";
+};
-- 
2.22.0

