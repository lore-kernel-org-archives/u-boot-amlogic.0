Received: by mail-wr1-f65.google.com with SMTP id w10so3466841wrm.4
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6722Xx2zOCeaB8/2gvoMh6t8jeGGH4lpOqR8WhzkWc=;
        b=JfPzBle+ojydru8GKrUahlYkI6u0oc0BQ7d5npclwQbzhuqg1a2hviNZ0/d1AZ+sWq
         FGOGY3sDHafr6CxdZQzoy17Ndfy+arKs4iSHOsNBJy3NqaTvtEwqqFbs785PK85HPQV0
         blLoFrd6ho7BMzm4oceqFgym0McrSw98+zjaF+3A/SS8KUQ9FpTbJ1TAOZNCHs3ePuCp
         fZ+UDx1ekWlMYXnTJu0FFey8SoILZE7VTSGLiwHntGdHySngcwdSPbFuE2KD4yyJFCxZ
         hiMNMDM03GIkwqy3FN8Ts2H2orS4qfv6NnoR6gpkE0+/UiwavzmAyix3iYpNw2MMk79T
         YxVw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 4/6] ARM: meson: add G12a support
Date: Wed, 10 Apr 2019 17:23:46 +0200
Message-Id: <20190410152348.13777-5-narmstrong@baylibre.com>
In-Reply-To: <20190410152348.13777-1-narmstrong@baylibre.com>
References: <20190410152348.13777-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Jerome Brunet <jbrunet@baylibre.com>

Add support for the Amlogic G12A SoC, which is a mix between the
new physical memory mapping of AXG and the functionnalities of
the previous Amlogic GXL/GXM SoCs.

To handle the internal ethernet PHY, the Amlogic G12A SoCs now
embeds a dedicated PLL to feed the internal PHY.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/g12a.h |  66 +++++++++++
 arch/arm/mach-meson/Kconfig            |   9 +-
 arch/arm/mach-meson/Makefile           |   1 +
 arch/arm/mach-meson/board-g12a.c       | 150 +++++++++++++++++++++++++
 4 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/arch-meson/g12a.h
 create mode 100644 arch/arm/mach-meson/board-g12a.c

diff --git a/arch/arm/include/asm/arch-meson/g12a.h b/arch/arm/include/asm/arch-meson/g12a.h
new file mode 100644
index 0000000000..b806667860
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/g12a.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __G12A_H__
+#define __G12A_H__
+
+#define G12A_AOBUS_BASE			0xff800000
+#define G12A_PERIPHS_BASE		0xff634400
+#define G12A_HIU_BASE			0xff63c000
+#define G12A_ETH_PHY_BASE		0xff64c000
+#define G12A_ETH_BASE			0xff3f0000
+
+/* Always-On Peripherals registers */
+#define G12A_AO_ADDR(off)	(G12A_AOBUS_BASE + ((off) << 2))
+
+#define G12A_AO_SEC_GP_CFG0		G12A_AO_ADDR(0x90)
+#define G12A_AO_SEC_GP_CFG3		G12A_AO_ADDR(0x93)
+#define G12A_AO_SEC_GP_CFG4		G12A_AO_ADDR(0x94)
+#define G12A_AO_SEC_GP_CFG5		G12A_AO_ADDR(0x95)
+
+#define G12A_AO_BOOT_DEVICE		0xF
+#define G12A_AO_MEM_SIZE_MASK		0xFFFF0000
+#define G12A_AO_MEM_SIZE_SHIFT		16
+#define G12A_AO_BL31_RSVMEM_SIZE_MASK	0xFFFF0000
+#define G12A_AO_BL31_RSVMEM_SIZE_SHIFT	16
+#define G12A_AO_BL32_RSVMEM_SIZE_MASK	0xFFFF
+
+/* Peripherals registers */
+#define G12A_PERIPHS_ADDR(off)	(G12A_PERIPHS_BASE + ((off) << 2))
+
+#define G12A_ETH_REG_0			G12A_PERIPHS_ADDR(0x50)
+#define G12A_ETH_REG_1			G12A_PERIPHS_ADDR(0x51)
+
+#define G12A_ETH_REG_0_PHY_INTF_RGMII	BIT(0)
+#define G12A_ETH_REG_0_PHY_INTF_RMII	BIT(2)
+#define G12A_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
+#define G12A_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
+#define G12A_ETH_REG_0_PHY_CLK_EN	BIT(10)
+#define G12A_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
+#define G12A_ETH_REG_0_CLK_EN		BIT(12)
+
+#define G12A_ETH_PHY_ADDR(off)	(G12A_ETH_PHY_BASE + ((off) << 2))
+#define ETH_PLL_CNTL0			G12A_ETH_PHY_ADDR(0x11)
+#define ETH_PLL_CNTL1			G12A_ETH_PHY_ADDR(0x12)
+#define ETH_PLL_CNTL2			G12A_ETH_PHY_ADDR(0x13)
+#define ETH_PLL_CNTL3			G12A_ETH_PHY_ADDR(0x14)
+#define ETH_PLL_CNTL4			G12A_ETH_PHY_ADDR(0x15)
+#define ETH_PLL_CNTL5			G12A_ETH_PHY_ADDR(0x16)
+#define ETH_PLL_CNTL6			G12A_ETH_PHY_ADDR(0x17)
+#define ETH_PLL_CNTL7			G12A_ETH_PHY_ADDR(0x18)
+#define ETH_PHY_CNTL0			G12A_ETH_PHY_ADDR(0x20)
+#define ETH_PHY_CNTL1			G12A_ETH_PHY_ADDR(0x21)
+#define ETH_PHY_CNTL2			G12A_ETH_PHY_ADDR(0x22)
+
+/* HIU registers */
+#define G12A_HIU_ADDR(off)	(G12A_HIU_BASE + ((off) << 2))
+
+#define G12A_MEM_PD_REG_0		G12A_HIU_ADDR(0x40)
+
+/* Ethernet memory power domain */
+#define G12A_MEM_PD_REG_0_ETH_MASK	(BIT(2) | BIT(3))
+
+#endif /* __G12A_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 1b1d0aef0d..e29e4c0acc 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -41,7 +41,13 @@ config MESON_AXG
 	bool "AXG"
 	select MESON64_COMMON
 	help
-		Select this if your SoC is an A113X/D
+	  Select this if your SoC is an A113X/D
+
+config MESON_G12A
+	bool "G12A"
+	select MESON64_COMMON
+	help
+	  Select this if your SoC is an S905X/D2
 
 endchoice
 
@@ -65,6 +71,7 @@ config SYS_BOARD
 	default "p212" if MESON_GXL
 	default "q200" if MESON_GXM
 	default "s400" if MESON_AXG
+	default "u200" if MESON_G12A
 	default ""
 	help
 	  This option contains information about board name.
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 6ddfba606b..a9e4046f80 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -5,3 +5,4 @@
 obj-y += board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
 obj-$(CONFIG_MESON_AXG) += board-axg.o
+obj-$(CONFIG_MESON_G12A) += board-g12a.o
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
new file mode 100644
index 0000000000..fc3764b960
--- /dev/null
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
+ * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/g12a.h>
+#include <asm/arch/mem.h>
+#include <asm/io.h>
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+#include <phy.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int meson_get_boot_device(void)
+{
+	return readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_BOOT_DEVICE;
+}
+
+/* Configure the reserved memory zones exported by the secure registers
+ * into EFI and DTB reserved memory entries.
+ */
+void meson_init_reserved_memory(void *fdt)
+{
+	u64 bl31_size, bl31_start;
+	u64 bl32_size, bl32_start;
+	u32 reg;
+
+	/*
+	 * Get ARM Trusted Firmware reserved memory zones in :
+	 * - AO_SEC_GP_CFG3: bl32 & bl31 size in KiB, can be 0
+	 * - AO_SEC_GP_CFG5: bl31 physical start address, can be NULL
+	 * - AO_SEC_GP_CFG4: bl32 physical start address, can be NULL
+	 */
+	reg = readl(G12A_AO_SEC_GP_CFG3);
+
+	bl31_size = ((reg & G12A_AO_BL31_RSVMEM_SIZE_MASK)
+			>> G12A_AO_BL31_RSVMEM_SIZE_SHIFT) * SZ_1K;
+	bl32_size = (reg & G12A_AO_BL32_RSVMEM_SIZE_MASK) * SZ_1K;
+
+	bl31_start = readl(G12A_AO_SEC_GP_CFG5);
+	bl32_start = readl(G12A_AO_SEC_GP_CFG4);
+
+	/* Add BL31 reserved zone */
+	if (bl31_start && bl31_size)
+		meson_board_add_reserved_memory(fdt, bl31_start, bl31_size);
+
+	/* Add BL32 reserved zone */
+	if (bl32_start && bl32_size)
+		meson_board_add_reserved_memory(fdt, bl32_start, bl32_size);
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	/* Size is reported in MiB, convert it in bytes */
+	return ((readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_MEM_SIZE_MASK)
+			>> G12A_AO_MEM_SIZE_SHIFT) * SZ_1M;
+}
+
+static struct mm_region g12a_mem_map[] = {
+	{
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0xf0000000UL,
+		.phys = 0xf0000000UL,
+		.size = 0x10000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = g12a_mem_map;
+
+static void g12a_enable_external_mdio(void)
+{
+	writel(0x0, ETH_PHY_CNTL2);
+}
+
+static void g12a_enable_internal_mdio(void)
+{
+	/* Fire up the PHY PLL */
+	writel(0x29c0040a, ETH_PLL_CNTL0);
+	writel(0x927e0000, ETH_PLL_CNTL1);
+	writel(0xac5f49e5, ETH_PLL_CNTL2);
+	writel(0x00000000, ETH_PLL_CNTL3);
+	writel(0x00000000, ETH_PLL_CNTL4);
+	writel(0x20200000, ETH_PLL_CNTL5);
+	writel(0x0000c002, ETH_PLL_CNTL6);
+	writel(0x00000023, ETH_PLL_CNTL7);
+	writel(0x39c0040a, ETH_PLL_CNTL0);
+	writel(0x19c0040a, ETH_PLL_CNTL0);
+
+	/* Select the internal MDIO */
+	writel(0x33000180, ETH_PHY_CNTL0);
+	writel(0x00074043, ETH_PHY_CNTL1);
+	writel(0x00000260, ETH_PHY_CNTL2);
+}
+
+/* Configure the Ethernet MAC with the requested interface mode
+ * with some optional flags.
+ */
+void meson_eth_init(phy_interface_t mode, unsigned int flags)
+{
+	switch (mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* Set RGMII mode */
+		setbits_le32(G12A_ETH_REG_0, G12A_ETH_REG_0_PHY_INTF_RGMII |
+			     G12A_ETH_REG_0_TX_PHASE(1) |
+			     G12A_ETH_REG_0_TX_RATIO(4) |
+			     G12A_ETH_REG_0_PHY_CLK_EN |
+			     G12A_ETH_REG_0_CLK_EN);
+		break;
+
+	case PHY_INTERFACE_MODE_RMII:
+		/* Set RMII mode */
+		out_le32(G12A_ETH_REG_0, G12A_ETH_REG_0_PHY_INTF_RMII |
+					G12A_ETH_REG_0_INVERT_RMII_CLK |
+					G12A_ETH_REG_0_CLK_EN);
+
+		/* Use G12A RMII Internal PHY */
+		if (flags & MESON_USE_INTERNAL_RMII_PHY)
+			g12a_enable_internal_mdio();
+		else
+			g12a_enable_external_mdio();
+
+		break;
+
+	default:
+		printf("Invalid Ethernet interface mode\n");
+		return;
+	}
+
+	/* Enable power gate */
+	clrbits_le32(G12A_MEM_PD_REG_0, G12A_MEM_PD_REG_0_ETH_MASK);
+}
-- 
2.21.0

