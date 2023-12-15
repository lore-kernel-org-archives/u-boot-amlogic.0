Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5288C46CD2
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:43 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.77235.1702673474304142739
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Dec 2023 12:51:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KszuVCj8;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: seanga2@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-425c9cd7dd2so6855271cf.2
        for <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702673473; x=1703278273; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPhRiiZb6KtBM+Tdst055w3ClspZmou2qDYxHA/ur2c=;
        b=KszuVCj8+hxFxAWE0ESW3OQ3uaQP1D9Xq+W3r2tR2Etyw3AQP4NW5NxSKyfgitgDkg
         HZ1buVX/wc14SlpaYu6CYjzvwG/00KYBYVRAwLoW25ipymMxfMKZdcUSkxXv5DEf+0lJ
         So63UyWsGWTI72k9FTwniYitsy+Kjvdl9/N0OjYJv5RRRpE7K1TuLPoh2NgL3bZWWJWz
         2rTMvjN++st9lCne6M2LWyMDhAU3/cRHs3YFN33m4Y+/FW+ycOArk09K54qdAokblmGm
         hIu8wLVidI6q5ycBUizJ6UdOC0cXWc+S8nMsno/5NKCfctL1WVoeRioiXXsLSbw2fIHD
         SovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673473; x=1703278273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPhRiiZb6KtBM+Tdst055w3ClspZmou2qDYxHA/ur2c=;
        b=Dkb8iXOjAjziKJvg/S6zNK4CZlxf7gyu1dGH4SEautEO7ffQzX37cJSRgawNhWRhrE
         2UfR4nZ4APufYY04I15Abp3eKmDc0gLAx2OkjzqyjxPxFftM+1Qwf+7/KFUUTCqlt6B7
         wZ05EzK/ZfPt39whIaTw9nfMhljOR2pc5VrE/CCLdSWOSeT2zXBGcMe7wirYi4rOgRZV
         JmVYeuyHpcahl40GdB/mUPZbJaRvU0TGFZu62+mlYzRAAd1R29LFWgkeYk/x5P2LZJ5c
         ePree0e3Iuxd5ANHuDLfCJijHIrX93e4jZxdGm/UMcIzGsIgwz4ZvjxgtyPB/SLws5yq
         oXjg==
X-Gm-Message-State: AOJu0YycO1bZ9WdQ5GQAj2+olJOWrmagA6M0u/OTzzDs0QNmLzhQoI6H
	7Z8Efsh+JwgCEY1+Vy1Sl4g=
X-Google-Smtp-Source: AGHT+IFw0NwFijMYNMW9kuTFt7bRVkLtNGv4jeDQ5jkUJ852sXkmGnAkaL9AbRCful56bmXbC5avUg==
X-Received: by 2002:a0c:e851:0:b0:67e:f034:d540 with SMTP id l17-20020a0ce851000000b0067ef034d540mr5729445qvo.84.1702673473347;
        Fri, 15 Dec 2023 12:51:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id u3-20020a0cf883000000b0067eec0ef4b7sm2225716qvn.66.2023.12.15.12.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:51:12 -0800 (PST)
Message-ID: <eea5dfe6-ca73-adb9-3f46-fe4ef0d8b64b@gmail.com>
Date: Fri, 15 Dec 2023 15:51:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 5/8] clk: Add dump operation to clk_ops
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
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
 <20231109105516.24892-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231109105516.24892-6-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1942

On 11/9/23 05:55, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   include/clk-uclass.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..f10dd213ff 100644
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
> @@ -135,6 +139,15 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.

The correct member here is @dev. I fixed this when applying.

--Sean

> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + */
> +void dump(struct udevice *dev);
>   #endif
>   
>   #endif


