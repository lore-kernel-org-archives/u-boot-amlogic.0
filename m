Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCCCAC581
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:39 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
 by mx.groups.io with SMTP id smtpd.web10.19823.1757255796704042715
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=c/mDycTV;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.188, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8KjNGMLCMAAWdUknWM1mT9RaS5Ls837EsQtrBJzTu0=;
	b=c/mDycTVs9dsKsiIx4K5+ZfHJ4+U9gntkYt9YUjg5F0T3evMxXWzST8pGmOsJnyUg37kcC
	YHUqXB1kSr5biyk5IkVYk8ZQx/bLECLIETzqbea5qJ13xecI/W3V85RNGm2dN9rU8BFDQN
	+bqn3YCqhu82Zp9uuT87QAIuI87qyr4qk9FjB32F5BxhfzXrFUOM73OWSIwGKr1rv3Lk/4
	CqFNcsfzt6F2qTOCBW5Dg/oJdvwd//psCwyHXNvoWgtUNfgDGQXytiiLOeD01DzehZjyak
	P0sv/mI5P0Tz5Xjz196U2qW8xVyBr9EQdddsnM4/5MMwPa2B88malRzaC8ESKg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:11 +0000
Subject: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18597;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=Je28SObmYCoxHrnBcqcWiavfeDvc/kKyz6Xw4Fjioj4=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhr4lQmkd7uptIjWuwesIRd1R0m93yfPJZow
 WdkGp+sSVyJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YawAKCRCEr8vQ14ma
 A6E4EACPrZgkdWFSG80ql48PzHCQfRi71h5nBVPyLUEFACn/J3ubQ/thA8tLnh4w5AHs5bAUKg3
 JDW9eyiGxjUgMAkH/xNO6xRbeD0YjvkQX0mY99c4P8qX7A9RU/1esRawIeGRm9vSFGNPXv8oKhr
 0qN/mouaszRQPztE3q01mDpFYuIl0gwKlyEEKH4LcSx0/uP1T2qyONxJ43RtjN/bPqj3fUB3oUM
 e4Ey7vWuheRuAEkDRipNy46ilXsRo9LisDTOJiVgZNp9nRqc2JhICLZWxjE7mIkAkYmgRA1kMb9
 T9yinKTxk1vRibcIeXysqj9qIeyOj/m4N6hBYlmZNSwzY6nq3TCJ53bfr58nj96z+j0ZGPSRr+y
 TVQ7+J+Wt/z6atln/8GjLVtKUt7f534IlXkLSaphtCI7cxBUSlAnWaPMJuUPH/3/XOZ0oytaHRu
 I6qVQokaqo3j40KYFWH4j/zVErEofCHn8Dvcc9/cUCYt3Gh9bvEG31bs+Sg6nwD9L2ctmhbHH1T
 qZNe5bm6IXdR+5uzV0pBiiwdJe+G+gBhwnOEfeaZLetOFuEyofd+3KPAnqavLI1OtDMa/a6AlaT
 jYdbVj9FdFhSeYl9QN+7Aw3IU5kYl0NiVads7SjX/s8CrqL25ewrsSMWq8RIGg8Yjrafx5fzEc8
 415VMhhlnUNl0WQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2748

Add initial boilerplate for U-Boot SPL support on Amlogic.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/clock-gx.h |   1 +
 arch/arm/include/asm/arch-meson/gx.h       |  36 ++++
 arch/arm/mach-meson/Kconfig                |  42 ++++-
 arch/arm/mach-meson/Makefile               |   5 +
 arch/arm/mach-meson/board-common.c         |  11 ++
 arch/arm/mach-meson/spl-gx.c               | 278 +++++++++++++++++++++++++++++
 arch/arm/mach-meson/spl.c                  | 123 +++++++++++++
 7 files changed, 495 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/clock-gx.h b/arch/arm/include/asm/arch-meson/clock-gx.h
index 13a2e7688fc569d8a217b424306570514ab011f4..23678230242be15476f6330ffd4e4658941b8330 100644
--- a/arch/arm/include/asm/arch-meson/clock-gx.h
+++ b/arch/arm/include/asm/arch-meson/clock-gx.h
@@ -87,6 +87,7 @@
 #define HHI_VDAC_CNTL0			0x2F4 /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1			0x2F8 /* 0xbe offset in data sheet */
 
+#define HHI_SYS_PLL_CNTL1		0x2fc /* 0xbf offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL2		0x304 /* 0xc1 offset in data sheet */
 #define HHI_SYS_PLL_CNTL3		0x308 /* 0xc2 offset in data sheet */
diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
index 8cfc6b00329f252bbf452dba00f8ad56b480c707..b4cb2a5ddbc9cef5d9133339c12aaa5bb62b4721 100644
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
index 7570f48e25fe477ce4dfb1eb608ed07b3a83d27f..8d1bf91e98b49822d036f10b5737a73247bc83c6 100644
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
index 535b0878b9105e7a83729bea65fa4cd70cd4beac..7dc8ec08cfc5fe6e79fc59fc4db745ca3dd2cd93 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -4,6 +4,11 @@
 
 obj-y += board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
+ifeq ($(CONFIG_SPL_BUILD),y)
+obj-$(CONFIG_MESON_GX) += spl-gx.o
+obj-$(CONFIG_MESON_GX) += spl.o
+endif
+
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 39774c43049a40ed11578086603717571bedd23b..c243c46c0fc14e1f0910a50ed65ce46a36b8e9db 100644
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
index 0000000000000000000000000000000000000000..65b301bc9ed89b7ca2156b7fa672ed4ef3f8633b
--- /dev/null
+++ b/arch/arm/mach-meson/spl-gx.c
@@ -0,0 +1,278 @@
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
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+#if defined(CONFIG_MESON_GXBB)
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
+#endif
+
+void board_fit_image_post_process(const void *fit, int node, void **p_image, size_t *p_size)
+{
+#if defined(CONFIG_MESON_GXBB)
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
+		send_scp(*p_image, *p_size, value, value_len);
+		break;
+	}
+#endif
+}
+#endif
+
+inline void cpu_pll_switch_to(int mode)
+{
+	u32 reg;
+
+	reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
+
+	while (reg & (1 << 28))
+		reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
+
+	reg |= (1 << 26);
+
+	if (mode == 1) {
+		/* Switch to System PLL */
+		reg |= (1 << 11);
+	} else {
+		if (reg & (1 << 10)) {
+			reg = (reg & ~((1 << 10) | (0x3f << 4) | (1 << 2) |
+				(0x3 << 0)));
+		} else {
+			reg = (reg & ~((1 << 10) | (0x3f << 20) |
+				(1 << 18) | (0x3 << 16))) | (1 << 10);
+		}
+		/* Select dynamic mux */
+		reg = reg & ~(1 << 11);
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
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
+		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
+	} else {
+		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
+		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
+	}
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
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
+		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
+	} else {
+		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
+		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
+	}
+}
diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..b3565402972f81c3cfd5824ba49cd713c1329a9d
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
+		if (CONFIG_IS_ENABLED(YMODEM))
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
2.51.0


