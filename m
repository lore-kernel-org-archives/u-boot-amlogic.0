Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web11.21110.1679245547682999831
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE9FNZtK7usLaV+fTcW0VuU7FKFr9OnKgiIC6WJO07c=;
	b=uYhFQ8h1DpjbRZCabWgT/vPfvtPl6fRDYUQl0WyuKPAgPup/BHhPONrM6odVVJewdJdyNq
	l1Gqy6n3Ev3FKsxnV5T2R5lrllVMD3NrDW3Iu/jmdbyiEekIgWl8HNY21q0e+Mnt7pdo0S
	8ZFDq90PGPYMuQcL9ji9Bkb8PuIeMgbShwf6LMZRiBaCs78kxsM3avmaC/6AstKds5jwuc
	mrh8WNSeeMKnUl2ir7LPWFcDmoa8DbPhzJzKr3pQzsiZMwva0MMx0MSAE0kd9X2xSgTeGu
	ZCT24X3JY102Msnkl0HXn5ImmvL+xGU4YZTH+DIYknpsI+5mu9lDbPVAIoIhUQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE9FNZtK7usLaV+fTcW0VuU7FKFr9OnKgiIC6WJO07c=;
	b=dbCNpNxD8IYZVZ/7ai+SL33linoP7TcUrOhsaQ+Py9rqfXKjfFk2ruiKkIYAlqfpFiwSLL
	D0KXKuf4VeLXrQvo/OubrGaPh1vVtaub8sFFf8x6LesqwWJDgpbtHNCGM0aYPQHHsxkpmk
	rdpdfcaEVL3DEGd2LE8hCbPGdfpNyY0+Mqt/MLlhlHbS5HuPcmVTqqX0eDp0wa0njPK/nr
	IC/M+Pm83U5jXcykZJbcpw6W0VVqW43397VXtLrbM1HFqpRYGECVjjuoVwhjyZsKzr+eaz
	h8ku6hBqZ2T3rx1pujQ+If3kgUnzjQQyqb6+U4wazJhD5Fn9ByVm3faGoMJtPA==
Subject: [PATCH 37/41] net: phy: gen10g: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:13 +0100
Message-Id: <20230319170317.27711-37-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/generic_10g.c | 2 +-
 drivers/net/phy/phy.c         | 2 +-
 include/phy.h                 | 4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/generic_10g.c b/drivers/net/phy/generic_10g.c
index b4384e1f781..34ac51ea070 100644
--- a/drivers/net/phy/generic_10g.c
+++ b/drivers/net/phy/generic_10g.c
@@ -80,7 +80,7 @@ int gen10g_config(struct phy_device *phydev)
 	return gen10g_discover_mmds(phydev);
 }
=20
-struct phy_driver gen10g_driver =3D {
+U_BOOT_PHY_DRIVER(gen10g) =3D {
 	.uid		=3D 0xffffffff,
 	.mask		=3D 0xffffffff,
 	.name		=3D "Generic 10G PHY",
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b1e9861c6f3..bd9c576f459 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -566,7 +566,7 @@ static struct phy_driver *generic_for_phy(struct phy_de=
vice *phydev)
 {
 #ifdef CONFIG_PHYLIB_10G
 	if (phydev->is_c45)
-		return &gen10g_driver;
+		return ll_entry_get(struct phy_driver, gen10g, phy_driver);
 #endif
=20
 	return ll_entry_get(struct phy_driver, genphy, phy_driver);
diff --git a/include/phy.h b/include/phy.h
index df2586f89ea..5f4967cb150 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -173,10 +173,6 @@ struct fixed_link {
 	int asym_pause;
 };
=20
-#ifdef CONFIG_PHYLIB_10G
-extern struct phy_driver gen10g_driver;
-#endif
-
 /**
  * phy_init() - Initializes the PHY drivers
  * This function registers all available PHY drivers
--=20
2.39.2

