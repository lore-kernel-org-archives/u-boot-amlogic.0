Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21051.1679245436564602079
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:03:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SuonYyfAY4GZEOcdaPce5x9MNW6PzZk+i0dS8xqAOeM=;
	b=Czm5PCmAOs0DuRmBWzjyGq2TPpHIrJUhhbfH4v8O0xKc5V2Coyz2wGPv6IuJ4HVBbb8IeS
	lPiIgheI+CQ8izkE5+v6KMKSgtfBBne80ZM35zcQLNC0k9j2DDi8NqrRgz30hqrXKshvBX
	pGpubyJEqakEGXdnzK9tfPr0tW9QShM1kEyCfyR0Ts/dVyYTbFiTT71I3DAXZAIR7zm8+B
	Jmw2es4bEOmkUp27xrX5uHG4KuygB6ISXoWxCyq465CujjXqzyPUtwZyoYwMAgGb5r6t9V
	EqrUgpMMEtvwjqsog8DT6yCapfnTkdp+LQdTxaGlkUZeS5P1ZQp56tWHp1FJ+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SuonYyfAY4GZEOcdaPce5x9MNW6PzZk+i0dS8xqAOeM=;
	b=nove2OYHVPPcW2llkpAwTTrDEiVZHVULEe0+IPTLJdaMZ0bMYhYIgaG7jI8iAsNvv0vISG
	U1MJVwsnLdi7kSPYhFsvBAYLFd1Qdm+qKUN7oF2TYW4MGs+UB62KcoKLf5IlKxSHBheXlX
	Nmm5DXMursbnFbzWHaAzAJijfiBAlOsbEiv61Yb75fihdjbjQIvrmM+GAsOILydLSeg2hQ
	8lgs6jSP7IyXnitB5Bql1Rp7DM9NSSiETnVQwmLY/zfxUALqu49t7eKklD7CgtT17ZKJmw
	hhCte4QXkC3/EjEusM31JCGZjMScYdphAPVadYb9+T0uVufpManTmT8s5+OGBQ==
Subject: [PATCH 01/41] net: phy: aquantia: Staticize PHY driver entries
Date: Sun, 19 Mar 2023 18:02:37 +0100
Message-Id: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

These struct phy_driver ... instances are local to this source code
file, staticize them. No functional change.

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
 drivers/net/phy/aquantia.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 8eb6024829d..fa887ade0c2 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -598,7 +598,7 @@ int aquantia_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-struct phy_driver aq1202_driver =3D {
+static struct phy_driver aq1202_driver =3D {
 	.name =3D "Aquantia AQ1202",
 	.uid =3D 0x3a1b445,
 	.mask =3D 0xfffffff0,
@@ -611,7 +611,7 @@ struct phy_driver aq1202_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-struct phy_driver aq2104_driver =3D {
+static struct phy_driver aq2104_driver =3D {
 	.name =3D "Aquantia AQ2104",
 	.uid =3D 0x3a1b460,
 	.mask =3D 0xfffffff0,
@@ -624,7 +624,7 @@ struct phy_driver aq2104_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-struct phy_driver aqr105_driver =3D {
+static struct phy_driver aqr105_driver =3D {
 	.name =3D "Aquantia AQR105",
 	.uid =3D 0x3a1b4a2,
 	.mask =3D 0xfffffff0,
@@ -638,7 +638,7 @@ struct phy_driver aqr105_driver =3D {
 	.data =3D AQUANTIA_GEN1,
 };
=20
-struct phy_driver aqr106_driver =3D {
+static struct phy_driver aqr106_driver =3D {
 	.name =3D "Aquantia AQR106",
 	.uid =3D 0x3a1b4d0,
 	.mask =3D 0xfffffff0,
@@ -651,7 +651,7 @@ struct phy_driver aqr106_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-struct phy_driver aqr107_driver =3D {
+static struct phy_driver aqr107_driver =3D {
 	.name =3D "Aquantia AQR107",
 	.uid =3D 0x3a1b4e0,
 	.mask =3D 0xfffffff0,
@@ -665,7 +665,7 @@ struct phy_driver aqr107_driver =3D {
 	.data =3D AQUANTIA_GEN2,
 };
=20
-struct phy_driver aqr112_driver =3D {
+static struct phy_driver aqr112_driver =3D {
 	.name =3D "Aquantia AQR112",
 	.uid =3D 0x3a1b660,
 	.mask =3D 0xfffffff0,
@@ -679,7 +679,7 @@ struct phy_driver aqr112_driver =3D {
 	.data =3D AQUANTIA_GEN3,
 };
=20
-struct phy_driver aqr113c_driver =3D {
+static struct phy_driver aqr113c_driver =3D {
 	.name =3D "Aquantia AQR113C",
 	.uid =3D 0x31c31c12,
 	.mask =3D 0xfffffff0,
@@ -693,7 +693,7 @@ struct phy_driver aqr113c_driver =3D {
 	.data =3D AQUANTIA_GEN3,
 };
=20
-struct phy_driver aqr405_driver =3D {
+static struct phy_driver aqr405_driver =3D {
 	.name =3D "Aquantia AQR405",
 	.uid =3D 0x3a1b4b2,
 	.mask =3D 0xfffffff0,
@@ -707,7 +707,7 @@ struct phy_driver aqr405_driver =3D {
 	.data =3D AQUANTIA_GEN1,
 };
=20
-struct phy_driver aqr412_driver =3D {
+static struct phy_driver aqr412_driver =3D {
 	.name =3D "Aquantia AQR412",
 	.uid =3D 0x3a1b710,
 	.mask =3D 0xfffffff0,
--=20
2.39.2

