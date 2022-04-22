Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.8468.1650634049874166836
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:27:30 -0700
Received: by mail-wr1-f50.google.com with SMTP id t6so7631662wra.4
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=qH8hGVY3ixLbS/jvsWdRsYpqQtiMr72z0GRtSwlCM4o=;
        b=61D7dnB7WN2hx3mWv0HlcW/fzEONqp65AlrBu5+dHi+UhKg+0sDSITpDu3WD4koVHB
         LTuJs8a+GjLZTQQEip+Yw9hqR5V/3mSYQukOWdNk+dpQ3eThK/gmnmRPb1DIIesSEbg7
         MY/imJZwnlc+/lRjJqVTL0LkoO/GYJglZit6F6N0C1QRemUznzledxUtvUek5nGXNwVp
         D6hW2kTErP0a5BTYhv+UWZDBj/joI+QybtTTm70bWd3WObjWmTBttCFWX88sZjv0/UPz
         ZEFoNKmDGkbz1pW4gM2H9+9QiYCoX9eYE0Rxam3/e/nxnKBDXIDgc7aVzHtoUWtZKWTy
         HXkg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <cec55cdf-d5b4-2294-f6c6-5311d969b207@baylibre.com>
Date: Fri, 22 Apr 2022 15:27:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/6] clk: meson: add minimal driver for axg-ao clocks
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-2-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-2-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Add minimal driver AO clocks on meson AXG family. Only ADC related clocks
> are supported.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/clk/meson/Makefile |  1 +
>   drivers/clk/meson/axg-ao.c | 89 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>   create mode 100644 drivers/clk/meson/axg-ao.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index b9c6bd66cf..a486b13e9c 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -5,5 +5,6 @@
>   
>   obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
>   obj-$(CONFIG_CLK_MESON_AXG) += axg.o
> +obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
>   obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
>   obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> new file mode 100644
> index 0000000000..3f9617e9f7
> --- /dev/null
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <common.h>
> +#include <log.h>
> +#include <asm/io.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <dt-bindings/clock/axg-aoclkc.h>
> +
> +#include "clk_meson.h"
> +
> +struct meson_clk {
> +	struct regmap *map;
> +};
> +
> +#define AO_CLK_GATE0		0x40
> +#define AO_SAR_CLK		0x90
> +
> +static struct meson_gate gates[] = {
> +	MESON_GATE(CLKID_AO_SAR_ADC, AO_CLK_GATE0, 7),
> +	MESON_GATE(CLKID_AO_SAR_ADC_CLK, AO_SAR_CLK, 7),
> +};
> +
> +static int meson_set_gate(struct clk *clk, bool on)
> +{
> +	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	struct meson_gate *gate;
> +
> +	gate = &gates[clk->id];
> +
> +	if (gate->reg == 0)
> +		return 0;
> +
> +	regmap_update_bits(priv->map, gate->reg,
> +			   BIT(gate->bit), on ? BIT(gate->bit) : 0);
> +
> +	return 0;
> +}
> +
> +static int meson_clk_enable(struct clk *clk)
> +{
> +	return meson_set_gate(clk, true);
> +}
> +
> +static int meson_clk_disable(struct clk *clk)
> +{
> +	return meson_set_gate(clk, false);
> +}
> +
> +static int meson_clk_probe(struct udevice *dev)
> +{
> +	struct meson_clk *priv = dev_get_priv(dev);
> +
> +	priv->map = syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
> +	if (IS_ERR(priv->map))
> +		return PTR_ERR(priv->map);
> +
> +	return 0;
> +}
> +
> +static int meson_clk_request(struct clk *clk)
> +{
> +	if (clk->id >= ARRAY_SIZE(gates))
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static struct clk_ops meson_clk_ops = {
> +	.disable	= meson_clk_disable,
> +	.enable		= meson_clk_enable,
> +	.request	= meson_clk_request,
> +};
> +
> +static const struct udevice_id meson_clk_ids[] = {
> +	{ .compatible = "amlogic,meson-axg-aoclkc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(meson_clk_axg_ao) = {
> +	.name		= "meson_clk_axg_ao",
> +	.id		= UCLASS_CLK,
> +	.of_match	= meson_clk_ids,
> +	.priv_auto	= sizeof(struct meson_clk),
> +	.ops		= &meson_clk_ops,
> +	.probe		= meson_clk_probe,
> +};

Looks ok

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

