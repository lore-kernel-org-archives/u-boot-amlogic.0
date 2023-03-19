Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web11.21101.1679245525886149559
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y2U16fd3KB7Gn51fYw11k0v59EE2U3jvzTEfVbxo9U=;
	b=NX/BstaegU3/zZWViFOzGh4W5A5KOBKHiIjv6kujEoBFaOVTgoOGJdV7BNLhBalfGiWANF
	KBT1nak3M/YufgpQ7PKWLD8HoG/6S6PaUGEwiuI1iCQrrBoGI+cc/H/Ir8ZiUrP4NK7ffR
	XDwcghJXsJ4dvzaNXllVOhORYwhIOSx2eblO3OtpiuxDJFmqkoBiFNehAtwqIgGhLpunfR
	199okB9XuS0RvdxKBNP8E0EG2MK/oNHMKxpyDypjOW2qWh5I8RPYfg49skH3p2SB0mgZCC
	iuQjaE4ahd8huDbb3Tpw9fffH0+4Qvkq1KZ4CWTKxn11kqgYeuES96bAUEA0ng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y2U16fd3KB7Gn51fYw11k0v59EE2U3jvzTEfVbxo9U=;
	b=JYvbYIix3rN1FoPxfXuwXSH10/at5CQmcbp9F4ROgGtR/JQQI/d/dKZ9kWV/lsI4kEMhjr
	sh/eIHdWbAHYIEHrxe2x34xenqTYiz69+mVQshoHF0ZnA9D+T2SW7SoJ0oQJCa8E6TR/yG
	BfS4Dq4AJTlNOqT6VXswUufBgfwkXMdRVdqONuD2ljxKm+/dbbaKmYj03igGOOb6tcSEqJ
	YW9Q6ILK8bvvRHCkukrfLkvoh2jywX2vt7+W4aLXjxq42tJII3vElEIJNJG7fPNWPXqP/i
	ZiAJnqcI23nNa/PQwyTl6ArMSMEU7AmVIaSz4n/n+RIhqFhG94oU/Ym9LY+VYw==
Subject: [PATCH 29/41] net: phy: vitesse: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:05 +0100
Message-Id: <20230319170317.27711-29-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Convert PHY driver to U_BOOT_PHY_DRIVER() macro and drop phy_register() ini=
t call.

Converted using sed
"s@^static struct phy_driver \(.*\)_driver =3D \+{@U_BOOT_PHY_DRIVER(\L\1) =
=3D {"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
Cc: "Marek Beh=C3=BAn" <kabel@kernel.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Haolin Li <li.haolin@qq.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Josua Mayer <josua@solid-run.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nate Drude <nate.d@variscite.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Stefan Roese <sr@denx.de>
Cc: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot-amlogic@groups.io
---
 drivers/net/phy/phy.c     |  3 ---
 drivers/net/phy/vitesse.c | 45 +++++++++++----------------------------
 include/phy.h             |  1 -
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 404d61c5ab3..fff1d669fcd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_VITESSE
-	phy_vitesse_init();
-#endif
 #ifdef CONFIG_PHY_XILINX
 	phy_xilinx_init();
 #endif
diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index eca26c98938..c5cf0d7dfbd 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -293,7 +293,7 @@ static int vsc8664_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver VSC8211_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8211) =3D {
 	.name	=3D "Vitesse VSC8211",
 	.uid	=3D 0xfc4b0,
 	.mask	=3D 0xffff0,
@@ -303,7 +303,7 @@ static struct phy_driver VSC8211_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8221_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8221) =3D {
 	.name =3D "Vitesse VSC8221",
 	.uid =3D 0xfc550,
 	.mask =3D 0xffff0,
@@ -313,7 +313,7 @@ static struct phy_driver VSC8221_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8244_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8244) =3D {
 	.name =3D "Vitesse VSC8244",
 	.uid =3D 0xfc6c0,
 	.mask =3D 0xffff0,
@@ -323,7 +323,7 @@ static struct phy_driver VSC8244_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8234_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8234) =3D {
 	.name =3D "Vitesse VSC8234",
 	.uid =3D 0xfc620,
 	.mask =3D 0xffff0,
@@ -333,7 +333,7 @@ static struct phy_driver VSC8234_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8574_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8574) =3D {
 	.name =3D "Vitesse VSC8574",
 	.uid =3D 0x704a0,
 	.mask =3D 0xffff0,
@@ -343,7 +343,7 @@ static struct phy_driver VSC8574_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8514_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8514) =3D {
 	.name =3D "Vitesse VSC8514",
 	.uid =3D 0x70670,
 	.mask =3D 0xffff0,
@@ -353,7 +353,7 @@ static struct phy_driver VSC8514_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8584_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8584) =3D {
 	.name =3D "Vitesse VSC8584",
 	.uid =3D 0x707c0,
 	.mask =3D 0xffff0,
@@ -363,7 +363,7 @@ static struct phy_driver VSC8584_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8601_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8601) =3D {
 	.name =3D "Vitesse VSC8601",
 	.uid =3D 0x70420,
 	.mask =3D 0xffff0,
@@ -373,7 +373,7 @@ static struct phy_driver VSC8601_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8641_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8641) =3D {
 	.name =3D "Vitesse VSC8641",
 	.uid =3D 0x70430,
 	.mask =3D 0xffff0,
@@ -383,7 +383,7 @@ static struct phy_driver VSC8641_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8662_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8662) =3D {
 	.name =3D "Vitesse VSC8662",
 	.uid =3D 0x70660,
 	.mask =3D 0xffff0,
@@ -393,7 +393,7 @@ static struct phy_driver VSC8662_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8664_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8664) =3D {
 	.name =3D "Vitesse VSC8664",
 	.uid =3D 0x70660,
 	.mask =3D 0xffff0,
@@ -404,7 +404,7 @@ static struct phy_driver VSC8664_driver =3D {
 };
=20
 /* Vitesse bought Cicada, so we'll put these here */
-static struct phy_driver cis8201_driver =3D {
+U_BOOT_PHY_DRIVER(cis8201) =3D {
 	.name =3D "CIS8201",
 	.uid =3D 0xfc410,
 	.mask =3D 0xffff0,
@@ -414,7 +414,7 @@ static struct phy_driver cis8201_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver cis8204_driver =3D {
+U_BOOT_PHY_DRIVER(cis8204) =3D {
 	.name =3D "Cicada Cis8204",
 	.uid =3D 0xfc440,
 	.mask =3D 0xffff0,
@@ -423,22 +423,3 @@ static struct phy_driver cis8204_driver =3D {
 	.startup =3D &vitesse_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_vitesse_init(void)
-{
-	phy_register(&VSC8641_driver);
-	phy_register(&VSC8601_driver);
-	phy_register(&VSC8234_driver);
-	phy_register(&VSC8244_driver);
-	phy_register(&VSC8211_driver);
-	phy_register(&VSC8221_driver);
-	phy_register(&VSC8574_driver);
-	phy_register(&VSC8584_driver);
-	phy_register(&VSC8514_driver);
-	phy_register(&VSC8662_driver);
-	phy_register(&VSC8664_driver);
-	phy_register(&cis8201_driver);
-	phy_register(&cis8204_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index e6508a132d0..74f3ada2491 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_vitesse_init(void);
 int phy_xilinx_init(void);
 int phy_xway_init(void);
 int phy_mscc_init(void);
--=20
2.39.2

