Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.12158.1631110654905279494
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:35 -0700
Received: by mail-wr1-f41.google.com with SMTP id m9so3580972wrb.1
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yxiGi92Gef9QvxgoWqHRzJn0ukWDWVBdqleEHaPfwU=;
        b=e5p19LPRv84ph2FmahUwn6PgQgl2UijPgB2aX9GO8UqL6dWKZL8/V6JgV2mKnNyysY
         as5iULSl4Ns+NhLklS9ioRn5Vky47JuYoXHq0nbM5suugMtvPbieeujxmE65CCNqcY5u
         ym+ECQtvSrp3dKgSkjJ1BrmWFocNt8+o8G4lWKH2w+Su3w86e7epHOb6mLtNEXFHBIUe
         ubyXU09mT7aNj4Q187YakZ4FglbjJzDZWxcATJi3YD9tLa+oq6Gi/QAK8Kg3JM+CzxRc
         bAvFzn0jMhaHYE3HWT9Y2z9u2YJJAjynCwxykMVBUIxmOBvPRusUspkmu8o8HdOHEVXM
         ++xA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 2/9] ARM: meson: keep HW order for MMC devices
Date: Wed,  8 Sep 2021 16:17:21 +0200
Message-Id: <20210908141728.585797-2-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
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

