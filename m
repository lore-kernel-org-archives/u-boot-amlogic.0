Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.87453.1696932396883468975
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 03:06:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7990E120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696932392;
	bh=iaRjXishPr3PxBu0QoaFYctoQP0fmc3Hg6fUpaiC2LE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=T2jJeqpCs5haZMF+Y+tYGes1nzy1n9B+dXssusajK+joiHeFDXk3Of2np34ExkcUI
	 DsQZPta0Zx8ITjWW96bIpnt/KOrGHfltSefVOx7zoiU7jHfDOozEIeXfGv2TkNJQID
	 VtuPUf6vCkzIaZStUD1RAifQGvrnO3ihkVrQ2TBrjdUxRxu0V+gE1AWi5FwO3dd1Nb
	 FATjPMc+cXFQMv+OD1a3L8JoPQsqEVzPBy6mWf/r0QzOeTAlKrmUg/C8ceyerd+3ol
	 rffzrVbC62ZK2+aoo9gSLrPunjmSLYj9nuj45RQc09J6g5kI007CPxRQiS4Vs730Cn
	 FGHXj4Dhj3pew==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 1/2] meson-a1: dts: add hw rng node
Date: Tue, 10 Oct 2023 13:06:16 +0300
Message-ID: <20231010100623.74475-2-avromanov@salutedevices.com>
In-Reply-To: <20231010100623.74475-1-avromanov@salutedevices.com>
References: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for hardware random number generator
of Amlogic Meson SoCs.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/dts/meson-a1.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
index 6509329b85..e6e72d4004 100644
--- a/arch/arm/dts/meson-a1.dtsi
+++ b/arch/arm/dts/meson-a1.dtsi
@@ -124,6 +124,11 @@
 				clock-names =3D "xtal", "pclk", "baud";
 				status =3D "disabled";
 			};
+
+			hwrng: rng@5118 {
+				compatible =3D "amlogic,meson-rng";
+				reg =3D <0x0 0x5118 0x0 0x4>;
+			};
 		};
=20
 		gic: interrupt-controller@ff901000 {
--=20
2.25.1

