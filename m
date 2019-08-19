Received: by mail-wm1-f67.google.com with SMTP id e8so2000872wme.1
        for <u-boot-amlogic@groups.io>; Mon, 19 Aug 2019 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gUrsfRhvYQIs5qvk1N4y+q+IMr1561kYEc2E9Cx6WKw=;
        b=xbCKMoZyK+tXEGX0iSumesQSdUvFMcaIGKZGuNNkb5dt2rka673SgwgymR6J0PCRBm
         7Qkvfcy8A+AgxfLjij6VXiRkKyKa6HXJAyHiAYpx/i9kPReDqMsg7wPJS5h5kenjglul
         1tBG4DbOyZAW8LuLd07q/F+dTDLt1b4fcmvIc7qdN8AEH1g7K8Eiu5t/QiTDLlWYWfh1
         HrXAxw8nS3yWB7iOrjKTqrEpSZHPW27Qk9MoJJ/dA5UWnsTeiv6QhpH1ZSC/njOsz/85
         4J0u8eXU1iGJAT2gvjCJQW+wqdXPi5Vm8eObHdyXL7q2H+B0CUIfOQkpcbogM2LRpVHw
         KZBA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] phy: meson: add GXBB PHY driver
References: <20190818134255.7135-1-b.galvani@gmail.com>
 <20190818134255.7135-2-b.galvani@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c7379ff4-b8a8-c385-f1d8-180e0657504f@baylibre.com>
Date: Mon, 19 Aug 2019 09:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190818134255.7135-2-b.galvani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 18/08/2019 15:42, Beniamino Galvani wrote:
> This adds support for the USB PHY found on Amlogic GXBB SoCs.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/phy/Kconfig           |   8 ++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/meson-gxbb-usb2.c | 235 ++++++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 drivers/phy/meson-gxbb-usb2.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 3942f035eb..2190f6f970 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -154,6 +154,14 @@ config PHY_STM32_USBPHYC
>  	  between an HS USB OTG controller and an HS USB Host controller,
>  	  selected by an USB switch.
>  
> +config MESON_GXBB_USB_PHY
> +	bool "Amlogic Meson GXBB USB PHY"
> +	depends on PHY && ARCH_MESON && MESON_GXBB
> +	imply REGMAP
> +	help
> +	  This is the generic phy driver for the Amlogic Meson GXBB
> +	  USB2 PHY.
> +
>  config MESON_GXL_USB_PHY
>  	bool "Amlogic Meson GXL USB PHYs"
>  	depends on PHY && ARCH_MESON && (MESON_GXL || MESON_GXM)
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 3157f1b7ee..dde3b0ecef 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_STI_USB_PHY) += sti_usb_phy.o
>  obj-$(CONFIG_PHY_RCAR_GEN2) += phy-rcar-gen2.o
>  obj-$(CONFIG_PHY_RCAR_GEN3) += phy-rcar-gen3.o
>  obj-$(CONFIG_PHY_STM32_USBPHYC) += phy-stm32-usbphyc.o
> +obj-$(CONFIG_MESON_GXBB_USB_PHY) += meson-gxbb-usb2.o
>  obj-$(CONFIG_MESON_GXL_USB_PHY) += meson-gxl-usb2.o meson-gxl-usb3.o
>  obj-$(CONFIG_MESON_G12A_USB_PHY) += meson-g12a-usb2.o meson-g12a-usb3-pcie.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
> diff --git a/drivers/phy/meson-gxbb-usb2.c b/drivers/phy/meson-gxbb-usb2.c
> new file mode 100644
> index 0000000000..88c2ec69b2
> --- /dev/null
> +++ b/drivers/phy/meson-gxbb-usb2.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Meson8, Meson8b and GXBB USB2 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2018 BayLibre, SAS
> + *
> + * Author: Beniamino Galvani <b.galvani@gmail.com>
> + */
> +
> +#include <common.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <power/regulator.h>
> +#include <regmap.h>
> +#include <reset.h>
> +
> +#define REG_CONFIG					0x00
> +	#define REG_CONFIG_CLK_EN			BIT(0)
> +	#define REG_CONFIG_CLK_SEL_MASK			GENMASK(3, 1)
> +	#define REG_CONFIG_CLK_DIV_MASK			GENMASK(10, 4)
> +	#define REG_CONFIG_CLK_32k_ALTSEL		BIT(15)
> +	#define REG_CONFIG_TEST_TRIG			BIT(31)
> +
> +#define REG_CTRL					0x04
> +	#define REG_CTRL_SOFT_PRST			BIT(0)
> +	#define REG_CTRL_SOFT_HRESET			BIT(1)
> +	#define REG_CTRL_SS_SCALEDOWN_MODE_MASK		GENMASK(3, 2)
> +	#define REG_CTRL_CLK_DET_RST			BIT(4)
> +	#define REG_CTRL_INTR_SEL			BIT(5)
> +	#define REG_CTRL_CLK_DETECTED			BIT(8)
> +	#define REG_CTRL_SOF_SENT_RCVD_TGL		BIT(9)
> +	#define REG_CTRL_SOF_TOGGLE_OUT			BIT(10)
> +	#define REG_CTRL_POWER_ON_RESET			BIT(15)
> +	#define REG_CTRL_SLEEPM				BIT(16)
> +	#define REG_CTRL_TX_BITSTUFF_ENN_H		BIT(17)
> +	#define REG_CTRL_TX_BITSTUFF_ENN		BIT(18)
> +	#define REG_CTRL_COMMON_ON			BIT(19)
> +	#define REG_CTRL_REF_CLK_SEL_MASK		GENMASK(21, 20)
> +	#define REG_CTRL_REF_CLK_SEL_SHIFT		20
> +	#define REG_CTRL_FSEL_MASK			GENMASK(24, 22)
> +	#define REG_CTRL_FSEL_SHIFT			22
> +	#define REG_CTRL_PORT_RESET			BIT(25)
> +	#define REG_CTRL_THREAD_ID_MASK			GENMASK(31, 26)
> +
> +/* bits [31:26], [24:21] and [15:3] seem to be read-only */
> +#define REG_ADP_BC					0x0c
> +	#define REG_ADP_BC_VBUS_VLD_EXT_SEL		BIT(0)
> +	#define REG_ADP_BC_VBUS_VLD_EXT			BIT(1)
> +	#define REG_ADP_BC_OTG_DISABLE			BIT(2)
> +	#define REG_ADP_BC_ID_PULLUP			BIT(3)
> +	#define REG_ADP_BC_DRV_VBUS			BIT(4)
> +	#define REG_ADP_BC_ADP_PRB_EN			BIT(5)
> +	#define REG_ADP_BC_ADP_DISCHARGE		BIT(6)
> +	#define REG_ADP_BC_ADP_CHARGE			BIT(7)
> +	#define REG_ADP_BC_SESS_END			BIT(8)
> +	#define REG_ADP_BC_DEVICE_SESS_VLD		BIT(9)
> +	#define REG_ADP_BC_B_VALID			BIT(10)
> +	#define REG_ADP_BC_A_VALID			BIT(11)
> +	#define REG_ADP_BC_ID_DIG			BIT(12)
> +	#define REG_ADP_BC_VBUS_VALID			BIT(13)
> +	#define REG_ADP_BC_ADP_PROBE			BIT(14)
> +	#define REG_ADP_BC_ADP_SENSE			BIT(15)
> +	#define REG_ADP_BC_ACA_ENABLE			BIT(16)
> +	#define REG_ADP_BC_DCD_ENABLE			BIT(17)
> +	#define REG_ADP_BC_VDAT_DET_EN_B		BIT(18)
> +	#define REG_ADP_BC_VDAT_SRC_EN_B		BIT(19)
> +	#define REG_ADP_BC_CHARGE_SEL			BIT(20)
> +	#define REG_ADP_BC_CHARGE_DETECT		BIT(21)
> +	#define REG_ADP_BC_ACA_PIN_RANGE_C		BIT(22)
> +	#define REG_ADP_BC_ACA_PIN_RANGE_B		BIT(23)
> +	#define REG_ADP_BC_ACA_PIN_RANGE_A		BIT(24)
> +	#define REG_ADP_BC_ACA_PIN_GND			BIT(25)
> +	#define REG_ADP_BC_ACA_PIN_FLOAT		BIT(26)
> +
> +#define RESET_COMPLETE_TIME				500
> +#define ACA_ENABLE_COMPLETE_TIME			50
> +
> +struct phy_meson_gxbb_usb2_priv {
> +	struct regmap *regmap;
> +	struct reset_ctl_bulk resets;
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	struct udevice *phy_supply;
> +#endif
> +};
> +
> +static int phy_meson_gxbb_usb2_power_on(struct phy *phy)
> +{
> +	struct udevice *dev = phy->dev;
> +	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
> +	uint val;
> +
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	if (priv->phy_supply) {
> +		int ret = regulator_set_enable(priv->phy_supply, true);
> +
> +		if (ret)
> +			return ret;
> +	}
> +#endif
> +
> +	regmap_update_bits(priv->regmap, REG_CONFIG,
> +			   REG_CONFIG_CLK_32k_ALTSEL,
> +			   REG_CONFIG_CLK_32k_ALTSEL);
> +	regmap_update_bits(priv->regmap, REG_CTRL,
> +			   REG_CTRL_REF_CLK_SEL_MASK,
> +			   0x2 << REG_CTRL_REF_CLK_SEL_SHIFT);
> +	regmap_update_bits(priv->regmap, REG_CTRL,
> +			   REG_CTRL_FSEL_MASK,
> +			   0x5 << REG_CTRL_FSEL_SHIFT);
> +
> +	/* reset the PHY */
> +	regmap_update_bits(priv->regmap, REG_CTRL,
> +			   REG_CTRL_POWER_ON_RESET,
> +			   REG_CTRL_POWER_ON_RESET);
> +	udelay(RESET_COMPLETE_TIME);
> +	regmap_update_bits(priv->regmap, REG_CTRL,
> +			   REG_CTRL_POWER_ON_RESET,
> +			   0);
> +	udelay(RESET_COMPLETE_TIME);
> +
> +	regmap_update_bits(priv->regmap, REG_CTRL,
> +			   REG_CTRL_SOF_TOGGLE_OUT,
> +			   REG_CTRL_SOF_TOGGLE_OUT);
> +
> +	/* Set host mode */
> +	regmap_update_bits(priv->regmap, REG_ADP_BC,
> +			   REG_ADP_BC_ACA_ENABLE,
> +			   REG_ADP_BC_ACA_ENABLE);
> +	udelay(ACA_ENABLE_COMPLETE_TIME);
> +
> +	regmap_read(priv->regmap, REG_ADP_BC, &val);
> +	if (val & REG_ADP_BC_ACA_PIN_FLOAT) {
> +		pr_err("Error powering on GXBB USB PHY\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxbb_usb2_power_off(struct phy *phy)
> +{
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	struct udevice *dev = phy->dev;
> +	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
> +
> +	if (priv->phy_supply) {
> +		int ret = regulator_set_enable(priv->phy_supply, false);
> +
> +		if (ret)
> +			return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static struct phy_ops meson_gxbb_usb2_phy_ops = {
> +	.power_on = phy_meson_gxbb_usb2_power_on,
> +	.power_off = phy_meson_gxbb_usb2_power_off,
> +};
> +
> +static int meson_gxbb_usb2_phy_probe(struct udevice *dev)
> +{
> +	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
> +	struct clk clk_usb_general, clk_usb;
> +	int ret;
> +
> +	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_get_by_name(dev, "usb_general", &clk_usb_general);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&clk_usb_general);
> +	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> +		pr_err("Failed to enable PHY general clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_get_by_name(dev, "usb", &clk_usb);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&clk_usb);
> +	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> +		pr_err("Failed to enable PHY clock\n");
> +		return ret;
> +	}
> +
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	ret = device_get_supply_regulator(dev, "phy-supply", &priv->phy_supply);
> +	if (ret && ret != -ENOENT) {
> +		pr_err("Failed to get PHY regulator\n");
> +		return ret;
> +	}
> +#endif
> +	ret = reset_get_bulk(dev, &priv->resets);
> +	if (!ret) {
> +		ret = reset_deassert_bulk(&priv->resets);
> +		if (ret) {
> +			pr_err("Failed to deassert reset\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int meson_gxbb_usb2_phy_remove(struct udevice *dev)
> +{
> +	struct phy_meson_gxbb_usb2_priv *priv = dev_get_priv(dev);
> +
> +	return reset_release_bulk(&priv->resets);
> +}
> +
> +static const struct udevice_id meson_gxbb_usb2_phy_ids[] = {
> +	{ .compatible = "amlogic,meson8-usb2-phy" },
> +	{ .compatible = "amlogic,meson8b-usb2-phy" },
> +	{ .compatible = "amlogic,meson-gxbb-usb2-phy" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(meson_gxbb_usb2_phy) = {
> +	.name = "meson_gxbb_usb2_phy",
> +	.id = UCLASS_PHY,
> +	.of_match = meson_gxbb_usb2_phy_ids,
> +	.probe = meson_gxbb_usb2_phy_probe,
> +	.remove = meson_gxbb_usb2_phy_remove,
> +	.ops = &meson_gxbb_usb2_phy_ops,
> +	.priv_auto_alloc_size = sizeof(struct phy_meson_gxbb_usb2_priv),
> +};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
