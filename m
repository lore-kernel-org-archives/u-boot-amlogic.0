Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web11.21114.1679245553340634319
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coJL793MVfgDnaZb7xSFveHjas2z73I+RxXUMjwtNUY=;
	b=Frn/i4qud6evxmVA2CqfEuTqETQENOTcPbudyan/iSXAp/ZTL1QWUA3yGvy7Om1XZRATq9
	19C5w2Qvjs/NdbLt6YGs5hTtBKXwO/+sqOcfYqY/678+rSavDphU2DDdwLDOYPHyW161he
	Hr8pMiRh0yd8zqx1EEdJdhdKKm/HhAW9DDbUrUBWSKAav+QDiDs3kzSNv91OlXwIyiBCrQ
	IkVU/n6LD5RGY0PGPbgujUV4scl0h7JZ2xFI/h0V/lgG91piR8+J2Ijneond0bxWWw4SP9
	0c9XWCB1DYe0mjoIJdnVotTsB55gXYC5SW5/4vi/DuOtwR92f7VUDISioBzylg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coJL793MVfgDnaZb7xSFveHjas2z73I+RxXUMjwtNUY=;
	b=ZelCg90ywMLgDIk3HHaT6DBtPnsl+99gwgph+K3jeaUb7WniGKv6B/eXOeAadPXRyioCuO
	mXGm/u4Jvtu4Io9NmkrZ4XepR5I54Gl2R+Keph6hdk30QGKuzlkKZULjAjekEbAhjTaiLe
	St4P4z/teoLsKr7VwIzo4cqYH5VlZlBjElxS5XY9AAUc09h8BXc0MR8/n4klMwAKERE9Nu
	rRIkV21aLB9rdB3eeXeYN8oPP2miDUGRgVkp8HG3VOnOUGK5m6fAb645oCQ5d+9jeNY/U/
	puszSU2LAurU93OV9KJtArfuDvadOsgffjfu2MZ8gTneIydS9TPHW8fanvJjUw==
Subject: [PATCH 39/41] net: phy: Drop unused phy_register()
Date: Sun, 19 Mar 2023 18:03:15 +0100
Message-Id: <20230319170317.27711-39-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This function is no longer used, drop it.

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
 drivers/net/phy/phy.c | 8 --------
 include/phy.h         | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index f4aa1f664cb..15da9a80de2 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -500,14 +500,6 @@ int phy_init(void)
 	return 0;
 }
=20
-int phy_register(struct phy_driver *drv)
-{
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	phy_drv_reloc(drv);
-#endif
-	return 0;
-}
-
 int phy_set_supported(struct phy_device *phydev, u32 max_speed)
 {
 	/* The default values for phydev->supported are provided by the PHY
diff --git a/include/phy.h b/include/phy.h
index 5e8ae5e29aa..4a9de461152 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -293,7 +293,6 @@ int phy_clear_bits_mmd(struct phy_device *phydev, int d=
evad, u32 regnum, u16 val
 int phy_startup(struct phy_device *phydev);
 int phy_config(struct phy_device *phydev);
 int phy_shutdown(struct phy_device *phydev);
-int phy_register(struct phy_driver *drv);
 int phy_set_supported(struct phy_device *phydev, u32 max_speed);
 int phy_modify(struct phy_device *phydev, int devad, int regnum, u16 mask,
 	       u16 set);
--=20
2.39.2

