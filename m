Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.33365.1615196665100095671
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:44:25 -0800
Received: by mail-wm1-f49.google.com with SMTP id e23so5631815wmh.3
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYDMkvcqb26xp43QzZGV5X8OPS7S79y+1kCfiLWdVdc=;
        b=2GFpSF0Oj53MeJIBr0YY1dsByCaVW7Iy3Ac6sysxbfTI3CsTfk3i5VFONRgg2DCfqB
         V+u9xAH3768NKKEKIx80fyIQdlPEoQR6lvM4jRbsYQAebUS7uJocJo6XNczsq9NdleM9
         fWzF4l8q2bI0JSLnonSEIClW/u52gNFt/8JczRzu4aUh+Rp9D7X6vnbxdcisuUskqn8A
         HDHHRV+jULZVyvsAF2UpkNOtDeV3QwzWViILz9nNltqW8gHOKN5bQ6JeV3Guj+H/o4NX
         tgfRdGSmjSbXl+BDZoY2/ipRHtlxAeIEpPjCsI790zjSWpxbB8AHEPpaGMH6dKYsEy7t
         6aog==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] button: adc: fix treshold typo
References: <CGME20210223151049eucas1p2f45c23f278c93b83e1a0812e4370b090@eucas1p2.samsung.com>
 <20210223151040.2201981-1-narmstrong@baylibre.com>
 <2073014a-cdb9-9848-8a39-b02446f0a2ce@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <41a4b1f3-916e-c00f-53f8-f512ea1f941f@baylibre.com>
Date: Mon, 8 Mar 2021 10:44:21 +0100
MIME-Version: 1.0
In-Reply-To: <2073014a-cdb9-9848-8a39-b02446f0a2ce@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 23/02/2021 19:18, Marek Szyprowski wrote:
> On 23.02.2021 16:10, Neil Armstrong wrote:
>> Fix the treshold typo in code by threshold.
>>
>> Fixes: c0165c85c3 ("button: add a simple Analog to Digital Converter device based button driver")
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/button/button-adc.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
>> index eed86564fb..fd896c76f9 100644
>> --- a/drivers/button/button-adc.c
>> +++ b/drivers/button/button-adc.c
>> @@ -55,7 +55,7 @@ static int button_adc_of_to_plat(struct udevice *dev)
>>   	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>   	struct button_adc_priv *priv = dev_get_priv(dev);
>>   	struct ofnode_phandle_args args;
>> -	u32 treshold, up_treshold, t;
>> +	u32 threshold, up_threshold, t;
>>   	ofnode node;
>>   	int ret;
>>   
>> @@ -73,12 +73,12 @@ static int button_adc_of_to_plat(struct udevice *dev)
>>   		return ret;
>>   
>>   	ret = ofnode_read_u32(dev_ofnode(dev->parent),
>> -			      "keyup-threshold-microvolt", &up_treshold);
>> +			      "keyup-threshold-microvolt", &up_threshold);
>>   	if (ret)
>>   		return ret;
>>   
>>   	ret = ofnode_read_u32(dev_ofnode(dev), "press-threshold-microvolt",
>> -			      &treshold);
>> +			      &threshold);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -87,13 +87,13 @@ static int button_adc_of_to_plat(struct udevice *dev)
>>   		if (ret)
>>   			return ret;
>>   
>> -		if (t > treshold)
>> -			up_treshold = t;
>> +		if (t > threshold)
>> +			up_threshold = t;
>>   	}
>>   
>>   	priv->channel = args.args[0];
>> -	priv->min = treshold;
>> -	priv->max = up_treshold;
>> +	priv->min = threshold;
>> +	priv->max = up_threshold;
>>   
>>   	return ret;
>>   }
> 
> Best regards
> 


Applied to u-boot-amlogic
