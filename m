Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21060.1679245464740294977
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKZ4z8w0M3CFeezqiDNtGYKv5JQPNk+kXwn75uIVbYs=;
	b=VWpfUqGYK55mSViY1TAgmkOL1p7gBLUDUXiznxtT1Ho1N+ETWb6Us1h4I6g1LtD2s/5U2J
	rIOAORtdpC/J5KVAz8+ygpIBxodJZcPy/qr6hEfAEHgEyAd4LKBvYQ+kRMFif07YE4lVSW
	cGlbqiyTHUQASsFQNqGelGIr/bphy7HlI/hfO1y3KOg+RMd7eQnOeMlvYLhbXGIQXzXvNg
	fkAB5uhLbf3mW70mXX91KEk+ULwFWamsuskVGERwZrwiSFjWFS6OE8luvc+rUHS9GzlAD1
	7wFLOOV4tne7DUlzpGbrG/qe0GiN1WafoWQC7aXJdt0iLyk/KrlhX/0N6h+TFw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKZ4z8w0M3CFeezqiDNtGYKv5JQPNk+kXwn75uIVbYs=;
	b=xjDvHKfq4xWOisQQQymbm/dfqUQe+WoJFERNiAGNemIluIH/WsN54cgtVCBfeK3hK9VJQU
	dUChVZcx9TSll8GwpeT2eyQnuse+HVfdBHDQ4tvND8HVJbFhzHrhqGz3xDUonUlWXkHRFp
	LkSLVWtoaRSWuqLYGqzt1RQUHaXU8k47pqga3DYybA1xv5GaDSiEg0bMnVL4fBxsSkAtwW
	3QjPEiGmqMD2JL5n3kZQ45DpCJgCA34d9HQnzPlSKJi94on75rHljUNgR7WRqpkjzZsyd2
	bNkurRygp3YaycUZHrqypldGwQTVq3eWSEOCUsalWMsR35s4qxRoeyD1kFBKRg==
Subject: [PATCH 07/41] net: phy: adin: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:43 +0100
Message-Id: <20230319170317.27711-7-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/adin.c | 9 +--------
 drivers/net/phy/phy.c  | 3 ---
 include/phy.h          | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index a5bfd960d9c..fb9f1e4c70d 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -252,7 +252,7 @@ static int adin1300_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
=20
-static struct phy_driver ADIN1300_driver =3D  {
+U_BOOT_PHY_DRIVER(ADIN1300) =3D {
 	.name =3D "ADIN1300",
 	.uid =3D PHY_ID_ADIN1300,
 	.mask =3D 0xffffffff,
@@ -261,10 +261,3 @@ static struct phy_driver ADIN1300_driver =3D  {
 	.startup =3D genphy_startup,
 	.shutdown =3D genphy_shutdown,
 };
-
-int phy_adin_init(void)
-{
-	phy_register(&ADIN1300_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 50bfabbb765..ecb4b72ed10 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -520,9 +520,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_ADIN
-	phy_adin_init();
-#endif
 #ifdef CONFIG_PHY_AQUANTIA
 	phy_aquantia_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 1eccfacec68..dbc0da7e084 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -317,7 +317,6 @@ int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_b53_init(void);
 int phy_mv88e61xx_init(void);
-int phy_adin_init(void);
 int phy_aquantia_init(void);
 int phy_atheros_init(void);
 int phy_broadcom_init(void);
--=20
2.39.2

