Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web11.21091.1679245505262281172
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6QK1HM6IwkRKQq4HaTeV91A9H/3KpmCX9BvW/WaJ8E=;
	b=qlQqCPuZcrrLUahYqcVkAvn8u5hQLGTMJxOfJW6upWfTLRo46KNOgKeDefUYHPMv75CbWc
	UBAp9UXQtXz7Efs+3f9tY+moX1pjSW2/8cML4L4s6r85ThFLsPg98IC0PgGyBi7YXzVyvw
	v5S/nkeYcsXnlWgpHpwiBF3DyWb+qrJ3pz4T0s2USw6+zuJ4I+HYp0nW8UzYlYm4Q/7bj1
	4XqhGQEOugNvraGY21qsyyimzZ+nushaU5s2+3HD26gCveMi8EfUhaxTGTBEt0I700dT8U
	xlH1OwszfV/IckYFcX4+pY/t1qK2kHfzLw6tn0pmcFATHgSdk1L1RPfGB4nvqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6QK1HM6IwkRKQq4HaTeV91A9H/3KpmCX9BvW/WaJ8E=;
	b=ZW7qydQ8A4+pS+2qYigHgGhNDh6WsJRbzYeW1YK39k+cZLW03FXjUfy569o8laPui/33F1
	gtBaWhY0R9kcQl8hVQZXbAhrv02CzR+FQz6JuJ6oZDLX+kIS3b0f665aZxRxWwPs4229Xf
	835qnHdGxHGzveNlTthpBcyz0mbcAocAK6XD7Mt19JoZ09UlR3SVaQQLF8fhBrFgmDMtZs
	GLV05FLmBAM4eUh8p/1mbqNOKGF64lW8EH6epDvcm1VGTubkk4ZLAx7Gu2G8NKen9dDo+d
	JBL4IW6GF7lJ4z/u3UlUvoGRPjaYsbl6hl2oC+rYx7pWmA37kych7hDbGv6STQ==
Subject: [PATCH 22/41] net: phy: natsemi: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:58 +0100
Message-Id: <20230319170317.27711-22-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/natsemi.c | 15 +++------------
 drivers/net/phy/phy.c     |  3 ---
 include/phy.h             |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/natsemi.c b/drivers/net/phy/natsemi.c
index efde4574deb..6b9e99ea115 100644
--- a/drivers/net/phy/natsemi.c
+++ b/drivers/net/phy/natsemi.c
@@ -33,7 +33,7 @@ static int dp83630_config(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver DP83630_driver =3D {
+U_BOOT_PHY_DRIVER(dp83630) =3D {
 	.name =3D "NatSemi DP83630",
 	.uid =3D 0x20005ce1,
 	.mask =3D 0xfffffff0,
@@ -103,7 +103,7 @@ static int dp83865_startup(struct phy_device *phydev)
 }
=20
=20
-static struct phy_driver DP83865_driver =3D {
+U_BOOT_PHY_DRIVER(dp83865) =3D {
 	.name =3D "NatSemi DP83865",
 	.uid =3D 0x20005c70,
 	.mask =3D 0xfffffff0,
@@ -146,7 +146,7 @@ static int dp83848_startup(struct phy_device *phydev)
 	return dp83848_parse_status(phydev);
 }
=20
-static struct phy_driver DP83848_driver =3D {
+U_BOOT_PHY_DRIVER(dp83848) =3D {
 	.name =3D "NatSemi DP83848",
 	.uid =3D 0x20005c90,
 	.mask =3D 0x2000ff90,
@@ -155,12 +155,3 @@ static struct phy_driver DP83848_driver =3D {
 	.startup =3D &dp83848_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_natsemi_init(void)
-{
-	phy_register(&DP83630_driver);
-	phy_register(&DP83865_driver);
-	phy_register(&DP83848_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 27cc9f5ec60..3d6fc8080e5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_NATSEMI
-	phy_natsemi_init();
-#endif
 #ifdef CONFIG_NXP_C45_TJA11XX_PHY
 	phy_nxp_c45_tja11xx_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index f69f379fc2b..647d23595d1 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_natsemi_init(void);
 int phy_nxp_c45_tja11xx_init(void);
 int phy_nxp_tja11xx_init(void);
 int phy_realtek_init(void);
--=20
2.39.2

