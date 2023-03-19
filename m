Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web10.21389.1679245523005612975
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SSah0UHqvz2pupbPPkhgH+OH7onihdVLd73Zk1yzEE=;
	b=LoWxKCtQcPf37qVZmIR5m5F2wTxYHy4DBHCkVGdVChV2EOtyI9sLDAXR68XtvRI31Gnqpv
	c8K7S3cCqj2sj60BeQeUtVkSZutJjTfOrQ+gF8tyU9gEOzCNr/fjLU1Je//N7wFk9d+65t
	7UvCkLXmR2h+kX+q+pMVk+y3hEHjT6smnwJnm1sZvVeB3SqbAIk5gv3/TA1Lmm6tA7cXOZ
	HELrSl83oLcR2w/AH62yDM3aoznt9Ykx8gfCs4x/6wrRIsaYUny4W+LGe0hxnZ6RJ6bHmU
	KPeFdaZ6Ft9v5njMai7khL3Uw19ivok1p9r1arKVFkBxc5V6Zhm7W5LgFyts3g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SSah0UHqvz2pupbPPkhgH+OH7onihdVLd73Zk1yzEE=;
	b=SW+sg1mFHxo+dCpwPy888C40EcEt0uWahBhwQ6RdT/Lsq8hscrbjpMI2X5qhKhtdv0amBF
	lqz+hC2G8Gfq3yajnf4mbU44aRc2mM0v7yJwbu+L9vH+z3HwN37W01DFSz4Ua4aFgeuV24
	Xy3jDM6vbufemcSzm/JQvDCRooSg8oe63YLK7SI8ePTM3Vz3bPIjI8Chf0iz+9H8s33d1d
	SHCKhOpkGvhw7NzeSG2lmZdyWqze+Ydr4kd64YTOBo7dHJ4CAw3yfz8M0he0upNFB1K/Mj
	okqlzDInN6EwMZ/zkC+uo3NTH1tfYMnQGcwLzKdDzWlx+ay7ByamVIfyuCj9Sw==
Subject: [PATCH 28/41] net: phy: ti: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:04 +0100
Message-Id: <20230319170317.27711-28-marek.vasut+renesas@mailbox.org>
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

This particular PHY driver is slightly more spread out across additional
source files. Since the phy_register() calls are no longer necessary, all
the registration calls across those source files is dropped. Furthermore,
the Makefile can now be updated to only compile generic TI PHY support if
matching Kconfig symbol is enabled and the ifdeffery in the generic TI PHY
driver can be dropped.

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
 drivers/net/phy/Makefile      |  2 +-
 drivers/net/phy/dp83867.c     |  8 +-------
 drivers/net/phy/dp83869.c     |  8 +-------
 drivers/net/phy/phy.c         |  3 ---
 drivers/net/phy/ti_phy_init.c | 38 +++++++----------------------------
 include/phy.h                 |  1 -
 6 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index d38e99e7171..963d96e2bcb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_PHY_NXP_TJA11XX) +=3D nxp-tja11xx.o
 obj-$(CONFIG_PHY_REALTEK) +=3D realtek.o
 obj-$(CONFIG_PHY_SMSC) +=3D smsc.o
 obj-$(CONFIG_PHY_TERANETICS) +=3D teranetics.o
-obj-$(CONFIG_PHY_TI) +=3D ti_phy_init.o
+obj-$(CONFIG_PHY_TI_GENERIC) +=3D ti_phy_init.o
 obj-$(CONFIG_PHY_TI_DP83867) +=3D dp83867.o
 obj-$(CONFIG_PHY_TI_DP83869) +=3D dp83869.o
 obj-$(CONFIG_PHY_XILINX) +=3D xilinx_phy.o
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index a45152bddc9..b861bf7cef3 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -409,7 +409,7 @@ static int dp83867_probe(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver DP83867_driver =3D {
+U_BOOT_PHY_DRIVER(dp83867) =3D {
 	.name =3D "TI DP83867",
 	.uid =3D 0x2000a231,
 	.mask =3D 0xfffffff0,
@@ -419,9 +419,3 @@ static struct phy_driver DP83867_driver =3D {
 	.startup =3D &genphy_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_dp83867_init(void)
-{
-	phy_register(&DP83867_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 23dbf42b68c..8d32d73b07f 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -473,7 +473,7 @@ static int dp83869_probe(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver DP83869_driver =3D {
+U_BOOT_PHY_DRIVER(dp83869) =3D {
 	.name =3D "TI DP83869",
 	.uid =3D 0x2000a0f1,
 	.mask =3D 0xfffffff0,
@@ -485,9 +485,3 @@ static struct phy_driver DP83869_driver =3D {
 	.readext =3D dp83869_readext,
 	.writeext =3D dp83869_writeext
 };
-
-int phy_dp83869_init(void)
-{
-	phy_register(&DP83869_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b76cc51cbfb..404d61c5ab3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_TI
-	phy_ti_init();
-#endif
 #ifdef CONFIG_PHY_VITESSE
 	phy_vitesse_init();
 #endif
diff --git a/drivers/net/phy/ti_phy_init.c b/drivers/net/phy/ti_phy_init.c
index 075b19a39f0..a0878193ac0 100644
--- a/drivers/net/phy/ti_phy_init.c
+++ b/drivers/net/phy/ti_phy_init.c
@@ -10,8 +10,7 @@
 #include <phy.h>
 #include "ti_phy_init.h"
=20
-#ifdef CONFIG_PHY_TI_GENERIC
-static struct phy_driver dp83822_driver =3D {
+U_BOOT_PHY_DRIVER(dp83822) =3D {
 	.name =3D "TI DP83822",
 	.uid =3D 0x2000a240,
 	.mask =3D 0xfffffff0,
@@ -21,7 +20,7 @@ static struct phy_driver dp83822_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83826nc_driver =3D {
+U_BOOT_PHY_DRIVER(dp83826nc) =3D {
 	.name =3D "TI DP83826NC",
 	.uid =3D 0x2000a110,
 	.mask =3D 0xfffffff0,
@@ -31,7 +30,7 @@ static struct phy_driver dp83826nc_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83826c_driver =3D {
+U_BOOT_PHY_DRIVER(dp83826c) =3D {
 	.name =3D "TI DP83826C",
 	.uid =3D 0x2000a130,
 	.mask =3D 0xfffffff0,
@@ -41,7 +40,7 @@ static struct phy_driver dp83826c_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83825s_driver =3D {
+U_BOOT_PHY_DRIVER(dp83825s) =3D {
 	.name =3D "TI DP83825S",
 	.uid =3D 0x2000a140,
 	.mask =3D 0xfffffff0,
@@ -51,7 +50,7 @@ static struct phy_driver dp83825s_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83825i_driver =3D {
+U_BOOT_PHY_DRIVER(dp83825i) =3D {
 	.name =3D "TI DP83825I",
 	.uid =3D 0x2000a150,
 	.mask =3D 0xfffffff0,
@@ -61,7 +60,7 @@ static struct phy_driver dp83825i_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83825m_driver =3D {
+U_BOOT_PHY_DRIVER(dp83825m) =3D {
 	.name =3D "TI DP83825M",
 	.uid =3D 0x2000a160,
 	.mask =3D 0xfffffff0,
@@ -71,7 +70,7 @@ static struct phy_driver dp83825m_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver dp83825cs_driver =3D {
+U_BOOT_PHY_DRIVER(dp83825cs) =3D {
 	.name =3D "TI DP83825CS",
 	.uid =3D 0x2000a170,
 	.mask =3D 0xfffffff0,
@@ -80,26 +79,3 @@ static struct phy_driver dp83825cs_driver =3D {
 	.startup =3D &genphy_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-#endif /* CONFIG_PHY_TI_GENERIC */
-
-int phy_ti_init(void)
-{
-#ifdef CONFIG_PHY_TI_DP83867
-	phy_dp83867_init();
-#endif
-
-#ifdef CONFIG_PHY_TI_DP83869
-	phy_dp83869_init();
-#endif
-
-#ifdef CONFIG_PHY_TI_GENERIC
-	phy_register(&dp83822_driver);
-	phy_register(&dp83825s_driver);
-	phy_register(&dp83825i_driver);
-	phy_register(&dp83825m_driver);
-	phy_register(&dp83825cs_driver);
-	phy_register(&dp83826c_driver);
-	phy_register(&dp83826nc_driver);
-#endif
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index 2c6e167f26e..e6508a132d0 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_ti_init(void);
 int phy_vitesse_init(void);
 int phy_xilinx_init(void);
 int phy_xway_init(void);
--=20
2.39.2

