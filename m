Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21378.1679245486334989571
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBgTpaVdCzE0r853JuaNtyo/kjvIigGzmOEpCCtqpxk=;
	b=uPboXUTTY2VVqGVjMDunxdhlKcsXeDLjifUx/fyc8rSe/Uc++QAhChxK/hkm4H3RFMMUMg
	2cwdv9Oyj2sNcGYbreoiugKBDECFmH0419kP8NjbTUpgIJbpZ3NudXIhEJS/AOYgGLwg35
	tEkjoeiLecV78VOeuUvYSOroRaSIFZc3Km4nq6hmUjYtWhH/X739vCjOwEIOXgYkrmEDQJ
	8jlJ+H+XOS5K6OO7yFpK9uwb+DoxQeHwJN6dB7JgNQmQ6WpLo7mE/Mk59LbNwgsCag+OU3
	hjkG8jxEeevGNSuBfvBvaoGoJtg3RSNfRjurCbMGGUlvBzS9z7DizUrpd4j/sg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBgTpaVdCzE0r853JuaNtyo/kjvIigGzmOEpCCtqpxk=;
	b=XYK9BeB4TXSwaZsSJ7VVT+RdsMlfTNp2xM777YUcCtdFW1y0vEzoMMYsByE+3s+F2HFnu2
	DFhyaREZGtGcOo/SVtY3ebME3MpygX+9/iZiKeYNbtJLo6W7MgUK6vIhrqTevVt8MLe0oT
	D/RtbqUmVAM7ct6zNMxePJM0AFSe8pyWSmRCU4OR97uDidN9uz0F9tX+sl+HmEoxLIKQco
	REqPVzMSy5u4zL6k7WfFd06mIfpcM0OuMsdiqdDb2lE8cjiv0YxwlJL1Uk+9DFFOyY1J6n
	jbf8tnqgviFWs2D+onIYy53CAqU8473wSSPs5JlZOhZKAvGd1AxNCIeWyl2vaw==
Subject: [PATCH 15/41] net: phy: mv88e61xx: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:51 +0100
Message-Id: <20230319170317.27711-15-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/mv88e61xx.c | 15 +++------------
 drivers/net/phy/phy.c       |  3 ---
 include/phy.h               |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/mv88e61xx.c b/drivers/net/phy/mv88e61xx.c
index 7ab60164c77..85778106edd 100644
--- a/drivers/net/phy/mv88e61xx.c
+++ b/drivers/net/phy/mv88e61xx.c
@@ -1127,7 +1127,7 @@ static int mv88e61xx_phy_startup(struct phy_device *p=
hydev)
 	return 0;
 }
=20
-static struct phy_driver mv88e61xx_driver =3D {
+U_BOOT_PHY_DRIVER(mv88e61xx) =3D {
 	.name =3D "Marvell MV88E61xx",
 	.uid =3D 0x01410eb1,
 	.mask =3D 0xfffffff0,
@@ -1138,7 +1138,7 @@ static struct phy_driver mv88e61xx_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver mv88e609x_driver =3D {
+U_BOOT_PHY_DRIVER(mv88e609x) =3D {
 	.name =3D "Marvell MV88E609x",
 	.uid =3D 0x1410c89,
 	.mask =3D 0xfffffff0,
@@ -1149,7 +1149,7 @@ static struct phy_driver mv88e609x_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver mv88e6071_driver =3D {
+U_BOOT_PHY_DRIVER(mv88e6071) =3D {
 	.name =3D "Marvell MV88E6071",
 	.uid =3D 0x1410db0,
 	.mask =3D 0xfffffff0,
@@ -1160,15 +1160,6 @@ static struct phy_driver mv88e6071_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-int phy_mv88e61xx_init(void)
-{
-	phy_register(&mv88e61xx_driver);
-	phy_register(&mv88e609x_driver);
-	phy_register(&mv88e6071_driver);
-
-	return 0;
-}
-
 /*
  * Overload weak get_phy_id definition since we need non-standard function=
s
  * to read PHY registers
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 6d7e07c25a5..7312719cdbb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_MV88E61XX_SWITCH
-	phy_mv88e61xx_init();
-#endif
 #ifdef CONFIG_PHY_ET1011C
 	phy_et1011c_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 51c2ddb7e4e..9e5a9196cbd 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_mv88e61xx_init(void);
 int phy_et1011c_init(void);
 int phy_lxt_init(void);
 int phy_marvell_init(void);
--=20
2.39.2

