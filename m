Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web09.31240.1612171669773092752
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Feb 2021 01:27:50 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210201092746epoutp02a51a5e16bfa4ca2dd5d9f3af37c29ba4~flZbn8xeR3221732217epoutp02e
	for <u-boot-amlogic@groups.io>; Mon,  1 Feb 2021 09:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210201092746epoutp02a51a5e16bfa4ca2dd5d9f3af37c29ba4~flZbn8xeR3221732217epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1612171667;
	bh=bcEIN9Tyom6AHt8/0qXMsppDBZCQfvVCJBoEQriPY04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJHw6O4uVG0MhWJAucWGkACwGOK8q8Kh/FUpA3XNXmVKRSrhORe4J+KxCZx/yvHQ3
	 CWBeKlrXucjYZTR8KQVX6QDGIYn+Gf5XXAddPNVrMnBWdE/CGISt3pjvgCkSVVk2Tw
	 xI3BHv+W5sj5J2st04+a959E0qv8mKz+lGEivZIw=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/3] mmc: meson_gx_mmc: use mmc_pwrseq instead of meson_mmc_pwrseq
Date: Mon,  1 Feb 2021 18:28:05 +0900
Message-Id: <20210201092806.14314-3-jh80.chung@samsung.com>
In-Reply-To: <20210201092806.14314-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <20210201092806.14314-1-jh80.chung@samsung.com>
	<CGME20210201092741epcas1p1d0ca675d8c002bcac09d9add543f938b@epcas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, narmstrong@baylibre.com, sjg@chromium.org, kever.yang@rock-chips.com, yangbo.lu@nxp.com, faiz_abbas@ti.com, u-boot-amlogic@groups.io, philipp.tomsich@theobroma-systems.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Use mmc_pwrseq instead of meson_mmc_pwrseq.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/meson_gx_mmc.c | 41 +++-----------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 8b6dfa3b9603..0ef140562cd2 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -292,12 +292,11 @@ static int meson_mmc_probe(struct udevice *dev)
=20
 	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
=20
-#ifdef CONFIG_PWRSEQ
+#ifdef CONFIG_MMC_PWRSEQ
 	/* Enable power if needed */
-	ret =3D uclass_get_device_by_phandle(UCLASS_PWRSEQ, dev, "mmc-pwrseq",
-					   &pwr_dev);
+	ret =3D mmc_pwrseq_get_power(dev, cfg);
 	if (!ret) {
-		ret =3D pwrseq_set_power(pwr_dev, true);
+		ret =3D pwrseq_set_power(cfg->pwr_dev, true);
 		if (ret)
 			return ret;
 	}
@@ -342,37 +341,3 @@ U_BOOT_DRIVER(meson_mmc) =3D {
 	.of_to_plat =3D meson_mmc_of_to_plat,
 	.plat_auto	=3D sizeof(struct meson_mmc_plat),
 };
-
-#ifdef CONFIG_PWRSEQ
-static int meson_mmc_pwrseq_set_power(struct udevice *dev, bool enable)
-{
-	struct gpio_desc reset;
-	int ret;
-
-	ret =3D gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OU=
T);
-	if (ret)
-		return ret;
-	dm_gpio_set_value(&reset, 1);
-	udelay(1);
-	dm_gpio_set_value(&reset, 0);
-	udelay(200);
-
-	return 0;
-}
-
-static const struct pwrseq_ops meson_mmc_pwrseq_ops =3D {
-	.set_power	=3D meson_mmc_pwrseq_set_power,
-};
-
-static const struct udevice_id meson_mmc_pwrseq_ids[] =3D {
-	{ .compatible =3D "mmc-pwrseq-emmc" },
-	{ }
-};
-
-U_BOOT_DRIVER(meson_mmc_pwrseq_drv) =3D {
-	.name		=3D "mmc_pwrseq_emmc",
-	.id		=3D UCLASS_PWRSEQ,
-	.of_match	=3D meson_mmc_pwrseq_ids,
-	.ops		=3D &meson_mmc_pwrseq_ops,
-};
-#endif
--=20
2.29.0

