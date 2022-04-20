Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.11026.1650477315148478103
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 10:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650477312; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bmnaoWXZLCIjUnMK61K8on4MKuYnakE+ZVh2wzJyGtQ=;
	b=Lzi0nbTjul/kfaGkaGXdJ017Yc3QUUoTNF6Ffp6nwZWUOBsXIvldkPdmPqcZKES66yc8XL
	8aC6D2uu4W3LCm/ZansdXHBJT5lEg2RcG4AuTERRkFrGldlG0LKmcvdLCBv2SuvVor0qzA
	y2IJp0gWszocRbj/2VzaZ8v/I9p9Gqg3JsiBHwD0g2TomgAfa6LQxx/TB5diRARpeSBLvU
	ufvwWbxcUk14I1SFCWeJtaWAXMiyNdYTAYiGZWo5qrkCVDy2KWybE7i1N5NYDgK7094KLu
	exFCmiGwACX5njxuZO4oqqQZeOGmruCgl8Ei8TwYJuUoHOPvd1TrpGXU1ruPXw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 4/5] board: amlogic: jethub j100: enable saradc in dts
Date: Wed, 20 Apr 2022 20:55:01 +0300
Message-Id: <20220420175502.2449249-5-adeep@lexina.in>
In-Reply-To: <20220420175502.2449249-1-adeep@lexina.in>
References: <20220420175502.2449249-1-adeep@lexina.in>
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

