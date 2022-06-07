Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.13016.1654610454966113725
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jun 2022 07:00:55 -0700
Received: by mail-wr1-f47.google.com with SMTP id q26so13943483wra.1
        for <u-boot-amlogic@groups.io>; Tue, 07 Jun 2022 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GnE4DyE1wIC1SG2mwP5d1hvqwy/KWE2RiJqHzv6Worc=;
        b=ThSwgsUzc9YB17pyeR11xW561ZVzTyVdmUxJVCIl1F8FGX6iU+6C1hFIvhDLkJAs4+
         Jc/WoI7o18RuourK+IU18qhQH7O70+rZ6URwGDIfw5HJA0v45ANauhI6UHlO4N+EPN4Q
         Oj05CYcEQNZky+i4VWeHfTNPHG1BK9zz0ecZ763vstgHNdrg6YN8iz3yakCjecjWj96A
         B/+DU7xXJCbW1cMLbWoKzQRxkivLCD8E04BYZYP0Gr7Ox0Mmn+rLQCsokEwAYv2cTytO
         wYMWuYc+M6sDzhAsI1nt/gGwzeDajUOZwpZuZLEqJl5m0ZdE4+BkOQ5cpnZu8sGej5y/
         5yDA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <46c23d77-1e4f-65c0-58ba-09d1593a726e@baylibre.com>
Date: Tue, 7 Jun 2022 16:00:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: add amlogic watchdog support
References: <20220607132842.30525-1-pboos@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220607132842.30525-1-pboos@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Philippe Boos <pboos@baylibre.com>, Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Jerome Brunet <jbrunet@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 07/06/2022 15:28, Philippe Boos wrote:
> Add support for hardware watchdog timer for Amlogic SoCs.
> This driver has been heavily inspired by his Linux equivalent
> (meson_gxbb_wdt.c).
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Philippe Boos <pboos@baylibre.com>
> 
> ---
> 
> This watchdog driver has been tested on a GXL libretech-cc board and also on
> a custom G12a board. I did the following test cases:
>   * boot with a faulty boot command, then we reach watchdog reset successfully,
>   * boot a Linux kernel with and without watchdog support, and check if it is
>     working as expected.
> 
>   drivers/watchdog/Kconfig          |   6 ++
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/meson_gxbb_wdt.c | 126 ++++++++++++++++++++++++++++++
>   3 files changed, 133 insertions(+)
>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c3eb8a8aec..81b60482c9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -175,6 +175,12 @@ config WDT_MAX6370
>   	help
>   	  Select this to enable max6370 watchdog timer.
>   
> +config WDT_MESON_GXBB
> +	bool "Amlogic watchdog timer support"
> +	depends on WDT
> +	help
> +	  Amlogic watchdog timer support.
> +
>   config WDT_MPC8xx
>   	bool "MPC8xx watchdog timer support"
>   	depends on WDT && MPC8xx
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 1f6199beca..0e2f582a5f 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
>   obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
> +obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
>   obj-$(CONFIG_WDT_MPC8xx) += mpc8xx_wdt.o
>   obj-$(CONFIG_WDT_MT7620) += mt7620_wdt.o
>   obj-$(CONFIG_WDT_MT7621) += mt7621_wdt.o
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> new file mode 100644
> index 0000000000..56b8a8990c
> --- /dev/null
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2022 BayLibre, SAS.
> + */
> +
> +#include <clk.h>
> +#include <common.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <reset.h>
> +#include <wdt.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +
> +#define GXBB_WDT_CTRL_REG			0x0
> +#define GXBB_WDT_TCNT_REG			0x8
> +#define GXBB_WDT_RSET_REG			0xc
> +
> +#define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
> +#define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> +#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
> +#define GXBB_WDT_CTRL_EN			BIT(18)
> +
> +#define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
> +#define GXBB_WDT_TCNT_SETUP_MASK		GENMASK(15, 0)
> +
> +
> +struct amlogic_wdt_priv {
> +	void __iomem *reg_base;
> +};
> +
> +static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
> +{
> +	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +
> +	if (timeout_ms > GXBB_WDT_TCNT_SETUP_MASK) {
> +		dev_warn(dev, "%s: timeout_ms=%llu: maximum watchdog timeout "
> +		         "exceeded\n", __func__, timeout_ms);
> +		timeout_ms = GXBB_WDT_TCNT_SETUP_MASK;
> +	}
> +
> +	writel(timeout_ms, data->reg_base + GXBB_WDT_TCNT_REG);
> +
> +	return 0;
> +}
> +
> +static int amlogic_wdt_stop(struct udevice *dev)
> +{
> +	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
> +	       data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int amlogic_wdt_start(struct udevice *dev, u64 time_ms, ulong flags)
> +{
> +	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +
> +	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
> +	       data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return amlogic_wdt_set_timeout(dev, time_ms);
> +}
> +
> +static int amlogic_wdt_reset(struct udevice *dev)
> +{
> +	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +
> +	writel(0, data->reg_base + GXBB_WDT_RSET_REG);
> +
> +	return 0;
> +}
> +
> +static int amlogic_wdt_probe(struct udevice *dev)
> +{
> +	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +	int ret;
> +
> +	data->reg_base = dev_remap_addr(dev);
> +	if (!data->reg_base)
> +		return -EINVAL;
> +
> +	struct clk clk;
> +
> +	ret = clk_get_by_index(dev, 0, &clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&clk);
> +	if (ret) {
> +		clk_free(&clk);
> +		return ret;
> +	}
> +
> +	/* Setup with 1ms timebase */
> +	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> +	       GXBB_WDT_CTRL_EE_RESET |
> +	       GXBB_WDT_CTRL_CLK_EN |
> +	       GXBB_WDT_CTRL_CLKDIV_EN,
> +	       data->reg_base + GXBB_WDT_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops amlogic_wdt_ops = {
> +	.start = amlogic_wdt_start,
> +	.reset = amlogic_wdt_reset,
> +	.stop = amlogic_wdt_stop,
> +};
> +
> +static const struct udevice_id amlogic_wdt_ids[] = {
> +	{ .compatible = "amlogic,meson-gxbb-wdt" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(amlogic_wdt) = {
> +	.name = "amlogic_wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = amlogic_wdt_ids,
> +	.priv_auto = sizeof(struct amlogic_wdt_priv),
> +	.probe = amlogic_wdt_probe,
> +	.ops = &amlogic_wdt_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};

Can you update MAINTAINERS to include it in "ARM AMLOGIC SOC SUPPORT" entry ?

With this:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
