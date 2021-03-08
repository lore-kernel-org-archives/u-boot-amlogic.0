Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.33359.1615196591758251151
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:43:12 -0800
Received: by mail-wr1-f48.google.com with SMTP id b18so10700164wrn.6
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xr/0yPbz/esfw37JxYp6ebjI0lkVlAmLBF5h6l90I8Q=;
        b=as0WIl2diVwyGNeW0TC2nit0wkLxWpbwUL4r7EkRGUSTdHSno1BYooHlmV2YplQFLs
         Jvt+jOf7i+dDVwgSiqTyeezhJ3JUfsLzPXBJqqqb8UgtJMxb8SKLwjNJZu69tU4WCutM
         08pTSRjMFhnzlNhPX+z5q0/d6SW0VsqGEtbbYg7RdCG8lGkg6SVsRvtbA9f6q5QukzjB
         LyiiuN9yNrRqBZUOqGRUmISpgrIDjZbLyQZhTdsg5J6J5yFlFG+irHACyiQFYUwJDin2
         sSALt03vjv8J3cfFj+r26JVfs/zgFEf+wNL/J0jk5gvSMTwTAl8lUxD3sy+ZL31E1QtA
         tRMA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: designware: add DM_MDIO support
References: <20210224140239.2617642-1-narmstrong@baylibre.com>
 <CAGi-RULpnr=Sd0vDhfdTf5GuHibOh321q6CX2wojtnVtP0M44w@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e315ab3c-a290-79b5-259d-392fdcfa5c50@baylibre.com>
Date: Mon, 8 Mar 2021 10:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAGi-RULpnr=Sd0vDhfdTf5GuHibOh321q6CX2wojtnVtP0M44w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 25/02/2021 20:34, Ramon Fried wrote:
> On Wed, Feb 24, 2021 at 4:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add support for DM_MDIO to connect to PHY and expose a MDIO device for the
>> internal MDIO bus in order to dynamically connect to MDIO PHYs with DT
>> with eventual MDIO muxes in between.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/net/designware.c | 93 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
>> index 9dba55adaa..acf3a82828 100644
>> --- a/drivers/net/designware.c
>> +++ b/drivers/net/designware.c
>> @@ -21,7 +21,9 @@
>>  #include <reset.h>
>>  #include <asm/cache.h>
>>  #include <dm/device_compat.h>
>> +#include <dm/device-internal.h>
>>  #include <dm/devres.h>
>> +#include <dm/lists.h>
>>  #include <linux/compiler.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>> @@ -122,6 +124,55 @@ static int dw_mdio_reset(struct mii_dev *bus)
>>  }
>>  #endif
>>
>> +#if IS_ENABLED(CONFIG_DM_MDIO)
>> +int designware_eth_mdio_read(struct udevice *mdio_dev, int addr, int devad, int reg)
>> +{
>> +       struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
>> +
>> +       return dw_mdio_read(pdata->mii_bus, addr, devad, reg);
>> +}
>> +
>> +int designware_eth_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg, u16 val)
>> +{
>> +       struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
>> +
>> +       return dw_mdio_write(pdata->mii_bus, addr, devad, reg, val);
>> +}
>> +
>> +#if CONFIG_IS_ENABLED(DM_GPIO)
>> +int designware_eth_mdio_reset(struct udevice *mdio_dev)
>> +{
>> +       struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
>> +
>> +       return dw_mdio_reset(pdata->mii_bus);
>> +}
>> +#endif
>> +
>> +static const struct mdio_ops designware_eth_mdio_ops = {
>> +       .read = designware_eth_mdio_read,
>> +       .write = designware_eth_mdio_write,
>> +#if CONFIG_IS_ENABLED(DM_GPIO)
>> +       .reset = designware_eth_mdio_reset,
>> +#endif
>> +};
>> +
>> +static int designware_eth_mdio_probe(struct udevice *dev)
>> +{
>> +       /* Use the priv data of parent */
>> +       dev_set_priv(dev, dev_get_priv(dev->parent));
>> +
>> +       return 0;
>> +}
>> +
>> +U_BOOT_DRIVER(designware_eth_mdio) = {
>> +       .name = "eth_designware_mdio",
>> +       .id = UCLASS_MDIO,
>> +       .probe = designware_eth_mdio_probe,
>> +       .ops = &designware_eth_mdio_ops,
>> +       .plat_auto = sizeof(struct mdio_perdev_priv),
>> +};
>> +#endif
>> +
>>  static int dw_mdio_init(const char *name, void *priv)
>>  {
>>         struct mii_dev *bus = mdio_alloc();
>> @@ -143,6 +194,34 @@ static int dw_mdio_init(const char *name, void *priv)
>>         return mdio_register(bus);
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DM_MDIO)
>> +static int dw_dm_mdio_init(const char *name, void *priv)
>> +{
>> +       struct udevice *dev = priv;
>> +       ofnode node;
>> +       int ret;
>> +
>> +       ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>> +               const char *subnode_name = ofnode_get_name(node);
>> +               struct udevice *mdiodev;
>> +
>> +               if (strcmp(subnode_name, "mdio"))
>> +                       continue;
>> +
>> +               ret = device_bind_driver_to_node(dev, "eth_designware_mdio",
>> +                                                subnode_name, node, &mdiodev);
>> +               if (ret)
>> +                       debug("%s: not able to bind mdio device node\n", __func__);
>> +
>> +               return 0;
>> +       }
>> +
>> +       printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
>> +
>> +       return dw_mdio_init(name, priv);
>> +}
>> +#endif
>> +
>>  static void tx_descs_init(struct dw_eth_dev *priv)
>>  {
>>         struct eth_dma_regs *dma_p = priv->dma_regs_p;
>> @@ -487,7 +566,14 @@ static int _dw_free_pkt(struct dw_eth_dev *priv)
>>  static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
>>  {
>>         struct phy_device *phydev;
>> -       int phy_addr = -1, ret;
>> +       int ret;
>> +
>> +#if IS_ENABLED(CONFIG_DM_MDIO) && IS_ENABLED(CONFIG_DM_ETH)
>> +       phydev = dm_eth_phy_connect(dev);
>> +       if (!phydev)
>> +               return -ENODEV;
>> +#else
>> +       int phy_addr = -1;
>>
>>  #ifdef CONFIG_PHY_ADDR
>>         phy_addr = CONFIG_PHY_ADDR;
>> @@ -496,6 +582,7 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
>>         phydev = phy_connect(priv->bus, phy_addr, dev, priv->interface);
>>         if (!phydev)
>>                 return -ENODEV;
>> +#endif
>>
>>         phydev->supported &= PHY_GBIT_FEATURES;
>>         if (priv->max_speed) {
>> @@ -759,7 +846,11 @@ int designware_eth_probe(struct udevice *dev)
>>         priv->interface = pdata->phy_interface;
>>         priv->max_speed = pdata->max_speed;
>>
>> +#if IS_ENABLED(CONFIG_DM_MDIO)
>> +       ret = dw_dm_mdio_init(dev->name, dev);
>> +#else
>>         ret = dw_mdio_init(dev->name, dev);
>> +#endif
>>         if (ret) {
>>                 err = ret;
>>                 goto mdio_err;
>> --
>> 2.25.1
>>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> 

Thanks !

Applied to u-boot-amlogic-next
