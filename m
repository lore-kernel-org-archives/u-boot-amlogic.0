Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21071.1679245480947827757
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8qmhM1Mqbd5uo56l0UeXUrwCEcEZCLDHE0ApoO03cM=;
	b=FDjkrQ7bcpZrdma/kMGuiOAHzeYa07HOxQQUUpmsh3hNsXCdLfm/3VI5zPyk+a66fPWK8f
	+vtNYX+S9T2gtbWYzO+qpa3qELMQDzeLM8aRrONEgF5fD32gMC3ojrRcSsk/6pZdFGuZ3o
	1K2RrqoiXEnslPW7SZE7kuetwe4QvqbFIzfs+9KE21lsrpVQcE8FGgU5pYsLm04F4+nYcC
	N4dRgchWeNXWxJQKLzvuHYMwkAOCHObL3hSNFnElKl1AU0e1LiNAyDfD9rvQLYmmKgq3on
	od9tSfsTyT/TZMe3wYD3c4e3NQk3zc9BLormsOUeArNerL1cx4bDqv/IPJsKJQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8qmhM1Mqbd5uo56l0UeXUrwCEcEZCLDHE0ApoO03cM=;
	b=MQ8g23NA3QWF2boViL7kDVOE75EDvCOXh4HfikH1VuHHrp+KUSJAf/ah7tQtXkjP6rJFKP
	IRGuvNky/PFAFur4AnAJ0NKmzXkjl+Z8hcWN2pKuyik3WZhCKcJlewklsVdpXwg52WtBYB
	/TdqqWppMGnnahITeKpsfeAj+igPN+ygQRFyg5UrseyFBdLw23Ui6wnHulLgrJvKk6mQIO
	9ET1uYVajHozCsO1K2HNFS6HW1rSKteDvJTlnKBm8daDpeSwoRExY2/H7OJ1TI400Zy6fE
	hE0z6KS/1rt2OW7N1dbb9AbOGbiCFyf0QLcj1ACWs9DT3NIFbJTK5SVv/qtYHQ==
Subject: [PATCH 13/41] net: phy: cortina: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:49 +0100
Message-Id: <20230319170317.27711-13-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/cortina.c | 11 ++---------
 drivers/net/phy/phy.c     |  3 ---
 include/phy.h             |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index df5a73d6112..1cf8b28f582 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -382,7 +382,7 @@ int cs4223_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver cs4340_driver =3D {
+U_BOOT_PHY_DRIVER(cs4340) =3D {
 	.name =3D "Cortina CS4315/CS4340",
 	.uid =3D PHY_UID_CS4340,
 	.mask =3D 0xfffffff0,
@@ -396,7 +396,7 @@ static struct phy_driver cs4340_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-static struct phy_driver cs4223_driver =3D {
+U_BOOT_PHY_DRIVER(cs4223) =3D {
 	.name =3D "Cortina CS4223",
 	.uid =3D PHY_UID_CS4223,
 	.mask =3D 0x0ffff00f,
@@ -409,13 +409,6 @@ static struct phy_driver cs4223_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-int phy_cortina_init(void)
-{
-	phy_register(&cs4340_driver);
-	phy_register(&cs4223_driver);
-	return 0;
-}
-
 int get_phy_id(struct mii_dev *bus, int addr, int devad, u32 *phy_id)
 {
 	int phy_reg;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4446902ab63..d595290dd4b 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -517,9 +517,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_CORTINA
-	phy_cortina_init();
-#endif
 #ifdef CONFIG_PHY_DAVICOM
 	phy_davicom_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 50a53982810..797139bf681 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -316,7 +316,6 @@ int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_mv88e61xx_init(void);
-int phy_cortina_init(void);
 int phy_davicom_init(void);
 int phy_et1011c_init(void);
 int phy_lxt_init(void);
--=20
2.39.2

