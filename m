Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web10.18978.1604958905526271214
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 13:55:06 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201109215502epoutp01acbca2f2dd6b20b9abb17eb78c6a327a~F9Z5ZKQ2J0698806988epoutp01Y
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 21:55:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201109215502epoutp01acbca2f2dd6b20b9abb17eb78c6a327a~F9Z5ZKQ2J0698806988epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604958902;
	bh=4MT8FwQxtMZAJP0o/ASR9zVy8B3+vX0n3x/+dhqwHdk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=RKGQQKGrPNfWtH20kvKp2Bl78PavyB8i2QqKP2u9qGFcLQKQrPOS3M7DbkoA6TAh5
	 coaK3X/zCNKP6/0t/LPUhKbT9od82iZ9e9bKc6HAAqN5PVebaVWkdFFAHmXv5k6Rg9
	 uBc5fEBKD/AsN3tCw+oxzdVhSvhlqQktbwqh7aNQ=
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <c541c346-beef-7e8f-55c1-c59aad85a1fe@samsung.com>
Date: Tue, 10 Nov 2020 06:55:16 +0900
MIME-Version: 1.0
In-Reply-To: <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
	<20201109031233.25320-1-jh80.chung@samsung.com>
	<15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 11/9/20 10:37 PM, Neil Armstrong wrote:
> Hi,
> 
> On 09/11/2020 04:12, Jaehoon Chung wrote:
>> Core clock phase value is changed from 180' to 270'.
>> It's more stable than before.
>> - Odroidn-N2/C4 : Working fine with 52MHz
>> - VIM3 : Working fine with 52MHz
>>
>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index 719dd1e5e570..7c60e0566560 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>  	}
>>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>  
>> -	/* 180 phase core clock */
>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>> -
>> -	/* 180 phase tx clock */
>> +	/*
>> +	 * Clock Phase needs to set a proper value.
>> +	 * It can be changed to other value.
>> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
>> +	 * set to them by default.
>> +	 */
>> +	/* Core Clock Phase */
>> +	meson_mmc_clk |= CLK_CO_PHASE_270;
>> +
>> +	/* TX Clock Phase */
>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>  
>>  	/* clock settings */
>>
> 
> The previous values were aligned on the Linux driver, which is functional.
> 
> How did you test these ?


Actually, i have tested about all cases on targets what i have. (VIM3/Odroid-N2/Odroid-C4) 
I also have VIM3L, but i didn't test on VIM3L. (I can test with VIM3L)
If check with oscilloscope, it will be a good way to find what's wrong. 

When i have enabled MMC_DEBUG, it was always returned -5 (IO) error during switching mode.
In meson_gx_mmc.c, meson_dm_mmc_send_cmd() is returned to -5.
 When i have checked status register, CRC error status bit (BIT[10]) is set. It means that clock timing is wrong.
In my experiment, my debugging about CRC error is 
1) GPIO setting
2) clock value
3) Driver strength
4) clock phase value

I assume that 1~3) are correct. So checked PHASE values.

I didn't check yet how to set value on Linux driver.

Best Regards,
Jaehoon Chung

> 
> Neil
> 

