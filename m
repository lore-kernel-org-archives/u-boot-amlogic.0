Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web10.21400.1679245541919017220
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d2tY+2sF6dwspdNJ4JcX6UQCy9A/20jq+njEP9bcBg=;
	b=vtSnmdyUxL3NeOwyCWgPgBCXE/4ZTAtRYN6KqOwCzCpM3A1hvjo/mMbK9vrAHjU1jRJLf+
	6ArgilAe2jxs8Spki3QSERXXEyXJ6FusSMxbeqZe0H46/fO2CQI8Zm4nIAkaAI5fu3Ym49
	C15SHT0Ayn708sUcsMuX/fhFP8P5+OgRcY5EHwrf6rW7IoJcXZ1fzySnvxNEkpBjT01Lvi
	SSUQl0Q2z1sWEOO+F+H4lfCo/rXMSbvRchGw5ctQCD8KySyHgXpGFp3zS4dJep0sS9PPwk
	vs/4Onzu/Pfkq1omtaXZgtnk8n9iEsITDxbS2MlSum0myfO8e0x0sjIQwlV2pg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d2tY+2sF6dwspdNJ4JcX6UQCy9A/20jq+njEP9bcBg=;
	b=t4gRq5kraDFVPaU4A6lcvalPeeHmwQIYZ+lq3CsUEcwj7BowIRGVkiyk5Mzlt305gQaUGT
	Dj/bYAd71jvY4481Nnj3iI/Bax8ce69BkbqNK9JWnRPmSX1NyOE+zMKU0h3eYWJ5dMOqRP
	nGNe3QmUYWRw0qxWk6RxR7IEkq8JfmdJIwB10pjA0pCu4dVN7f6UL0kDbVKp7MHjdM8sX6
	uqFQfYvdgBWE/bv9ig2uHYZIL2lVvWjxxdI0L2Yskyb1TTRQZ4/ANEn71UtYEOH1b9qHHq
	hv9gEKKT1WTACXgixGdqvkf/0Cr1xvWDaCSDCqw7VfevI4GLstpa+xnAXaMWDw==
Subject: [PATCH 35/41] net: phy: xilinx-gmii2rgmii: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:11 +0100
Message-Id: <20230319170317.27711-35-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c               | 3 ---
 drivers/net/phy/xilinx_gmii2rgmii.c | 9 +--------
 include/phy.h                       | 2 --
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 69db79f79e0..9d5d1494616 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_XILINX_GMII2RGMII
-	phy_xilinx_gmii2rgmii_init();
-#endif
 	genphy_init();
=20
 	return 0;
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index 73762839565..0b7436a7e1e 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -124,7 +124,7 @@ static int xilinxgmiitorgmii_probe(struct phy_device *p=
hydev)
 	return 0;
 }
=20
-static struct phy_driver gmii2rgmii_driver =3D {
+U_BOOT_PHY_DRIVER(gmii2rgmii) =3D {
 	.name =3D "XILINX GMII2RGMII",
 	.uid =3D PHY_GMII2RGMII_ID,
 	.mask =3D 0xffffffff,
@@ -135,10 +135,3 @@ static struct phy_driver gmii2rgmii_driver =3D {
 	.writeext =3D xilinxgmiitorgmii_extwrite,
 	.readext =3D xilinxgmiitorgmii_extread,
 };
-
-int phy_xilinx_gmii2rgmii_init(void)
-{
-	phy_register(&gmii2rgmii_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index 001c998db47..df2586f89ea 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,8 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_xilinx_gmii2rgmii_init(void);
-
 /**
  * U_BOOT_PHY_DRIVER() - Declare a new U-Boot driver
  * @__name: name of the driver
--=20
2.39.2

