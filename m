Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5243FCDB47E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 07:24:30 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.6006.1697095465259085707
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Oct 2023 00:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=C7Pw/TKb;
 spf=pass (domain: linaro.org, ip: 209.85.167.49, mailfrom: neil.armstrong@linaro.org)
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
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697095463; x=1697700263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cPCDR1LNByf7pFqbKQgMF5hUul43mQVN8swXPpciFE=;
        b=laZiRo1DFXi0lFmFUvGmii6x8ehCKQACqrL6RY1OU+8jlYCgddwM19Ks+j1AzWptPC
         kc6cCZbLR/vmJy9sPmSQbrarhTYbOJ5vhaViQzQMqdJ+IaZSCtH/RpSa5yKfOTmHnC5O
         qrJvO4bMj/vct/vXk8asbQCWccKN8vbYMec+kkRx9zTLXsjKDUAkx/tNZQ9NALO/YpE2
         hyXqwdqcdrgJbkUaJDgEWRpN34jtnnwcod1ZXH7aDyv4A+inlPcsl6VMBGM7c/ksE3jb
         nRRfBYxOP4NPvJD1EyQz3HYucSQFRoXnrNHBJH8sLlYatGCdB73Cy4rSr843p71rtvCV
         p7FQ==
X-Gm-Message-State: AOJu0YwRfiY+gbGBSs7LFWQZbYm8OmLdaH7Jr7CD97cikmSbptoXCqEn
	UxmnHF6U1dI52I7NmYXmFFSXBw==
X-Google-Smtp-Source: AGHT+IHSmmCP2HS7X6hvAoTz0WdyCNdmh5x6hj3nm4JXPi41Lz2UorjyS2zJnlq9VAiTKktFY0mJSg==
X-Received: by 2002:a05:6512:e99:b0:500:86b4:5282 with SMTP id bi25-20020a0565120e9900b0050086b45282mr22613591lfb.34.1697095463328;
        Thu, 12 Oct 2023 00:24:23 -0700 (PDT)
Received: from [192.168.7.21] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b004068def185asm19144085wms.28.2023.10.12.00.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:24:22 -0700 (PDT)
Message-ID: <a4ee2c60-2176-43be-87d4-dcd32a1173a2@linaro.org>
Date: Thu, 12 Oct 2023 09:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/1] drivers: rng: add support for Meson S4
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231010111344.77563-1-avromanov@salutedevices.com>
 <20231010111344.77563-2-avromanov@salutedevices.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231010111344.77563-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 12 Oct 2023 07:24:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1744
Message-ID: <20231012072420._MLSvXlQ9yIiuwaLaJ0kUaJCPuZW5wcT6q9gWXM_5qQ@z>

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

