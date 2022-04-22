Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.4936.1650605370210671046
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605365; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bmnaoWXZLCIjUnMK61K8on4MKuYnakE+ZVh2wzJyGtQ=;
	b=HlpP0KLNclhpL2ZD5f+owI8cP2zFUrRV/jcuMOb6vsp3JolfStuwdYdjhqceC6oJ+Snmy8
	EydFQ+IpOloTRcoE8NGgyZMJ1gC4cFzv8HWzwUeiQJTm0vxEr8Y2emm16Z7pDOgKPTf3mF
	745LBhLTk9yOXW0uVpI2piq0htW+LGAeROpZnn/oe8tlK4YpG9/M5BJsfr8r611iWWHb2X
	s6QDavZ7iiNI705FgFknaU4H7nuk8AFYgmil5XfnIcja1pSAPOqJ1m40xurdKQWtTlb/k0
	g8x0+YXSNyIUPEBruWB2Mxd8R5RpBnpJzZw38XDCe3TICBqvd7ofkS9oAtilCg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 5/6] board: amlogic: jethub j100: enable saradc in dts
Date: Fri, 22 Apr 2022 08:29:13 +0300
Message-Id: <20220422052914.1836694-6-adeep@lexina.in>
In-Reply-To: <20220422052914.1836694-1-adeep@lexina.in>
References: <20220422052914.1836694-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Prepare to use ADC channel 1 to check the hardware revision of the board.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm/dts/meson-axg-jethome-jethub-j100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts b/arch/arm/dt=
s/meson-axg-jethome-jethub-j100.dts
index 5783732dc6..00a0b268af 100644
--- a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
@@ -359,3 +359,8 @@
 &cpu3 {
 	#cooling-cells =3D <2>;
 };
+
+&saradc {
+	status =3D "okay";
+	vref-supply =3D <&vddio_ao18>;
+};
--=20
2.30.2

