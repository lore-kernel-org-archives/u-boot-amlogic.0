Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21092.1679245508134509330
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2MmiQfuugLRYTYFtceYxZ4yzAxB4Zf/HHCN0eBogCE=;
	b=kn7B5fB9+f1dNTVUj8IyESygSFfmOlcuDXAj/b7FHwpDKZWzia5cAV4bYpBmK+mrzFpQlr
	sgEh/KlE34fDAG+QQrZxIq6HumP8gn53fnnR2fu2hqRZLLTzAAOaV5At2+o0Fzzwltg0se
	ewgPTyZGkGDC+EyGQchXULwk59mVE128QBdpFGT6f/7ATMulTH1PsEGyAohUoexYb7lAKb
	qJ9bb5eh37JN2LvMeNY50jqHet0x3x/01qu7Qno7W/lm2fe0yUFstMW93aZy7ME08TtW01
	8ixzsOMOb7+RuWirmIy4sXzRje7P108SBxxAb3GJ3gfbqSbt6/XX6wov94ef1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2MmiQfuugLRYTYFtceYxZ4yzAxB4Zf/HHCN0eBogCE=;
	b=QRNrqDoEVBCObLt/9SoH3v7POArXcNZRZV1VfOrL8BjkTSSJ9rWcvb+rgSSAfOAAhsqgF3
	GhwMXozMgKjRuaWIenwu7VhRTUfmwkx47T4+68A449KsspzKLlDprVfh2501GY9CHmT7Ye
	eZ5osMfYPk94LZq9XWUys18pnl0YcCQJDPkx00lyTlGnvPcFG7BYMietOg0J4jyskEymav
	gfrbYDJeAjedceyPZifNIY7nNpL4cz5U4jakYddOSt0gMQFZN4hXEFcb9h2dUX1ydfFdf0
	vqFFl1AXBTNo4EV1/IxiXK8zRfPB783k9yHagFrSdCvHJHlp1+UpAA7FYhWIVw==
Subject: [PATCH 23/41] net: phy: nxp-c45-tja11xx: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:59 +0100
Message-Id: <20230319170317.27711-23-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/nxp-c45-tja11xx.c | 8 +-------
 drivers/net/phy/phy.c             | 3 ---
 include/phy.h                     | 1 -
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tj=
a11xx.c
index a0f41fab698..f701790194c 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -330,7 +330,7 @@ static int nxp_c45_probe(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver nxp_c45_tja11xx =3D {
+U_BOOT_PHY_DRIVER(nxp_c45_tja11xx) =3D {
 	.name =3D "NXP C45 TJA1103",
 	.uid  =3D PHY_ID_TJA_1103,
 	.mask =3D 0xfffff0,
@@ -340,9 +340,3 @@ static struct phy_driver nxp_c45_tja11xx =3D {
 	.startup =3D &nxp_c45_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_nxp_c45_tja11xx_init(void)
-{
-	phy_register(&nxp_c45_tja11xx);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3d6fc8080e5..706b9505d6e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_NXP_C45_TJA11XX_PHY
-	phy_nxp_c45_tja11xx_init();
-#endif
 #ifdef CONFIG_PHY_NXP_TJA11XX
 	phy_nxp_tja11xx_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 647d23595d1..aa65ae16f68 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_nxp_c45_tja11xx_init(void);
 int phy_nxp_tja11xx_init(void);
 int phy_realtek_init(void);
 int phy_smsc_init(void);
--=20
2.39.2

