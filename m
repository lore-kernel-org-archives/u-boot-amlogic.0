Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.33358.1615196585201438217
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:43:05 -0800
Received: by mail-wr1-f50.google.com with SMTP id d15so10708865wrv.5
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljHGHDKFJlI6EhCR5FU/nVpwBahowd/9jFHamCuiYio=;
        b=X6LNIYNHZ5gMKMgP0ohGd1xn9B2AGgCSQdoSKxxaeqIjGk821rwCCifXiIoTSOzEm3
         7Y376glljGQHUbFubNeiUMFFfK9RYFRD6mh44Xh6ofvF2+Vz7V1Cdq9jjIJXG9lashRP
         wWkavjA2lmueKwC+ABB2B4TEsTD7b2ORLEuD+goxBSiBewBDbm3kSLH/eKp8v5ceToax
         CR+72DIURVRgj+5LpbpnyCxXgTVFjp5SF1cEPjBOX5ZhiHuKUuwj3uu+e+0K4FTdSSTo
         MB6rAY/rkcQqzcPullbin0TFaRkn4eYlNIZUN26/vdHFdewnHg78oHOEsHqFxodcOO2Z
         JC7w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: add Amlogic Meson G12A MDIO MUX driver
References: <20210224163153.2678768-1-narmstrong@baylibre.com>
 <CAGi-RUJCfFTkzPqSjsigwLzw6O+st=Z8Pub1Ae803RfrFTx=Yg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b2541c86-e70f-0b0d-ecea-fac15638f36b@baylibre.com>
Date: Mon, 8 Mar 2021 10:43:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAGi-RUJCfFTkzPqSjsigwLzw6O+st=Z8Pub1Ae803RfrFTx=Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 25/02/2021 20:34, Ramon Fried wrote:
> On Wed, Feb 24, 2021 at 6:31 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic G12A & compatible SoCs embeds a mux to either communicate with
>> the external PHY or the internal 10/100 PHY.
>>
>> This adds support for this mux as a MDIO MUX device.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/net/Kconfig               |   7 ++
>>  drivers/net/Makefile              |   1 +
>>  drivers/net/mdio_mux_meson_g12a.c | 149 ++++++++++++++++++++++++++++++
>>  3 files changed, 157 insertions(+)
>>  create mode 100644 drivers/net/mdio_mux_meson_g12a.c
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 41fa2fe566..e1d3b26687 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -797,4 +797,11 @@ config MDIO_MUX_MMIOREG
>>           This driver is used for MDIO muxes driven by writing to a register in
>>           the MMIO physical memory.
>>
>> +config MDIO_MUX_MESON_G12A
>> +       bool "MDIO MUX for Amlogic Meson G12A SoCs"
>> +       depends on DM_MDIO_MUX
>> +       help
>> +         This driver is used for the MDIO mux found on the Amlogic G12A & compatible
>> +         SoCs.
>> +
>>  endif # NETDEVICES
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index 511c87c3a5..070ae7662c 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -43,6 +43,7 @@ obj-$(CONFIG_MACB) += macb.o
>>  obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
>>  obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
>>  obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
>> +obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
>>  obj-$(CONFIG_MDIO_MUX_MMIOREG) += mdio_mux_mmioreg.o
>>  obj-$(CONFIG_MDIO_MUX_SANDBOX) += mdio_mux_sandbox.o
>>  obj-$(CONFIG_MPC8XX_FEC) += mpc8xx_fec.o
>> diff --git a/drivers/net/mdio_mux_meson_g12a.c b/drivers/net/mdio_mux_meson_g12a.c
>> new file mode 100644
>> index 0000000000..b520bf98f0
>> --- /dev/null
>> +++ b/drivers/net/mdio_mux_meson_g12a.c
>> @@ -0,0 +1,149 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * (C) Copyright 2021 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <dm.h>
>> +#include <errno.h>
>> +#include <log.h>
>> +#include <miiphy.h>
>> +#include <asm/io.h>
>> +#include <linux/bitfield.h>
>> +
>> +#define ETH_PLL_STS            0x40
>> +#define ETH_PLL_CTL0           0x44
>> +#define  PLL_CTL0_LOCK_DIG     BIT(30)
>> +#define  PLL_CTL0_RST          BIT(29)
>> +#define  PLL_CTL0_EN           BIT(28)
>> +#define  PLL_CTL0_SEL          BIT(23)
>> +#define  PLL_CTL0_N            GENMASK(14, 10)
>> +#define  PLL_CTL0_M            GENMASK(8, 0)
>> +#define  PLL_LOCK_TIMEOUT      1000000
>> +#define  PLL_MUX_NUM_PARENT    2
>> +#define ETH_PLL_CTL1           0x48
>> +#define ETH_PLL_CTL2           0x4c
>> +#define ETH_PLL_CTL3           0x50
>> +#define ETH_PLL_CTL4           0x54
>> +#define ETH_PLL_CTL5           0x58
>> +#define ETH_PLL_CTL6           0x5c
>> +#define ETH_PLL_CTL7           0x60
>> +
>> +#define ETH_PHY_CNTL0          0x80
>> +#define   EPHY_G12A_ID         0x33010180
>> +#define ETH_PHY_CNTL1          0x84
>> +#define  PHY_CNTL1_ST_MODE     GENMASK(2, 0)
>> +#define  PHY_CNTL1_ST_PHYADD   GENMASK(7, 3)
>> +#define   EPHY_DFLT_ADD                8
>> +#define  PHY_CNTL1_MII_MODE    GENMASK(15, 14)
>> +#define   EPHY_MODE_RMII       0x1
>> +#define  PHY_CNTL1_CLK_EN      BIT(16)
>> +#define  PHY_CNTL1_CLKFREQ     BIT(17)
>> +#define  PHY_CNTL1_PHY_ENB     BIT(18)
>> +#define ETH_PHY_CNTL2          0x88
>> +#define  PHY_CNTL2_USE_INTERNAL        BIT(5)
>> +#define  PHY_CNTL2_SMI_SRC_MAC BIT(6)
>> +#define  PHY_CNTL2_RX_CLK_EPHY BIT(9)
>> +
>> +#define MESON_G12A_MDIO_EXTERNAL_ID 0
>> +#define MESON_G12A_MDIO_INTERNAL_ID 1
>> +
>> +struct mdio_mux_meson_g12a_priv {
>> +       struct udevice *chip;
>> +       phys_addr_t phys;
>> +};
>> +
>> +static int meson_g12a_ephy_pll_init(struct mdio_mux_meson_g12a_priv *priv)
>> +{
>> +       /* Fire up the PHY PLL */
>> +       writel(0x29c0040a, priv->phys + ETH_PLL_CTL0);
>> +       writel(0x927e0000, priv->phys + ETH_PLL_CTL1);
>> +       writel(0xac5f49e5, priv->phys + ETH_PLL_CTL2);
>> +       writel(0x00000000, priv->phys + ETH_PLL_CTL3);
>> +       writel(0x00000000, priv->phys + ETH_PLL_CTL4);
>> +       writel(0x20200000, priv->phys + ETH_PLL_CTL5);
>> +       writel(0x0000c002, priv->phys + ETH_PLL_CTL6);
>> +       writel(0x00000023, priv->phys + ETH_PLL_CTL7);
>> +       writel(0x39c0040a, priv->phys + ETH_PLL_CTL0);
>> +       writel(0x19c0040a, priv->phys + ETH_PLL_CTL0);
>> +
>> +       return 0;
>> +}
>> +
>> +static int meson_g12a_enable_internal_mdio(struct mdio_mux_meson_g12a_priv *priv)
>> +{
>> +       /* Initialize ephy control */
>> +       writel(EPHY_G12A_ID, priv->phys + ETH_PHY_CNTL0);
>> +       writel(FIELD_PREP(PHY_CNTL1_ST_MODE, 3) |
>> +              FIELD_PREP(PHY_CNTL1_ST_PHYADD, EPHY_DFLT_ADD) |
>> +              FIELD_PREP(PHY_CNTL1_MII_MODE, EPHY_MODE_RMII) |
>> +              PHY_CNTL1_CLK_EN |
>> +              PHY_CNTL1_CLKFREQ |
>> +              PHY_CNTL1_PHY_ENB,
>> +              priv->phys + ETH_PHY_CNTL1);
>> +       writel(PHY_CNTL2_USE_INTERNAL |
>> +              PHY_CNTL2_SMI_SRC_MAC |
>> +              PHY_CNTL2_RX_CLK_EPHY,
>> +              priv->phys + ETH_PHY_CNTL2);
>> +
>> +       return 0;
>> +}
>> +
>> +static int meson_g12a_enable_external_mdio(struct mdio_mux_meson_g12a_priv *priv)
>> +{
>> +       /* Reset the mdio bus mux */
>> +       writel(0x0, priv->phys + ETH_PHY_CNTL2);
>> +
>> +       return 0;
>> +}
>> +
>> +static int mdio_mux_meson_g12a_select(struct udevice *mux, int cur, int sel)
>> +{
>> +       struct mdio_mux_meson_g12a_priv *priv = dev_get_priv(mux);
>> +
>> +       debug("%s: %x -> %x\n", __func__, (u32)cur, (u32)sel);
>> +
>> +       /* if last selection didn't change we're good to go */
>> +       if (cur == sel)
>> +               return 0;
>> +
>> +       switch (sel) {
>> +       case MESON_G12A_MDIO_EXTERNAL_ID:
>> +               return meson_g12a_enable_external_mdio(priv);
>> +       case MESON_G12A_MDIO_INTERNAL_ID:
>> +               return meson_g12a_enable_internal_mdio(priv);
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct mdio_mux_ops mdio_mux_meson_g12a_ops = {
>> +       .select = mdio_mux_meson_g12a_select,
>> +};
>> +
>> +static int mdio_mux_meson_g12a_probe(struct udevice *dev)
>> +{
>> +       struct mdio_mux_meson_g12a_priv *priv = dev_get_priv(dev);
>> +
>> +       priv->phys = dev_read_addr(dev);
>> +
>> +       meson_g12a_ephy_pll_init(priv);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct udevice_id mdio_mux_meson_g12a_ids[] = {
>> +       { .compatible = "amlogic,g12a-mdio-mux" },
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(mdio_mux_meson_g12a) = {
>> +       .name           = "mdio_mux_meson_g12a",
>> +       .id             = UCLASS_MDIO_MUX,
>> +       .of_match       = mdio_mux_meson_g12a_ids,
>> +       .probe          = mdio_mux_meson_g12a_probe,
>> +       .ops            = &mdio_mux_meson_g12a_ops,
>> +       .priv_auto      = sizeof(struct mdio_mux_meson_g12a_priv),
>> +};
>> --
>> 2.25.1
>>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> 

Thanks !

Applied to u-boot-amlogic-next
