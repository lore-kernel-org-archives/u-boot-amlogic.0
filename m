Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.5062.1617868255462595272
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:50:55 -0700
Received: by mail-wm1-f49.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so3561195wma.0
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jcc0oYrKoBrDbwqyVm5pzOtSyAFTFpTZBjmPgAUYSvU=;
        b=Cz+mqlgOEPN+C6uV3HjA5QqYSNbtsj4NW4fDbxQBcc+Oyh6jkB1NHzGiUlVpfgPDYY
         YImcIkBi6wUAZNstLBtyEzz/hgMeU2vx7JMGQgbS9ucBi7aNlT9DOHuj9ipjlRC8UA7e
         lqu8+h0/nnwStMYzMycjELgS87wX/mox1TMishvEH3s0yIpMhrVoUTnlMLV+12yjU0Jt
         qh9WJ0WRoJrJlRIoiAalhisTBn7QnaOkzvF43RT8BA7mZCvLJlxKARBfaVOcTCNCXhUW
         QiMrBvRtdQNRiBsaTrARK1yBW7wKafpI87KBeYWByyyt7dyl7JI7X7gxxl3rlOk6Pfjr
         4kyw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/5] arm: dts: meson-khadas-vim3: enable PCIe in U-boot
Date: Thu,  8 Apr 2021 09:50:45 +0200
Message-Id: <20210408075047.4076954-4-narmstrong@baylibre.com>
In-Reply-To: <20210408075047.4076954-1-narmstrong@baylibre.com>
References: <20210408075047.4076954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable PCIe by default in u-boot, this should eventually be made dynamic
in the runtime board config depending on the MCU configuration.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
index 81fd5be378..24dbf8ca2c 100644
--- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
+++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
@@ -10,6 +10,10 @@
 	};
 };
 
+&pcie {
+	status = "okay";
+};
+
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_4b_pins>, <&emmc_ds_pins>;
-- 
2.25.1

