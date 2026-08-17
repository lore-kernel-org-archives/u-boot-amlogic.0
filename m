Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CDAC61DBC
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75.1786986994426041564
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=bGc7Tipg;
 spf=pass (domain: brivo.com, ip: 209.85.160.175, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5218927884fso36419651cf.3
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986993; x=1787591793; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oghrmtiUslwVTfiOK5Lvb8Ch5/Q01t9IH1Ie4P8wd0E=;
        b=bGc7TipgBuDP4YV8AdSewdxWygClFY8NWTTKNwAMNnJvJiqibWl1HOeJ4UQ0YHbFlO
         wjR9Daw1qhFK6NsXN6flAR7f3UtcWyGr0ebuwDhvUkJjPOmD8DZN1SIvz5gcBSCMqRaZ
         c7WLmp9Lg1k+rGxA5GiGLswYUQefr4RHEu9zoQVHsR+cUCKZJXAgQyCgzsLKaMI3Gt0L
         2Ord76fly5K0yrc6aJW9HzGWoeNyuGO2NEptg888xYjfwJ/wnpJj4K9l5In8xDLYz74Z
         cFs8bilY0aaGKcLHX7ng38ujITMAw+A61ZqKaQwrlrX349l2Rfdi6NPh8BWVRSHco1eF
         sb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986993; x=1787591793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oghrmtiUslwVTfiOK5Lvb8Ch5/Q01t9IH1Ie4P8wd0E=;
        b=KbEzVMZRtk9Fqb6RzQuFG11cklKJ1H4H9uwwaeMj+HKjQeY/42VAHW44CEKdny1GBz
         fYbXWbbc6DZY3Huf40srpgobM37amROS0lZyqy5J2/iMSnXc+eaMBrQXKqFaw1gWDXr3
         FbK/thjKOCN8HBmpGxm4rQkh91ghEZfegZjvnr4Xhc0AqS3I/Mw6R/Qe6e17usZQouEI
         mzE2U7qHdlUTtIGe2kzDjIcCyyo1i2+mqlgz1yK2M1Ory2XIBCP/nW0xSjZNws7zR+Wp
         UsoaWDhxPP+2amsTvK6bMM8kOKUbZZfD4VPrEm8ijtiJ/14jOekuYQht1O60xMnzxts5
         JXtA==
X-Gm-Message-State: AOJu0YyftjtGT6RoOUdvdioCApWSRcdvis1mdLx55kVU5PLnTp8Ru/gf
	T+UX06KZX7EBh1xSEbyQL7UZNkw9meUIphfgKR92/eKjAHy5fJinNSMBXbHkR5qsU6dqZRnNueI
	lr+hlAzF8vomDCDhhdbSrXGNZ36eFi8zTPaBg2No5ttNXGWPvLjfLLg==
X-Gm-Gg: AR+sD11EjLDMig03fpEq9P2nKI+vMuf8iC7Xj3iu4Isgl1UuVrJX7RtwY796zNeaNCC
	yxB+MV4MAJ7LJSOsnm8NkmHDOtJEHNZdQJ1mwsRAq8sLEoslxVMb0KCkKXfd2hwP69xn9I5q1h6
	V87NLF7cwbyQ0MqAfdC/qpg0BErS5oe/HqvW0DnncNz/OrUNehCJkqpI5pvaRHMWJNp9HjiEIST
	pQr624ikcoaE8uz9sDrlUc8TIy7n5kPPooGeyJ4b5zpRb6pszpEVVOnRBf+AAkzybO1/u3kQQCu
	EHBgLE31QcjxKzXp+wdq98Zzh08hBy9HWtSpkjVaant/q4RzUwL8rULlGKVgJLPwzoer5BVtSJ/
	uLWmqpuwga2aQpR9bmayHbPHsYqlvTiNoBLTSyIqg+Z8ZadYiUtpEdRoMUHiX6NdpygI5y9VLUd
	H47i1hhd9EiaJKTuTSnbf9fLp/A/zBFDwy5S4e3ZweaYI8H8iEzshp2iYhvrpvumKLsQd1lT36l
	setL2J4CQ3fee27o91vvT+S5e0=
X-Received: by 2002:ac8:5fd5:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-52d8542c3c0mr288269211cf.22.1786986991973;
        Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 8/9] clk: meson: Add s4 clock driver
Date: Mon, 17 Aug 2026 13:15:19 -0400
Message-ID: <20260817171623.1943847-9-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3035

Add a clock driver to support for the "s4" series of SoCs (S805X2 and
S905Y4). I've added most of the clocks necessary at boot, although a few
of the unused parents (VID_PLL, RTC) have been omitted. I also left out
the parents of the MPLL clocks, as they have a custom divider. MPLL2 is
enabled by the Ethernet driver but is never actually selected so it's OK
to stub out the parent.

=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 24000000             0        |-- xtal-clk
 34700000             0        |-- bt-txco

meson-clk-s4 clock-controller@0:
clock-controller@0:
----------------------------------------------------------------------
            clk           frequency              parent          state
----------------------------------------------------------------------
   sysclk_b_sel           498000000           fclk_div4            N/A
   sysclk_b_div           166000000        sysclk_b_sel            N/A
       sysclk_b           166000000        sysclk_b_div        enabled
   sysclk_a_sel            24000000                xtal            N/A
   sysclk_a_div            24000000        sysclk_a_sel            N/A
       sysclk_a            24000000        sysclk_a_div        enabled
            sys           166000000            sysclk_b            N/A
  sd_emmc_c_sel            24000000                xtal            N/A
  sd_emmc_c_div            24000000       sd_emmc_c_sel            N/A
      sd_emmc_c            24000000       sd_emmc_c_div        enabled
  sd_emmc_a_sel            24000000                xtal            N/A
  sd_emmc_a_div            24000000       sd_emmc_a_sel            N/A
      sd_emmc_a            24000000       sd_emmc_a_div        enabled
  sd_emmc_b_sel            24000000                xtal            N/A
  sd_emmc_b_div            24000000       sd_emmc_b_sel            N/A
      sd_emmc_b            24000000       sd_emmc_b_div        enabled
      pwm_a_sel            24000000                xtal            N/A
      pwm_a_div            24000000           pwm_a_sel            N/A
          pwm_a            24000000           pwm_a_div       disabled
      pwm_b_sel            24000000                xtal            N/A
      pwm_b_div            24000000           pwm_b_sel            N/A
          pwm_b            24000000           pwm_b_div       disabled
      pwm_c_sel            24000000                xtal            N/A
      pwm_c_div            24000000           pwm_c_sel            N/A
          pwm_c            24000000           pwm_c_div       disabled
      pwm_d_sel            24000000                xtal            N/A
      pwm_d_div            24000000           pwm_d_sel            N/A
          pwm_d            24000000           pwm_d_div       disabled
      pwm_e_sel            24000000                xtal            N/A
      pwm_e_div            24000000           pwm_e_sel            N/A
          pwm_e            24000000           pwm_e_div       disabled
      pwm_f_sel            24000000                xtal            N/A
      pwm_f_div            24000000           pwm_f_sel            N/A
          pwm_f            24000000           pwm_f_div       disabled
      pwm_g_sel            24000000                xtal            N/A
      pwm_g_div            24000000           pwm_g_sel            N/A
          pwm_g            24000000           pwm_g_div       disabled
      pwm_h_sel            24000000                xtal            N/A
      pwm_h_div            24000000           pwm_h_sel            N/A
          pwm_h            24000000           pwm_h_div        enabled
      pwm_i_sel            24000000                xtal            N/A
      pwm_i_div            24000000           pwm_i_sel            N/A
          pwm_i            24000000           pwm_i_div       disabled
      pwm_j_sel            24000000                xtal            N/A
      pwm_j_div            24000000           pwm_j_sel            N/A
          pwm_j            24000000           pwm_j_div        enabled
         ethphy           166000000                 sys        enabled
       sdemmc_a           166000000                 sys        enabled
       sdemmc_b           166000000                 sys        enabled
           nand           166000000                 sys        enabled
            eth           166000000                 sys        enabled
         uart_a           166000000                 sys        enabled
         uart_b           166000000                 sys        enabled
         uart_c           166000000                 sys        enabled
         uart_d           166000000                 sys        enabled
         uart_e           166000000                 sys        enabled
            usb           166000000                 sys        enabled
        i2c_m_a           166000000                 sys        enabled
        i2c_m_b           166000000                 sys        enabled
        i2c_m_c           166000000                 sys        enabled
        i2c_m_d           166000000                 sys        enabled
        i2c_m_e           166000000                 sys        enabled
    usb1_to_ddr           166000000                 sys        enabled
         pwm_ab           166000000                 sys        enabled
         pwm_cd           166000000                 sys        enabled
         pwm_ef           166000000                 sys        enabled
         pwm_gh           166000000                 sys        enabled
         pwm_ij           166000000                 sys        enabled
           xtal            24000000             unknown            N/A
      fclk_div2           996000000             unknown            N/A
    fclk_div2p5           796800000             unknown            N/A
      fclk_div3           664000000             unknown            N/A
      fclk_div4           498000000             unknown            N/A
      fclk_div5           398400000             unknown            N/A
      fclk_div7           284571428             unknown            N/A
       hifi_pll          1176000000             unknown            N/A
        gp0_pll             unknown             unknown            N/A
          mpll0             unknown             unknown            N/A
          mpll1             unknown             unknown            N/A
          mpll2             unknown             unknown            N/A
          mpll3             unknown             unknown            N/A
       hdmi_pll             unknown             unknown            N/A

meson-clk-s4 clock-controller@8000:
clock-controller@8000:
----------------------------------------------------------------------
            clk           frequency              parent          state
----------------------------------------------------------------------
  fixed_pll_dco          3984000000                xtal            N/A
      fixed_pll          1992000000       fixed_pll_dco            N/A
  fclk_div2_div           996000000           fixed_pll            N/A
      fclk_div2           996000000       fclk_div2_div        enabled
  fclk_div3_div           664000000           fixed_pll            N/A
      fclk_div3           664000000       fclk_div3_div        enabled
  fclk_div4_div           498000000           fixed_pll            N/A
      fclk_div4           498000000       fclk_div4_div        enabled
  fclk_div5_div           398400000           fixed_pll            N/A
      fclk_div5           398400000       fclk_div5_div        enabled
  fclk_div7_div           284571428           fixed_pll            N/A
      fclk_div7           284571428       fclk_div7_div        enabled
fclk_div2p5_div           796800000           fixed_pll            N/A
    fclk_div2p5           796800000     fclk_div2p5_div        enabled
    gp0_pll_dco             unknown                xtal            N/A
        gp0_pll             unknown         gp0_pll_dco            N/A
   hifi_pll_dco          4704000000                xtal            N/A
       hifi_pll          1176000000        hifi_pll_dco            N/A
   hdmi_pll_dco             unknown                xtal            N/A
    hdmi_pll_od             unknown        hdmi_pll_dco            N/A
       hdmi_pll             unknown         hdmi_pll_od            N/A
   mpll_50m_div            49800000       fixed_pll_dco            N/A
       mpll_50m            49800000        mpll_50m_div            N/A
          mpll0             unknown             unknown       disabled
          mpll1             unknown             unknown       disabled
          mpll2             unknown             unknown        enabled
          mpll3             unknown             unknown       disabled
           xtal            24000000             unknown            N/A

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/Kconfig  |   8 +
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/s4.c     | 587 +++++++++++++++++++++++++++++++++++++
 3 files changed, 596 insertions(+)
 create mode 100644 drivers/clk/meson/s4.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index ee33c611400..abdc6a70e25 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -30,6 +30,14 @@ config CLK_MESON_A1
 	  Enable clock support for the Amlogic A1 SoC family, such as
 	  the A113L
 
+config CLK_MESON_S4
+	bool "Enable clock support for Amlogic S4"
+	depends on CLK && ARCH_MESON
+	default MESON_S4
+	help
+	  Enable clock support for the Amlogic S4 SoC family, such as
+	  the S905Y4/S905W2
+
 config CLK_MESON_MSR
 	bool "Enable clock measure driver for Amlogic SoCs"
 	depends on CLK && ARCH_MESON
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 3d1dfcdb640..705591ed4a9 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
 obj-$(CONFIG_CLK_MESON_A1) += a1.o
+obj-$(CONFIG_CLK_MESON_S4) += s4.o
 obj-$(CONFIG_CLK_MESON_MSR) += clk-measure.o
diff --git a/drivers/clk/meson/s4.c b/drivers/clk/meson/s4.c
new file mode 100644
index 00000000000..5bb8e58f378
--- /dev/null
+++ b/drivers/clk/meson/s4.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) Brivo Systems LLC 2026
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
+#include "clk_meson.h"
+
+/*
+ * This driver supports both PLL and peripherals clock sources.
+ * Following operations are supported:
+ * - calculating clock frequency on a limited tree
+ * - reading muxes and dividers
+ * - enabling/disabling gates without propagation
+ * - reparenting without rate propagation, only on muxes
+ * - setting rates with limited reparenting, only on dividers with mux parent
+ */
+
+#define RTC_BY_OSCIN_CTRL0                 0x008
+#define RTC_BY_OSCIN_CTRL1                 0x00c
+#define RTC_CTRL                           0x010
+#define SYS_CLK_CTRL0                      0x040
+#define SYS_CLK_EN0_REG0                   0x044
+#define SYS_CLK_EN0_REG1                   0x048
+#define SYS_CLK_EN0_REG2                   0x04c
+#define SYS_CLK_EN0_REG3                   0x050
+#define CECA_CTRL0                         0x088
+#define CECA_CTRL1                         0x08c
+#define CECB_CTRL0                         0x090
+#define CECB_CTRL1                         0x094
+#define SC_CLK_CTRL                        0x098
+#define CLK12_24_CTRL                      0x0a8
+#define VID_CLK_CTRL                       0x0c0
+#define VID_CLK_CTRL2                      0x0c4
+#define VID_CLK_DIV                        0x0c8
+#define VIID_CLK_DIV                       0x0cc
+#define VIID_CLK_CTRL                      0x0d0
+#define HDMI_CLK_CTRL                      0x0e0
+#define VID_PLL_CLK_DIV                    0x0e4
+#define VPU_CLK_CTRL                       0x0e8
+#define VPU_CLKB_CTRL                      0x0ec
+#define VPU_CLKC_CTRL                      0x0f0
+#define VID_LOCK_CLK_CTRL                  0x0f4
+#define VDIN_MEAS_CLK_CTRL                 0x0f8
+#define VAPBCLK_CTRL                       0x0fc
+#define HDCP22_CTRL                        0x100
+#define CDAC_CLK_CTRL                      0x108
+#define VDEC_CLK_CTRL                      0x140
+#define VDEC2_CLK_CTRL                     0x144
+#define VDEC3_CLK_CTRL                     0x148
+#define VDEC4_CLK_CTRL                     0x14c
+#define TS_CLK_CTRL                        0x158
+#define MALI_CLK_CTRL                      0x15c
+#define NAND_CLK_CTRL                      0x168
+#define SD_EMMC_CLK_CTRL                   0x16c
+#define SPICC_CLK_CTRL                     0x174
+#define GEN_CLK_CTRL                       0x178
+#define SAR_CLK_CTRL                       0x17c
+#define PWM_CLK_AB_CTRL                    0x180
+#define PWM_CLK_CD_CTRL                    0x184
+#define PWM_CLK_EF_CTRL                    0x188
+#define PWM_CLK_GH_CTRL                    0x18c
+#define PWM_CLK_IJ_CTRL                    0x190
+#define DEMOD_CLK_CTRL                     0x200
+
+#define FIXPLL_CTRL0                       0x040
+#define FIXPLL_CTRL1                       0x044
+#define FIXPLL_CTRL3                       0x04c
+#define GP0PLL_CTRL0                       0x080
+#define GP0PLL_CTRL1                       0x084
+#define GP0PLL_CTRL2                       0x088
+#define GP0PLL_CTRL3                       0x08c
+#define GP0PLL_CTRL4                       0x090
+#define GP0PLL_CTRL5                       0x094
+#define GP0PLL_CTRL6                       0x098
+#define HIFIPLL_CTRL0                      0x100
+#define HIFIPLL_CTRL1                      0x104
+#define HIFIPLL_CTRL2                      0x108
+#define HIFIPLL_CTRL3                      0x10c
+#define HIFIPLL_CTRL4                      0x110
+#define HIFIPLL_CTRL5                      0x114
+#define HIFIPLL_CTRL6                      0x118
+#define MPLL_CTRL0                         0x180
+#define MPLL_CTRL1                         0x184
+#define MPLL_CTRL2                         0x188
+#define MPLL_CTRL3                         0x18c
+#define MPLL_CTRL4                         0x190
+#define MPLL_CTRL5                         0x194
+#define MPLL_CTRL6                         0x198
+#define MPLL_CTRL7                         0x19c
+#define MPLL_CTRL8                         0x1a0
+#define HDMIPLL_CTRL0                      0x1c0
+
+/* External clock IDs. Those should not overlap with regular IDs */
+enum {
+	EXTERNAL_XTAL = CLKID_ADC_EXTCLK_IN + 1,
+	EXTERNAL_FCLK_DIV2,
+	EXTERNAL_FCLK_DIV2P5,
+	EXTERNAL_FCLK_DIV3,
+	EXTERNAL_FCLK_DIV4,
+	EXTERNAL_FCLK_DIV5,
+	EXTERNAL_FCLK_DIV7,
+	EXTERNAL_HIFI_PLL,
+	EXTERNAL_GP0_PLL,
+	EXTERNAL_MPLL0,
+	EXTERNAL_MPLL1,
+	EXTERNAL_MPLL2,
+	EXTERNAL_MPLL3,
+	EXTERNAL_HDMI_PLL,
+
+	EXTERNAL_PLL_XTAL = CLKID_MPLL3 + 1,
+};
+
+/* S4 peripherals clocks */
+static const struct meson_clk_info *meson_clocks[] = {
+	[CLKID_SYS_CLK_B_SEL] = CLK_MUX("sysclk_b_sel", SYS_CLK_CTRL0, 26, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV7,
+		-ENOENT,
+	}),
+	[CLKID_SYS_CLK_B_DIV] = CLK_DIV("sysclk_b_div", SYS_CLK_CTRL0, 16, 10,
+		CLKID_SYS_CLK_B_SEL
+	),
+	[CLKID_SYS_CLK_B] = CLK_GATE("sysclk_b", SYS_CLK_CTRL0, 29,
+		CLKID_SYS_CLK_B_DIV
+	),
+	[CLKID_SYS_CLK_A_SEL] = CLK_MUX("sysclk_a_sel", SYS_CLK_CTRL0, 10, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV7,
+		-ENOENT,
+	}),
+	[CLKID_SYS_CLK_A_DIV] = CLK_DIV("sysclk_a_div", SYS_CLK_CTRL0, 0, 10,
+		CLKID_SYS_CLK_A_SEL
+	),
+	[CLKID_SYS_CLK_A] = CLK_GATE("sysclk_a", SYS_CLK_CTRL0, 13,
+		CLKID_SYS_CLK_A_DIV
+	),
+	[CLKID_SYS] = CLK_MUX("sys", SYS_CLK_CTRL0, 31, 1, {
+		CLKID_SYS_CLK_A,
+		CLKID_SYS_CLK_B,
+	}),
+
+	[CLKID_SD_EMMC_C_CLK_SEL] = CLK_MUX("sd_emmc_c_sel", NAND_CLK_CTRL, 9, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_C_CLK_DIV] = CLK_DIV("sd_emmc_c_div", NAND_CLK_CTRL, 0, 7,
+		CLKID_SD_EMMC_C_CLK_SEL
+	),
+	[CLKID_SD_EMMC_C] = CLK_GATE("sd_emmc_c", NAND_CLK_CTRL, 7,
+		CLKID_SD_EMMC_C_CLK_DIV
+	),
+
+	[CLKID_SD_EMMC_A_CLK_SEL] = CLK_MUX("sd_emmc_a_sel", SD_EMMC_CLK_CTRL, 9, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_A_CLK_DIV] = CLK_DIV("sd_emmc_a_div", SD_EMMC_CLK_CTRL, 0, 7,
+		CLKID_SD_EMMC_A_CLK_SEL
+	),
+	[CLKID_SD_EMMC_A] = CLK_GATE("sd_emmc_a", SD_EMMC_CLK_CTRL, 7,
+		CLKID_SD_EMMC_A_CLK_DIV
+	),
+
+	[CLKID_SD_EMMC_B_CLK_SEL] = CLK_MUX("sd_emmc_b_sel", SD_EMMC_CLK_CTRL, 25, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_B_CLK_DIV] = CLK_DIV("sd_emmc_b_div", SD_EMMC_CLK_CTRL, 16, 7,
+		CLKID_SD_EMMC_B_CLK_SEL
+	),
+	[CLKID_SD_EMMC_B] = CLK_GATE("sd_emmc_b", SD_EMMC_CLK_CTRL, 23,
+		CLKID_SD_EMMC_B_CLK_DIV
+	),
+
+	[CLKID_PWM_A_SEL] = CLK_MUX("pwm_a_sel", PWM_CLK_AB_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_A_DIV] = CLK_DIV("pwm_a_div", PWM_CLK_AB_CTRL, 0, 8,
+		CLKID_PWM_A_SEL
+	),
+	[CLKID_PWM_A] = CLK_GATE("pwm_a", PWM_CLK_AB_CTRL, 8,
+		CLKID_PWM_A_DIV
+	),
+
+	[CLKID_PWM_B_SEL] = CLK_MUX("pwm_b_sel", PWM_CLK_AB_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_B_DIV] = CLK_DIV("pwm_b_div", PWM_CLK_AB_CTRL, 16, 8,
+		CLKID_PWM_B_SEL
+	),
+	[CLKID_PWM_B] = CLK_GATE("pwm_b", PWM_CLK_AB_CTRL, 24,
+		CLKID_PWM_B_DIV
+	),
+
+	[CLKID_PWM_C_SEL] = CLK_MUX("pwm_c_sel", PWM_CLK_CD_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_C_DIV] = CLK_DIV("pwm_c_div", PWM_CLK_CD_CTRL, 0, 8,
+		CLKID_PWM_C_SEL
+	),
+	[CLKID_PWM_C] = CLK_GATE("pwm_c", PWM_CLK_CD_CTRL, 8,
+		CLKID_PWM_C_DIV
+	),
+
+	[CLKID_PWM_D_SEL] = CLK_MUX("pwm_d_sel", PWM_CLK_CD_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_D_DIV] = CLK_DIV("pwm_d_div", PWM_CLK_CD_CTRL, 16, 8,
+		CLKID_PWM_D_SEL
+	),
+	[CLKID_PWM_D] = CLK_GATE("pwm_d", PWM_CLK_CD_CTRL, 24,
+		CLKID_PWM_D_DIV
+	),
+
+	[CLKID_PWM_E_SEL] = CLK_MUX("pwm_e_sel", PWM_CLK_EF_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_E_DIV] = CLK_DIV("pwm_e_div", PWM_CLK_EF_CTRL, 0, 8,
+		CLKID_PWM_E_SEL
+	),
+	[CLKID_PWM_E] = CLK_GATE("pwm_e", PWM_CLK_EF_CTRL, 8,
+		CLKID_PWM_E_DIV
+	),
+
+	[CLKID_PWM_F_SEL] = CLK_MUX("pwm_f_sel", PWM_CLK_EF_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_F_DIV] = CLK_DIV("pwm_f_div", PWM_CLK_EF_CTRL, 16, 8,
+		CLKID_PWM_F_SEL
+	),
+	[CLKID_PWM_F] = CLK_GATE("pwm_f", PWM_CLK_EF_CTRL, 24,
+		CLKID_PWM_F_DIV
+	),
+
+	[CLKID_PWM_G_SEL] = CLK_MUX("pwm_g_sel", PWM_CLK_GH_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_G_DIV] = CLK_DIV("pwm_g_div", PWM_CLK_GH_CTRL, 0, 8,
+		CLKID_PWM_G_SEL
+	),
+	[CLKID_PWM_G] = CLK_GATE("pwm_g", PWM_CLK_GH_CTRL, 8,
+		CLKID_PWM_G_DIV
+	),
+
+	[CLKID_PWM_H_SEL] = CLK_MUX("pwm_h_sel", PWM_CLK_GH_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_H_DIV] = CLK_DIV("pwm_h_div", PWM_CLK_GH_CTRL, 16, 8,
+		CLKID_PWM_H_SEL
+	),
+	[CLKID_PWM_H] = CLK_GATE("pwm_h", PWM_CLK_GH_CTRL, 24,
+		CLKID_PWM_H_DIV
+	),
+
+	[CLKID_PWM_I_SEL] = CLK_MUX("pwm_i_sel", PWM_CLK_IJ_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_I_DIV] = CLK_DIV("pwm_i_div", PWM_CLK_IJ_CTRL, 0, 8,
+		CLKID_PWM_I_SEL
+	),
+	[CLKID_PWM_I] = CLK_GATE("pwm_i", PWM_CLK_IJ_CTRL, 8,
+		CLKID_PWM_I_DIV
+	),
+
+	[CLKID_PWM_J_SEL] = CLK_MUX("pwm_j_sel", PWM_CLK_IJ_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_J_DIV] = CLK_DIV("pwm_j_div", PWM_CLK_IJ_CTRL, 16, 8,
+		CLKID_PWM_J_SEL
+	),
+	[CLKID_PWM_J] = CLK_GATE("pwm_j", PWM_CLK_IJ_CTRL, 24,
+		CLKID_PWM_J_DIV
+	),
+
+	[CLKID_ETHPHY] = CLK_GATE("ethphy", SYS_CLK_EN0_REG0, 4,
+		CLKID_SYS
+	),
+	[CLKID_SDEMMC_A] = CLK_GATE("sdemmc_a", SYS_CLK_EN0_REG0, 24,
+		CLKID_SYS
+	),
+	[CLKID_SDEMMC_B] = CLK_GATE("sdemmc_b", SYS_CLK_EN0_REG0, 25,
+		CLKID_SYS
+	),
+	[CLKID_NAND] = CLK_GATE("nand", SYS_CLK_EN0_REG0, 26,
+		CLKID_SYS
+	),
+
+	[CLKID_ETH] = CLK_GATE("eth", SYS_CLK_EN0_REG1, 3,
+		CLKID_SYS
+	),
+	[CLKID_UART_A] = CLK_GATE("uart_a", SYS_CLK_EN0_REG1, 5,
+		CLKID_SYS
+	),
+	[CLKID_UART_B] = CLK_GATE("uart_b", SYS_CLK_EN0_REG1, 6,
+		CLKID_SYS
+	),
+	[CLKID_UART_C] = CLK_GATE("uart_c", SYS_CLK_EN0_REG1, 7,
+		CLKID_SYS
+	),
+	[CLKID_UART_D] = CLK_GATE("uart_d", SYS_CLK_EN0_REG1, 8,
+		CLKID_SYS
+	),
+	[CLKID_UART_E] = CLK_GATE("uart_e", SYS_CLK_EN0_REG1, 9,
+		CLKID_SYS
+	),
+	[CLKID_USB] = CLK_GATE("usb", SYS_CLK_EN0_REG1, 26,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_A] = CLK_GATE("i2c_m_a", SYS_CLK_EN0_REG1, 30,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_B] = CLK_GATE("i2c_m_b", SYS_CLK_EN0_REG1, 31,
+		CLKID_SYS
+	),
+
+	[CLKID_I2C_M_C] = CLK_GATE("i2c_m_c", SYS_CLK_EN0_REG2, 0,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_D] = CLK_GATE("i2c_m_d", SYS_CLK_EN0_REG2, 1,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_E] = CLK_GATE("i2c_m_e", SYS_CLK_EN0_REG2, 2,
+		CLKID_SYS
+	),
+	[CLKID_USB1_TO_DDR] = CLK_GATE("usb1_to_ddr", SYS_CLK_EN0_REG2, 8,
+		CLKID_SYS
+	),
+
+	[CLKID_PWM_AB] = CLK_GATE("pwm_ab", SYS_CLK_EN0_REG3, 7,
+		CLKID_SYS
+	),
+	[CLKID_PWM_CD] = CLK_GATE("pwm_cd", SYS_CLK_EN0_REG3, 8,
+		CLKID_SYS
+	),
+	[CLKID_PWM_EF] = CLK_GATE("pwm_ef", SYS_CLK_EN0_REG3, 9,
+		CLKID_SYS
+	),
+	[CLKID_PWM_GH] = CLK_GATE("pwm_gh", SYS_CLK_EN0_REG3, 10,
+		CLKID_SYS
+	),
+	[CLKID_PWM_IJ] = CLK_GATE("pwm_ij", SYS_CLK_EN0_REG3, 11,
+		CLKID_SYS
+	),
+
+	[EXTERNAL_XTAL] = CLK_EXTERNAL("xtal"),
+	[EXTERNAL_FCLK_DIV2] = CLK_EXTERNAL("fclk_div2"),
+	[EXTERNAL_FCLK_DIV2P5] = CLK_EXTERNAL("fclk_div2p5"),
+	[EXTERNAL_FCLK_DIV3] = CLK_EXTERNAL("fclk_div3"),
+	[EXTERNAL_FCLK_DIV4] = CLK_EXTERNAL("fclk_div4"),
+	[EXTERNAL_FCLK_DIV5] = CLK_EXTERNAL("fclk_div5"),
+	[EXTERNAL_FCLK_DIV7] = CLK_EXTERNAL("fclk_div7"),
+	[EXTERNAL_HIFI_PLL] = CLK_EXTERNAL("hifi_pll"),
+	[EXTERNAL_GP0_PLL] = CLK_EXTERNAL("gp0_pll"),
+	[EXTERNAL_MPLL0] = CLK_EXTERNAL("mpll0"),
+	[EXTERNAL_MPLL1] = CLK_EXTERNAL("mpll1"),
+	[EXTERNAL_MPLL2] = CLK_EXTERNAL("mpll2"),
+	[EXTERNAL_MPLL3] = CLK_EXTERNAL("mpll3"),
+	[EXTERNAL_HDMI_PLL] = CLK_EXTERNAL("hdmi_pll"),
+};
+
+/* S4 PLL clocks */
+static const struct meson_clk_info *meson_pll_clocks[] = {
+	[CLKID_FIXED_PLL_DCO] = CLK_PLL("fixed_pll_dco", EXTERNAL_PLL_XTAL, {
+		{FIXPLL_CTRL0, 0, 8},
+		{FIXPLL_CTRL0, 10, 5},
+	}),
+	[CLKID_GP0_PLL_DCO] = CLK_PLL("gp0_pll_dco", EXTERNAL_PLL_XTAL, {
+		{GP0PLL_CTRL0, 0, 8},
+		{GP0PLL_CTRL0, 10, 5},
+	}),
+	[CLKID_HIFI_PLL_DCO] = CLK_PLL("hifi_pll_dco", EXTERNAL_PLL_XTAL, {
+		{HIFIPLL_CTRL0, 0, 8},
+		{HIFIPLL_CTRL0, 10, 5},
+	}),
+	[CLKID_HDMI_PLL_DCO] = CLK_PLL("hdmi_pll_dco", EXTERNAL_PLL_XTAL, {
+		{HDMIPLL_CTRL0, 0, 8},
+		{HDMIPLL_CTRL0, 10, 5},
+	}),
+
+	[CLKID_FIXED_PLL] = CLK_DIV2("fixed_pll", FIXPLL_CTRL0, 16, 2,
+		CLKID_FIXED_PLL_DCO
+	),
+	[CLKID_FCLK_DIV2_DIV] = CLK_DIV_FIXED("fclk_div2_div", 2,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV2P5_DIV] = CLK_DIV_FIXED_FULL("fclk_div2p5_div", 2, 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV3_DIV] = CLK_DIV_FIXED("fclk_div3_div", 3,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV4_DIV] = CLK_DIV_FIXED("fclk_div4_div", 4,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV5_DIV] = CLK_DIV_FIXED("fclk_div5_div", 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV7_DIV] = CLK_DIV_FIXED("fclk_div7_div", 7,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_GP0_PLL] = CLK_DIV2("gp0_pll", GP0PLL_CTRL0, 16, 3,
+		CLKID_GP0_PLL_DCO
+	),
+	[CLKID_HDMI_PLL_OD] = CLK_DIV2("hdmi_pll_od", HDMIPLL_CTRL0, 16, 4,
+		CLKID_HDMI_PLL_DCO
+	),
+	[CLKID_MPLL_50M_DIV] = CLK_DIV_FIXED("mpll_50m_div", 80,
+		CLKID_FIXED_PLL_DCO
+	),
+
+	[CLKID_FCLK_DIV2] = CLK_GATE("fclk_div2", FIXPLL_CTRL1, 24,
+		CLKID_FCLK_DIV2_DIV
+	),
+	[CLKID_FCLK_DIV2P5] = CLK_GATE("fclk_div2p5", FIXPLL_CTRL1, 25,
+		CLKID_FCLK_DIV2P5_DIV
+	),
+	[CLKID_FCLK_DIV3] = CLK_GATE("fclk_div3", FIXPLL_CTRL1, 20,
+		CLKID_FCLK_DIV3_DIV
+	),
+	[CLKID_FCLK_DIV4] = CLK_GATE("fclk_div4", FIXPLL_CTRL1, 21,
+		CLKID_FCLK_DIV4_DIV
+	),
+	[CLKID_FCLK_DIV5] = CLK_GATE("fclk_div5", FIXPLL_CTRL1, 22,
+		CLKID_FCLK_DIV5_DIV
+	),
+	[CLKID_FCLK_DIV7] = CLK_GATE("fclk_div7", FIXPLL_CTRL1, 23,
+		CLKID_FCLK_DIV7_DIV
+	),
+	[CLKID_HIFI_PLL] = CLK_DIV2("hifi_pll", HIFIPLL_CTRL0, 16, 2,
+		CLKID_HIFI_PLL_DCO
+	),
+	[CLKID_HDMI_PLL] = CLK_DIV("hdmi_pll", HDMIPLL_CTRL0, 20, 2,
+		CLKID_HDMI_PLL_OD
+	),
+	[CLKID_MPLL_50M] = CLK_MUX("mpll_50m", FIXPLL_CTRL3, 5, 1, {
+		EXTERNAL_PLL_XTAL,
+		CLKID_MPLL_50M_DIV,
+	}),
+	[CLKID_MPLL0] = CLK_GATE("mpll0", MPLL_CTRL1, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL1] = CLK_GATE("mpll1", MPLL_CTRL3, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL2] = CLK_GATE("mpll2", MPLL_CTRL5, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL3] = CLK_GATE("mpll3", MPLL_CTRL7, 31,
+		-ENOENT
+	),
+
+	[EXTERNAL_PLL_XTAL] = CLK_EXTERNAL("xtal"),
+};
+
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+{
+	switch (clk->id) {
+	case CLKID_SD_EMMC_A_CLK_DIV:
+	case CLKID_SD_EMMC_B_CLK_DIV:
+	case CLKID_SD_EMMC_C_CLK_DIV:
+		return meson_composite_set_rate(clk, rate);
+	case CLKID_SD_EMMC_A:
+	case CLKID_SD_EMMC_B:
+	case CLKID_SD_EMMC_C: {
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = meson_clk_get_parent(clk),
+		};
+
+		return meson_clk_set_rate(&parent, rate);
+	}
+	}
+
+	return -EINVAL;
+}
+
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv = dev_get_priv(dev);
+
+	return regmap_init_mem(dev_ofnode(dev), &priv->map);
+}
+
+struct meson_clk_data meson_s4_peripherals_info = {
+	.clocks = meson_clocks,
+	.num_clocks = ARRAY_SIZE(meson_clocks),
+};
+
+struct meson_clk_data meson_s4_pll_info = {
+	.clocks = meson_pll_clocks,
+	.num_clocks = ARRAY_SIZE(meson_pll_clocks),
+};
+
+static const struct udevice_id meson_clk_ids[] = {
+	{
+		.compatible = "amlogic,s4-peripherals-clkc",
+		.data = (ulong)&meson_s4_peripherals_info,
+	},
+	{
+		.compatible = "amlogic,s4-pll-clkc",
+		.data = (ulong)&meson_s4_pll_info,
+	},
+	{ }
+};
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+	.get_rate	= meson_clk_get_rate,
+	.set_rate	= meson_clk_set_rate,
+	.set_parent	= meson_clk_set_parent,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump		= meson_clk_dump,
+#endif
+};
+
+U_BOOT_DRIVER(meson_clk_s4) = {
+	.name		= "meson-clk-s4",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto	= sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
-- 
2.53.0


