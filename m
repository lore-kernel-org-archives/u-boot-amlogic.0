Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF1C87FCF
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 15:27:30 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.54636.1754579699470350236
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Aug 2025 08:14:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BqHv81AF;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b792b0b829so913999f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 07 Aug 2025 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754579698; x=1755184498; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NPoBVvBVglgwFwseFIQSlJTjrIPpVM+D9vZtsczBUk=;
        b=BqHv81AFfZU5MsvuJGv4Zg8xc5ypQOnm3VZz6xHrQ6B6iVDGqWj7TR4ejttWXP0i1O
         D2GK5RoUdnzwvK8DS3PBTQxWQfMplifo2dfY0orF5JNT3vFg2AXfTcejUI0CsF7MwNZW
         ZPfLLe7kpa4GTaH9IaRYhOC0RVyxe33V+DsznucpT/C4cb6M56U0aToOVOoky1H0FIAo
         8Ywc9sClhLCexJzZMIkT8kNPzh3bTwl+XJ4yXfrpKtttyhVvZBP0NqEPa8rH1aBoxyPP
         3eVvf1pBHWh9iA/I94z/B23o6KY43TjvTfvMcfJTkvTbI6ZMOjDiYJnXUmtavyZzySN3
         Cvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579698; x=1755184498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NPoBVvBVglgwFwseFIQSlJTjrIPpVM+D9vZtsczBUk=;
        b=YGLbJimJLz2skUGgOIyQyMRswYeQZzE8yjXcFUBclWX1C8+4HpVtxiBiElbhs/OWhc
         vXGLCngKiditN9MrlCm4EUnY/83kHzTaaoyvlBGQIP2LRt+M5QZTtmX2ngK4qXfHhuGI
         7O1HlY/sSp/53SxgDVArvz64FVFbkXyqyBIJjCyU0i0gB07BOs8XJ11UIZGuHoptGKsW
         lt6YYrGcFL6lpzK9x+WewqyvZjO/b/d7YCpPaUMT/l9lUKruUM4QAtOLxikr8pAVE8zP
         ghoDf9wLJPJxj2a9tUMjRuT5tOHuDvognegepx9afC8+1HYw7DcgtUSsK111h9wbGdBt
         8fDQ==
X-Gm-Message-State: AOJu0YzOgwccKKfbBmJfR+Q2kpW/W/h+FWGpAc7yEsv2XcusywKwC+UB
	8bt5thguDiJm2sUsgIXgs4uOd6eCryYe+uI2qC41b7g0jd3XqyWl9fkamaO76KRV0KdE9ZCCCpH
	Phs0HnLs=
X-Gm-Gg: ASbGncvGNBgQMlL8e8ot4h3EXXMgs7UOAQJhR0ApA4gk379Aqn4TLK1ZmWDkSuP/msM
	YjZiBjNkliZghmvnJR9qxZxXjBhycSJBp8hfAXpaSorPcwjQae0JYUq3TtfC5fQ50qb/cm5EJGf
	jpS0KISqG1PiTV03K5qfrWxy+Agcuas8NN4Mh1+aN1FuLcNeOLrDi6oIOsD0pcj7xymVgswSYHm
	kFL/M3rSmnzANCgj/ogmXoDche6iIY4J3NytCET+wFgGUFZByxJAYGhVATNJaXmsgSc4t1EJG7a
	TwGA1pZ/lUg4p1M3A0FPIfY7D5pGEQW1XljKtfdETpwwQ9zosfJ8WkSpvp2zobsWU1e2IlT5zgp
	hmtyTDuBvWQ3lBqF9XqlCXxRQAmB9vCa10mUERpGAwzIXzq7cZXGxbbfzkMKPmAD5A+oCkN7GpV
	Vynw==
X-Google-Smtp-Source: AGHT+IEgeXGFqt/8N7ZVklBT55xfGRgC+GqfqTENQ9uCNgz/8aJqMRq2oPSMRfukR28VamzIgD/dKw==
X-Received: by 2002:a05:6000:2d0b:b0:3b8:f8e5:f6be with SMTP id ffacd0b85a97d-3b8f8e5f822mr2780159f8f.4.1754579227916;
        Thu, 07 Aug 2025 08:07:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf? ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9eddsm27059428f8f.22.2025.08.07.08.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 08:07:07 -0700 (PDT)
Message-ID: <e70bf33e-49a8-4141-8a1e-a7a6c6d73375@linaro.org>
Date: Thu, 7 Aug 2025 16:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
 <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 07 Aug 2025 15:27:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2733

On 24/07/2025 09:30, Neil Armstrong wrote:
> On 22/07/2025 16:06, Andrew Goodbody wrote:
>> timeout is declared as a uint but then tested for being less than zero
>> which must always fail. Change the while loop for a pre-decrement on
>> timeout and test timeout for being zero.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/adc/meson-saradc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
>> index 60e348968fb..0144ff828c5 100644
>> --- a/drivers/adc/meson-saradc.c
>> +++ b/drivers/adc/meson-saradc.c
>> @@ -205,9 +205,9 @@ static int meson_saradc_lock(struct 
>> meson_saradc_priv *priv)
>>       do {
>>           udelay(1);
>>           regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
>> -    } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
>> +    } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
>> -    if (timeout < 0) {
>> +    if (!timeout) {
>>           printf("Timeout while waiting for BL30 unlock\n");
>>           return -ETIMEDOUT;
>>       }
>> @@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct 
>> meson_saradc_priv *priv)
>>       do {
>>           udelay(1);
>>           regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>> -    } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && 
>> timeout--);
>> +    } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && -- 
>> timeout);
>> -    if (timeout < 0)
>> +    if (!timeout)
>>           return -ETIMEDOUT;
>>       return 0;
>>
>> ---
>> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
>> change-id: 20250722-meson_saradc-4bba9dc18333
>>
>> Best regards,
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Is there anything else needed before this can be merged please?

Thanks,
Andrew

