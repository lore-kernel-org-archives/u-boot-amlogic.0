Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web11.21059.1679245459739130363
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PEHBOKAzcrpbT2GCl735MpxDiuf+z8uRNozu01lfA0=;
	b=Nl2jMM+IoWPMoN07ZosqcXy6FJFU7slvQZGEMatnAC7yfA7L7c4loXgNb1qPmVEwOhmoLG
	P+rukJ+/lgPfijyPTrfIgSy/M/vp7t6maWiMzTJUsCFxoeG5vplHI35OKjJ/vM4Izh7VjG
	4TJCKutB7E7pLnxcqapmfCgTjWc1vNwbIqlxVdtU3+R/o/r1U3CtoGUXBb/WRPFBzgifq6
	0vgbvQ07ZHWlbUhRCYapsgP6fxLMPxbCaPMfAKkhQviURK3w9uYvaKR5il/eczZq/q1H9a
	nclGBQ+6QJrOcQtpJSyabkvmLyKXMO9e4usSDOgbcgF28JIpVCDE6wqcI62E6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PEHBOKAzcrpbT2GCl735MpxDiuf+z8uRNozu01lfA0=;
	b=fLl9Dogk+FPsntbYqMRZbzR3eFfvZYZT+QK270NkANawyiX8Ve4RAzp4nOK8QNM+R4GXzh
	JMGsX9K/Bw11tMsildtkcY8/NGXiFg9/bW4STxaavtOGE9aiQZZVu8bBZcjbyk+8ijVtw3
	zUcCG5jv9tmxA373PPrIhm/wYu3pWd5dluiWGs6rW6dlt4Ed2/MaUKzux2mIDTyuZ8bf2E
	RhmTZYa55LRYFvp7LULlBxgGU4cBOVtk34pwhvQRMStTxREEJW+qaYuKJxpl41Mi8Zhr98
	TYhoPmJxbMw5HIxsBO5E6WJZYy3NfIUHtwa01jC871WV86vQP4CBcAovu8M99w==
Subject: [PATCH 05/41] net: phy: Factor manual relocation into separate function
Date: Sun, 19 Mar 2023 18:02:41 +0100
Message-Id: <20230319170317.27711-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Create separate function to implement manual relocation of PHY driver
functions and make use of that function. This is a preparatory patch
for introduction of PHY driver definition using linker lists.

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
 drivers/net/phy/phy.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 80230b907c1..5097c32b829 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -470,6 +470,28 @@ static int genphy_init(void)
=20
 static LIST_HEAD(phy_drivers);
=20
+#ifdef CONFIG_NEEDS_MANUAL_RELOC
+static void phy_drv_reloc(struct phy_driver *drv)
+{
+	if (drv->probe)
+		drv->probe +=3D gd->reloc_off;
+	if (drv->config)
+		drv->config +=3D gd->reloc_off;
+	if (drv->startup)
+		drv->startup +=3D gd->reloc_off;
+	if (drv->shutdown)
+		drv->shutdown +=3D gd->reloc_off;
+	if (drv->readext)
+		drv->readext +=3D gd->reloc_off;
+	if (drv->writeext)
+		drv->writeext +=3D gd->reloc_off;
+	if (drv->read_mmd)
+		drv->read_mmd +=3D gd->reloc_off;
+	if (drv->write_mmd)
+		drv->write_mmd +=3D gd->reloc_off;
+}
+#endif
+
 int phy_init(void)
 {
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
@@ -582,22 +604,7 @@ int phy_register(struct phy_driver *drv)
 	list_add_tail(&drv->list, &phy_drivers);
=20
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
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
+	phy_drv_reloc(drv);
 #endif
 	return 0;
 }
--=20
2.39.2

