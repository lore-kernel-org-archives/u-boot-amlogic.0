Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21371.1679245475548547060
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/g6fytIaAiqx06zSk5hva4z1hyDtxLednGctuVUSbs=;
	b=xLHklSS1QWe9kghuc3GY04IJqGCVvV1T7mKuBnNavWRNe11Pc2s3hO3wp0UhufDNvjGIt2
	p00HlHZJ9pqd4VWwumHAzbf7zgSP75yuzzmq+DtOtVYqEGb0SgjFkOSTSb+VYEyPRbP2dQ
	8hR7AA/ZHTgyUM6i0g5mLMbuItawjWOwNfRW6tcYDhlmK5EqlTy8l52W+gDeMAaMVKuzW1
	vomzXGhkDYzJ0w2z9/g1UUnMs2uG6565EQjIoTzBhglEG8/sub3278VkICB5Z5hoLz3zq6
	fzHTTwQffN7mO2O3OyVyoV+Xk+ReDuJxoQore2l7v4xr113aeEByPOUgtOhtfw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/g6fytIaAiqx06zSk5hva4z1hyDtxLednGctuVUSbs=;
	b=mEzWvphQl3xwy+PJA82FwvPLvb2lj/cABoL/8nH7HJAnQLavWP+CYqhnjALV6RUN2vHmNU
	L0WhdmFFh+BeDqBUrrmAwgtIi62Q8y5o+IYkd2RFCJwkARs+lwyOV3ZKCtM4El3jGlimej
	lsInjQSEQxPv9jXVXjd0BJnBN9051BSUg6EOIYNXvOKNMENIwA5udGvuLkgbKik4+FWDPX
	zLVeyPkD4U7bbMWTxqzm8sx97jr/4T2/HhPKFBlygcR1qe9efgUq7NgQ5CcazB0EBdKORI
	OpL2LGt7SfPDhhS36UWj6QOgVgDyVRUZEjHR38h0jFXJ9wjycNUIxYrk6pCvbg==
Subject: [PATCH 11/41] net: phy: broadcom: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:47 +0100
Message-Id: <20230319170317.27711-11-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/broadcom.c | 18 ++++--------------
 drivers/net/phy/phy.c      |  3 ---
 include/phy.h              |  1 -
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 566fcb8de73..ea98cfcc1b5 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -323,7 +323,7 @@ static int bcm5482_startup(struct phy_device *phydev)
 	return bcm54xx_parse_status(phydev);
 }
=20
-static struct phy_driver BCM5461S_driver =3D {
+U_BOOT_PHY_DRIVER(bcm5461s) =3D {
 	.name =3D "Broadcom BCM5461S",
 	.uid =3D 0x2060c0,
 	.mask =3D 0xfffff0,
@@ -333,7 +333,7 @@ static struct phy_driver BCM5461S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver BCM5464S_driver =3D {
+U_BOOT_PHY_DRIVER(bcm5464s) =3D {
 	.name =3D "Broadcom BCM5464S",
 	.uid =3D 0x2060b0,
 	.mask =3D 0xfffff0,
@@ -343,7 +343,7 @@ static struct phy_driver BCM5464S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver BCM5482S_driver =3D {
+U_BOOT_PHY_DRIVER(bcm5482s) =3D {
 	.name =3D "Broadcom BCM5482S",
 	.uid =3D 0x143bcb0,
 	.mask =3D 0xffffff0,
@@ -353,7 +353,7 @@ static struct phy_driver BCM5482S_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-static struct phy_driver BCM_CYGNUS_driver =3D {
+U_BOOT_PHY_DRIVER(bcm_cygnus) =3D {
 	.name =3D "Broadcom CYGNUS GPHY",
 	.uid =3D 0xae025200,
 	.mask =3D 0xfffff0,
@@ -362,13 +362,3 @@ static struct phy_driver BCM_CYGNUS_driver =3D {
 	.startup =3D &bcm_cygnus_startup,
 	.shutdown =3D &genphy_shutdown,
 };
-
-int phy_broadcom_init(void)
-{
-	phy_register(&BCM5482S_driver);
-	phy_register(&BCM5464S_driver);
-	phy_register(&BCM5461S_driver);
-	phy_register(&BCM_CYGNUS_driver);
-
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 7a7762377b6..4b1fed1ff6f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -517,9 +517,6 @@ int phy_init(void)
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
-#ifdef CONFIG_PHY_BROADCOM
-	phy_broadcom_init();
-#endif
 #ifdef CONFIG_PHY_CORTINA
 	phy_cortina_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index 88c9013f1f8..cecfbe6968f 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -316,7 +316,6 @@ int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_mv88e61xx_init(void);
-int phy_broadcom_init(void);
 int phy_cortina_init(void);
 int phy_cortina_access_init(void);
 int phy_davicom_init(void);
--=20
2.39.2

