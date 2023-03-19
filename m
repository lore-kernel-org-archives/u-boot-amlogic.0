Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21080.1679245497150193123
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg7v6rOrWShdLt5WeXJr39ZOxemC9D4ctKGdE+B81Uw=;
	b=shCMfuSUM+iSAAK48F+QzzxzJQJep/5llvNkatbB5/gegHLKK2MgfdFsk0nmlfuPHZtICs
	F1SIW6xgTwjwMHrnIOrB+Wr6VEBUkDlMz/HDHuogBx8CxuxFjXhYKBg1DVP9pJb5ChRKP/
	kCTh0z0QHGi+UQGmMvOhCiB0YxZ/nj7gLwInaDP2fH2nC5PR+Rz1wEILw8VXkiGQ9t0eBu
	eN4n09QkW013Z/YSQuq9DHmc/giYx5RIcvqrRXIaLoNDGdIv1jG41ORwf1xp3Uw3ekA11o
	F4Iagzyty9irlds7Cg1bjPiLxeix8emHAmBneqN6MjUiTIJAoKsOIeMEM4DCZw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg7v6rOrWShdLt5WeXJr39ZOxemC9D4ctKGdE+B81Uw=;
	b=IjnxpeR0wJvaXpVyu3f1keV7eUtRE8c8TzQH9CrDWIDiZ+eWgZA+11Gvvuxw8GitRr8Y2Q
	BQ9AO6WbMhR5R3s1L/3TW4mYK8RP6/yIUJRkKKexqu10eO83YhJpIZLoLOx0yq994R3ORU
	AXWRFuBBxr01XF2XAbyBHPaz3bggoGWtwBIVyHun58MyJj7fbnU3NCNFgPpyClAyv8ev0o
	ZGhR0bVIDzpWLpo3L0bsiSnEBgFzV04W8ErlEusZ37Qchbs43uoJWt6noIg9gEMMacS4ku
	tM1qQXnd+CS61IqqWHgHG+plsjBpWiSJmkYuiQHm08tqJ5OtNDSD0v+b9SsZVw==
Subject: [PATCH 19/41] net: phy: ksz8xxx: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:55 +0100
Message-Id: <20230319170317.27711-19-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/micrel_ksz8xxx.c | 29 ++++++++---------------------
 drivers/net/phy/phy.c            |  3 ---
 include/phy.h                    |  1 -
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/micrel_ksz8xxx.c b/drivers/net/phy/micrel_ksz8=
xxx.c
index 60d42fe9840..b0f3abcb037 100644
--- a/drivers/net/phy/micrel_ksz8xxx.c
+++ b/drivers/net/phy/micrel_ksz8xxx.c
@@ -14,7 +14,7 @@
 #include <phy.h>
 #include <linux/bitops.h>
=20
-static struct phy_driver KSZ804_driver =3D {
+U_BOOT_PHY_DRIVER(ksz804) =3D {
 	.name =3D "Micrel KSZ804",
 	.uid =3D 0x221510,
 	.mask =3D 0xfffff0,
@@ -44,7 +44,7 @@ static int ksz_genconfig_bcastoff(struct phy_device *phyd=
ev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver KSZ8031_driver =3D {
+U_BOOT_PHY_DRIVER(ksz8031) =3D {
 	.name =3D "Micrel KSZ8021/KSZ8031",
 	.uid =3D 0x221550,
 	.mask =3D 0xfffff0,
@@ -72,7 +72,7 @@ static int ksz8051_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver KSZ8051_driver =3D {
+U_BOOT_PHY_DRIVER(ksz8051) =3D {
 	.name =3D "Micrel KSZ8051",
 	.uid =3D 0x221550,
 	.mask =3D 0xfffff0,
@@ -87,7 +87,7 @@ static int ksz8061_config(struct phy_device *phydev)
 	return phy_write(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
 }
=20
-static struct phy_driver KSZ8061_driver =3D {
+U_BOOT_PHY_DRIVER(ksz8061) =3D {
 	.name =3D "Micrel KSZ8061",
 	.uid =3D 0x00221570,
 	.mask =3D 0xfffff0,
@@ -115,7 +115,7 @@ static int ksz8081_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver KSZ8081_driver =3D {
+U_BOOT_PHY_DRIVER(ksz8081) =3D {
 	.name =3D "Micrel KSZ8081",
 	.uid =3D 0x221560,
 	.mask =3D 0xfffff0,
@@ -172,7 +172,7 @@ static int ksz8895_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver ksz8895_driver =3D {
+U_BOOT_PHY_DRIVER(ksz8895) =3D {
 	.name =3D "Micrel KSZ8895/KSZ8864",
 	.uid  =3D 0x221450,
 	.mask =3D 0xffffe1,
@@ -185,7 +185,7 @@ static struct phy_driver ksz8895_driver =3D {
 /* Micrel used the exact same model number for the KSZ9021,
  * so the revision number is used to distinguish them.
  */
-static struct phy_driver KS8721_driver =3D {
+U_BOOT_PHY_DRIVER(ks8721) =3D {
 	.name =3D "Micrel KS8721BL",
 	.uid =3D 0x221618,
 	.mask =3D 0xfffffc,
@@ -210,7 +210,7 @@ static int ksz886x_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver ksz886x_driver =3D {
+U_BOOT_PHY_DRIVER(ksz886x) =3D {
 	.name =3D "Micrel KSZ886x Switch",
 	.uid  =3D 0x00221430,
 	.mask =3D 0xfffff0,
@@ -219,16 +219,3 @@ static struct phy_driver ksz886x_driver =3D {
 	.startup =3D &ksz886x_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_micrel_ksz8xxx_init(void)
-{
-	phy_register(&KSZ804_driver);
-	phy_register(&KSZ8031_driver);
-	phy_register(&KSZ8051_driver);
-	phy_register(&KSZ8061_driver);
-	phy_register(&KSZ8081_driver);
-	phy_register(&KS8721_driver);
-	phy_register(&ksz8895_driver);
-	phy_register(&ksz886x_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index efc75808ead..b2b2d6edfa7 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_MICREL_KSZ8XXX
-	phy_micrel_ksz8xxx_init();
-#endif
 #ifdef CONFIG_PHY_MICREL_KSZ90X1
 	phy_micrel_ksz90x1_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 77e46ebac83..27d9742c6c4 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_micrel_ksz8xxx_init(void);
 int phy_micrel_ksz90x1_init(void);
 int phy_meson_gxl_init(void);
 int phy_natsemi_init(void);
--=20
2.39.2

