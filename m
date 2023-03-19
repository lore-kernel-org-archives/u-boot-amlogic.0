Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web11.21116.1679245556014761348
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO+62RtQhfcAj4sqHVhclxl8P7FZWAnOMGmeuuR3W9A=;
	b=MEaH8Ne2+xyWkKufjqxRwtcfcz3nHEfofSGuH4tpiNPF520k0aMpuA2Wh772XIU25TmMfw
	HYlXxMIZMwART6TIFfCH7R6mob+rQv5By7RkOHF+ToI5LVvTWUaXnItNJSpW3+/Im5gYes
	8bRers1Xbr1WTygbQZN+30OMPt2z9xEmDDCdYacDM9qgxeNFKoG0B7aeOME7FufondyuXj
	4iqEc1glB3qfHaCXLJ134EIrDP27tylZ9EMrQxNnXcIErrcpO3PX9iY2TqzQQnNe8csHCE
	2/fjCRfR3uRcgr/VWg2B7KJijO4id4mNafkq2o/BWPrKqjDDJRDTD76yc5GpPg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO+62RtQhfcAj4sqHVhclxl8P7FZWAnOMGmeuuR3W9A=;
	b=i3SR94DS9ybvQjSsj8Yevmss0Y+e2qRM+7LxBzhhgX59oLmKfDc5uwfdjZCgNEf8b837Gy
	QodUj8y3K4corjh8MDS8HrYJtLEXk7oepMfrCQZJHk04+k9e+MgRHoprQVws15p80wakUx
	3uND0rWQXIKh+BJONzM6m85Mig7087kca/fF23yU0ixEvaGORRmuGASOFNXJ3qmBBU2q3a
	ku8EGvbmMrD2XR1MreRSGrNmmhYiKmzwun+QOFDSV2UhRfUFggv22thFAAYB+mbzuEQHk9
	C4Z/IlTnWXYntsMdwyvIzl1YxJ2m4QLlvhmkH7z1Peawcq+Flhs1ojhe0WItLw==
Subject: [PATCH 40/41] net: phy: Re-inline phy_drv_reloc()
Date: Sun, 19 Mar 2023 18:03:16 +0100
Message-Id: <20230319170317.27711-40-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Wrap phy_drv_reloc() back into phy_init() to reduce ifdeffery,
since phy_drv_reloc() is now called only from one call site.
No functional change.

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
 drivers/net/phy/phy.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 15da9a80de2..61603f28179 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -463,28 +463,6 @@ U_BOOT_PHY_DRIVER(genphy) =3D {
 	.shutdown	=3D genphy_shutdown,
 };
=20
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-static void phy_drv_reloc(struct phy_driver *drv)
-{
-	if (drv->probe)
-		drv->probe +=3D gd->reloc_off;
-	if (drv->config)
-		drv->config +=3D gd->reloc_off;
-	if (drv->startup)
-		drv->startup +=3D gd->reloc_off;
-	if (drv->shutdown)
-		drv->shutdown +=3D gd->reloc_off;
-	if (drv->readext)
-		drv->readext +=3D gd->reloc_off;
-	if (drv->writeext)
-		drv->writeext +=3D gd->reloc_off;
-	if (drv->read_mmd)
-		drv->read_mmd +=3D gd->reloc_off;
-	if (drv->write_mmd)
-		drv->write_mmd +=3D gd->reloc_off;
-}
-#endif
-
 int phy_init(void)
 {
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
@@ -493,8 +471,24 @@ int phy_init(void)
=20
 	/* Perform manual relocation on linker list based PHY drivers */
 	ll_entry =3D ll_entry_start(struct phy_driver, phy_driver);
-	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++)
-		phy_drv_reloc(drv);
+	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++) {
+		if (drv->probe)
+			drv->probe +=3D gd->reloc_off;
+		if (drv->config)
+			drv->config +=3D gd->reloc_off;
+		if (drv->startup)
+			drv->startup +=3D gd->reloc_off;
+		if (drv->shutdown)
+			drv->shutdown +=3D gd->reloc_off;
+		if (drv->readext)
+			drv->readext +=3D gd->reloc_off;
+		if (drv->writeext)
+			drv->writeext +=3D gd->reloc_off;
+		if (drv->read_mmd)
+			drv->read_mmd +=3D gd->reloc_off;
+		if (drv->write_mmd)
+			drv->write_mmd +=3D gd->reloc_off;
+	}
 #endif
=20
 	return 0;
--=20
2.39.2

