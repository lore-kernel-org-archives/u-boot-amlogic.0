Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web08.19365.1604960801457994097
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 14:26:42 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201109222639epoutp01bcc4602a12513d7f10b843c1abcf718b~F91ftcCJV3016230162epoutp01U
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 22:26:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201109222639epoutp01bcc4602a12513d7f10b843c1abcf718b~F91ftcCJV3016230162epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604960799;
	bh=sKI/QpKFNQS6pevi+qf9PerxN/ns1YWA/p3ZOJfq85c=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=jlRr0Gs3aDkESqIYVuKO80Qo9tRlzsu0IusF99xZNuKXwffbAE0uOoPCL2xEuq7VR
	 TrXR4wr9USTASoZB25Z+EkEXYu4NmHFdk+Qzuu+8mqFCSYNQ5vEG5DsxMeE6p6zMb5
	 eRhfo6XKvZDHrxFNCrduPjq4/qw5ApWuQXLuB2pU=
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <d4e7514d-6044-5446-50c7-ccc88ab6ce63@samsung.com>
Date: Tue, 10 Nov 2020 07:26:53 +0900
MIME-Version: 1.0
In-Reply-To: <CANAwSgRA-43AReFgP7D-5i=EA_XXV+wgQhHkGEFD5StGceXAeg@mail.gmail.com>
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
	<20201109031233.25320-1-jh80.chung@samsung.com>
	<15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
	<e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
	<9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
	<CANAwSgRA-43AReFgP7D-5i=EA_XXV+wgQhHkGEFD5StGceXAeg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Anand Moon <linux.amoon@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Peng Fan <peng.fan@nxp.com>
List-ID: <u-boot-amlogic@groups.io>

Dear Anand,

On 11/10/20 4:02 AM, Anand Moon wrote:
> Hi Neil,
> 
> On Mon, 9 Nov 2020 at 19:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
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
>>>>>     }
>>>>>     clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>>>
>>>>> -   /* 180 phase core clock */
>>>>> -   meson_mmc_clk |= CLK_CO_PHASE_180;
>>>>> -
>>>>> -   /* 180 phase tx clock */
>>>>> +   /*
>>>>> +    * Clock Phase needs to set a proper value.
>>>>> +    * It can be changed to other value.
>>>>> +    * Because CORE : 270' Phase and TX : 0' Phase are stable,
>>>>> +    * set to them by default.
>>>>> +    */
>>>>> +   /* Core Clock Phase */
>>>>> +   meson_mmc_clk |= CLK_CO_PHASE_270;
>>>>> +
>>>>> +   /* TX Clock Phase */
>>>>>     meson_mmc_clk |= CLK_TX_PHASE_000;
>>>>>
>>>>>     /* clock settings */
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
>>
>> So the Linux must be fixes, including the bindings to introduce a new compatible, then
>> ported to U-Boot.
>>
>> So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
>> clarified.
>>
>> Neil
> 
> Earlier I had a similar approach for this FIX but somehow it did not get merged.
> 
> Please add my
> Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks for testing!

Best Regards,
Jaehoon Chung

> 
> Best Regards
> -Anand
> 

