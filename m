Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web08.5136.1617870334270403718
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 01:25:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1617870330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=zTUBHCZt1YE3+nP9dde6BOaf474o7j/TmdevszywVew=;
	b=yu1RM/9A8MLVh+gzJvtidNFci66YbUVOObt86Bdx2pjIZRQcjtG97ckGbSQF3F5BAbuLrg
	6B1UIro6kRJCnp0cGqXUx97efYJMyiGItjsYYSpDD9TeUCXETN1whhGLNlJF0n2vsGT2kA
	3TBFYNyTcwMz5O9SWKUqkNsymIKYoyE=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] arm64: dts: meson: odroidc2: readd PHY reset properties
Date: Thu,  8 Apr 2021 10:25:28 +0200
Message-Id: <68934d1271af9afa7854ced37e72765381be6421.1617870301.git.stefan@agner.ch>
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
 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/=
meson-gxbb-odroidc2-u-boot.dtsi
index 90087b00db..5a2be8171e 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
@@ -29,6 +29,12 @@
 	};
 };
=20
+&ethmac {
+	snps,reset-gpio =3D <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us =3D <0 10000 1000000>;
+	snps,reset-active-low;
+};
+
 &usb0 {
 	status =3D "disabled";
 };
--=20
2.31.1

