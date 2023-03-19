Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21393.1679245528399148409
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cllsqzs/Ce/9i+PClbAexmxdRyz4xXWwr2LbanZBXFk=;
	b=uoplPU5aPdMlsudHEAOptKTp7ygkCVbNPqu4cKWWO7LsKwiIYikQzpPlpZf/1Jo/Vx5Cil
	iAW9uC71MoR3+me2nms76n6TcNgpUZ+J9VIA59QrHW/ENcC87Lf4NoylbYsb+2J+iUWzYi
	xXISZl2YNa4gf68zUvnAitD6fEToHHpcJ6h6np4Dwvv2esnlRyBumyR8lY/b4m13XB6LhU
	ec8098tgp6+kAl9/KfknXyV2Qm9CzLroWz9oQtVvolUImXd+TB3zmZPNmv1opWm9NHi4bC
	GxE3RGB6AG0Y3YgxJkX5FxsKFb/DmNva3Z9mJm51ttrYcWGKfBlCoHvbjToPrw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cllsqzs/Ce/9i+PClbAexmxdRyz4xXWwr2LbanZBXFk=;
	b=yWAspM92NR7z6LbpuCYhkcWeuTkzPZMhznW2ruYHjyYqIHe9MmiXrwUGmBQ27UUBHhc6du
	KRCozbjUKTY1XNMuDJqk157skigVemF6DvzR8SvfookxsUSnjE2mjLAXxDiPULW++s/DhQ
	8ggy5vSlQyDkM0J0CFCBp2QIK2dAdKwLi7XhZEngtOV2vVkpg6dBzoDzlOvbqAK/kSfc6z
	HR8sKy3w7vjHrWmN0dzeVkW+IwKpH6P5wXudBVaY94wjmaDKTAPQLn6RkInWFO/pGw172K
	QMtUTc0MMKqCPgzUUfRtMz0HfW7WTLQMBGobx2UCl8ys6gY171ttqT/PO1eXtw==
Subject: [PATCH 30/41] net: phy: xilinx: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:06 +0100
Message-Id: <20230319170317.27711-30-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c        |  3 ---
 drivers/net/phy/xilinx_phy.c | 10 +---------
 include/phy.h                |  1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fff1d669fcd..b85d5c4566d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_XILINX
-	phy_xilinx_init();
-#endif
 #ifdef CONFIG_PHY_XWAY
 	phy_xway_init();
 #endif
diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
index 39dbfdb7da8..1df639d6f44 100644
--- a/drivers/net/phy/xilinx_phy.c
+++ b/drivers/net/phy/xilinx_phy.c
@@ -127,7 +127,7 @@ static int xilinxphy_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver xilinxphy_driver =3D {
+U_BOOT_PHY_DRIVER(xilinxphy) =3D {
 	.uid =3D XILINX_PHY_ID,
 	.mask =3D XILINX_PHY_ID_MASK,
 	.name =3D "Xilinx PCS/PMA PHY",
@@ -136,11 +136,3 @@ static struct phy_driver xilinxphy_driver =3D {
 	.startup =3D &xilinxphy_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_xilinx_init(void)
-{
-	debug("%s\n", __func__);
-	phy_register(&xilinxphy_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index 74f3ada2491..e128ddf0037 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_xilinx_init(void);
 int phy_xway_init(void);
 int phy_mscc_init(void);
 int phy_fixed_init(void);
--=20
2.39.2

