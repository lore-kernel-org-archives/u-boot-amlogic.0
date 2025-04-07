Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43467C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:31:07 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.41391.1744011064730977044
 for <u-boot-amlogic@groups.io>;
 Mon, 07 Apr 2025 00:31:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gC9wpbQs;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf257158fso26918775e9.2
        for <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744011063; x=1744615863; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PzUkauJz6eUqsp2mAxyAZ/wmWS1LrZrN50sg9NQblE=;
        b=gC9wpbQsUHOdrjUKiA4EPl4TuZiQ9zK6tX1XzPE/g/Cqb/uvtczNQgmK0OK7eLBjCY
         fHbm8sp7mVWaoiXm7JMt0HwC36EDEBsq0ySyy7fU5uEXtwM52+H/ElfdbbBaplLgt+C/
         AigNbtxUbsw3bcfNMUhNIB1Bjyc34UWLuosbkUYBPEKrbZua5//4AHNDdU3hgFOjAbSn
         e1KpoHDjJygVc7/rubHagYPPpm5vy/NHy5rFyIlylkIQ07V17PaKS/iBp4Iy2nKA0Hq6
         dYBVPtKUNOm3Y4BiWE1qVargsUbZIR63f3vuypYlB8h5E9Gp0XgWCK1eGREfYmg6pI1d
         wJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744011063; x=1744615863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/PzUkauJz6eUqsp2mAxyAZ/wmWS1LrZrN50sg9NQblE=;
        b=idyJNZzbIT/gsDfjcbevRmhS9AqVDCUX73gH6bUn1oWTYbCYFqsJ11OGa5gW+SGCWA
         HOjxxECvprRcNT/bK4SADwbc/tYHG4rFgRWEU5ydHM2rv6I9NYoJ1HCk2q3Vug7QnZJ/
         ZtktmvFCazaxGzpNxWprAiyzRwDnUJN5khiBo/o462WjQ6Lf4Tc3YNgpgmLk8v7f/aCW
         Rmx+x1KyJ1dVfOUlf4epgbYplTvQuRd10+vPJKP/DhfiMlBR+yIcpgsufmvu8biV5zuX
         4YwKpgPLZmNiwF/beYpfw2jdzjXczCG+5yLNpKAU65DSD6azXWC2hfcIWxNOKHGHFQI2
         LksA==
X-Forwarded-Encrypted: i=1; AJvYcCUX4VyavU0Y4DZP4OtAyw0REteDjaZk55a7uDC3/JLukMiASJNesbjJXICP2ag1SO+y0GLKNQcCOx4fujAxgg==@groups.io
X-Gm-Message-State: AOJu0Yw1A1Eg7rb0U0to/Le5DrjPr8nvVlzjAgZIRs8xD3rq2RyG+RQC
	I8HGEh5rTvxgQaWXmbV5MNulA8ZF+RjcfRBO9GKNTiB9M15XAgVa9/yT1zwDlKw=
X-Gm-Gg: ASbGnctcXIr/vN+New2oOQ9MoQkxyl0nOX6pa9IAY6qq9DjvFXMvr3ENebvtwx4I1zd
	dEugPikj23uGlSuSNrIOyn0uutEj6OXhwMA+KvT6ujXvQOTxayK5rUs4AUrR5W3ySulBM2RxZqt
	eiExo8Q2oIs2aL5LnAt/dG1GffbQ2xLHEsqBV6/0VWiHHyerzKorgU0jh+fDVZ4gWkMuYjT82dW
	2FwxKqZejLr+qTjJX5wSzXUzqny/bR2DTyCy7x9AQ+e4CY3uLNpjXd+W7VMEm+FjVHWOB8N5yk5
	UfWLzQItCmTkJGF860Zuc5z0dwluE0433a4y6GmJgvkDjfsqK5ReAP3Acj44RFcjQV9gu0FNq4G
	7HcYJx7XKA5BoAPFDFcPO+A==
X-Google-Smtp-Source: AGHT+IEDQ9y5nKH2og5UFcQiDQvnJ3oIwDc2EBPuXms0Q1hXL+7/sBqoCgHUKa+sbp0I4TcNFFY7Cg==
X-Received: by 2002:a05:600c:3109:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-43ecf57edb7mr120838525e9.0.1744011063015;
        Mon, 07 Apr 2025 00:31:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605? ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1f27a55sm123104595e9.2.2025.04.07.00.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 00:31:02 -0700 (PDT)
Message-ID: <5d894819-119a-44ed-b3aa-5f99e54c76c6@linaro.org>
Date: Mon, 7 Apr 2025 09:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/4] designware: Use the remove() method with related
 drivers
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-2-sjg@chromium.org>
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
In-Reply-To: <20250407013513.638110-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:31:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2650

On 07/04/2025 03:35, Simon Glass wrote:
> Several drivers make use of the designware Ethernet driver but do not
> implement the remove() method. Add this to keep things tidy.
> 
> Note that the Ethernet uclass calls each driver's stop() method on
> removal, so there is no need to do that here.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> ---
> 
> Changes in v2:
> - Use the designware_eth_remove() method directly
> - Add gmac_rockchip too
> - Reword the commit message to mention the uclass' actions
> 
>   drivers/net/designware.c    |  2 +-
>   drivers/net/designware.h    | 12 ++++++++++++
>   drivers/net/dwmac_meson8b.c |  1 +
>   drivers/net/dwmac_s700.c    |  1 +
>   drivers/net/dwmac_socfpga.c |  1 +
>   drivers/net/gmac_rockchip.c |  1 +
>   6 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 07b0f49ef58..5385849ea6b 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -805,7 +805,7 @@ clk_err:
>   	return err;
>   }
>   
> -static int designware_eth_remove(struct udevice *dev)
> +int designware_eth_remove(struct udevice *dev)
>   {
>   	struct dw_eth_dev *priv = dev_get_priv(dev);
>   
> diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> index e47101ccaf6..8c9d0190e03 100644
> --- a/drivers/net/designware.h
> +++ b/drivers/net/designware.h
> @@ -247,6 +247,18 @@ struct dw_eth_dev {
>   
>   int designware_eth_of_to_plat(struct udevice *dev);
>   int designware_eth_probe(struct udevice *dev);
> +
> +/**
> + * designware_eth_remove() - Remove the device
> + *
> + * Disables DMA and marks the device as remove. This must be called before
> + * booting an OS, to ensure that DMA is inactive.
> + *
> + * @dev: Device to remove
> + * Return 0 if OK, -ve on error
> + */
> +int designware_eth_remove(struct udevice *dev);
> +
>   extern const struct eth_ops designware_eth_ops;
>   
>   struct dw_eth_pdata {
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index fde4aabbace..bf94e50842d 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -158,6 +158,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.of_match	= dwmac_meson8b_ids,
>   	.of_to_plat = dwmac_meson8b_of_to_plat,
>   	.probe		= dwmac_meson8b_probe,
> +	.remove		= designware_eth_remove,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index 969d247b4f3..e78193f3376 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -60,6 +60,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.of_match = dwmac_s700_ids,
>   	.of_to_plat = dwmac_s700_of_to_plat,
>   	.probe  = dwmac_s700_probe,
> +	.remove	= designware_eth_remove,
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct eth_pdata),
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index a9e2d8c0972..dda33f90d65 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -141,6 +141,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.of_match	= dwmac_socfpga_ids,
>   	.of_to_plat = dwmac_socfpga_of_to_plat,
>   	.probe		= dwmac_socfpga_probe,
> +	.remove		= designware_eth_remove,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 8cfeeffe95b..5c542d62bd8 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -756,6 +756,7 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.of_match = rockchip_gmac_ids,
>   	.of_to_plat = gmac_rockchip_of_to_plat,
>   	.probe	= gmac_rockchip_probe,
> +	.remove	= designware_eth_remove,
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct gmac_rockchip_plat),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

