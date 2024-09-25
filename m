Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A872CF64A2
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.6153.1727231071659029877
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Sep 2024 19:24:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=TK+cQoRD;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 49EB182BA7;
	Wed, 25 Sep 2024 04:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727231070;
	bh=AX9wfmLpE0Kv3hzTTU9pNvGTSXyR6dCnUNROqvr8izY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TK+cQoRDlL8AoPjA3Kp/Uuas5xEIleJxIW7zif7LJEYBT5I5rhaVuzej7JgfbmnZN
	 xCsQ5lHrLocVjBPikpe19KdXbuKkp5S+0Kn6ilQwDFh346LTnAEf5heO6enIcjsNdP
	 VYfoEYBtH+RZFRoy7Phbc2CXTgMZkVh1RB6PbAkZFRYRC3B+SdlTWstNLw5g6J3h8+
	 YDO87cRox+ub8LyloNe78aPTB9OCFNVp5XQHk8POVqmTFwsAWkxZ7GNmjQlWr5+0Fk
	 VjM1HapaEXu94ISrIAZozYgnXzhDrJfioYQXb96MeLkqJkMFB1KdZtmvGjIDxN8lc6
	 awOqx/JO6Nzrw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
	Ben Wolsieffer <benwolsieffer@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Kever Yang <kever.yang@rock-chips.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sam Day <me@samcday.com>,
	Simon Glass <sjg@chromium.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Tom Rini <trini@konsulko.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io,
	u-boot@dh-electronics.com,
	uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 5/5] power: regulator: Drop regulators_enable_boot_on/off()
Date: Wed, 25 Sep 2024 04:21:56 +0200
Message-ID: <20240925022314.714285-5-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925022314.714285-1-marex@denx.de>
References: <20240925022314.714285-1-marex@denx.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2403

Both regulators_enable_boot_on/off() are unused and superseded by
regulator uclass regulator_post_probe(). Remove both functions.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Rebase on current u-boot/next
---
 arch/arm/mach-rockchip/board.c                |  8 ------
 arch/arm/mach-snapdragon/board.c              |  1 -
 arch/arm/mach-tegra/board2.c                  |  3 ---
 board/Marvell/octeontx2_cn913x/board.c        |  5 ----
 .../amlogic/odroid-go-ultra/odroid-go-ultra.c |  2 --
 board/dhelectronics/dh_imx6/dh_imx6.c         |  2 --
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  2 --
 board/dhelectronics/dh_stm32mp1/board.c       |  2 --
 board/engicam/stm32mp1/stm32mp1.c             |  3 ---
 board/google/veyron/veyron.c                  |  4 ---
 board/samsung/common/exynos5-dt.c             |  4 ---
 board/st/stm32mp1/stm32mp1.c                  |  2 --
 drivers/power/regulator/regulator-uclass.c    | 10 --------
 include/power/regulator.h                     | 25 -------------------
 14 files changed, 73 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/boar=
d.c
index 0fdf9365b41..3fadf7e4122 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -202,14 +202,6 @@ int board_late_init(void)
=20
 int board_init(void)
 {
-	int ret;
-
-#ifdef CONFIG_DM_REGULATOR
-	ret =3D regulators_enable_boot_on(false);
-	if (ret)
-		debug("%s: Cannot enable boot on regulator\n", __func__);
-#endif
-
 	return 0;
 }
=20
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/=
board.c
index 0af297470a6..2ab2ceb5138 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -237,7 +237,6 @@ void __weak qcom_board_init(void)
=20
 int board_init(void)
 {
-	regulators_enable_boot_on(false);
 	show_psci_version();
 	qcom_of_fixup_nodes();
 	qcom_board_init();
diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 7971e3b68d5..5c5838629b2 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -187,9 +187,6 @@ int board_init(void)
 	warmboot_prepare_code(TEGRA_LP0_ADDR, TEGRA_LP0_SIZE);
 #endif
=20
-	/* Set up boot-on regulators */
-	regulators_enable_boot_on(_DEBUG);
-
 	return nvidia_board_init();
 }
=20
diff --git a/board/Marvell/octeontx2_cn913x/board.c b/board/Marvell/octeo=
ntx2_cn913x/board.c
index 3d20cfb2fab..3ffe15d42b8 100644
--- a/board/Marvell/octeontx2_cn913x/board.c
+++ b/board/Marvell/octeontx2_cn913x/board.c
@@ -23,11 +23,6 @@ int board_early_init_f(void)
=20
 int board_early_init_r(void)
 {
-	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
-		/* Check if any existing regulator should be turned down */
-		regulators_enable_boot_off(false);
-	}
-
 	return 0;
 }
=20
diff --git a/board/amlogic/odroid-go-ultra/odroid-go-ultra.c b/board/amlo=
gic/odroid-go-ultra/odroid-go-ultra.c
index 8f3f2045d74..f9412071737 100644
--- a/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
+++ b/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
@@ -16,7 +16,5 @@ int mmc_get_env_dev(void)
=20
 int board_init(void)
 {
-	regulators_enable_boot_on(_DEBUG);
-
 	return 0;
 }
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/=
dh_imx6/dh_imx6.c
index ada44e01424..f2b14bf701a 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -128,8 +128,6 @@ int board_init(void)
=20
 	setup_fec_clock();
=20
-	regulators_enable_boot_on(_DEBUG);
-
 	return 0;
 }
=20
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dh=
electronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index a389ab3c2d9..78aae412350 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -112,8 +112,6 @@ int dh_setup_mac_address(void)
=20
 int board_init(void)
 {
-	regulators_enable_boot_on(_DEBUG);
-
 	return 0;
 }
=20
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronic=
s/dh_stm32mp1/board.c
index 4f4f537fee5..24c5f37c12f 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -622,8 +622,6 @@ static void board_init_regulator_av96(void)
 static void board_init_regulator(void)
 {
 	board_init_regulator_av96();
-
-	regulators_enable_boot_on(_DEBUG);
 }
 #else
 static inline int board_get_regulator_buck3_nvm_uv_av96(int *uv)
diff --git a/board/engicam/stm32mp1/stm32mp1.c b/board/engicam/stm32mp1/s=
tm32mp1.c
index bc2af66d8e9..56557d56429 100644
--- a/board/engicam/stm32mp1/stm32mp1.c
+++ b/board/engicam/stm32mp1/stm32mp1.c
@@ -37,9 +37,6 @@ int checkboard(void)
 /* board dependent setup after realloc */
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_DM_REGULATOR))
-		regulators_enable_boot_on(_DEBUG);
-
 	return 0;
 }
=20
diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index bd8ce633772..674f19ba03c 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -57,10 +57,6 @@ static int veyron_init(void)
 	if (ret)
 		return log_msg_ret("s33", ret);
=20
-	ret =3D regulators_enable_boot_on(false);
-	if (ret)
-		return log_msg_ret("boo", ret);
-
 	return 0;
 }
 #endif
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exy=
nos5-dt.c
index 56862bcb34d..68edd1ec282 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -88,10 +88,6 @@ int exynos_power_init(void)
 	if (ret =3D=3D -ENODEV)
 		return 0;
=20
-	ret =3D regulators_enable_boot_on(false);
-	if (ret)
-		return ret;
-
 	ret =3D exynos_set_regulator("vdd_mif", 1100000);
 	if (ret)
 		return ret;
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 97532a8156f..d5e5e776d2a 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -665,8 +665,6 @@ int board_init(void)
 	if (board_is_stm32mp15x_dk2())
 		board_stm32mp15x_dk2_init();
=20
-	regulators_enable_boot_on(_DEBUG);
-
 	/*
 	 * sysconf initialisation done only when U-Boot is running in secure
 	 * done in TF-A for TFABOOT.
diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
index 34c2a36ec44..c491ba91017 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -524,16 +524,6 @@ static int regulator_post_probe(struct udevice *dev)
 	return 0;
 }
=20
-int regulators_enable_boot_on(bool verbose)
-{
-	return 0;
-}
-
-int regulators_enable_boot_off(bool verbose)
-{
-	return 0;
-}
-
 UCLASS_DRIVER(regulator) =3D {
 	.id		=3D UCLASS_REGULATOR,
 	.name		=3D "regulator",
diff --git a/include/power/regulator.h b/include/power/regulator.h
index 5363483d02a..8a914dfc74f 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -414,26 +414,6 @@ int regulator_get_mode(struct udevice *dev);
  */
 int regulator_set_mode(struct udevice *dev, int mode_id);
=20
-/**
- * regulators_enable_boot_on() - enable regulators needed for boot
- *
- * This enables all regulators which are marked to be on at boot time. T=
his
- * only works for regulators which don't have a range for voltage/curren=
t,
- * since in that case it is not possible to know which value to use.
- *
- * This effectively calls regulator_autoset() for every regulator.
- */
-int regulators_enable_boot_on(bool verbose);
-
-/**
- * regulators_enable_boot_off() - disable regulators needed for boot
- *
- * This disables all regulators which are marked to be off at boot time.
- *
- * This effectively does nothing.
- */
-int regulators_enable_boot_off(bool verbose);
-
 /**
  * regulator_autoset: setup the voltage/current on a regulator
  *
@@ -617,11 +597,6 @@ static inline int regulator_set_mode(struct udevice =
*dev, int mode_id)
 	return -ENOSYS;
 }
=20
-static inline int regulators_enable_boot_on(bool verbose)
-{
-	return -ENOSYS;
-}
-
 static inline int regulator_autoset(struct udevice *dev)
 {
 	return -ENOSYS;
--=20
2.45.2


