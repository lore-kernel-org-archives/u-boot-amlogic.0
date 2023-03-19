Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web10.21383.1679245502429900848
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJNnQv9/9o+pIuM1g0OhgGd6L0LomFxhM58TzInaCSQ=;
	b=NFHNoF841ajEonGFcclydWKbyeA6pcnai8nmZMjoevwtlG1Rmt9IW5HakH/qV7zvnLL3Ir
	bB+Rze8+PnnFe2XTocYF1+u4J2diw4V/HnN0U5ZO5G6ASF9ePeoo/wOl5H9Gp838Cqp6bw
	Kqp/fUW8Mbg9w2bWiDBhreKSQdLnA60kjtDfYjZKohz6rohFWN7BA73dYGhGnBLzT1RfvM
	G6mdSHW1cyZgSLMJ7RLyMt4o5Bz50DCCqDYxud/g4zkCNKVL/y0WfBaE70FEscSjxzwe2n
	l9o9b20qMSlYNtSydL9UjY5PCE+bZS7imFj5+/peGO1uMJjFPq79gUuPxnoXdw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJNnQv9/9o+pIuM1g0OhgGd6L0LomFxhM58TzInaCSQ=;
	b=n0EL2p2HABeGGSG1hjM/hLLO7NrRyEMUMKh09mbwnxyuEoOWMmF7nd33rWEUTlxCQXrQ5P
	LLQuV7UpfUlmeZxQvBiJrNz5eH5XXtRVJ6fYR8gZsqnMA5nqzddru3f6rcefhOp/sHE152
	ucTSge5QmnozAXsg0q1Wej3GZVbMUFSuTlYN3jeef972tMi1Rj5OvfaQT+c2s10jNDg4nX
	2SRVZNtKLFlGVIla54O0J4L2SL2nddI9zXNC5WUCin2BfI80PdIiHKGlGNQQJk06p2GvKn
	kiTM00492qrBfhjf8TzmbvKuk9uD69+f/xw9NyzAmpmlbahT9m+92OcdA8JlaA==
Subject: [PATCH 21/41] net: phy: meson-gxl: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:57 +0100
Message-Id: <20230319170317.27711-21-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/meson-gxl.c | 9 +--------
 drivers/net/phy/phy.c       | 3 ---
 include/phy.h               | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 753ca727686..b49c9b5f495 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -124,7 +124,7 @@ static int meson_gxl_phy_config(struct phy_device *phyd=
ev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver meson_gxl_phy_driver =3D {
+U_BOOT_PHY_DRIVER(meson_gxl_phy) =3D {
 	.name =3D "Meson GXL Internal PHY",
 	.uid =3D 0x01814400,
 	.mask =3D 0xfffffff0,
@@ -133,10 +133,3 @@ static struct phy_driver meson_gxl_phy_driver =3D {
 	.startup =3D &meson_gxl_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_meson_gxl_init(void)
-{
-	phy_register(&meson_gxl_phy_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4747011cda2..27cc9f5ec60 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_MESON_GXL
-	phy_meson_gxl_init();
-#endif
 #ifdef CONFIG_PHY_NATSEMI
 	phy_natsemi_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 570524a21f5..f69f379fc2b 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_meson_gxl_init(void);
 int phy_natsemi_init(void);
 int phy_nxp_c45_tja11xx_init(void);
 int phy_nxp_tja11xx_init(void);
--=20
2.39.2

