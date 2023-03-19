Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web10.21394.1679245531062822364
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwJrJ3mgCaImkU+ySO5MXFcA373VIYq4kPju7roJP4w=;
	b=PZNmminKBOsy360d7LnEG4yD3JbiKWhyjDnA0kgTz7cu1sTOt+idlpgBsj2NwDU+sspoo3
	HAi2WYI1J+35HfWFyp6O78Qp54bSAPd85wkNZatdKwhOoX6sCEAJZEhtDBoKAdE97Yds0v
	HletCxTT2DUt0lqgWtz86AJRZR1iVC4VpOBTfs/vyIbwajqnyCXW70c5LF9+qj+/PfkrZk
	q9irpPfJLLP6btGDeMNnfaz8zG21S3ZuHvBlc7pCc/Ll3UIgUgtsp8Vl8vKhPxcZkKOHsv
	2ijV9yfpaTE+ETJ4Y+I5lGBtmsU0b8eciEFNjhKyQl/tkwk7iBNfs9MIjU0d+A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwJrJ3mgCaImkU+ySO5MXFcA373VIYq4kPju7roJP4w=;
	b=rhieVqZDscI16P+14rGql6QqJLyMpIawmWEq00RVfF6exKtgAjh90EciYUWksTsvpSC1r1
	8TkRvlW0sAUt0EpkMLOvX8KBXgcqQ0RVATMobqv3H9OSixDXZyL687Iio1d0nKxBjzr83u
	zk0fSnwu/iXVrCqR7Phh7dthq79j/+Ir0/qfGBfRZV3Y3WZQFsfoDd3ne6hXiPCHGN/leL
	j8pSu/l3gwEWIz+4UfMNbzYNMgm/lzgtQihG5EkdBJY8be381KWCjYHXjLHZO7xA6wqUGK
	kUw4DDrSuF0Z9FdC8/MVYHcNm5z3Rk+Z0WP+62TAQ+bOxe6mUh4arQodCvKX0w==
Subject: [PATCH 31/41] net: phy: intel-xway: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:07 +0100
Message-Id: <20230319170317.27711-31-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/intel_xway.c | 9 +--------
 drivers/net/phy/phy.c        | 3 ---
 include/phy.h                | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/intel_xway.c b/drivers/net/phy/intel_xway.c
index dfce3f8332e..9d1b97d349f 100644
--- a/drivers/net/phy/intel_xway.c
+++ b/drivers/net/phy/intel_xway.c
@@ -30,7 +30,7 @@ static int xway_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver XWAY_driver =3D {
+U_BOOT_PHY_DRIVER(xway) =3D {
 	.name =3D "XWAY",
 	.uid =3D 0xD565A400,
 	.mask =3D 0xffffff00,
@@ -39,10 +39,3 @@ static struct phy_driver XWAY_driver =3D {
 	.startup =3D genphy_startup,
 	.shutdown =3D genphy_shutdown,
 };
-
-int phy_xway_init(void)
-{
-	phy_register(&XWAY_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b85d5c4566d..1542fe89252 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_XWAY
-	phy_xway_init();
-#endif
 #ifdef CONFIG_PHY_MSCC
 	phy_mscc_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index e128ddf0037..fc8300d5d97 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_xway_init(void);
 int phy_mscc_init(void);
 int phy_fixed_init(void);
 int phy_ncsi_init(void);
--=20
2.39.2

