Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.9602.1631864235209566693
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:15 -0700
Received: by mail-wr1-f43.google.com with SMTP id t8so6599098wri.1
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yxiGi92Gef9QvxgoWqHRzJn0ukWDWVBdqleEHaPfwU=;
        b=F9fk1l6kUxs9tDclxXW3AiBdtSwEdFUuPMFBf+bXUnhAn/YSD+mW0bTFLl7idyoswW
         QMrMBEywsFqxWfYMWvZJxTUh3WWvEJ2dVUK2BfLI4kdGhvVO55t+q+FVdA507+PB7ITC
         9djZV+YwJQuD04TJPWKOGdU1uoR0nCR+MxJS0lWue/1EeQxaj6Rjo5Aa0vpTHdL6QlQV
         EfBzUQsw7gUvA9h1L/NFR9E68sBfruo4twh7MHRMLuKRt/kQV4GLonom7QmZ8rsK3lKt
         BWI8Qe286wVWF+R7nAysvO+wOL2AqxjWDIbJDZW+Da1ERR0fe/GFyasj9Ubbp9uOz1FZ
         FbVw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 03/10] ARM: meson: keep HW order for MMC devices
Date: Fri, 17 Sep 2021 09:37:02 +0200
Message-Id: <20210917073709.1052133-3-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Since Linux commmit [1], the order is fixed with aliases, in order to keep the
MMC device order, set it back to HW order in U-Boot dtsi files.

[1] ab547c4fb39f ("arm64: dts: amlogic: Assign a fixed index to mmc devices")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12-common-u-boot.dtsi | 7 +++++++
 arch/arm/dts/meson-gx-u-boot.dtsi         | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
index 38fd3d3feb..b1f60b15c9 100644
--- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
@@ -5,6 +5,13 @@
  */
 
 / {
+	/* Keep HW order from U-boot */
+	aliases {
+		/delete-property/ mmc0;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
+	};
+
 	soc {
 		u-boot,dm-pre-reloc;
 	};
diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index 17d2cb95c1..fb6952f1d8 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -5,6 +5,13 @@
  */
 
 / {
+	/* Keep HW order from U-boot */
+	aliases {
+		/delete-property/ mmc0;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
+	};
+
 	soc {
 		u-boot,dm-pre-reloc;
 	};
-- 
2.25.1

