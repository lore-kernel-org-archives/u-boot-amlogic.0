Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web10.21380.1679245489082949865
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrHaWUO9DQWqnPhRo292uD14rJJj7UQUYONajsB3sko=;
	b=AIITD9oJZJWv1xCm6zpdZCclxu5AaZ3Ze6WG9oyGqxOuCHa4GDd7yq61v+lSQyRoQOAGcx
	FPuyXmQtjpphGCZ41R+KUvYKo6kgA/0BWNaXySG3ym3FTyvnE5J+qixxUkW9WRV75+4XIU
	kEHib+sfPwCZPpWw8OrGo4tEXtDCu+d/AwmnkYFRpXsiGJ4C3xttD5ypw7WVI1SRLMFlOA
	3EO3KYDIsl+GcDAzt0wvVUrtR5pTTji5z+bm7szTh4gfFyzcRQgen05PTVwMTHw6jnjWJv
	1/jPaYU1fhHtQGjG8tXXveDzreKv+p+SSM3+pkv8MNVPSNNJ5Zc6cHujJdA/Yw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrHaWUO9DQWqnPhRo292uD14rJJj7UQUYONajsB3sko=;
	b=xA0gd77wjJPbYYnZpY1e6uP0+fzxC7beGTWR9wHDDxot/OmMzoKwSE8SQD2SCDxLVN65sX
	0ZcJGcWXGtrDT7WI1ffZRXXSV2p4xiTuKdI35k3fBs/9w0PPaIyOMZSkLC06R7p2owlLoX
	lVrK35R5vGFd+qqC17VPpaT40IpasDMVYvF+Zl4p5dQkcJxNom3AzQGjQUBgJFtq3Yl7lb
	wBBhNuhJYvj9onUUmYdNKpUpvyfKbxbUyXdpBiqfhAL6fqKniNvGY9M7+Y6YPKsp/wgSIr
	5gtdaW6NBywYE5sC54Sl1qSrE+hGiKyX4/eVfFq1gD+/Vz5dE5zyhoZhgplNoQ==
Subject: [PATCH 16/41] net: phy: et1011c: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:52 +0100
Message-Id: <20230319170317.27711-16-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/et1011c.c | 9 +--------
 drivers/net/phy/phy.c     | 3 ---
 include/phy.h             | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/et1011c.c b/drivers/net/phy/et1011c.c
index 7eff5ec7cac..fa4831427d5 100644
--- a/drivers/net/phy/et1011c.c
+++ b/drivers/net/phy/et1011c.c
@@ -87,7 +87,7 @@ static int et1011c_startup(struct phy_device *phydev)
 	return et1011c_parse_status(phydev);
 }
=20
-static struct phy_driver et1011c_driver =3D {
+U_BOOT_PHY_DRIVER(et1011c) =3D {
 	.name		=3D "ET1011C",
 	.uid		=3D 0x0282f014,
 	.mask		=3D 0xfffffff0,
@@ -95,10 +95,3 @@ static struct phy_driver et1011c_driver =3D {
 	.config		=3D &et1011c_config,
 	.startup	=3D &et1011c_startup,
 };
-
-int phy_et1011c_init(void)
-{
-	phy_register(&et1011c_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 7312719cdbb..5b6e6294377 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_ET1011C
-	phy_et1011c_init();
-#endif
 #ifdef CONFIG_PHY_LXT
 	phy_lxt_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 9e5a9196cbd..3bc4a0de724 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_et1011c_init(void);
 int phy_lxt_init(void);
 int phy_marvell_init(void);
 int phy_micrel_ksz8xxx_init(void);
--=20
2.39.2

