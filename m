Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web08.267.1616683783943239290
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Mar 2021 07:49:44 -0700
Received: by mail-wm1-f47.google.com with SMTP id k128so1324841wmk.4
        for <u-boot-amlogic@groups.io>; Thu, 25 Mar 2021 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpxBpwqyHRcNf0UwfTAv7YWybWU+QUuq14KpZj5P7to=;
        b=WZBT56ax42ltRzlk1VjKxO4pFA9ZL7dnSxYWtHdim/XRZ2/t6Lom7/nlO5zbKONhv7
         aa15Ixhf+IapKU6yq4SK/pW9V4EFMeYl0hi8KW6VgoIeQJVzxeGR2x7EagEcttBrHZfF
         tA26qprFJABGe13+wjPd77BTlMTdhtLUGXWx286/I5Spz935A3yCC956CTN5m2FqfDav
         NFT3V6y1vTzY0XbHKRygdEjwb1yVRasfskeVrSUD3Q/tLs2Vjxbq2HGclNoZe5fca/0c
         q3yiWRD88vK3NUAP/nSk6kSiKR+bKtaF3ZeiMKr2EYn37bt5ZGMrotzmMWKZTWO6IxpR
         bLeQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH RFT v2 3/4] pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
Date: Thu, 25 Mar 2021 15:49:20 +0100
Message-Id: <20210325144921.1791892-4-narmstrong@baylibre.com>
In-Reply-To: <20210325144921.1791892-1-narmstrong@baylibre.com>
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: lokeshvutla@ti.com, nsekhar@ti.com, shawn.lin@rock-chips.com, bmeng.cn@gmail.com, green.wan@sifive.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Migrate the dw_rockchip driver to use the common DW PCIe helpers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/Kconfig            |   2 +-
 drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
 2 files changed, 30 insertions(+), 444 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 318d8fa37d..cacfc4bd25 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -289,7 +289,7 @@ config PCIE_ROCKCHIP
 config PCIE_DW_ROCKCHIP
 	bool "Rockchip DesignWare based PCIe controller"
 	depends on ARCH_ROCKCHIP
-	select DM_PCI
+	select PCIE_DW_COMMON
 	select PHY_ROCKCHIP_SNPS_PCIE3
 	help
 	  Say Y here if you want to enable DW PCIe controller support on
diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 77f1a1b48f..bc22af4230 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -22,39 +22,26 @@
 #include <linux/delay.h>
 #include <power/regulator.h>
 
+#include "pcie_dw_common.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 /**
  * struct rk_pcie - RK DW PCIe controller state
  *
  * @vpcie3v3: The 3.3v power supply for slot
- * @dbi_base: The base address of dwc core regs
  * @apb_base: The base address of vendor regs
- * @cfg_base: The base address of config header space
- * @cfg_size: The size of the configuration space which is needed
- *            as it gets written into the PCIE_ATU_LIMIT register
- * @first_busno: This driver supports multiple PCIe controllers.
- *               first_busno stores the bus number of the PCIe root-port
- *               number which may vary depending on the PCIe setup
- *               (PEX switches etc).
  * @rst_gpio: The #PERST signal for slot
- * @io:	The IO space for EP's BAR
- * @mem: The memory space for EP's BAR
  */
 struct rk_pcie {
-	struct udevice	*dev;
+	/* Must be first member of the struct */
+	struct pcie_dw  dw;
 	struct udevice  *vpcie3v3;
-	void		*dbi_base;
 	void		*apb_base;
-	void		*cfg_base;
-	fdt_size_t	cfg_size;
 	struct phy	phy;
 	struct clk_bulk	clks;
-	int		first_busno;
 	struct reset_ctl_bulk	rsts;
 	struct gpio_desc	rst_gpio;
-	struct pci_region	io;
-	struct pci_region	mem;
 };
 
 /* Parameters for the waiting for iATU enabled routine */
@@ -73,59 +60,6 @@ struct rk_pcie {
 #define PCIE_CLIENT_DBG_TRANSITION_DATA	0xffff0000
 #define PCIE_CLIENT_DBF_EN		0xffff0003
 
-/* PCI DBICS registers */
-#define PCIE_LINK_STATUS_REG		0x80
-#define PCIE_LINK_STATUS_SPEED_OFF	16
-#define PCIE_LINK_STATUS_SPEED_MASK	(0xf << PCIE_LINK_STATUS_SPEED_OFF)
-#define PCIE_LINK_STATUS_WIDTH_OFF	20
-#define PCIE_LINK_STATUS_WIDTH_MASK	(0xf << PCIE_LINK_STATUS_WIDTH_OFF)
-
-#define PCIE_LINK_CAPABILITY		0x7c
-#define PCIE_LINK_CTL_2			0xa0
-#define TARGET_LINK_SPEED_MASK		0xf
-#define LINK_SPEED_GEN_1		0x1
-#define LINK_SPEED_GEN_2		0x2
-#define LINK_SPEED_GEN_3		0x3
-
-#define PCIE_MISC_CONTROL_1_OFF		0x8bc
-#define PCIE_DBI_RO_WR_EN		BIT(0)
-
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80c
-#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
-
-/*
- * iATU Unroll-specific register definitions
- * From 4.80 core version the address translation will be made by unroll.
- * The registers are offset from atu_base
- */
-#define PCIE_ATU_UNR_REGION_CTRL1	0x00
-#define PCIE_ATU_UNR_REGION_CTRL2	0x04
-#define PCIE_ATU_UNR_LOWER_BASE		0x08
-#define PCIE_ATU_UNR_UPPER_BASE		0x0c
-#define PCIE_ATU_UNR_LIMIT		0x10
-#define PCIE_ATU_UNR_LOWER_TARGET	0x14
-#define PCIE_ATU_UNR_UPPER_TARGET	0x18
-
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
-
-/* Register address builder */
-#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)        \
-	((0x3 << 20) | ((region) << 9))
-
-/* Parameters for the waiting for iATU enabled routine */
-#define LINK_WAIT_MAX_IATU_RETRIES	5
-#define LINK_WAIT_IATU_US		10000
-
 /* Parameters for the waiting for #perst signal */
 #define PERST_WAIT_MS			1000
 
@@ -175,7 +109,7 @@ static u32 __rk_pcie_read_apb(struct rk_pcie *rk_pcie, void __iomem *base,
 
 	ret = rk_pcie_read(base + reg, size, &val);
 	if (ret)
-		dev_err(rk_pcie->dev, "Read APB address failed\n");
+		dev_err(rk_pcie->dw.dev, "Read APB address failed\n");
 
 	return val;
 }
@@ -187,7 +121,7 @@ static void __rk_pcie_write_apb(struct rk_pcie *rk_pcie, void __iomem *base,
 
 	ret = rk_pcie_write(base + reg, size, val);
 	if (ret)
-		dev_err(rk_pcie->dev, "Write APB address failed\n");
+		dev_err(rk_pcie->dw.dev, "Write APB address failed\n");
 }
 
 /**
@@ -214,91 +148,6 @@ static inline void rk_pcie_writel_apb(struct rk_pcie *rk_pcie, u32 reg,
 	__rk_pcie_write_apb(rk_pcie, rk_pcie->apb_base, reg, 0x4, val);
 }
 
-static int rk_pcie_get_link_speed(struct rk_pcie *rk_pcie)
-{
-	return (readl(rk_pcie->dbi_base + PCIE_LINK_STATUS_REG) &
-		PCIE_LINK_STATUS_SPEED_MASK) >> PCIE_LINK_STATUS_SPEED_OFF;
-}
-
-static int rk_pcie_get_link_width(struct rk_pcie *rk_pcie)
-{
-	return (readl(rk_pcie->dbi_base + PCIE_LINK_STATUS_REG) &
-		PCIE_LINK_STATUS_WIDTH_MASK) >> PCIE_LINK_STATUS_WIDTH_OFF;
-}
-
-static void rk_pcie_writel_ob_unroll(struct rk_pcie *rk_pcie, u32 index,
-				     u32 reg, u32 val)
-{
-	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
-	void __iomem *base = rk_pcie->dbi_base;
-
-	writel(val, base + offset + reg);
-}
-
-static u32 rk_pcie_readl_ob_unroll(struct rk_pcie *rk_pcie, u32 index, u32 reg)
-{
-	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
-	void __iomem *base = rk_pcie->dbi_base;
-
-	return readl(base + offset + reg);
-}
-
-static inline void rk_pcie_dbi_write_enable(struct rk_pcie *rk_pcie, bool en)
-{
-	u32 val;
-
-	val = readl(rk_pcie->dbi_base + PCIE_MISC_CONTROL_1_OFF);
-
-	if (en)
-		val |= PCIE_DBI_RO_WR_EN;
-	else
-		val &= ~PCIE_DBI_RO_WR_EN;
-	writel(val, rk_pcie->dbi_base + PCIE_MISC_CONTROL_1_OFF);
-}
-
-/**
- * rockchip_pcie_setup_host() - Setup the PCIe controller for RC opertaion
- *
- * @rk_pcie: Pointer to the PCI controller state
- *
- * Configure the host BARs of the PCIe controller root port so that
- * PCI(e) devices may access the system memory.
- */
-static void rk_pcie_setup_host(struct rk_pcie *rk_pcie)
-{
-	u32 val;
-
-	rk_pcie_dbi_write_enable(rk_pcie, true);
-
-	/* setup RC BARs */
-	writel(PCI_BASE_ADDRESS_MEM_TYPE_64,
-	       rk_pcie->dbi_base + PCI_BASE_ADDRESS_0);
-	writel(0x0, rk_pcie->dbi_base + PCI_BASE_ADDRESS_1);
-
-	/* setup interrupt pins */
-	clrsetbits_le32(rk_pcie->dbi_base + PCI_INTERRUPT_LINE,
-			0xff00, 0x100);
-
-	/* setup bus numbers */
-	clrsetbits_le32(rk_pcie->dbi_base + PCI_PRIMARY_BUS,
-			0xffffff, 0x00ff0100);
-
-	/* setup command register */
-	clrsetbits_le32(rk_pcie->dbi_base + PCI_PRIMARY_BUS,
-			0xffff,
-			PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
-
-	/* program correct class for RC */
-	writew(PCI_CLASS_BRIDGE_PCI, rk_pcie->dbi_base + PCI_CLASS_DEVICE);
-	/* Better disable write permission right after the update */
-
-	setbits_le32(rk_pcie->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL,
-		     PORT_LOGIC_SPEED_CHANGE)
-
-	rk_pcie_dbi_write_enable(rk_pcie, false);
-}
-
 /**
  * rk_pcie_configure() - Configure link capabilities and speed
  *
@@ -311,242 +160,15 @@ static void rk_pcie_configure(struct rk_pcie *pci, u32 cap_speed)
 {
 	u32 val;
 
-	rk_pcie_dbi_write_enable(pci, true);
+	dw_pcie_dbi_write_enable(&pci->dw, true);
 
-	clrsetbits_le32(pci->dbi_base + PCIE_LINK_CAPABILITY,
+	clrsetbits_le32(pci->dw.dbi_base + PCIE_LINK_CAPABILITY,
 			TARGET_LINK_SPEED_MASK, cap_speed);
 
-	clrsetbits_le32(pci->dbi_base + PCIE_LINK_CTL_2,
+	clrsetbits_le32(pci->dw.dbi_base + PCIE_LINK_CTL_2,
 			TARGET_LINK_SPEED_MASK, cap_speed);
 
-	rk_pcie_dbi_write_enable(pci, false);
-}
-
-/**
- * rk_pcie_dw_prog_outbound_atu_unroll() - Configure ATU for outbound accesses
- *
- * @rk_pcie: Pointer to the PCI controller state
- * @index: ATU region index
- * @type: ATU accsess type
- * @cpu_addr: the physical address for the translation entry
- * @pci_addr: the pcie bus address for the translation entry
- * @size: the size of the translation entry
- *
- * Return: 0 is successful and -1 is failure
- */
-static int rk_pcie_prog_outbound_atu_unroll(struct rk_pcie *pci, int index,
-					    int type, u64 cpu_addr,
-					    u64 pci_addr, u32 size)
-{
-	u32 retries, val;
-
-	dev_dbg(pci->dev, "ATU programmed with: index: %d, type: %d, cpu addr: %8llx, pci addr: %8llx, size: %8x\n",
-		index, type, cpu_addr, pci_addr, size);
-
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
-				 lower_32_bits(cpu_addr));
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
-				 upper_32_bits(cpu_addr));
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
-				 lower_32_bits(cpu_addr + size - 1));
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
-				 lower_32_bits(pci_addr));
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
-				 upper_32_bits(pci_addr));
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type);
-	rk_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				 PCIE_ATU_ENABLE);
-
-	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = rk_pcie_readl_ob_unroll(pci, index,
-					      PCIE_ATU_UNR_REGION_CTRL2);
-		if (val & PCIE_ATU_ENABLE)
-			return 0;
-
-		udelay(LINK_WAIT_IATU_US);
-	}
-	dev_err(pci->dev, "outbound iATU is not being enabled\n");
-
-	return -1;
-}
-
-/**
- * rk_pcie_dw_addr_valid() - Check for valid bus address
- *
- * @d: The PCI device to access
- * @first_busno: Bus number of the PCIe controller root complex
- *
- * Return 1 (true) if the PCI device can be accessed by this controller.
- *
- * Return: 1 on valid, 0 on invalid
- */
-static int rk_pcie_addr_valid(pci_dev_t d, int first_busno)
-{
-	if ((PCI_BUS(d) == first_busno) && (PCI_DEV(d) > 0))
-		return 0;
-	if ((PCI_BUS(d) == first_busno + 1) && (PCI_DEV(d) > 0))
-		return 0;
-
-	return 1;
-}
-
-/**
- * set_cfg_address() - Configure the PCIe controller config space access
- *
- * @rk_pcie: Pointer to the PCI controller state
- * @d: PCI device to access
- * @where: Offset in the configuration space
- *
- * Configures the PCIe controller to access the configuration space of
- * a specific PCIe device and returns the address to use for this
- * access.
- *
- * Return: Address that can be used to access the configation space
- *         of the requested device / offset
- */
-static uintptr_t set_cfg_address(struct rk_pcie *pcie,
-				 pci_dev_t d, uint where)
-{
-	int rel_bus = PCI_BUS(d) - pcie->first_busno;
-	uintptr_t va_address;
-	u32 atu_type;
-	int ret;
-
-	/* Use dbi_base for own configuration read and write */
-	if (!rel_bus) {
-		va_address = (uintptr_t)pcie->dbi_base;
-		goto out;
-	}
-
-	if (rel_bus == 1)
-		/*
-		 * For local bus whose primary bus number is root bridge,
-		 * change TLP Type field to 4.
-		 */
-		atu_type = PCIE_ATU_TYPE_CFG0;
-	else
-		/* Otherwise, change TLP Type field to 5. */
-		atu_type = PCIE_ATU_TYPE_CFG1;
-
-	/*
-	 * Not accessing root port configuration space?
-	 * Region #0 is used for Outbound CFG space access.
-	 * Direction = Outbound
-	 * Region Index = 0
-	 */
-	d = PCI_MASK_BUS(d);
-	d = PCI_ADD_BUS(rel_bus, d);
-	ret = rk_pcie_prog_outbound_atu_unroll(pcie, PCIE_ATU_REGION_INDEX1,
-					       atu_type, (u64)pcie->cfg_base,
-					       d << 8, pcie->cfg_size);
-	if (ret)
-		return (uintptr_t)ret;
-
-	va_address = (uintptr_t)pcie->cfg_base;
-
-out:
-	va_address += where & ~0x3;
-
-	return va_address;
-}
-
-/**
- * rockchip_pcie_rd_conf() - Read from configuration space
- *
- * @bus: Pointer to the PCI bus
- * @bdf: Identifies the PCIe device to access
- * @offset: The offset into the device's configuration space
- * @valuep: A pointer at which to store the read value
- * @size: Indicates the size of access to perform
- *
- * Read a value of size @size from offset @offset within the configuration
- * space of the device identified by the bus, device & function numbers in @bdf
- * on the PCI bus @bus.
- *
- * Return: 0 on success
- */
-static int rockchip_pcie_rd_conf(const struct udevice *bus, pci_dev_t bdf,
-				 uint offset, ulong *valuep,
-				 enum pci_size_t size)
-{
-	struct rk_pcie *pcie = dev_get_priv(bus);
-	uintptr_t va_address;
-	ulong value;
-
-	debug("PCIE CFG read: bdf=%2x:%2x:%2x\n",
-	      PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
-
-	if (!rk_pcie_addr_valid(bdf, pcie->first_busno)) {
-		debug("- out of range\n");
-		*valuep = pci_get_ff(size);
-		return 0;
-	}
-
-	va_address = set_cfg_address(pcie, bdf, offset);
-
-	value = readl(va_address);
-
-	debug("(addr,val)=(0x%04x, 0x%08lx)\n", offset, value);
-	*valuep = pci_conv_32_to_size(value, offset, size);
-
-	return rk_pcie_prog_outbound_atu_unroll(pcie,
-						PCIE_ATU_REGION_INDEX1,
-						PCIE_ATU_TYPE_IO,
-						pcie->io.phys_start,
-						pcie->io.bus_start,
-						pcie->io.size);
-}
-
-/**
- * rockchip_pcie_wr_conf() - Write to configuration space
- *
- * @bus: Pointer to the PCI bus
- * @bdf: Identifies the PCIe device to access
- * @offset: The offset into the device's configuration space
- * @value: The value to write
- * @size: Indicates the size of access to perform
- *
- * Write the value @value of size @size from offset @offset within the
- * configuration space of the device identified by the bus, device & function
- * numbers in @bdf on the PCI bus @bus.
- *
- * Return: 0 on success
- */
-static int rockchip_pcie_wr_conf(struct udevice *bus, pci_dev_t bdf,
-				 uint offset, ulong value,
-				 enum pci_size_t size)
-{
-	struct rk_pcie *pcie = dev_get_priv(bus);
-	uintptr_t va_address;
-	ulong old;
-
-	debug("PCIE CFG write: (b,d,f)=(%2d,%2d,%2d)\n",
-	      PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
-	debug("(addr,val)=(0x%04x, 0x%08lx)\n", offset, value);
-
-	if (!rk_pcie_addr_valid(bdf, pcie->first_busno)) {
-		debug("- out of range\n");
-		return 0;
-	}
-
-	va_address = set_cfg_address(pcie, bdf, offset);
-
-	old = readl(va_address);
-	value = pci_conv_size_to_32(old, value, offset, size);
-	writel(value, va_address);
-
-	return rk_pcie_prog_outbound_atu_unroll(pcie,
-						PCIE_ATU_REGION_INDEX1,
-						PCIE_ATU_TYPE_IO,
-						pcie->io.phys_start,
-						pcie->io.bus_start,
-						pcie->io.size);
-
+	dw_pcie_dbi_write_enable(&pci->dw, false);
 }
 
 static void rk_pcie_enable_debug(struct rk_pcie *rk_pcie)
@@ -642,19 +264,19 @@ static int rk_pcie_link_up(struct rk_pcie *priv, u32 cap_speed)
 
 	for (retries = 0; retries < 5; retries++) {
 		if (is_link_up(priv)) {
-			dev_info(priv->dev, "PCIe Link up, LTSSM is 0x%x\n",
+			dev_info(priv->dw.dev, "PCIe Link up, LTSSM is 0x%x\n",
 				 rk_pcie_readl_apb(priv, PCIE_CLIENT_LTSSM_STATUS));
 			rk_pcie_debug_dump(priv);
 			return 0;
 		}
 
-		dev_info(priv->dev, "PCIe Linking... LTSSM is 0x%x\n",
+		dev_info(priv->dw.dev, "PCIe Linking... LTSSM is 0x%x\n",
 			 rk_pcie_readl_apb(priv, PCIE_CLIENT_LTSSM_STATUS));
 		rk_pcie_debug_dump(priv);
 		msleep(1000);
 	}
 
-	dev_err(priv->dev, "PCIe-%d Link Fail\n", dev_seq(priv->dev));
+	dev_err(priv->dw.dev, "PCIe-%d Link Fail\n", dev_seq(priv->dw.dev));
 	/* Link maybe in Gen switch recovery but we need to wait more 1s */
 	msleep(1000);
 	return -EIO;
@@ -670,7 +292,7 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 	if (priv->vpcie3v3) {
 		ret = regulator_set_value(priv->vpcie3v3, 3300000);
 		if (ret) {
-			dev_err(priv->dev, "failed to enable vpcie3v3 (ret=%d)\n",
+			dev_err(priv->dw.dev, "failed to enable vpcie3v3 (ret=%d)\n",
 				ret);
 			return ret;
 		}
@@ -709,7 +331,7 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 
 	/* Set RC mode */
 	rk_pcie_writel_apb(priv, 0x0, 0xf00040);
-	rk_pcie_setup_host(priv);
+	pcie_dw_setup_host(&priv->dw);
 
 	ret = rk_pcie_link_up(priv, LINK_SPEED_GEN_3);
 	if (ret < 0)
@@ -733,11 +355,11 @@ static int rockchip_pcie_parse_dt(struct udevice *dev)
 	struct rk_pcie *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->dbi_base = (void *)dev_read_addr_index(dev, 0);
-	if (!priv->dbi_base)
+	priv->dw.dbi_base = (void *)dev_read_addr_index(dev, 0);
+	if (!priv->dw.dbi_base)
 		return -ENODEV;
 
-	dev_dbg(dev, "DBI address is 0x%p\n", priv->dbi_base);
+	dev_dbg(dev, "DBI address is 0x%p\n", priv->dw.dbi_base);
 
 	priv->apb_base = (void *)dev_read_addr_index(dev, 1);
 	if (!priv->apb_base)
@@ -795,10 +417,10 @@ static int rockchip_pcie_probe(struct udevice *dev)
 	struct rk_pcie *priv = dev_get_priv(dev);
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
-	int reti = 0;
+	int ret = 0;
 
-	priv->first_busno = dev_seq(dev);
-	priv->dev = dev;
+	priv->dw.first_busno = dev_seq(dev);
+	priv->dw.dev = dev;
 
 	ret = rockchip_pcie_parse_dt(dev);
 	if (ret)
@@ -809,58 +431,22 @@ static int rockchip_pcie_probe(struct udevice *dev)
 		return ret;
 
 	dev_info(dev, "PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n",
-		 dev_seq(dev), rk_pcie_get_link_speed(priv),
-		 rk_pcie_get_link_width(priv),
+		 dev_seq(dev), pcie_dw_get_link_speed(&priv->dw),
+		 pcie_dw_get_link_width(&priv->dw),
 		 hose->first_busno);
 
-	for (ret = 0; ret < hose->region_count; ret++) {
-		if (hose->regions[ret].flags == PCI_REGION_IO) {
-			priv->io.phys_start = hose->regions[ret].phys_start; /* IO base */
-			priv->io.bus_start  = hose->regions[ret].bus_start;  /* IO_bus_addr */
-			priv->io.size       = hose->regions[ret].size;      /* IO size */
-		} else if (hose->regions[ret].flags == PCI_REGION_MEM) {
-			priv->mem.phys_start = hose->regions[ret].phys_start; /* MEM base */
-			priv->mem.bus_start  = hose->regions[ret].bus_start;  /* MEM_bus_addr */
-			priv->mem.size	     = hose->regions[ret].size;	    /* MEM size */
-		} else if (hose->regions[ret].flags == PCI_REGION_SYS_MEMORY) {
-			priv->cfg_base = (void *)(priv->io.phys_start - priv->io.size);
-			priv->cfg_size = priv->io.size;
-		} else {
-			dev_err(dev, "invalid flags type!\n");
-		}
-	}
-
-	dev_dbg(dev, "Config space: [0x%p - 0x%p, size 0x%llx]\n",
-		priv->cfg_base, priv->cfg_base + priv->cfg_size,
-		priv->cfg_size);
-
-	dev_dbg(dev, "IO space: [0x%llx - 0x%llx, size 0x%lx]\n",
-		priv->io.phys_start, priv->io.phys_start + priv->io.size,
-		priv->io.size);
-
-	dev_dbg(dev, "IO bus:   [0x%lx - 0x%lx, size 0x%lx]\n",
-		priv->io.bus_start, priv->io.bus_start + priv->io.size,
-		priv->io.size);
-
-	dev_dbg(dev, "MEM space: [0x%llx - 0x%llx, size 0x%lx]\n",
-		priv->mem.phys_start, priv->mem.phys_start + priv->mem.size,
-		priv->mem.size);
-
-	dev_dbg(dev, "MEM bus:   [0x%lx - 0x%lx, size 0x%lx]\n",
-		priv->mem.bus_start, priv->mem.bus_start + priv->mem.size,
-		priv->mem.size);
 
-	return rk_pcie_prog_outbound_atu_unroll(priv,
+	return pcie_dw_prog_outbound_atu_unroll(&priv->dw,
 						PCIE_ATU_REGION_INDEX0,
 						PCIE_ATU_TYPE_MEM,
-						priv->mem.phys_start,
-						priv->mem.bus_start,
-						priv->mem.size);
+						priv->dw.mem.phys_start,
+						priv->dw.mem.bus_start,
+						priv->dw.mem.size);
 }
 
 static const struct dm_pci_ops rockchip_pcie_ops = {
-	.read_config	= rockchip_pcie_rd_conf,
-	.write_config	= rockchip_pcie_wr_conf,
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
 };
 
 static const struct udevice_id rockchip_pcie_ids[] = {
-- 
2.25.1

