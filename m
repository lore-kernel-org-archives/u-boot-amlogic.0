Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F6CCD19E
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:24 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
 by mx.groups.io with SMTP id smtpd.web10.22423.1760545577196378712
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 09:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=T2U3bncN;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.180, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760545575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Neto7zJwOWPlGpu3nE9QaE9dSRfqSWZJ+RYCSa5TQF4=;
	b=T2U3bncNxt5OIp+Cyya5h5LzmoQVhddeeQT8zCtmUZMAD+MBx1bTEBNNgi5+uxvQO3X77y
	5qmHKn6PGHkQeMJ8LzvXVY0+h0a5E7sXYNjkxy4We95V8VcMLP+22QzutYH7dWVXDMeoz7
	NXS7pRejwBpuAiJA11VZrRj/YbKJrzsGtLP5yrEN7P4+7y3rzqp8f1bCAabqC8autA1KbO
	s32ZnqpVnwXSMri/2zsEd7VPfw7BZVNZrRlGNH0lEjCmNZubd04waKuqdltSgYVHVdAkpP
	g7OODga/RdKP1aND7lXsV96mRlEGGobWdETPLYQCCulLtmrQK9V07fGoRVmMnQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:52 +0000
Subject: [PATCH v4 5/8] arm: meson: spl: add support for SPL DRAM init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251015-spl-gx-v4-5-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=69668;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=7aA4lZaZEYS592nYya9VqYMz47rUK9F0G1IxjhtGOWU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sfIx1/sKzw4/aRMadpZscU2OVzi/GWvreY7
 MSp2k5uvGOJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHwAKCRCEr8vQ14ma
 A7HrD/0U8YV5Val6OwDipV/uPr+nZSI+lsZ2q6rG4hmqeLm4WTGB/2WsuC2WRe+A6PS3P2Bke0S
 dZkdOAiY39OC3u+qTzq+pqjxnpKCuQf1vUaGlKflzj91IM8iXYAOuCl+ukuvWiD2R5pihe4Qir/
 xbbamiGZPibEqsZl6rC2zKFa5r6QKSBEIEeeSKmU0xJ11Uj5LXP5ffqPRHWYv9sU4devG6O1gTT
 ZQEZdRBWB+Logx6RzU6cDkIC9I+jxhQrfsL3N2zcJwzJAc4IttgdYJqgXivVY6kIhPBtWZaJwpL
 qn1P1EfPZW1BT3T2JKXhh54rYPyfaQ53+RQjPVjDv2UqaryOAGpHrBZPN4bdGuAZb96Aq6xgMpX
 /Nty90dtZPCaFmMwEvd9z8dmZGKoZbVnQZlq5stCn2Yw8PznknLLDUwJsavcogDJjRCvlffBHpQ
 cCasuFjJUZLq2dcrj8i2bWe4OzZI/nMvPQ0S/2BVU/qMVs40jAX9P1582TehwKI8mOo1yGqowR6
 88Hbu0zvXiSW2BlbZ2bhBJjiJVK7D6ttqioYRV1Q3Mhl2AyoB3u0OuUeEV21b33a5BougEtF24z
 OWVowNrUoG1S+H3zU1+0U1rhYQ7pyrGOOuMx3F9W73rntDQglKQaUu63TJRip+91TGiv6wXqzZ/
 tJ3F6NgtcpuLvuw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 16:26:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2816

Supports both GXBB and GXL SoCs.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++=
++
 arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
 arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
 arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
 arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
 arch/arm/mach-meson/Kconfig                        |  70 ++++
 arch/arm/mach-meson/Makefile                       |   3 +
 arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++=
++++++
 arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
 arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
 10 files changed, 1948 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/dram-gx.h b/arch/arm/include=
/asm/arch-meson/dram-gx.h
new file mode 100644
index 00000000000..177e0ac1a65
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/dram-gx.h
@@ -0,0 +1,341 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#ifndef DRAM_GX_H
+#define DRAM_GX_H
+
+/*
+ * Registers
+ */
+
+/* PCTL */
+#define DDR0_PCTL_BASE	0xc8839000
+/* DDR1_PCTL_BASE is DDR0_PCTL_BASE + 0x400 */
+
+/* DMC */
+#define DMC_REG_BASE	0xc8838000
+
+#define DMC_REQ_CTRL	(DMC_REG_BASE + (0x00 << 2))
+#define DMC_SOFT_RST	(DMC_REG_BASE + (0x01 << 2))
+#define DMC_SOFT_RST1	(DMC_REG_BASE + (0x02 << 2))
+#define DMC_RST_STS	(DMC_REG_BASE + (0x03 << 2))
+#define DMC_VERSION	(DMC_REG_BASE + (0x05 << 2))
+
+#define DMC_REFR_CTRL1	(DMC_REG_BASE + (0x23 << 2))
+#define DMC_REFR_CTRL2	(DMC_REG_BASE + (0x24 << 2))
+
+#define DMC_PCTL_LP_CTRL	(DMC_REG_BASE + (0x46 << 2))
+
+#define DMC_AM0_QOS_INC		(DMC_REG_BASE + (0x62 << 2))
+#define DMC_AM0_QOS_DEC		(DMC_REG_BASE + (0x64 << 2))
+#define DMC_AM0_QOS_DIS		(DMC_REG_BASE + (0x66 << 2))
+
+#define DMC_AM1_QOS_INC		(DMC_REG_BASE + (0x6c << 2))
+#define DMC_AM1_QOS_DEC		(DMC_REG_BASE + (0x6e << 2))
+#define DMC_AM1_QOS_DIS		(DMC_REG_BASE + (0x70 << 2))
+
+#define DMC_AM2_QOS_INC		(DMC_REG_BASE + (0x76 << 2))
+#define DMC_AM2_QOS_DEC		(DMC_REG_BASE + (0x78 << 2))
+#define DMC_AM2_QOS_DIS		(DMC_REG_BASE + (0x7a << 2))
+
+#define DMC_AM3_QOS_INC		(DMC_REG_BASE + (0x80 << 2))
+#define DMC_AM3_QOS_DEC		(DMC_REG_BASE + (0x82 << 2))
+#define DMC_AM3_QOS_DIS		(DMC_REG_BASE + (0x84 << 2))
+
+#define DMC_AM4_QOS_INC		(DMC_REG_BASE + (0x8a << 2))
+#define DMC_AM4_QOS_DEC		(DMC_REG_BASE + (0x8c << 2))
+#define DMC_AM4_QOS_DIS		(DMC_REG_BASE + (0x8e << 2))
+
+#define DMC_AM5_QOS_INC		(DMC_REG_BASE + (0x94 << 2))
+#define DMC_AM5_QOS_DEC		(DMC_REG_BASE + (0x96 << 2))
+#define DMC_AM5_QOS_DIS		(DMC_REG_BASE + (0x98 << 2))
+
+#define DMC_AM6_QOS_INC		(DMC_REG_BASE + (0x9e << 2))
+#define DMC_AM6_QOS_DEC		(DMC_REG_BASE + (0xa0 << 2))
+#define DMC_AM6_QOS_DIS		(DMC_REG_BASE + (0xa2 << 2))
+
+#define DMC_AM7_QOS_INC		(DMC_REG_BASE + (0xa8 << 2))
+#define DMC_AM7_QOS_DEC		(DMC_REG_BASE + (0xaa << 2))
+#define DMC_AM7_QOS_DIS		(DMC_REG_BASE + (0xac << 2))
+
+#define DMC_AXI0_QOS_INC	(DMC_REG_BASE + (0xb2 << 2))
+#define DMC_AXI0_QOS_DEC	(DMC_REG_BASE + (0xb4 << 2))
+#define DMC_AXI0_QOS_DIS	(DMC_REG_BASE + (0xb6 << 2))
+#define DMC_AXI0_QOS_CTRL1	(DMC_REG_BASE + (0xb9 << 2))
+
+#define DMC_AXI1_QOS_INC	(DMC_REG_BASE + (0xbc << 2))
+#define DMC_AXI1_QOS_DEC	(DMC_REG_BASE + (0xbe << 2))
+#define DMC_AXI1_QOS_DIS	(DMC_REG_BASE + (0xc0 << 2))
+
+#define DMC_AXI2_QOS_INC	(DMC_REG_BASE + (0xc6 << 2))
+#define DMC_AXI2_QOS_DEC	(DMC_REG_BASE + (0xc8 << 2))
+#define DMC_AXI2_QOS_DIS	(DMC_REG_BASE + (0xca << 2))
+
+#define DMC_AXI3_QOS_INC	(DMC_REG_BASE + (0xd0 << 2))
+#define DMC_AXI3_QOS_DEC	(DMC_REG_BASE + (0xd2 << 2))
+#define DMC_AXI3_QOS_DIS	(DMC_REG_BASE + (0xd4 << 2))
+
+#define DMC_AXI4_QOS_INC	(DMC_REG_BASE + (0xda << 2))
+#define DMC_AXI4_QOS_DEC	(DMC_REG_BASE + (0xdc << 2))
+#define DMC_AXI4_QOS_DIS	(DMC_REG_BASE + (0xde << 2))
+
+#define DMC_AXI5_QOS_INC	(DMC_REG_BASE + (0xe4 << 2))
+#define DMC_AXI5_QOS_DEC	(DMC_REG_BASE + (0xe6 << 2))
+#define DMC_AXI5_QOS_DIS	(DMC_REG_BASE + (0xe8 << 2))
+
+#define DMC_AXI6_QOS_INC	(DMC_REG_BASE + (0xee << 2))
+#define DMC_AXI6_QOS_DEC	(DMC_REG_BASE + (0xf0 << 2))
+#define DMC_AXI6_QOS_DIS	(DMC_REG_BASE + (0xf2 << 2))
+
+#define DMC_AXI7_QOS_INC	(DMC_REG_BASE + (0xf8 << 2))
+#define DMC_AXI7_QOS_DEC	(DMC_REG_BASE + (0xfa << 2))
+#define DMC_AXI7_QOS_DIS	(DMC_REG_BASE + (0xfc << 2))
+
+/* DDR MMC */
+#define AM_DDR_PLL_CNTL0	(DDR_MMC_BASE + 0x00)
+#define AM_DDR_PLL_CNTL1	(DDR_MMC_BASE + 0x04)
+#define AM_DDR_PLL_CNTL2	(DDR_MMC_BASE + 0x08)
+#define AM_DDR_PLL_CNTL3	(DDR_MMC_BASE + 0x0c)
+#define AM_DDR_PLL_CNTL4	(DDR_MMC_BASE + 0x10)
+#if defined(CONFIG_MESON_GXBB)
+#define AM_DDR_PLL_STS	(DDR_MMC_BASE + 0x14)
+#else
+#define AM_DDR_PLL_CNTL5	(DDR_MMC_BASE + 0x14)
+#endif
+
+#define DDR0_CLK_CTRL	(DDR_MMC_BASE + 0x400)
+
+/* DMC SEC */
+#define DMC_SEC_REG_BASE	0xda838400
+
+#define DMC_SEC_CTRL		(DMC_SEC_REG_BASE + (0x00 << 2))
+#define DMC_SEC_RANGE_CTRL	(DMC_SEC_REG_BASE + (0x07 << 2))
+#define DMC_SEC_AXI_PORT_CTRL	(DMC_SEC_REG_BASE + (0x0e << 2))
+
+#define DMC_VDEC_SEC_READ_CTRL		(DMC_SEC_REG_BASE + (0x10 << 2))
+#define DMC_VDEC_SEC_WRITE_CTRL		(DMC_SEC_REG_BASE + (0x11 << 2))
+#define DMC_VDEC_SEC_CFG		(DMC_SEC_REG_BASE + (0x12 << 2))
+
+#define DMC_HCODEC_SEC_READ_CTRL	(DMC_SEC_REG_BASE + (0x17 << 2))
+#define DMC_HCODEC_SEC_WRITE_CTRL	(DMC_SEC_REG_BASE + (0x18 << 2))
+#define DMC_HCODEC_SEC_CFG		(DMC_SEC_REG_BASE + (0x19 << 2))
+
+#define DMC_HEVC_SEC_READ_CTRL		(DMC_SEC_REG_BASE + (0x1e << 2))
+#define DMC_HEVC_SEC_WRITE_CTRL		(DMC_SEC_REG_BASE + (0x1f << 2))
+#define DMC_HEVC_SEC_CFG		(DMC_SEC_REG_BASE + (0x20 << 2))
+
+#define DMC_VPU_SEC_READ_CTRL	(DMC_SEC_REG_BASE + (0x32 << 2))
+#define DMC_VPU_SEC_WRITE_CTRL	(DMC_SEC_REG_BASE + (0x33 << 2))
+#define DMC_VPU_SEC_CFG		(DMC_SEC_REG_BASE + (0x25 << 2))
+
+#define DMC_GE2D_SEC_CTRL	(DMC_SEC_REG_BASE + (0x34 << 2))
+#define DMC_PARSER_SEC_CTRL	(DMC_SEC_REG_BASE + (0x35 << 2))
+#define DMC_DEV_SEC_READ_CTRL	(DMC_SEC_REG_BASE + (0x36 << 2))
+#define DMC_DEV_SEC_WRITE_CTRL	(DMC_SEC_REG_BASE + (0x37 << 2))
+
+#define DMC_WTCH0_CTRL	(DMC_SEC_REG_BASE + (0xa9 << 2))
+#define DMC_WTCH1_CTRL	(DMC_SEC_REG_BASE + (0xb0 << 2))
+
+#define DDR0_ADDRMAP_0	(DMC_SEC_REG_BASE + (0xd0 << 2))
+#define DDR0_ADDRMAP_1	(DMC_SEC_REG_BASE + (0xd1 << 2))
+#define DDR0_ADDRMAP_2	(DMC_SEC_REG_BASE + (0xd2 << 2))
+#define DDR0_ADDRMAP_3	(DMC_SEC_REG_BASE + (0xd3 << 2))
+#define DDR0_ADDRMAP_4	(DMC_SEC_REG_BASE + (0xd4 << 2))
+
+#define DDR1_ADDRMAP_0	(DMC_SEC_REG_BASE + (0xd5 << 2))
+#define DDR1_ADDRMAP_1	(DMC_SEC_REG_BASE + (0xd6 << 2))
+#define DDR1_ADDRMAP_2	(DMC_SEC_REG_BASE + (0xd7 << 2))
+#define DDR1_ADDRMAP_3	(DMC_SEC_REG_BASE + (0xd8 << 2))
+#define DDR1_ADDRMAP_4	(DMC_SEC_REG_BASE + (0xd9 << 2))
+
+#if defined(CONFIG_MESON_GXL)
+#define DMC_DES_KEY0_H	(DMC_SEC_REG_BASE + (0x90 << 2))
+#define DMC_DES_KEY0_L	(DMC_SEC_REG_BASE + (0x91 << 2))
+#define DMC_DES_KEY1_H	(DMC_SEC_REG_BASE + (0x92 << 2))
+#define DMC_DES_KEY1_L	(DMC_SEC_REG_BASE + (0x93 << 2))
+
+#define DMC_DES_CTRL	(DMC_SEC_REG_BASE + (0x9d << 2))
+#endif
+
+#define DMC_DDR_CTRL	(DMC_SEC_REG_BASE + (0xda << 2))
+
+#define AM_ANALOG_TOP_REG1	(0xc8834400 + (0x6f << 2))
+
+/* Macros */
+#define DQSCORR_DX(dx)							\
+	if ((readl(dx) & ~(0xe00)) && ((readl(dx) >> 8) & ~(0xe00)))	\
+		writel((((readl(dx) & ~(0xe00)) * 95) / 100) |		\
+			(((((readl(dx) >> 8) & ~(0xe00)) * 88) / 100) << 8) | \
+			(((((readl(dx) >> 8) & ~(0xe00)) * 88) / 100) << 16), \
+			dx);						\
+	else if (((readl(dx) >> 8) & ~(0xe00)))				\
+		writel((95 / 100) |					\
+			(((((readl(dx) >> 8) & ~(0xe00)) * 88) / 100) << 8) | \
+			(((((readl(dx) >> 8) & ~(0xe00)) * 88) / 100) << 16), \
+			dx);						\
+	else if (((readl(dx)) & ~(0xe00)))				\
+		writel((((readl(dx) & ~(0xe00)) * 95) / 100) |		\
+			(((88) / 100) << 8) | (((88) / 100) << 16),	\
+			dx);						\
+	else								\
+		writel((95 / 100) |					\
+			((88 / 100) << 8) | ((88 / 100) << 16), dx)
+
+#define DMC_ENABLE_REGION(REGION)					\
+	writel(0xffffffff, REGION## _SEC_CFG);				\
+	writel(0x55555555, REGION## _SEC_WRITE_CTRL);			\
+	writel(0x55555555, REGION## _SEC_READ_CTRL)
+
+/* TODO: Timeout */
+#define WAIT_FOR(a)							\
+	while (!(readl(a) & 1))						\
+		;							\
+	if (!(readl(a) & 1))						\
+		panic("%s: init failed, err=3D%d", __func__, -ETIMEDOUT)
+
+/**
+ * Register values
+ **/
+
+/*
+ * PLL
+ */
+#define DDR_CLK_CNTL_CLKGEN_SOFTRESET	BIT(28)
+#define DDR_CLK_CNTL_PHY_CLK_ENABLE	BIT(29)
+#define DDR_CLK_CNTL_DDRPLL_ENABLE	BIT(31)
+
+/*
+ * PCTL
+ */
+
+/* PCTL_SCTL: state control register (S905X datasheet p.451) */
+#define PCTL_SCTL_CFG_STATE	BIT(0)
+#define PCTL_SCTL_GO_STATE	BIT(1)
+
+/* PCTL_STAT */
+#define PCTL_STAT_ACCESS	(BIT(1) | BIT(0))
+
+/* PCTL_POWCTL: power control */
+#define PCTL_POWCTL_POWERON	BIT(0)
+
+/*
+ * PUB
+ */
+
+/* PUB_PGSR0: PHY General Status Register 0 */
+#define PUB_PGSR0_IDONE		BIT(0)	/* Initialization Done */
+#define PUB_PGSR0_PLDONE	BIT(1)	/* PLL Lock Done */
+#define PUB_PGSR0_DCDONE	BIT(2)	/* DDL Calibration Done */
+#define PUB_PGSR0_ZCDONE	BIT(3)	/* Impedance Calibration Done */
+#define PUB_PGSR0_DIDONE	BIT(4)	/* DRAM Initialization Done */
+#define PUB_PGSR0_WLDONE	BIT(5)	/* Write Leveling Done */
+#define PUB_PGSR0_QSGDONE	BIT(6)	/* DQS Gate Training Done */
+#define PUB_PGSR0_WLADONE	BIT(7)	/* Write Leveling Adjust Done */
+#define PUB_PGSR0_RDDONE	BIT(8)	/* Read Bit Deskew Done */
+#define PUB_PGSR0_WDDONE	BIT(9)	/* Write Bit Deskew Done */
+#define PUB_PGSR0_REDONE	BIT(10)	/* Read Eye Training Done */
+#define PUB_PGSR0_WEDONE	BIT(11)	/* Write Eye Training Done */
+#define PUB_PGSR0_ZCERR		BIT(20)	/* Impedance Calib Error */
+#define PUB_PGSR0_WLERR		BIT(21)	/* Write Leveling Error */
+#define PUB_PGSR0_QSGERR	BIT(22)	/* DQS Gate Training Error */
+#define PUB_PGSR0_WLAERR	BIT(23)	/* Write Leveling Adj Error */
+#define PUB_PGSR0_RDERR		BIT(24)	/* Read Bit Deskew Error */
+#define PUB_PGSR0_WDERR		BIT(25)	/* Write Bit Deskew Error */
+#define PUB_PGSR0_REERR		BIT(26)	/* Read Eye Training Error */
+#define PUB_PGSR0_WEERR		BIT(27)	/* Write Eye Training Error */
+
+/* PUB_PIR: PHY init register */
+#define PUB_PIR_INIT		BIT(0)
+#define PUB_PIR_ZCAL		BIT(1)
+#define PUB_PIR_CA		BIT(2)
+
+#define PUB_PIR_PLLINIT		BIT(4)
+#define PUB_PIR_DCAL		BIT(5)
+#define PUB_PIR_PHYRST		BIT(6)
+#define PUB_PIR_DRAMRST		BIT(7)
+#define PUB_PIR_DRAMINIT	BIT(8)
+#define PUB_PIR_WL		BIT(9)
+#define PUB_PIR_QSGATE		BIT(10)
+#define PUB_PIR_WLADJ		BIT(11)
+#define PUB_PIR_RDDSKW		BIT(12)
+#define PUB_PIR_WRDSKW		BIT(13)
+#define PUB_PIR_RDEYE		BIT(14)
+#define PUB_PIR_WREYE		BIT(15)
+#define PUB_PIR_ICPC		BIT(16)
+#define PUB_PIR_PLLBYP		BIT(17)
+#define PUB_PIR_CTLDINIT	BIT(18)
+#define PUB_PIR_RDIMMINIT	BIT(19)
+#define PUB_PIR_CLRSR		BIT(27)
+#define PUB_PIR_LOCKBYP		BIT(28)
+#define PUB_PIR_DCALBYP		BIT(29)
+#define PUB_PIR_ZCALBYP		BIT(30)
+#define PUB_PIR_INITBYP		BIT(31)
+
+#define PUB_PIR_FINAL_STEP	(PUB_PIR_INIT | PUB_PIR_ZCAL |			\
+	PUB_PIR_PLLINIT | PUB_PIR_DCAL | PUB_PIR_PHYRST | PUB_PIR_DRAMRST |	\
+	PUB_PIR_DRAMINIT | PUB_PIR_WL | PUB_PIR_QSGATE | PUB_PIR_WLADJ |	\
+	PUB_PIR_RDDSKW | PUB_PIR_WRDSKW | PUB_PIR_RDEYE | PUB_PIR_WREYE)
+
+/* Struct which holds timings (see dram-settings-gx.h) */
+struct meson_gx_dram_timings {
+	u8 drv;
+	u8 odt;
+	u8 rtp;
+	u8 wtr;
+	u8 rp;
+	u8 rcd;
+	u8 ras;
+	u8 rrd;
+	u8 rc;
+	u8 mrd;
+	u8 mod;
+	u8 faw;
+	u8 wlmrd;
+	u8 wlo;
+	ushort rfc;
+	u8 xp;
+	ushort xs;
+	ushort dllk;
+	u8 cke;
+	u8 rtodt;
+	u8 rtw;
+	u8 refi;
+	u8 refi_mddr3;
+	u8 cl;
+	u8 wr;
+	u8 cwl;
+	u8 al;
+	u8 dqs;
+	u8 cksre;
+	u8 cksrx;
+	u8 zqcs;
+	u8 xpdll;
+	ushort exsr;
+	ushort zqcl;
+	ushort zqcsi;
+	u8 rpab;
+	u8 rppb;
+	u8 tccdl;
+	u8 tdqsck;
+	u8 tdqsckmax;
+	u8 tckesr;
+	u8 tdpd;
+	u8 taond_aofd;
+};
+
+#if defined(CONFIG_MESON_GXBB)
+# include <asm/arch/dram-gxbb.h>
+#elif defined(CONFIG_MESON_GXL)
+# include <asm/arch/dram-gxl.h>
+#endif
+
+/* Functions */
+int dram_init(void);
+void meson_dram_prepare_pctl(void);
+void meson_dram_phy_init(void);
+void meson_dram_phy_setup_ranks(void);
+void meson_dram_finalise_init(void);
+extern const struct meson_gx_dram_timings timings;
+#endif
diff --git a/arch/arm/include/asm/arch-meson/dram-gxbb.h b/arch/arm/inclu=
de/asm/arch-meson/dram-gxbb.h
new file mode 100644
index 00000000000..b04f66d6336
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/dram-gxbb.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023-2025, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#ifndef DRAM_GXBB_H
+#define DRAM_GXBB_H
+
+/* PUB (not much documented) */
+#define DDR0_PUB_REG_BASE	0xc8836000
+
+#define DDR0_PUB_PIR	(DDR0_PUB_REG_BASE + (0x01 << 2))
+
+#define DDR0_PUB_PGCR1	(DDR0_PUB_REG_BASE + (0x03 << 2))
+#define DDR0_PUB_PGCR2	(DDR0_PUB_REG_BASE + (0x04 << 2))
+#define DDR0_PUB_PGCR3	(DDR0_PUB_REG_BASE + (0x05 << 2))
+#define DDR0_PUB_PGSR0	(DDR0_PUB_REG_BASE + (0x06 << 2))
+
+#define DDR0_PUB_ACLCDLR	(DDR0_PUB_REG_BASE + (0x0F << 2))
+#define DDR0_PUB_ACBDLR0	(DDR0_PUB_REG_BASE + (0x10 << 2))
+#define DDR0_PUB_ACIOCR1	(DDR0_PUB_REG_BASE + (0x1B << 2))
+#define DDR0_PUB_ACIOCR2	(DDR0_PUB_REG_BASE + (0x1C << 2))
+#define DDR0_PUB_ACIOCR3	(DDR0_PUB_REG_BASE + (0x1D << 2))
+#define DDR0_PUB_ACIOCR4	(DDR0_PUB_REG_BASE + (0x1E << 2))
+#define DDR0_PUB_ACIOCR5	(DDR0_PUB_REG_BASE + (0x1F << 2))
+
+#define DDR0_PUB_DXCCR	(DDR0_PUB_REG_BASE + (0x20 << 2))
+#define DDR0_PUB_DSGCR	(DDR0_PUB_REG_BASE + (0x21 << 2))
+#define DDR0_PUB_DCR	(DDR0_PUB_REG_BASE + (0x22 << 2))
+
+#define DDR0_PUB_DTPR0	(DDR0_PUB_REG_BASE + (0x23 << 2))
+#define DDR0_PUB_DTPR1	(DDR0_PUB_REG_BASE + (0x24 << 2))
+#define DDR0_PUB_DTPR2	(DDR0_PUB_REG_BASE + (0x25 << 2))
+#define DDR0_PUB_DTPR3	(DDR0_PUB_REG_BASE + (0x26 << 2))
+
+#define DDR0_PUB_MR0	(DDR0_PUB_REG_BASE + (0x27 << 2))
+#define DDR0_PUB_MR1	(DDR0_PUB_REG_BASE + (0x28 << 2))
+#define DDR0_PUB_MR2	(DDR0_PUB_REG_BASE + (0x29 << 2))
+#define DDR0_PUB_MR3	(DDR0_PUB_REG_BASE + (0x2A << 2))
+
+#define DDR0_PUB_ODTCR	(DDR0_PUB_REG_BASE + (0x2B << 2))
+
+#define DDR0_PUB_DTCR	(DDR0_PUB_REG_BASE + (0x2C << 2))
+
+#define DDR0_PUB_DTAR0	(DDR0_PUB_REG_BASE + (0x2D << 2))
+#define DDR0_PUB_DTAR1	(DDR0_PUB_REG_BASE + (0x2E << 2))
+#define DDR0_PUB_DTAR2	(DDR0_PUB_REG_BASE + (0x2F << 2))
+#define DDR0_PUB_DTAR3	(DDR0_PUB_REG_BASE + (0x30 << 2))
+
+#define DDR0_PUB_IOVCR0	(DDR0_PUB_REG_BASE + (0x8E << 2))
+#define DDR0_PUB_IOVCR1	(DDR0_PUB_REG_BASE + (0x8F << 2))
+
+#define DDR0_PUB_ZQCR	(DDR0_PUB_REG_BASE + (0x90 << 2))
+
+#define DDR0_PUB_ZQ0PR	(DDR0_PUB_REG_BASE + (0x91 << 2))
+#define DDR0_PUB_ZQ1PR	(DDR0_PUB_REG_BASE + (0x95 << 2))
+#define DDR0_PUB_ZQ2PR	(DDR0_PUB_REG_BASE + (0x99 << 2))
+#define DDR0_PUB_ZQ3PR	(DDR0_PUB_REG_BASE + (0x9D << 2))
+
+#define DDR0_PUB_DX0GCR1	(DDR0_PUB_REG_BASE + (0xA1 << 2))
+#define DDR0_PUB_DX0GCR2	(DDR0_PUB_REG_BASE + (0xA2 << 2))
+#define DDR0_PUB_DX0GCR3	(DDR0_PUB_REG_BASE + (0xA3 << 2))
+
+#define DDR0_PUB_DX0LCDLR0	(DDR0_PUB_REG_BASE + (0xAE << 2))
+#define DDR0_PUB_DX0LCDLR2	(DDR0_PUB_REG_BASE + (0xB0 << 2))
+
+#define DDR0_PUB_DX0GTR		(DDR0_PUB_REG_BASE + (0xB2 << 2))
+#define DDR0_PUB_DX1GTR		(DDR0_PUB_REG_BASE + (0xD2 << 2))
+#define DDR0_PUB_DX2GTR		(DDR0_PUB_REG_BASE + (0xF2 << 2))
+#define DDR0_PUB_DX3GTR		(DDR0_PUB_REG_BASE + (0x112 << 2))
+
+#define DDR0_PUB_DX1GCR1	(DDR0_PUB_REG_BASE + (0xC1 << 2))
+#define DDR0_PUB_DX1GCR2	(DDR0_PUB_REG_BASE + (0xC2 << 2))
+#define DDR0_PUB_DX1GCR3	(DDR0_PUB_REG_BASE + (0xC3 << 2))
+#define DDR0_PUB_DX1LCDLR0	(DDR0_PUB_REG_BASE + (0xCE << 2))
+#define DDR0_PUB_DX1LCDLR2	(DDR0_PUB_REG_BASE + (0xD0 << 2))
+
+#define DDR0_PUB_DX2GCR1	(DDR0_PUB_REG_BASE + (0xE1 << 2))
+#define DDR0_PUB_DX2GCR2	(DDR0_PUB_REG_BASE + (0xE2 << 2))
+#define DDR0_PUB_DX2GCR3	(DDR0_PUB_REG_BASE + (0xE3 << 2))
+#define DDR0_PUB_DX2LCDLR2	(DDR0_PUB_REG_BASE + (0xF0 << 2))
+
+#define DDR0_PUB_DX3GCR1	(DDR0_PUB_REG_BASE + (0x101 << 2))
+#define DDR0_PUB_DX3GCR2	(DDR0_PUB_REG_BASE + (0x102 << 2))
+#define DDR0_PUB_DX3GCR3	(DDR0_PUB_REG_BASE + (0x103 << 2))
+#define DDR0_PUB_DX3LCDLR0	(DDR0_PUB_REG_BASE + (0x10E << 2))
+#define DDR0_PUB_DX3LCDLR2	(DDR0_PUB_REG_BASE + (0x110 << 2))
+
+/* PCTL */
+#define DDR0_PCTL_BASE	0xc8839000
+/* DDR1_PCTL_BASE is DDR0_PCTL_BASE + 0x400 */
+
+#define PCTL_SCFG	(DDR0_PCTL_BASE + 0x000)
+#define PCTL_SCTL	(DDR0_PCTL_BASE + (0x1  << 2))
+#define PCTL_STAT	(DDR0_PCTL_BASE + (0x2  << 2))
+
+#define PCTL_POWSTAT	(DDR0_PCTL_BASE + (0x12 << 2))
+#define PCTL_POWCTL	(DDR0_PCTL_BASE + (0x11 << 2))
+
+#define PCTL_CMDTSTAT	(DDR0_PCTL_BASE + (0x13 << 2))
+#define PCTL_CMDTSTATEN	(DDR0_PCTL_BASE + (0x14 << 2))
+
+#define PCTL_PPCFG	(DDR0_PCTL_BASE + (0x21 << 2))
+
+#define PCTL_MCFG	(DDR0_PCTL_BASE + (0x20 << 2))
+#define PCTL_MCFG1	(DDR0_PCTL_BASE + (0x1f << 2))
+
+#define PCTL_TCKSRE	(DDR0_PCTL_BASE + (0x49 << 2))
+#define PCTL_TZQCSI	(DDR0_PCTL_BASE + (0x47 << 2))
+#define PCTL_TINIT		(DDR0_PCTL_BASE + (0x31 << 2))
+#define PCTL_TOGCNT1U	(DDR0_PCTL_BASE + (0x30 << 2))
+#define PCTL_TCKE		(DDR0_PCTL_BASE + (0x4b << 2))
+#define PCTL_TMOD		(DDR0_PCTL_BASE + (0x4c << 2))
+#define PCTL_TEXSR		(DDR0_PCTL_BASE + (0x43 << 2))
+#define PCTL_TAL		(DDR0_PCTL_BASE + (0x39 << 2))
+#define PCTL_TRTP		(DDR0_PCTL_BASE + (0x40 << 2))
+#define PCTL_TCKSRX	(DDR0_PCTL_BASE + (0x4a << 2))
+#define PCTL_TRTW		(DDR0_PCTL_BASE + (0x38 << 2))
+#define PCTL_TCWL		(DDR0_PCTL_BASE + (0x3b << 2))
+#define PCTL_TWR		(DDR0_PCTL_BASE + (0x41 << 2))
+#define PCTL_TCL		(DDR0_PCTL_BASE + (0x3a << 2))
+#define PCTL_TDQS		(DDR0_PCTL_BASE + (0x48 << 2))
+#define PCTL_TRSTH		(DDR0_PCTL_BASE + (0x32 << 2))
+#define PCTL_TRCD		(DDR0_PCTL_BASE + (0x3e << 2))
+#define PCTL_TXP		(DDR0_PCTL_BASE + (0x44 << 2))
+#define PCTL_TOGCNT100N	(DDR0_PCTL_BASE + (0x33 << 2))
+#define PCTL_TMRD		(DDR0_PCTL_BASE + (0x35 << 2))
+#define PCTL_TREFI		(DDR0_PCTL_BASE + (0x34 << 2))
+#define PCTL_TRAS		(DDR0_PCTL_BASE + (0x3c << 2))
+#define PCTL_TREFI_MEM_DDR3	(DDR0_PCTL_BASE + (0x52 << 2))
+#define PCTL_TWTR		(DDR0_PCTL_BASE + (0x42 << 2))
+#define PCTL_TRC		(DDR0_PCTL_BASE + (0x3d << 2))
+#define PCTL_TRFC		(DDR0_PCTL_BASE + (0x36 << 2))
+#define PCTL_TCKESR	(DDR0_PCTL_BASE + (0x50 << 2))
+#define PCTL_TZQCL		(DDR0_PCTL_BASE + (0x4e << 2))
+#define PCTL_TRRD		(DDR0_PCTL_BASE + (0x3f << 2))
+#define PCTL_TRP		(DDR0_PCTL_BASE + (0x37 << 2))
+#define PCTL_TZQCS		(DDR0_PCTL_BASE + (0x46 << 2))
+#define PCTL_TXPDLL	(DDR0_PCTL_BASE + (0x45 << 2))
+
+#define PCTL_DFIODTCFG	(DDR0_PCTL_BASE + (0x91 << 2))
+#define PCTL_DFIODTCFG1	(DDR0_PCTL_BASE + (0x92 << 2))
+#define PCTL_DFITCTRLDELAY	(DDR0_PCTL_BASE + (0x90 << 2))
+#define PCTL_DFITPHYWRLAT	(DDR0_PCTL_BASE + (0x95 << 2))
+#define PCTL_DFITPHYWRDATA	(DDR0_PCTL_BASE + (0x94 << 2))
+#define PCTL_DFITRDDATAEN	(DDR0_PCTL_BASE + (0x98 << 2))
+#define PCTL_DFITPHYRDLAT	(DDR0_PCTL_BASE + (0x99 << 2))
+#define PCTL_DFITPHYUPDTYPE1	(DDR0_PCTL_BASE + (0x9d << 2))
+#define PCTL_DFISTCFG0	(DDR0_PCTL_BASE + (0xb1 << 2))
+#define PCTL_DFISTCFG1	(DDR0_PCTL_BASE + (0xb2 << 2))
+#define PCTL_DFISTSTAT0	(DDR0_PCTL_BASE + (0xb0 << 2))
+#define PCTL_DFILPCFG0	(DDR0_PCTL_BASE + (0xbc << 2))
+#define PCTL_DFITCTRLUPDMIN	(DDR0_PCTL_BASE + (0xa0 << 2))
+#define PCTL_DFITDRAMCLKEN	(DDR0_PCTL_BASE + (0xb4 << 2))
+#define PCTL_DFITDRAMCLKDIS	(DDR0_PCTL_BASE + (0xb5 << 2))
+
+/* DDR MMC (see dram-gx.h for more details) */
+#define DDR_MMC_BASE	0xc8836800
+
+#define DDR0_SOFT_RESET	(DDR_MMC_BASE + 0x404)
+#define DDR_CLK_CNTL	(DDR_MMC_BASE + 0x18)
+#define DDR0_APD_CTRL	(DDR_MMC_BASE + 0x408)
+
+/* These will get optimized out by the compiler */
+#define AM_DDR_PLL_CNTL5	0
+#define PCTL_TCCD		0
+#define PCTL_TFAW		0
+#endif
diff --git a/arch/arm/include/asm/arch-meson/dram-gxl.h b/arch/arm/includ=
e/asm/arch-meson/dram-gxl.h
new file mode 100644
index 00000000000..c52ef37c1bf
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/dram-gxl.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023-2025, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#ifndef DRAM_GXL_H
+#define DRAM_GXL_H
+
+/* PUB (not much documented) */
+#define DDR0_PUB_REG_BASE	0xc8836000
+
+#define DDR0_PUB_PIR	(DDR0_PUB_REG_BASE + (0x01 << 2))
+
+#define DDR0_PUB_PGCR1	(DDR0_PUB_REG_BASE + (0x05 << 2))
+#define DDR0_PUB_PGCR2	(DDR0_PUB_REG_BASE + (0x06 << 2))
+#define DDR0_PUB_PGCR3	(DDR0_PUB_REG_BASE + (0x07 << 2))
+#define DDR0_PUB_PGCR4	(DDR0_PUB_REG_BASE + (0x08 << 2))
+#define DDR0_PUB_PGCR5	(DDR0_PUB_REG_BASE + (0x09 << 2))
+#define DDR0_PUB_PGCR6	(DDR0_PUB_REG_BASE + (0x0a << 2))
+#define DDR0_PUB_PGSR0	(DDR0_PUB_REG_BASE + (0x0d << 2))
+
+#define DDR0_PUB_ACLCDLR	(DDR0_PUB_REG_BASE + (0x160 << 2))
+#define DDR0_PUB_ACMDLR0	(DDR0_PUB_REG_BASE + (0x168 << 2))
+#define DDR0_PUB_ACBDLR0	(DDR0_PUB_REG_BASE + (0x150 << 2))
+#define DDR0_PUB_ACBDLR1	(DDR0_PUB_REG_BASE + (0x151 << 2))
+#define DDR0_PUB_ACBDLR2	(DDR0_PUB_REG_BASE + (0x152 << 2))
+#define DDR0_PUB_ACBDLR3	(DDR0_PUB_REG_BASE + (0x153 << 2))
+#define DDR0_PUB_ACBDLR6	(DDR0_PUB_REG_BASE + (0x156 << 2))
+#define DDR0_PUB_ACBDLR7	(DDR0_PUB_REG_BASE + (0x157 << 2))
+#define DDR0_PUB_ACBDLR8	(DDR0_PUB_REG_BASE + (0x158 << 2))
+#define DDR0_PUB_ACBDLR9	(DDR0_PUB_REG_BASE + (0x159 << 2))
+#define DDR0_PUB_ACIOCR1	(DDR0_PUB_REG_BASE + (0x141 << 2))
+#define DDR0_PUB_ACIOCR2	(DDR0_PUB_REG_BASE + (0x142 << 2))
+#define DDR0_PUB_ACIOCR3	(DDR0_PUB_REG_BASE + (0x143 << 2))
+#define DDR0_PUB_ACIOCR4	(DDR0_PUB_REG_BASE + (0x144 << 2))
+#define DDR0_PUB_ACIOCR5	(DDR0_PUB_REG_BASE + (0x145 << 2))
+
+#define DDR0_PUB_PTR3	(DDR0_PUB_REG_BASE + (0x13 << 2))
+#define DDR0_PUB_PTR4	(DDR0_PUB_REG_BASE + (0x14 << 2))
+
+#define DDR0_PUB_DXCCR	(DDR0_PUB_REG_BASE + (0x22 << 2))
+#define DDR0_PUB_DSGCR	(DDR0_PUB_REG_BASE + (0x24 << 2))
+#define DDR0_PUB_DCR	(DDR0_PUB_REG_BASE + (0x40 << 2))
+
+#define DDR0_PUB_DTPR0	(DDR0_PUB_REG_BASE + (0x44 << 2))
+#define DDR0_PUB_DTPR1	(DDR0_PUB_REG_BASE + (0x45 << 2))
+#define DDR0_PUB_DTPR2	(DDR0_PUB_REG_BASE + (0x46 << 2))
+#define DDR0_PUB_DTPR3	(DDR0_PUB_REG_BASE + (0x47 << 2))
+#define DDR0_PUB_DTPR4	(DDR0_PUB_REG_BASE + (0x48 << 2))
+#define DDR0_PUB_DTPR5	(DDR0_PUB_REG_BASE + (0x49 << 2))
+
+#define DDR0_PUB_MR0	(DDR0_PUB_REG_BASE + (0x60 << 2))
+#define DDR0_PUB_MR1	(DDR0_PUB_REG_BASE + (0x61 << 2))
+#define DDR0_PUB_MR2	(DDR0_PUB_REG_BASE + (0x62 << 2))
+#define DDR0_PUB_MR3	(DDR0_PUB_REG_BASE + (0x63 << 2))
+#define DDR0_PUB_MR4	(DDR0_PUB_REG_BASE + (0x64 << 2))
+#define DDR0_PUB_MR5	(DDR0_PUB_REG_BASE + (0x65 << 2))
+#define DDR0_PUB_MR6	(DDR0_PUB_REG_BASE + (0x66 << 2))
+#define DDR0_PUB_MR11	(DDR0_PUB_REG_BASE + (0x6b << 2))
+
+#define DDR0_PUB_ODTCR	(DDR0_PUB_REG_BASE + (0x26 << 2))
+
+#define DDR0_PUB_DTCR	(DDR0_PUB_REG_BASE + (0x80 << 2))
+#define DDR0_PUB_DTCR1	(DDR0_PUB_REG_BASE + (0x81 << 2))
+
+#define DDR0_PUB_DTAR0	(DDR0_PUB_REG_BASE + (0x82 << 2))
+#define DDR0_PUB_DTAR1	(DDR0_PUB_REG_BASE + (0x83 << 2))
+#define DDR0_PUB_DTAR2	(DDR0_PUB_REG_BASE + (0x84 << 2))
+#define DDR0_PUB_DTAR3	(DDR0_PUB_REG_BASE + (0x85 << 2))
+
+#define DDR0_PUB_RANKIDR	(DDR0_PUB_REG_BASE + (0x137 << 2))
+
+#define DDR0_PUB_IOVCR0	(DDR0_PUB_REG_BASE + (0x148 << 2))
+#define DDR0_PUB_IOVCR1	(DDR0_PUB_REG_BASE + (0x149 << 2))
+
+#define DDR0_PUB_VTCR0	(DDR0_PUB_REG_BASE + (0x14a << 2))
+#define DDR0_PUB_VTCR1	(DDR0_PUB_REG_BASE + (0x14b << 2))
+
+#define DDR0_PUB_ZQCR	(DDR0_PUB_REG_BASE + (0x1a0 << 2))
+
+#define DDR0_PUB_ZQ0PR	(DDR0_PUB_REG_BASE + (0x1a1 << 2))
+#define DDR0_PUB_ZQ1PR	(DDR0_PUB_REG_BASE + (0x1a5 << 2))
+#define DDR0_PUB_ZQ2PR	(DDR0_PUB_REG_BASE + (0x1a9 << 2))
+#define DDR0_PUB_ZQ3PR	(DDR0_PUB_REG_BASE + (0x1ad << 2))
+
+#define DDR0_PUB_DX0GCR1	(DDR0_PUB_REG_BASE + (0x1c1 << 2))
+#define DDR0_PUB_DX0GCR2	(DDR0_PUB_REG_BASE + (0x1c2 << 2))
+#define DDR0_PUB_DX0GCR3	(DDR0_PUB_REG_BASE + (0x1c3 << 2))
+#define DDR0_PUB_DX0GCR4	(DDR0_PUB_REG_BASE + (0x1c4 << 2))
+#define DDR0_PUB_DX0LCDLR0	(DDR0_PUB_REG_BASE + (0x1e0 << 2))
+#define DDR0_PUB_DX0LCDLR2	(DDR0_PUB_REG_BASE + (0x1e2 << 2))
+
+#define DDR0_PUB_DX0GTR		(DDR0_PUB_REG_BASE + (0x1f0 << 2))
+#define DDR0_PUB_DX1GTR		(DDR0_PUB_REG_BASE + (0x230 << 2))
+#define DDR0_PUB_DX2GTR		(DDR0_PUB_REG_BASE + (0x270 << 2))
+#define DDR0_PUB_DX3GTR		(DDR0_PUB_REG_BASE + (0x2b0 << 2))
+
+#define DDR0_PUB_DX1GCR1	(DDR0_PUB_REG_BASE + (0x201 << 2))
+#define DDR0_PUB_DX1GCR2	(DDR0_PUB_REG_BASE + (0x202 << 2))
+#define DDR0_PUB_DX1GCR3	(DDR0_PUB_REG_BASE + (0x203 << 2))
+#define DDR0_PUB_DX1GCR4	(DDR0_PUB_REG_BASE + (0x204 << 2))
+#define DDR0_PUB_DX1LCDLR0	(DDR0_PUB_REG_BASE + (0x220 << 2))
+#define DDR0_PUB_DX1LCDLR2	(DDR0_PUB_REG_BASE + (0x222 << 2))
+
+#define DDR0_PUB_DX2GCR0	(DDR0_PUB_REG_BASE + (0x240 << 2))
+#define DDR0_PUB_DX2GCR1	(DDR0_PUB_REG_BASE + (0x241 << 2))
+#define DDR0_PUB_DX2GCR2	(DDR0_PUB_REG_BASE + (0x242 << 2))
+#define DDR0_PUB_DX2GCR3	(DDR0_PUB_REG_BASE + (0x243 << 2))
+#define DDR0_PUB_DX2GCR4	(DDR0_PUB_REG_BASE + (0x244 << 2))
+#define DDR0_PUB_DX2LCDLR0	(DDR0_PUB_REG_BASE + (0x260 << 2))
+#define DDR0_PUB_DX2LCDLR2	(DDR0_PUB_REG_BASE + (0x262 << 2))
+
+#define DDR0_PUB_DX3GCR0	(DDR0_PUB_REG_BASE + (0x280 << 2))
+#define DDR0_PUB_DX3GCR1	(DDR0_PUB_REG_BASE + (0x281 << 2))
+#define DDR0_PUB_DX3GCR2	(DDR0_PUB_REG_BASE + (0x282 << 2))
+#define DDR0_PUB_DX3GCR3	(DDR0_PUB_REG_BASE + (0x283 << 2))
+#define DDR0_PUB_DX3GCR4	(DDR0_PUB_REG_BASE + (0x284 << 2))
+#define DDR0_PUB_DX3LCDLR0	(DDR0_PUB_REG_BASE + (0x2a0 << 2))
+#define DDR0_PUB_DX3LCDLR2	(DDR0_PUB_REG_BASE + (0x2a2 << 2))
+
+/* PCTL */
+#define DMC_PCTL_BASE	0xc8839000
+
+#define PCTL_SCFG	(DDR0_PCTL_BASE + 0x000)
+#define PCTL_SCTL	(DDR0_PCTL_BASE + (0x1  << 2))
+#define PCTL_STAT	(DDR0_PCTL_BASE + (0x48 << 2))
+
+#define PCTL_CMDTSTAT	(DDR0_PCTL_BASE + (0x48 << 2))
+
+#define PCTL_PPCFG	(DDR0_PCTL_BASE + (0x43 << 2))
+#define PCTL_ZQCFG	(DDR0_PCTL_BASE + (0x44 << 2))
+
+#define PCTL_MCFG	(DDR0_PCTL_BASE + (0x41 << 2))
+#define PCTL_MCFG1	(DDR0_PCTL_BASE + (0x42 << 2))
+
+#define PCTL_TCKSRE	(DDR0_PCTL_BASE + (0x1a << 2))
+#define PCTL_TZQCSI	(DDR0_PCTL_BASE + (0x19 << 2))
+#define PCTL_TCKE		(DDR0_PCTL_BASE + (0x1c << 2))
+#define PCTL_TMOD		(DDR0_PCTL_BASE + (0x1d << 2))
+#define PCTL_TEXSR		(DDR0_PCTL_BASE + (0x15 << 2))
+#define PCTL_TAL		(DDR0_PCTL_BASE + (0x50 << 2))
+#define PCTL_TCCD		(DDR0_PCTL_BASE + (0x52 << 2))
+#define PCTL_TRTP		(DDR0_PCTL_BASE + (0x12 << 2))
+#define PCTL_TFAW		(DDR0_PCTL_BASE + (0x11 << 2))
+#define PCTL_TCKSRX	(DDR0_PCTL_BASE + (0x1b << 2))
+#define PCTL_TRTW		(DDR0_PCTL_BASE + (0x9  << 2))
+#define PCTL_TCWL		(DDR0_PCTL_BASE + (0xc  << 2))
+#define PCTL_TWR		(DDR0_PCTL_BASE + (0x13 << 2))
+#define PCTL_TCL		(DDR0_PCTL_BASE + (0xb  << 2))
+#define PCTL_TDQS		(DDR0_PCTL_BASE + (0x1e << 2))
+#define PCTL_TRCD		(DDR0_PCTL_BASE + (0xf  << 2))
+#define PCTL_TXP		(DDR0_PCTL_BASE + (0x16 << 2))
+#define PCTL_TMRD		(DDR0_PCTL_BASE + (0x6  << 2))
+#define PCTL_TRAS		(DDR0_PCTL_BASE + (0xd  << 2))
+#define PCTL_TREFI_MEM_DDR3	(DDR0_PCTL_BASE + (0x24 << 2)) // replaced b=
y TREFI
+#define PCTL_TWTR		(DDR0_PCTL_BASE + (0x14 << 2))
+#define PCTL_TRC		(DDR0_PCTL_BASE + (0xe  << 2))
+#define PCTL_TRFC		(DDR0_PCTL_BASE + (0x7  << 2))
+#define PCTL_TCKESR	(DDR0_PCTL_BASE + (0x22 << 2))
+#define PCTL_TZQCL		(DDR0_PCTL_BASE + (0x20 << 2))
+#define PCTL_TRRD		(DDR0_PCTL_BASE + (0x10 << 2))
+#define PCTL_TRP		(DDR0_PCTL_BASE + (0x8  << 2))
+#define PCTL_TZQCS		(DDR0_PCTL_BASE + (0x18 << 2))
+#define PCTL_TXPDLL	(DDR0_PCTL_BASE + (0x17 << 2))
+
+#define PCTL_DFIODTCFG	(DDR0_PCTL_BASE + (0x27 << 2))
+#define PCTL_DFIODTCFG1	(DDR0_PCTL_BASE + (0x28 << 2))
+#define PCTL_DFITCTRLDELAY	(DDR0_PCTL_BASE + (0x26 << 2))
+#define PCTL_DFITPHYWRLAT	(DDR0_PCTL_BASE + (0x2b << 2))
+#define PCTL_DFITPHYWRDATA	(DDR0_PCTL_BASE + (0x2a << 2))
+#define PCTL_DFITRDDATAEN	(DDR0_PCTL_BASE + (0x2c << 2))
+#define PCTL_DFITPHYRDLAT	(DDR0_PCTL_BASE + (0x2d << 2))
+#define PCTL_DFITPHYUPDTYPE0	(DDR0_PCTL_BASE + (0x2e << 2))
+#define PCTL_DFITPHYUPDTYPE1	(DDR0_PCTL_BASE + (0x2f << 2))
+#define PCTL_DFIUPDCFG	(DDR0_PCTL_BASE + (0x35 << 2))
+#define PCTL_DFISTCFG0	(DDR0_PCTL_BASE + (0x3c << 2))
+#define PCTL_DFISTCFG1	(DDR0_PCTL_BASE + (0x3d << 2))
+#define PCTL_DFISTSTAT0	(DDR0_PCTL_BASE + (0x46 << 2))
+#define PCTL_DFILPCFG0	(DDR0_PCTL_BASE + (0x40 << 2))
+#define PCTL_DFITCTRLUPDMIN	(DDR0_PCTL_BASE + (0x32 << 2))
+#define PCTL_DFITCTRLUPDMAX	(DDR0_PCTL_BASE + (0x33 << 2))
+#define PCTL_DFITDRAMCLKEN	(DDR0_PCTL_BASE + (0x3e << 2))
+#define PCTL_DFITDRAMCLKDIS	(DDR0_PCTL_BASE + (0x3f << 2))
+
+/* DDR MMC (see dram-gx.h for more details) */
+#define DDR_MMC_BASE	0xc8837000
+
+#define DDR0_SOFT_RESET	(DDR_MMC_BASE + 0x20)
+
+#define AM_DDR_PLL_STS	(DDR_MMC_BASE + 0x18)
+#define DDR_CLK_CNTL	(DDR_MMC_BASE + 0x1c)
+#define DDR0_APD_CTRL	(DDR_MMC_BASE + 0x24)
+#endif
diff --git a/arch/arm/include/asm/arch-meson/dram-settings-gx.h b/arch/ar=
m/include/asm/arch-meson/dram-settings-gx.h
new file mode 100644
index 00000000000..b4ced2eda67
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/dram-settings-gx.h
@@ -0,0 +1,296 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023-2024, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#ifndef DRAM_SETTINGS_GX_H
+#define DRAM_SETTINGS_GX_H
+#include <linux/bitops.h>
+#include <asm/arch/dram-gx.h>
+
+/*
+ * These registers are pretty similar to other DRAM registers found in
+ * Allwinner A31/sun6i. Some of these registers also exist in some Rockc=
hip
+ * SoCs and the TI KeyStone3.
+ */
+/* DMC control register */
+#if defined(CONFIG_DRAM_TWO_IDENTICAL_RANKS) || defined(CONFIG_DRAM_ONE_=
RANK)
+#define DMC_DRAM_SIZE_SHIFT 6
+#else
+#define DMC_DRAM_SIZE_SHIFT 7
+#endif
+#define DMC_CTRL_CHANNEL	BIT(6) /* Channel 0 only */
+#if defined(CONFIG_DRAM_DDR4)
+#define DMC_CTRL_DDR_TYPE	BIT(22) | BIT(20) /* DDR4 */
+#else
+#define DMC_CTRL_DDR_TYPE	0
+#endif
+#if defined(CONFIG_DRAM_ONE_RANK) || defined(CONFIG_DRAM_TWO_DIFF_RANKS)
+#define DMC_CTRL_RANK	BIT(21) /* Enable rank 1 */
+#elif defined(CONFIG_DRAM_TWO_IDENTICAL_RANKS)
+#define DMC_CTRL_RANK	BIT(22) /* Rank 0 and 1 are identical */
+#elif defined(CONFIG_DRAM_16BIT_RANK)
+#define DMC_CTRL_RANK	BIT(16) /* 16-bit Rank 0 */
+#endif
+#define DMC_CTRL	DMC_CTRL_CHANNEL | DMC_CTRL_RANK | DMC_CTRL_DDR_TYPE
+
+/* Mode Register */
+#if defined(CONFIG_MESON_GXL) && defined(CONFIG_DRAM_DDR4)
+#define PUB_MR0			4 | (((((timings.cl - 9) >> 1) & 7) << 4)) | \
+	((((timings.wr - 10) >> 1) & 7) << 9)
+#define PUB_MR1			(timings.odt << 8) | (timings.drv << 1) | 0x81
+#define PUB_MR2			(((timings.cwl - 6) >> 1) & 7) << 3 | 0xc0
+#define PUB_MR3			0
+#define PUB_MR4			8
+#else
+#define PUB_MR0			(((timings.cl - 4) & 8) >> 1) | \
+	(((timings.cl - 4) & 7) << 4) | \
+	(((timings.wr <=3D 8 ? (timings.wr - 4) : (timings.wr >> 1)) & 7) << 9)=
 | 0x1c00
+#define PUB_MR1			(timings.drv << 1) | \
+	((timings.odt & 1) << 2)        | \
+	(((timings.odt >> 1) & 1) << 6) | \
+	(((timings.odt >> 2) & 1) << 9) | \
+	BIT(7)			        | \
+	((timings.al ? ((timings.cl - timings.al) & 3) : 0) << 3)
+#define PUB_MR2			BIT(6) | (((timings.cwl - 5) & 7) << 3)
+#endif
+#define PUB_MR3			0
+#if defined(CONFIG_MESON_GXL)
+#if defined(CONFIG_DRAM_DDR3)
+#define PUB_MR4			0
+#define PUB_MR5			0x420
+#elif defined(CONFIG_DRAM_DDR4)
+#define PUB_MR5			0x400
+#endif
+#define PUB_MR6			0x800
+#endif
+
+/* ODT Configuration Register */
+#if defined(CONFIG_MESON_GXBB)
+#define PUB_ODTCR	0x210000
+#elif defined(CONFIG_MESON_GXL)
+#define PUB_ODTCR	0x30000
+#endif
+
+/* DDR Timing Parameter */
+#if defined(CONFIG_MESON_GXBB)
+#define PUB_DTPR0	timings.rtp | \
+	(timings.wtr << 4)  | \
+	(timings.rp  << 8)  | \
+	(timings.ras << 16) | \
+	(timings.rrd << 22) | \
+	(timings.rcd << 26)
+#define PUB_DTPR1	(timings.mod << 2) | \
+	(timings.faw << 5)    | \
+	(timings.rfc << 11)   | \
+	(timings.wlmrd << 20) | \
+	(timings.wlo << 26)
+#define PUB_DTPR2	timings.xs | \
+	(timings.xp << 10)   | \
+	(timings.dllk << 19)
+#define PUB_DTPR3	0 | \
+	(0 << 3)            | \
+	(timings.rc << 6)   | \
+	(timings.cke << 13) | \
+	(timings.mrd << 18) | \
+	(0 << 29)
+#elif defined(CONFIG_MESON_GXL)
+#define PUB_DTPR0	timings.rtp | \
+	(timings.rp  << 8)  | \
+	(timings.ras << 16) | \
+	(timings.rrd << 24)
+#define PUB_DTPR1	(timings.wlmrd << 24) | \
+	(timings.faw << 16) | \
+	timings.mrd
+#define PUB_DTPR2	timings.xs | \
+	(timings.cke << 16)
+#define PUB_DTPR3	(timings.dllk << 16) | (4 << 28)
+#define PUB_DTPR4	timings.xp | BIT(11) | (timings.rfc << 0x10)
+#define PUB_DTPR5	(timings.rc << 16) | (timings.rcd << 8) | \
+	timings.wtr
+#endif
+
+#if defined(CONFIG_MESON_GXBB)
+#define PUB_PGCR0	0x7D81E3F
+#define PUB_PGCR1	0x380C6A0
+#define PUB_PGCR2	(0x1F12480 & 0xefffffff)
+#define PUB_PGCR3	0xC0AAFE60
+#elif defined(CONFIG_MESON_GXL)
+#define PUB_PGCR0	0x7d81e3f
+#define PUB_PGCR1	0x2004620
+#define PUB_PGCR2	(0xf05f97 & 0xefffffff)
+#if defined(CONFIG_DRAM_DDR3)
+#define PUB_PGCR3	0xc0aae860
+#elif defined(CONFIG_DRAM_DDR4)
+#define PUB_PGCR3	0xc0aae860 | 0x4000000
+#endif
+#endif
+
+#if defined(CONFIG_MESON_GXBB)
+#define PUB_DXCCR	0x181884
+#define PUB_DTCR	0x4300308f
+#define PUB_DSGCR	0x20645A
+
+#define PUB_ZQ0PR	0x69
+#define PUB_ZQ1PR	0x69
+#define PUB_ZQ2PR	0x69
+#define PUB_ZQ3PR	0x69
+#elif defined(CONFIG_MESON_GXL)
+#define PUB_DXCCR	0x20c01204
+
+#if defined(CONFIG_DRAM_DDR4)
+#define PUB_DTCR	0x80003187 | 0x40
+#else
+#define PUB_DTCR	0x80003187
+#endif
+
+#define PUB_DTCR1	0x00010237 /* XXX: Needed? */
+#define PUB_DSGCR	(0x20641b | 0x800004) /* Works on DDR4 too? */
+
+#if defined(CONFIG_DRAM_DDR3)
+#define PUB_ZQ0PR	0x5d95d
+#define PUB_ZQ1PR	0x5d95d
+#define PUB_ZQ2PR	0x5d95d
+#define PUB_ZQ3PR	0x1dd1d
+#elif defined(CONFIG_DRAM_DDR4)
+#define PUB_ZQ0PR	0x775d
+#define PUB_ZQ1PR	0x6fc5d
+#define PUB_ZQ2PR	0x6fc5d
+#define PUB_ZQ3PR	0x1dd1d
+#endif
+#endif
+
+#if defined(CONFIG_DRAM_DDR3)
+#define PUB_DCR	0xb
+#elif defined(CONFIG_DRAM_DDR4)
+#define PUB_DCR	0x1800040c
+#endif
+#define PUB_DTAR	(0 | (0 << 12) | (0 << 28)) /* Uh? */
+
+#define PCTL0_1US_PCK	0x1C8
+#define PCTL0_100NS_PCK	0x2D
+#define PCTL0_INIT_US	0x2
+#define PCTL0_RSTH_US	0x2
+
+/* Mode Config(?) */
+#if defined(CONFIG_MESON_GXBB)
+#define PCTL0_MCFG	((((timings.faw + timings.rrd - 1) / timings.rrd) & 3=
) << 0x12) | \
+	(0xa2f21 & 0xfff3ffff)
+#define PCTL0_MCFG1	(((timings.rrd - ((timings.faw - (timings.faw / timi=
ngs.rrd) * \
+	timings.rrd) & 0xff)) & 7) << 8) | \
+	(0x80200000 & 0xfffffcff)
+#elif defined(CONFIG_MESON_GXL)
+#if defined(CONFIG_DRAM_DDR3)
+#define PCTL0_MCFG_DDRTYPE	0
+#elif defined(CONFIG_DRAM_DDR4)
+#define PCTL0_MCFG_DDRTYPE	BIT(4)
+#endif
+
+#define PCTL0_MCFG	(0xa2f21 & 0xffffff8f) | PCTL0_MCFG_DDRTYPE
+/* XXX: What is this?           =E2=86=93 ??? */
+#define PCTL0_MCFG1	0
+#endif
+
+#define PCTL0_SCFG	0xF01
+
+#if defined(CONFIG_MESON_GXL) && defined(CONFIG_DRAM_16BIT_RANK)
+#define PCTL0_PPCFG	0x1fd
+#else
+#define PCTL0_PPCFG	0x1e0
+#endif
+
+#define PCTL0_DFISTCFG0	0x4
+#define PCTL0_DFISTCFG1	0x1
+
+#define PCTL0_DFITCTRLDELAY	0x2
+
+#if defined(CONFIG_MESON_GXBB)
+#define PCTL0_DFITPHYWRDATA	0x1
+#else
+#define PCTL0_DFITPHYWRDATA	0x2
+#endif
+
+#if defined(CONFIG_MESON_GXBB)
+#define PCTL0_DFITPHYWRLTA	(timings.cwl + timings.al - \
+	(((timings.cwl + timings.al) % 2) ? 3 : 4)) / 2
+#define PCTL0_DFITRDDATAEN	(timings.cl + timings.al - \
+	(((timings.cl + timings.al) % 2) ? 3 : 4)) / 2
+#define PCTL0_DFITPHYRDLAT	((timings.cl + timings.al) % 2) ? 14 : 16
+#elif defined(CONFIG_MESON_GXL)
+#define PCTL0_DFITPHYWRLTA	((timings.cwl + timings.al) - 2)
+#define PCTL0_DFITRDDATAEN	((timings.cl + timings.al) - 4)
+#define PCTL0_DFITPHYRDLAT	0x16
+#endif
+
+#define PCTL0_DFITDRAMCLKDIS	1
+#define PCTL0_DFITDRAMCLKEN	1
+#if defined(CONFIG_MESON_GXBB)
+#define PCTL0_DFITPHYUPDTYPE1	0x200
+#else
+#define PCTL0_DFITPHYUPDTYPE0	16
+#define PCTL0_DFITPHYUPDTYPE1	16
+#define PCTL0_DFITCTRLUPDMAX	64
+#define PCTL0_DFIUPDCFG		3
+#endif
+#define PCTL0_DFITCTRLUPDMIN	16
+
+#define PCTL0_CMDTSTATEN	1
+
+#if defined(CONFIG_DRAM_ONE_RANK) || defined(CONFIG_DRAM_16BIT_RANK)
+#define PCTL0_DFIODTCFG	0x808
+#elif defined(CONFIG_DRAM_TWO_DIFF_RANKS)
+#define PCTL0_DFIODTCFG	0xc0c
+#elif defined(CONFIG_DRAM_TWO_IDENTICAL_RANKS)
+#define PCTL0_DFIODTCFG	0x8
+#endif
+
+#if defined(CONFIG_MESON_GXBB)
+#define PCTL0_DFIODTCFG1	(0 | (6 << 16))
+#elif defined(CONFIG_MESON_GXL)
+#if defined(CONFIG_DRAM_16BIT_RANK)
+#define PCTL0_DFIODTCFG1	((6 << 16) | (8 << 16))
+#else
+#define PCTL0_DFIODTCFG1	((6 << 16) | (3 << 25) | (8 << 16))
+#endif
+#endif
+#define PCTL0_DFILPCFG0		(1 | (3 << 4) | BIT(8) | (3 << 12) | \
+	(7 << 16) | BIT(24) | (3 << 28))
+
+#if defined(CONFIG_MESON_GXBB)
+#define PUB_ACBDLR0		0x10
+#elif defined(CONFIG_MESON_GXL)
+#if defined(CONFIG_DRAM_DDR3)
+#define PUB_ACBDLR0		0
+#define PUB_ACBDLR3		0
+#define PUB_ACLCDLR		48
+#elif defined(CONFIG_DRAM_DDR4)
+#define PUB_ACBDLR0		0x3f
+#define PUB_ACBDLR3		0x10
+#define PUB_ACLCDLR		0x28
+#else
+#define PUB_ACBDLR0		0
+#define PUB_ACBDLR3		0
+#define PUB_ACLCDLR		48
+#endif
+#endif
+
+#define LPDDR3_CA0	2
+#define LPDDR3_CA1	0
+#define LPDDR3_REMAP	3
+#define LPDDR3_WL	1
+
+/* PLL */
+#if defined(CONFIG_MESON_GXBB)
+#define DDR_PLL_CNTL1	0x69c80000
+#define DDR_PLL_CNTL2	0xca463823
+#define DDR_PLL_CNTL3	0xc00023
+#define DDR_PLL_CNTL4	0x303500
+#define DDR_PLL_CNTL5	0 /* Unused */
+#elif defined(CONFIG_MESON_GXL)
+#define DDR_PLL_CNTL1	0xaa203
+#define DDR_PLL_CNTL2	0x2919a288
+#define DDR_PLL_CNTL3	0x3e3b744
+#define DDR_PLL_CNTL4	0xc0101
+#define DDR_PLL_CNTL5	0xe600001e
+#endif
+
+#endif /* DRAM_SETTINGS_GX_H */
diff --git a/arch/arm/include/asm/arch-meson/dram-timings-gx.h b/arch/arm=
/include/asm/arch-meson/dram-timings-gx.h
new file mode 100644
index 00000000000..144b727e998
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/dram-timings-gx.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+#ifndef DRAM_TIMINGS_GX_H
+#define DRAM_TIMINGS_GX_H
+
+/*
+ * DRAM timings
+ * It looks like those are quite similar in regular boards based on refe=
rence
+ * designs and not using counterfeit RAM chips. Those are hacked around =
by lowbin
+ * TV box vendors to support lowbin RAM chips, however. Here, we are har=
dcoding
+ * timings, which *will* cause issues on lowbin boards, but should be fi=
ne on other
+ * boards derived from Amlogic reference designs.
+ */
+
+/*
+ * TODO:
+ * - Add timings for different DRAM clocks
+ * - Support overwriting those if board needs different timings (how?)
+ * - Other things
+ */
+
+#if defined(CONFIG_DRAM_DDR3)
+/* DDR3: 912 MHz */
+const struct meson_gx_dram_timings timings =3D {
+	.drv        =3D 0,
+	.odt        =3D 2,
+
+	/* Timings */
+	.rtp        =3D 0x7,
+	.wtr        =3D 0x7,
+	.rp         =3D 0xd,
+	.rcd        =3D 0xd,
+	.ras        =3D 0x25,
+	.rrd        =3D 0x7,
+	.rc         =3D 0x34,
+	.mrd        =3D 0x6, /* Should be < 8 */
+	.mod        =3D 0x4,
+	.faw        =3D 0x21,
+	.wlmrd      =3D 0x28,
+	.wlo        =3D 0x7,
+	.rfc        =3D 0x118,
+	.xp         =3D 0x7,
+	.xs         =3D 0x200,
+	.dllk       =3D 0x200,
+	.cke        =3D 0x5,
+	.rtodt      =3D 0x0,
+	.rtw        =3D 0x7,
+	.refi       =3D 0x4e,
+	.refi_mddr3 =3D 0x4,
+	.cl         =3D 0xd,
+	.wr         =3D 0x10,
+	.cwl        =3D 0x9,
+	.al         =3D 0x0,
+	.dqs        =3D 0x17,
+	.cksre      =3D 0xf,
+	.cksrx      =3D 0xf,
+	.zqcs       =3D 0x40,
+	.xpdll      =3D 0x17,
+	.exsr       =3D 0x200, /* Should be < 0x3ff */
+	.zqcl       =3D 0x88,
+	.zqcsi      =3D 0x3e8,
+	.rpab       =3D 0x0,
+	.rppb       =3D 0x0,
+	.tdqsck     =3D 0x0,
+	.tdqsckmax  =3D 0x0,
+	.tckesr     =3D 0x0,
+	.tdpd       =3D 0x0,
+	.taond_aofd =3D 0x0,
+	.tccdl      =3D 0, /* Unused on GXBB */
+};
+
+#elif defined(CONFIG_DRAM_DDR4)
+/* DDR4: 1080 MHz */
+const struct meson_gx_dram_timings timings =3D {
+	.drv        =3D 1,
+	.odt        =3D 1,
+
+	/* Timings */
+	.rtp        =3D 9,
+	.wtr        =3D 9,
+	.rp         =3D 0x10, // ddr_clk < 1200
+	.rcd        =3D 0x10, // ddr_clk < 1200
+	.ras        =3D 35 * 1.2,
+	.rrd        =3D 6,
+	.rc         =3D 0x3a,
+	.mrd        =3D 8,
+	.mod        =3D 24,
+	.faw        =3D 35 * 1.2,
+	.rfc        =3D 350 * 1.2,
+	.wlmrd      =3D 40,
+	.wlo        =3D 9.5 * 1.2,
+	.xs         =3D 512,
+	.xp         =3D 7,
+	.cke        =3D 5,
+	.dllk       =3D 1024,
+	.rtodt      =3D 0,
+	.rtw        =3D 8,
+	.refi       =3D 76,
+	.refi_mddr3 =3D 4,
+	.cl         =3D 0x10, // ddr_clk < 1200
+	.wr         =3D 0x12,
+	.cwl        =3D 12,
+	.al         =3D 0,
+	.exsr       =3D 1024,
+	.dqs        =3D 9,
+	.cksre      =3D 15,
+	.cksrx      =3D 15,
+	.zqcs       =3D 128,
+	.zqcl       =3D 256,
+	.xpdll      =3D 23,
+	.zqcsi      =3D 1000,
+	.tccdl      =3D 6, // ddr_clk < 1200
+};
+#endif
+#endif
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 8d1bf91e98b..ef86129b535 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -99,6 +99,76 @@ if MESON_GX && SPL
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
=20
+choice
+	prompt "DRAM rank mode"
+	help
+	  Choose rank mode. This heavily depends on the board and you should
+	  leave the board default set if you don't know what this is.
+	  If you choose the wrong rank mode DRAM init in SPL may either fail
+	  or in rare occasions require multiple resets before it succeeds.
+
+config DRAM_ONE_RANK
+	bool "One rank"
+
+config DRAM_TWO_IDENTICAL_RANKS
+	bool "Two identical ranks"
+
+if MESON_GXBB
+config DRAM_TWO_DIFF_RANKS
+	bool "Two different ranks"
+endif
+
+if MESON_GXL
+config DRAM_16BIT_RANK
+	bool "One 16-bit rank"
+endif
+endchoice
+
+choice
+	prompt "DRAM memory type"
+	default DRAM_DDR3
+	help
+	  Select the DDR type according to your board design.  GXBB/S905
+	  currently only supports DDR3.
+
+config DRAM_DDR3
+	bool "DDR3"
+
+if MESON_GXL
+config DRAM_DDR4
+	bool "DDR4"
+endif
+endchoice
+
+config DRAM_DQS_CORR
+	bool "Enable DQS correction"
+
+config DRAM_CLK
+	int "DRAM clock"
+	default 912
+	help
+	  This option contains the DRAM clock to use in MHz.
+
+config DRAM_SIZE
+	int "DRAM size"
+	default 1024
+	help
+	  This option contains the DRAM size. Units in MB.
+
+choice
+	prompt "Enable DRAM 2T mode"
+	default DRAM_1T_MODE
+	help
+	  Choose whenever to use 2T mode or not.
+
+config DRAM_1T_MODE
+	bool "Use DRAM 1T mode"
+
+config DRAM_2T_MODE
+	bool "Use DRAM 2T mode"
+
+endchoice
+
 choice
 	prompt "Set VDDEE init voltage"
 	default SPL_MESON_GX_VDDEE_1000MV
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 798b20df78a..5b57d63e02d 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -5,6 +5,9 @@
 obj-y +=3D board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) +=3D board-gx.o
 ifeq ($(CONFIG_SPL_BUILD),y)
+obj-$(CONFIG_MESON_GXBB) +=3D dram-gxbb.o
+obj-$(CONFIG_MESON_GXL) +=3D dram-gxl.o
+obj-$(CONFIG_MESON_GX) +=3D dram-gx.o
 obj-$(CONFIG_MESON_GXBB) +=3D spl-gxbb.o
 obj-$(CONFIG_MESON_GXL) +=3D spl-gxl.o
 obj-$(CONFIG_MESON_GX) +=3D spl-gx.o
diff --git a/arch/arm/mach-meson/dram-gx.c b/arch/arm/mach-meson/dram-gx.=
c
new file mode 100644
index 00000000000..049beda6ef3
--- /dev/null
+++ b/arch/arm/mach-meson/dram-gx.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023-2025, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#include <init.h>
+#include <asm/unaligned.h>
+#include <linux/libfdt.h>
+#include <config.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/arch/dram-gx.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/clock-gx.h>
+#include <asm/arch/dram-settings-gx.h>
+#include <asm/arch/dram-timings-gx.h>
+#include <linux/delay.h>
+
+/*
+ * Meson GX common shared DRAM init code
+ *
+ * See dram-gxbb.c and dram-gxl.c for gxbb/gxl-specific code
+ */
+
+void meson_dram_pll_init(void)
+{
+	setbits_32(AM_ANALOG_TOP_REG1, 1);
+	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL5, 1);
+
+	clrbits_32(AM_DDR_PLL_CNTL4, BIT(12));
+	setbits_32(AM_DDR_PLL_CNTL4, BIT(12));
+
+	udelay(10);
+
+	do {
+		if (IS_ENABLED(CONFIG_MESON_GXBB))
+			writel(1 << 29, AM_DDR_PLL_CNTL0);
+		writel(DDR_PLL_CNTL1, AM_DDR_PLL_CNTL1);
+		writel(DDR_PLL_CNTL2, AM_DDR_PLL_CNTL2);
+		writel(DDR_PLL_CNTL3, AM_DDR_PLL_CNTL3);
+		writel(DDR_PLL_CNTL4, AM_DDR_PLL_CNTL4);
+		if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+			if (CONFIG_DRAM_CLK >=3D 375 && CONFIG_DRAM_CLK <=3D 749)
+				writel((1 << 29) | ((2 << 16) | (1 << 9) |
+					(((CONFIG_DRAM_CLK / 6) * 6) / 12)), AM_DDR_PLL_CNTL0);
+			else if (CONFIG_DRAM_CLK >=3D 750 && CONFIG_DRAM_CLK <=3D 1449)
+				writel((1 << 29) | ((1 << 16) | (1 << 9) |
+					(((CONFIG_DRAM_CLK / 12) * 12) / 24)), AM_DDR_PLL_CNTL0);
+			clrbits_32(AM_DDR_PLL_CNTL0, 1 << 29);
+		} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+			writel(DDR_PLL_CNTL5, AM_DDR_PLL_CNTL5);
+			if (CONFIG_DRAM_CLK >=3D 399 && CONFIG_DRAM_CLK <=3D 799)
+				writel(((1 << 16) | ((1 << 2) | 1) |
+					((CONFIG_DRAM_CLK / 12) << 4)) |
+					((1 << 31) | (1 << 29) | (1 << 28)), AM_DDR_PLL_CNTL0);
+			else if (CONFIG_DRAM_CLK >=3D 800 && CONFIG_DRAM_CLK <=3D 1498)
+				writel(((1 << 16) | (1 << 2) |
+					((CONFIG_DRAM_CLK / 24) << 4)) |
+					((1 << 31) | (1 << 29) | (1 << 28)), AM_DDR_PLL_CNTL0);
+		}
+		udelay(200);
+	} while (!((readl(AM_DDR_PLL_STS) >> 0x1F) & 1));
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		writel(DDR_CLK_CNTL_CLKGEN_SOFTRESET |
+			DDR_CLK_CNTL_PHY_CLK_ENABLE |
+			DDR_CLK_CNTL_DDRPLL_ENABLE, DDR_CLK_CNTL);
+	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+		writel(DDR_CLK_CNTL_CLKGEN_SOFTRESET |
+			DDR_CLK_CNTL_PHY_CLK_ENABLE |
+			DDR_CLK_CNTL_DDRPLL_ENABLE |
+			0xa005 /* unknown */, DDR_CLK_CNTL);
+	}
+
+	printf("DRAM clock: %d MHz\n", CONFIG_DRAM_CLK);
+}
+
+void meson_dram_phy_prepare(void)
+{
+	/* Release reset of DLL */
+	writel(0xffffffff, DMC_SOFT_RST);
+	writel(0xffffffff, DMC_SOFT_RST1);
+	udelay(10);
+
+	/* Enable UPCTL and PUB clock */
+	if (IS_ENABLED(CONFIG_MESON_GXBB))
+		writel(0x550620, DMC_PCTL_LP_CTRL);
+	else if (IS_ENABLED(CONFIG_MESON_GXL))
+		writel(0, DMC_PCTL_LP_CTRL);
+	writel(0xf, DDR0_SOFT_RESET);
+	udelay(10);
+}
+
+void meson_dram_set_memory_timings(void)
+{
+	/* Set memory timings */
+	writel(timings.rfc, PCTL_TRFC);
+	if (IS_ENABLED(CONFIG_MESON_GXL))
+		writel(timings.faw, PCTL_TFAW);
+	writel(timings.refi_mddr3, PCTL_TREFI_MEM_DDR3);
+	writel(timings.mrd, PCTL_TMRD);
+	if (IS_ENABLED(CONFIG_MESON_GXL))
+		writel((timings.rp << 16) | timings.rp, PCTL_TRP);
+	else /* Meson GXBB */
+		writel(timings.rp, PCTL_TRP);
+	writel(timings.cke + 1, PCTL_TCKESR);
+	writel(timings.al, PCTL_TAL);
+	writel(timings.cwl, PCTL_TCWL);
+	writel(timings.cl, PCTL_TCL);
+	writel(timings.ras, PCTL_TRAS);
+	writel(timings.rc, PCTL_TRC);
+	writel(timings.rcd, PCTL_TRCD);
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		writel(timings.rrd, PCTL_TRRD);
+	} else {
+		writel(timings.rrd | ((timings.rrd + 2) * 0x10000), PCTL_TRRD);
+		writel((timings.tccdl << 16) | 4, PCTL_TCCD);
+	}
+	writel(timings.rtp, PCTL_TRTP);
+	writel(timings.wr, PCTL_TWR);
+	writel(timings.wtr, PCTL_TWTR);
+	writel(timings.exsr, PCTL_TEXSR);
+	writel(timings.xp, PCTL_TXP);
+	writel(timings.dqs, PCTL_TDQS);
+	writel(timings.rtw, PCTL_TRTW);
+	writel(timings.cksre, PCTL_TCKSRE);
+	writel(timings.cksrx, PCTL_TCKSRX);
+	writel(timings.mod, PCTL_TMOD);
+	writel(timings.cke, PCTL_TCKE);
+	writel(timings.zqcs, PCTL_TZQCS);
+	writel(timings.zqcl, PCTL_TZQCL);
+	writel(timings.xpdll, PCTL_TXPDLL);
+	writel(timings.zqcsi, PCTL_TZQCSI);
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		/* GXBB: Enter config state */
+		writel(PCTL0_SCFG, PCTL_SCFG);
+		writel(PCTL_SCTL_CFG_STATE, PCTL_SCTL);
+	}
+}
+
+void meson_dram_set_dfi_timings(void)
+{
+#ifdef CONFIG_MESON_GXL
+	writel(0xab0a560a, PCTL_ZQCFG);
+#endif
+	WAIT_FOR(PCTL_STAT);
+
+	writel(PCTL0_PPCFG, PCTL_PPCFG);
+	writel(PCTL0_DFISTCFG0, PCTL_DFISTCFG0);
+	writel(PCTL0_DFISTCFG1, PCTL_DFISTCFG1);
+	writel(PCTL0_DFITCTRLDELAY, PCTL_DFITCTRLDELAY);
+	writel(PCTL0_DFITPHYWRDATA, PCTL_DFITPHYWRDATA);
+	writel(PCTL0_DFITPHYWRLTA, PCTL_DFITPHYWRLAT);
+	writel(PCTL0_DFITRDDATAEN, PCTL_DFITRDDATAEN);
+	writel(PCTL0_DFITPHYRDLAT, PCTL_DFITPHYRDLAT);
+	writel(PCTL0_DFITDRAMCLKDIS, PCTL_DFITDRAMCLKDIS);
+	writel(PCTL0_DFITDRAMCLKEN, PCTL_DFITDRAMCLKEN);
+	writel(PCTL0_DFITCTRLUPDMIN, PCTL_DFITCTRLUPDMIN);
+#if defined(CONFIG_MESON_GXL)
+	writel(PCTL0_DFITCTRLUPDMAX, PCTL_DFITCTRLUPDMAX);
+	writel(PCTL0_DFIUPDCFG, PCTL_DFIUPDCFG);
+#endif
+	writel(PCTL0_DFILPCFG0, PCTL_DFILPCFG0);
+#if defined(CONFIG_MESON_GXL)
+	writel(PCTL0_DFITPHYUPDTYPE0, PCTL_DFITPHYUPDTYPE0);
+#endif
+	writel(PCTL0_DFITPHYUPDTYPE1, PCTL_DFITPHYUPDTYPE1);
+	writel(PCTL0_DFIODTCFG, PCTL_DFIODTCFG);
+	writel(PCTL0_DFIODTCFG1, PCTL_DFIODTCFG1);
+#if defined(CONFIG_MESON_GXBB)
+	writel(PCTL0_CMDTSTATEN, PCTL_CMDTSTATEN);
+#endif
+}
+
+uint meson_dram_phy_finalise_init(void)
+{
+	writel(PUB_ZQ0PR, DDR0_PUB_ZQ0PR);
+	writel(PUB_ZQ1PR, DDR0_PUB_ZQ1PR);
+	writel(PUB_ZQ2PR, DDR0_PUB_ZQ2PR);
+#if defined(CONFIG_MESON_GXBB)
+	writel(PUB_ZQ3PR, DDR0_PUB_ZQ3PR);
+#endif
+
+	writel(PUB_PIR_INIT | PUB_PIR_ZCAL, DDR0_PUB_PIR);
+	WAIT_FOR(DDR0_PUB_PGSR0);
+	/*
+	 * Is this needed?
+	 * TODO: test without
+	 */
+	writel(readl(DDR0_PUB_ZQCR) | (1 << 2) | (1 << 27), DDR0_PUB_ZQCR);
+	udelay(10);
+	writel(readl(DDR0_PUB_ZQCR) & ~((1 << 2) | (1 << 27)), DDR0_PUB_ZQCR);
+	udelay(30);
+
+#if defined(CONFIG_MESON_GXL) && defined(CONFIG_DRAM_16BIT_RANK)
+	clrsetbits_32(DDR0_PUB_DX2GCR0, 0xb0001, 0xb0000); /* Make it neat some=
how? */
+	clrsetbits_32(DDR0_PUB_DX3GCR0, 0xb0001, 0xb0000);
+#endif
+
+	writel(PUB_ACBDLR0, DDR0_PUB_ACBDLR0);
+#if defined(CONFIG_MESON_GXL)
+	writel(PUB_ACBDLR3, DDR0_PUB_ACBDLR3);
+#endif
+
+#if defined(CONFIG_MESON_GXL) && defined(CONFIG_DRAM_2T_MODE) && defined=
(CONFIG_DRAM_DDR3)
+	writel(0x10101010, DDR0_PUB_ACBDLR1);
+	writel(0x10101010, DDR0_PUB_ACBDLR7);
+	writel(0x20202020, DDR0_PUB_ACBDLR8);
+	writel(0x30303030, DDR0_PUB_ACBDLR9);
+	writel(0x3f003f, DDR0_PUB_ACBDLR2);
+	writel(0, DDR0_PUB_ACBDLR6);
+#endif
+
+#if defined(CONFIG_MESON_GXL) && defined(CONFIG_DRAM_DDR3)
+	clrsetbits_32(DDR0_PUB_DXCCR, (3 << 5) | (3 << 7) |
+		(3 << 9) | (3 << 11), (1 << 12) | (1 << 9));
+#endif
+
+	writel(PUB_PIR_FINAL_STEP, DDR0_PUB_PIR);
+	udelay(1000);
+
+	for (u32 pgsr0 =3D readl(DDR0_PUB_PGSR0); (pgsr0 !=3D 0xc0000fff) &&
+	     (pgsr0 !=3D 0x80000fff); pgsr0 =3D readl(DDR0_PUB_PGSR0)) {
+		udelay(20);
+		debug("Waiting for PGSR0, currently 0x%x\n", pgsr0);
+
+		/* Check for errors */
+		if (pgsr0 & PUB_PGSR0_ZCERR)
+			pr_err("%s: impedance calibration error\n", __func__);
+		if (pgsr0 & PUB_PGSR0_WLERR)
+			pr_err("%s: write leveling error\n", __func__);
+		if (pgsr0 & PUB_PGSR0_QSGERR)
+			pr_err("%s: DQS gate training error\n", __func__);
+		if (pgsr0 & PUB_PGSR0_WLAERR)
+			pr_err("%s: WL Adj error\n", __func__);
+		if (pgsr0 & PUB_PGSR0_RDERR)
+			pr_err("%s: read bit deskew error", __func__);
+		if (pgsr0 & PUB_PGSR0_WDERR)
+			pr_err("%s: write bit deskew error", __func__);
+		if (pgsr0 & PUB_PGSR0_REERR)
+			pr_err("%s: read eye training error", __func__);
+		if (pgsr0 & PUB_PGSR0_WEERR)
+			pr_err("%s: write eye training error", __func__);
+	}
+	debug("Wait done for PGSR0, currently 0x%x\n", readl(DDR0_PUB_PGSR0));
+
+	return 0;
+}
+
+void meson_dram_dmc_set_addrmap(void)
+{
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		/* GXBB address map */
+		if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS) ||
+		    IS_ENABLED(CONFIG_DRAM_ONE_RANK)) {
+			writel(11 | 31 << 5 |  0 << 10 | 14 << 15 | 15 << 20 | 16 << 25,
+			       DDR0_ADDRMAP_1);
+			writel(30 | 12 << 5 | 13 << 10 | 29 << 15 |  0 << 20 |  0 << 25,
+			       DDR0_ADDRMAP_4);
+		} else if (IS_ENABLED(CONFIG_DRAM_TWO_DIFF_RANKS)) {
+			writel(11 | 31 << 5 |  0 << 10 | 14 << 15 | 15 << 20 | 16 << 25,
+			       DDR0_ADDRMAP_1);
+			writel(0 | 12 << 5 | 13 << 10 | 29 << 15 |  0 << 20 | 30 << 25,
+			       DDR0_ADDRMAP_4);
+		}
+	} else if (IS_ENABLED(CONFIG_MESON_GXL) && IS_ENABLED(CONFIG_DRAM_DDR3)=
) {
+		/* This applies for GXL + DDR3 RAM (e.g. LePotato) */
+		if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS) ||
+		    IS_ENABLED(CONFIG_DRAM_ONE_RANK)) {
+			writel(11 | 30 << 5 |  0 << 10 | 15 << 15 | 16 << 20 | 17 << 25,
+			       DDR0_ADDRMAP_1);
+			writel(18 | 19 << 5 | 20 << 10 | 21 << 15 | 22 << 20 | 23 << 25,
+			       DDR0_ADDRMAP_2);
+			writel(24 | 25 << 5 | 26 << 10 | 27 << 15 | 28 << 20 | 29 << 25,
+			       DDR0_ADDRMAP_3);
+			writel(30 | 12 << 5 | 13 << 10 | 14 << 15 |  0 << 20 | 31 << 25,
+			       DDR0_ADDRMAP_4);
+
+			writel(5 |  6 << 5 |  7 << 10 |  8 << 15 |  9 << 20 | 10 << 25,
+			       DDR1_ADDRMAP_0);
+			writel(11 | 30 << 5 |  0 << 10 | 15 << 15 | 16 << 20 | 17 << 25,
+			       DDR1_ADDRMAP_1);
+			writel(18 | 19 << 5 | 20 << 10 | 21 << 15 | 22 << 20 | 23 << 25,
+			       DDR1_ADDRMAP_2);
+			writel(24 | 25 << 5 | 26 << 10 | 27 << 15 | 28 << 20 | 29 << 25,
+			       DDR1_ADDRMAP_3);
+			writel(30 | 12 << 5 | 13 << 10 | 14 << 15 |  0 << 20 | 31 << 25,
+			       DDR1_ADDRMAP_4);
+		}
+	} else if (IS_ENABLED(CONFIG_MESON_GXL) && IS_ENABLED(CONFIG_DRAM_DDR4)=
) {
+		/* This applies for GXL + DDR4 RAM (e.g. LaFrite) */
+		if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS) ||
+		    IS_ENABLED(CONFIG_DRAM_ONE_RANK)) {
+			writel(6 |  7 << 5 |  8 << 10 |  9 << 15 | 10 << 20 | 11 << 25,
+			       DDR0_ADDRMAP_0);
+			writel(12 |  0 << 5 |  0 << 10 | 15 << 15 | 16 << 20 | 17 << 25,
+			       DDR0_ADDRMAP_1);
+			writel(18 | 19 << 5 | 20 << 10 | 21 << 15 | 22 << 20 | 23 << 25,
+			       DDR0_ADDRMAP_2);
+			writel(24 | 25 << 5 | 26 << 10 | 27 << 15 | 28 << 20 | 29 << 25,
+			       DDR0_ADDRMAP_3);
+			writel(30 | 13 << 5 | 14 << 10 |  5 << 15 |  0 << 20 | 31 << 25,
+			       DDR0_ADDRMAP_4);
+
+			writel(6 |  7 << 5 |  8 << 10 |  9 << 15 | 10 << 20 | 11 << 25,
+			       DDR1_ADDRMAP_0);
+			writel(12 |  0 << 5 |  0 << 10 | 15 << 15 | 16 << 20 | 17 << 25,
+			       DDR1_ADDRMAP_1);
+			writel(18 | 19 << 5 | 20 << 10 | 21 << 15 | 22 << 20 | 23 << 25,
+			       DDR1_ADDRMAP_2);
+			writel(24 | 25 << 5 | 26 << 10 | 27 << 15 | 28 << 20 | 29 << 25,
+			       DDR1_ADDRMAP_3);
+			writel(30 | 13 << 5 | 14 << 10 |  5 << 15 |  0 << 20 | 31 << 25,
+			       DDR1_ADDRMAP_4);
+		} else if (IS_ENABLED(CONFIG_DRAM_16BIT_RANK)) {
+			writel(0 | 6 << 5  |  7 << 10 |  8 << 15 |  9 << 20 | 10 << 25,
+			       DDR0_ADDRMAP_0);
+			writel(11 | 0 << 5  |  0 << 10 | 14 << 15 | 15 << 20 | 16 << 25,
+			       DDR0_ADDRMAP_1);
+			writel(17 | 18 << 5 | 19 << 10 | 20 << 15 | 21 << 20 | 22 << 25,
+			       DDR0_ADDRMAP_2);
+			writel(23 | 24 << 5 | 25 << 10 | 26 << 15 | 27 << 20 | 28 << 25,
+			       DDR0_ADDRMAP_3);
+			writel(29 | 12 << 5 | 13 << 10 |  5 << 15 |  0 << 20 | 30 << 25,
+			       DDR0_ADDRMAP_4);
+
+			writel(0 |  6 << 5 |  7 << 10 |  8 << 15 |  9 << 20 | 10 << 25,
+			       DDR1_ADDRMAP_0);
+			writel(11 |  0 << 5 |  0 << 10 | 14 << 15 | 15 << 20 | 16 << 25,
+			       DDR1_ADDRMAP_1);
+			writel(17 | 18 << 5 | 19 << 10 | 20 << 15 | 21 << 20 | 22 << 25,
+			       DDR1_ADDRMAP_2);
+			writel(23 | 24 << 5 | 25 << 10 | 26 << 15 | 27 << 20 | 28 << 25,
+			       DDR1_ADDRMAP_3);
+			writel(29 | 12 << 5 | 13 << 10 |  5 << 15 |  0 << 20 | 30 << 25,
+			       DDR1_ADDRMAP_4);
+		}
+	}
+}
+
+void meson_dram_dmc_init(void)
+{
+	u32 ddr_size_register =3D 0;
+
+	printf("DMC version: 0x%x\n", readl(DMC_VERSION));
+
+	for (int i =3D CONFIG_DRAM_SIZE >> DMC_DRAM_SIZE_SHIFT;
+	     !((i >>=3D 1) & 1); ddr_size_register++)
+		;
+
+	if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS) || IS_ENABLED(CONFIG_DR=
AM_ONE_RANK))
+		writel(DMC_CTRL | ddr_size_register |
+			(ddr_size_register << 3),
+			DMC_DDR_CTRL);
+	else
+		writel(DMC_CTRL | ddr_size_register |
+			(5 << 3),
+			DMC_DDR_CTRL);
+
+	meson_dram_dmc_set_addrmap();
+
+	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
+		writel(0x440620, DMC_PCTL_LP_CTRL);
+		writel(BIT(13) | BIT(5), DDR0_APD_CTRL);
+		writel(0x5, DDR0_CLK_CTRL);
+
+		writel(0x11, DMC_AXI0_QOS_CTRL1);
+	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
+		writel(BIT(13), DDR0_APD_CTRL);
+	}
+
+	writel(0x0, DMC_SEC_RANGE_CTRL);
+	writel(0x80000000, DMC_SEC_CTRL);
+	writel(0x55555555, DMC_SEC_AXI_PORT_CTRL);
+	writel(0x55555555, DMC_DEV_SEC_READ_CTRL);
+	writel(0x55555555, DMC_DEV_SEC_WRITE_CTRL);
+	writel(0x15, DMC_GE2D_SEC_CTRL);
+	writel(0x5, DMC_PARSER_SEC_CTRL);
+	DMC_ENABLE_REGION(DMC_VPU);
+	DMC_ENABLE_REGION(DMC_VDEC);
+	DMC_ENABLE_REGION(DMC_HCODEC);
+	DMC_ENABLE_REGION(DMC_HEVC);
+
+	writel(0xffff, DMC_REQ_CTRL);
+
+	dmb();
+	isb();
+
+	debug("dram: memory controller init done\n");
+}
+
+int dram_init(void)
+{
+	uint ret;
+
+	debug("SPL: initialising dram\n");
+
+	meson_dram_pll_init();
+	meson_dram_phy_prepare();
+	meson_dram_phy_init();
+	meson_dram_prepare_pctl();
+	meson_dram_set_memory_timings();
+	meson_dram_set_dfi_timings();
+	ret =3D meson_dram_phy_finalise_init();
+	if (ret < 0)
+		return ret;
+	meson_dram_phy_setup_ranks();
+	meson_dram_finalise_init();
+	meson_dram_dmc_init();
+
+	/* Write size */
+	clrsetbits_32(GX_SEC_AO_SEC_GP_CFG0, GX_AO_MEM_SIZE_MASK,
+		      CONFIG_DRAM_SIZE << GX_AO_MEM_SIZE_SHIFT);
+
+	debug("SPL: dram init done\n");
+
+	return 0;
+}
diff --git a/arch/arm/mach-meson/dram-gxbb.c b/arch/arm/mach-meson/dram-g=
xbb.c
new file mode 100644
index 00000000000..9cfe3bac071
--- /dev/null
+++ b/arch/arm/mach-meson/dram-gxbb.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023-2025, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#include <init.h>
+#include <asm/unaligned.h>
+#include <linux/libfdt.h>
+#include <config.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/arch/dram-gx.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/clock-gx.h>
+#include <asm/arch/dram-settings-gx.h>
+#include <linux/delay.h>
+
+/* Meson GXBB specific DRAM init */
+
+void meson_dram_prepare_pctl(void)
+{
+	writel(PCTL0_1US_PCK, PCTL_TOGCNT1U);
+	writel(PCTL0_100NS_PCK, PCTL_TOGCNT100N);
+	writel(PCTL0_INIT_US, PCTL_TINIT);
+	writel(PCTL0_RSTH_US, PCTL_TRSTH);
+
+	writel(PCTL0_MCFG | (CONFIG_DRAM_2T_MODE ? 8 : 0),
+	       PCTL_MCFG);
+	writel(PCTL0_MCFG1, PCTL_MCFG1);
+	udelay(500);
+
+	WAIT_FOR(PCTL_DFISTSTAT0);
+
+	/* Ask the DRAM to kindly power on and wait until it is ready */
+	writel(PCTL_POWCTL_POWERON, PCTL_POWCTL);
+	WAIT_FOR(PCTL_POWSTAT);
+}
+
+void meson_dram_phy_init(void)
+{
+	/* Some unknown magic done by bl2 */
+	writel(0x49494949, DDR0_PUB_IOVCR0);
+	writel(0x49494949, DDR0_PUB_IOVCR1);
+
+	writel(PUB_ODTCR, DDR0_PUB_ODTCR);
+
+	writel(PUB_MR0, DDR0_PUB_MR0);
+	writel(PUB_MR1, DDR0_PUB_MR1);
+	writel(PUB_MR2, DDR0_PUB_MR2);
+	writel(PUB_MR3, DDR0_PUB_MR3);
+
+	/* Configure DRAM timing parameters (DTPR) */
+	writel(PUB_DTPR0, DDR0_PUB_DTPR0);
+	writel(PUB_DTPR1, DDR0_PUB_DTPR1);
+	writel(PUB_PGCR1, DDR0_PUB_PGCR1);
+	writel(PUB_DTPR2, DDR0_PUB_DTPR2);
+	writel(PUB_DTPR3, DDR0_PUB_DTPR3);
+
+	if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS))
+		writel(PUB_PGCR2 | (1 << 28), DDR0_PUB_PGCR2);
+	else
+		writel(PUB_PGCR2, DDR0_PUB_PGCR2);
+
+	writel(PUB_PGCR3, DDR0_PUB_PGCR3);
+	writel(PUB_DXCCR, DDR0_PUB_DXCCR);
+
+	writel(PUB_DTCR, DDR0_PUB_DTCR);
+	/* Wait for DLL lock */
+	WAIT_FOR(DDR0_PUB_PGSR0);
+
+	writel(0, DDR0_PUB_ACIOCR1);
+	writel(0, DDR0_PUB_ACIOCR2);
+	writel(0, DDR0_PUB_ACIOCR3);
+	writel(0, DDR0_PUB_ACIOCR4);
+	writel(0, DDR0_PUB_ACIOCR5);
+
+	writel(0, DDR0_PUB_DX0GCR1);
+	writel(0, DDR0_PUB_DX0GCR2);
+	writel((1 << 10) | (2 << 12), DDR0_PUB_DX0GCR3);
+	writel(0, DDR0_PUB_DX1GCR1);
+	writel(0, DDR0_PUB_DX1GCR2);
+	writel((1 << 10) | (2 << 12), DDR0_PUB_DX1GCR3);
+	writel(0, DDR0_PUB_DX2GCR1);
+	writel(0, DDR0_PUB_DX2GCR2);
+	writel((1 << 10) | (2 << 12), DDR0_PUB_DX2GCR3);
+	writel(0, DDR0_PUB_DX3GCR1);
+	writel(0, DDR0_PUB_DX3GCR2);
+	writel((1 << 10) | (2 << 12), DDR0_PUB_DX3GCR3);
+
+	writel(PUB_DCR, DDR0_PUB_DCR);
+
+	writel(PUB_DTAR, DDR0_PUB_DTAR0);
+	writel(PUB_DTAR | 0x8, DDR0_PUB_DTAR1);
+	writel(PUB_DTAR | 0x10, DDR0_PUB_DTAR2);
+	writel(PUB_DTAR | 0x18, DDR0_PUB_DTAR3);
+
+	writel(PUB_DSGCR, DDR0_PUB_DSGCR);
+
+	/* Wait for the SDRAM to initialise */
+	WAIT_FOR(DDR0_PUB_PGSR0);
+}
+
+void meson_dram_phy_setup_ranks(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_ONE_RANK) || IS_ENABLED(CONFIG_DRAM_TWO_DIFF=
_RANKS)) {
+		uint i =3D 0, j =3D 0;
+
+		writel((readl(DDR0_PUB_DX0LCDLR0) >> 8) |
+			(readl(DDR0_PUB_DX0LCDLR0) & 0xffffff00),
+			DDR0_PUB_DX0LCDLR0);
+
+		i =3D ((readl(DDR0_PUB_DX2GTR) >> 3) & (7 << 0));
+		j =3D ((readl(DDR0_PUB_DX2GTR) >> 14) & (3 << 0));
+		writel(i | (i << 3) | (j << 12) | (j << 14), DDR0_PUB_DX2GTR);
+
+		writel((readl(DDR0_PUB_DX2LCDLR2) >> 8) |
+			(readl(DDR0_PUB_DX2LCDLR2) & 0xffffff00),
+			DDR0_PUB_DX2LCDLR2);
+
+		writel((readl(DDR0_PUB_DX3LCDLR0) >> 8) |
+			(readl(DDR0_PUB_DX3LCDLR0) & 0xffffff00),
+			DDR0_PUB_DX3LCDLR0);
+
+		i =3D (readl(DDR0_PUB_DX3GTR) >> 3) & (7 << 0);
+		j =3D (readl(DDR0_PUB_DX3GTR) >> 14) & (3 << 0);
+		writel(i | (i << 3) | (j << 12) | (j << 14), DDR0_PUB_DX3GTR);
+
+		writel((readl(DDR0_PUB_DX3LCDLR2) >> 8) |
+			(readl(DDR0_PUB_DX3LCDLR2) & 0xffffff00),
+			DDR0_PUB_DX3LCDLR2);
+
+		writel((readl(DDR0_PUB_DX0LCDLR0) << 8) |
+			(readl(DDR0_PUB_DX0LCDLR0) & 0xffff00ff),
+			DDR0_PUB_DX0LCDLR0);
+
+		i =3D (readl(DDR0_PUB_DX0GTR) << 0) & (7 << 0);
+		j =3D (readl(DDR0_PUB_DX0GTR) >> 12) & (3 << 0);
+		writel(i | (i << 3) | (j << 12) | (j << 14), DDR0_PUB_DX0GTR);
+
+		writel((readl(DDR0_PUB_DX0LCDLR2) << 8) |
+			(readl(DDR0_PUB_DX0LCDLR2) & 0xffff00ff),
+			DDR0_PUB_DX0LCDLR2);
+
+		writel((readl(DDR0_PUB_DX1LCDLR0) << 8) |
+			(readl(DDR0_PUB_DX1LCDLR0) & 0xffff00ff),
+			DDR0_PUB_DX1LCDLR0);
+
+		i =3D (readl(DDR0_PUB_DX1GTR) << 0) & (7 << 0);
+		j =3D (readl(DDR0_PUB_DX1GTR) >> 12) & (3 << 0);
+		writel(i | (i << 3) | (j << 12) | (j << 14), DDR0_PUB_DX0GTR);
+
+		writel((readl(DDR0_PUB_DX1LCDLR2) >> 8) |
+			(readl(DDR0_PUB_DX1LCDLR2) & 0xffffff00),
+			DDR0_PUB_DX1LCDLR2);
+	}
+
+	writel((~(1 << 28)) & PUB_PGCR2, DDR0_PUB_PGCR2);
+
+	if (IS_ENABLED(CONFIG_DRAM_2T_MODE) && (PUB_DCR & 7) =3D=3D 3)
+		writel(0x1f, DDR0_PUB_ACLCDLR);
+}
+
+void meson_dram_finalise_init(void)
+{
+	WAIT_FOR(PCTL_CMDTSTAT);
+	writel(PCTL_SCTL_GO_STATE, PCTL_SCTL);
+
+	while (readl(PCTL_STAT) !=3D PCTL_STAT_ACCESS)
+		;
+	writel(0x880019d, DMC_REFR_CTRL1);
+	writel(0x20100000 | (CONFIG_DRAM_CLK / 20) |
+		(timings.refi << 8), DMC_REFR_CTRL2);
+	clrbits_32(DDR0_PUB_ZQCR, 4);
+}
diff --git a/arch/arm/mach-meson/dram-gxl.c b/arch/arm/mach-meson/dram-gx=
l.c
new file mode 100644
index 00000000000..60c41632582
--- /dev/null
+++ b/arch/arm/mach-meson/dram-gxl.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2023-2025, Ferass El Hafidi <funderscore@postmarketos.o=
rg>
+ */
+#include <init.h>
+#include <asm/unaligned.h>
+#include <linux/libfdt.h>
+#include <config.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/arch/dram-gx.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/clock-gx.h>
+#include <asm/arch/dram-settings-gx.h>
+#include <linux/delay.h>
+
+/* Meson GXL specific DRAM init */
+
+void meson_dram_prepare_pctl(void)
+{
+	writel(CONFIG_DRAM_2T_MODE ? 8 : 0, PCTL_MCFG);
+	setbits_32(PCTL_MCFG, PCTL0_MCFG);
+	udelay(500);
+
+	WAIT_FOR(PCTL_DFISTSTAT0);
+
+	/* Enter config state */
+	writel(PCTL0_SCFG, PCTL_SCFG);
+	writel(PCTL_SCTL_CFG_STATE, PCTL_SCTL);
+	WAIT_FOR(PCTL_STAT);
+
+	writel(0x581, DDR0_PUB_PIR);
+	WAIT_FOR(DDR0_PUB_PGSR0);
+}
+
+void meson_dram_phy_init(void)
+{
+	/* Some unknown magic done by bl2 */
+	writel(0x190c3500, DDR0_PUB_PTR3);
+	writel(0x12c493e0, DDR0_PUB_PTR4);
+
+	writel(0x1f090909, DDR0_PUB_IOVCR0);
+	writel(0x109, DDR0_PUB_IOVCR1);
+
+	writel(0xe09093c, DDR0_PUB_DX0GCR4);
+	writel(0xe09093c, DDR0_PUB_DX1GCR4);
+	writel(0xe09093c, DDR0_PUB_DX2GCR4);
+	writel(0xe09093c, DDR0_PUB_DX3GCR4);
+
+	writel(PUB_ODTCR, DDR0_PUB_ODTCR);
+
+	writel(PUB_MR0, DDR0_PUB_MR0);
+	writel(PUB_MR1, DDR0_PUB_MR1);
+	writel(PUB_MR2, DDR0_PUB_MR2);
+	writel(PUB_MR3, DDR0_PUB_MR3);
+	writel(PUB_MR4, DDR0_PUB_MR4);
+	writel(PUB_MR5, DDR0_PUB_MR5);
+	writel(PUB_MR6, DDR0_PUB_MR6);
+
+	/* Configure DRAM timing parameters (DTPR) */
+	writel(timings.odt | (1 << 2), DDR0_PUB_MR11);
+	writel(PUB_DTPR0, DDR0_PUB_DTPR0);
+	writel(PUB_DTPR1, DDR0_PUB_DTPR1);
+	writel(PUB_DTPR2, DDR0_PUB_DTPR2);
+	writel(PUB_DTPR3, DDR0_PUB_DTPR3);
+	writel(PUB_DTPR4, DDR0_PUB_DTPR4);
+	writel(PUB_DTPR5, DDR0_PUB_DTPR5);
+
+	if (IS_ENABLED(CONFIG_DRAM_TWO_IDENTICAL_RANKS))
+		writel(PUB_PGCR2 | (1 << 28), DDR0_PUB_PGCR2);
+	else
+		writel(PUB_PGCR2, DDR0_PUB_PGCR2);
+
+	writel(PUB_PGCR3, DDR0_PUB_PGCR3);
+	writel(PUB_DXCCR, DDR0_PUB_DXCCR);
+
+	writel(PUB_DTCR, DDR0_PUB_DTCR);
+	writel(PUB_DTCR1, DDR0_PUB_DTCR1);
+	writel(PUB_PGCR1, DDR0_PUB_PGCR1);
+
+	writel(0, DDR0_PUB_ACIOCR1);
+	writel(0, DDR0_PUB_ACIOCR2);
+	writel(0, DDR0_PUB_ACIOCR3);
+	writel(0, DDR0_PUB_ACIOCR4);
+	writel(0, DDR0_PUB_ACIOCR5);
+
+	writel(0, DDR0_PUB_DX0GCR1);
+	writel(0, DDR0_PUB_DX0GCR2);
+	writel(0, DDR0_PUB_DX1GCR1);
+	writel(0, DDR0_PUB_DX1GCR2);
+	writel(0, DDR0_PUB_DX2GCR1);
+	writel(0, DDR0_PUB_DX2GCR2);
+	writel(0, DDR0_PUB_DX3GCR1);
+	writel(0, DDR0_PUB_DX3GCR2);
+
+	if (IS_ENABLED(CONFIG_DRAM_16BIT_RANK)) {
+		writel(0, DDR0_PUB_DX2GCR0);
+		writel(0, DDR0_PUB_DX3GCR0);
+	}
+	writel(0x73, DDR0_PUB_PIR);
+	WAIT_FOR(DDR0_PUB_PGSR0);
+
+	writel(PUB_DCR | (CONFIG_DRAM_2T_MODE ? 1 << 28 : 0), DDR0_PUB_DCR);
+
+	writel(0xfc00172, DDR0_PUB_VTCR1);
+
+	writel(PUB_DSGCR & ~(0x800004), DDR0_PUB_DSGCR);
+
+	/* Wait for the SDRAM to initialise */
+	WAIT_FOR(DDR0_PUB_PGSR0);
+}
+
+void meson_dram_phy_setup_ranks(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_2T_MODE)) {
+		writel(0x3f003f, DDR0_PUB_ACBDLR2);
+		if (PUB_ACLCDLR <=3D 62) {
+			writel(((PUB_ACLCDLR - 24) + (readl(DDR0_PUB_ACMDLR0) & ~(0xe00))) |
+				(((PUB_ACLCDLR - 24) + (readl(DDR0_PUB_ACMDLR0) & ~(0xe00)))
+				* 0xffff), DDR0_PUB_ACBDLR2);
+		}
+	}
+	writel((PUB_ACLCDLR - 24) + (readl(DDR0_PUB_ACMDLR0) & ~(0xe00)), DDR0_=
PUB_ACLCDLR);
+
+	if (IS_ENABLED(CONFIG_DRAM_DQS_CORR)) {
+		/* DQS correction stuff(?) */
+		clrbits_32(DDR0_PUB_ACLCDLR, 0xe00);
+		if (!readl(DDR0_PUB_ACLCDLR))
+			writel(1, DDR0_PUB_ACLCDLR);
+
+		writel(readl(DDR0_PUB_ACLCDLR) & ~(0xe00), DDR0_PUB_ACLCDLR);
+
+		clrbits_32(DDR0_PUB_ACBDLR0, 0xe00);
+		if (!readl(DDR0_PUB_ACBDLR0))
+			writel(1, DDR0_PUB_ACBDLR0);
+
+		writel(readl(DDR0_PUB_ACBDLR0) & ~(0xc0), DDR0_PUB_ACBDLR0);
+
+		DQSCORR_DX(DDR0_PUB_DX0LCDLR0);
+		DQSCORR_DX(DDR0_PUB_DX1LCDLR0);
+		DQSCORR_DX(DDR0_PUB_DX2LCDLR0);
+		DQSCORR_DX(DDR0_PUB_DX3LCDLR0);
+	}
+}
+
+void meson_dram_finalise_init(void)
+{
+	writel((0x3f << 12) | 0xf8, DDR0_PUB_PGCR6);
+	writel(PCTL_SCTL_GO_STATE, PCTL_SCTL);
+	while ((readl(PCTL_STAT) & 7) !=3D PCTL_STAT_ACCESS)
+		;
+
+	writel(0xfffc << 16, DDR0_PUB_DX0GCR3);
+	writel(0xfffc << 16, DDR0_PUB_DX1GCR3);
+	writel(0xfffc << 16, DDR0_PUB_DX2GCR3);
+	writel(0xfffc << 16, DDR0_PUB_DX3GCR3);
+
+	writel(0, DDR0_PUB_RANKIDR);
+	writel(PUB_DSGCR | 0x800004, DDR0_PUB_DSGCR);
+
+	setbits_32(DDR0_PUB_ZQCR, 4);
+	writel(0x20100000 | ((CONFIG_DRAM_CLK / 20) - 1) |
+		(timings.refi << 8), DMC_REFR_CTRL2);
+	writel(0xf08f, DMC_REFR_CTRL1);
+}
+

--=20
2.51.0


