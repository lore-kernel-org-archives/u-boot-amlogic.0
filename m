Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web12.19438.1609411000295637403
 for <u-boot-amlogic@groups.io>;
 Thu, 31 Dec 2020 02:36:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1609410996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=DjQpdpIpOzsKOQMECDb4Mx3JTtfnSxU1Fb2kkwJWuuw=;
	b=t37MqZAOnnn8CJ88bPhUfDGDE9fHTir/jiK1QsxcPl2PXbkZ0cLpn1m4m+fkReeQVwSTqO
	g3sZKULQB4duPAXBkVNSYhMqM64WS5Sn35bMqOL5Z+9S7E2Pl4MaaZZy2eT6x5JCp9HSCw
	RRX2cxgrS+n9Gy+We6sFEuqJkxRNl2E=
From: Stefan Agner <stefan@agner.ch>
Subject: [RFC] arm64: dts: meson: revert breaking change for eMMC detection
Date: Thu, 31 Dec 2020 11:36:36 +0100
Message-Id: <14c518aa46f3b87e7489bb1a3736ae5640262f9f.1609410832.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, jbrunet@baylibre.com
Cc: u-boot-amlogic@groups.io, Stefan Agner <stefan@agner.ch>
List-ID: <u-boot-amlogic@groups.io>

The sync of the device tree and dt-bindings from Linux v5.6-rc2
11a48a5a18c6 ("Linux 5.6-rc2") causes eMMC to break for ODROID-C2.
Revert the offending change.

Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-r=
c2")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
It seems that eMMC on ODROID-C2 doesn't work anymore since U-Boot 2020.07=
. A git
bisect pointed to the above mentioned commit. This reverts the offending =
part
only, but is probably not the proper fix. I am not familar with the pinct=
rl
drivers, so maybe somebody with a bit more insight can come up with the p=
roper
fix?

-> master without this patch
=3D> mmc dev 1
Card did not respond to voltage select!

-> With this patch
=3D> mmc dev 1
switch to partitions #0, OK
mmc1(part 0) is current device

 arch/arm/dts/meson-gxbb.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/meson-gxbb.dtsi b/arch/arm/dts/meson-gxbb.dtsi
index 234490d3ee..bb46dcd1c0 100644
--- a/arch/arm/dts/meson-gxbb.dtsi
+++ b/arch/arm/dts/meson-gxbb.dtsi
@@ -404,17 +404,11 @@
 		};
=20
 		emmc_pins: emmc {
-			mux-0 {
+			mux {
 				groups =3D "emmc_nand_d07",
-				       "emmc_cmd";
-				function =3D "emmc";
-				bias-pull-up;
-			};
-
-			mux-1 {
-				groups =3D "emmc_clk";
+				       "emmc_cmd",
+				       "emmc_clk";
 				function =3D "emmc";
-				bias-disable;
 			};
 		};
=20
--=20
2.30.0

