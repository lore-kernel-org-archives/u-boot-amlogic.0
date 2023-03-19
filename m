Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21372.1679245478185846318
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dsCrBqWbtMbthUNGbLjq013Sdx5XjIlrpTS0AbRoVQ=;
	b=AwqKiXFg5LCnSAJNviNjSLu+/35A1cHIfX8d/bzasC7W4cLEkhISY2guwec4c5D01wOwDl
	9UVlOoR3fpGfld4UuT6iYHa+Ksxs7SZvu4CZe7AiiS7CpqZo/UAoH+AJMTONe90TRxTey/
	UyksQOjUy//w1WZQTqp/qwPs7P+zocJ7HcAc+rwSw0yrxdgrW9tQeizCRAqHEAPe1dcOXV
	Y3sRWKkXlXqE2luKdmbQWOtIoRqduA5Ujmgs9BNzIzFif9HPUtRJCIKM9ozCCRvrONAg5R
	DlZe4vEzRKrof/Uh7vcz4o8RGlU1wzdDxBDUOi28iBALoTQimUyaY82R+/YbGQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dsCrBqWbtMbthUNGbLjq013Sdx5XjIlrpTS0AbRoVQ=;
	b=eXMgG5QLbufy7J0Sa0RPwMXKYEre280gx/Q/YYsQ5innUvKlja1l/ejfvjSLU7r3XX2EJk
	vvKhWjEwa9dXiV+S8IRP1InzsgtaD8CW/FTJQY+c9OqCtx5LCHQNKwLwq+eAlC3pQpQVsL
	Qw31/CAdON/1eGjxGiY4wcnd6eIo/dQ87Y4WwEVDKPts/OjKD7L96oYkXSGse1vAEv5YDe
	D5R9ch1vuZwWfCM6twwwfiKaW5gtLySYIG404xyisjio0Hk+huWPU4bdMAVwQJEEBdhf3U
	CV8wgqWG3l36Xo/SoObES9K5qfS9hopjmfhA6SnuxmSseDE3SOOaut8PlFSekA==
Subject: [PATCH 12/41] net: phy: ca_phy: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:48 +0100
Message-Id: <20230319170317.27711-12-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/ca_phy.c | 11 ++---------
 drivers/net/phy/phy.c    |  3 ---
 include/phy.h            |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/ca_phy.c b/drivers/net/phy/ca_phy.c
index 9180a41111c..edef21867b0 100644
--- a/drivers/net/phy/ca_phy.c
+++ b/drivers/net/phy/ca_phy.c
@@ -104,7 +104,7 @@ static int rtl8211_probe(struct phy_device *phydev)
 }
=20
 /* Support for RTL8211 External PHY */
-static struct phy_driver rtl8211_external_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211_external) =3D {
 	.name =3D "Cortina RTL8211 External",
 	.uid =3D PHY_ID_RTL8211_EXT,
 	.mask =3D PHY_ID_MASK,
@@ -115,7 +115,7 @@ static struct phy_driver rtl8211_external_driver =3D {
 };
=20
 /* Support for RTL8211 Internal PHY */
-static struct phy_driver rtl8211_internal_driver =3D {
+U_BOOT_PHY_DRIVER(rtl8211_internal) =3D {
 	.name =3D "Cortina RTL8211 Inrernal",
 	.uid =3D PHY_ID_RTL8211_INT,
 	.mask =3D PHY_ID_MASK,
@@ -124,10 +124,3 @@ static struct phy_driver rtl8211_internal_driver =3D {
 	.probe =3D &rtl8211_probe,
 	.startup =3D &genphy_startup,
 };
-
-int phy_cortina_access_init(void)
-{
-	phy_register(&rtl8211_external_driver);
-	phy_register(&rtl8211_internal_driver);
-	return 0;
-}
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4b1fed1ff6f..4446902ab63 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -520,9 +520,6 @@ int phy_init(void)
 #ifdef CONFIG_PHY_CORTINA
 	phy_cortina_init();
 #endif
-#ifdef CONFIG_PHY_CORTINA_ACCESS
-	phy_cortina_access_init();
-#endif
 #ifdef CONFIG_PHY_DAVICOM
 	phy_davicom_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index cecfbe6968f..50a53982810 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -317,7 +317,6 @@ int gen10g_discover_mmds(struct phy_device *phydev);
=20
 int phy_mv88e61xx_init(void);
 int phy_cortina_init(void);
-int phy_cortina_access_init(void);
 int phy_davicom_init(void);
 int phy_et1011c_init(void);
 int phy_lxt_init(void);
--=20
2.39.2

