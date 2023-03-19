Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web11.21063.1679245470229339509
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64b8q/fcJlUlBRDn6Ull1+Py589VdYNDKEU91EOsWeA=;
	b=veTzP7gfQMgXQDwiNaR4srJ74qUxq389kqVN0cH8UqXgYuuvnhOpaXPTSJx2m2Ol1U/SbX
	ocKEL9vpEsSuiGZGwA0hR5I6a1JZ53NJbMtp+lrO+P0tfhD8kXLIAn1fLkgAdEG0B/AMzo
	nNaZHtOLHq2bnR2E48/VNb1spl63Vczln+k9t+bNNQfiJLYRte823Rd+fpDyQUqiRImSik
	L239T2cJFssNSU7RXe4W3E9YTsYUvSyT5Ton5OJg+CQBK7KasOA8wiyzcXVqpOV+qeVyY7
	jd/B7Ccu+ajwDHs4tPPljDv1NfYKL2XUgmWersQ3tXx/YRjo6LKSd2+2vrum3Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64b8q/fcJlUlBRDn6Ull1+Py589VdYNDKEU91EOsWeA=;
	b=wovZM3SFI2CaVy4kKsUH0SKBjVlUAjqRCj3WFY4cAhPqqWqvBu5JQx4rPV+Gf8LeqPq1Zr
	COK+NWEZanYBYpk4RU2s0qbOxE0Olh2OvCoaMQTOPT0cJeyoN1Wu4YkeNzQ7Th0CgVbKJ9
	f0wFNkzQSIyK+XmxNwET4COqx/gNELGlIg/9ni+5DMSiqZ7ZZidbOSSJZKDEql+wc9R07O
	EfX8KzmJnCSoTJHk0rjl0G0YdHNd0Gty2oBYiD4WWLjlQ8bfRr1P/VELFnT6sSmU1ls+3v
	zPmP9q4gG4TbV1qZjEYWf+B2JH1YK0R47nwPbeCoUwYxdNDtwaL3H4VjjGXGrg==
Subject: [PATCH 09/41] net: phy: atheros: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:45 +0100
Message-Id: <20230319170317.27711-9-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/atheros.c | 15 +++------------
 drivers/net/phy/phy.c     |  3 ---
 include/phy.h             |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/atheros.c b/drivers/net/phy/atheros.c
index c6f9f916459..abb7bdf537c 100644
--- a/drivers/net/phy/atheros.c
+++ b/drivers/net/phy/atheros.c
@@ -333,7 +333,7 @@ static int ar803x_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver AR8021_driver =3D  {
+U_BOOT_PHY_DRIVER(AR8021) =3D {
 	.name =3D "AR8021",
 	.uid =3D AR8021_PHY_ID,
 	.mask =3D 0xfffffff0,
@@ -343,7 +343,7 @@ static struct phy_driver AR8021_driver =3D  {
 	.shutdown =3D genphy_shutdown,
 };
=20
-static struct phy_driver AR8031_driver =3D  {
+U_BOOT_PHY_DRIVER(AR8031) =3D {
 	.name =3D "AR8031/AR8033",
 	.uid =3D AR8031_PHY_ID,
 	.mask =3D 0xffffffef,
@@ -353,7 +353,7 @@ static struct phy_driver AR8031_driver =3D  {
 	.shutdown =3D genphy_shutdown,
 };
=20
-static struct phy_driver AR8035_driver =3D  {
+U_BOOT_PHY_DRIVER(AR8035) =3D {
 	.name =3D "AR8035",
 	.uid =3D AR8035_PHY_ID,
 	.mask =3D 0xffffffef,
@@ -362,12 +362,3 @@ static struct phy_driver AR8035_driver =3D  {
 	.startup =3D genphy_startup,
 	.shutdown =3D genphy_shutdown,
 };
-
-int phy_atheros_init(void)
-{
-	phy_register(&AR8021_driver);
-	phy_register(&AR8031_driver);
-	phy_register(&AR8035_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f17f98876e..853302cf974 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -520,9 +520,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_ATHEROS
-	phy_atheros_init();
-#endif
 #ifdef CONFIG_PHY_BROADCOM
 	phy_broadcom_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index a0060cd19ea..a1be1fbe1a1 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -317,7 +317,6 @@ int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_b53_init(void);
 int phy_mv88e61xx_init(void);
-int phy_atheros_init(void);
 int phy_broadcom_init(void);
 int phy_cortina_init(void);
 int phy_cortina_access_init(void);
--=20
2.39.2

