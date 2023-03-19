Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web11.21097.1679245519246563663
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UELc162fhBaVM3nJ/nSHNt+XnRfslgeB6QC1GB7eyUk=;
	b=ucv7O/pph00UwSaRYbllB0rtOyXsxsErexDdYQ8D/3x2m2My+u+QwBUz4Cua1Wc7MtyXhe
	Cn74CLfAiK/rK6Udx1pfNUQE4un4nSU+uybUUTq4Zv5TGSzV9WH8ZtNQIIBfPl+Whm7ms1
	2iW7AzHfL/EqRByGZrY8KolPKRqIgj7sYoOJ9AkdVDO+zOPb+yiMLPaMFKlmJf1jHYJYok
	/3d7vqkzJOiA7ApZw3Pk0Rcpt6KWKYNJTtT98S5OApYBD3x+/cP+iGPwWzhviTenLr3a3Z
	f3xH2nX6zTSbkjEthABktyFDCSHS+OHzHrqwQeeFhYtJDVnqHJAaWY6VPuuTdg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UELc162fhBaVM3nJ/nSHNt+XnRfslgeB6QC1GB7eyUk=;
	b=c4WN1yYTDpiDFrjA0mJ/erPROsGr2Rby1C1fRilXMvnXyj7RHlge1d94ng0e/9zbRWJN2I
	p6xkqR2lZS4mT8ZhkqzQBWxZZZCdX/FayMqZ6KPBFnsw9oCdUj7UBhj+6Run/xvQF6hftN
	XXynVMbVSF8w33x9QP/1sfChqLd/959GRzQEjfj+PJYkK6NzwMkp+WaJr087RjprDA6TUg
	9kc00bUUyhlXV/E4U8Y+RErfMelNggPFYgm4dwgRNiQEhytblyr+Uxc0zlByfqOQFPC8FA
	iw2G4zJr4P7Z/yuCAdrcPj2J8+0Q+a6sOAiuc+cm4vSGP6sJ+k9Gv69cpuavtQ==
Subject: [PATCH 27/41] net: phy: teranetics: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:03 +0100
Message-Id: <20230319170317.27711-27-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c        | 3 ---
 drivers/net/phy/teranetics.c | 9 +--------
 include/phy.h                | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d4a50fb76ac..b76cc51cbfb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_PHY_TERANETICS
-	phy_teranetics_init();
-#endif
 #ifdef CONFIG_PHY_TI
 	phy_ti_init();
 #endif
diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index c402bad88c6..15f2c12ed83 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -90,7 +90,7 @@ int tn2020_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver tn2020_driver =3D {
+U_BOOT_PHY_DRIVER(tn2020) =3D {
 	.name =3D "Teranetics TN2020",
 	.uid =3D PHY_UID_TN2020,
 	.mask =3D 0xfffffff0,
@@ -102,10 +102,3 @@ static struct phy_driver tn2020_driver =3D {
 	.startup =3D &tn2020_startup,
 	.shutdown =3D &gen10g_shutdown,
 };
-
-int phy_teranetics_init(void)
-{
-	phy_register(&tn2020_driver);
-
-	return 0;
-}
diff --git a/include/phy.h b/include/phy.h
index 4326ef223e0..2c6e167f26e 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_teranetics_init(void);
 int phy_ti_init(void);
 int phy_vitesse_init(void);
 int phy_xilinx_init(void);
--=20
2.39.2

