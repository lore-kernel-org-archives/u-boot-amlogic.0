Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.33755.1615196571691556833
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:42:52 -0800
Received: by mail-wr1-f41.google.com with SMTP id b18so10699044wrn.6
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZAMmMj0iCAM0TpzUpaQx/E1HlalbeFOQIDtvkB4xnzw=;
        b=Wwq/6yve9GrnwJUNU51vN30ZrUgFBoj2XlHo4dLkN4KxRR6Uaa80nb6BBP3I8B8Gbx
         lt956NFNRqCQFF47fXbAu7m3fUBB8jADDra4+gU1NzCpIpDLOdVhorXDV7VarsK493GF
         xjmCYT+IE1WZDWG4zbDau5H2C2oyncjJRUCOf8cEB7ZPcG58jTQ7/wUIvxux/fJdohzu
         VwNcsTvsDujKf5dgeVJyhooH0pZFm7CHm4porAeLvqsMY7bs9qJypP/RPF+v3KSujvWJ
         ujCTzVME1VFXOiTTyF1mhIFX/1pDAstMfzRiKE9Df5jA7E9Dr9lzalNKLlxWOc1AL8fR
         2BKg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: designware: add Amlogic Meson8b & later glue driver
References: <20210224193356.2948805-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9eb1190b-aa6c-3ff5-424a-36005f805de8@baylibre.com>
Date: Mon, 8 Mar 2021 10:42:47 +0100
MIME-Version: 1.0
In-Reply-To: <20210224193356.2948805-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/02/2021 20:33, Neil Armstrong wrote:
> This adds a proper glue driver for the Designware DWMAC ethernet MAC IP
> found in the Amlogic Meson8, GXBB, GXL, GXM, G12A, G12B & SM1 SoCs.
> 
> This is aimed to replace the static ethernet link setup found on the board
> init code for the Amlogic SoC based boards.
> 
> Tested on a libretech-cc (S905x Internal RMII 10/100 PHY) and Khadas VIM3 (A113d
> with external 10/100/1000 RGMII PHY) to cover the most extreme setups.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/net/Kconfig         |   8 ++
>  drivers/net/Makefile        |   1 +
>  drivers/net/dwmac_meson8b.c | 150 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/net/dwmac_meson8b.c
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index e1d3b26687..cf062fad4d 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -271,6 +271,14 @@ config ETH_DESIGNWARE
>  	  100Mbit and 1 Gbit operation. You must enable CONFIG_PHYLIB to
>  	  provide the PHY (physical media interface).
>  
> +config ETH_DESIGNWARE_MESON8B
> +	bool "Amlogic Meson8b and later glue driver for Synopsys Designware Ethernet MAC"
> +	depends on DM_ETH
> +	select ETH_DESIGNWARE
> +	help
> +	  This provides glue layer to use Synopsys Designware Ethernet MAC
> +	  present on the Amlogic Meson8b, GX, AXG & G12A SoCs.
> +
>  config ETH_DESIGNWARE_SOCFPGA
>  	select REGMAP
>  	select SYSCON
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 070ae7662c..ce7b9e3478 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_CORTINA_NI_ENET) += cortina_ni.o
>  obj-$(CONFIG_CS8900) += cs8900.o
>  obj-$(CONFIG_TULIP) += dc2114x.o
>  obj-$(CONFIG_ETH_DESIGNWARE) += designware.o
> +obj-$(CONFIG_ETH_DESIGNWARE_MESON8B) += dwmac_meson8b.o
>  obj-$(CONFIG_ETH_DESIGNWARE_SOCFPGA) += dwmac_socfpga.o
>  obj-$(CONFIG_ETH_DESIGNWARE_S700) += dwmac_s700.o
>  obj-$(CONFIG_DRIVER_DM9000) += dm9000x.o
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> new file mode 100644
> index 0000000000..c0b6ef4994
> --- /dev/null
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 BayLibre, SAS
> + */
> +
> +#include <common.h>
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <phy.h>
> +#include "designware.h"
> +#include <dm/device_compat.h>
> +#include <linux/err.h>
> +
> +#define ETH_REG_0		0x0
> +#define ETH_REG_1		0x4
> +#define ETH_REG_2		0x18
> +#define ETH_REG_3		0x1c
> +
> +#define GX_ETH_REG_0_PHY_INTF		BIT(0)
> +#define GX_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
> +#define GX_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
> +#define GX_ETH_REG_0_PHY_CLK_EN	BIT(10)
> +#define GX_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
> +#define GX_ETH_REG_0_CLK_EN		BIT(12)
> +
> +#define AXG_ETH_REG_0_PHY_INTF_RGMII	BIT(0)
> +#define AXG_ETH_REG_0_PHY_INTF_RMII	BIT(2)
> +#define AXG_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
> +#define AXG_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
> +#define AXG_ETH_REG_0_PHY_CLK_EN	BIT(10)
> +#define AXG_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
> +#define AXG_ETH_REG_0_CLK_EN		BIT(12)
> +
> +struct dwmac_meson8b_plat {
> +	struct dw_eth_pdata dw_eth_pdata;
> +	int (*dwmac_setup)(struct udevice *dev, struct eth_pdata *edata);
> +	void *regs;
> +};
> +
> +static int dwmac_meson8b_of_to_plat(struct udevice *dev)
> +{
> +	struct dwmac_meson8b_plat *pdata = dev_get_plat(dev);
> +
> +	pdata->regs = (void *)dev_read_addr_index(dev, 1);
> +	if ((fdt_addr_t)pdata->regs == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	pdata->dwmac_setup = (void *)dev_get_driver_data(dev);
> +	if (!pdata->dwmac_setup)
> +		return -EINVAL;
> +
> +	return designware_eth_of_to_plat(dev);
> +}
> +
> +static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
> +{
> +	struct dwmac_meson8b_plat *plat = dev_get_plat(dev);
> +
> +	switch (edata->phy_interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		/* Set RGMII mode */
> +		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
> +						     AXG_ETH_REG_0_TX_PHASE(1) |
> +						     AXG_ETH_REG_0_TX_RATIO(4) |
> +						     AXG_ETH_REG_0_PHY_CLK_EN |
> +						     AXG_ETH_REG_0_CLK_EN);
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RMII:
> +		/* Set RMII mode */
> +		out_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RMII |
> +						 AXG_ETH_REG_0_INVERT_RMII_CLK |
> +						 AXG_ETH_REG_0_CLK_EN);
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported PHY mode\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
> +{
> +	struct dwmac_meson8b_plat *plat = dev_get_plat(dev);
> +
> +	switch (edata->phy_interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		/* Set RGMII mode */
> +		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
> +						     GX_ETH_REG_0_TX_PHASE(1) |
> +						     GX_ETH_REG_0_TX_RATIO(4) |
> +						     GX_ETH_REG_0_PHY_CLK_EN |
> +						     GX_ETH_REG_0_CLK_EN);
> +
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RMII:
> +		/* Set RMII mode */
> +		out_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
> +						 GX_ETH_REG_0_CLK_EN);
> +
> +		if (!IS_ENABLED(CONFIG_MESON_GXBB))
> +			writel(0x10110181, plat->regs + ETH_REG_2);
> +
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported PHY mode\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dwmac_meson8b_probe(struct udevice *dev)
> +{
> +	struct dwmac_meson8b_plat *pdata = dev_get_plat(dev);
> +	struct eth_pdata *edata = &pdata->dw_eth_pdata.eth_pdata;
> +	int ret;
> +
> +	ret = pdata->dwmac_setup(dev, edata);
> +	if (ret)
> +		return ret;
> +
> +	return designware_eth_probe(dev);
> +}
> +
> +static const struct udevice_id dwmac_meson8b_ids[] = {
> +	{ .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
> +	{ .compatible = "amlogic,meson-axg-dwmac", .data = (ulong)dwmac_setup_axg },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(dwmac_meson8b) = {
> +	.name		= "dwmac_meson8b",
> +	.id		= UCLASS_ETH,
> +	.of_match	= dwmac_meson8b_ids,
> +	.of_to_plat = dwmac_meson8b_of_to_plat,
> +	.probe		= dwmac_meson8b_probe,
> +	.ops		= &designware_eth_ops,
> +	.priv_auto	= sizeof(struct dw_eth_dev),
> +	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
> +	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
> +};
> 

Applied to u-boot-amlogic-next
