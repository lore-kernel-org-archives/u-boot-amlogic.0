Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web08.25119.1604998730857510467
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Nov 2020 00:58:51 -0800
Received: by mail-wr1-f66.google.com with SMTP id 23so11768840wrc.8
        for <u-boot-amlogic@groups.io>; Tue, 10 Nov 2020 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8ngIDyNxaUsu3uWntD6tTRfYmqGRl7LAE12/6o0Kjs=;
        b=IZFFCjDWpJ8TZnQZnxSf6FMHzJ7/FKgmrJk6Kf3NQSt50JQW5HjhE+xlyS09B6FzTf
         72Xaj19yAN5aFzXCgeZMcdk3Gwwrza6o9sJgeSN7DL4jCZhLXgPJQ7tiF1hQJtqMM3AS
         /1z7g+gbX/9lJC0CX5cqqQV4RtEvqAZKni5KEJTeEHfq2plDQn8Dat0JsdSc6J809jYV
         K/jrtdjx8g4FHIr4fyClvCJ9YmH0oaskbIQhtuLhI/UMpXXFAzHDneroZH+sYCIACri0
         YGP3vr6/9NieRzuSW2IdPnPtRm9Z7lAsybK6HZRtJOxuWNqDIA9in7szWRTPWOzeRoZx
         jqjg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com>
 <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
 <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
 <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
 <4948303b-681e-785e-8e85-f4be8bb5074c@samsung.com>
 <92cad952-f3d3-7616-a494-4f376ade959c@baylibre.com>
 <75908485-ed1f-4058-8099-177bbffc8368@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <147cfd33-2682-0ab7-d9e2-aa8ebbda3f34@baylibre.com>
Date: Tue, 10 Nov 2020 09:58:47 +0100
MIME-Version: 1.0
In-Reply-To: <75908485-ed1f-4058-8099-177bbffc8368@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 10/11/2020 09:36, Jaehoon Chung wrote:
> On 11/10/20 5:05 PM, Neil Armstrong wrote:
>> On 09/11/2020 23:19, Jaehoon Chung wrote:
>>> On 11/9/20 11:23 PM, Neil Armstrong wrote:
>>>> On 09/11/2020 15:10, Mark Kettenis wrote:
>>>>>> From: Neil Armstrong <narmstrong@baylibre.com>
>>>>>> Date: Mon, 9 Nov 2020 14:37:09 +0100
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 09/11/2020 04:12, Jaehoon Chung wrote:
>>>>>>> Core clock phase value is changed from 180' to 270'.
>>>>>>> It's more stable than before.
>>>>>>> - Odroidn-N2/C4 : Working fine with 52MHz
>>>>>>> - VIM3 : Working fine with 52MHz
>>>>>>>
>>>>>>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
>>>>>>>
>>>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>>>> ---
>>>>>>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>>>>>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>>>>>> index 719dd1e5e570..7c60e0566560 100644
>>>>>>> --- a/drivers/mmc/meson_gx_mmc.c
>>>>>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>>>>>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>>>>>  	}
>>>>>>>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>>>>>  
>>>>>>> -	/* 180 phase core clock */
>>>>>>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>>>>>> -
>>>>>>> -	/* 180 phase tx clock */
>>>>>>> +	/*
>>>>>>> +	 * Clock Phase needs to set a proper value.
>>>>>>> +	 * It can be changed to other value.
>>>>>>> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
>>>>>>> +	 * set to them by default.
>>>>>>> +	 */
>>>>>>> +	/* Core Clock Phase */
>>>>>>> +	meson_mmc_clk |= CLK_CO_PHASE_270;
>>>>>>> +
>>>>>>> +	/* TX Clock Phase */
>>>>>>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>>>>>>  
>>>>>>>  	/* clock settings */
>>>>>>>
>>>>>>
>>>>>> The previous values were aligned on the Linux driver, which is functional.
>>>>>
>>>>> Actually the Linux driver isn't really functional; the 52 MHz
>>>>> high-speed mode doesn't work.  But since HS200 does work in Linux,
>>>>> probably nobody noticed this.
>>>>>
>>>>> That said, I'm not confident a single clock phase setting will work
>>>>> across all Amlogic SoCs and across different boards.  Maybe we need
>>>>> something in the device tree such that we can control the values on a
>>>>> per-board level.
>>>>>
>>>>
>>>> So this is specific to SM1 SoCs then, because others families doesn't have such issues
>>>> at 52MHz.
>>>
>>> I don't have much knowledge of SM1 SoCs. But how did its phase value select them on Linux driver?
>>>
>>>>
>>>> So the Linux must be fixes, including the bindings to introduce a new compatible, then
>>>> ported to U-Boot.
>>>>
>>>> So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
>>>> clarified.
>>> If you want to limit to 26MHz, I don't have any objection about your opinion.
>>> But I wonder how to clarify all. And I also wonder that values what is used on Linux kernel are really right.
>>
>> OK, I'm not a MMC & SDCard expert on Amlogic, all the work was done in Linux.
>>
>> I just want to keep a working and stable SDCard & eMMC support for the 7 SoCs Families.
>>
>> Could you rewrite my "[PATCH 2/3] mmc: meson-gx: limit max frequency on SM1 SoCs" by instead changing the
>> clock phase only for SM1 ?
>> I'll then apply it with the 2 other patches and push then for the current development cycle.
> 
> Ok. I will rewrite with you patch. Is it ok that i send the patch on Tomorrow?

Agreed

> 
>>
>> The driver is functional for all the other SoCs, and I want to keep it stable unless extensively tested.
> 
> Agreed. If i can test all Amlogic SoCs, I want to do that..But it's impossible to me.
> In future, i hope that it will be fixed with generic approach.

Sure, thanks for your work & testing !

Neil

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Neil
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> Neil
>>>>
>>>
>>
>>
> 

