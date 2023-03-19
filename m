Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web10.21367.1679245463110367301
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulnwCWu8dDCieVkPx0QiaRFitV2IxticRnu1CvUvDBE=;
	b=naoa9NzRDlfYJnoRy42s2dU8dOsIjzM2nEaJXwlwXgMilb79ypyGHtiMD1A1Nkgn+jkkxe
	nvTgxTZIONQAesq3PoJ7QfufnWn74pHs8y015XHv996PHD6J6cnOLkrL7L+Pzyc4uHogM8
	+1Rl0xG8sS6QLevsAw9tKKQQRHDC9Vn9hOER1Jr++Zuey+HG75SBg/yjfj1rn2YJDgTFZb
	5CFq4GzPLaI9ZxpUg30kWjyT47ue9AbAoD0TgCHI+3oEylrO6VPA3fXVUwDaxRKGaQ92HN
	m3XVjKwH0BfacpwhRf5PioUZeXQDd5A24oAUT7OrG+758U9ZSy8fb1jn/7JawA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulnwCWu8dDCieVkPx0QiaRFitV2IxticRnu1CvUvDBE=;
	b=HnjfMOTjCeWMGbo4tXtXGuSr7WOEcX16VJ/cVe5MhZFNXA/rm9+oa9nFugakP7TLkc3n4z
	VAaLD4NjOjJDyzHmxWju6SEEAg6Gng+1CODugGqctKIt25wzqlDXqBpNvxqgo5r+W63074
	wYZUzyfYg3V5PmVP1jPoHyTG1mya0luHXBwKq7jSZOvPop+Mh6K8Xyu/2TVYbjltAkF4L2
	XzpX2LV6sIFKhziP87MVReSA05T28l6Ua+CZ/4+m6NMBAOWniP1WjRa1mAEdolC66ESyze
	9VcsMZZIkVjzuCrdSF8k0xMDoEMcBjl3Ov4jE3/D4UlH4Dig4y/Ba/iXmJk+oQ==
Subject: [PATCH 06/41] net: phy: Iterate over both registered PHYs and struct phy_driver linker list
Date: Sun, 19 Mar 2023 18:02:42 +0100
Message-Id: <20230319170317.27711-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Introduce U_BOOT_PHY_DRIVER() macro which is used to add struct phy_driver
into a new linker list section containing all compiled in struct phy_driver
drivers. This is so far empty until PHY drivers are converted over to this
macro.

Iterate over both drivers registered using soon to be legacy phy_register()
as well as drivers in the new linker list when looking up a suitable PHY
driver. This way, PHY drivers can be converted over to the new macro one
driver at a time.

The relocation of callbacks for linker list based drivers now happens in
phy_init() call as the drivers are available at that point in time, and
phy_register() is not called for those drivers.

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
 drivers/net/phy/phy.c | 15 +++++++++++++++
 include/phy.h         |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 5097c32b829..50bfabbb765 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -495,6 +495,9 @@ static void phy_drv_reloc(struct phy_driver *drv)
 int phy_init(void)
 {
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
+	const int ll_n_ents =3D ll_entry_count(struct phy_driver, phy_driver);
+	struct phy_driver *drv, *ll_entry;
+
 	/*
 	 * The pointers inside phy_drivers also needs to be updated incase of
 	 * manual reloc, without which these points to some invalid
@@ -504,6 +507,11 @@ int phy_init(void)
=20
 	head->next =3D (void *)head->next + gd->reloc_off;
 	head->prev =3D (void *)head->prev + gd->reloc_off;
+
+	/* Perform manual relocation on linker list based PHY drivers */
+	ll_entry =3D ll_entry_start(struct phy_driver, phy_driver);
+	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++)
+		phy_drv_reloc(drv);
 #endif
=20
 #ifdef CONFIG_B53_SWITCH
@@ -660,6 +668,8 @@ static struct phy_driver *generic_for_phy(struct phy_de=
vice *phydev)
=20
 static struct phy_driver *get_phy_driver(struct phy_device *phydev)
 {
+	const int ll_n_ents =3D ll_entry_count(struct phy_driver, phy_driver);
+	struct phy_driver *ll_entry;
 	struct list_head *entry;
 	int phy_id =3D phydev->phy_id;
 	struct phy_driver *drv =3D NULL;
@@ -670,6 +680,11 @@ static struct phy_driver *get_phy_driver(struct phy_de=
vice *phydev)
 			return drv;
 	}
=20
+	ll_entry =3D ll_entry_start(struct phy_driver, phy_driver);
+	for (drv =3D ll_entry; drv !=3D ll_entry + ll_n_ents; drv++)
+		if ((drv->uid & drv->mask) =3D=3D (phy_id & drv->mask))
+			return drv;
+
 	/* If we made it here, there's no driver for this PHY */
 	return generic_for_phy(phydev);
 }
diff --git a/include/phy.h b/include/phy.h
index 87aa86c2e78..1eccfacec68 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -345,6 +345,13 @@ int phy_fixed_init(void);
 int phy_ncsi_init(void);
 int phy_xilinx_gmii2rgmii_init(void);
=20
+/**
+ * U_BOOT_PHY_DRIVER() - Declare a new U-Boot driver
+ * @__name: name of the driver
+ */
+#define U_BOOT_PHY_DRIVER(__name)					\
+	ll_entry_declare(struct phy_driver, __name, phy_driver)
+
 int board_phy_config(struct phy_device *phydev);
 int get_phy_id(struct mii_dev *bus, int addr, int devad, u32 *phy_id);
=20
--=20
2.39.2

