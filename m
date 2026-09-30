Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAEBCA5FC5
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 21:09:43 +0000 (UTC)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1617.1790802582093004010
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Sep 2026 14:09:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=jDDEv3QP;
 spf=pass (domain: brivo.com, ip: 74.125.226.235, mailfrom: sanderson@brivo.com)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-988bb9d0548so818638241.2
        for <u-boot-amlogic@groups.io>; Wed, 30 Sep 2026 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790802581; x=1791407381; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
        b=jDDEv3QPkFakefnvcKkxGdG5Msb3yFK4lkIe5PyXuOMj4WjjxiUKph7QdP8AYuO86I
         zAk0/jR7xNKq3qUMK7ZT7RXiPQPtbA6J+WYRin4RAdtN0z9gnbTjewZQaFyac/r6GwNe
         Ly8uOn7aWHOzFgdMQsDH6Ekn7EZYvO1gqwefnSfIn1TscTKvLhrV2RnCtj14pJeeRa+i
         wDUfBrS0TST/0/OFWJGdYA6lvjJ5RvPB+rzpBYu77FkjHpp1QQ2DQxgloZ8lz/NNXhxt
         SzgCbcx8f8PbtwK8G07NQX8Bo3Pr1Hw+kK2tYphIBYYuE07pxVeOX+Rr9glh/DgX5iZJ
         +72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802581; x=1791407381;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
        b=muYO1hQPtXwy7ceJNLSioej1XHZ1UrH/45VJdBV/MuivbZRIuE14Bsc8Fqi2ZwwWEl
         3by1H5L8NZ6m16XDH4EaeH5FkX3pZ1mQevZeSdnqi7+Mdz83df54K2+v0NZ3Rn8rMLt2
         j2r6rYSuk9+F/1dcedLZvrde/ks7L6pkfHDyq0kbWmxBKJHRFzYl3edpmUT+SGYbq/cU
         6xH6mIBzXE2+oreyyxWqaZ8/y7lRvi75UdZO9ESAG7SAorKxawoVIlxD/H/Zx/LRrNJV
         IetlxEIgS4qQPK/MZ6OMcDFT/oEuAhzsTKD/s+fnHyfjpklL3snff5HcFvBRnyMulC4i
         /kJg==
X-Gm-Message-State: AFq9FYKtTSmwISqoBZCrRYWWeBg0j5Xv917OAkTuHBsizVUAwyD+zVt8
	PIZFAGGWA3Xsmjr3XgZpQpLEv2VHVupzeBnzHSpI/lpXDq3fsLVm0YRxtkuPWBKhF9DsXs4f++c
	Yv1b1A/OIbn0LVYjDc3LstDdrMMxrb8tg4iwymtLaW3xvxzk+Cus/4pKEZEmCphIHY62UMg==
X-Gm-Gg: AYBFou3+gpxTNrIbeq1TVZ7YvgtbeKidvXsuOcPp0Wx1qhvYXnZXXGez07R/o4HaWar
	SOS+mHa+MxrxqYXaptYxO06bdIIGEFZRlLSsvrOH/Fe4YQ3YFKoUZ9GLuntIlWhMIN55kxCGcLG
	HofeLmSJKScBVdO+HbXGNDeuPwN+jymxYIgaDPw6rre/Sckw4dTnhHMEB5vh80mC2Vb0+XpAQzs
	4xC3CRZzPNZ4+SZRGACkIGjJhgyjOYsPQQUo2vCEDsBKvKaLkpUndYLlcoVCEFRTJOSy6G1mIo1
	OVaU2EqbeUXcnsQaFuCUNau6/8MxZR90mjY67lW4E5svB38ynl1zVGk4BR103xgkDhYh0yje+f/
	44G0J4Luk3rqwuwLxvBskd0U82Mw6gjhJA4fwnb3JtpX3yeMigwlmk3l8bMK3U4w0H21lR0xUUv
	yGkpFlJezmKD6L+irEG/QLA1StT1e9skVI9+rt/zJmG4EpnWkooIFamUqmSDSKN09nfoZyez17y
	Qw=
X-Received: by 2002:a05:6102:f91:b0:7af:81dd:a9d3 with SMTP id ada2fe7eead31-7be73795bd3mr602925137.29.1790802580744;
        Wed, 30 Sep 2026 14:09:40 -0700 (PDT)
Received: from [10.200.233.210] ([66.193.28.125])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7bfa6cba2fcsm685436137.8.2026.09.30.14.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 14:09:40 -0700 (PDT)
Message-ID: <4b0f1f15-3275-4d4e-85f7-b02d8bfdd88b@brivo.com>
Date: Wed, 30 Sep 2026 17:09:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: designware: Fix MDIO bus getting bound multiple
 times
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>
References: <20260929180055.3439132-1-sanderson@brivo.com>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <20260929180055.3439132-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 30 Sep 2026 21:09:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3113



On 9/29/26 2:00 PM, Sean Anderson wrote:
> designware_eth_probe may be called multiple times for a given device.
> such as if the first probe (or post_probe) fails for whatever reason.
> When this happens, subsequent probes still try to bind the MDIO bus,
> creating several duplicate copies of the bus (all possibly sharing the
> same of_node). This can cause an infinite loop in dm_mdio_probe_devices
> if we have been probed at least once already:
> 
> dm_mdio_probe_devices()
>   device_probe(dwmac.mac0)
>    device_probe(dwmac)
>     designware_eth_probe()
>      device_bind_driver_to_node(dwmac.mac1)
>      return -EFOO
>   device_probe(dwmac.mac1)
>    ...
> 
> Prevent this by binding the MDIO bus in designware_eth_bind instead of
> designware_eth_probe.
> 
> Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/net/designware.c    | 35 ++++++++++++++++++-----------------
>   drivers/net/designware.h    |  1 +
>   drivers/net/dwmac_meson8b.c |  3 +++
>   drivers/net/dwmac_s700.c    |  3 +++
>   drivers/net/dwmac_socfpga.c |  3 +++
>   drivers/net/dwmac_thead.c   |  3 +++
>   drivers/net/gmac_rockchip.c |  3 +++
>   7 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 6ed9c6d538a..256e474a565 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -209,15 +209,14 @@ static int dw_mdio_init(const char *name, void *priv)
>   }
>   
>   #if IS_ENABLED(CONFIG_DM_MDIO)
> -static int dw_dm_mdio_init(const char *name, void *priv)
> +int dw_dm_mdio_bind(struct udevice *dev)
>   {
> -	struct udevice *dev = priv;
> +	struct udevice *mdiodev;
>   	ofnode node;
>   	int ret;
>   
>   	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>   		const char *subnode_name = ofnode_get_name(node);
> -		struct udevice *mdiodev;
>   
>   		if (strcmp(subnode_name, "mdio"))
>   			continue;
> @@ -231,8 +230,10 @@ static int dw_dm_mdio_init(const char *name, void *priv)
>   	}
>   
>   	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
> -
> -	return dw_mdio_init(name, priv);
> +	ret = device_bind_driver(dev, "eth_designware_mdio", dev->name, &mdiodev);
> +	if (ret)
> +		debug("%s: not able to create mdio bus\n", __func__);
> +	return ret;
>   }
>   #endif
>   
> @@ -855,6 +856,9 @@ static int designware_eth_bind(struct udevice *dev)
>   		}
>   	}
>   
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	return dw_dm_mdio_bind(dev);
> +#endif
>   	return 0;
>   }
>   
> @@ -961,19 +965,16 @@ int designware_eth_probe(struct udevice *dev)
>   		}
>   	} else
>   #endif
> -	{

This brace shouldn't be deleted, since it's the else clause of the above ifdef

> -#if IS_ENABLED(CONFIG_DM_MDIO)
> -		ret = dw_dm_mdio_init(dev->name, dev);
> -#else
> -		ret = dw_mdio_init(dev->name, dev);
> -#endif
> -		if (ret) {
> -			err = ret;
> -			goto mdio_err;
> -		}
> -		priv->bus = miiphy_get_dev_by_name(dev->name);
> -		priv->dev = dev;
> +
> +	priv->dev = dev;
> +#if !IS_ENABLED(CONFIG_DM_MDIO)
> +	ret = dw_mdio_init(dev->name, dev);
> +	if (ret) {
> +		err = ret;
> +		goto mdio_err;

This is the only user of this label so there's a warning when DM_MDIO is enabled.

I will fix these issues in v2.

--Sean

>   	}
> +	priv->bus = miiphy_get_dev_by_name(dev->name);
> +#endif
>   
>   	ret = dw_phy_init(priv, dev);
>   	debug("%s, ret=%d\n", __func__, ret);
> diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> index cccf9d54e02..3618300f4c5 100644
> --- a/drivers/net/designware.h
> +++ b/drivers/net/designware.h
> @@ -249,6 +249,7 @@ struct dw_eth_dev {
>   	struct mii_dev *bus;
>   };
>   
> +int dw_dm_mdio_bind(struct udevice *dev);
>   int designware_eth_of_to_plat(struct udevice *dev);
>   int designware_eth_probe(struct udevice *dev);
>   extern const struct eth_ops designware_eth_ops;
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index fde4aabbace..cb9de81a819 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -157,6 +157,9 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_meson8b_ids,
>   	.of_to_plat = dwmac_meson8b_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_meson8b_probe,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index 76daab961c0..d95f2111a5b 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -56,6 +56,9 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.id     = UCLASS_ETH,
>   	.of_match = dwmac_s700_ids,
>   	.of_to_plat = dwmac_s700_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe  = dwmac_s700_probe,
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index a55f3e29f9f..64bb2dbfbe3 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -143,6 +143,9 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_socfpga_ids,
>   	.of_to_plat = dwmac_socfpga_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_socfpga_probe,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_thead.c b/drivers/net/dwmac_thead.c
> index 138d71a6202..5843bed49cb 100644
> --- a/drivers/net/dwmac_thead.c
> +++ b/drivers/net/dwmac_thead.c
> @@ -280,6 +280,9 @@ U_BOOT_DRIVER(dwmac_thead) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_thead_match,
>   	.of_to_plat	= dwmac_thead_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_thead_probe,
>   	.ops		= &dwmac_thead_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 2b6080dd9ee..1d21cb2606d 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -790,6 +790,9 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.id	= UCLASS_ETH,
>   	.of_match = rockchip_gmac_ids,
>   	.of_to_plat = gmac_rockchip_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe	= gmac_rockchip_probe,
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> ---
> base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
> branch: dw_mdio_bind
> 


