Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.266.1616683788159490208
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Mar 2021 07:49:48 -0700
Received: by mail-wm1-f42.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so3264463wml.2
        for <u-boot-amlogic@groups.io>; Thu, 25 Mar 2021 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQXHVPM1bxAFvshoCX1Zdm6Y5rmz9pV3BQQaNu7bPSc=;
        b=i/fPyEWSSJIzWYAhAZpyS5Sb7zXEsHGvx45nTpG/kPczN+126WQ6m5GIQlclWzEZxU
         9nokSVgKPW+/+l7icotKeLd/Q6Htly2DXS8XWz3uf+vkeqLuZ1IWsFsoqpRavQCHJRWt
         hwklXv+XbxvVc1Cc3F/g6qCQwSsgKwIGNSVX0pSEzyEKpt27IFZAWE0UGzeZsbQowouh
         Q1BXex3NZzfqNMd1yXY8bQyHJ6QAGv9py5AWUweIbcwu7z+CPFGzZljTb/uZ5oqAyXGU
         3JHLhhk2gIm3Y2Gkrh4bH9/gcVf/XhzKkD+IhRA4V9k3fJTNS30owpB+qBl/fTRFfR4D
         3PeQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH RFT v2 4/4] pci: add Amlogic Meson Designware PCIe controller
Date: Thu, 25 Mar 2021 15:49:21 +0100
Message-Id: <20210325144921.1791892-5-narmstrong@baylibre.com>
In-Reply-To: <20210325144921.1791892-1-narmstrong@baylibre.com>
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: lokeshvutla@ti.com, nsekhar@ti.com, shawn.lin@rock-chips.com, bmeng.cn@gmail.com, green.wan@sifive.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the DW PCIe controller found in the Amlogic Meson AXG and
G12 (G12A, G12B, SM1) SoCs.
This uses the common DW PCIe helpers introducted previously.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/Kconfig         |   8 +
 drivers/pci/Makefile        |   1 +
 drivers/pci/pcie_dw_meson.c | 459 ++++++++++++++++++++++++++++++++++++
 3 files changed, 468 insertions(+)
 create mode 100644 drivers/pci/pcie_dw_meson.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index cacfc4bd25..cdcdd8f456 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -276,6 +276,14 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable Gen2 PCIe controller,
 	  which could be found on MT7623 SoC family.
 
+config PCIE_DW_MESON
+	bool "Amlogic Meson DesignWare based PCIe controller"
+	depends on ARCH_MESON
+	select PCIE_DW_COMMON
+	help
+	  Say Y here if you want to enable DW PCIe controller support on
+	  Amlogic SoCs.
+
 config PCIE_ROCKCHIP
 	bool "Enable Rockchip PCIe driver"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e3ca8b27e4..96d61821fe 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -50,5 +50,6 @@ obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie_rockchip.o
 obj-$(CONFIG_PCIE_DW_ROCKCHIP) += pcie_dw_rockchip.o
+obj-$(CONFIG_PCIE_DW_MESON) += pcie_dw_meson.o
 obj-$(CONFIG_PCI_BRCMSTB) += pcie_brcmstb.o
 obj-$(CONFIG_PCI_OCTEONTX) += pci_octeontx.o
diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
new file mode 100644
index 0000000000..0525ecbea6
--- /dev/null
+++ b/drivers/pci/pcie_dw_meson.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic DesignWare based PCIe host controller driver
+ *
+ * Copyright (c) 2021 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Based on pcie_dw_rockchip.c
+ * Copyright (c) 2021 Rockchip, Inc.
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <pci.h>
+#include <power-domain.h>
+#include <reset.h>
+#include <syscon.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm-generic/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/iopoll.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/bitfield.h>
+
+#include "pcie_dw_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * struct meson_pcie - Amlogic Meson DW PCIe controller state
+ *
+ * @pci: The common PCIe DW structure
+ * @meson_cfg_base: The base address of vendor regs
+ * @phy
+ * @clk_port
+ * @clk_general
+ * @clk_pclk
+ * @rsts
+ * @rst_gpio: The #PERST signal for slot
+ */
+struct meson_pcie {
+	/* Must be first member of the struct */
+	struct pcie_dw dw;
+	void *meson_cfg_base;
+	struct phy phy;
+	struct clk clk_port;
+	struct clk clk_general;
+	struct clk clk_pclk;
+	struct reset_ctl_bulk rsts;
+	struct gpio_desc rst_gpio;
+};
+
+#define PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+
+#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
+#define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
+
+/* PCIe specific config registers */
+#define PCIE_CFG0			0x0
+#define APP_LTSSM_ENABLE		BIT(7)
+
+#define PCIE_CFG_STATUS12		0x30
+#define IS_SMLH_LINK_UP(x)		((x) & (1 << 6))
+#define IS_RDLH_LINK_UP(x)		((x) & (1 << 16))
+#define IS_LTSSM_UP(x)			((((x) >> 10) & 0x1f) == 0x11)
+
+#define PCIE_CFG_STATUS17		0x44
+#define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
+
+#define WAIT_LINKUP_TIMEOUT		4000
+#define PORT_CLK_RATE			100000000UL
+#define MAX_PAYLOAD_SIZE		256
+#define MAX_READ_REQ_SIZE		256
+#define PCIE_RESET_DELAY		500
+#define PCIE_SHARED_RESET		1
+#define PCIE_NORMAL_RESET		0
+
+enum pcie_data_rate {
+	PCIE_GEN1,
+	PCIE_GEN2,
+	PCIE_GEN3,
+	PCIE_GEN4
+};
+
+/* Parameters for the waiting for #perst signal */
+#define PERST_WAIT_US			1000000
+
+static inline u32 meson_cfg_readl(struct meson_pcie *priv, u32 reg)
+{
+	return readl(priv->meson_cfg_base + reg);
+}
+
+static inline void meson_cfg_writel(struct meson_pcie *priv, u32 val, u32 reg)
+{
+	writel(val, priv->meson_cfg_base + reg);
+}
+
+/**
+ * meson_pcie_configure() - Configure link
+ *
+ * @meson_pcie: Pointer to the PCI controller state
+ *
+ * Configure the link mode and width
+ */
+static void meson_pcie_configure(struct meson_pcie *priv)
+{
+	u32 val;
+
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+
+	val = readl(priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
+	val &= ~PORT_LINK_FAST_LINK_MODE;
+	val |= PORT_LINK_DLL_LINK_EN;
+	val &= ~PORT_LINK_MODE_MASK;
+	val |= PORT_LINK_MODE_1_LANES;
+	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
+
+	val = readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
+	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static inline void meson_pcie_enable_ltssm(struct meson_pcie *priv)
+{
+	u32 val;
+
+	val = meson_cfg_readl(priv, PCIE_CFG0);
+	val |= APP_LTSSM_ENABLE;
+	meson_cfg_writel(priv, val, PCIE_CFG0);
+}
+
+static int meson_pcie_wait_link_up(struct meson_pcie *priv)
+{
+	u32 speed_okay = 0;
+	u32 cnt = 0;
+	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
+
+	do {
+		state12 = meson_cfg_readl(priv, PCIE_CFG_STATUS12);
+		state17 = meson_cfg_readl(priv, PCIE_CFG_STATUS17);
+		smlh_up = IS_SMLH_LINK_UP(state12);
+		rdlh_up = IS_RDLH_LINK_UP(state12);
+		ltssm_up = IS_LTSSM_UP(state12);
+
+		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
+			speed_okay = 1;
+
+		if (smlh_up)
+			debug("%s: smlh_link_up is on\n", __func__);
+		if (rdlh_up)
+			debug("%s: rdlh_link_up is on\n", __func__);
+		if (ltssm_up)
+			debug("%s: ltssm_up is on\n", __func__);
+		if (speed_okay)
+			debug("%s: speed_okay\n", __func__);
+
+		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
+			return 0;
+
+		cnt++;
+
+		udelay(10);
+	} while (cnt < WAIT_LINKUP_TIMEOUT);
+
+	printf("%s: error: wait linkup timeout\n", __func__);
+	return -EIO;
+}
+
+/**
+ * meson_pcie_link_up() - Wait for the link to come up
+ *
+ * @meson_pcie: Pointer to the PCI controller state
+ * @cap_speed: Desired link speed
+ *
+ * Return: 1 (true) for active line and negative (false) for no link (timeout)
+ */
+static int meson_pcie_link_up(struct meson_pcie *priv, u32 cap_speed)
+{
+	/* DW link configurations */
+	meson_pcie_configure(priv);
+
+	/* Reset the device */
+	if (dm_gpio_is_valid(&priv->rst_gpio)) {
+		dm_gpio_set_value(&priv->rst_gpio, 1);
+		/*
+		 * Minimal is 100ms from spec but we see
+		 * some wired devices need much more, such as 600ms.
+		 * Add a enough delay to cover all cases.
+		 */
+		udelay(PERST_WAIT_US);
+		dm_gpio_set_value(&priv->rst_gpio, 0);
+	}
+
+	/* Enable LTSSM */
+	meson_pcie_enable_ltssm(priv);
+
+	return meson_pcie_wait_link_up(priv);
+}
+
+static int meson_size_to_payload(int size)
+{
+	/*
+	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
+	 * So if input size is not 2^order alignment or less than 2^7 or bigger
+	 * than 2^12, just set to default size 2^(1+7).
+	 */
+	if (!is_power_of_2(size) || size < 128 || size > 4096) {
+		debug("%s: payload size %d, set to default 256\n", __func__, size);
+		return 1;
+	}
+
+	return fls(size) - 8;
+}
+
+static void meson_set_max_payload(struct meson_pcie *priv, int size)
+{
+	u32 val;
+	u16 offset = dm_pci_find_capability(priv->dw.dev, PCI_CAP_ID_EXP);
+	int max_payload_size = meson_size_to_payload(size);
+
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+
+	val = readl(priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	writel(val, priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+
+	val = readl(priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
+	writel(val, priv->dw.dbi_base + PCI_EXP_DEVCTL);
+
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static void meson_set_max_rd_req_size(struct meson_pcie *priv, int size)
+{
+	u32 val;
+	u16 offset = dm_pci_find_capability(priv->dw.dev, PCI_CAP_ID_EXP);
+	int max_rd_req_size = meson_size_to_payload(size);
+
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+
+	val = readl(priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	writel(val, priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+
+	val = readl(priv->dw.dbi_base + offset + PCI_EXP_DEVCTL);
+	val |= PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size);
+	writel(val, priv->dw.dbi_base + PCI_EXP_DEVCTL);
+
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static int meson_pcie_init_port(struct udevice *dev)
+{
+	int ret;
+	struct meson_pcie *priv = dev_get_priv(dev);
+
+	ret = generic_phy_init(&priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to init phy (ret=%d)\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_power_on(&priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to power on phy (ret=%d)\n", ret);
+		goto err_exit_phy;
+	}
+
+	ret = generic_phy_reset(&priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to reset phy (ret=%d)\n", ret);
+		goto err_exit_phy;
+	}
+
+	ret = reset_assert_bulk(&priv->rsts);
+	if (ret) {
+		dev_err(dev, "failed to assert resets (ret=%d)\n", ret);
+		goto err_power_off_phy;
+	}
+
+	udelay(PCIE_RESET_DELAY);
+
+	ret = reset_deassert_bulk(&priv->rsts);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets (ret=%d)\n", ret);
+		goto err_power_off_phy;
+	}
+
+	udelay(PCIE_RESET_DELAY);
+
+	ret = clk_set_rate(&priv->clk_port, PORT_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "failed to set port clk rate (ret=%d)\n", ret);
+		goto err_deassert_bulk;
+	}
+
+	ret = clk_enable(&priv->clk_general);
+	if (ret) {
+		dev_err(dev, "failed to enable clk general (ret=%d)\n", ret);
+		goto err_deassert_bulk;
+	}
+
+	ret = clk_enable(&priv->clk_pclk);
+	if (ret) {
+		dev_err(dev, "failed to enable pclk (ret=%d)\n", ret);
+		goto err_deassert_bulk;
+	}
+
+	meson_set_max_payload(priv, MAX_PAYLOAD_SIZE);
+	meson_set_max_rd_req_size(priv, MAX_READ_REQ_SIZE);
+
+	pcie_dw_setup_host(&priv->dw);
+
+	ret = meson_pcie_link_up(priv, LINK_SPEED_GEN_2);
+	if (ret < 0)
+		goto err_link_up;
+
+	return 0;
+err_link_up:
+	clk_disable(&priv->clk_port);
+	clk_disable(&priv->clk_general);
+	clk_disable(&priv->clk_pclk);
+err_deassert_bulk:
+	reset_assert_bulk(&priv->rsts);
+err_power_off_phy:
+	generic_phy_power_off(&priv->phy);
+err_exit_phy:
+	generic_phy_exit(&priv->phy);
+
+	return ret;
+}
+
+static int meson_pcie_parse_dt(struct udevice *dev)
+{
+	struct meson_pcie *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->dw.dbi_base = (void *)dev_read_addr_index(dev, 0);
+	if (!priv->dw.dbi_base)
+		return -ENODEV;
+
+	dev_dbg(dev, "ELBI address is 0x%p\n", priv->dw.dbi_base);
+
+	priv->meson_cfg_base = (void *)dev_read_addr_index(dev, 1);
+	if (!priv->meson_cfg_base)
+		return -ENODEV;
+
+	dev_dbg(dev, "CFG address is 0x%p\n", priv->meson_cfg_base);
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->rst_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "failed to find reset-gpios property\n");
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &priv->rsts);
+	if (ret) {
+		dev_err(dev, "Can't get reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "port", &priv->clk_port);
+	if (ret) {
+		dev_err(dev, "Can't get port clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "general", &priv->clk_general);
+	if (ret) {
+		dev_err(dev, "Can't get port clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "pclk", &priv->clk_pclk);
+	if (ret) {
+		dev_err(dev, "Can't get port clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_get_by_index(dev, 0, &priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to get pcie phy (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * meson_pcie_probe() - Probe the PCIe bus for active link
+ *
+ * @dev: A pointer to the device being operated on
+ *
+ * Probe for an active link on the PCIe bus and configure the controller
+ * to enable this port.
+ *
+ * Return: 0 on success, else -ENODEV
+ */
+static int meson_pcie_probe(struct udevice *dev)
+{
+	struct meson_pcie *priv = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	int ret = 0;
+
+	priv->dw.first_busno = dev_seq(dev);
+	priv->dw.dev = dev;
+
+	ret = meson_pcie_parse_dt(dev);
+	if (ret)
+		return ret;
+
+	ret = meson_pcie_init_port(dev);
+	if (ret) {
+		dm_gpio_free(dev, &priv->rst_gpio);
+		return ret;
+	}
+
+	printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n",
+	       dev_seq(dev), pcie_dw_get_link_speed(&priv->dw),
+	       pcie_dw_get_link_width(&priv->dw),
+	       hose->first_busno);
+
+	return pcie_dw_prog_outbound_atu_unroll(&priv->dw,
+						PCIE_ATU_REGION_INDEX0,
+						PCIE_ATU_TYPE_MEM,
+						priv->dw.mem.phys_start,
+						priv->dw.mem.bus_start,
+						priv->dw.mem.size);
+}
+
+static const struct dm_pci_ops meson_pcie_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id meson_pcie_ids[] = {
+	{ .compatible = "amlogic,axg-pcie" },
+	{ .compatible = "amlogic,g12a-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_dw_pcie) = {
+	.name			= "pcie_dw_meson",
+	.id			= UCLASS_PCI,
+	.of_match		= meson_pcie_ids,
+	.ops			= &meson_pcie_ops,
+	.probe			= meson_pcie_probe,
+	.priv_auto		= sizeof(struct meson_pcie),
+};
-- 
2.25.1

