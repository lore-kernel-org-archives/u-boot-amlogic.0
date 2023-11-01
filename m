Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17BC4167B
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:35 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.13353.1698858733325614555
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 10:12:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M1xSJj3w;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: seanga2@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so9764726d6.0
        for <u-boot-amlogic@groups.io>; Wed, 01 Nov 2023 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858732; x=1699463532; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRuxvJsK/N1oREgCV2uD8VdTs3lvdBwA54CvH8KsMlU=;
        b=M1xSJj3wkTBV/+Allrs3Y7aKikxDd1/I5xkuwh9a3pKrG3a41zQGhSJypJ+7CywIak
         bO9ZtTHj9CRwJuTu5KdzsW2T7NpHNPcCIPO9twGmB7VxnW7xs8Gh+a57MA4hWtgIF1h+
         jpr+9Ltm3kopFfAh9Kg1+Rx3ztA/Ygytl3GtEMq8C4nG2of0+gXU1STUJvrqpOhDYdST
         0Yc71+zgLMgHDrIWWN71/m1AW7hCvcsovAyRckSfYenLfT0B6nrJMW9aGILPoFhWSCti
         SD02m0x0SKno/arduT6fmjLTwhHItLXB/lv9ZDPG0x6tJsV38F6ecf37t37bi7kUf32M
         u8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858732; x=1699463532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRuxvJsK/N1oREgCV2uD8VdTs3lvdBwA54CvH8KsMlU=;
        b=GvkK+4dbH6QDkQ/I026KcFQWyh28pgVCBvxD7bXy1jd05lQZ36t6T/GpJwMPsT/+YE
         B06fFzkQ1HnXjUpFe5wmxLA8dqP+pu5DbKgJuqLM8kfplvZ1qe14PqXIyvsYBQ8rcA0E
         mOLa9pGPqtkaMrJSMdG7d1/KjgibzhibliBFBnmkHZz9kjHzy9HqrtB2e4nqCn/ColvM
         HXbBx4UkliEULxM2JNywDffLEHJNGiQ849M/HDb2ZXhS0ifaSOLUQPbaqN6KplBsavr3
         p3ybM83RKItgsaGZqxZmpqoQnLWt6RP4fmZ+6mTTUG8xBDvuz+rMNvgTzGOnjvo+v+vs
         rcgA==
X-Gm-Message-State: AOJu0Yy/FiPz7hx/gxGu9evg46UO05t7XSB0DSLBX6Eis9RH+/Nsp73w
	gz3s9fjSBefr2xxLM83WxN0=
X-Google-Smtp-Source: AGHT+IEh9pcDdj7MSOdioIiR+CHysM01noGu3l8//+J+dTQNeFosR4AJLog5PEU1ITw+Aw2h9Wcy5Q==
X-Received: by 2002:a05:6214:5c6:b0:66f:ac56:fb9b with SMTP id t6-20020a05621405c600b0066fac56fb9bmr4718605qvz.22.1698858732348;
        Wed, 01 Nov 2023 10:12:12 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id cp13-20020ad44aed000000b0066d32666a20sm1651513qvb.71.2023.11.01.10.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:12:12 -0700 (PDT)
Message-ID: <d4bc9fbc-d8de-0a72-d8cd-c54dcf5a4d5e@gmail.com>
Date: Wed, 1 Nov 2023 13:12:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/8] clk: k210: Move soc_clk_dump function
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-4-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-4-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1826

On 10/17/23 12:56, Igor Prusov wrote:
> Move clock dump function to avoid forward declaration after switching to
> dump in clk_ops.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   drivers/clk/clk_k210.c | 92 +++++++++++++++++++++---------------------
>   1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
> index c534cc07e0..2f17152021 100644
> --- a/drivers/clk/clk_k210.c
> +++ b/drivers/clk/clk_k210.c
> @@ -1238,52 +1238,6 @@ static int k210_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static const struct clk_ops k210_clk_ops = {
> -	.request = k210_clk_request,
> -	.set_rate = k210_clk_set_rate,
> -	.get_rate = k210_clk_get_rate,
> -	.set_parent = k210_clk_set_parent,
> -	.enable = k210_clk_enable,
> -	.disable = k210_clk_disable,
> -};
> -
> -static int k210_clk_probe(struct udevice *dev)
> -{
> -	int ret;
> -	struct k210_clk_priv *priv = dev_get_priv(dev);
> -
> -	priv->base = dev_read_addr_ptr(dev_get_parent(dev));
> -	if (!priv->base)
> -		return -EINVAL;
> -
> -	ret = clk_get_by_index(dev, 0, &priv->in0);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Force setting defaults, even before relocation. This is so we can
> -	 * set the clock rate for PLL1 before we relocate into aisram.
> -	 */
> -	if (!(gd->flags & GD_FLG_RELOC))
> -		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
> -
> -	return 0;
> -}
> -
> -static const struct udevice_id k210_clk_ids[] = {
> -	{ .compatible = "canaan,k210-clk" },
> -	{ },
> -};
> -
> -U_BOOT_DRIVER(k210_clk) = {
> -	.name = "k210_clk",
> -	.id = UCLASS_CLK,
> -	.of_match = k210_clk_ids,
> -	.ops = &k210_clk_ops,
> -	.probe = k210_clk_probe,
> -	.priv_auto = sizeof(struct k210_clk_priv),
> -};
> -
>   #if IS_ENABLED(CONFIG_CMD_CLK)
>   static char show_enabled(struct k210_clk_priv *priv, int id)
>   {
> @@ -1342,3 +1296,49 @@ int soc_clk_dump(void)
>   	return 0;
>   }
>   #endif
> +
> +static const struct clk_ops k210_clk_ops = {
> +	.request = k210_clk_request,
> +	.set_rate = k210_clk_set_rate,
> +	.get_rate = k210_clk_get_rate,
> +	.set_parent = k210_clk_set_parent,
> +	.enable = k210_clk_enable,
> +	.disable = k210_clk_disable,
> +};
> +
> +static int k210_clk_probe(struct udevice *dev)
> +{
> +	int ret;
> +	struct k210_clk_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr_ptr(dev_get_parent(dev));
> +	if (!priv->base)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_index(dev, 0, &priv->in0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Force setting defaults, even before relocation. This is so we can
> +	 * set the clock rate for PLL1 before we relocate into aisram.
> +	 */
> +	if (!(gd->flags & GD_FLG_RELOC))
> +		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id k210_clk_ids[] = {
> +	{ .compatible = "canaan,k210-clk" },
> +	{ },
> +};
> +
> +U_BOOT_DRIVER(k210_clk) = {
> +	.name = "k210_clk",
> +	.id = UCLASS_CLK,
> +	.of_match = k210_clk_ids,
> +	.ops = &k210_clk_ops,
> +	.probe = k210_clk_probe,
> +	.priv_auto = sizeof(struct k210_clk_priv),
> +};

Reviewed-by: Sean Anderson <seanga2@gmail.com>

