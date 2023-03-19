Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web10.21397.1679245539003333343
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOTD3eEWGbgKjosuyJgEVsiGNpRMSo620KyZde1pqaw=;
	b=uxrA5Np+VWdXrYo9xLOyQyo3g4YL24WXfG1zRBn0zkF5+AAYFEF8QUKTejmm7gUjXhyZR5
	JD7OZ5y+54pfGas2+8MSN5nX2cH3kc7E7xbaV4x4BJHshH7KQa67wf24YIH2d3QIsTkisL
	lcMX61KH//IV/oPAp8bCfIaTVUbFhWBXYuZMmeNTl2+DCsuayqGNpEJDiJL412HZR2Cz7L
	jkxzevuVKxj/z1VHlJITGR2TvUkygyJi4LuakNXONDkTsFe1zpGPKRtIcDXBWYQ8jZNgpT
	Y1WthtrnhG1/QuzVrFcsxWfoWq8OAMV0dYVwE2w60Sawe7szE2+Kijb92cWrAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOTD3eEWGbgKjosuyJgEVsiGNpRMSo620KyZde1pqaw=;
	b=S1en6Q9Y2mDtvvF2HjQAA2TWVP/lXiPj63QsKnj9WyWeiPij9oj7N9R5qBLrz4+rE6gtdf
	bX97dtuPksooS1fdoUZWRTyltnvrKGTFE57BWa/MVaoZJjh/9vhg2O/05rtEnjd8sDQ2Af
	44/p+MQ3yD7IIXfVmIFH2CpOlDv2xNH1/HpMogw/KpxoCImIS1CaQOqF9/2oGE6aL+UxEh
	Y5i6YvERPWxWmUgy/c4bpCiQHxvA4hQanGSswteOkAOMrUk80pFM/uoI5+m7K0JFGZWBeG
	BJMv5tJpnlosfxSamECuufs1//FX3vuw3G/nLYi7igGzZA++Kb+Pys89uhxD5g==
Subject: [PATCH 34/41] net: phy: ncsi: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:10 +0100
Message-Id: <20230319170317.27711-34-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/ncsi.c | 8 +-------
 drivers/net/phy/phy.c  | 3 ---
 include/phy.h          | 1 -
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index bb7ecebed38..eb3fd65bb47 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -881,7 +881,7 @@ int ncsi_shutdown(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver ncsi_driver =3D {
+U_BOOT_PHY_DRIVER(ncsi) =3D {
 	.uid		=3D PHY_NCSI_ID,
 	.mask		=3D 0xffffffff,
 	.name		=3D "NC-SI",
@@ -891,9 +891,3 @@ static struct phy_driver ncsi_driver =3D {
 	.startup	=3D ncsi_startup,
 	.shutdown	=3D ncsi_shutdown,
 };
-
-int phy_ncsi_init(void)
-{
-	phy_register(&ncsi_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 245357c31dc..69db79f79e0 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_NCSI
-	phy_ncsi_init();
-#endif
 #ifdef CONFIG_PHY_XILINX_GMII2RGMII
 	phy_xilinx_gmii2rgmii_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 9cabfeedec8..001c998db47 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_ncsi_init(void);
 int phy_xilinx_gmii2rgmii_init(void);
=20
 /**
--=20
2.39.2

