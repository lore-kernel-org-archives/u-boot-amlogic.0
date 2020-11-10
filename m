Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mx.groups.io with SMTP id smtpd.web08.24656.1604994648118243008
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 23:50:49 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201110075045epoutp0384c11d8b9c3355ef9183eae3e4ad0890~GFiBO4jJL0454204542epoutp03h
	for <u-boot-amlogic@groups.io>; Tue, 10 Nov 2020 07:50:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201110075045epoutp0384c11d8b9c3355ef9183eae3e4ad0890~GFiBO4jJL0454204542epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604994645;
	bh=lZac//jWOHHpVcrLfV4O49eUNZTn4awMP9W/GQDIf9o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ED69VRzXQDLDPeDYg2a1myNHNmyVNXVIIbBoyXr7AmWXWXMOtGdMzEiPL9HRYj6uS
	 pgiOk88fTEAHyXtrJalOXUooP0r9jkxrbnoyuBezK+Wr6mw8G7OUqDXJE9WQvDVS1n
	 s3hhENnQX2GoVErWWCZ8GiQFoJP0Ww/AV/D3fk80=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: meson_gx_mmc: control ddr_mode bit
Date: Tue, 10 Nov 2020 16:50:55 +0900
Message-Id: <20201110075055.25318-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <CGME20201110075040epcas1p1f3865c6fd9c7f3c561faf12ac760d277@epcas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, peng.fan@nxp.com, narmstrong@baylibre.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

EMMC_CFG register has a cfg_ddr bit(BIT[2]).
It needs to set when mmc is running to ddr mode.
Otherwise, its bit should be cleared.
CFG_DDR[2] - 1: DDR mode, 0: SDR mode

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
 drivers/mmc/meson_gx_mmc.c                | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include=
/asm/arch-meson/sd_emmc.h
index 1e9f8cf498b4..c2f77c7308ec 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -38,6 +38,7 @@
 #define   CFG_BUS_WIDTH_1		0
 #define   CFG_BUS_WIDTH_4		1
 #define   CFG_BUS_WIDTH_8		2
+#define   CFG_DDR_MODE			BIT(2)
 #define   CFG_BL_LEN_MASK		GENMASK(7, 4)
 #define   CFG_BL_LEN_SHIFT		4
 #define   CFG_BL_LEN_512		(9 << 4)
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 7c60e0566560..6fcf6c2ced27 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -90,6 +90,11 @@ static int meson_dm_mmc_set_ios(struct udevice *dev)
 	else
 		return -EINVAL;
=20
+	if (mmc->ddr_mode)
+		meson_mmc_cfg |=3D CFG_DDR_MODE;
+	else
+		meson_mmc_cfg &=3D ~CFG_DDR_MODE;
+
 	/* 512 bytes block length */
 	meson_mmc_cfg &=3D ~CFG_BL_LEN_MASK;
 	meson_mmc_cfg |=3D CFG_BL_LEN_512;
--=20
2.29.0

