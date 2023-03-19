Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21375.1679245484754848026
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=291kacJ8PiryGugJA/ULO0LCrx7UCLfPJkOSv4BCZ7M=;
	b=eHyezeJOgwJU+fQUogjBajUeH7s5rSL/kBVA4zzZ7SYzLAgPdjeBs5S9E8UNKT0N79bCL7
	l/pxMa1je9vr6O/BS30tLsW0Q7hALzPSb0YLLheRuRVNkvrOBAJ/DflgAUoLp3t7PIKd4B
	csf8piKCdGdQ+x7GAXyVDMETdfdoGO4l3USyXKEilR9SLNJr6JrgPVYxyNuUTXV1OPBTjf
	ILJva6IkEwlXbRCtb8AgVzbC0l5lX5Xraj/wgqz76m8x6tE2NQz6uq9f+5tkAv2pvfIA9+
	cJ4ze2ICswSf70UsD4MxbAlR7YquLj95vwtXNvWDA9l9gYh771+L6soAlLVTUQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=291kacJ8PiryGugJA/ULO0LCrx7UCLfPJkOSv4BCZ7M=;
	b=TEE1lL4ceS/2UiAnOp1uwfaKVe9Rr1QAJFn41j5r7w43X/cWRoUBPx50aM6QNqBn/k3w21
	VuZgPpxE4EEH3UzMvrYu6pLpYVVnk4iBhUDEVOpipRoo0MiImekoo12XRDMnRiLA4hp9li
	IkvDDE7hLdOOJ6KHPHkC+2IVzU9ovSesC8SBTIZLAmf7+rDBjIEiZWT+/D8TXqdHP9hXhM
	vpkxugQGWFTiRYDxHwDrGx9WCFSIFdjK/wZZ6b0HMBzqV8M5MpdRgTLzrqGtuP9HCviut3
	b1txaiSHh8tPxqK2m+FuWcoY1PeaVCdPi2PCajODAMk9OX2EN8pKPmM11fR8lw==
Subject: [PATCH 14/41] net: phy: davicom: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:50 +0100
Message-Id: <20230319170317.27711-14-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/davicom.c | 9 +--------
 drivers/net/phy/phy.c     | 3 ---
 include/phy.h             | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
index 4666497d44f..31ffa1ac7a9 100644
--- a/drivers/net/phy/davicom.c
+++ b/drivers/net/phy/davicom.c
@@ -69,7 +69,7 @@ static int dm9161_startup(struct phy_device *phydev)
 	return dm9161_parse_status(phydev);
 }
=20
-static struct phy_driver DM9161_driver =3D {
+U_BOOT_PHY_DRIVER(dm9161) =3D {
 	.name =3D "Davicom DM9161E",
 	.uid =3D 0x181b880,
 	.mask =3D 0xffffff0,
@@ -78,10 +78,3 @@ static struct phy_driver DM9161_driver =3D {
 	.startup =3D &dm9161_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_davicom_init(void)
-{
-	phy_register(&DM9161_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d595290dd4b..6d7e07c25a5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -517,9 +517,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_DAVICOM
-	phy_davicom_init();
-#endif
 #ifdef CONFIG_PHY_ET1011C
 	phy_et1011c_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 797139bf681..51c2ddb7e4e 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -316,7 +316,6 @@ int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_mv88e61xx_init(void);
-int phy_davicom_init(void);
 int phy_et1011c_init(void);
 int phy_lxt_init(void);
 int phy_marvell_init(void);
--=20
2.39.2

