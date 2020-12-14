Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web08.436.1607982580938755589
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 13:49:41 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201214214938epoutp015c32c124950f8cd7f7e939077d329334~Qs6KjXTE_1695516955epoutp01d
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 21:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201214214938epoutp015c32c124950f8cd7f7e939077d329334~Qs6KjXTE_1695516955epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607982578;
	bh=UzzTZfJ8f63W/dZq1aD4gNYFbO+NTvDfqj4FncDKfUc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=sGcv5GZikIuycqWIHcOmoh81aBeUdlgQ4fOMFAeRjjP0nkc1MPGdiBa+YgPjbaMUk
	 GihFy3MXj9SA04KYYnw7YATqTX4XQPRjKn7PKGdn2LVvp66M96c3075+WSeLkbyNh2
	 o2lNLubUleUexvuAmfJW650ivlxCwWah59ajmN6o=
Subject: Re: [PATCH 1/6] clk: meson: add minimal driver for g12a-ao clocks
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <a7925cb2-3688-8f0f-fda2-8f777d862433@samsung.com>
Date: Tue, 15 Dec 2020 06:50:00 +0900
MIME-Version: 1.0
In-Reply-To: <84d06ecc-70af-b5b1-6a4d-17b77a5679c7@baylibre.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112449eucas1p2ce0ef939e0d7f468e64be3555f29ea04@eucas1p2.samsung.com>
	<20201214112437.18757-2-m.szyprowski@samsung.com>
	<84d06ecc-70af-b5b1-6a4d-17b77a5679c7@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 3:53 AM, Neil Armstrong wrote:
> Hi,
> 
> On 14/12/2020 12:24, Marek Szyprowski wrote:
>> Add minimal driver AO clocks on meson G12A family. Only ADC related clocks
>> are supported.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Change-Id: I0c91848bc55493e19570db333e7da6020d687907
> 
> Please drop the Change-Ids
> 
>> ---
>>  drivers/clk/meson/Makefile  |  1 +
>>  drivers/clk/meson/g12a-ao.c | 83 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 84 insertions(+)
>>  create mode 100644 drivers/clk/meson/g12a-ao.c
>>
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index c873d6976fa..7204383e173 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -6,4 +6,5 @@
>>  obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
>>  obj-$(CONFIG_CLK_MESON_AXG) += axg.o
>>  obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
>> +obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
>>  
>> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
>> new file mode 100644
>> index 00000000000..7a0abea77c4
>> --- /dev/null
>> +++ b/drivers/clk/meson/g12a-ao.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include <common.h>
>> +#include <log.h>
>> +#include <asm/io.h>
>> +#include <clk-uclass.h>
>> +#include <dm.h>
>> +#include <regmap.h>
>> +#include <syscon.h>
>> +#include <dt-bindings/clock/g12a-aoclkc.h>
>> +
>> +#include "clk_meson.h"
>> +
>> +struct meson_clk {
>> +	struct regmap *map;
>> +};
>> +
>> +#define AO_CLK_GATE0		0x4c
>> +#define AO_SAR_CLK		0x90
>> +
>> +static struct meson_gate gates[] = {
>> +	MESON_GATE(CLKID_AO_SAR_ADC, AO_CLK_GATE0, 8),
>> +	MESON_GATE(CLKID_AO_SAR_ADC_CLK, AO_SAR_CLK, 8),
>> +};
>> +
>> +static int meson_set_gate(struct clk *clk, bool on)
>> +{
>> +	struct meson_clk *priv = dev_get_priv(clk->dev);
>> +	struct meson_gate *gate;
>> +
>> +	if (clk->id >= ARRAY_SIZE(gates))
>> +		return -ENOENT;
>> +
>> +	gate = &gates[clk->id];
>> +
>> +	if (gate->reg == 0)
>> +		return 0;
>> +
>> +	regmap_update_bits(priv->map, gate->reg,
>> +			   BIT(gate->bit), on ? BIT(gate->bit) : 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_clk_enable(struct clk *clk)
>> +{
>> +	return meson_set_gate(clk, true);
>> +}
>> +
>> +static int meson_clk_disable(struct clk *clk)
>> +{
>> +	return meson_set_gate(clk, false);
>> +}
>> +
>> +static int meson_clk_probe(struct udevice *dev)
>> +{
>> +	struct meson_clk *priv = dev_get_priv(dev);
>> +
>> +	priv->map = syscon_node_to_regmap(dev_get_parent(dev)->node);
>> +	if (IS_ERR(priv->map))
>> +		return PTR_ERR(priv->map);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct clk_ops meson_clk_ops = {
>> +	.disable	= meson_clk_disable,
>> +	.enable		= meson_clk_enable,
>> +};
>> +
>> +static const struct udevice_id meson_clk_ids[] = {
>> +	{ .compatible = "amlogic,meson-g12a-aoclkc" },
>> +	{ }
>> +};
>> +
>> +U_BOOT_DRIVER(meson_clk_axg) = {
>> +	.name		= "meson_clk_g12a_ao",
>> +	.id		= UCLASS_CLK,
>> +	.of_match	= meson_clk_ids,
>> +	.priv_auto_alloc_size = sizeof(struct meson_clk),
>> +	.ops		= &meson_clk_ops,
>> +	.probe		= meson_clk_probe,
>> +};
>>
> 
> very nice, thanks for addition !
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> 

