Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mx.groups.io with SMTP id smtpd.web10.19307.1604960333146924869
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 14:18:54 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201109221850epoutp03fa47e6efb4bebf9f62b5a31eaaf74735~F9urBoGnR0704907049epoutp037
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 22:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201109221850epoutp03fa47e6efb4bebf9f62b5a31eaaf74735~F9urBoGnR0704907049epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604960330;
	bh=V/jyGnsWkw+wQu4cVdExqYZRwbgqZBwaTfNhfYxLq8A=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=G0yPwncrCEfed82Zcw1nMDYIpwSOsQkXnS8VWYT81r7bMMjxLB1RKFCbtvgL6HE7M
	 5PrKHBt5BYAEpRD+QN6cMZFjqhN8CSRGlEwJSFbYog9FoyPYS8aN7BoQz3alSHSPeR
	 mb1xT1NO9m4qkfIBuljhjW2hMBKcj6n6YZ5AwifE=
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <4948303b-681e-785e-8e85-f4be8bb5074c@samsung.com>
Date: Tue, 10 Nov 2020 07:19:04 +0900
MIME-Version: 1.0
In-Reply-To: <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
	<20201109031233.25320-1-jh80.chung@samsung.com>
	<15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
	<e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
	<9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 11/9/20 11:23 PM, Neil Armstrong wrote:
> On 09/11/2020 15:10, Mark Kettenis wrote:
>>> From: Neil Armstrong <narmstrong@baylibre.com>
>>> Date: Mon, 9 Nov 2020 14:37:09 +0100
>>>
>>> Hi,
>>>
>>> On 09/11/2020 04:12, Jaehoon Chung wrote:
>>>> Core clock phase value is changed from 180' to 270'.
>>>> It's more stable than before.
>>>> - Odroidn-N2/C4 : Working fine with 52MHz
>>>> - VIM3 : Working fine with 52MHz
>>>>
>>>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> ---
>>>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>>> index 719dd1e5e570..7c60e0566560 100644
>>>> --- a/drivers/mmc/meson_gx_mmc.c
>>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>>  	}
>>>>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>>  
>>>> -	/* 180 phase core clock */
>>>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>>> -
>>>> -	/* 180 phase tx clock */
>>>> +	/*
>>>> +	 * Clock Phase needs to set a proper value.
>>>> +	 * It can be changed to other value.
>>>> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
>>>> +	 * set to them by default.
>>>> +	 */
>>>> +	/* Core Clock Phase */
>>>> +	meson_mmc_clk |= CLK_CO_PHASE_270;
>>>> +
>>>> +	/* TX Clock Phase */
>>>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>>>  
>>>>  	/* clock settings */
>>>>
>>>
>>> The previous values were aligned on the Linux driver, which is functional.
>>
>> Actually the Linux driver isn't really functional; the 52 MHz
>> high-speed mode doesn't work.  But since HS200 does work in Linux,
>> probably nobody noticed this.
>>
>> That said, I'm not confident a single clock phase setting will work
>> across all Amlogic SoCs and across different boards.  Maybe we need
>> something in the device tree such that we can control the values on a
>> per-board level.
>>
> 
> So this is specific to SM1 SoCs then, because others families doesn't have such issues
> at 52MHz.

I don't have much knowledge of SM1 SoCs. But how did its phase value select them on Linux driver?

> 
> So the Linux must be fixes, including the bindings to introduce a new compatible, then
> ported to U-Boot.
> 
> So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
> clarified.
If you want to limit to 26MHz, I don't have any objection about your opinion.
But I wonder how to clarify all. And I also wonder that values what is used on Linux kernel are really right.

Best Regards,
Jaehoon Chung

> 
> Neil
> 

