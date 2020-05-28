Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.12454.1590673656346132194
 for <u-boot-amlogic@groups.io>;
 Thu, 28 May 2020 06:47:37 -0700
Received: by mail-wr1-f67.google.com with SMTP id t18so13918438wru.6
        for <u-boot-amlogic@groups.io>; Thu, 28 May 2020 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBxNf9G93sGMTg/bzlPfFF0xzmWT6JS8GBonbsEBxw4=;
        b=BsDHfpRY45ayQ91Y5cQ/62os/QS+lIynQlSvfDWrBf9Uei/aKZYX8Pd3xiZZQ2qdsc
         mEG2OkOudXYGE0R5p6azjSVQt4Lo1dAVgNDj0Nx2qnixUMvk91O/yk0/aJgXEMhSHrYp
         vHwPwaN7MktCySx9PtoXzmIoLayHjl+ol44iYgs3LUzAhauG4Z/6G5BvjF54qxMtNExF
         3Q7u7qFX6dbaILaGsf1YCeGQauJXkKG64p8sPftZmsVI9B5wsjBX0QuOEkzQzjJAY/Cy
         eBZKaZUFf16Uf48otx5ISN0+HZ5e6hj5xZjwKxFY5eISREpW+65wjB1SES9Z0pdlUsca
         RJdg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] arm: dts: meson-gxl: fix USB gadget by adding missing nodes for U-Boot
Date: Thu, 28 May 2020 15:47:27 +0200
Message-Id: <20200528134727.32534-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The khadas-vim, khadas-vim2, libretech-ac & libretech-*-pc boards were missing
DT tweak to enable USB gadget.
Add them to their -u-boot.dtsi files and include the right gxl-u-boot.dtsi.

Fixes: a19e8a0f03 ("arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot")
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 6 +++++-
 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi | 6 +++++-
 arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi   | 4 ++++
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi        | 6 +++++-
 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi  | 6 +++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
index c35158d7e9..474a3e1604 100644
--- a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
@@ -4,4 +4,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
+
+&dwc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
index c35158d7e9..474a3e1604 100644
--- a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
@@ -4,4 +4,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
+
+&dwc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
index 39270ea71c..474a3e1604 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
+
+&dwc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
index bec9e05b09..7aecf2696b 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
 
 / {
 	aliases {
@@ -12,6 +12,10 @@
 	};
 };
 
+&dwc2 {
+	status = "okay";
+};
+
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
index c35158d7e9..474a3e1604 100644
--- a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
@@ -4,4 +4,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxl-u-boot.dtsi"
+
+&dwc2 {
+	status = "okay";
+};
-- 
2.22.0

