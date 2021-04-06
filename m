Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web08.298.1617731229205850672
 for <u-boot-amlogic@groups.io>;
 Tue, 06 Apr 2021 10:47:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1617731223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=vtyJVymAAqeOlNfxcwn7rieHpNQ5M51iIVVfcrFzBRM=;
	b=m9+G2GRYA89iE1MkXD+fgF3X7+DSxuOv3Xzw5PuH5AB5Bn1bB6VQTlN+ZgxItz4PBhv0Bi
	NuM00tXuIQl+WIqAieUisSXsKui28XusvJ/1b7Xz7pcPlpm7vFV7lz+oPTDubSJ6N6m6xj
	npanU8LzhxGzbBn/5W87qSVEjiDgKxA=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] arm64: dts: meson: fix PHY deassert timing requirements
Date: Tue,  6 Apr 2021 19:47:01 +0200
Message-Id: <ad76ec471d131339985c1f6766069ef3fd317a33.1617731144.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Stefan Agner <stefan@agner.ch>
List-ID: <u-boot-amlogic@groups.io>

The sync of the device tree and dt-bindings from Linux v5.6-rc2
11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
ODROID-C2.

Meanwhile a fix to increase the reset timing has been added to Linux.
Instead of reverting the offending commit, use the new reset timing
from upstream Linux commit c183c406c432 ("arm64: dts: meson: fix PHY
deassert timing requirements").

Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-r=
c2")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/dts/meson-g12b-odroid-n2.dtsi | 2 +-
 arch/arm/dts/meson-gxbb-nanopi-k2.dts  | 2 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts   | 2 +-
 arch/arm/dts/meson-gxm-khadas-vim2.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dtsi b/arch/arm/dts/meson-=
g12b-odroid-n2.dtsi
index 6982632ae6..39a09661c5 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
@@ -413,7 +413,7 @@
 		max-speed =3D <1000>;
=20
 		reset-assert-us =3D <10000>;
-		reset-deassert-us =3D <30000>;
+		reset-deassert-us =3D <80000>;
 		reset-gpios =3D <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
=20
 		interrupt-parent =3D <&gpio_intc>;
diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-g=
xbb-nanopi-k2.dts
index 7be3e35409..de27beafe9 100644
--- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
@@ -165,7 +165,7 @@
 			reg =3D <0>;
=20
 			reset-assert-us =3D <10000>;
-			reset-deassert-us =3D <30000>;
+			reset-deassert-us =3D <80000>;
 			reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
=20
 			interrupt-parent =3D <&gpio_intc>;
diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gx=
bb-odroidc2.dts
index 70fcfb7b06..50de1d01e5 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2.dts
+++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
@@ -200,7 +200,7 @@
 			reg =3D <0>;
=20
 			reset-assert-us =3D <10000>;
-			reset-deassert-us =3D <30000>;
+			reset-deassert-us =3D <80000>;
 			reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
=20
 			interrupt-parent =3D <&gpio_intc>;
diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-=
gxm-khadas-vim2.dts
index bff8ec2c1c..e38d9e50ca 100644
--- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
+++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
@@ -194,7 +194,7 @@
 		reg =3D <0>;
=20
 		reset-assert-us =3D <10000>;
-		reset-deassert-us =3D <30000>;
+		reset-deassert-us =3D <80000>;
 		reset-gpios =3D <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
=20
 		interrupt-parent =3D <&gpio_intc>;
--=20
2.31.1

