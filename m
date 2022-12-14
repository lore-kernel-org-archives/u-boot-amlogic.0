Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.106108.1671029593830757497
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Dec 2022 06:53:14 -0800
Received: by mail-wm1-f52.google.com with SMTP id bg10so11500141wmb.1
        for <u-boot-amlogic@groups.io>; Wed, 14 Dec 2022 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LIUhfNlEf4iclXcxjBnVvcXRGRJsMRfrbr2CuapK7iU=;
        b=FklnKIwjuEPwRPgiEu1ClAQq57pH9WaoWMzAtYXRv4sTuQpIkHf667QqoCFC9rHq31
         KFtTKr2QV2k854fSXZW+lpWg1T1fWQfYPAUHOfQRAgrBgYHQU1LRdPR2iOct1C1qBfyl
         FZJNooiB3++aZTozlwNEnhY/vLrv5lfTmqHTIiGtC0XuPllcmWWlI2sbynsrF/URedDY
         ooJBc6TCz6vtTD1DEI0WkaquvwMka9Fdy1nFEjfvB9CjxxP9qnN88r1mcw1/TmFvp3TQ
         rRDx4jv2HOzsb15Y/UE8bLjHeFzFu0bbwa5EPrg/qVv6ObL/BXlYPCCJwq0ZCYcc2/bT
         yWEA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <6a7da2a9-3f7b-cce2-62c8-5584c6b6940a@linaro.org>
Date: Wed, 14 Dec 2022 15:53:11 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/3] asm/arch-meson: add missing meson_sm_write_efuse signature
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
 <20221213183129.75915-2-avromanov@sberdevices.ru>
 <CAPnjgZ2CEz=L=cAstFYOszMxDN8FZ3UmG2UQ-=8GY4913ogGLw@mail.gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <CAPnjgZ2CEz=L=cAstFYOszMxDN8FZ3UmG2UQ-=8GY4913ogGLw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, sjg@chromium.org, Alexey Romanov <avromanov@sberdevices.ru>
Cc: narmstrong@baylibre.com, trini@konsulko.com, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 14/12/2022 05:39, Simon Glass wrote:
> Hi Alexey,
> 
> On Tue, 13 Dec 2022 at 10:32, Alexey Romanov <avromanov@sberdevices.ru> wrote:
>>
>> This function can be used by other modules.
>>
>> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>> ---
>>   arch/arm/include/asm/arch-meson/sm.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
>> index f3ae46a6d6b..b68edf842e4 100644
>> --- a/arch/arm/include/asm/arch-meson/sm.h
>> +++ b/arch/arm/include/asm/arch-meson/sm.h
>> @@ -8,6 +8,8 @@
>>
>>   ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
>>
>> +ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
>> +
>>   #define SM_SERIAL_SIZE 12
>>
>>   int meson_sm_get_serial(void *buffer, size_t size);
>> --
>> 2.25.1
>>
> 
> Should add function comments.
> 
> Also, you might consider adding a uclass for this. It seems like an
> important use case that is not handled right now.

An NVMEM uclass would be a great addition, but for the scope of this
change it can be done later.

Neil

> 
> Regards,
> Simon
> 
> 
> 
> 
> 

