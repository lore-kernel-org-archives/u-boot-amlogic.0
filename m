Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.1998.1628236453081882763
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Aug 2021 00:54:13 -0700
Received: by mail-wr1-f54.google.com with SMTP id n12so9906846wrr.2
        for <u-boot-amlogic@groups.io>; Fri, 06 Aug 2021 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qrECyKRzL8W8WwU96T7DWkPX+hlkMsYt0s0nVMIpEs=;
        b=O2bqWDjMUNleSnfeTgoWSX/8z5QBWHlaMMnQa5+2ev6GS443VvxNe70gvrJaTqdRHv
         eqR2IafsDJpbfHJ8nBcObScBbNqcvA6lbErSIk/ohSwN55cIbWcSieWPNwNtipWc4bhS
         lOIDfS3E/0o1p+2VqUg0uJ3TxAADix9sOO3XXJheJyRN6zHbTfD/TYYWLmyraEJRficc
         ipoaZp9PqgOaY5MKu2FZDE5GeW/r/2zAC1vNWr3oPwu42yJaAgaW0V0fJEFcFVN8ulww
         qoNf5J/DGoCglyZjxBWe/+G4MaSf/9JDwrIiTJudTI0sEsDYJWqGRIGtVDgqJvPrYbdx
         ZWDA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/9] configs: meson64: permit redefining SYS_MALLOC_LEN
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-2-mkorpershoek@baylibre.com>
 <c68ec64e-5309-be21-db7b-452c8f01e0f8@baylibre.com>
 <20210805171601.GN858@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <23fcf0b5-201c-7518-0113-f2397283b344@baylibre.com>
Date: Fri, 6 Aug 2021 09:54:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210805171601.GN858@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 19:16, Tom Rini wrote:
> On Thu, Aug 05, 2021 at 06:20:53PM +0200, Neil Armstrong wrote:
>> On 05/08/2021 17:17, Mattijs Korpershoek wrote:
>>> Permit redefining SYS_MALLOC_LEN for board specific configs.
>>> This is especially useful for Android with AVB, which requires a malloc
>>> length of 128M.
>>>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> ---
>>>  include/configs/meson64.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
>>> index fb7f16d148..f9bb0240d2 100644
>>> --- a/include/configs/meson64.h
>>> +++ b/include/configs/meson64.h
>>> @@ -32,7 +32,9 @@
>>>  #define CONFIG_CPU_ARMV8
>>>  #define CONFIG_REMAKE_ELF
>>>  #define CONFIG_SYS_MAXARGS		32
>>> +#ifndef CONFIG_SYS_MALLOC_LEN
>>>  #define CONFIG_SYS_MALLOC_LEN		(32 << 20)
>>> +#endif
>>>  #define CONFIG_SYS_CBSIZE		1024
>>>  
>>>  #define CONFIG_SYS_SDRAM_BASE		0
>>>
>>
>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I prefer to see these as SZ_xxx, but also what's the minimum DRAM you're
> going to see on a meson64 platform?  And if it's 1GB or more, why not
> just use 128MB for everyone?
> 

We can get down to 256MiB DRAM (very rare), but 512MiB is used on La Frite.

Neil
