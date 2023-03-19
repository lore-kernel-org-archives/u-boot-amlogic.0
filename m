Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web11.21094.1679245513934820202
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INpe9DvGpe4FTOHEvQ1GTi+g78m9uL5dEWVTh3OkzdM=;
	b=p23ERLQuH3JhoRcedzH/et5Y1GG2MPsGW7/qegaYH8ZwMYDwAkjPRkH8utI3lNQtUJahLE
	T9RNcdT8fpuG2++v+VlRgkHD5cHtn22LTcbo6aiRLIYX0LYhYmp70sPQbDYLLYxec8xbSe
	SwavP1kVMPvA17JKPoD5miwNV3wWDahfjzX0bNNELsqvzb6H/28t6M0KA4u8U0shmqg+9B
	n2cOoMJxMLfvWAYPBE2VDqN1y9HWD+HHfNTVRWOnZLlALrV8xA4ApU3exDLpntCQrWcWGm
	U7zkr3qV9AbRcMP2VZ+Pmy7mp2gm60mTrA1NopdycvJP+QxKFIelpNLfOORQ2Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INpe9DvGpe4FTOHEvQ1GTi+g78m9uL5dEWVTh3OkzdM=;
	b=jRXSLZT45+kuc/HdhzWSnwW22leLHuQpdVMvwYC1kxP5LRNR3mLsDrAazzZwu7PJz+zQ+4
	O55Ah6pHJxTYLVvNfAGljJkkPlOGjm3fiGI48oZuXFggDewxfUG5YCZQgQzVDzXqG+aztF
	Nh6aSIjO4ezkPaSXXJkwrTOui1jngvFTenya/PEiP4/Hd2bnbvdsSiZtIkLmEh/9id48Pk
	vuaQBRflm9VUc4gevwQTE7AJboggKaI4qlbGPehBYLrCFKfwrq5erRjCM0Z/50E1wecV6B
	DAydvdNk0HuAuawOlxTSbeibBFKpBBIMJEZl0ijg8MiKgQYAteQLbyt/6Yhtig==
Subject: [PATCH 25/41] net: phy: realtek: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:01 +0100
Message-Id: <20230319170317.27711-25-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c     |  3 ---
 drivers/net/phy/realtek.c | 21 +++++----------------
 include/phy.h             |  1 -
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 03d221f216d..e821a3f37cb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_REALTEK
-	phy_realtek_init();
-#endif
 #ifdef CONFIG_PHY_SMSC
 	phy_smsc_init();
 #endif
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 24c3ea59bbb..247d9753a88 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -409,7 +409,7 @@ static int rtl8211f_startup(struct phy_device *phydev)
 }
=20
 /* Support for RTL8211B PHY */
-static struct phy_driver RTL8211B_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211b) =3D {
 	.name =3D "RealTek RTL8211B",
 	.uid =3D 0x1cc912,
 	.mask =3D 0xffffff,
@@ -421,7 +421,7 @@ static struct phy_driver RTL8211B_driver =3D {
 };
=20
 /* Support for RTL8211E-VB-CG, RTL8211E-VL-CG and RTL8211EG-VB-CG PHYs */
-static struct phy_driver RTL8211E_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211e) =3D {
 	.name =3D "RealTek RTL8211E",
 	.uid =3D 0x1cc915,
 	.mask =3D 0xffffff,
@@ -433,7 +433,7 @@ static struct phy_driver RTL8211E_driver =3D {
 };
=20
 /* Support for RTL8211DN PHY */
-static struct phy_driver RTL8211DN_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211dn) =3D {
 	.name =3D "RealTek RTL8211DN",
 	.uid =3D 0x1cc914,
 	.mask =3D 0xffffff,
@@ -444,7 +444,7 @@ static struct phy_driver RTL8211DN_driver =3D {
 };
=20
 /* Support for RTL8211F PHY */
-static struct phy_driver RTL8211F_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211f) =3D {
 	.name =3D "RealTek RTL8211F",
 	.uid =3D 0x1cc916,
 	.mask =3D 0xffffff,
@@ -458,7 +458,7 @@ static struct phy_driver RTL8211F_driver =3D {
 };
=20
 /* Support for RTL8201F PHY */
-static struct phy_driver RTL8201F_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8201f) =3D {
 	.name =3D "RealTek RTL8201F 10/100Mbps Ethernet",
 	.uid =3D 0x1cc816,
 	.mask =3D 0xffffff,
@@ -468,14 +468,3 @@ static struct phy_driver RTL8201F_driver =3D {
 	.startup =3D &rtl8211e_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_realtek_init(void)
-{
-	phy_register(&RTL8211B_driver);
-	phy_register(&RTL8211E_driver);
-	phy_register(&RTL8211F_driver);
-	phy_register(&RTL8211DN_driver);
-	phy_register(&RTL8201F_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index bc42a522ea6..24a880ed2fb 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_realtek_init(void);
 int phy_smsc_init(void);
 int phy_teranetics_init(void);
 int phy_ti_init(void);
--=20
2.39.2

