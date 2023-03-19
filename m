Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web11.21102.1679245533625782974
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ee+F/ykc97LIjy8MRZU34S4jplrozEx2DFoAXIu61E=;
	b=F6h77W5pFv7BzqJOXg4dZyd5hh/J0dPUQl/Cd4MLj99PxJJXTLhqHbJVv6CuKccNNn0bs/
	RPkrfa02tro8O/ES1wuU1vYcgbzJaNoO9iUsDQz6t23GtqPaCgWuFrPdLz3HLiocJjIfhA
	ggK+zBPcFXuoRnS5uUnyJB4tpa7j1zdxr/q3NkJ/4/83CG0+TS9893cmyThWnJyqrSFn0X
	aN6ZLJUdJ0rP42MwxBq0jt7971M/Tybrpxz7tC2yS1w6mclfcIfzGZGMUjnJ2fkVLWmKZB
	p7Z0XHdF7q1aMiRWc2q4Ks5SOHVC+5ULiyurOyGJczeF3kODLrRWSSzdDf7dVA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ee+F/ykc97LIjy8MRZU34S4jplrozEx2DFoAXIu61E=;
	b=Rii4IKhDfr/feVDoJEJxIsE5Tqpxb1cUf7JBVcPcA+cSfyH7kl8c30wgOJ4uw11OBUMGHT
	gAmj5/DJCGxkF/xFSR6UDX/rTnjpjmyrCpTP09+QxUwjlTEkfa8SAxjown1g9hyvqnVr/2
	AWEVN76SQd9DmF1bgrPioaFDu2sIdNkGUGd0cEoMyg9dGNoxvKdi0cmp7bH/cjppYWQnmR
	OsJ+AbOQWk0fsliUh0fYe79E5XTX+9SWHEJHzfdbfsOqpe4Q/2vNW01aGjjt+ctxrTiRx7
	1PfNmOLIM/hY0ycJ+oDfcw9Bg94YQfjPkPFOlQG6wv+97+FKakyM+P+PvqMt6Q==
Subject: [PATCH 32/41] net: phy: mscc: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:08 +0100
Message-Id: <20230319170317.27711-32-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/mscc.c | 27 +++++++--------------------
 drivers/net/phy/phy.c  |  3 ---
 include/phy.h          |  1 -
 3 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index f9482b21a01..ef1761a8bda 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1558,7 +1558,7 @@ static int vsc8502_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver VSC8530_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8530) =3D {
 	.name =3D "Microsemi VSC8530",
 	.uid =3D PHY_ID_VSC8530,
 	.mask =3D 0x000ffff0,
@@ -1568,7 +1568,7 @@ static struct phy_driver VSC8530_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8531_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8531) =3D {
 	.name =3D "Microsemi VSC8531",
 	.uid =3D PHY_ID_VSC8531,
 	.mask =3D 0x000ffff0,
@@ -1578,7 +1578,7 @@ static struct phy_driver VSC8531_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8502_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8502) =3D {
 	.name =3D "Microsemi VSC8502",
 	.uid =3D PHY_ID_VSC8502,
 	.mask =3D 0x000ffff0,
@@ -1588,7 +1588,7 @@ static struct phy_driver VSC8502_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8540_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8540) =3D {
 	.name =3D "Microsemi VSC8540",
 	.uid =3D PHY_ID_VSC8540,
 	.mask =3D 0x000ffff0,
@@ -1598,7 +1598,7 @@ static struct phy_driver VSC8540_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8541_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8541) =3D {
 	.name =3D "Microsemi VSC8541",
 	.uid =3D PHY_ID_VSC8541,
 	.mask =3D 0x000ffff0,
@@ -1608,7 +1608,7 @@ static struct phy_driver VSC8541_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8574_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8574) =3D {
 	.name =3D "Microsemi VSC8574",
 	.uid =3D PHY_ID_VSC8574,
 	.mask =3D 0x000ffff0,
@@ -1618,7 +1618,7 @@ static struct phy_driver VSC8574_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver VSC8584_driver =3D {
+U_BOOT_PHY_DRIVER(vsc8584) =3D {
 	.name =3D "Microsemi VSC8584",
 	.uid =3D PHY_ID_VSC8584,
 	.mask =3D 0x000ffff0,
@@ -1627,16 +1627,3 @@ static struct phy_driver VSC8584_driver =3D {
 	.startup =3D &mscc_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_mscc_init(void)
-{
-	phy_register(&VSC8530_driver);
-	phy_register(&VSC8531_driver);
-	phy_register(&VSC8502_driver);
-	phy_register(&VSC8540_driver);
-	phy_register(&VSC8541_driver);
-	phy_register(&VSC8574_driver);
-	phy_register(&VSC8584_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1542fe89252..c20e750aa16 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_MSCC
-	phy_mscc_init();
-#endif
 #ifdef CONFIG_PHY_FIXED
 	phy_fixed_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index fc8300d5d97..e4a3e10c48b 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_mscc_init(void);
 int phy_fixed_init(void);
 int phy_ncsi_init(void);
 int phy_xilinx_gmii2rgmii_init(void);
--=20
2.39.2

