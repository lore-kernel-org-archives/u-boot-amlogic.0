Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web11.6521.1604891545012185220
 for <u-boot-amlogic@groups.io>;
 Sun, 08 Nov 2020 19:12:26 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201109031222epoutp02ef50d02dc7d3cd0b717fab64bf3dbddb~FuFrA079C0654806548epoutp02y
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 03:12:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201109031222epoutp02ef50d02dc7d3cd0b717fab64bf3dbddb~FuFrA079C0654806548epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604891542;
	bh=oOSwfhjMSvCH7WAf+SQaDXy+VmAObHwSB3l8Sf8XbJc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TLgsGz/UeHsCPaLrYsJ95hBNEJ+1K+eC98PSKnjXZHf6+1cH0LikumNO6uBVqZWGT
	 YPJ6fzRt3GSZUk+p8nS9QJ0rtzQk2SfoyDqKZEjEiSFFfn7IdRoQLImjpHUwT1bNve
	 T1LexNlXWoMsVj2zWIZykhtLnlaQg36tFSGamDK0=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
Date: Mon,  9 Nov 2020 12:12:33 +0900
Message-Id: <20201109031233.25320-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, narmstrong@baylibre.com, peng.fan@nxp.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Core clock phase value is changed from 180' to 270'.
It's more stable than before.
- Odroidn-N2/C4 : Working fine with 52MHz
- VIM3 : Working fine with 52MHz

Before this patch, Odroid-C4 doesn't work fine with 52MHz.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 719dd1e5e570..7c60e0566560 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	}
 	clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
=20
-	/* 180 phase core clock */
-	meson_mmc_clk |=3D CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
+	/*
+	 * Clock Phase needs to set a proper value.
+	 * It can be changed to other value.
+	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
+	 * set to them by default.
+	 */
+	/* Core Clock Phase */
+	meson_mmc_clk |=3D CLK_CO_PHASE_270;
+
+	/* TX Clock Phase */
 	meson_mmc_clk |=3D CLK_TX_PHASE_000;
=20
 	/* clock settings */
--=20
2.29.0

