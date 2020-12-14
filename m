Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web10.447.1607982608561414008
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 13:50:09 -0800
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201214215006epoutp041d02a4c9659f7b78b74d78b36887905f~Qs6lB0xGS1172511725epoutp04W
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 21:50:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201214215006epoutp041d02a4c9659f7b78b74d78b36887905f~Qs6lB0xGS1172511725epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607982606;
	bh=UBUKffvl2dnoOgJ2bADMNhU13fCQm4TwHQjhUY/QBUU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=Pw3D34NOdZLJhHkdyjgGAiSPnyP9lQlcdhE/MoPA21SWsQAqWbD5avXPYR/jk1jOS
	 AHW5qmMSzFEJSuh29/6lp3jm7GS5zInr7dzhTPf4mrU7/OO/g4ZL6oCO94isbNb/6t
	 tf1WBbvauKupCmYVXyawdtTWMFJUdQLstQHh8NLw=
Subject: Re: [PATCH 3/6] adc: meson-saradc: skip hardware init only if ADC is enabled
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <150103a6-72b8-3b2c-9680-7f447ae4b89b@samsung.com>
Date: Tue, 15 Dec 2020 06:50:29 +0900
MIME-Version: 1.0
In-Reply-To: <e2f7c87c-562f-de3a-edef-5a9ebd51dcc4@baylibre.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112450eucas1p1e7ad389bceaaf1082c9afdcb0733e9c0@eucas1p1.samsung.com>
	<20201214112437.18757-4-m.szyprowski@samsung.com>
	<e2f7c87c-562f-de3a-edef-5a9ebd51dcc4@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 3:54 AM, Neil Armstrong wrote:
> On 14/12/2020 12:24, Marek Szyprowski wrote:
>> The driver skips hardware initialization if it is already configured by
>> the earlier bootloader stage (BL30). Skip the initialization only if the
>> hardware is really initialized and enabled.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Change-Id: I3e2e2d270ad3e7e7f38e2bc3ce2a924a47b164af
> 
> Ditto
> 
>> ---
>>  drivers/adc/meson-saradc.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
>> index 998cef24d88..ce7ae990ad0 100644
>> --- a/drivers/adc/meson-saradc.c
>> +++ b/drivers/adc/meson-saradc.c
>> @@ -512,8 +512,11 @@ static int meson_saradc_init(struct meson_saradc_priv *priv)
>>  	 * reading the temperature sensor.
>>  	 */
>>  	regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
>> -	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
>> -		return 0;
>> +	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED) {
>> +		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
>> +		if (regval & MESON_SAR_ADC_REG3_ADC_EN)
>> +			return 0;
>> +	}
>>  
>>  	meson_saradc_stop_sample_engine(priv);
>>  
>>
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> 

