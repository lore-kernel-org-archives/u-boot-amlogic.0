Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web08.8356.1617807001169985895
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 07:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1617806999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=OoknQeBrEf1mf1sP3gzEVX838qbzTHKFOxoJk5MGdg8=;
	b=ZO3YTstIYCU3oSp81HP/4juPpjAAS7sKfCt8KXbnrYb1yE54BKFfFyxM6jYdDKWDOoT/OI
	WDdN4Cr/MebJOn0nE0GZNth+OL/CcLkclQRpYBBTzu7DM9mnPqqwE72ojEjGc1WAi7ASXe
	h37ic/yoB2qMKBXaWJNddz+sZpE+/bY=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] arm64: dts: meson: odroidc2: readd PHY reset properties
Date: Wed,  7 Apr 2021 16:49:51 +0200
Message-Id: <65880dfc6b107ab09f566edec65c6d4ccc71377f.1617806959.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Stefan Agner <stefan@agner.ch>
List-ID: <u-boot-amlogic@groups.io>

The sync of the device tree and dt-bindings from Linux v5.6-rc2
11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
ODROID-C2. The PHY seems to need proper reset timing to be functional
in U-Boot and Linux afterwards. Readd the old PHY reset bindings for
dwmac until we support the new bindings in the PHY node.

Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-r=
c2")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/dts/meson-gxbb-odroidc2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gx=
bb-odroidc2.dts
index 70fcfb7b06..8b80bbc90b 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2.dts
+++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
@@ -188,6 +188,10 @@
 	phy-handle =3D <&eth_phy0>;
 	phy-mode =3D "rgmii";
=20
+	snps,reset-gpio =3D <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us =3D <0 10000 1000000>;
+	snps,reset-active-low;
+
 	amlogic,tx-delay-ns =3D <2>;
=20
 	mdio {
--=20
2.31.1

