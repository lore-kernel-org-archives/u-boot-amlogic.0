Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F88C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:55 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
 by mx.groups.io with SMTP id smtpd.web11.11419.1699111387813010586
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Nov 2023 08:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lqQDVwVx;
 spf=pass (domain: gmail.com, ip: 209.85.217.46, mailfrom: seanga2@gmail.com)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-45db0df090eso268977137.3
        for <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699111387; x=1699716187; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8YsGPoM2nP3Oro4YpLc0li5niugDAB0IrtRvzNgb/Q=;
        b=lqQDVwVxaUXCNUhT4bT0PW8I+SyCQMRpSidwqzfE56TFOYQNLCYcH1EJ7cN5aqwVUE
         i6iN+Djjn72XGJLlGFcc9a7y1qvDSxdF7qq6kXEx4zyOiapVIrGiB9HNsH53V+Hix+UO
         VM2xqdWgwtJv+beRigsi6sk9FQ+F8b+74FIpt1Z1u5QlBpZRWaVmhl1R5YQmCXahoIjV
         adQAyOdGsphuDCYJxgOAAdoQrCdsuGABf02j+bj3bZ5PQ2Isg659Vjp0bB0mRq2NE8Mu
         Lo7vtnZRG3xi3Gnriw+M2q2Ycn9j1tn1QGxG8hcCvnKDP1z1W0OYOsuqrsd4izMkSH/V
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699111387; x=1699716187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8YsGPoM2nP3Oro4YpLc0li5niugDAB0IrtRvzNgb/Q=;
        b=uE0YYrZeRcyLSQ/JshZw9kEXhA3FWVLg6K8noturLCCfdIs5U8Kjoe86H+Z/zxDEn4
         eh62hb0DNXq+FEyoQiaNTPkPqsciIFhOTYb5seF1p/VK9XQ6SklBExjmqDQSaF1vKmre
         4KZFcRmlVsQGu3TE2H5Vgk/KtONrqodFQiWbdtNyEe55MOc0d9oBH8TV8DCk/eaRSRMp
         pG7Y9vG+ZUNjZr51hERV92kmkagnai18gGv1Tf7bFPWEu8ugaXbfnASH3uk6OXwOcsEk
         GrsalzLyfTNOwCSiBcky0W1JdJnNv3Qx6n6PN9h6PBWh1DZLv8i2YixqxKggISGWCM13
         mJwA==
X-Gm-Message-State: AOJu0YyJlToZ4Tq/ccdgBVzYAJEzx24e0PvB0lhOAI46KxhsH/SvX5am
	v/rkda1MqWgZQGRfHtCAz6w=
X-Google-Smtp-Source: AGHT+IGEVwLuE1wJ8IUOFTi16FAk+iRReYA53iw/os78VvzWuJAQ1NnVHT7QaRG98zhRxBN3U5mPag==
X-Received: by 2002:a67:cb91:0:b0:45d:9e46:fb50 with SMTP id h17-20020a67cb91000000b0045d9e46fb50mr3001730vsl.10.1699111386575;
        Sat, 04 Nov 2023 08:23:06 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id kh6-20020a056214514600b006714f8b5512sm1727582qvb.6.2023.11.04.08.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 08:23:06 -0700 (PDT)
Message-ID: <81a727a6-599d-c5f8-e85b-9f66012d5e74@gmail.com>
Date: Sat, 4 Nov 2023 11:23:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 6/8] cmd: clk: Use dump function from clk_ops
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
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231102122017.56995-7-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1829

On 11/2/23 08:20, Igor Prusov wrote:
> Add another loop to dump additional info from clock providers that
> implement dump operation.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index c7c379d7a6..4b9709d3ff 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   int __weak soc_clk_dump(void)
>   {
>   	struct udevice *dev;
> +	const struct clk_ops *ops;
>   
>   	printf(" Rate               Usecnt      Name\n");
>   	printf("------------------------------------------\n");
> @@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
>   	uclass_foreach_dev_probe(UCLASS_CLK, dev)
>   		show_clks(dev, -1, 0);
>   
> +	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
> +		ops = dev_get_driver_ops(dev);
> +		if (ops && ops->dump) {
> +			printf("\n%s %s:\n", dev->driver->name, dev->name);
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

Reviewed-by: Sean Anderson <seanga2@gmail.com>

