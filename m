Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.7781.1609212721123286726
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Dec 2020 19:32:01 -0800
Received: by mail-wm1-f51.google.com with SMTP id g185so1029939wmf.3
        for <u-boot-amlogic@groups.io>; Mon, 28 Dec 2020 19:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEPROCsbhKxTJHo4IzvXCG9mcNDwvPe/onjVj0C6elc=;
        b=FgOnlg615pvvqJsTq1tIFOYvRQyyuAO34pZTDzQU6NFYMR+F3D8hOpF/D5qaXkugiK
         PF5kA47jctE5FvfJAPRRLrUMQWWXHFUUXSaaD364KcDx4BSvSXhEKrqLJzjreWdXi9XY
         FjPPgN7wjT4nTd4ZoQ53JAR25H2nDQ3hdZ71M=
MIME-Version: 1.0
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
 <CGME20201222085639eucas1p1db16b6bc2ae790ed711a09bcc5f176e5@eucas1p1.samsung.com>
 <20201222085633.10194-3-m.szyprowski@samsung.com> <56836417-aa29-0e0c-5ba2-539a0fb860c5@gmx.de>
In-Reply-To: <56836417-aa29-0e0c-5ba2-539a0fb860c5@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Dec 2020 20:31:47 -0700
Message-ID: <CAPnjgZ1_gf9K3CJeGT-qH-AeJYqfeTPDd8chDmmtGyT_xCCAcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] button: add a simple Analog to Digital Converter device based button driver
Content-Type: text/plain; charset="UTF-8"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 22 Dec 2020 at 02:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/22/20 9:56 AM, Marek Szyprowski wrote:
> > Add a simple Analog to Digital Converter device based button driver. This
> > driver binds to the 'adc-keys' device tree node.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   drivers/button/Kconfig      |   8 +++
> >   drivers/button/Makefile     |   1 +
> >   drivers/button/button-adc.c | 121 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 130 insertions(+)
> >   create mode 100644 drivers/button/button-adc.c
> >
> > diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> > index 6b3ec7e55d..6db3c5e93a 100644
> > --- a/drivers/button/Kconfig
> > +++ b/drivers/button/Kconfig
> > @@ -9,6 +9,14 @@ config BUTTON
> >         can provide access to board-specific buttons. Use of the device tree
> >         for configuration is encouraged.
> >
> > +config BUTTON_ADC
> > +     bool "Button adc"
> > +     depends on BUTTON
> > +     help
> > +       Enable support for buttons which are connected to Analog to Digital
> > +       Converter device. The ADC driver must use driver model. Buttons are
> > +       configured using the device tree.
> > +
> >   config BUTTON_GPIO
> >       bool "Button gpio"
> >       depends on BUTTON
> > diff --git a/drivers/button/Makefile b/drivers/button/Makefile
> > index fcc10ebe8d..bbd18af149 100644
> > --- a/drivers/button/Makefile
> > +++ b/drivers/button/Makefile
> > @@ -3,4 +3,5 @@
> >   # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
> >
> >   obj-$(CONFIG_BUTTON) += button-uclass.o
> > +obj-$(CONFIG_BUTTON_ADC) += button-adc.o
> >   obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
> > diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
> > new file mode 100644
> > index 0000000000..bf99dd8b43
> > --- /dev/null
> > +++ b/drivers/button/button-adc.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> > + *           http://www.samsung.com
> > + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> > + */
> > +
> > +#include <common.h>
> > +#include <adc.h>
> > +#include <button.h>
> > +#include <dm.h>
> > +#include <dm/lists.h>
> > +#include <dm/uclass-internal.h>
> > +
> > +/**
> > + * struct button_adc_priv - private data for button-adc driver.
> > + *
> > + * @adc: Analog to Digital Converter device to which button is connected.
> > + * @channel: channel of the ADC device to probe the button state.
> > + */
> > +struct button_adc_priv {
> > +     struct udevice *adc;
> > +     int channel;
> > +};
> > +
> > +static enum button_state_t button_adc_get_state(struct udevice *dev)
> > +{
> > +     struct button_adc_priv *priv = dev_get_priv(dev);
> > +     unsigned int val, mask;
> > +     int ret;
> > +
> > +     ret = adc_start_channel(priv->adc, priv->channel);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = adc_channel_data(priv->adc, priv->channel, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = adc_data_mask(priv->adc, &mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* getting state is simplified a bit */
> > +     if (ret == 0)
> > +             return (val < mask / 2) ? BUTTON_ON : BUTTON_OFF;
> > +
> > +     return ret;
> > +}
> > +
> > +static int button_adc_probe(struct udevice *dev)
> > +{
> > +     struct button_uc_plat *uc_plat = dev_get_uclass_platdata(dev);
> > +     struct button_adc_priv *priv = dev_get_priv(dev);
> > +     struct ofnode_phandle_args args;
> > +     int ret;
> > +
> > +     /* Ignore the top-level button node */
> > +     if (!uc_plat->label)
> > +             return 0;
> > +
> > +     ret = dev_read_phandle_with_args(dev->parent, "io-channels",
> > +                                      "#io-channel-cells", 0, 0, &args);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = uclass_get_device_by_ofnode(UCLASS_ADC, args.node, &priv->adc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->channel = args.args[0];
> > +
> > +     return ret;
> > +}
> > +
> > +static int button_adc_bind(struct udevice *parent)
> > +{
> > +     struct udevice *dev;
> > +     ofnode node;
> > +     int ret;
> > +
> > +     dev_for_each_subnode(node, parent) {
> > +             struct button_uc_plat *uc_plat;
> > +             const char *label;
> > +
> > +             label = ofnode_read_string(node, "label");
> > +             if (!label) {
> > +                     debug("%s: node %s has no label\n", __func__,
> > +                           ofnode_get_name(node));
> > +                     return -EINVAL;
> > +             }
> > +             ret = device_bind_driver_to_node(parent, "button_adc",
> > +                                              ofnode_get_name(node),
> > +                                              node, &dev);
>
> This code does not match the binding. The binding defines a voltage
> ladder where you have multiple voltage ranges and multiple buttons.
>
> You need to consider the threshold voltages.
>
> Have a look at Linux' drivers/input/keyboard/adc-keys.c. Beware that
> code is also incorrect as the author ignores the meaning of "threshold"
> and uses it it as closest voltage.

Apart from that, from a DM point of view, this looks good.

Regards,
Simon
