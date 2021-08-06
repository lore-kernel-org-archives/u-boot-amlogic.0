Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.2570.1628241897836181324
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Aug 2021 02:24:58 -0700
Received: by mail-wm1-f54.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so5631228wmg.4
        for <u-boot-amlogic@groups.io>; Fri, 06 Aug 2021 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Xo8levsB7uabEcV3nZ0vexg9oqS0Hn9rhmXJ/V6tTak=;
        b=iZh519gWz8uk2fAxpfy97fuPKWlhMLEy6RSoLxMD6OjdxxSJ5mMlu+/7tUp1BY38jb
         4HrCIdcX6zpKPDtgjjXo/1Uin+Y3boRAPibT+eZPPkjVEY6zIaYboiMmFJq41DTgLt/I
         8i7lKaJ7DIm8nYUAeQeq9bWbWledcmfBjPDU0Sbdc+sruq7M3z8Gjp7fCsPcr/l4OAJb
         mcisB1TmFyy28AUb6jGr3LA1QIOu/noXHSm4HovRhFF0y2kFa4mjrgjGkhLHRrymVTyE
         vf2++Refubt510dukRRvixFWDE40JI4i4Yd0xcLFQyV4SQ1S8UiKRDmtqBq+eQdy/fhe
         z5eg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 1/9] configs: meson64: permit redefining SYS_MALLOC_LEN
In-Reply-To: <23fcf0b5-201c-7518-0113-f2397283b344@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-2-mkorpershoek@baylibre.com>
 <c68ec64e-5309-be21-db7b-452c8f01e0f8@baylibre.com>
 <20210805171601.GN858@bill-the-cat>
 <23fcf0b5-201c-7518-0113-f2397283b344@baylibre.com>
Date: Fri, 06 Aug 2021 11:24:54 +0200
Message-ID: <87pmurj57d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom, Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 05/08/2021 19:16, Tom Rini wrote:
>> On Thu, Aug 05, 2021 at 06:20:53PM +0200, Neil Armstrong wrote:
>>> On 05/08/2021 17:17, Mattijs Korpershoek wrote:
>>>> Permit redefining SYS_MALLOC_LEN for board specific configs.
>>>> This is especially useful for Android with AVB, which requires a malloc
>>>> length of 128M.
>>>>
>>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>> ---
>>>>  include/configs/meson64.h | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
>>>> index fb7f16d148..f9bb0240d2 100644
>>>> --- a/include/configs/meson64.h
>>>> +++ b/include/configs/meson64.h
>>>> @@ -32,7 +32,9 @@
>>>>  #define CONFIG_CPU_ARMV8
>>>>  #define CONFIG_REMAKE_ELF
>>>>  #define CONFIG_SYS_MAXARGS		32
>>>> +#ifndef CONFIG_SYS_MALLOC_LEN
>>>>  #define CONFIG_SYS_MALLOC_LEN		(32 << 20)
>>>> +#endif
>>>>  #define CONFIG_SYS_CBSIZE		1024
>>>>  
>>>>  #define CONFIG_SYS_SDRAM_BASE		0
>>>>
>>>
>>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> I prefer to see these as SZ_xxx, but also what's the minimum DRAM you're
>> going to see on a meson64 platform?  And if it's 1GB or more, why not
>> just use 128MB for everyone?
>> 
>
> We can get down to 256MiB DRAM (very rare), but 512MiB is used on La Frite.
In that case, I think it's more reasonable to keep the change as-is.
I'll send a v2 replacing (32 << 20) by SZ_32M

Do you agree ?

Mattijs

>
> Neil
