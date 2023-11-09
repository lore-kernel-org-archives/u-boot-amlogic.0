Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1228C41535
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:10:33 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.927.1699549825074023355
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 09:10:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=Jeh6e6ij;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8F26612004D;
	Thu,  9 Nov 2023 20:10:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8F26612004D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699549823;
	bh=f/s8MpJ/kFTc/SI8ZkO9FPXCTM/vCbX645tShVIaa3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Jeh6e6ij8kD1LkJDAZQFRhhSM+krFyNnQJnGwKslhuzu+UcgQjCRPC1wUwlrZ0dU9
	 j/p0zaks+aAzGbZjTKZ9MwKh0eb4qt+OcHHN5NSBgRz1GRBM8+XSOuMorGiQ2j3EFV
	 NRANGJPdPI6vIBVk3UDGcgRx9WaH+PlUFjRrI7K9W5w6+ovcuLDZix/lfzNmFVZl5Y
	 7Ple3lsqbLeCuqMNta6hB+R2TR58X3znRsrP1JMLIAzTw/JNMic8mM/0fw0gOmb8gf
	 VDjWNKZpxbjLL+FcT+txm/YN4UAAeZFnycC9t27lKjdJwp1QD6w21MuYBz/p46q6Ay
	 4sa1hh1By/9Rw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  9 Nov 2023 20:10:23 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 20:10:23 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <kernel@sberdevices.ru>, <prusovigor@gmail.com>, Igor Prusov
	<ivprusov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, Anatolij
 Gustschin <agust@denx.de>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Balaji
 Prakash J <bjagadee@codeaurora.org>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Baruch Siach <baruch@tkos.co.il>,
	Bhupesh Sharma <bhupesh.linux@gmail.com>, Caleb Connolly
	<caleb.connolly@linaro.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Chris Morgan <macromorgan@hotmail.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Eugen Hristev
	<eugen.hristev@collabora.com>, Heiko Schocher <hs@denx.de>, Jaehoon Chung
	<jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joel
 Stanley <joel@jms.id.au>, Kever Yang <kever.yang@rock-chips.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Michael Trimarchi
	<michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Neha
 Malcom Francis <n-francis@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
	<sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese
	<sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
	<clamor95@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
	<u-boot-amlogic@groups.io>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] treewide: use linux/time.h for time conversion defines
Date: Thu, 9 Nov 2023 20:10:04 +0300
Message-ID: <20231109171004.193521-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109171004.193521-1-ivprusov@salutedevices.com>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181258 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 11:05:00 #22436988
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 17:10:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1856

Now that we have time conversion defines from in time.h there is no need
for each driver to define their own version.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 board/friendlyarm/nanopi2/onewire.c              |  5 +----
 drivers/clk/at91/clk-main.c                      |  2 +-
 drivers/i2c/stm32f7_i2c.c                        | 11 +++++------
 drivers/memory/stm32-fmc2-ebi.c                  |  5 ++---
 drivers/mmc/octeontx_hsmmc.h                     |  2 --
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  3 +--
 drivers/mtd/nand/raw/mxs_nand.c                  |  3 +--
 drivers/mtd/nand/raw/octeontx_nand.c             |  2 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c           |  5 ++---
 drivers/phy/meson-axg-mipi-dphy.c                |  3 +--
 drivers/phy/phy-core-mipi-dphy.c                 |  3 +--
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  3 +--
 drivers/pwm/pwm-aspeed.c                         |  3 +--
 drivers/pwm/pwm-at91.c                           |  2 +-
 drivers/pwm/pwm-cadence-ttc.c                    |  3 +--
 drivers/pwm/pwm-meson.c                          |  3 +--
 drivers/pwm/pwm-mtk.c                            |  3 +--
 drivers/pwm/pwm-ti-ehrpwm.c                      |  3 +--
 drivers/serial/serial_msm_geni.c                 |  3 +--
 drivers/spi/cadence_qspi.c                       |  3 +--
 drivers/spi/fsl_dspi.c                           |  4 +---
 drivers/ufs/cdns-platform.c                      |  3 +--
 drivers/usb/dwc3/core.c                          |  3 +--
 drivers/video/dw_mipi_dsi.c                      |  3 +--
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c    |  3 +--
 drivers/video/tegra20/tegra-dsi.c                |  4 +---
 drivers/watchdog/sunxi_wdt.c                     |  3 +--
 fs/ubifs/ubifs.h                                 |  1 -
 28 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/board/friendlyarm/nanopi2/onewire.c b/board/friendlyarm/nano=
pi2/onewire.c
index 56f0f2dfce..4f0b1e33c2 100644
--- a/board/friendlyarm/nanopi2/onewire.c
+++ b/board/friendlyarm/nanopi2/onewire.c
@@ -11,16 +11,13 @@
 #include <asm/arch/clk.h>
 #include <asm/arch/pwm.h>
 #include <i2c.h>
+#include <linux/time.h>
=20
 #include <irq_func.h>
=20
 #include <asm/arch/nexell.h>
 #include <asm/arch/nx_gpio.h>
=20
-#ifndef NSEC_PER_SEC
-#define NSEC_PER_SEC	1000000000L
-#endif
-
 #define SAMPLE_BPS		9600
 #define SAMPLE_IN_US	101		/* (1000000 / BPS) */
=20
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index b52d926f33..025c7a7aa2 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -17,6 +17,7 @@
 #include <linux/clk/at91_pmc.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/time.h>
 #include "pmc.h"
=20
 #define UBOOT_DM_CLK_AT91_MAIN_RC		"at91-main-rc-clk"
@@ -25,7 +26,6 @@
 #define UBOOT_DM_CLK_AT91_SAM9X5_MAIN		"at91-sam9x5-main-clk"
=20
 #define MOR_KEY_MASK		GENMASK(23, 16)
-#define USEC_PER_SEC		1000000UL
 #define SLOW_CLOCK_FREQ		32768
=20
 #define clk_main_parent_select(s)	(((s) & \
diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index b6c71789ee..eaa1d69289 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/printk.h>
+#include <linux/time.h>
=20
 /* STM32 I2C registers */
 struct stm32_i2c_regs {
@@ -121,8 +122,6 @@ struct stm32_i2c_regs {
 #define STM32_SCLH_MAX				BIT(8)
 #define STM32_SCLL_MAX				BIT(8)
=20
-#define STM32_NSEC_PER_SEC			1000000000L
-
 /**
  * struct stm32_i2c_spec - private i2c specification timing
  * @rate: I2C bus speed (Hz)
@@ -591,7 +590,7 @@ static int stm32_i2c_choose_solution(u32 i2cclk,
 				     struct stm32_i2c_timings *s)
 {
 	struct stm32_i2c_timings *v;
-	u32 i2cbus =3D DIV_ROUND_CLOSEST(STM32_NSEC_PER_SEC,
+	u32 i2cbus =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC,
 				       setup->speed_freq);
 	u32 clk_error_prev =3D i2cbus;
 	u32 clk_min, clk_max;
@@ -607,8 +606,8 @@ static int stm32_i2c_choose_solution(u32 i2cclk,
 	dnf_delay =3D setup->dnf * i2cclk;
=20
 	tsync =3D af_delay_min + dnf_delay + (2 * i2cclk);
-	clk_max =3D STM32_NSEC_PER_SEC / specs->rate_min;
-	clk_min =3D STM32_NSEC_PER_SEC / specs->rate_max;
+	clk_max =3D NSEC_PER_SEC / specs->rate_min;
+	clk_min =3D NSEC_PER_SEC / specs->rate_max;
=20
 	/*
 	 * Among Prescaler possibilities discovered above figures out SCL Low
@@ -686,7 +685,7 @@ static int stm32_i2c_compute_timing(struct stm32_i2c_=
priv *i2c_priv,
 	const struct stm32_i2c_spec *specs;
 	struct stm32_i2c_timings *v, *_v;
 	struct list_head solutions;
-	u32 i2cclk =3D DIV_ROUND_CLOSEST(STM32_NSEC_PER_SEC, setup->clock_src);
+	u32 i2cclk =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, setup->clock_src);
 	int ret;
=20
 	specs =3D get_specs(setup->speed_freq);
diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-=
ebi.c
index 212bb4f5dc..a722a3836f 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
+#include <linux/time.h>
=20
 /* FMC2 Controller Registers */
 #define FMC2_BCR1			0x0
@@ -90,8 +91,6 @@
 #define FMC2_BTR_DATLAT_MAX		0xf
 #define FMC2_PCSCNTR_CSCOUNT_MAX	0xff
=20
-#define FMC2_NSEC_PER_SEC		1000000000L
-
 enum stm32_fmc2_ebi_bank {
 	FMC2_EBI1 =3D 0,
 	FMC2_EBI2,
@@ -279,7 +278,7 @@ static u32 stm32_fmc2_ebi_ns_to_clock_cycles(struct s=
tm32_fmc2_ebi *ebi,
 					     int cs, u32 setup)
 {
 	unsigned long hclk =3D clk_get_rate(&ebi->clk);
-	unsigned long hclkp =3D FMC2_NSEC_PER_SEC / (hclk / 1000);
+	unsigned long hclkp =3D NSEC_PER_SEC / (hclk / 1000);
=20
 	return DIV_ROUND_UP(setup * 1000, hclkp);
 }
diff --git a/drivers/mmc/octeontx_hsmmc.h b/drivers/mmc/octeontx_hsmmc.h
index 70844b1cba..9849121f17 100644
--- a/drivers/mmc/octeontx_hsmmc.h
+++ b/drivers/mmc/octeontx_hsmmc.h
@@ -32,8 +32,6 @@
  */
 #define MMC_TIMEOUT_SHORT		20
=20
-#define NSEC_PER_SEC			1000000000L
-
 #define MAX_NO_OF_TAPS			64
=20
 #define EXT_CSD_POWER_CLASS		187	/* R/W */
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
index fa962ba591..5c0265ccf5 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -64,6 +64,7 @@
 #include <linux/mfd/syscon/atmel-smc.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/mtd.h>
+#include <linux/time.h>
 #include <mach/at91_sfr.h>
 #include <nand.h>
 #include <regmap.h>
@@ -71,8 +72,6 @@
=20
 #include "pmecc.h"
=20
-#define NSEC_PER_SEC    1000000000L
-
 #define ATMEL_HSMC_NFC_CFG			0x0
 #define ATMEL_HSMC_NFC_CFG_SPARESIZE(x)		(((x) / 4) << 24)
 #define ATMEL_HSMC_NFC_CFG_SPARESIZE_MASK	GENMASK(30, 24)
diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_n=
and.c
index 65eab4c808..fd65772af8 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/math64.h>
=20
@@ -52,8 +53,6 @@
 #endif
=20
 #define	MXS_NAND_BCH_TIMEOUT			10000
-#define	USEC_PER_SEC				1000000
-#define	NSEC_PER_SEC				1000000000L
=20
 #define TO_CYCLES(duration, period) DIV_ROUND_UP_ULL(duration, period)
=20
diff --git a/drivers/mtd/nand/raw/octeontx_nand.c b/drivers/mtd/nand/raw/=
octeontx_nand.c
index 65a03d22c1..3b20685fac 100644
--- a/drivers/mtd/nand/raw/octeontx_nand.c
+++ b/drivers/mtd/nand/raw/octeontx_nand.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/nand_bch.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/types.h>
@@ -291,7 +292,6 @@ union ndf_cmd {
 #define OCTEONTX_NAND_DRIVER_NAME	"octeontx_nand"
=20
 #define NDF_TIMEOUT		1000	/** Timeout in ms */
-#define USEC_PER_SEC		1000000	/** Linux compatibility */
 #ifndef NAND_MAX_CHIPS
 # define NAND_MAX_CHIPS		8	/** Linux compatibility */
 #endif
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/ra=
w/stm32_fmc2_nand.c
index 64be6486b4..3528824575 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/printk.h>
+#include <linux/time.h>
=20
 /* Bad block marker length */
 #define FMC2_BBM_LEN			2
@@ -127,8 +128,6 @@
 #define FMC2_BCHDSR4_EBP7		GENMASK(12, 0)
 #define FMC2_BCHDSR4_EBP8		GENMASK(28, 16)
=20
-#define FMC2_NSEC_PER_SEC		1000000000L
-
 #define FMC2_TIMEOUT_5S			5000000
=20
 enum stm32_fmc2_ecc {
@@ -603,7 +602,7 @@ static void stm32_fmc2_nfc_calc_timings(struct nand_c=
hip *chip,
 	struct stm32_fmc2_nand *nand =3D to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *tims =3D &nand->timings;
 	unsigned long hclk =3D clk_get_rate(&nfc->clk);
-	unsigned long hclkp =3D FMC2_NSEC_PER_SEC / (hclk / 1000);
+	unsigned long hclkp =3D NSEC_PER_SEC / (hclk / 1000);
 	unsigned long timing, tar, tclr, thiz, twait;
 	unsigned long tset_mem, tset_att, thold_mem, thold_att;
=20
diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mi=
pi-dphy.c
index cf2a1cd14c..a69b6c9759 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -25,6 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/bitfield.h>
+#include <linux/time.h>
=20
 /* [31] soft reset for the phy.
  *		1: reset. 0: dessert the reset.
@@ -170,8 +171,6 @@
 #define MIPI_DSI_TEST_CTRL0				0x3c
 #define MIPI_DSI_TEST_CTRL1				0x40
=20
-#define NSEC_PER_MSEC	1000000L
-
 struct phy_meson_axg_mipi_dphy_priv {
 	struct regmap *regmap;
 #if CONFIG_IS_ENABLED(CLK)
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi=
-dphy.c
index ba5f648612..bb61816add 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -6,11 +6,10 @@
=20
 #include <common.h>
 #include <div64.h>
+#include <linux/time.h>
=20
 #include <phy-mipi-dphy.h>
=20
-#define PSEC_PER_SEC	1000000000000LL
-
 /*
  * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
  * from the valid ranges specified in Section 6.9, Table 14, Page 41
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/p=
hy/rockchip/phy-rockchip-inno-dsidphy.c
index 9ed7af0d6e..5be76e0533 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -15,6 +15,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
+#include <linux/time.h>
 #include <phy-mipi-dphy.h>
 #include <reset.h>
=20
@@ -186,8 +187,6 @@
 #define DSI_PHY_STATUS				0xb0
 #define PHY_LOCK				BIT(0)
=20
-#define PSEC_PER_SEC				1000000000000LL
-
 #define msleep(a)				udelay(a * 1000)
=20
 enum phy_max_rate {
diff --git a/drivers/pwm/pwm-aspeed.c b/drivers/pwm/pwm-aspeed.c
index ba98641c86..b03472d234 100644
--- a/drivers/pwm/pwm-aspeed.c
+++ b/drivers/pwm/pwm-aspeed.c
@@ -49,6 +49,7 @@
 #include <dm/device_compat.h>
 #include <linux/math64.h>
 #include <linux/bitfield.h>
+#include <linux/time.h>
 #include <asm/io.h>
=20
 /* The channel number of Aspeed pwm controller */
@@ -77,8 +78,6 @@
 /* PWM fixed value */
 #define PWM_ASPEED_FIXED_PERIOD 0xff
=20
-#define NSEC_PER_SEC			1000000000L
-
 struct aspeed_pwm_priv {
 	struct clk clk;
 	struct regmap *regmap;
diff --git a/drivers/pwm/pwm-at91.c b/drivers/pwm/pwm-at91.c
index 95597aee55..3ff1fb6d5c 100644
--- a/drivers/pwm/pwm-at91.c
+++ b/drivers/pwm/pwm-at91.c
@@ -14,11 +14,11 @@
 #include <dm.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/time.h>
 #include <pwm.h>
=20
 #define PERIOD_BITS 16
 #define PWM_MAX_PRES 10
-#define NSEC_PER_SEC 1000000000L
=20
 #define PWM_ENA 0x04
 #define PWM_CHANNEL_OFFSET 0x20
diff --git a/drivers/pwm/pwm-cadence-ttc.c b/drivers/pwm/pwm-cadence-ttc.=
c
index dc3b314b0c..d9f6736a7a 100644
--- a/drivers/pwm/pwm-cadence-ttc.c
+++ b/drivers/pwm/pwm-cadence-ttc.c
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
+#include <linux/time.h>
 #include <dm/device_compat.h>
=20
 #define CLOCK_CONTROL		0
@@ -37,8 +38,6 @@
 #define COUNTER_INTERVAL_ENABLE		BIT(1)
 #define COUNTER_COUNTING_DISABLE	BIT(0)
=20
-#define NSEC_PER_SEC	1000000000L
-
 #define TTC_REG(reg, channel) ((reg) + (channel) * sizeof(u32))
 #define TTC_CLOCK_CONTROL(reg, channel) \
 	TTC_REG((reg) + CLOCK_CONTROL, (channel))
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2311910a63..60959720da 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -26,8 +26,7 @@
 #include <linux/math64.h>
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
-
-#define NSEC_PER_SEC 1000000000L
+#include <linux/time.h>
=20
 #define REG_PWM_A		0x0
 #define REG_PWM_B		0x4
diff --git a/drivers/pwm/pwm-mtk.c b/drivers/pwm/pwm-mtk.c
index 11e7444019..ad845ed966 100644
--- a/drivers/pwm/pwm-mtk.c
+++ b/drivers/pwm/pwm-mtk.c
@@ -12,6 +12,7 @@
 #include <div64.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/time.h>
=20
 /* PWM registers and bits definitions */
 #define PWMCON			0x00
@@ -27,8 +28,6 @@
 #define PWM_CLK_DIV_MAX		7
 #define MAX_PWM_NUM		8
=20
-#define NSEC_PER_SEC 1000000000L
-
 enum mtk_pwm_reg_ver {
 	PWM_REG_V1,
 	PWM_REG_V2,
diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
index f09914519b..fefa3c65ec 100644
--- a/drivers/pwm/pwm-ti-ehrpwm.c
+++ b/drivers/pwm/pwm-ti-ehrpwm.c
@@ -14,8 +14,7 @@
 #include <dm/device_compat.h>
 #include <pwm.h>
 #include <asm/io.h>
-
-#define NSEC_PER_SEC			        1000000000L
+#include <linux/time.h>
=20
 /* Time base module registers */
 #define TI_EHRPWM_TBCTL				0x00
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm=
_geni.c
index 78fd9389c0..b8bc61451a 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -13,14 +13,13 @@
 #include <dm.h>
 #include <errno.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 #include <misc.h>
 #include <serial.h>
=20
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT	160
=20
-#define USEC_PER_SEC	1000000L
-
 /* Registers*/
 #define GENI_FORCE_DEFAULT_REG	0x20
 #define GENI_SER_M_CLK_CFG	0x48
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index cc3a54f295..b0c656dbb4 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -18,12 +18,11 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
+#include <linux/time.h>
 #include <zynqmp_firmware.h>
 #include "cadence_qspi.h"
 #include <dt-bindings/power/xlnx-versal-power.h>
=20
-#define NSEC_PER_SEC			1000000000L
-
 #define CQSPI_STIG_READ			0
 #define CQSPI_STIG_WRITE		1
 #define CQSPI_READ			2
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index f8ec268812..89907cbbb0 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -27,9 +27,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
-
-/* linux/include/time.h */
-#define NSEC_PER_SEC	1000000000L
+#include <linux/time.h>
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index 1e62e252e7..8ebcb51634 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -13,11 +13,10 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/time.h>
=20
 #include "ufs.h"
=20
-#define USEC_PER_SEC	1000000L
-
 #define CDNS_UFS_REG_HCLKDIV	0xFC
 #define CDNS_UFS_REG_PHY_XCFGD1	0x113C
=20
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ca9d09824..f0c4aab6b9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -31,6 +31,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/bitfield.h>
 #include <linux/math64.h>
+#include <linux/time.h>
=20
 #include "core.h"
 #include "gadget.h"
@@ -38,8 +39,6 @@
=20
 #include "linux-compat.h"
=20
-#define NSEC_PER_SEC	1000000000L
-
 static LIST_HEAD(dwc3_list);
 /* ---------------------------------------------------------------------=
----- */
=20
diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index 22fef7e882..a7e0784596 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/time.h>
 #include <video_bridge.h>
=20
 #define HWVER_131			0x31333100	/* IP version 1.31 */
@@ -214,8 +215,6 @@
 #define PHY_STATUS_TIMEOUT_US		10000
 #define CMD_PKT_STATUS_TIMEOUT_US	20000
=20
-#define MSEC_PER_SEC			1000
-
 struct dw_mipi_dsi {
 	struct mipi_dsi_host dsi_host;
 	struct mipi_dsi_device *device;
diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/vide=
o/rockchip/dw_mipi_dsi_rockchip.c
index 1a5ab781e3..5e75b6ec68 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -30,12 +30,11 @@
 #include <asm/io.h>
 #include <dm/device-internal.h>
 #include <linux/bitops.h>
+#include <linux/time.h>
=20
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
=20
-#define USEC_PER_SEC	1000000L
-
 /*
  * DSI wrapper registers & bit definitions
  * Note: registers are named as in the Reference Manual
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/te=
gra-dsi.c
index b4cf4fad5e..a48f9c85d0 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -14,6 +14,7 @@
 #include <panel.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/time.h>
 #include <power/regulator.h>
=20
 #include <asm/gpio.h>
@@ -24,9 +25,6 @@
=20
 #include "mipi-phy.h"
=20
-#define USEC_PER_SEC	1000000L
-#define NSEC_PER_SEC	1000000000L
-
 struct tegra_dsi_priv {
 	struct mipi_dsi_host host;
 	struct mipi_dsi_device device;
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index b40a1d29ca..8eeac93576 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -9,8 +9,7 @@
 #include <wdt.h>
 #include <asm/io.h>
 #include <linux/delay.h>
-
-#define MSEC_PER_SEC		1000
+#include <linux/time.h>
=20
 #define WDT_MAX_TIMEOUT		16
 #define WDT_TIMEOUT_MASK	0xf
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 67b13c83b5..b4e761c366 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -68,7 +68,6 @@ struct page {
 void iput(struct inode *inode);
=20
 /* linux/include/time.h */
-#define NSEC_PER_SEC	1000000000L
 #define get_seconds()	0
 #define CURRENT_TIME_SEC	((struct timespec) { get_seconds(), 0 })
=20
--=20
2.34.1


