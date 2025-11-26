Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78570D10F33
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 12:17:45 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11621.1764159457847448920
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 04:17:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Hi5DBPcF;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.178, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764159456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol9ACT7ICEO1PIxZ14CyDCBLmsyx3lhF1mx35q7Uy4Y=;
	b=Hi5DBPcFYMTnSit4Xsb/dNPoKPIugcbG4EtYdx6XiGpQOYBPT/KQfUXevNqwjb66DZkodp
	6VQ+CeTJazWPrZW3i1HNs0WqNgXpQCkwciZac+lYqPbT/UvQtHmH6Ldk+Jde+Eabj69hZB
	w1U+f7fL4cXAe23jdJpaFlKKADy3qut/xS335OaAqeCBc5Tx9+PcH+O83HbJg1CN32SH2s
	y6ts+Xk+uHsMC2ODraeTWK+6NoH+if0wbfCaJtkCc2qmX4CIgs/JTQ5oudhHQ03JGatTQn
	+OtiIZ1vFVznbmxP28HFdpwMLolHsoU1Zk3k0hlJ8r0x0TXlRezDzO7mWXnuug==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:06 +0000
Subject: [PATCH v5 04/10] arm: meson: initial u-boot SPL support for GX
 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-4-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=20950;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=lclRBruiVswZ2TxSUkgae+mj8xJsBGV7ADz7LKVYoAc=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/XdpTRwuvlaS7AgfthSYlRO+aqQJHnvZs9W
 D2rvWaW0/+JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv1wAKCRCEr8vQ14ma
 A5KZEACB8a9/3a9XriWogWTFe1gAitJqPRCh7hATyOM24xmXjSK0Zy290zhWuaWgGeknj3sOxWU
 Q3b/THHCdxLndtPDFBF6lVvWWePDMbBdm+MZ/yQyqKxslaqokTu5wSoPQUT5bcLKcHqm/hPn5s5
 8xT4nBgeBQXgG2hh1i9Na8QiiEnDagDHZtwbsRhD98Jx/qs5p3J/qiZHZEEPAZSx59+V9Q2+Yg0
 eMvtnY2nAOgwl2l9jH38R5sNxDvyUXmrjtdhj5C1J97Hz8vTk/37oTg4EkS6AEHr4krGlFUxuEx
 3PnQMjy8N57jbSuQdo7aTbNmzlpz4sY2kZvmXstZ6NXrBU2bERR1Y1TIoeOY+rIdcb2JYS3xG+e
 4fLxuhgMP//yFFYppfYAGOpRpD5jVsFPs/SvUElReeSxDwboXTgZYc8pdnz0ZUOn1oPkO3E7Y75
 vGYB7WM6tSNe61hBVSkcLLfN9eRJvopLpfO8hWLPRVAiY8O4PplGM9+m88EjZhCSwzWCBeJ48+W
 EDBrl6/e/AnTHvkFZmry8xy1fyYSsCD65mCY91sTmpj3ZO4t4Kc0/czyBlJAxE7Z02c7h/e1DS8
 6lFE/MoZHiqrUZUkQQ07Qrr2xVR+JlrV8iK8Akasy1AMwein3rR9s7vjN28J8bgFsxC5tKOaJqd
 FMVw1YSXnbiYP5g==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 12:17:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2855

Add initial boilerplate for U-Boot SPL support on Amlogic.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/clock-gx.h |  14 +++
 arch/arm/include/asm/arch-meson/gx.h       |  36 +++++++
 arch/arm/mach-meson/Kconfig                |  42 +++++++-
 arch/arm/mach-meson/Makefile               |   7 ++
 arch/arm/mach-meson/board-common.c         |  11 ++
 arch/arm/mach-meson/spl-gx.c               | 168 +++++++++++++++++++++++++++++
 arch/arm/mach-meson/spl-gxbb.c             | 113 +++++++++++++++++++
 arch/arm/mach-meson/spl-gxl.c              |  39 +++++++
 arch/arm/mach-meson/spl.c                  | 123 +++++++++++++++++++++
 9 files changed, 552 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/clock-gx.h b/arch/arm/include/asm/arch-meson/clock-gx.h
index 13a2e7688fc..72e4bac7aad 100644
--- a/arch/arm/include/asm/arch-meson/clock-gx.h
+++ b/arch/arm/include/asm/arch-meson/clock-gx.h
@@ -87,6 +87,7 @@
 #define HHI_VDAC_CNTL0			0x2F4 /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1			0x2F8 /* 0xbe offset in data sheet */
 
+#define HHI_SYS_PLL_CNTL1		0x2fc /* 0xbf offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL2		0x304 /* 0xc1 offset in data sheet */
 #define HHI_SYS_PLL_CNTL3		0x308 /* 0xc2 offset in data sheet */
@@ -114,4 +115,17 @@
 
 ulong meson_measure_clk_rate(unsigned int clk);
 
+#if defined(CONFIG_SPL_BUILD)
+#define HHI_SCC_CNTL0_FINAL_MUX_SEL	BIT(11)
+#define HHI_SCC_CNTL0_FINAL_DYN_MUX_SEL	BIT(10)
+#define HHI_SCC_CNTL0_MUX0_DIVN_TCNT	(0x3f << 4)
+#define HHI_SCC_CNTL0_MUX1_DIVN_TCNT	(0x3f << 20)
+#define HHI_SCC_CNTL0_POSTMUX0	BIT(2)
+#define HHI_SCC_CNTL0_POSTMUX1	BIT(18)
+#define HHI_SCC_CNTL0_PREMUX0	3
+#define HHI_SCC_CNTL0_PREMUX1	(3 << 16)
+#define HHI_SCC_CNTL0_DYN_ENABLE	BIT(26)
+#define HHI_SCC_CNTL0_BUSY	BIT(28)
+#endif
+
 #endif
diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
index 8cfc6b00329..b4cb2a5ddbc 100644
--- a/arch/arm/include/asm/arch-meson/gx.h
+++ b/arch/arm/include/asm/arch-meson/gx.h
@@ -12,7 +12,10 @@
 
 #define GX_FIRMWARE_MEM_SIZE	0x1000000
 
+#define GX_MB_SRAM_BASE		0xd9013800
 #define GX_AOBUS_BASE		0xc8100000
+#define GX_SEC_HIU_MB_BASE	0xda83c400
+#define GX_SEC_AOBUS_BASE	0xda100000
 #define GX_PERIPHS_BASE	0xc8834400
 #define GX_HIU_BASE		0xc883c000
 #define GX_ETH_BASE		0xc9410000
@@ -24,6 +27,10 @@
 #define GX_AO_SEC_GP_CFG3	GX_AO_ADDR(0x93)
 #define GX_AO_SEC_GP_CFG4	GX_AO_ADDR(0x94)
 #define GX_AO_SEC_GP_CFG5	GX_AO_ADDR(0x95)
+#define GX_AO_SEC_SD_CFG15	GX_AO_ADDR(0x8f)
+
+#define GX_SEC_AO_ADDR(off)	(GX_SEC_AOBUS_BASE + ((off) << 2))
+#define GX_SEC_AO_SEC_GP_CFG0	GX_SEC_AO_ADDR(0x90)
 
 #define GX_AO_BOOT_DEVICE	0xF
 #define GX_AO_MEM_SIZE_MASK	0xFFFF0000
@@ -41,9 +48,38 @@
 #define GX_GPIO_IN(n)		GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 1)
 #define GX_GPIO_OUT(n)	GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 2)
 
+/* Mailbox registers */
+#define GX_SEC_HIU_MB_ADDR(off)	(GX_SEC_HIU_MB_BASE + ((off) << 2))
+#define GX_SEC_HIU_MAILBOX_SET_0	GX_SEC_HIU_MB_ADDR(0x01)
+#define GX_SEC_HIU_MAILBOX_STAT_0	GX_SEC_HIU_MB_ADDR(0x02)
+#define GX_SEC_HIU_MAILBOX_CLR_0	GX_SEC_HIU_MB_ADDR(0x03)
+
+/* Mailbox commands */
+#define GX_MB_CMD_SHA	0xc0de0001
+#define GX_MB_CMD_DATA	0xc0dec0de
+#define GX_MB_CMD_END	0xe00de00d
+#define GX_MB_CMD_OP_SHA	0xc0de0002
+#define GX_MB_CMD_DATA_LEN	0xc0dec0d0
+
+/* PIN_MUX registers */
+#define GX_PIN_MUX_REG1		(0xda834400 + (0x2d << 2))
+#define GX_PIN_MUX_REG2		(0xda834400 + (0x2e << 2))
+#define GX_PIN_MUX_REG3		(0xda834400 + (0x2f << 2))
+#define GX_PIN_MUX_REG7		(0xda834400 + (0x33 << 2))
+
+/* PWM registers */
+#define GX_PWM_PWM_B	(0xc1100000 + (0x2155 << 2))
+#define GX_PWM_PWM_D	(0xc1100000 + (0x2195 << 2))
+#define GX_PWM_MISC_REG_CD	(0xc1100000 + (0x2196 << 2))
+#define GX_PWM_MISC_REG_AB	(0xc1100000 + (0x2156 << 2))
+
 /* Non-DM MMC init */
 #if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
 struct mmc *meson_mmc_init(int mmc_no);
 #endif
 
+#if !CONFIG_IS_ENABLED(WDT_MESON_GXBB) && defined(CONFIG_SPL_BUILD)
+#define GX_WDT_CTRL_REG		0xc11098d0
+#endif
+
 #endif /* __GX_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 7570f48e25f..8d1bf91e98b 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -17,6 +17,8 @@ config MESON64_COMMON
 config MESON_GX
 	bool
 	select MESON64_COMMON
+	select SUPPORT_SPL
+	select BINMAN if SPL
 
 choice
 	prompt "Platform select"
@@ -69,7 +71,7 @@ config SYS_SOC
 	default "meson"
 
 config SYS_MALLOC_F_LEN
-	default 0x1000
+	default 0x2000
 
 config SYS_VENDOR
 	string "Vendor name"
@@ -93,4 +95,42 @@ config SYS_BOARD
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
 	  be used.
 
+if MESON_GX && SPL
+config SPL_SYS_MALLOC_F_LEN
+	default 0x2000
+
+choice
+	prompt "Set VDDEE init voltage"
+	default SPL_MESON_GX_VDDEE_1000MV
+	help
+	  This option is used to set the VDDEE voltage on boot up.
+	  If unsure, leave it to the board default.
+
+config SPL_MESON_GX_VDDEE_1000MV
+	bool "Set VDDEE to 1000 mv"
+
+config SPL_MESON_GX_VDDEE_1100MV
+	bool "Set VDDEE to 1100 mv"
+
+endchoice
+
+choice
+	prompt "Set VCCK init voltage"
+	default SPL_MESON_GX_VCCK_1100MV
+	help
+	  This option is used to set the VCCK voltage on boot up.
+	  If unsure, leave it to the board default.
+
+config SPL_MESON_GX_VCCK_1000MV
+	bool "Set VCCK to 1000 mv"
+
+config SPL_MESON_GX_VCCK_1100MV
+	bool "Set VCCK to 1100 mv"
+
+config SPL_MESON_GX_VCCK_1120MV
+	bool "Set VCCK to 1120 mv"
+
+endchoice
+
+endif
 endif
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b91..798b20df78a 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -4,6 +4,13 @@
 
 obj-y += board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
+ifeq ($(CONFIG_SPL_BUILD),y)
+obj-$(CONFIG_MESON_GXBB) += spl-gxbb.o
+obj-$(CONFIG_MESON_GXL) += spl-gxl.o
+obj-$(CONFIG_MESON_GX) += spl-gx.o
+obj-$(CONFIG_MESON_GX) += spl.o
+endif
+
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 39774c43049..c243c46c0fc 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -30,6 +30,7 @@ __weak int board_init(void)
 	return 0;
 }
 
+#ifndef CONFIG_SPL_BUILD
 int dram_init(void)
 {
 	const fdt64_t *val;
@@ -49,6 +50,7 @@ int dram_init(void)
 
 	return 0;
 }
+#endif
 
 __weak int meson_ft_board_setup(void *blob, struct bd_info *bd)
 {
@@ -150,5 +152,14 @@ int board_late_init(void)
 
 void reset_cpu(void)
 {
+#if CONFIG_SPL_BUILD
+	/*
+	 * We do not have BL31 running yet, so no PSCI.
+	 * Instead, let the watchdog reset the board.
+	 */
+	for (;;)
+		;
+#else
 	psci_system_reset();
+#endif
 }
diff --git a/arch/arm/mach-meson/spl-gx.c b/arch/arm/mach-meson/spl-gx.c
new file mode 100644
index 00000000000..a7d2b672421
--- /dev/null
+++ b/arch/arm/mach-meson/spl-gx.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#include <hang.h>
+#include <image.h>
+#include <spl.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/clock-gx.h>
+#include <asm/arch/gx.h>
+#include <linux/delay.h>
+
+/* Meson GX SPL code */
+
+inline void cpu_pll_switch_to(int mode)
+{
+	u32 reg;
+
+	reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
+
+	while (reg & HHI_SCC_CNTL0_BUSY)
+		reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
+
+	reg |= HHI_SCC_CNTL0_DYN_ENABLE;
+
+	if (mode == 1) {
+		/* Switch to System PLL */
+		reg |= HHI_SCC_CNTL0_FINAL_MUX_SEL;
+	} else {
+		if (reg & HHI_SCC_CNTL0_FINAL_DYN_MUX_SEL) {
+			reg = (reg & ~(HHI_SCC_CNTL0_FINAL_DYN_MUX_SEL |
+				HHI_SCC_CNTL0_MUX0_DIVN_TCNT |
+				HHI_SCC_CNTL0_POSTMUX0 | HHI_SCC_CNTL0_PREMUX0));
+		} else {
+			reg = (reg & ~(HHI_SCC_CNTL0_FINAL_DYN_MUX_SEL |
+				HHI_SCC_CNTL0_MUX1_DIVN_TCNT |
+				(HHI_SCC_CNTL0_POSTMUX1 | HHI_SCC_CNTL0_PREMUX1))) |
+				HHI_SCC_CNTL0_FINAL_DYN_MUX_SEL;
+		}
+		/* Select dynamic mux */
+		reg = reg & ~(HHI_SCC_CNTL0_FINAL_MUX_SEL) /*final_mux_sel*/;
+	}
+	writel(reg, GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
+}
+
+int meson_pll_init(void)
+{
+	clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
+	cpu_pll_switch_to(0);
+
+	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL6, 1 << 26);
+	udelay(100);
+
+	while (!((readl(GX_HIU_BASE + HHI_SYS_PLL_CNTL) >> 31) & 1)) {
+		if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+			setbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
+			writel(0x5ac80000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
+			writel(0x8e452015, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
+			writel(0x401d40c, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
+			writel(0x870, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
+			writel((1 << 30) | (1 << 29) |
+				((0 << 16) | (1 << 9) |
+				(1536 / 24)), /* 1.5 GHz */
+				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
+			clrbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
+		} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+			writel(0xc4258100, GX_HIU_BASE + HHI_SYS_PLL_CNTL1);
+			writel(0xb7400000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
+			writel(0xa59a288, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
+			writel(0x40002d, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
+			writel(0x7c700007, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
+			writel((1 << 30) | ((1 << 9) |
+				(1200 / 24)), /* 1.2 GHz */
+				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
+		}
+		udelay(20);
+	}
+	cpu_pll_switch_to(1); /* Hook the CPU to the PLL divider output */
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB))
+		writel(0x10007, GX_HIU_BASE + HHI_MPLL_CNTL4);
+	else if (IS_ENABLED(CONFIG_MESON_GXL))
+		writel(0x10006, GX_HIU_BASE + HHI_MPLL_CNTL4);
+
+	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
+	udelay(200);
+
+	writel(0x59C80000, GX_HIU_BASE + HHI_MPLL_CNTL2);
+	writel(0xCA45B822, GX_HIU_BASE + HHI_MPLL_CNTL3);
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB))
+		writel(0xB5500E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
+	else if (IS_ENABLED(CONFIG_MESON_GXL))
+		writel(0x95520E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
+
+	writel(0xFC454545, GX_HIU_BASE + HHI_MPLL_CNTL6);
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		writel((1 << 30) | (1 << 29) | (3 << 9) | (250 << 0), GX_HIU_BASE + HHI_MPLL_CNTL);
+		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
+	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+		writel((1 << 30) | (3 << 9) | (250 << 0), GX_HIU_BASE + HHI_MPLL_CNTL);
+	}
+	udelay(800);
+
+	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL4, 1 << 14);
+
+	while (!((readl(GX_HIU_BASE + HHI_MPLL_CNTL) >> 31) & 1)) {
+		if ((readl(GX_HIU_BASE + HHI_MPLL_CNTL) & (1 << 31)) != 0)
+			break;
+		setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
+		udelay(1000);
+		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
+		udelay(1000);
+	}
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		writel(0xFFF << 16, GX_HIU_BASE + HHI_MPLL_CNTL10);
+		writel(((7 << 16) | (1 << 15) | (1 << 14) | (4681 << 0)),
+		       GX_HIU_BASE + HHI_MPLL_CNTL7);
+		writel(((readl(GX_HIU_BASE + HHI_MPEG_CLK_CNTL) & (~((0x7 << 12) | (1 << 7) |
+			(0x7F << 0)))) | ((5 << 12) | (1 << 7)	| (2 << 0))),
+			GX_HIU_BASE + HHI_MPEG_CLK_CNTL);
+		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
+		writel(((5 << 16) | (1 << 15) | (1 << 14) | (12524 << 0)),
+		       GX_HIU_BASE + HHI_MPLL_CNTL8);
+	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+		writel((1 << 12) | 3, GX_HIU_BASE + HHI_MPLL_CNTL10);
+		writel(0x5edb7, GX_HIU_BASE + HHI_MPLL_CNTL7);
+		clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
+			   (3 << 13) | (1 << 12) | (15 << 4) | 15);
+		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
+			   (1 << 14) | (1 << 12) | (1 << 8) | (2 << 6) | (1 << 1));
+		writel((4 << 16) | (7 << 13) | (1 << 8) | (5 << 4) | 10,
+		       GX_HIU_BASE + HHI_MPLL_CNTL8);
+	}
+
+	udelay(200);
+
+	/* TODO: Some error handling and timeouts... */
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
+int board_mmc_init(struct bd_info *bis)
+{
+	int mmc_device;
+
+	switch (meson_get_boot_device()) {
+	case BOOT_DEVICE_SD:
+		mmc_device = 0;
+		break;
+	case BOOT_DEVICE_EMMC:
+		mmc_device = 1;
+		break;
+	default:
+		return -1;
+	}
+
+	if (!meson_mmc_init(mmc_device))
+		return -1;
+
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-meson/spl-gxbb.c b/arch/arm/mach-meson/spl-gxbb.c
new file mode 100644
index 00000000000..954254bd9ad
--- /dev/null
+++ b/arch/arm/mach-meson/spl-gxbb.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#include <image.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <asm/arch/gx.h>
+#include <linux/delay.h>
+
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+/*
+ * This is only needed for GXBB because on GXL SCP firmware loading
+ * has been moved to BL31.
+ */
+inline void send_scp(void *addr, size_t size, const uint8_t *sha2,
+	uint32_t sha2_length)
+{
+	int i;
+
+	puts("Trying to send the SCP firmware\n");
+	writel(size, GX_MB_SRAM_BASE);
+
+	udelay(500);
+
+	writel(GX_MB_CMD_DATA_LEN, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
+	while (readl(GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4))
+		;
+	udelay(500);
+
+	memcpy((void *)GX_MB_SRAM_BASE, (const void *)sha2, sha2_length);
+	writel(GX_MB_CMD_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
+	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
+		;
+	udelay(500);
+
+	for (i = 0; i < size; i += 1024) {
+		if (size >= i + 1024)
+			memcpy((void *)GX_MB_SRAM_BASE,
+			       (const void *)(unsigned long)(addr + i), 1024);
+		else if (size > i)
+			memcpy((void *)GX_MB_SRAM_BASE,
+			       (const void *)(unsigned long)(addr + i), (size - i));
+
+		writel(GX_MB_CMD_DATA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
+		while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
+			;
+	}
+	writel(GX_MB_CMD_OP_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
+
+	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
+		;
+	udelay(500);
+
+	/* We transferred all of the SCP firmware. Running it */
+	writel(GX_MB_CMD_END, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
+}
+
+void board_fit_image_post_process(const void *fit, int node, void **image, size_t *size)
+{
+	const char *name = fit_get_name(fit, node, NULL);
+	int noffset = 0, value_len;
+	u8 *value;
+
+	if (strcmp("scp", name) && strcmp("bl301", name))
+		return;
+
+	fdt_for_each_subnode(noffset, fit, node) {
+		if (strncmp(fit_get_name(fit, noffset, NULL),
+			    FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
+			continue;
+
+		if (fit_image_hash_get_value(fit, noffset, &value, &value_len))
+			continue;
+
+		/* Send the SCP firmware to the SCP */
+		send_scp(*image, *size, value, value_len);
+		break;
+	}
+}
+#endif
+
+void meson_power_init(void)
+{
+	/* TODO: Support more voltages */
+
+	/* Init PWM B */
+	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
+
+	/* Set voltage */
+	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
+		writel(0x02001a, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
+		writel(0x040018, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
+		writel(0x0e000e, GX_PWM_PWM_B);
+
+	clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
+	clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
+
+	/* Init PWM D */
+	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
+
+	/* Set voltage */
+	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
+		writel(0x040018, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
+		writel(0x0e000e, GX_PWM_PWM_B);
+
+	clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
+	setbits_32(GX_PIN_MUX_REG3, 1 << 20);
+}
diff --git a/arch/arm/mach-meson/spl-gxl.c b/arch/arm/mach-meson/spl-gxl.c
new file mode 100644
index 00000000000..07fff695be8
--- /dev/null
+++ b/arch/arm/mach-meson/spl-gxl.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#include <spl.h>
+#include <asm/io.h>
+#include <asm/arch/gx.h>
+
+void meson_power_init_gxl(void)
+{
+	/* TODO: Support more voltages */
+
+	/* Init PWM B */
+	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
+
+	/* Set voltage */
+	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
+		writel(0x02001a, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
+		writel(0x040018, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
+		writel(0x0e000e, GX_PWM_PWM_B);
+
+	clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
+	clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
+
+	/* Init PWM D */
+	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
+
+	/* Set voltage */
+	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
+		writel(0x040018, GX_PWM_PWM_B);
+	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
+		writel(0x0e000e, GX_PWM_PWM_B);
+
+	clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
+	setbits_32(GX_PIN_MUX_REG2, 1 << 12);
+}
diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
new file mode 100644
index 00000000000..28a63f39d36
--- /dev/null
+++ b/arch/arm/mach-meson/spl.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#include <spl.h>
+#include <hang.h>
+#include <asm/io.h>
+#include <asm/spl.h>
+#include <asm/arch/boot.h>
+#include <vsprintf.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <atf_common.h>
+#include <image.h>
+#include <asm/arch/gx.h>
+#include <linux/delay.h>
+#include <asm/arch/clock-gx.h>
+
+u32 spl_boot_device(void)
+{
+	int boot_device = meson_get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC2;
+	case BOOT_DEVICE_SD:
+		return BOOT_DEVICE_MMC1;
+	/*
+	 * TODO: Get USB DFU to work
+	 * Right now we just panic when booted from USB.
+	 */
+	case BOOT_DEVICE_USB:
+		if (CONFIG_IS_ENABLED(YMODEM_SUPPORT))
+			return BOOT_DEVICE_UART;
+		else
+			return BOOT_DEVICE_DFU;
+	}
+
+	panic("Unknown device %d\n", boot_device);
+	return BOOT_DEVICE_NONE; /* Never reached */
+}
+
+__weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+	return (void *)CONFIG_TEXT_BASE + 0x4000000;
+}
+
+__weak void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	/* HACK: use same fit load buffer address as for mmc raw */
+	return spl_get_load_buffer(0, fit_size);
+}
+
+__weak bool spl_load_simple_fit_skip_processing(void)
+{
+	return false;
+}
+
+/* To be defined in dram-${GENERATION}.c */
+__weak int dram_init(void)
+{
+	return 0;
+}
+
+/* Placeholder functions to be defined in SoC-specific spl-... file */
+__weak void meson_power_init(void)
+{
+}
+
+__weak int meson_pll_init(void)
+{
+	return 0;
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Restart execution at EL3 */
+	if (current_el() != 3) {
+		struct pt_regs regs = {0};
+		static struct entry_point_info spl_ep_info;
+
+		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
+		spl_ep_info.pc = CONFIG_SPL_TEXT_BASE;
+		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECPTIONS);
+
+		regs.regs[0] = 0xc0000000;
+		regs.regs[1] = (unsigned long)&spl_ep_info;
+		smc_call(&regs);
+	}
+
+	meson_power_init();
+	ret = meson_pll_init();
+	if (ret) {
+		debug("meson_pll_init() failed: %d\n", ret);
+		return;
+	}
+
+	ret = dram_init();
+	if (ret) {
+		debug("dram_init() failed: %d\n", ret);
+		hang();
+	}
+
+	if (CONFIG_IS_ENABLED(OF_CONTROL)) {
+		ret = spl_early_init();
+		if (ret) {
+			debug("spl_early_init() failed: %d\n", ret);
+			hang();
+		}
+	}
+
+	spl_init();
+	icache_enable();
+	preloader_console_init();
+
+#if !CONFIG_IS_ENABLED(WDT_MESON_GXBB)
+	/* Disable watchdog */
+	clrbits_32(GX_WDT_CTRL_REG, (1 << 18) | (1 << 25));
+#endif
+}

-- 
2.51.2


