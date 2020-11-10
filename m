Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web09.25047.1604995682010334183
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Nov 2020 00:08:02 -0800
Received: by mail-wr1-f65.google.com with SMTP id p1so11600877wrf.12
        for <u-boot-amlogic@groups.io>; Tue, 10 Nov 2020 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XhIjCxvWZXcRMtkUBH00zusIGE2NeNWT81/0ykJaPg=;
        b=BB4EPNA6L6X8mgq++O9WoektrzUucLsr997CaGIC6zYT8ulVr8y/NweTrccq2lam3O
         HGDZzAYH8oPhqBYG+pQG2UZIoPXUsIWM9KtS2tv1b4fb73mDQNQxLzS6D55igPLZMq/6
         RPc3PvCC21jps43ZY7uf3d99eoVWXPmKQb4N/c71jJ4+FwvNDzv4mW+JqGAxoFhAx9Ko
         5TsLQdFiavC+8TCzP6rzgSAf+QQestRt858xLnb5n2glzY0JUahY9eHVlqb2kIBDEWg0
         wZAk9fxurKywOX7ks91j6otuzlrwwJkr41s4jkCBzIqSd0jXLUVIIIV6y8MISFegSYbb
         mHKQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com>
 <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
 <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
 <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
 <4948303b-681e-785e-8e85-f4be8bb5074c@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <92cad952-f3d3-7616-a494-4f376ade959c@baylibre.com>
Date: Tue, 10 Nov 2020 09:05:48 +0100
MIME-Version: 1.0
In-Reply-To: <4948303b-681e-785e-8e85-f4be8bb5074c@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 09/11/2020 23:19, Jaehoon Chung wrote:
> On 11/9/20 11:23 PM, Neil Armstrong wrote:
>> On 09/11/2020 15:10, Mark Kettenis wrote:
>>>> From: Neil Armstrong <narmstrong@baylibre.com>
>>>> Date: Mon, 9 Nov 2020 14:37:09 +0100
>>>>
>>>> Hi,
>>>>
>>>> On 09/11/2020 04:12, Jaehoon Chung wrote:
>>>>> Core clock phase value is changed from 180' to 270'.
>>>>> It's more stable than before.
>>>>> - Odroidn-N2/C4 : Working fine with 52MHz
>>>>> - VIM3 : Working fine with 52MHz
>>>>>
>>>>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> ---
>>>>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>>>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>>>> index 719dd1e5e570..7c60e0566560 100644
>>>>> --- a/drivers/mmc/meson_gx_mmc.c
>>>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>>>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>>>  	}
>>>>>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>>>  
>>>>> -	/* 180 phase core clock */
>>>>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>>>> -
>>>>> -	/* 180 phase tx clock */
>>>>> +	/*
>>>>> +	 * Clock Phase needs to set a proper value.
>>>>> +	 * It can be changed to other value.
>>>>> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
>>>>> +	 * set to them by default.
>>>>> +	 */
>>>>> +	/* Core Clock Phase */
>>>>> +	meson_mmc_clk |= CLK_CO_PHASE_270;
>>>>> +
>>>>> +	/* TX Clock Phase */
>>>>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>>>>  
>>>>>  	/* clock settings */
>>>>>
>>>>
>>>> The previous values were aligned on the Linux driver, which is functional.
>>>
>>> Actually the Linux driver isn't really functional; the 52 MHz
>>> high-speed mode doesn't work.  But since HS200 does work in Linux,
>>> probably nobody noticed this.
>>>
>>> That said, I'm not confident a single clock phase setting will work
>>> across all Amlogic SoCs and across different boards.  Maybe we need
>>> something in the device tree such that we can control the values on a
>>> per-board level.
>>>
>>
>> So this is specific to SM1 SoCs then, because others families doesn't have such issues
>> at 52MHz.
> 
> I don't have much knowledge of SM1 SoCs. But how did its phase value select them on Linux driver?
> 
>>
>> So the Linux must be fixes, including the bindings to introduce a new compatible, then
>> ported to U-Boot.
>>
>> So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
>> clarified.
> If you want to limit to 26MHz, I don't have any objection about your opinion.
> But I wonder how to clarify all. And I also wonder that values what is used on Linux kernel are really right.

OK, I'm not a MMC & SDCard expert on Amlogic, all the work was done in Linux.

I just want to keep a working and stable SDCard & eMMC support for the 7 SoCs Families.

Could you rewrite my "[PATCH 2/3] mmc: meson-gx: limit max frequency on SM1 SoCs" by instead changing the
clock phase only for SM1 ?
I'll then apply it with the 2 other patches and push then for the current development cycle.

The driver is functional for all the other SoCs, and I want to keep it stable unless extensively tested.

Neil

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Neil
>>
> 

