Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web10.21395.1679245536299489145
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euqT65yXedau26WbmMSLdY9hWzf6yxSZXbsx8mlfxSo=;
	b=j8KTu0oL851t/EW/h7o7GAZuai8ge8C/UYtB2N36faxEyJ8q2rndg/FT/Va2K97BpAao6m
	piJl+TTMOxmRuaNnbz3FpP0M2ZbBepatdn33rDEaivU4m9wAwaiIAoOgpd+QhSFUNtoHpk
	3nUkVXeqFkpEIcqVOyi2Vavmu4oTRph7UrZNxB/V7E3sm57X429j3vtSmVgYMf2d6ktvm1
	Rl2o4l8ODV94YTI0EAzWbZFXBntpry2HDi5dkGRygzVXjSyOGczz/GFmMBxApyoDlMB0L+
	w9t+Xo9yDrlxzcm/5d+dz1oe3LCFX5glZXbX/WOhRBSx8HysxZXXyEv/rqn0OA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euqT65yXedau26WbmMSLdY9hWzf6yxSZXbsx8mlfxSo=;
	b=bxwchd4cjS4vwNlRaH5pZ2ZMbp7UxCjS1yolqwEFf8l6l+CzuLe2JI4vMfoERk2fqcBFue
	ppMUqx56KtuI2Lxt1mpx1aREsyvovKDHaBhBa6ljZODkF3ap/nlAb7bbsWF9pKUPIot9lS
	7GbJ3H36LJFnzse4Fo702DgZVuwrMkPu+c+1fymOtesA3ehscWwOVn4ccQk3OMkMeFGnnB
	bMUSpZ5yirf7/34Tjk7J4ZkD6F4dewrURATdw7qWrycB/lT1Yb5Ohx0eGB75nJRhRYLZ6n
	iq5uEPu6jEeeC4zS8LRZi8HcRG7zs2PWdY0n2gNcLEALo6fgQ1VC4h+RQjtiew==
Subject: [PATCH 33/41] net: phy: fixed: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:09 +0100
Message-Id: <20230319170317.27711-33-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/fixed.c | 8 +-------
 drivers/net/phy/phy.c   | 3 ---
 include/phy.h           | 1 -
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 1192915ee52..2f0823b8365 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -93,7 +93,7 @@ static int fixedphy_shutdown(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver fixedphy_driver =3D {
+U_BOOT_PHY_DRIVER(fixedphy) =3D {
 	.uid		=3D PHY_FIXED_ID,
 	.mask		=3D 0xffffffff,
 	.name		=3D "Fixed PHY",
@@ -103,9 +103,3 @@ static struct phy_driver fixedphy_driver =3D {
 	.startup	=3D fixedphy_startup,
 	.shutdown	=3D fixedphy_shutdown,
 };
-
-int phy_fixed_init(void)
-{
-	phy_register(&fixedphy_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c20e750aa16..245357c31dc 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_FIXED
-	phy_fixed_init();
-#endif
 #ifdef CONFIG_PHY_NCSI
 	phy_ncsi_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index e4a3e10c48b..9cabfeedec8 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_fixed_init(void);
 int phy_ncsi_init(void);
 int phy_xilinx_gmii2rgmii_init(void);
=20
--=20
2.39.2

