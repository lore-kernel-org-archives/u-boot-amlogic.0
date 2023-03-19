Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web10.21404.1679245550704905955
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjtyAuvcENnxlgmYHasIyfbJeEI2PMbyrRzxX/tZBp8=;
	b=uFES4EfIn6D+9fH4r/sdTQkM6HV1btpslXcnI8CUJtqYSzYJuXExJRaGXhsIzGN+U/Muqu
	xzwpKk3n/MRTN5yN0ttNYiUX2/pfoNPTfuEBJzAgfg+nnpJluaURveze5zETEfHVcO4jX/
	jpfMCte+Kaiww0QRbL9SIKvhzQSdK3G9Y1oB1NejK1MeBue8HVF6fRyKUKO1fx867A6+E+
	SXuss1op7eBwo2Pqk8EqN9Z4Y37M7ON2/pn1fEPStQPSkCEP+bSdW81qWViUyA/ymZU2nO
	+emUmhWF7u71dYn9dmHLB2JORUivdaXeA568WvpZYgRaeh18QDh2tz5WlWP9Qg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjtyAuvcENnxlgmYHasIyfbJeEI2PMbyrRzxX/tZBp8=;
	b=s7MgWz1kKU56KMSBwq9lx7MngYu4T9LFI6/J9dNfxcSuRATiKeDq4pojy1cV2Tkv5cLRfk
	hWgkOgS+7Bf/tTxK4Ye7/xyqytQ1u54MAAwDo9u0slx7v5cbYtcMT+m6c70ME6tKW1i5lI
	fSzG2nF54RpMgEmaJSUj3TPRegtrOYTzsvRVOwUl/LrLfJxJkSsAzGTY0RuGWNcy8Fyh2c
	8tjHXNIxudW3R7QSNBSfow7a47MU0R3Feqdunla3dBaG/DkI4UxUgNduYspAasmZDsh5Ex
	nbWeWYw2Kb6218GAzFdtzm+XNk9EIyjxoEeC/qFSZr8NgsCPBkoKuQM/4xtugQ==
Subject: [PATCH 38/41] net: phy: Drop static phy_drivers list
Date: Sun, 19 Mar 2023 18:03:14 +0100
Message-Id: <20230319170317.27711-38-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The static phy_drivers list is superseded by linker list of struct phy_driv=
ers
now that all drivers have been converted to the later. Drop the phy_drivers
list as well as list_head from struct phy_driver.

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
 drivers/net/phy/phy.c | 26 ++------------------------
 include/phy.h         |  2 --
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bd9c576f459..f4aa1f664cb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -463,8 +463,6 @@ U_BOOT_PHY_DRIVER(genphy) =3D {
 	.shutdown	=3D genphy_shutdown,
 };
=20
-static LIST_HEAD(phy_drivers);
-
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
 static void phy_drv_reloc(struct phy_driver *drv)
 {
@@ -493,16 +491,6 @@ int phy_init(void)
 	const int ll_n_ents =3D ll_entry_count(struct phy_driver, phy_driver);
 	struct phy_driver *drv, *ll_entry;
=20
-	/*
-	 * The pointers inside phy_drivers also needs to be updated incase of
-	 * manual reloc, without which these points to some invalid
-	 * pre reloc address and leads to invalid accesses, hangs.
-	 */
-	struct list_head *head =3D &phy_drivers;
-
-	head->next =3D (void *)head->next + gd->reloc_off;
-	head->prev =3D (void *)head->prev + gd->reloc_off;
-
 	/* Perform manual relocation on linker list based PHY drivers */
 	ll_entry =3D ll_entry_start(struct phy_driver, phy_driver);
 	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++)
@@ -514,9 +502,6 @@ int phy_init(void)
=20
 int phy_register(struct phy_driver *drv)
 {
-	INIT_LIST_HEAD(&drv->list);
-	list_add_tail(&drv->list, &phy_drivers);
-
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
 	phy_drv_reloc(drv);
 #endif
@@ -575,16 +560,9 @@ static struct phy_driver *generic_for_phy(struct phy_d=
evice *phydev)
 static struct phy_driver *get_phy_driver(struct phy_device *phydev)
 {
 	const int ll_n_ents =3D ll_entry_count(struct phy_driver, phy_driver);
-	struct phy_driver *ll_entry;
-	struct list_head *entry;
 	int phy_id =3D phydev->phy_id;
-	struct phy_driver *drv =3D NULL;
-
-	list_for_each(entry, &phy_drivers) {
-		drv =3D list_entry(entry, struct phy_driver, list);
-		if ((drv->uid & drv->mask) =3D=3D (phy_id & drv->mask))
-			return drv;
-	}
+	struct phy_driver *ll_entry;
+	struct phy_driver *drv;
=20
 	ll_entry =3D ll_entry_start(struct phy_driver, phy_driver);
 	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++)
diff --git a/include/phy.h b/include/phy.h
index 5f4967cb150..5e8ae5e29aa 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -125,8 +125,6 @@ struct phy_driver {
 	int (*write_mmd)(struct phy_device *phydev, int devad, int reg,
 			 u16 val);
=20
-	struct list_head list;
-
 	/* driver private data */
 	ulong data;
 };
--=20
2.39.2

