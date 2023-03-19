Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web11.21077.1679245491807113619
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E7ien80ie/hP4mOXwvaD2xCsT3HupKLOgs1I0m062E=;
	b=rYuBrP1epxr7YlfiwMySipVZPRqrzYfEkhtVVBJM24suUrzJTgvk2RP4azoqCxGQAfgp9h
	sD5RINICRQnEn/zhOHHsymp8rgj34YQoCrFaAbEQvfeZE7SFVJ5rJ2oDMfTrzMdbpfhgiG
	ie+/jAADBCERulfntDdX3I6JGUIXxbCgtM8+uvGVyaHGbFq7uO0vge2NWbCfHepE2HO6f5
	gxj4jpt1N6k5NCKP+o0J4zFXKfEPgdXZQNqy5JTpgat7UUrM3ZBLWV1yT0oS6FWq8G1T5I
	pDQZaSW2c9egGsI+f5ESYDeAofT7w2w51IYaBv0NHi5zCno65V/PW5T6v4fRpA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E7ien80ie/hP4mOXwvaD2xCsT3HupKLOgs1I0m062E=;
	b=WHggA2YGa0TcoRboEP9DRgOjeeA6qTLvjhMySxCYGiFL7bQDsnFehgDjYwYyuRikyw+ALH
	mhNhDfn8LsgT4eZNK/00eAO5G8nEd5kmqW+OXUixJfmrO1RaX82MQgfwy+SwHzo2Zi5nyt
	QX5NvWljpLUIKnDtikSGmN0S/vzMwYACzmZjws2oeqCpdNMAVIT05q5Mz/K+/Axmj0zIKZ
	JgsdzdQpTJy3HLhavOkDDwCeLWMkNm83SQ/HX0w5FSFWAjXn9aq55YGOr0zO+U/kVTrIv2
	spnUjF9rwjqUuNv6RT3qMHMjLXcdjf7y4SdDo7qIejjqsEiwHcNmp704FdXLGg==
Subject: [PATCH 17/41] net: phy: lxt: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:53 +0100
Message-Id: <20230319170317.27711-17-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/lxt.c | 9 +--------
 drivers/net/phy/phy.c | 3 ---
 include/phy.h         | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index 2618deb0096..20940033a38 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -58,7 +58,7 @@ static int lxt971_startup(struct phy_device *phydev)
 	return lxt971_parse_status(phydev);
 }
=20
-static struct phy_driver LXT971_driver =3D {
+U_BOOT_PHY_DRIVER(lxt971) =3D {
 	.name =3D "LXT971",
 	.uid =3D 0x1378e0,
 	.mask =3D 0xfffff0,
@@ -67,10 +67,3 @@ static struct phy_driver LXT971_driver =3D {
 	.startup =3D &lxt971_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_lxt_init(void)
-{
-	phy_register(&LXT971_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 5b6e6294377..e2e31773f6a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_LXT
-	phy_lxt_init();
-#endif
 #ifdef CONFIG_PHY_MARVELL
 	phy_marvell_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 3bc4a0de724..a309056ce77 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_lxt_init(void);
 int phy_marvell_init(void);
 int phy_micrel_ksz8xxx_init(void);
 int phy_micrel_ksz90x1_init(void);
--=20
2.39.2

