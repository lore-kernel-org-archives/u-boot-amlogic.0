Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA88CF5366
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:51 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web11.7737.1729639186497549117
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 16:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=jsSiE/Lg;
 spf=pass (domain: samsung.com, ip: 203.254.224.24, mailfrom: jh80.chung@samsung.com)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241022231943epoutp01a98bd66aa14220a26053bb214b28705e~A6ax-imWy2091320913epoutp01d
	for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 23:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241022231943epoutp01a98bd66aa14220a26053bb214b28705e~A6ax-imWy2091320913epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729639184;
	bh=fHPbkkP8Xx4AiWRCbKUBveD5ecYvsKnq332pQMxgALc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jsSiE/LgQAJ7fRaXsBqvUXsw8ZGt86RsHyrKy1HECufjuKwgPxbGf23DQqsFyiE0W
	 xaaz+bGrommvzJsTe4goWRnJmOBlFmfpvvAc2p3z69dbc0JgNJbt8CdBHEshoQLQZu
	 otpcFqyZEVAv9hldVuRe8ZNZNlwW3Lb7JzgHtwBo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241022231943epcas1p1e43c1dcc6a178be3c617c0401e0f474d~A6axweJnK2907029070epcas1p1g;
	Tue, 22 Oct 2024 23:19:43 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.236]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XY7Rz0pBwz4x9Pr; Tue, 22 Oct
	2024 23:19:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.DE.08588.E0338176; Wed, 23 Oct 2024 08:19:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241022231942epcas1p255b192ff6aafb41cfa814e0371a0442f~A6awr_Ezz3119731197epcas1p2Y;
	Tue, 22 Oct 2024 23:19:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241022231942epsmtrp2098eb867066d9a723aaa266f0e639d1e~A6awrSFDn2889328893epsmtrp2Q;
	Tue, 22 Oct 2024 23:19:42 +0000 (GMT)
X-AuditID: b6c32a33-a57ff7000000218c-20-6718330ecd41
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.24.18937.E0338176; Wed, 23 Oct 2024 08:19:42 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241022231942epsmtip26bcd8031fb525f0bb0ed9d51ffe34e20~A6awdSDYK0336903369epsmtip2D;
	Tue, 22 Oct 2024 23:19:42 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Neil Armstrong'" <neil.armstrong@linaro.org>, "'Lukasz Majewski'"
	<lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>, "'Tom	Rini'"
	<trini@konsulko.com>
Cc: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-2-2479cd90c4ea@linaro.org>
Subject: Re: [PATCH 2/2] power/domain: meson-ee-pwrc: make sure to not enable a domain twice
Date: Wed, 23 Oct 2024 08:19:42 +0900
Message-ID: <0a5d01db24d8$dfc35d20$9f4a1760$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZooCD0Z+HE1POGi0+j9asZBb/QAHDKIwfAumZL/uycQaLUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmgS6fsUS6we41NhbP311msni/8xaj
	xdZ7E5gspk7azG4xacIvNou3ezvZHdg85s06weKxc9Zddo/5nd+ZPF4dWMXucefaHjaPs3d2
	MAawRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
	oaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIF
	KkzIztjT0cNacF+oouPPJaYGxs38XYycHBICJhLv57YzdzFycQgJ7GCUuPn5OSOE84lRouHc
	MnY4Z8uX9awwLSeWHmeCSOxklNj58g0LhPOSUWLRyz1MIFVsAnoS/xctBBssIrCUUeL74dtA
	szg4mAXMJNbeDwUxOQW8JF43y4KUCwvESUyf8pEZxGYRUJX4snYlO4jNK2Ap8XrvVDaIxQoS
	P58uAzuCWUBEYnZnG1i9iICTxOEvJ1ggal6yS/QcloawXST+3TjKCGELS7w6voUdwpaS+Pxu
	LxvIaRICzYwSS5ccZIVwehgl/jVch9pmLLF/6WQmiJs1Jdbv0odYzCfx7msPK0hYQoBXoqNN
	CKJaReLS65dMMPPvPvkPDSwPiblzXkED6y6jROvRGawTGOVnIflhFsKGBYxMqxjFUguKc9NT
	kw0LDOFRmZyfu4kRnAC1jHcwXp7/T+8QIxMH4yFGCQ5mJRFepRLRdCHelMTKqtSi/Pii0pzU
	4kOMpsCQnMgsJZqcD0zBeSXxhiaWBiZmRsYmFoZmhkrivGeulKUKCaQnlqRmp6YWpBbB9DFx
	cEo1MOkIaiQuM1A/46d+IvtdRvC5Y2s2Wkgw/Wj7vmrxpDfnpZbU7F65earkzV7te98ub4/w
	nHwlj20X49JdolM7XX1FArLnO6WpBhjmps9PiT9z7u80Rub1FbvSFDo+au6oLkkRavr75W3E
	Z6njlslvdkqrsXnnab1Q2fypWOjlPYuC79sUrtw+yrnVxd6hX3zqwfxpIfEZnC5O0Xr79Ly2
	vuZ6Gd+x3WmiJYMO6+o16gdZ0mcsz7Uu7Tn15u/KdpPOzO1eysE3j7du2Mpt5iL2J9ugqCjz
	2JIA6fVPNWb/lc+fxDPHcgrz7Sv3Pi70/LN/xTdr339Jc6eqT8syfV7xh2HbPv+QD/o7PNXy
	7S4aBCqxFGckGmoxFxUnAgClhlPiCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSvC6fsUS6QdtvGYvn7y4zWbzfeYvR
	Yuu9CUwWUydtZreYNOEXm8XbvZ3sDmwe82adYPHYOesuu8f8zu9MHq8OrGL3uHNtD5vH2Ts7
	GAPYorhsUlJzMstSi/TtErgy9nT0sBbcF6ro+HOJqYFxM38XIyeHhICJxImlx5m6GLk4hAS2
	M0qsajnMBJGQkvj8dCpbFyMHkC0scfhwMUTNc0aJ9o+z2EFq2AT0JP4vWsgMkhARWM4oMfP3
	Y7BmZgELicdru1ggOm4ySly5/p8dZBKngJfE62ZZkBphgRiJ5yvbwQaxCKhKfFm7EszmFbCU
	eL0XZDHIEQoSP58uY4WYKSIxu7ONGcQWEXCSOPzlBMsERoFZSFILGBlXMYqmFhTnpucmFxjq
	FSfmFpfmpesl5+duYgQHrlbQDsZl6//qHWJk4mA8xCjBwawkwqtUIpouxJuSWFmVWpQfX1Sa
	k1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwLT3bWd9wnX/SefYpzz4+eVN4ReT
	JMdJie03n700WZhkVtlzLdD1xqtJ25tFhA9NOFL0fIfImiBuNsGzllyb7y2I1WO1PvlUiU2S
	8U5m2QT/5Zonqw+qHtIxVysq2ROWunPeGn59rjxG5ePBnfIvVE4/3sUqWnNkx2k7JaYnv5Ou
	3J3j/KXtZyd774y5+2Qq9vP/NnsZX8Fg8W5R15cmhXMcc1d/KT4kNO2l54nFLm8OWlwyZzul
	yMTsvXK3dm2I7+KZfGIB13Ivduk/PfF9Y1pezZv58rM2KPwof/v9bUD97rwlZ79d//2XOei0
	wZVGzh+ycg8/7z9m/y1l2zGT5ke3HvFknn2hfn9SpczyGHt2JZbijERDLeai4kQAviJoWMsC
	AAA=
X-CMS-MailID: 20241022231942epcas1p255b192ff6aafb41cfa814e0371a0442f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241009091530epcas1p4304cc6217522cc7be5016af25b4e72f0
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
	<CGME20241009091530epcas1p4304cc6217522cc7be5016af25b4e72f0@epcas1p4.samsung.com>
	<20241009-u-boot-topic-fix-hdmi-v1-2-2479cd90c4ea@linaro.org>
Content-Language: ko
Content-Type: text/plain; charset="utf-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 23 Oct 2024 12:18:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2528



> -----Original Message-----
> From: Neil Armstrong <neil.armstrong@linaro.org>
> Sent: Wednesday, October 9, 2024 6:15 PM
> To: Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Tom Rini <trini@konsulko.com>;
> Jaehoon Chung <jh80.chung@samsung.com>
> Cc: u-boot-amlogic@groups.io; u-boot@lists.denx.de; Neil Armstrong <neil.armstrong@linaro.org>
> Subject: [PATCH 2/2] power/domain: meson-ee-pwrc: make sure to not enable a domain twice
>
> The upstream Device Tree for GXBB/GXL/G12A was updated with VPU domain
> shared between the VPU and HDMI node, causing a double enable.
>
> Simply store the enable state and avoid enabling twice, fixing
> HDMI output on all platforms.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/domain/meson-ee-pwrc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
> index 20e9f32b381..4d9f3bba644 100644
> --- a/drivers/power/domain/meson-ee-pwrc.c
> +++ b/drivers/power/domain/meson-ee-pwrc.c
> @@ -60,6 +60,7 @@ struct meson_ee_pwrc_domain_desc {
>  	unsigned int mem_pd_count;
>  	struct meson_ee_pwrc_mem_domain *mem_pd;
>  	bool (*get_power)(struct power_domain *power_domain);
> +	bool enabled;
>  };
>
>  struct meson_ee_pwrc_domain_data {
> @@ -306,6 +307,8 @@ static int meson_ee_pwrc_off(struct power_domain *power_domain)
>  		clk_disable_bulk(&priv->clks);
>  	}
>
> +	pwrc_domain->enabled = false;
> +
>  	return 0;
>  }
>
> @@ -317,6 +320,9 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
>
>  	pwrc_domain = &priv->data->domains[power_domain->id];
>
> +	if (pwrc_domain->enabled)
> +		return 0;
> +
>  	if (pwrc_domain->top_pd)
>  		regmap_update_bits(priv->regmap_ao,
>  				   pwrc_domain->top_pd->sleep_reg,
> @@ -347,8 +353,13 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
>  			return ret;
>  	}
>
> -	if (pwrc_domain->clk_names_count)
> -		return clk_enable_bulk(&priv->clks);
> +	if (pwrc_domain->clk_names_count) {
> +		ret = clk_enable_bulk(&priv->clks);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pwrc_domain->enabled = true;
>
>  	return 0;
>  }
>
> --
> 2.34.1




