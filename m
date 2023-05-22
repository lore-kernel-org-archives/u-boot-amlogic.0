Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.20314.1684757398291424406
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 05:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1684757396;
	bh=sjFSJ2lb7+R5kWB+tgxN/gOYq4Qi0AnyvCdbYcaHRVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YE6IpPM55xf3xIn4QN+cnaVVCKQxs3uJFxlra6on0kOFHmjO/lDnwcY6vXZFotlVA
	 ii0QDAuNvQRT45G6RBFbkBlyVK0rTV5yNvDsz3vBxywKjZ43y4q6an1hmvZ22gVU2r
	 JqFM143n7B4voFKm0w7sL8vK0oaShpVjRjBAnD4ebvyN7WdPb8uqx7p/gwx0bVQgoN
	 +U1+JQ1RQ7xTPG/LzoI2QEKIgJYTv/lfa5HR9eg/JrBVaj1tDVnSUynbzkl4SNjbhW
	 tToKmCEOFTjzaMDXWYhCy2J19jNaJGrSISV5UvW0LrIXufUdK9Cnyr0wRZAE6F5HPz
	 EClGB9fBwmHMw==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 3/3] arch/arm64: meson-a1: dts: move pwrc node to bus
Date: Mon, 22 May 2023 15:09:41 +0300
Message-ID: <20230522120941.63962-4-avromanov@sberdevices.ru>
In-Reply-To: <20230522120941.63962-1-avromanov@sberdevices.ru>
References: <20230522120941.63962-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

This is necessary so that pwrc can be used together with
peripherals when described in a bus node. For example,
in the future, this will be USB.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm/dts/meson-a1.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
index 9776b2d8798..f3560cbc3a4 100644
--- a/arch/arm/dts/meson-a1.dtsi
+++ b/arch/arm/dts/meson-a1.dtsi
@@ -65,12 +65,6 @@
=20
 	sm: secure-monitor {
 		compatible =3D "amlogic,meson-gxbb-sm";
-
-		pwrc: power-controller {
-			compatible =3D "amlogic,meson-a1-pwrc";
-			#power-domain-cells =3D <1>;
-			status =3D "okay";
-		};
 	};
=20
 	soc {
@@ -161,6 +155,12 @@
 			#address-cells =3D <0>;
 		};
=20
+		pwrc: power-controller {
+			compatible =3D "amlogic,meson-a1-pwrc";
+			#power-domain-cells =3D <1>;
+			status =3D "okay";
+		};
+
 		usb: usb@fe004400 {
 			compatible =3D "amlogic,meson-a1-usb-ctrl";
 			reg =3D <0x0 0xfe004400 0x0 0xa0>;
--=20
2.38.1

