Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web10.21381.1679245494566199002
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ex8qlmEOiee+xAjQL9CfY0uLzeuWdrlY3r1aQPk/aOs=;
	b=l9j8xVEZV2a6SlZj8iCx76vHG1HPKc9v0NqWuoR3bnLvynk3aw8YHScVIrdIlJL99gJCsh
	RhiI2fDFo83fvyExWa6qg/PTNWLx21azf/pxRXkIt2y+7Jv/ndmWjvh5JOnfi9+GBeEh2h
	R5zLOY3GkvZWdv7nMLSNi4blcqI7odhU915PGcNN8PgAAyQEA2quc4vV//SUB8hjz8GDfS
	9exrJisBFU9n1reBLHBt0WxKNXfzluQD4AkFYhVH76Q7LxMbokNA9ChXyOWLjP5MrM6jcM
	7eA7PBxQXGPo9CkBbRwUE43/1DlnAmuLVbMZhmRArmm/NLwE+LqjwPPTcIU+/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ex8qlmEOiee+xAjQL9CfY0uLzeuWdrlY3r1aQPk/aOs=;
	b=JGHcE77houHW8EiCXNCG8O/nCV5aaqJ04DIhzGJnrAp43GpOS0jTr639yiD65KCwkl2p/s
	h2y1j6H8gizd6yJcFNyWFdUDJPc1ZP9UCf28apQdd6E4eM2VxAOggnghrzutvFQUJg4iNu
	E/CPp+fPdVHwrYKI/siGM0i5hucKzEJsApy9N3Wd5KtDVsv+i2fcDS7svfUj43YS7goSB+
	QjfYYe5/9It5kinzl2+N3nSMBz2aArFfM3drqr2HOYQgpF73LooNbiKJJqgK9tkY8aogV7
	qzJDMkTVSilLibJMxI+T0NrHdda1U+RGojwWZUmXZnpzOOaFBSDWUv6VaHuweA==
Subject: [PATCH 18/41] net: phy: marvell: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:54 +0100
Message-Id: <20230319170317.27711-18-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/marvell.c | 39 +++++++++++----------------------------
 drivers/net/phy/phy.c     |  3 ---
 include/phy.h             |  1 -
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 1a25775eee6..8992be6e89e 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -693,7 +693,7 @@ static int m88e1680_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver M88E1011S_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1011s) =3D {
 	.name =3D "Marvell 88E1011S",
 	.uid =3D 0x1410c60,
 	.mask =3D 0xffffff0,
@@ -703,7 +703,7 @@ static struct phy_driver M88E1011S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1111S_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1111s) =3D {
 	.name =3D "Marvell 88E1111S",
 	.uid =3D 0x1410cc0,
 	.mask =3D 0xffffff0,
@@ -713,7 +713,7 @@ static struct phy_driver M88E1111S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1118_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1118) =3D {
 	.name =3D "Marvell 88E1118",
 	.uid =3D 0x1410e10,
 	.mask =3D 0xffffff0,
@@ -723,7 +723,7 @@ static struct phy_driver M88E1118_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1118R_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1118r) =3D {
 	.name =3D "Marvell 88E1118R",
 	.uid =3D 0x1410e40,
 	.mask =3D 0xffffff0,
@@ -733,7 +733,7 @@ static struct phy_driver M88E1118R_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1121R_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1121r) =3D {
 	.name =3D "Marvell 88E1121R",
 	.uid =3D 0x1410cb0,
 	.mask =3D 0xffffff0,
@@ -743,7 +743,7 @@ static struct phy_driver M88E1121R_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1145_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1145) =3D {
 	.name =3D "Marvell 88E1145",
 	.uid =3D 0x1410cd0,
 	.mask =3D 0xffffff0,
@@ -753,7 +753,7 @@ static struct phy_driver M88E1145_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1149S_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1149s) =3D {
 	.name =3D "Marvell 88E1149S",
 	.uid =3D 0x1410ca0,
 	.mask =3D 0xffffff0,
@@ -763,7 +763,7 @@ static struct phy_driver M88E1149S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1240_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1240) =3D {
 	.name =3D "Marvell 88E1240",
 	.uid =3D 0x1410e30,
 	.mask =3D 0xffffff0,
@@ -773,7 +773,7 @@ static struct phy_driver M88E1240_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E151x_driver =3D {
+U_BOOT_PHY_DRIVER(m88e151x) =3D {
 	.name =3D "Marvell 88E151x",
 	.uid =3D 0x1410dd0,
 	.mask =3D 0xffffff0,
@@ -785,7 +785,7 @@ static struct phy_driver M88E151x_driver =3D {
 	.writeext =3D &m88e1xxx_phy_extwrite,
 };
=20
-static struct phy_driver M88E1310_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1310) =3D {
 	.name =3D "Marvell 88E1310",
 	.uid =3D 0x01410e90,
 	.mask =3D 0xffffff0,
@@ -795,7 +795,7 @@ static struct phy_driver M88E1310_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver M88E1680_driver =3D {
+U_BOOT_PHY_DRIVER(m88e1680) =3D {
 	.name =3D "Marvell 88E1680",
 	.uid =3D 0x1410ed0,
 	.mask =3D 0xffffff0,
@@ -804,20 +804,3 @@ static struct phy_driver M88E1680_driver =3D {
 	.startup =3D &genphy_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_marvell_init(void)
-{
-	phy_register(&M88E1310_driver);
-	phy_register(&M88E1149S_driver);
-	phy_register(&M88E1145_driver);
-	phy_register(&M88E1121R_driver);
-	phy_register(&M88E1118_driver);
-	phy_register(&M88E1118R_driver);
-	phy_register(&M88E1111S_driver);
-	phy_register(&M88E1011S_driver);
-	phy_register(&M88E1240_driver);
-	phy_register(&M88E151x_driver);
-	phy_register(&M88E1680_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e2e31773f6a..efc75808ead 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_MARVELL
-	phy_marvell_init();
-#endif
 #ifdef CONFIG_PHY_MICREL_KSZ8XXX
 	phy_micrel_ksz8xxx_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index a309056ce77..77e46ebac83 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_marvell_init(void);
 int phy_micrel_ksz8xxx_init(void);
 int phy_micrel_ksz90x1_init(void);
 int phy_meson_gxl_init(void);
--=20
2.39.2

