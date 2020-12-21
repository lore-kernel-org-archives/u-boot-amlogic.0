Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.37445.1608543255602647334
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Dec 2020 01:34:16 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201221093358euoutp02fe3891dbf7d0e3763ec428e525e5513e~SsY17c6l02583725837euoutp02s
	for <u-boot-amlogic@groups.io>; Mon, 21 Dec 2020 09:33:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201221093358euoutp02fe3891dbf7d0e3763ec428e525e5513e~SsY17c6l02583725837euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608543238;
	bh=sWK7yNQq3AV5n8eVShigcKJ+gppSIkPcN1XYj69OQ2Q=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=vP9vugDuaoxPmB5ojEnddY7fBCER+I33w8gS1Z0hqsKVK6mZb74COQ9xbyUbs7yF+
	 sqoPrrgvuMfmDXFPuInqQeJWKaeQPrbpDzj0RoxWO9uPtA8TxbHAH5+Z0BjTW6ySx+
	 rpQDykifDu5WMLxAZA9s6/qN5U6zbUdSFoYRNitY=
Subject: Re: [PATCH 4/6] button: add a simple ADC-based button driver
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <63a2c287-4eec-67b9-694e-8eb56729c824@samsung.com>
Date: Mon, 21 Dec 2020 10:33:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ30hzX4rH2-veMdCT1b3U+5ERB=GPcmR-m2Ly=kuhWmwA@mail.gmail.com>
References: <CGME20201214112450eucas1p18b98479811b98d883196c72b0f6deebd@eucas1p1.samsung.com>
	<20201214112437.18757-1-m.szyprowski@samsung.com>
	<20201214112437.18757-5-m.szyprowski@samsung.com>
	<CAPnjgZ30hzX4rH2-veMdCT1b3U+5ERB=GPcmR-m2Ly=kuhWmwA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Simon,

On 19.12.2020 03:28, Simon Glass wrote:
> On Mon, 14 Dec 2020 at 04:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Add a simple ADC-based button driver. This driver binds to the 'adc-keys'
>> device tree node.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Change-Id: I6da7101eff3ce53766d899f49f5839d728d52fb3
>> ---
>>   drivers/button/Kconfig      |   8 +++
>>   drivers/button/Makefile     |   1 +
>>   drivers/button/button-adc.c | 117 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>   create mode 100644 drivers/button/button-adc.c
>>
>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>> index 6b3ec7e55de..283367f2bd3 100644
>> --- a/drivers/button/Kconfig
>> +++ b/drivers/button/Kconfig
>> @@ -9,6 +9,14 @@ config BUTTON
>>            can provide access to board-specific buttons. Use of the device tree
>>            for configuration is encouraged.
>>
>> +config BUTTON_ADC
>> +       bool "Button adc"
>> +       depends on BUTTON
>> +       help
>> +         Enable support for buttons which are connected to ADC lines. The ADC
>> +         driver must use driver model. Buttons are configured using the device
>> +         tree.
>> +
>>   config BUTTON_GPIO
>>          bool "Button gpio"
>>          depends on BUTTON
>> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
>> index fcc10ebe8db..bbd18af1494 100644
>> --- a/drivers/button/Makefile
>> +++ b/drivers/button/Makefile
>> @@ -3,4 +3,5 @@
>>   # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
>>
>>   obj-$(CONFIG_BUTTON) += button-uclass.o
>> +obj-$(CONFIG_BUTTON_ADC) += button-adc.o
>>   obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
>> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
>> new file mode 100644
>> index 00000000000..086c676c02a
>> --- /dev/null
>> +++ b/drivers/button/button-adc.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
>> + *             http://www.samsung.com
>> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> + */
>> +
>> +#include <common.h>
>> +#include <button.h>
>> +#include <dm.h>
>> +#include <dm/lists.h>
>> +#include <dm/uclass-internal.h>
>> +#include <log.h>
>> +#include <adc.h>
> Please check header order
>
> https://protect2.fireeye.com/v1/url?k=0827922c-57bcaba3-08261963-0cc47a31307c-c2add94742a708a4&q=1&e=e6ddd072-23a6-4591-9ca7-8d41aa498536&u=https%3A%2F%2Fwww.denx.de%2Fwiki%2FU-Boot%2FCodingStyle
>
>> +
>> +struct button_adc_priv {
>> +       struct udevice *adc;
>> +       int channel;
> comments
>
>> +};
>> +
>> +static enum button_state_t button_adc_get_state(struct udevice *dev)
>> +{
>> +       struct button_adc_priv *priv = dev_get_priv(dev);
>> +       unsigned int val, mask;
>> +       int ret;
>> +
>> +       ret = adc_start_channel(priv->adc, priv->channel);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = adc_channel_data(priv->adc, priv->channel, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = adc_data_mask(priv->adc, &mask);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* getting state is simplified a bit */
>> +       if (ret == 0)
>> +               return (val < mask / 2) ? BUTTON_ON : BUTTON_OFF;
>> +
>> +       return ret;
>> +}
>> +
>> +static int button_adc_probe(struct udevice *dev)
>> +{
>> +       struct button_uc_plat *uc_plat = dev_get_uclass_platdata(dev);
>> +       struct button_adc_priv *priv = dev_get_priv(dev);
>> +       struct ofnode_phandle_args args;
>> +       int ret;
>> +
>> +       /* Ignore the top-level button node */
>> +       if (!uc_plat->label)
>> +               return 0;
>> +
>> +       ret = dev_read_phandle_with_args(dev->parent, "io-channels",
>> +                                        "#io-channel-cells", 0, 0, &args);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = uclass_get_device_by_name(UCLASS_ADC, ofnode_get_name(args.node),
>> +                                       &priv->adc);
> How about uclass_get_device_by_ofnode() ?
>
>> +       if (ret)
>> +               return ret;
>> +
>> +       priv->channel = args.args[0];
>> +
>> +       return ret;
>> +}
>> +
>> +static int button_adc_bind(struct udevice *parent)
>> +{
>> +       struct udevice *dev;
>> +       ofnode node;
>> +       int ret;
>> +
>> +       dev_for_each_subnode(node, parent) {
>> +               struct button_uc_plat *uc_plat;
>> +               const char *label;
>> +
>> +               label = ofnode_read_string(node, "label");
>> +               if (!label) {
>> +                       debug("%s: node %s has no label\n", __func__,
>> +                             ofnode_get_name(node));
>> +                       return -EINVAL;
>> +               }
>> +               ret = device_bind_driver_to_node(parent, "button_adc",
>> +                                                ofnode_get_name(node),
>> +                                                node, &dev);
>> +               if (ret)
>> +                       return ret;
>> +               uc_plat = dev_get_uclass_platdata(dev);
>> +               uc_plat->label = label;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct button_ops button_adc_ops = {
>> +       .get_state      = button_adc_get_state,
>> +};
>> +
>> +static const struct udevice_id button_adc_ids[] = {
>> +       { .compatible = "adc-keys" },
> Please add the binding file for this.
Do you want me to copy the 
Documentation/devicetree/bindings/input/adc-keys.txt file from Linux 
kernel to doc/device-tree-bindings/input or should I modify it somehow? 
(drop all the ignored properties?)
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(button_adc) = {
>> +       .name           = "button_adc",
>> +       .id             = UCLASS_BUTTON,
>> +       .of_match       = button_adc_ids,
>> +       .ops            = &button_adc_ops,
>> +       .priv_auto_alloc_size = sizeof(struct button_adc_priv),
>> +       .bind           = button_adc_bind,
>> +       .probe          = button_adc_probe,
>> +};
>> --
>> 2.17.1
>>
> Regards,
> Simon
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

