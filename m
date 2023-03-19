Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web11.21109.1679245545032351179
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaQ2FIoGmMea0G4ffBFMVgc7YEciVf19DWeF+S9F8ow=;
	b=bw131oNChW9GeVwkI3cjJrhinjk1L6JWWbvitFeeX/MSyTxoLBqda+Yru8LJULDrNPWXqF
	4z1GDarJudoPFJBxsXqqUtEyJY5YOrL/3/BTrj3+PyMh//WQj1p7dlLmnci779NvG9mQCm
	YmqvEbc5jtjWIeU3Re27BimvqBRakh3KoV3TsVInCJlPZ8evqp/QR6ce3yiNO/MjrmWl+2
	mdKs9Z5izQhP1EeBy1uZFL8PGm2+Kg4waw8i1bqrr3jqaD5zJp+REVhJRPfgdYjpqFFhGF
	PmGj36+bZz1qnLXC8MyHO9z0XYTGghH4JoxCrHMPK0Cffglc6XeBLHoQEdqcbw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaQ2FIoGmMea0G4ffBFMVgc7YEciVf19DWeF+S9F8ow=;
	b=ojniq4/4TVXpx0+dqlKeJuXHsqvUQuhHzET5MxoPrRoNiJ2X2Ha5Qzf4nlKD9Qa6XNEO29
	n60YdWR+khjXB6cyNLfgO8+ormlfcvHdSSBlpIn+bKi1DrRiM0sEEAhzO2VxNTOLBiHF9y
	5TJCd9sQcPTaaBivfVOrMLTNXToWF1/hQYH5VJFmQk9cvssSvxKEqVimnQmfGYgSmUI5m0
	kJRNQJmihOISxgVdeZyDXo4CcAmV/P/y5SVQzYioOp5ZrgdyrKDx8JGQ81vcgN3oQTUWI9
	vLE9387rQMYQPTd7tcRHiTdgxhm8IytSJhv/XcIeAR15f/QPB3/9x++7BLyISQ==
Subject: [PATCH 36/41] net: phy: genphy: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:03:12 +0100
Message-Id: <20230319170317.27711-36-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/phy.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9d5d1494616..b1e9861c6f3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -451,7 +451,7 @@ int genphy_shutdown(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver genphy_driver =3D {
+U_BOOT_PHY_DRIVER(genphy) =3D {
 	.uid		=3D 0xffffffff,
 	.mask		=3D 0xffffffff,
 	.name		=3D "Generic PHY",
@@ -463,11 +463,6 @@ static struct phy_driver genphy_driver =3D {
 	.shutdown	=3D genphy_shutdown,
 };
=20
-static int genphy_init(void)
-{
-	return phy_register(&genphy_driver);
-}
-
 static LIST_HEAD(phy_drivers);
=20
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
@@ -514,8 +509,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-	genphy_init();
-
 	return 0;
 }
=20
@@ -576,7 +569,7 @@ static struct phy_driver *generic_for_phy(struct phy_de=
vice *phydev)
 		return &gen10g_driver;
 #endif
=20
-	return &genphy_driver;
+	return ll_entry_get(struct phy_driver, genphy, phy_driver);
 }
=20
 static struct phy_driver *get_phy_driver(struct phy_device *phydev)
--=20
2.39.2

