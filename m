Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.2470.1608569233839002582
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Dec 2020 08:47:14 -0800
Received: by mail-wm1-f54.google.com with SMTP id r4so11532374wmh.5
        for <u-boot-amlogic@groups.io>; Mon, 21 Dec 2020 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cX2DKOKCwESNqYHIITyxfXUR60c9IDf7rh7fB5uJRnw=;
        b=bt9SnwXZQ1SeoaSwi28JDS9HJpNqDfFZvAWF4VQUa+4udvoHyvemAyJJr43S5KHMfO
         J7L7EugA2YZQosa8/+thFJboIciOCnp8efup5vg3R1afwKJsNGqTFufNGsbSBtWXhXuU
         yqHqruiPjD6XJFlhTnUe0iUy2z40pcLMuLvEk=
MIME-Version: 1.0
References: <CGME20201214112450eucas1p18b98479811b98d883196c72b0f6deebd@eucas1p1.samsung.com>
 <20201214112437.18757-1-m.szyprowski@samsung.com> <20201214112437.18757-5-m.szyprowski@samsung.com>
 <CAPnjgZ30hzX4rH2-veMdCT1b3U+5ERB=GPcmR-m2Ly=kuhWmwA@mail.gmail.com> <63a2c287-4eec-67b9-694e-8eb56729c824@samsung.com>
In-Reply-To: <63a2c287-4eec-67b9-694e-8eb56729c824@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Dec 2020 09:46:59 -0700
Message-ID: <CAPnjgZ02Oeeu8AFgXz22KJdXZ53YsnKX_KY7qODd5TRE4gC7Mg@mail.gmail.com>
Subject: Re: [PATCH 4/6] button: add a simple ADC-based button driver
Content-Type: text/plain; charset="UTF-8"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On Mon, 21 Dec 2020 at 02:34, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Simon,
>
> On 19.12.2020 03:28, Simon Glass wrote:
> > On Mon, 14 Dec 2020 at 04:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> Add a simple ADC-based button driver. This driver binds to the 'adc-keys'
> >> device tree node.

I think it is best to copy it exactly as is.

Regards,
Simon


> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Change-Id: I6da7101eff3ce53766d899f49f5839d728d52fb3
> >> ---
> >>   drivers/button/Kconfig      |   8 +++
> >>   drivers/button/Makefile     |   1 +
> >>   drivers/button/button-adc.c | 117 ++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 126 insertions(+)
> >>   create mode 100644 drivers/button/button-adc.c
> >>
> >> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> >> index 6b3ec7e55de..283367f2bd3 100644
> >> --- a/drivers/button/Kconfig
> >> +++ b/drivers/button/Kconfig
> >> @@ -9,6 +9,14 @@ config BUTTON
> >>            can provide access to board-specific buttons. Use of the device tree
> >>            for configuration is encouraged.
> >>
> >> +config BUTTON_ADC
> >> +       bool "Button adc"
> >> +       depends on BUTTON
> >> +       help
> >> +         Enable support for buttons which are connected to ADC lines. The ADC
> >> +         driver must use driver model. Buttons are configured using the device
> >> +         tree.
> >> +
> >>   config BUTTON_GPIO
> >>          bool "Button gpio"
> >>          depends on BUTTON
> >> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
> >> index fcc10ebe8db..bbd18af1494 100644
> >> --- a/drivers/button/Makefile
> >> +++ b/drivers/button/Makefile
> >> @@ -3,4 +3,5 @@
> >>   # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
> >>
> >>   obj-$(CONFIG_BUTTON) += button-uclass.o
> >> +obj-$(CONFIG_BUTTON_ADC) += button-adc.o
> >>   obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
> >> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
> >> new file mode 100644
> >> index 00000000000..086c676c02a
> >> --- /dev/null
> >> +++ b/drivers/button/button-adc.c
> >> @@ -0,0 +1,117 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> >> + *             http://www.samsung.com
> >> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> >> + */
> >> +
> >> +#include <common.h>
> >> +#include <button.h>
> >> +#include <dm.h>
> >> +#include <dm/lists.h>
> >> +#include <dm/uclass-internal.h>
> >> +#include <log.h>
> >> +#include <adc.h>
> > Please check header order
> >
> > https://protect2.fireeye.com/v1/url?k=0827922c-57bcaba3-08261963-0cc47a31307c-c2add94742a708a4&q=1&e=e6ddd072-23a6-4591-9ca7-8d41aa498536&u=https%3A%2F%2Fwww.denx.de%2Fwiki%2FU-Boot%2FCodingStyle
> >
> >> +
> >> +struct button_adc_priv {
> >> +       struct udevice *adc;
> >> +       int channel;
> > comments
> >
> >> +};
> >> +
> >> +static enum button_state_t button_adc_get_state(struct udevice *dev)
> >> +{
> >> +       struct button_adc_priv *priv = dev_get_priv(dev);
> >> +       unsigned int val, mask;
> >> +       int ret;
> >> +
> >> +       ret = adc_start_channel(priv->adc, priv->channel);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = adc_channel_data(priv->adc, priv->channel, &val);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = adc_data_mask(priv->adc, &mask);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* getting state is simplified a bit */
> >> +       if (ret == 0)
> >> +               return (val < mask / 2) ? BUTTON_ON : BUTTON_OFF;
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int button_adc_probe(struct udevice *dev)
> >> +{
> >> +       struct button_uc_plat *uc_plat = dev_get_uclass_platdata(dev);
> >> +       struct button_adc_priv *priv = dev_get_priv(dev);
> >> +       struct ofnode_phandle_args args;
> >> +       int ret;
> >> +
> >> +       /* Ignore the top-level button node */
> >> +       if (!uc_plat->label)
> >> +               return 0;
> >> +
> >> +       ret = dev_read_phandle_with_args(dev->parent, "io-channels",
> >> +                                        "#io-channel-cells", 0, 0, &args);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = uclass_get_device_by_name(UCLASS_ADC, ofnode_get_name(args.node),
> >> +                                       &priv->adc);
> > How about uclass_get_device_by_ofnode() ?
> >
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       priv->channel = args.args[0];
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int button_adc_bind(struct udevice *parent)
> >> +{
> >> +       struct udevice *dev;
> >> +       ofnode node;
> >> +       int ret;
> >> +
> >> +       dev_for_each_subnode(node, parent) {
> >> +               struct button_uc_plat *uc_plat;
> >> +               const char *label;
> >> +
> >> +               label = ofnode_read_string(node, "label");
> >> +               if (!label) {
> >> +                       debug("%s: node %s has no label\n", __func__,
> >> +                             ofnode_get_name(node));
> >> +                       return -EINVAL;
> >> +               }
> >> +               ret = device_bind_driver_to_node(parent, "button_adc",
> >> +                                                ofnode_get_name(node),
> >> +                                                node, &dev);
> >> +               if (ret)
> >> +                       return ret;
> >> +               uc_plat = dev_get_uclass_platdata(dev);
> >> +               uc_plat->label = label;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct button_ops button_adc_ops = {
> >> +       .get_state      = button_adc_get_state,
> >> +};
> >> +
> >> +static const struct udevice_id button_adc_ids[] = {
> >> +       { .compatible = "adc-keys" },
> > Please add the binding file for this.
> Do you want me to copy the
> Documentation/devicetree/bindings/input/adc-keys.txt file from Linux
> kernel to doc/device-tree-bindings/input or should I modify it somehow?
> (drop all the ignored properties?)
> >> +       { }
> >> +};
> >> +
> >> +U_BOOT_DRIVER(button_adc) = {
> >> +       .name           = "button_adc",
> >> +       .id             = UCLASS_BUTTON,
> >> +       .of_match       = button_adc_ids,
> >> +       .ops            = &button_adc_ops,
> >> +       .priv_auto_alloc_size = sizeof(struct button_adc_priv),
> >> +       .bind           = button_adc_bind,
> >> +       .probe          = button_adc_probe,
> >> +};
> >> --
> >> 2.17.1
> >>
> > Regards,
> > Simon
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
