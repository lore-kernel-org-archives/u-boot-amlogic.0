Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21369.1679245467610680438
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBkryMdHGNFQ6VmhR8M4BS263iHU/gpC4MFGpMkxyLs=;
	b=ixLWfNq6OlA+KlpQ/2SnPUmoL9DuiqGP6OhKXvF78r3nNIraSQozcsnyDyHU67gdCiZD27
	SJcYSBF/hCSYJuJVCLmzfY+zVbLg8JQRilRpEnjQlVqZuO07dpQmgFDHHz3y888STHKmun
	f4ODJdItxiNKxvWZjnx6tMPXKwdD0sZsh63lhpfYM4fqp+O8ehHSgtMUV1Tt6fKgv1QCEl
	4B0VVEGH7BC5R3DyfiuGqAw/8vZnuKXdg7f7rY16cTp4i+GTqXgE+2uYcd74mShzOwjy6L
	45ENBnBXB1c8sJCWKKdAwtalGDafSh4FFiqiHBtOpT/mBHomUoPHt8kkP2dYjg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBkryMdHGNFQ6VmhR8M4BS263iHU/gpC4MFGpMkxyLs=;
	b=in4MwosSV2DiqYKD0KweNN9Dip87ick1jGD7EtDTTYUH4htflnIBUJYch/nHCRwrDhqGGs
	XTCfutboJlWTIdqSNhYeSIqAUDIUlh4TmRsANbd8oKkt/XXaWHSSH58AVeXYua7nC03IKs
	GgQN42vuE8r+EVQz0OZPF8wfAIA4hv1/NV67WtqPRgoexDX+lhwkLwFsws+WtPWq/ZfgHE
	CS5m4fELGo162U0ndhi9xkLaO+Y5sSkrIj1Fdpxgly985szmRSPePrTbwaUI7uXubptKSG
	3iwsu8HQWmNWwYiZ9K5gMFfJohHhvX/ZwKB5PPZxPIvh4feOZTnkIvGWKj4t1g==
Subject: [PATCH 08/41] net: phy: aquantia: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:44 +0100
Message-Id: <20230319170317.27711-8-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/aquantia.c | 33 +++++++++------------------------
 drivers/net/phy/phy.c      |  3 ---
 include/phy.h              |  1 -
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index fa887ade0c2..a958e88d44f 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -598,7 +598,7 @@ int aquantia_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver aq1202_driver =3D {
+U_BOOT_PHY_DRIVER(aq1202) =3D {
 	.name =3D "Aquantia AQ1202",
 	.uid =3D 0x3a1b445,
 	.mask =3D 0xfffffff0,
@@ -611,7 +611,7 @@ static struct phy_driver aq1202_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-static struct phy_driver aq2104_driver =3D {
+U_BOOT_PHY_DRIVER(aq2104) =3D {
 	.name =3D "Aquantia AQ2104",
 	.uid =3D 0x3a1b460,
 	.mask =3D 0xfffffff0,
@@ -624,7 +624,7 @@ static struct phy_driver aq2104_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-static struct phy_driver aqr105_driver =3D {
+U_BOOT_PHY_DRIVER(aqr105) =3D {
 	.name =3D "Aquantia AQR105",
 	.uid =3D 0x3a1b4a2,
 	.mask =3D 0xfffffff0,
@@ -638,7 +638,7 @@ static struct phy_driver aqr105_driver =3D {
 	.data =3D AQUANTIA_GEN1,
 };
=20
-static struct phy_driver aqr106_driver =3D {
+U_BOOT_PHY_DRIVER(aqr106) =3D {
 	.name =3D "Aquantia AQR106",
 	.uid =3D 0x3a1b4d0,
 	.mask =3D 0xfffffff0,
@@ -651,7 +651,7 @@ static struct phy_driver aqr106_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-static struct phy_driver aqr107_driver =3D {
+U_BOOT_PHY_DRIVER(aqr107) =3D {
 	.name =3D "Aquantia AQR107",
 	.uid =3D 0x3a1b4e0,
 	.mask =3D 0xfffffff0,
@@ -665,7 +665,7 @@ static struct phy_driver aqr107_driver =3D {
 	.data =3D AQUANTIA_GEN2,
 };
=20
-static struct phy_driver aqr112_driver =3D {
+U_BOOT_PHY_DRIVER(aqr112) =3D {
 	.name =3D "Aquantia AQR112",
 	.uid =3D 0x3a1b660,
 	.mask =3D 0xfffffff0,
@@ -679,7 +679,7 @@ static struct phy_driver aqr112_driver =3D {
 	.data =3D AQUANTIA_GEN3,
 };
=20
-static struct phy_driver aqr113c_driver =3D {
+U_BOOT_PHY_DRIVER(aqr113c) =3D {
 	.name =3D "Aquantia AQR113C",
 	.uid =3D 0x31c31c12,
 	.mask =3D 0xfffffff0,
@@ -693,7 +693,7 @@ static struct phy_driver aqr113c_driver =3D {
 	.data =3D AQUANTIA_GEN3,
 };
=20
-static struct phy_driver aqr405_driver =3D {
+U_BOOT_PHY_DRIVER(aqr405) =3D {
 	.name =3D "Aquantia AQR405",
 	.uid =3D 0x3a1b4b2,
 	.mask =3D 0xfffffff0,
@@ -707,7 +707,7 @@ static struct phy_driver aqr405_driver =3D {
 	.data =3D AQUANTIA_GEN1,
 };
=20
-static struct phy_driver aqr412_driver =3D {
+U_BOOT_PHY_DRIVER(aqr412) =3D {
 	.name =3D "Aquantia AQR412",
 	.uid =3D 0x3a1b710,
 	.mask =3D 0xfffffff0,
@@ -720,18 +720,3 @@ static struct phy_driver aqr412_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 	.data =3D AQUANTIA_GEN3,
 };
-
-int phy_aquantia_init(void)
-{
-	phy_register(&aq1202_driver);
-	phy_register(&aq2104_driver);
-	phy_register(&aqr105_driver);
-	phy_register(&aqr106_driver);
-	phy_register(&aqr107_driver);
-	phy_register(&aqr112_driver);
-	phy_register(&aqr113c_driver);
-	phy_register(&aqr405_driver);
-	phy_register(&aqr412_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index ecb4b72ed10..4f17f98876e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -520,9 +520,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_AQUANTIA
-	phy_aquantia_init();
-#endif
 #ifdef CONFIG_PHY_ATHEROS
 	phy_atheros_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index dbc0da7e084..a0060cd19ea 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -317,7 +317,6 @@ int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_b53_init(void);
 int phy_mv88e61xx_init(void);
-int phy_aquantia_init(void);
 int phy_atheros_init(void);
 int phy_broadcom_init(void);
 int phy_cortina_init(void);
--=20
2.39.2

