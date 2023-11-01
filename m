Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E2C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:25 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.13386.1698858816545699204
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 10:13:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W3ICIzqX;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: seanga2@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-66d87554434so289806d6.2
        for <u-boot-amlogic@groups.io>; Wed, 01 Nov 2023 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858815; x=1699463615; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqi4oQ+fI2HNFKzlptsGyxi9hbC2jIZhMA5wcmrHsoQ=;
        b=W3ICIzqX41s2XX8ZUP5fIH6MyCqgo9NkYL6tAcoNd5HAwGamTSvAu61A9U6ECYB358
         1OH8tWbRy/dmW8YrNTPCvMpgyaZDaAZB3LoojTe92o8/NLDB9Sw5N4Hh6S/BKkweGkXo
         i0y9jDhoZ/sgxllQhiqTOLuP/EU2vYb0fEJsI6s3H6Fg/eSKRO0+K6mhvtpC1DD/r7UL
         F6dVoO8NSquOEBgZ0IdjRx4o+0WVlOaLAj741KLq5qM77EP8b/ZgezQX87HIibx/DiB3
         cQ/fci6sufUKncNTG5vGs1rkC1nn2Cted0iySRt7EKXY9alZHnc//vVVDI7gDxnOmPKV
         M6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858815; x=1699463615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqi4oQ+fI2HNFKzlptsGyxi9hbC2jIZhMA5wcmrHsoQ=;
        b=XOeW7SvWRmsBrc2HnZlx3l7iuJOGvLwaRA+vbTxGg61BJUHwR03cb4layAQfFQxtbh
         zVVt7/48i4pXy6zt1m+qJsQ3gS2q4izxPlX6oUZNlljkHC8/7nchf6LqQkYAMuCGgFgH
         g/oGww7NqrBfQTL+ouuG5/kcrNLqfZHJN8AKlsc9Bw5VpvuZzxSbIL5HZ2bdwzAmj2ad
         tkUjUuxBi7SRBnjcQR/75U5EHik/K197nNvJeCURwJUdvditWMq8MJ8aTUI1T8NfiraK
         rsp06HhQBOuA0q6BFqj5tkq01ccvblQON2X8AX4Hzli8ObTh4Blj4ymWv0cLACNX1no4
         0GCA==
X-Gm-Message-State: AOJu0Yy0xPBQu2FjoDW26/btq5E2O+lIHwNTYKrLVgmrBLBwkNDdTOzk
	Hxbi4PptoSn6104by8FJ66gQhB5UGhYbJQ==
X-Google-Smtp-Source: AGHT+IGHTaoPYy1sfNIp6lRmI0gwb4rtmaiCOcvnjY2OuzNdqXRENpd+VDbjAaPGKw6sRY+htU4aqg==
X-Received: by 2002:a05:6214:194f:b0:66d:237d:8f75 with SMTP id q15-20020a056214194f00b0066d237d8f75mr20820368qvk.35.1698858815620;
        Wed, 01 Nov 2023 10:13:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id t14-20020a0cea2e000000b00655e428604esm1631933qvp.137.2023.11.01.10.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:13:35 -0700 (PDT)
Message-ID: <5d13035b-2f8d-a2cf-5150-99eed7e5bcf5@gmail.com>
Date: Wed, 1 Nov 2023 13:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 8/8] cmd: clk: Make soc_clk_dump static
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
 <20231017165649.1492-9-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-9-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1824

On 10/17/23 12:56, Igor Prusov wrote:
> After introducing dump to clk_ops there is no need to override or expose
> this symbol anymore.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c     | 4 ++--
>   include/clk.h | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index 90cc6fa906..f55911db7a 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -59,7 +59,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   	}
>   }
>   
> -int __weak soc_clk_dump(void)
> +static int soc_clk_dump(void)
>   {
>   	struct udevice *dev;
>   	const struct clk_ops *ops;
> @@ -81,7 +81,7 @@ int __weak soc_clk_dump(void)
>   	return 0;
>   }
>   #else
> -int __weak soc_clk_dump(void)
> +static int soc_clk_dump(void)
>   {
>   	puts("Not implemented\n");
>   	return 1;
> diff --git a/include/clk.h b/include/clk.h
> index d91285235f..bf0d9c9d7f 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -674,8 +674,6 @@ static inline bool clk_valid(struct clk *clk)
>   	return clk && !!clk->dev;
>   }
>   
> -int soc_clk_dump(void);
> -
>   #endif
>   
>   #define clk_prepare_enable(clk) clk_enable(clk)

Reviewed-by: Sean Anderson <seanga2@gmail.com>

