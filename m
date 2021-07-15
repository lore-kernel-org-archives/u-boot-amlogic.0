Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web12.3922.1626325236976938686
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Jul 2021 22:00:37 -0700
Received: by mail-pf1-f181.google.com with SMTP id p22so3985161pfh.8
        for <u-boot-amlogic@groups.io>; Wed, 14 Jul 2021 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M02kRbAGaCRN6r1pV6yzsZpE9MyVVXy2TmaKam6o6gg=;
        b=Sl6KOh/Zqinm9PmfS4+ZhJza0VN+jhd/SRQUpDPP7Frupr9J5lLwqQ20ujV7iOsaa9
         WeBsBMB7aHXDy8PJEf2D7xHmUREI2n7nX5yAlI5ttFTtb02adDfvHCGs5Hq/pbZ3kW50
         wKn4NgqaD7PhmHZ1LbdJN8auZ/k/T1a9Q7ZCdUBVT+ATJ/FKwh8jPMXqRbglp6uNy96N
         6k8cW0RqjKRwFduzJWs1MqstroMECMR7xHZCvTkDMUWoBE0E8dICplY3F548FU/nVOHc
         noEck8pL2A7QeqzG0QHtrAuh3jBzzXYrhjpil4WT1KSOQx0vFFvb7Begl3Q5xbw8rJ/j
         mLiA==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] dts: khadas vim series: Use devicetree for SMBIOS settings
Date: Thu, 15 Jul 2021 13:00:25 +0800
Message-Id: <20210715050026.2940786-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Khadas vim series: Use devicetree for SMBIOS settings
Add settings and enable the default sysinfo driver so that these can come
from the device tree.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  | 23 +++++++++++++++++++
 .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    | 23 +++++++++++++++++++
 .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi | 21 +++++++++++++++++
 .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    | 23 +++++++++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
index 489efa15..fcd6f053 100644
--- a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
@@ -6,3 +6,26 @@
 
 #include "meson-g12-common-u-boot.dtsi"
 #include "meson-khadas-vim3-u-boot.dtsi"
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "khadas";
+				product = "VIM3";
+			};
+
+			baseboard {
+				manufacturer = "khadas";
+				product = "VIM3";
+			};
+
+			chassis {
+				manufacturer = "khadas";
+				product = "VIM3";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
index 39270ea7..20e36d1b 100644
--- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
@@ -5,3 +5,26 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "khadas";
+				product = "VIM";
+			};
+
+			baseboard {
+				manufacturer = "khadas";
+				product = "VIM";
+			};
+
+			chassis {
+				manufacturer = "khadas";
+				product = "VIM";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
index c1763336..41480c9a 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
@@ -10,6 +10,27 @@
 	aliases {
 		spi0 = &spifc;
 	};
+
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "khadas";
+				product = "VIM2";
+			};
+
+			baseboard {
+				manufacturer = "khadas";
+				product = "VIM2";
+			};
+
+			chassis {
+				manufacturer = "khadas";
+				product = "VIM2";
+			};
+		};
+	};
 };
 
 &sd_emmc_c {
diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
index a591c0c9..06b81f23 100644
--- a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
@@ -6,3 +6,26 @@
 
 #include "meson-sm1-u-boot.dtsi"
 #include "meson-khadas-vim3-u-boot.dtsi"
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "khadas";
+				product = "VIM3L";
+			};
+
+			baseboard {
+				manufacturer = "khadas";
+				product = "VIM3L";
+			};
+
+			chassis {
+				manufacturer = "khadas";
+				product = "VIM3L";
+			};
+		};
+	};
+};
-- 
2.25.1

