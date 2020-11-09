Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web12.19115.1604959470941320756
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 14:04:32 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201109220428epoutp019e6828db8149287c5c1395a40900fa3f~F9iH-nP571502215022epoutp01_
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 22:04:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201109220428epoutp019e6828db8149287c5c1395a40900fa3f~F9iH-nP571502215022epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604959468;
	bh=WoKWi1VZGwMSOHeeoqQYYi+BZojqL4KaOTIdV4fHAfU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=seAQmU1e9TQcEsNRrEJoWBjZ8ek82Nhe4AfWQpTefGGUFGqBPOJ4XXKmanpr5RA7Y
	 iG5jraL4ORwFCWVccizH/gshl1JKzWo+JZRRqnJd7wDAw5rSC2+uDx+Iw8k8sC/ysN
	 +l200bjdl7s+jScVz04/JGu4HpAq562KcKu9zHmE=
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <729977a0-85f0-ad8c-d757-bf6b4875bafa@samsung.com>
Date: Tue, 10 Nov 2020 07:04:43 +0900
MIME-Version: 1.0
In-Reply-To: <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
	<20201109031233.25320-1-jh80.chung@samsung.com>
	<15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
	<e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 11/9/20 11:10 PM, Mark Kettenis wrote:
>> From: Neil Armstrong <narmstrong@baylibre.com>
>> Date: Mon, 9 Nov 2020 14:37:09 +0100
>>
>> Hi,
>>
>> On 09/11/2020 04:12, Jaehoon Chung wrote:
>>> Core clock phase value is changed from 180' to 270'.
>>> It's more stable than before.
>>> - Odroidn-N2/C4 : Working fine with 52MHz
>>> - VIM3 : Working fine with 52MHz
>>>
>>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>> index 719dd1e5e570..7c60e0566560 100644
>>> --- a/drivers/mmc/meson_gx_mmc.c
>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>  	}
>>>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>  
>>> -	/* 180 phase core clock */
>>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>> -
>>> -	/* 180 phase tx clock */
>>> +	/*
>>> +	 * Clock Phase needs to set a proper value.
>>> +	 * It can be changed to other value.
>>> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
>>> +	 * set to them by default.
>>> +	 */
>>> +	/* Core Clock Phase */
>>> +	meson_mmc_clk |= CLK_CO_PHASE_270;
>>> +
>>> +	/* TX Clock Phase */
>>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>>  
>>>  	/* clock settings */
>>>
>>
>> The previous values were aligned on the Linux driver, which is functional.
> 
> Actually the Linux driver isn't really functional; the 52 MHz
> high-speed mode doesn't work.  But since HS200 does work in Linux,
> probably nobody noticed this.

Well, i didn't check Linux driver. but i can also check on Linux side.

> 
> That said, I'm not confident a single clock phase setting will work
> across all Amlogic SoCs and across different boards.  Maybe we need
> something in the device tree such that we can control the values on a
> per-board level.

Agreed. I can't mention that "it's working fine about all Amlogic SoCs".
In exynos's case, there are sdr and ddr timing about mmc/sd IP.
sdr/ddr timing are trying to get from dt's property, because it's possible that all Exynos SoCs have different values.

I think that Amlogic SoCs also needs to apply similar approach.

Best Regards,
Jaehoon Chung

> 

