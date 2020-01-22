Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web09.9938.1579694794073410178
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Jan 2020 04:06:34 -0800
Received: by mail-pl1-f195.google.com with SMTP id b22so2884433pls.12
        for <u-boot-amlogic@groups.io>; Wed, 22 Jan 2020 04:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZySLhLems7qha8QTGygkmDqlwXDUNnWbyfa9yBVvuIw=;
        b=V9tV7/WJlOvvh6Wnfqyo5aYNVrxXWuZmLjNvcXNn/TIOu/ayWypJNQD5LQpoG9OCvf
         mnNumPDDYJgkTDUX1l/ZpGFP6hHAHeHZU4DqnFn/FTM1kIX1KnAT7uUIdtAUS9e4f5vO
         Eje4mmS/rV6MGmYeEQga+WkTi2/WKd+JAn4BhMs8WxTCOJq02gnMpTJyVvHH7poQeDaG
         6s8VO4HjdaONiP2KD3cR/4q2ELWK2Svt5bOQ9iY/bqPQvypu+iLV6oTLo+zLtH1hq9pO
         kkhb3ihSjJcc6RNlz9m6MjI7vInIxmfjO8jJuLxUc9KT9N27tCDq5PNR3xcciVP5PDPQ
         0+Vg==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [Patchv4 3/3] arm: dts: Add cd-gpio for eMMC
Date: Wed, 22 Jan 2020 12:06:20 +0000
Message-Id: <20200122120620.8699-4-linux.amoon@gmail.com>
In-Reply-To: <20200122120620.8699-1-linux.amoon@gmail.com>
References: <20200122120620.8699-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add cd-gpio property for eMMC node.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series
---
 arch/arm/dts/meson-g12b-odroid-n2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson-g12b-odroid-n2.dts
index 888429b1cc..23ec14abe7 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2.dts
+++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
@@ -449,6 +449,7 @@
 	max-frequency = <200000000>;
 	disable-wp;
 
+	cd-gpios = <&gpio GPIOH_7 GPIO_ACTIVE_LOW>; /* eMMC_nDET */
 	mmc-pwrseq = <&emmc_pwrseq>;
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&flash_1v8>;
-- 
2.25.0

