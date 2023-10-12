Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.6006.1697095465259085707
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Oct 2023 00:24:25 -0700
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so891868e87.1
        for <u-boot-amlogic@groups.io>; Thu, 12 Oct 2023 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697095463; x=1697700263; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cPCDR1LNByf7pFqbKQgMF5hUul43mQVN8swXPpciFE=;
        b=C7Pw/TKbvMCD1s/lwxPoN2tNqKwq5G99WCBP1M27MP8nG94mkLS3sZQAQxyFP7mwpi
         fVJNE/uRNYFZ6SahUWwfZHZoE4yrKWamX4mof0L16uQ5V69jiifMhQnv897cRDAVo3FK
         Xd6Sv6y9CvZMPkiIMZ24Q8AZa0BC9d8OXu1GW2M2Tg3OBtVxMaL37lp5DanoBzZU1vOd
         FhEJl6Z143/g2j8K7ntcgMhVVqXB5gTKx8+2vjRcOXehNL7Xlkvx70vJsfnhVignsU/j
         44YNKtZfmHDIqML0hYJcJfPz9wskeXBgWc8zpj109OtmUCFqI7x1FXAsOy8oBQFjuZeB
         GKxg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <a4ee2c60-2176-43be-87d4-dcd32a1173a2@linaro.org>
Date: Thu, 12 Oct 2023 09:24:20 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/1] drivers: rng: add support for Meson S4
References: <20231010111344.77563-1-avromanov@salutedevices.com>
 <20231010111344.77563-2-avromanov@salutedevices.com>
In-Reply-To: <20231010111344.77563-2-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 10/10/2023 13:13, Alexey Romanov wrote:
> For some Amlogic SOC's, mechanism to obtain random number
> has been changed. For example, S4 now uses status bit waiting algo.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index e0a1e8c7e0..ba60325b94 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -10,10 +10,23 @@
>   #include <dm.h>
>   #include <rng.h>
>   #include <asm/io.h>
> +#include <linux/iopoll.h>
> +
> +#define RNG_DATA	0x00
> +#define RNG_S4_DATA	0x08
> +#define RNG_S4_CFG	0x00
> +
> +#define RUN_BIT		BIT(0)
> +#define SEED_READY_STS_BIT	BIT(31)
> +
> +struct meson_rng_priv {
> +	u32 (*read)(fdt_addr_t base);
> +};
>   
>   struct meson_rng_plat {
>   	fdt_addr_t base;
>   	struct clk clk;
> +	struct meson_rng_priv *priv;
>   };
>   
>   /**
> @@ -27,10 +40,11 @@ struct meson_rng_plat {
>   static int meson_rng_read(struct udevice *dev, void *data, size_t len)
>   {
>   	struct meson_rng_plat *pdata = dev_get_plat(dev);
> +	struct meson_rng_priv *priv = pdata->priv;
>   	char *buffer = (char *)data;
>   
>   	while (len) {
> -		u32 rand = readl(pdata->base);
> +		u32 rand = priv->read(pdata->base);
>   		size_t step;
>   
>   		if (len >= 4)
> @@ -44,6 +58,47 @@ static int meson_rng_read(struct udevice *dev, void *data, size_t len)
>   	return 0;
>   }
>   
> +static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
> +{
> +	u32 status = 0;
> +	int ret;
> +
> +	ret = readl_relaxed_poll_timeout(cfg_addr,
> +					 status, !(status & bit),
> +					 10000);
> +	if (ret)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static u32 meson_common_rng_read(fdt_addr_t base)
> +{
> +	return readl(base);
> +}
> +
> +static u32 meson_s4_rng_read(fdt_addr_t base)
> +{
> +	void __iomem *cfg_addr = (void *)base + RNG_S4_CFG;
> +	int err;
> +
> +	writel_relaxed(readl_relaxed(cfg_addr) | SEED_READY_STS_BIT, cfg_addr);
> +
> +	err = meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
> +	if (err) {
> +		pr_err("Seed isn't ready, try again\n");
> +		return err;
> +	}
> +
> +	err = meson_rng_wait_status(cfg_addr, RUN_BIT);
> +	if (err) {
> +		pr_err("Can't get random number, try again\n");
> +		return err;
> +	}
> +
> +	return readl_relaxed(base + RNG_S4_DATA);
> +}
> +
>   /**
>    * meson_rng_probe() - probe rng device
>    *
> @@ -59,6 +114,8 @@ static int meson_rng_probe(struct udevice *dev)
>   	if (err)
>   		return err;
>   
> +	pdata->priv = dev_get_driver_data(dev);
> +
>   	return 0;
>   }
>   
> @@ -102,9 +159,22 @@ static const struct dm_rng_ops meson_rng_ops = {
>   	.read = meson_rng_read,
>   };
>   
> +static const struct meson_rng_priv meson_rng_priv = {
> +	.read = meson_common_rng_read,
> +};
> +
> +static const struct meson_rng_priv meson_rng_priv_s4 = {
> +	.read = meson_s4_rng_read,
> +};
> +
>   static const struct udevice_id meson_rng_match[] = {
>   	{
>   		.compatible = "amlogic,meson-rng",
> +		.data = (ulong)&meson_rng_priv,
> +	},
> +	{
> +		.compatible = "amlogic,meson-s4-rng",
> +		.data = (ulong)&meson_rng_priv_s4,
>   	},
>   	{},
>   };

I get:
+drivers/rng/meson-rng.c: In function 'meson_rng_probe':
+drivers/rng/meson-rng.c:117:21: error: assignment to 'struct meson_rng_priv *' from 'ulong' {aka 'long unsigned int'} makes pointer from integer without a cast [-Werror=int-conversion]
+  117 |         pdata->priv = dev_get_driver_data(dev);

while building in CI.

Thanks,
Neil
