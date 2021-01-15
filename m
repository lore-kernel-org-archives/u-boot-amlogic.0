Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.129.1610687900764666065
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Jan 2021 21:18:20 -0800
Received: by mail-pj1-f53.google.com with SMTP id w1so5678885pjc.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Jan 2021 21:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ru92q30VrXaJ9a8mzVLaRxIw3EbnfTCXQ3TfFzyO08s=;
        b=uohCXiMYCCqGeJgQbJgmAz4ClPJPNa67Cn6Qc5ctAA+nKC45c7o5TN3gxv0qLlwvIA
         q3h/6yU+Q/ccJMg6ThHGsxU0aoYKIR5YH9zG2T248oSIACpEh2zb7KiTa5F0+BZgCb2O
         BlsNXX/ZzgdA3yaG7WeFOBdtV1ru3SW53bSkDH1FptIoZk8+AZ4ubDlyBFknjMnBUnTT
         Gjnww3iqiVOoIBPqORq73U6p/Z0If40z9LBlkdY5PZ7zMQyCGB2eHVaYTyLaqKpQMuIe
         6GoJf6TeDcC46/Dk4Ti0YRgwnffoQJ30DuaHXw67mTuluX4S7VfdzGR7YW4N6lnuJ2r0
         BLcw==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: fix meson-khadas-vim3-u-boot.dtsi
Date: Fri, 15 Jan 2021 13:15:58 +0800
Message-Id: <20210115051558.469734-3-art@khadas.com>
In-Reply-To: <20210115051558.469734-1-art@khadas.com>
References: <20210115051558.469734-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, hs@denx.de, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add missed include meson-g12-common-u-boot.dtsi

PROBLEM: missed hdmi video setup for VIM3 and VIM3L boards

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
index 81fd5be378..5d6444cbac 100644
--- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
@@ -10,6 +10,8 @@
 	};
 };
 
+#include "meson-g12-common-u-boot.dtsi"
+
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_4b_pins>, <&emmc_ds_pins>;
-- 
2.25.1

