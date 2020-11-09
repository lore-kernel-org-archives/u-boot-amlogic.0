Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web08.12187.1604931970946981469
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 06:26:11 -0800
Received: by mail-wr1-f65.google.com with SMTP id p8so8084607wrx.5
        for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2020 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0MAGyXcbKuYXTLwazeQVL+2cyHU4uROSzMaUoeP/Inw=;
        b=ITqT/T8GRlGZZdBbedLX/ZAfPkSK7+5mBhpdF25MlSonh9YzAkWrO0/onC+QKWtgjg
         FlUEjEmrn2r7UuhKDIhJ46KM0IZWf4qZ6E45MYHbwjIw1Srwa22W70dSXez6WpQdtgFb
         rCUw5SUUj17I0tlLGyL8n9V/Axd7L4sUdDrAyxpZlQAykclPtP3tJ/dh0YMvbc+yK5h7
         jLfVdqH3WD3afyGIaOJuf5IyUJwtWuDvdwOHtu8qxCaKdqVGvLkiZ5uhbdjq6SAijiBL
         zKVoRnCVtQb/VdW7xWDe6bSl7NOFWrp4xuoXfy7nRFAIsBDsaTBtBsjUNMUTiV6fyzkg
         WdcA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com>
 <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
 <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
Date: Mon, 9 Nov 2020 15:23:57 +0100
MIME-Version: 1.0
In-Reply-To: <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 09/11/2020 15:10, Mark Kettenis wrote:
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
> 
> That said, I'm not confident a single clock phase setting will work
> across all Amlogic SoCs and across different boards.  Maybe we need
> something in the device tree such that we can control the values on a
> per-board level.
> 

So this is specific to SM1 SoCs then, because others families doesn't have such issues
at 52MHz.

So the Linux must be fixes, including the bindings to introduce a new compatible, then
ported to U-Boot.

So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
clarified.

Neil
