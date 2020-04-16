Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.2668.1587026542540002522
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Apr 2020 01:42:23 -0700
Received: by mail-wm1-f66.google.com with SMTP id a201so3895930wme.1
        for <u-boot-amlogic@groups.io>; Thu, 16 Apr 2020 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEHaQnUgI4OMKl+237u3V/Kg90BMatYMBkVCwsKJwoo=;
        b=Le/LcbeYwqzCh1KHTMgTtNaPFonrvtJQZtgl50ZIRhMqwjZ3MoBeGG4jbRjN/dOS8B
         bSpTlJJdgA8z1ok6oYeFklNPpQgNYG2zy+0yBqh0wjbZgTbMuSvSlyUnkMVLeJRDXirC
         QrcWg3Vtzugm/OyE7lsbh/E7S9J6foNKbXdK1dDuwh0AWgAxZSoRprl/7vH9yKbihlRR
         qVr64GG54xEJzYnONaZyODBOCcE/33M9qI/bfUjN0vuunz1RDZyxx9/1qbccdazs01na
         F2pw8Hi8fgEx3GNKPdRTeA6pKk9oRK/toYDi/5legk+ipa6/AtQ3OkzTXsjM6uTWz3uZ
         UgYA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-gx: add back dmc register range until canvas driver is available
Date: Thu, 16 Apr 2020 10:42:15 +0200
Message-Id: <20200416084215.26893-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Linux VPU bindings have changed and dropped the dmc register range.

Add it back in the meson-gx-u-boot.dtsi file until a proper canvas driver
is available.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-gx-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index b84e5edba4..17d2cb95c1 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -11,6 +11,10 @@
 };
 
 &vpu {
+	reg = <0x0 0xd0100000 0x0 0x100000>,
+	      <0x0 0xc883c000 0x0 0x1000>,
+	      <0x0 0xc8838000 0x0 0x1000>;
+	reg-names = "vpu", "hhi", "dmc";
 	u-boot,dm-pre-reloc;
 };
 
-- 
2.22.0

