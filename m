Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.21066.1679245472860416628
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQ+/j+mBowqySqXCPSivz4YM9rHkOsR7tkWdFsT5koA=;
	b=jdbSS+QZWJU+yb9Hgg1/X7PhdPv9RAMZIB9WufWcJ0nNBQJZQq+gPZ5BJgCEdDwrdksU+W
	LGJL4ek3Uij3A9v7Mqk3P2SBVmLl1pHJfVcJOH5/9C5H3OtidhSTXloEqBWzea2lBFYuXq
	4yb+//xW7lzKriR9T7nt/MpOx5OEQi1sRcZC2tkLnveCRC+wjvyKGJfbfzcJ0U+5xR3rXL
	QL5NkSa3k+a94U61e2ykmBvsihfwOG69g84R65HNWPVnwtlMNphtnRPKxiZfipqIR7UEX5
	lvGB07iLUFBDZs2J8+SQri51CcJTlu1zl2I+R/IfMUbbB4QPrzSn1Ovc6ZsI1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQ+/j+mBowqySqXCPSivz4YM9rHkOsR7tkWdFsT5koA=;
	b=gSHItQ4qZQnBEQhbKhBUQNwFwyaD+3+iMpFPdht7EgtzQD+I7bS0GvuMXUjHLdLWdAIvuw
	OxuUEGndFTXmHm+O+xinCYgFFT6MhEBkdAKETiMImCWDACgXiT7m7nwnKWj57BBp6EWEGI
	JyrsfWFuRUmbPBHk9P6BbkGdIeexvWg9ZK+ZPMrdcpr29ArGX6tUJn/e52sTTWtQC6e7pK
	gF+iF6ICOV6M9xzTBn/3/USC9tvJ0zAp8D5pEyRXXqAVHFJ6FOAV66of7vwkyggRlyKGBJ
	fzSrjkGi5P45fSBalL0TeJz52lexL31NeCU2cGCCmrDHDf0q8RPu2belpVnVbA==
Subject: [PATCH 10/41] net: phy: b53: Convert to U_BOOT_PHY_DRIVER()
Date: Sun, 19 Mar 2023 18:02:46 +0100
Message-Id: <20230319170317.27711-10-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/b53.c | 9 +--------
 drivers/net/phy/phy.c | 3 ---
 include/phy.h         | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/b53.c b/drivers/net/phy/b53.c
index c706e2b9bde..26e8e2fe64f 100644
--- a/drivers/net/phy/b53.c
+++ b/drivers/net/phy/b53.c
@@ -612,7 +612,7 @@ static int b53_phy_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-static struct phy_driver b53_driver =3D {
+U_BOOT_PHY_DRIVER(b53) =3D {
 	.name =3D "Broadcom BCM53125",
 	.uid =3D 0x03625c00,
 	.mask =3D 0xfffffc00,
@@ -623,13 +623,6 @@ static struct phy_driver b53_driver =3D {
 	.shutdown =3D &genphy_shutdown,
 };
=20
-int phy_b53_init(void)
-{
-	phy_register(&b53_driver);
-
-	return 0;
-}
-
 int do_b53_reg_read(const char *name, int argc, char *const argv[])
 {
 	u8 page, offset, width;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 853302cf974..7a7762377b6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -514,9 +514,6 @@ int phy_init(void)
 		phy_drv_reloc(drv);
 #endif
=20
-#ifdef CONFIG_B53_SWITCH
-	phy_b53_init();
-#endif
 #ifdef CONFIG_MV88E61XX_SWITCH
 	phy_mv88e61xx_init();
 #endif
diff --git a/include/phy.h b/include/phy.h
index a1be1fbe1a1..88c9013f1f8 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -315,7 +315,6 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
=20
-int phy_b53_init(void);
 int phy_mv88e61xx_init(void);
 int phy_broadcom_init(void);
 int phy_cortina_init(void);
--=20
2.39.2

