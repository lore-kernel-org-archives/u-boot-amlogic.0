Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.11768.1609250348424535976
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 05:59:08 -0800
Received: by mail-wr1-f44.google.com with SMTP id c5so14721251wrp.6
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+h3LSWGKq+fQ7Uy3epFoH7GXkRmBmGRwCMjftZSusg0=;
        b=RATw2YmHsDnLIYUohNI5W3Xmydrtn1X6twx5O+Yv79KISvq9Qmha9DSHJA4BZ2LrC+
         3R/rBxeJSs7/uGd5JJoIYVouExIkewL0VpTbs9CP1cGqKtEurNLjS7YBJ130cRAyKrp6
         ey6kni6j/tqv1L0qWppm3tnPydPCAmviU5DmaFsrYggdll4OsNstbvvZN1UDPI+FBLc7
         bXHs3POFiBnFqlIwzEl90p7mEEje0MpPWCQ36KELdQSjRIkUqDB2nUQYAVjnQ3J4ikMk
         dGnkk1LqumWwBfk7TNuerFRYTb01aAt6pw/G2OD+VCeAklAYrjy8sCDUa7Whca7zipHP
         eKLA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/4] phy: dphy: Add configuration helpers
Date: Tue, 29 Dec 2020 14:58:58 +0100
Message-Id: <20201229135901.30090-2-narmstrong@baylibre.com>
In-Reply-To: <20201229135901.30090-1-narmstrong@baylibre.com>
References: <20201229135901.30090-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The MIPI D-PHY spec defines default values and boundaries for most of the
parameters it defines. Introduce helpers to help drivers get meaningful
values based on their current parameters, and validate the boundaries of
these parameters if needed.

These helpers and header are taken from Linux commit 9123e3a74ec7 ("Linux 5.9-rc1").

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/Kconfig              |   5 +
 drivers/phy/Makefile             |   1 +
 drivers/phy/phy-core-mipi-dphy.c | 161 ++++++++++++++++++
 include/phy-mipi-dphy.h          | 284 +++++++++++++++++++++++++++++++
 4 files changed, 451 insertions(+)
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 include/phy-mipi-dphy.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d12a6b02ad..8d9da17b53 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -59,6 +59,11 @@ config SPL_NOP_PHY
 	  This is useful when a driver uses the PHY framework but no real PHY
 	  hardware exists.
 
+config MIPI_DPHY_HELPERS
+	bool "MIPI D-PHY support helpers"
+	help
+	  Provides a number of helpers a core functions for MIPI D-PHY drivers.
+
 config BCM6318_USBH_PHY
 	bool "BCM6318 USBH PHY support"
 	depends on PHY && ARCH_BMIPS
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 45a7fe5b56..9024002822 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(SPL_)PHY) += phy-uclass.o
 obj-$(CONFIG_$(SPL_)NOP_PHY) += nop-phy.o
+obj-$(CONFIG_MIPI_DPHY_HELPERS) += phy-core-mipi-dphy.o
 obj-$(CONFIG_BCM6318_USBH_PHY) += bcm6318-usbh-phy.o
 obj-$(CONFIG_BCM6348_USBH_PHY) += bcm6348-usbh-phy.o
 obj-$(CONFIG_BCM6358_USBH_PHY) += bcm6358-usbh-phy.o
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
new file mode 100644
index 0000000000..ba5f648612
--- /dev/null
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ */
+
+#include <common.h>
+#include <div64.h>
+
+#include <phy-mipi-dphy.h>
+
+#define PSEC_PER_SEC	1000000000000LL
+
+/*
+ * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
+ * from the valid ranges specified in Section 6.9, Table 14, Page 41
+ * of the D-PHY specification (v2.1).
+ */
+int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+				     unsigned int bpp,
+				     unsigned int lanes,
+				     struct phy_configure_opts_mipi_dphy *cfg)
+{
+	unsigned long long hs_clk_rate;
+	unsigned long long ui;
+
+	if (!cfg)
+		return -EINVAL;
+
+	hs_clk_rate = pixel_clock * bpp;
+	do_div(hs_clk_rate, lanes);
+
+	ui = ALIGN(PSEC_PER_SEC, hs_clk_rate);
+	do_div(ui, hs_clk_rate);
+
+	cfg->clk_miss = 0;
+	cfg->clk_post = 60000 + 52 * ui;
+	cfg->clk_pre = 8000;
+	cfg->clk_prepare = 38000;
+	cfg->clk_settle = 95000;
+	cfg->clk_term_en = 0;
+	cfg->clk_trail = 60000;
+	cfg->clk_zero = 262000;
+	cfg->d_term_en = 0;
+	cfg->eot = 0;
+	cfg->hs_exit = 100000;
+	cfg->hs_prepare = 40000 + 4 * ui;
+	cfg->hs_zero = 105000 + 6 * ui;
+	cfg->hs_settle = 85000 + 6 * ui;
+	cfg->hs_skip = 40000;
+
+	/*
+	 * The MIPI D-PHY specification (Section 6.9, v1.2, Table 14, Page 40)
+	 * contains this formula as:
+	 *
+	 *     T_HS-TRAIL = max(n * 8 * ui, 60 + n * 4 * ui)
+	 *
+	 * where n = 1 for forward-direction HS mode and n = 4 for reverse-
+	 * direction HS mode. There's only one setting and this function does
+	 * not parameterize on anything other that ui, so this code will
+	 * assumes that reverse-direction HS mode is supported and uses n = 4.
+	 */
+	cfg->hs_trail = max(4 * 8 * ui, 60000 + 4 * 4 * ui);
+
+	cfg->init = 100;
+	cfg->lpx = 60000;
+	cfg->ta_get = 5 * cfg->lpx;
+	cfg->ta_go = 4 * cfg->lpx;
+	cfg->ta_sure = 2 * cfg->lpx;
+	cfg->wakeup = 1000;
+
+	cfg->hs_clk_rate = hs_clk_rate;
+	cfg->lanes = lanes;
+
+	return 0;
+}
+
+/*
+ * Validate D-PHY configuration according to MIPI D-PHY specification
+ * (v1.2, Section Section 6.9 "Global Operation Timing Parameters").
+ */
+int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg)
+{
+	unsigned long long ui;
+
+	if (!cfg)
+		return -EINVAL;
+
+	ui = ALIGN(PSEC_PER_SEC, cfg->hs_clk_rate);
+	do_div(ui, cfg->hs_clk_rate);
+
+	if (cfg->clk_miss > 60000)
+		return -EINVAL;
+
+	if (cfg->clk_post < (60000 + 52 * ui))
+		return -EINVAL;
+
+	if (cfg->clk_pre < 8000)
+		return -EINVAL;
+
+	if (cfg->clk_prepare < 38000 || cfg->clk_prepare > 95000)
+		return -EINVAL;
+
+	if (cfg->clk_settle < 95000 || cfg->clk_settle > 300000)
+		return -EINVAL;
+
+	if (cfg->clk_term_en > 38000)
+		return -EINVAL;
+
+	if (cfg->clk_trail < 60000)
+		return -EINVAL;
+
+	if ((cfg->clk_prepare + cfg->clk_zero) < 300000)
+		return -EINVAL;
+
+	if (cfg->d_term_en > (35000 + 4 * ui))
+		return -EINVAL;
+
+	if (cfg->eot > (105000 + 12 * ui))
+		return -EINVAL;
+
+	if (cfg->hs_exit < 100000)
+		return -EINVAL;
+
+	if (cfg->hs_prepare < (40000 + 4 * ui) ||
+	    cfg->hs_prepare > (85000 + 6 * ui))
+		return -EINVAL;
+
+	if ((cfg->hs_prepare + cfg->hs_zero) < (145000 + 10 * ui))
+		return -EINVAL;
+
+	if ((cfg->hs_settle < (85000 + 6 * ui)) ||
+	    (cfg->hs_settle > (145000 + 10 * ui)))
+		return -EINVAL;
+
+	if (cfg->hs_skip < 40000 || cfg->hs_skip > (55000 + 4 * ui))
+		return -EINVAL;
+
+	if (cfg->hs_trail < max(8 * ui, 60000 + 4 * ui))
+		return -EINVAL;
+
+	if (cfg->init < 100)
+		return -EINVAL;
+
+	if (cfg->lpx < 50000)
+		return -EINVAL;
+
+	if (cfg->ta_get != (5 * cfg->lpx))
+		return -EINVAL;
+
+	if (cfg->ta_go != (4 * cfg->lpx))
+		return -EINVAL;
+
+	if (cfg->ta_sure < cfg->lpx || cfg->ta_sure > (2 * cfg->lpx))
+		return -EINVAL;
+
+	if (cfg->wakeup < 1000)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/include/phy-mipi-dphy.h b/include/phy-mipi-dphy.h
new file mode 100644
index 0000000000..a877ffee84
--- /dev/null
+++ b/include/phy-mipi-dphy.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ */
+
+#ifndef __PHY_MIPI_DPHY_H_
+#define __PHY_MIPI_DPHY_H_
+
+/**
+ * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
+ *
+ * This structure is used to represent the configuration state of a
+ * MIPI D-PHY phy.
+ */
+struct phy_configure_opts_mipi_dphy {
+	/**
+	 * @clk_miss:
+	 *
+	 * Timeout, in picoseconds, for receiver to detect absence of
+	 * Clock transitions and disable the Clock Lane HS-RX.
+	 *
+	 * Maximum value: 60000 ps
+	 */
+	unsigned int		clk_miss;
+
+	/**
+	 * @clk_post:
+	 *
+	 * Time, in picoseconds, that the transmitter continues to
+	 * send HS clock after the last associated Data Lane has
+	 * transitioned to LP Mode. Interval is defined as the period
+	 * from the end of @hs_trail to the beginning of @clk_trail.
+	 *
+	 * Minimum value: 60000 ps + 52 * @hs_clk_rate period in ps
+	 */
+	unsigned int		clk_post;
+
+	/**
+	 * @clk_pre:
+	 *
+	 * Time, in UI, that the HS clock shall be driven by
+	 * the transmitter prior to any associated Data Lane beginning
+	 * the transition from LP to HS mode.
+	 *
+	 * Minimum value: 8 UI
+	 */
+	unsigned int		clk_pre;
+
+	/**
+	 * @clk_prepare:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the Clock
+	 * Lane LP-00 Line state immediately before the HS-0 Line
+	 * state starting the HS transmission.
+	 *
+	 * Minimum value: 38000 ps
+	 * Maximum value: 95000 ps
+	 */
+	unsigned int		clk_prepare;
+
+	/**
+	 * @clk_settle:
+	 *
+	 * Time interval, in picoseconds, during which the HS receiver
+	 * should ignore any Clock Lane HS transitions, starting from
+	 * the beginning of @clk_prepare.
+	 *
+	 * Minimum value: 95000 ps
+	 * Maximum value: 300000 ps
+	 */
+	unsigned int		clk_settle;
+
+	/**
+	 * @clk_term_en:
+	 *
+	 * Time, in picoseconds, for the Clock Lane receiver to enable
+	 * the HS line termination.
+	 *
+	 * Maximum value: 38000 ps
+	 */
+	unsigned int		clk_term_en;
+
+	/**
+	 * @clk_trail:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the HS-0
+	 * state after the last payload clock bit of a HS transmission
+	 * burst.
+	 *
+	 * Minimum value: 60000 ps
+	 */
+	unsigned int		clk_trail;
+
+	/**
+	 * @clk_zero:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the HS-0
+	 * state prior to starting the Clock.
+	 */
+	unsigned int		clk_zero;
+
+	/**
+	 * @d_term_en:
+	 *
+	 * Time, in picoseconds, for the Data Lane receiver to enable
+	 * the HS line termination.
+	 *
+	 * Maximum value: 35000 ps + 4 * @hs_clk_rate period in ps
+	 */
+	unsigned int		d_term_en;
+
+	/**
+	 * @eot:
+	 *
+	 * Transmitted time interval, in picoseconds, from the start
+	 * of @hs_trail or @clk_trail, to the start of the LP- 11
+	 * state following a HS burst.
+	 *
+	 * Maximum value: 105000 ps + 12 * @hs_clk_rate period in ps
+	 */
+	unsigned int		eot;
+
+	/**
+	 * @hs_exit:
+	 *
+	 * Time, in picoseconds, that the transmitter drives LP-11
+	 * following a HS burst.
+	 *
+	 * Minimum value: 100000 ps
+	 */
+	unsigned int		hs_exit;
+
+	/**
+	 * @hs_prepare:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the Data
+	 * Lane LP-00 Line state immediately before the HS-0 Line
+	 * state starting the HS transmission.
+	 *
+	 * Minimum value: 40000 ps + 4 * @hs_clk_rate period in ps
+	 * Maximum value: 85000 ps + 6 * @hs_clk_rate period in ps
+	 */
+	unsigned int		hs_prepare;
+
+	/**
+	 * @hs_settle:
+	 *
+	 * Time interval, in picoseconds, during which the HS receiver
+	 * shall ignore any Data Lane HS transitions, starting from
+	 * the beginning of @hs_prepare.
+	 *
+	 * Minimum value: 85000 ps + 6 * @hs_clk_rate period in ps
+	 * Maximum value: 145000 ps + 10 * @hs_clk_rate period in ps
+	 */
+	unsigned int		hs_settle;
+
+	/**
+	 * @hs_skip:
+	 *
+	 * Time interval, in picoseconds, during which the HS-RX
+	 * should ignore any transitions on the Data Lane, following a
+	 * HS burst. The end point of the interval is defined as the
+	 * beginning of the LP-11 state following the HS burst.
+	 *
+	 * Minimum value: 40000 ps
+	 * Maximum value: 55000 ps + 4 * @hs_clk_rate period in ps
+	 */
+	unsigned int		hs_skip;
+
+	/**
+	 * @hs_trail:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the
+	 * flipped differential state after last payload data bit of a
+	 * HS transmission burst
+	 *
+	 * Minimum value: max(8 * @hs_clk_rate period in ps,
+	 *		      60000 ps + 4 * @hs_clk_rate period in ps)
+	 */
+	unsigned int		hs_trail;
+
+	/**
+	 * @hs_zero:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the HS-0
+	 * state prior to transmitting the Sync sequence.
+	 */
+	unsigned int		hs_zero;
+
+	/**
+	 * @init:
+	 *
+	 * Time, in microseconds for the initialization period to
+	 * complete.
+	 *
+	 * Minimum value: 100 us
+	 */
+	unsigned int		init;
+
+	/**
+	 * @lpx:
+	 *
+	 * Transmitted length, in picoseconds, of any Low-Power state
+	 * period.
+	 *
+	 * Minimum value: 50000 ps
+	 */
+	unsigned int		lpx;
+
+	/**
+	 * @ta_get:
+	 *
+	 * Time, in picoseconds, that the new transmitter drives the
+	 * Bridge state (LP-00) after accepting control during a Link
+	 * Turnaround.
+	 *
+	 * Value: 5 * @lpx
+	 */
+	unsigned int		ta_get;
+
+	/**
+	 * @ta_go:
+	 *
+	 * Time, in picoseconds, that the transmitter drives the
+	 * Bridge state (LP-00) before releasing control during a Link
+	 * Turnaround.
+	 *
+	 * Value: 4 * @lpx
+	 */
+	unsigned int		ta_go;
+
+	/**
+	 * @ta_sure:
+	 *
+	 * Time, in picoseconds, that the new transmitter waits after
+	 * the LP-10 state before transmitting the Bridge state
+	 * (LP-00) during a Link Turnaround.
+	 *
+	 * Minimum value: @lpx
+	 * Maximum value: 2 * @lpx
+	 */
+	unsigned int		ta_sure;
+
+	/**
+	 * @wakeup:
+	 *
+	 * Time, in microseconds, that a transmitter drives a Mark-1
+	 * state prior to a Stop state in order to initiate an exit
+	 * from ULPS.
+	 *
+	 * Minimum value: 1000 us
+	 */
+	unsigned int		wakeup;
+
+	/**
+	 * @hs_clk_rate:
+	 *
+	 * Clock rate, in Hertz, of the high-speed clock.
+	 */
+	unsigned long		hs_clk_rate;
+
+	/**
+	 * @lp_clk_rate:
+	 *
+	 * Clock rate, in Hertz, of the low-power clock.
+	 */
+	unsigned long		lp_clk_rate;
+
+	/**
+	 * @lanes:
+	 *
+	 * Number of active, consecutive, data lanes, starting from
+	 * lane 0, used for the transmissions.
+	 */
+	unsigned char		lanes;
+};
+
+int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+				     unsigned int bpp,
+				     unsigned int lanes,
+				     struct phy_configure_opts_mipi_dphy *cfg);
+int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg);
+
+#endif /* __PHY_MIPI_DPHY_H_ */
-- 
2.25.1

