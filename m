Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web10.21385.1679245511135275916
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH5+e+ddTXG1FW/R0GJZAqkqFn7c8qvoV1G8VlowmVg=;
	b=qWG0zlQ0fRUsJO9bjx9Yh96s0Jyv26/NzG5eqy7opB5VbeCwRdSr1uP54nI2U/bxo8zgyZ
	JL9Ep0tUzXVQZJ3VvfLyYqccry+1P0lT9ielO3yj+WyRG67cLfknZhpxYDlAU/fUnIN3+Q
	1evrRKN1bCEaR3f1YIDP0se0vv60rSaS7m4PaOhnR2+cXCEJYmvFBMwxmji7gQJuoYg1/+
	OQodsYz8upPEIF4K2r1EHPzVrDZmo9PNP/2CBx6gVhh2crnxcQLktI7GCe0Zj8SMKixG/u
	nc0Pv7tcC5jKfOqykAbtOemhsaEZb8UmpXJU7Zz0wJe5CJsiLiIxhMOk5/KNKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH5+e+ddTXG1FW/R0GJZAqkqFn7c8qvoV1G8VlowmVg=;
	b=S22t4TdQtjn7QI+flzMWWBr8rH/YpzNyVPnTLPy/T5/ZT4JdyJFz5BPphP5J6dovFPz/s1
	KjA4lpnMPJml2loqLj38fqgmcXKM6bezZCT7lADRo52XX50VacdEALl9R/2eG5rTqRAoEo
	t2YzmPsJSMQYfDvhJIVDgm3DV1Rs0W4mgrOkcXNYtllwAfStYMTdS8QG2Qbt1r6g3suGCT
	5u9kHWMZJ5taQ6vc/9s0KejjQKCFKXG0xfZRkD+TPInBXExHzxDpCJN/WcssbY2Ar6NF+x
	NLCQuDvJ/kGnzKu96P/loZjDiulrMpQT9ElG5gyWvPr0eLw+ave2jb3VxaJBtA==
Subject: [PATCH 24/41] net: phy: nxp-tja11xx: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:00 +0100
Message-Id: <20230319170317.27711-24-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/nxp-tja11xx.c | 12 ++----------
 drivers/net/phy/phy.c         |  3 ---
 include/phy.h                 |  1 -
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 30dec5e605b..471b0e322b5 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -248,7 +248,7 @@ static int tja11xx_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver TJA1100_driver =3D {
+U_BOOT_PHY_DRIVER(tja1100) =3D {
 	.name =3D "NXP TJA1100",
 	.uid =3D PHY_ID_TJA1100,
 	.mask =3D PHY_ID_MASK,
@@ -258,7 +258,7 @@ static struct phy_driver TJA1100_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver TJA1101_driver =3D {
+U_BOOT_PHY_DRIVER(tja1101) =3D {
 	.name =3D "NXP TJA1101",
 	.uid =3D PHY_ID_TJA1101,
 	.mask =3D PHY_ID_MASK,
@@ -267,11 +267,3 @@ static struct phy_driver TJA1101_driver =3D {
 	.startup =3D &tja11xx_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_nxp_tja11xx_init(void)
-{
-	phy_register(&TJA1100_driver);
-	phy_register(&TJA1101_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 706b9505d6e..03d221f216d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_NXP_TJA11XX
-	phy_nxp_tja11xx_init();
-#endif
 #ifdef CONFIG_PHY_REALTEK
 	phy_realtek_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index aa65ae16f68..bc42a522ea6 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_nxp_tja11xx_init(void);
 int phy_realtek_init(void);
 int phy_smsc_init(void);
 int phy_teranetics_init(void);
--=20
2.39.2

