Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mx.groups.io with SMTP id smtpd.web12.31407.1612171669770624816
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Feb 2021 01:27:50 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210201092747epoutp0391b31f0e6a21a8744d033ee5a7b0f712~flZbvKUZ80499704997epoutp03W
	for <u-boot-amlogic@groups.io>; Mon,  1 Feb 2021 09:27:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210201092747epoutp0391b31f0e6a21a8744d033ee5a7b0f712~flZbvKUZ80499704997epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1612171667;
	bh=uTqv2MUoXg0enEK1VRmEwPfKeDY7DfVHiVFxVf3isNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBVb+CT6krwqivSqp0y0qhpS56NandpxoXb4DBed6NCCvztzMiTvoO/DG38D62YaW
	 jBrxMMDF2No8OZvajUtzoy+LBuc7jRpr87300iIv30DejCDahO9ewqEC0hR1K8VJ8w
	 XxaxdAUbbqxU1jL2LP/6AtBddTNVHcZgfaOb+Hro=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/3] mmc: rockchip_dw_mmc: use mmc_pwrseq instead of rockchip_mmc_pwrseq
Date: Mon,  1 Feb 2021 18:28:06 +0900
Message-Id: <20210201092806.14314-4-jh80.chung@samsung.com>
In-Reply-To: <20210201092806.14314-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <20210201092806.14314-1-jh80.chung@samsung.com>
	<CGME20210201092741epcas1p2d6b484568480f419e9c7656ab4786621@epcas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, narmstrong@baylibre.com, sjg@chromium.org, kever.yang@rock-chips.com, yangbo.lu@nxp.com, faiz_abbas@ti.com, u-boot-amlogic@groups.io, philipp.tomsich@theobroma-systems.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Use mmc_pwrseq instead of rockchip_mmc_pwrseq.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/rockchip_dw_mmc.c | 41 +++--------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.=
c
index 1be3c1741fd4..0664f6e5aef4 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -136,12 +136,11 @@ static int rockchip_dwmmc_probe(struct udevice *dev=
)
=20
 	host->fifo_mode =3D priv->fifo_mode;
=20
-#ifdef CONFIG_PWRSEQ
+#ifdef CONFIG_MMC_PWRSEQ
 	/* Enable power if needed */
-	ret =3D uclass_get_device_by_phandle(UCLASS_PWRSEQ, dev, "mmc-pwrseq",
-					   &pwr_dev);
+	ret =3D mmc_pwrseq_get_power(dev, &plat->cfg);
 	if (!ret) {
-		ret =3D pwrseq_set_power(pwr_dev, true);
+		ret =3D pwrseq_set_power(&plat->cfg->pwr_dev, true);
 		if (ret)
 			return ret;
 	}
@@ -182,37 +181,3 @@ U_BOOT_DRIVER(rockchip_rk3288_dw_mshc) =3D {
=20
 DM_DRIVER_ALIAS(rockchip_rk3288_dw_mshc, rockchip_rk3328_dw_mshc)
 DM_DRIVER_ALIAS(rockchip_rk3288_dw_mshc, rockchip_rk3368_dw_mshc)
-
-#ifdef CONFIG_PWRSEQ
-static int rockchip_dwmmc_pwrseq_set_power(struct udevice *dev, bool ena=
ble)
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
-static const struct pwrseq_ops rockchip_dwmmc_pwrseq_ops =3D {
-	.set_power	=3D rockchip_dwmmc_pwrseq_set_power,
-};
-
-static const struct udevice_id rockchip_dwmmc_pwrseq_ids[] =3D {
-	{ .compatible =3D "mmc-pwrseq-emmc" },
-	{ }
-};
-
-U_BOOT_DRIVER(rockchip_dwmmc_pwrseq_drv) =3D {
-	.name		=3D "mmc_pwrseq_emmc",
-	.id		=3D UCLASS_PWRSEQ,
-	.of_match	=3D rockchip_dwmmc_pwrseq_ids,
-	.ops		=3D &rockchip_dwmmc_pwrseq_ops,
-};
-#endif
--=20
2.29.0

