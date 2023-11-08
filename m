Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE4C4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 12:48:15 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web10.19942.1699462754265246118
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Nov 2023 08:59:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mocY0Oau;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: seanga2@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d33298f8fdso3391395a34.1
        for <u-boot-amlogic@groups.io>; Wed, 08 Nov 2023 08:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699462753; x=1700067553; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnOdKUWWE4zFAKJWidQzEqP0t/m6lENpHeoIBjpMExk=;
        b=mocY0OautmqSaQYkQpjrRA2vSPGIr1/NB1oSEEYUWyJ6hPrCAmk3ZwBjyGWEsgM94p
         mpbY6ARQGllRyLfJfK2n9+TjN3bwxpGSyaznmYln8XY4jnP0CEI6Q2qMEIjZqsSRWD+C
         7wbK3yxW4tr4r6UzOQcXTKnhokaa6WHg0zcqSvz4XFwUOiKCDLrWXgjMxaXme8477AhU
         M6dcSScvFv0Wh3qlyB0DZhdolEUWky1gKi/j2PrdDVghfo2HPeUCl8frEpBqQiFHa0Rb
         upTgKeJ7SuXhVmTJERUjhN3pXE2/2oIumEEVL4/qogJTMJ0/vcVsK5XwNC4puwWDGgtz
         tLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462753; x=1700067553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnOdKUWWE4zFAKJWidQzEqP0t/m6lENpHeoIBjpMExk=;
        b=WUWRWMcaDG3SYop5Pbsa1Z+r0P7HewDEVmNLeOws1aIdkdS78DjPPumDELksgH3fq5
         uPLuFgMaYAuXE2BcqZsjsIdCq0HRWJ5m6OD9x2+/aGYtLgiLzAOt8PrUq32VhhKCySl/
         uUMGpKnX6B4g8dwVwf8RTmPEJLcwERw9HwRvJXiO0BBcn7sjtNQ8h7S+096+1SJ/C2nv
         f94ml9g7kp5Yi3Fikn9d78vGahrXFRsmoMJ8E8QzEgTs/eVUyMcKwE4esJ4+tF4g4AIs
         B8T8BLuqo04hqe9KfZjDj3GStZPOl4zYY21h8D6put3gw9yW/aOuWMT9cvimEBqGa0w2
         +kCw==
X-Gm-Message-State: AOJu0YwVmwJ+ejrmplRIZGzljro1mnudK2tS1H7zRssXYddQZi8kmapl
	JYxbDH6x95X+73naGR8hB4g=
X-Google-Smtp-Source: AGHT+IETEvYweDNabSPYit/y8g1EtPfbXj0e+2RBrbqRDfj8gbZFR7JQQFtUnjhk4bU0jRWqQU4fSw==
X-Received: by 2002:a05:6830:2b21:b0:6be:c1b:ded4 with SMTP id l33-20020a0568302b2100b006be0c1bded4mr2768421otv.3.1699462753555;
        Wed, 08 Nov 2023 08:59:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id kg16-20020a05622a761000b0040331a24f16sm1073339qtb.3.2023.11.08.08.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:59:13 -0800 (PST)
Message-ID: <976548be-3bdd-0655-8bbb-31c7acdbe4be@gmail.com>
Date: Wed, 8 Nov 2023 11:59:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/8] clk: Add dump operation to clk_ops
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
 <20231105083809.3293-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231105083809.3293-6-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Nov 2023 12:48:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1860

On 11/5/23 03:38, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..3419daab34 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>    * @set_parent: Set current clock parent
>    * @enable: Enable a clock.
>    * @disable: Disable a clock.
> + * @dump: Print clock information.
>    *
>    * The individual methods are described more fully below.
>    */
> @@ -39,6 +40,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	void (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */
> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.
> + *
> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + *
> + * Return: zero on success, or -ve error code.

This is no longer correct, but I can remove it when applying.

> + */
> +void dump(struct udevice *dev);
>   #endif
>   
>   #endif

Reviewed-by: Sean Anderson <seanga2@gmail.com>

