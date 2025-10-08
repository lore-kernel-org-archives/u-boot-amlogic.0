Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0AACCA472
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 13:33:15 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.16005.1759930388464326291
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 06:33:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=n9oCWVo5;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2e363118so67780565e9.0
        for <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759930387; x=1760535187; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gCtVeqv/xctn0W0vlzJRNNyG26Hrx1wHzyi8DOXBLk=;
        b=n9oCWVo5i8VixVf7YrddpQbL9XCq1aq9jKXnX1Z8Sm9ydLzR6+EKmUl5FskEFxbMGZ
         yaM21EliCPKYQqaFMZVaZrebZ6aBzp/yEtN0pp/NbiugE49I0kyIPTioXQwc7ePSjBG9
         ZUUnqmxfhvlKIx82xI7YCm9xuUYuiDkl1NO3bAyUINO2WKqjK/+zkBnoavOAH0CMCK7S
         xg+KFuGT9NVnHA+9F6ShptypsOz31SZmDW1unnl6zXgZNvLUvCDSphKTE1v6n40ZRLO2
         CM7ZwP4tl15o4/5Uj4CFd9Uz2UBj+ZF3NG3irbIbbB8VW+nEqa2hNjzBZDQJ9wKR7y09
         MONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930387; x=1760535187;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gCtVeqv/xctn0W0vlzJRNNyG26Hrx1wHzyi8DOXBLk=;
        b=ecMTe4GiWKiKbEr8OSTNMuRgk0ZmsQDVyKCrRXu+TX4nTQn5FKD97cpbramRacrji3
         pwL/tNHVs5qyGLgsk2QniRGHTwHGFXU3D++W4s5dijrf7abaoaF3RreqvFUGP2eDC9Rn
         yLK1MU2uZsAzIp9BLDyJJgRv22iHymaP0M43f8A2OqJJrIyT+Jp610dxWOba080tbeoW
         6qTQG5hIIr5UtKYhgsv3y/ClIMxKIkzmOXJ7jvIhVXYIS4bGBBZrkfcraIny3mNT0KPY
         q3JbXcsG2glTh+c/BmO9Mpy5yaROmpGhN/VGRJDW2BPa3lMCsJVQQpFdDqW6tx1V10qB
         4jmA==
X-Forwarded-Encrypted: i=1; AJvYcCVWOJOyR7p09bM4ABweVixvAWVN1/GyLDTSp3sJmCSj4InnUrbaieU5gi7DH7jJQhYApyJStkqXQRE9K6+LPQ==@groups.io
X-Gm-Message-State: AOJu0YwkZnNu2l4A+aSzyD7bhzDYmeUFtX2YfTf+o+DN98auWx8z3bZJ
	j1qxqfQT6h1oLSirUJLfVMDQ8G8OJlD73++KSziSynvyTwLiGk22RBWD5QqKR+lUIaw=
X-Gm-Gg: ASbGnctCd+qTQOpTTCxqRxP3QVmh1TspmZhvPbm8GEEXysG4iNiwy9GQUvIz/bXlNV+
	UPzSqE2ZWqGcvxikoNBkKcSBdUWOsqbgbFGFyW03BDMHfJQPUFkST4kq1Dzu/MIdR2ELphYGeyW
	7LmJL44pjtQi0Sci5mjOCjJ4tOGq0USk4NhkH2IRc6VvgrnWgixuR7VCyyiVrPETzNbwUWaoqvB
	SF4xX5eF6s0RTJ2wSr9Cr85rfPEf593uISOOplaWKL55YCuP2BBMLx9zWnVNRX/TbifRTWKbe7q
	pY/lWKHG4JcT4FSthd3t48m9I08axdgr3tHLBfJ4igkWDUSX9Q1sem6+r8ZetYZg/w6VNrjzkFW
	mHA8NoYeANJtVwAAemiD6SqbxubfNyPHQGuJuSD0UprJfRZa7P1wcuYs1v9WhzBAIMbFweyeCxS
	CAbtZFrgclmnFgbpDZK7k=
X-Google-Smtp-Source: AGHT+IFUXJq7JH7SlIOgsPhp2y57cfdx+ATI9LUbff2mxRd9EDkWvooMDDXud42aZcpW0hCJvb0Lqw==
X-Received: by 2002:a05:600c:c162:b0:46e:5a5b:db60 with SMTP id 5b1f17b1804b1-46fa9affbe0mr28779705e9.31.1759930386678;
        Wed, 08 Oct 2025 06:33:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d? ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4bdcsm30017252f8f.54.2025.10.08.06.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:33:06 -0700 (PDT)
Message-ID: <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
Date: Wed, 8 Oct 2025 15:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
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
Organization: Linaro
In-Reply-To: <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 13:33:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2802

On 10/8/25 12:00, Ferass El Hafidi wrote:
> Add a minimal non-DM MMC driver for use in size-constrained
> environments.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/gx.h |  5 +++
>   drivers/mmc/meson_gx_mmc.c           | 75 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
> index 26ec5d0bc340bc03587047d68a88042779e64536..8cfc6b00329f252bbf452dba00f8ad56b480c707 100644
> --- a/arch/arm/include/asm/arch-meson/gx.h
> +++ b/arch/arm/include/asm/arch-meson/gx.h
> @@ -41,4 +41,9 @@
>   #define GX_GPIO_IN(n)		GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 1)
>   #define GX_GPIO_OUT(n)	GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 2)
>   
> +/* Non-DM MMC init */
> +#if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
> +struct mmc *meson_mmc_init(int mmc_no);
> +#endif
> +
>   #endif /* __GX_H__ */
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 5852b24c6d2a5a9d1b1e8a62f8c0ec325b339182..a4338f1e29c1da07acb0333be9b75a318cba1334 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -16,6 +16,7 @@
>   #include <linux/log2.h>
>   #include "meson_gx_mmc.h"
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   bool meson_gx_mmc_is_compatible(struct udevice *dev,
>   				enum meson_gx_mmc_compatible family)
>   {
> @@ -23,6 +24,7 @@ bool meson_gx_mmc_is_compatible(struct udevice *dev,
>   
>   	return compat == family;
>   }
> +#endif
>   
>   static inline void *get_regbase(const struct mmc *mmc)
>   {
> @@ -67,7 +69,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	 * Other SoCs use CLK_CO_PHASE_180 by default.
>   	 * It needs to find what is a proper value about each SoCs.
>   	 */
> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
> +	if (IS_ENABLED(CONFIG_MESON_SM))

I'm not a fan of that, technically while we keep the socs separated the
driver should be generic and not rely on the soc config.

I'k ok to have it in non-DM, but in DM it should still use meson_gx_mmc_is_compatible().

Neil

>   		meson_mmc_clk |= CLK_CO_PHASE_270;
>   	else
>   		meson_mmc_clk |= CLK_CO_PHASE_180;
> @@ -82,9 +84,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	meson_write(mmc, meson_mmc_clk, MESON_SD_EMMC_CLOCK);
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_set_ios(struct udevice *dev)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else
> +static int meson_legacy_mmc_set_ios(struct mmc *mmc)
> +{
> +#endif
>   	uint32_t meson_mmc_cfg;
>   
>   	meson_mmc_config_clock(mmc);
> @@ -193,10 +200,16 @@ static void meson_mmc_read_response(struct mmc *mmc, struct mmc_cmd *cmd)
>   	}
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   				 struct mmc_data *data)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else
> +static int meson_legacy_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
> +				     struct mmc_data *data)
> +{
> +#endif
>   	struct meson_mmc_plat *pdata = mmc->priv;
>   	uint32_t status;
>   	ulong start;
> @@ -235,6 +248,59 @@ static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   	return ret;
>   }
>   
> +#if !CONFIG_IS_ENABLED(DM_MMC)
> +struct meson_mmc_plat mmc_plat[2];
> +
> +static int meson_legacy_mmc_init(struct mmc *mmc)
> +{
> +	/* reset all status bits */
> +	meson_write(mmc, STATUS_MASK, MESON_SD_EMMC_STATUS);
> +
> +	/* disable interrupts */
> +	meson_write(mmc, 0, MESON_SD_EMMC_IRQ_EN);
> +
> +	return 0;
> +}
> +
> +static const struct mmc_ops meson_mmc_ops = {
> +	.send_cmd	= meson_legacy_mmc_send_cmd,
> +	.set_ios	= meson_legacy_mmc_set_ios,
> +	.init		= meson_legacy_mmc_init,
> +};
> +
> +struct mmc *meson_mmc_init(int mmc_no)
> +{
> +	struct meson_mmc_plat *pdata = &mmc_plat[mmc_no];
> +	struct mmc_config *cfg = &pdata->cfg;
> +
> +	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
> +			MMC_VDD_31_32 | MMC_VDD_165_195;
> +	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT;
> +	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
> +	cfg->f_max = 6000000; /* 6 MHz */
> +	cfg->b_max = 127; /* max 128 - 1 block */
> +	cfg->name = "Meson SD/eMMC";
> +	cfg->ops = &meson_mmc_ops;
> +
> +	if (mmc_no == 0) /* MMC1: SD card */
> +		pdata->regbase = (void *)0xd0072000;
> +	else if (mmc_no == 1) /* MMC2: eMMC */
> +		pdata->regbase = (void *)0xd0074000;
> +
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
> +	/* Enable power if needed */
> +	ret = mmc_pwrseq_get_power(dev, cfg);
> +	if (!ret) {
> +		ret = pwrseq_set_power(cfg->pwr_dev, true);
> +		if (ret)
> +			return ret;
> +	}
> +#endif
> +
> +	return mmc_create(cfg, pdata);
> +}
> +
> +#else
>   static const struct dm_mmc_ops meson_dm_mmc_ops = {
>   	.send_cmd = meson_dm_mmc_send_cmd,
>   	.set_ios = meson_dm_mmc_set_ios,
> @@ -282,6 +348,12 @@ static int meson_mmc_probe(struct udevice *dev)
>   	cfg->b_max = 511; /* max 512 - 1 blocks */
>   	cfg->name = dev->name;
>   
> +	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
> +		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
> +		cfg->f_max = 6000000; /* 6 MHz */
> +		cfg->b_max = 127; /* max 128 - 1 block */
> +	}
> +
>   	mmc->priv = pdata;
>   	upriv->mmc = mmc;
>   
> @@ -336,3 +408,4 @@ U_BOOT_DRIVER(meson_mmc) = {
>   	.of_to_plat = meson_mmc_of_to_plat,
>   	.plat_auto	= sizeof(struct meson_mmc_plat),
>   };
> +#endif
> 


