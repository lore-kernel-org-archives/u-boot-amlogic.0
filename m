Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web11.21085.1679245499747012934
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAF6+EGJ3XlrLyeJjoshq6rHLOwbFgsbfh6cveuGMz8=;
	b=UzWFwvxTwV+uQwRZDC+dU4N3uVJJI+ykD+Bo7DDBPuM8P9GPzGlyuD/slXB0eTjsg4ADBB
	2CxIPrg+qr1efEQJYtY0+lP95GIE2QdjNKAolRvSQXH+sd2UwxRgJaE/0cQkfRy1faGbxF
	mjh78aj3IoRRV+U+6vvbiaDUQ+rK5srk76Z89gkRii7ThhF0t9iI9yI5t+g71V/j0Xou0V
	MeYJOq2vH9lialGvS3m9z5mQtQwimytF4J3hVBtZeyASORG61yq4XknsweunJFkwwZ2imR
	p77erBJXoam3cHGd31C1nhAsCJ7munnQWm5KoSj0bhhqXq/A17YN0I/X16e6mg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAF6+EGJ3XlrLyeJjoshq6rHLOwbFgsbfh6cveuGMz8=;
	b=fG8ivzuFSYD/pTP+kOh+6wJVjg/Hkn9wXzKMwekUuf9vIyl+kxoQPyrKKTkN0uSYAFDxRw
	IORXnEI0MOjq3QFdBfxoN3Ct9+jVAtBi8r9iP85qx7geAaYJFyUkeS9hzBu09SgygPJop+
	v5bCSO82t9sxm7O+dh3jF719N25+6OGuOjSH4EhA8smQso4bpHzpJa6od23uxC/fdVBDNd
	c7/bePhY3XvPTmAx2eif2IhCdIvd1H2yvN2y+nG75hrGHugGPMLP8p53Utsh5GZyLpu8bW
	ZjJGwkjaNNcxuTo3+te80iFFRGvJEr1VDwCFlDL1onnBFrWWLP7fbYouQuMROg==
Subject: [PATCH 20/41] net: phy: ksz90x1: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:56 +0100
Message-Id: <20230319170317.27711-20-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/micrel_ksz90x1.c | 14 +++-----------
 drivers/net/phy/phy.c            |  3 ---
 include/phy.h                    |  1 -
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz9=
0x1.c
index 79ebdb5e82a..ffc3c987eaa 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -270,7 +270,7 @@ static int ksz9021_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver ksz9021_driver =3D {
+U_BOOT_PHY_DRIVER(ksz9021) =3D {
 	.name =3D "Micrel ksz9021",
 	.uid  =3D 0x221610,
 	.mask =3D 0xfffffe,
@@ -368,7 +368,7 @@ static int ksz9031_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver ksz9031_driver =3D {
+U_BOOT_PHY_DRIVER(ksz9031) =3D {
 	.name =3D "Micrel ksz9031",
 	.uid  =3D PHY_ID_KSZ9031,
 	.mask =3D MII_KSZ9x31_SILICON_REV_MASK,
@@ -477,7 +477,7 @@ static int ksz9131_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver ksz9131_driver =3D {
+U_BOOT_PHY_DRIVER(ksz9131) =3D {
 	.name =3D "Micrel ksz9131",
 	.uid  =3D PHY_ID_KSZ9131,
 	.mask =3D MII_KSZ9x31_SILICON_REV_MASK,
@@ -497,11 +497,3 @@ int ksz9xx1_phy_get_id(struct phy_device *phydev)
=20
 	return phyid;
 }
-
-int phy_micrel_ksz90x1_init(void)
-{
-	phy_register(&ksz9021_driver);
-	phy_register(&ksz9031_driver);
-	phy_register(&ksz9131_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b2b2d6edfa7..4747011cda2 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_MICREL_KSZ90X1
-	phy_micrel_ksz90x1_init();
-#endif
 #ifdef CONFIG_PHY_MESON_GXL
 	phy_meson_gxl_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 27d9742c6c4..570524a21f5 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_micrel_ksz90x1_init(void);
 int phy_meson_gxl_init(void);
 int phy_natsemi_init(void);
 int phy_nxp_c45_tja11xx_init(void);
--=20
2.39.2

