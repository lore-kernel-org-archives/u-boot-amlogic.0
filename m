Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.15928.1687450711698250785
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Jun 2023 09:18:32 -0700
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so21696065e9.1
        for <u-boot-amlogic@groups.io>; Thu, 22 Jun 2023 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687450710; x=1690042710;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I2Yt2GYJ4UaqIyDqxVBIOUYUjR7wwj0inQLlQH/Uv4c=;
        b=JcVzsdwbkcxR7wT4e6xQ6kzOONTlT9ZFmC6XT1w4Zk/bHURILxxzbTl5rDkLCi50wP
         pExAw6IXv18wK+xmOjhLnfuXpzQjn+40n9y/z/YjJr+81+36PnzsfjeJkzym0islYSAQ
         EmbpDEGqsqHwtNTiKwiA/iHOZXRAI097KMHSl4i8ZIEegDCN0BZi2t8de5uDnRaKq11x
         04p85RXROPEfIG528F9BIIHQyhZrFsu6DhkYA0CfvXGlgA933GIVWjAGPCNtG8rOxjOv
         eR6hbEXh84EXKCRl+iDRzR0LEa/mxrzhQ/ds40xj0OzPWMiWxwVXzilli8eUAeCp4Q+C
         GLPg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <697a4d8a-0a1b-16cb-a5dd-f1e25d11d4f9@linaro.org>
Date: Thu, 22 Jun 2023 18:18:28 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: rng: add check status bit feature
References: <20230621102401.76646-1-avromanov@sberdevices.ru>
In-Reply-To: <20230621102401.76646-1-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com, xypron.glpk@gmx.de, sughosh.ganu@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 21/06/2023 12:24, Alexey Romanov wrote:
> For some Amlogic SOC's, the mechanism for obtain a random number
> has been changed. For example, S4 now uses a status bit wait algo.

Thanks for the change, but could you add this first in Linux with the
associated bindings update and DT changes then port it to U-boot ?

Thanks,
Neil

> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   drivers/rng/meson-rng.c | 73 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index e0a1e8c7e04..3bf2eb9cf87 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -11,36 +11,82 @@
>   #include <rng.h>
>   #include <asm/io.h>
>   
> +struct meson_rng_data {
> +	bool check_status_bit;
> +};
> +
>   struct meson_rng_plat {
>   	fdt_addr_t base;
>   	struct clk clk;
> +	struct meson_rng_data *data;
>   };
>   
> +#define RETRY_CNT 100
> +#define RNG_OUT_OFFSET 0x08
> +
> +#define SEED_READY_STS_BIT 0
> +#define RUN_BIT 31
> +
> +static int meson_rng_wait_status(struct meson_rng_plat *pdata, int bit)
> +{
> +	u32 status;
> +	u32 cnt = 0;
> +
> +	pr_debug("Poll status of bit: %d\n", bit);
> +
> +	do {
> +		status = readl(pdata->base) & BIT(bit);
> +	} while (status && (cnt++ < RETRY_CNT));
> +
> +	if (cnt == RETRY_CNT) {
> +		pr_err("Can't get random number, try again");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * meson_rng_read() - fill buffer with random bytes
>    *
>    * @buffer:	buffer to receive data
>    * @size:	size of buffer
>    *
> - * Return:	0
> + * Return:	0 on success or -errno in failure
>    */
>   static int meson_rng_read(struct udevice *dev, void *data, size_t len)
>   {
>   	struct meson_rng_plat *pdata = dev_get_plat(dev);
> +	struct meson_rng_data *rng_data = pdata->data;
>   	char *buffer = (char *)data;
> +	int err;
>   
>   	while (len) {
> -		u32 rand = readl(pdata->base);
> +		u32 rand;
>   		size_t step;
>   
> -		if (len >= 4)
> -			step = 4;
> -		else
> -			step = len;
> +		if (rng_data->check_status_bit) {
> +			writel(readl(pdata->base) | BIT(SEED_READY_STS_BIT), pdata->base);
> +
> +			err = meson_rng_wait_status(pdata, SEED_READY_STS_BIT);
> +			if (err)
> +				return err;
> +
> +			err = meson_rng_wait_status(pdata, RUN_BIT);
> +			if (err)
> +				return err;
> +
> +			rand = readl(pdata->base + RNG_OUT_OFFSET);
> +		} else {
> +			rand = readl(pdata->base);
> +		}
> +
> +		step = min_t(u32, len, 4);
>   		memcpy(buffer, &rand, step);
>   		buffer += step;
>   		len -= step;
>   	}
> +
>   	return 0;
>   }
>   
> @@ -90,6 +136,8 @@ static int meson_rng_of_to_plat(struct udevice *dev)
>   	if (!pdata->base)
>   		return -ENODEV;
>   
> +	pdata->data = (struct meson_rng_data *)dev_get_driver_data(dev);
> +
>   	/* Get optional "core" clock */
>   	err = clk_get_by_name_optional(dev, "core", &pdata->clk);
>   	if (err)
> @@ -102,9 +150,22 @@ static const struct dm_rng_ops meson_rng_ops = {
>   	.read = meson_rng_read,
>   };
>   
> +static const struct meson_rng_data meson_rng_data = {
> +	.check_status_bit = false,
> +};
> +
> +static const struct meson_rng_data meson_rng_data_s4 = {
> +	.check_status_bit = true,
> +};
> +
>   static const struct udevice_id meson_rng_match[] = {
>   	{
>   		.compatible = "amlogic,meson-rng",
> +		.data = (ulong)&meson_rng_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-rng-s4",
> +		.data = (ulong)&meson_rng_data_s4,
>   	},
>   	{},
>   };

