Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21387.1679245516594234090
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjdrui3gAHIQgjh6Udy3JW0wIpa7T+0f79QkNq+Q0Ps=;
	b=dMBlfrKOdvCHI2Uhk22q+PG6s9HqfIoRwGYKrG0ya9oLEWcvmxX1EXqvAtrgV+Sr9b864D
	pAE3yoG3FtrdFIUSCAsDsIKzv+1DDRBZQ0Xn9q2YU0Fkfi1OaGRTOYe8D6umWAe9NsqcGn
	vobRJRS2GBaZziJzf2HaUFWskoN0aaVGDEBI4/aaJu/UwWOut53Runh/sbiy8DSS+xlq4G
	wTYwE/W+ikmf894UQbNqfUmf67mmR3fqAzTsBeYTIBN3d2kCFYFmFFmXWYvoWp8yeVDGBu
	plA5n5durdrHATf2hRVKHDDJsrAqAbBcYF3ki7fmL6KPUHBYy5PSYObh6RuZ/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjdrui3gAHIQgjh6Udy3JW0wIpa7T+0f79QkNq+Q0Ps=;
	b=FN/cWqhVEkObw12NKQgAg7HEIosDDmOfNzQIx4HQkUUVKVUoRZ4Fuv8z7dRq+jluBjp72v
	hWzJk8np365Ep595fUFTDxu39uewczg9ZJ8PpaBCEc4/0Kq6tM/IKxzxuMRoTMvpmoji0o
	9ZtW5UUiWsRG7Z2+A2nJowQ+9+yddQK28rMp58JgwmacXYO5paW/yAvRKXM6cPO36LxbN1
	6IE8Issb/F8ayf76crSG3At2knokx3U3hoO0nOcHaEh04Kf+acFh2I/8gFfO5vOvtB/4bG
	jgjCd035S4NhAf3UYDG4Gu52gKnwuuuoaIz5O0vD5DmT0j4FNIdhruGFJkAC2w==
Subject: [PATCH 26/41] net: phy: smsc: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:02 +0100
Message-Id: <20230319170317.27711-26-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c  |  3 ---
 drivers/net/phy/smsc.c | 24 ++++++------------------
 include/phy.h          |  1 -
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e821a3f37cb..d4a50fb76ac 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_SMSC
-	phy_smsc_init();
-#endif
 #ifdef CONFIG_PHY_TERANETICS
 	phy_teranetics_init();
 #endif
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 7740a2510d2..056b607e0b8 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -43,7 +43,7 @@ static int smsc_startup(struct phy_device *phydev)
 	return smsc_parse_status(phydev);
 }
=20
-static struct phy_driver lan8700_driver =3D {
+U_BOOT_PHY_DRIVER(lan8700) =3D {
 	.name =3D "SMSC LAN8700",
 	.uid =3D 0x0007c0c0,
 	.mask =3D 0xffff0,
@@ -53,7 +53,7 @@ static struct phy_driver lan8700_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver lan911x_driver =3D {
+U_BOOT_PHY_DRIVER(lan911x) =3D {
 	.name =3D "SMSC LAN911x Internal PHY",
 	.uid =3D 0x0007c0d0,
 	.mask =3D 0xffff0,
@@ -63,7 +63,7 @@ static struct phy_driver lan911x_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver lan8710_driver =3D {
+U_BOOT_PHY_DRIVER(lan8710) =3D {
 	.name =3D "SMSC LAN8710/LAN8720",
 	.uid =3D 0x0007c0f0,
 	.mask =3D 0xffff0,
@@ -73,7 +73,7 @@ static struct phy_driver lan8710_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver lan8740_driver =3D {
+U_BOOT_PHY_DRIVER(lan8740) =3D {
 	.name =3D "SMSC LAN8740",
 	.uid =3D 0x0007c110,
 	.mask =3D 0xffff0,
@@ -83,7 +83,7 @@ static struct phy_driver lan8740_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver lan8741_driver =3D {
+U_BOOT_PHY_DRIVER(lan8741) =3D {
 	.name =3D "SMSC LAN8741",
 	.uid =3D 0x0007c120,
 	.mask =3D 0xffff0,
@@ -93,7 +93,7 @@ static struct phy_driver lan8741_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver lan8742_driver =3D {
+U_BOOT_PHY_DRIVER(lan8742) =3D {
 	.name =3D "SMSC LAN8742",
 	.uid =3D 0x0007c130,
 	.mask =3D 0xffff0,
@@ -102,15 +102,3 @@ static struct phy_driver lan8742_driver =3D {
 	.startup =3D &genphy_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_smsc_init(void)
-{
-	phy_register(&lan8710_driver);
-	phy_register(&lan911x_driver);
-	phy_register(&lan8700_driver);
-	phy_register(&lan8740_driver);
-	phy_register(&lan8741_driver);
-	phy_register(&lan8742_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index 24a880ed2fb..4326ef223e0 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_smsc_init(void);
 int phy_teranetics_init(void);
 int phy_ti_init(void);
 int phy_vitesse_init(void);
--=20
2.39.2

