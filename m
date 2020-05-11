Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.11625.1589203054090402066
 for <u-boot-amlogic@groups.io>;
 Mon, 11 May 2020 06:17:34 -0700
Received: by mail-wr1-f68.google.com with SMTP id v12so10880771wrp.12
        for <u-boot-amlogic@groups.io>; Mon, 11 May 2020 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GupMuRqL1gm6ldX8zY22/z4NJImY88AqlRNPz3ucZNQ=;
        b=GvlTPbZ7YVf2vFeiw24HK0E63BJRbwxOCdW9sYQpu+rLdziYH/Xh9V4YS3b8AWARBp
         gxVs8nRMBdUbkUu0qG6HI4gfrKWQRwvPvGQyatP74c8DB9Oy7BOv5FGqWZ1fBCpNwOhl
         RnUSb61ky6O89VxZHYg3E2iukg6wyqeZZVLXwYfCdH8PCrnnSd+a5u2CyIU7rbY0kTk1
         F5xqybICZc138NjDsxs6fcpFXe9uxBLawuFjIy2OdB5Rh7K/cQsmqIDEPGjvjl0+NRRT
         twgUwSwcmX9gTbd09M9rwV2SDhc+++LK48su9A4YFWkAkfTMkC8Q6VKhnmmIIpcIb2+X
         IpHQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm: dts: khadas-vim3: include meson-g12-common-u-boot.dtsi to enable HDMI output
Date: Mon, 11 May 2020 15:17:27 +0200
Message-Id: <20200511131728.5570-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Include the common g12 u-boot tweaks to permit enabling video output tweaks
on Khadas VIM3 boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
index 81fd5be378..b5da4fdfc3 100644
--- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
@@ -4,6 +4,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include "meson-g12-common-u-boot.dtsi"
+
 / {
 	aliases {
 		spi0 = &spifc;
-- 
2.22.0

