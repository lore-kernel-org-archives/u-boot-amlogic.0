Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.2672.1607977069715537714
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 12:17:50 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201214201732euoutp024ee33ddc0749f103d33dadec526d0821~QrpwKOWKQ0318503185euoutp02R
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 20:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201214201732euoutp024ee33ddc0749f103d33dadec526d0821~QrpwKOWKQ0318503185euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607977052;
	bh=BuHQrOSs2GcHWT+v4XoEyN5rBqq01jv1nbgPPu7GMbY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=HkBAExtZvBqyynVidWf8SrI50I8CU5b515BlfaJiZTRWaiVwsfStVKT6hsxNkWLNc
	 jy+y7uejPtZSHl4f+XDeJe357eKkH2yxX77Gcnb3K/09gBFXoF0pVCRFYK3sAQQ+va
	 5Up+FayAVS/0fN2PnpFc0uQe+B9H/WlZIbo8OgYw=
Subject: Re: [PATCH 6/6] configs: khadas-vim3: enable Function button support
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bd110c62-4b09-12f0-47fb-b5bc41def981@samsung.com>
Date: Mon, 14 Dec 2020 21:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <c67d2024-019e-e671-b748-0b25d274d806@baylibre.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112452eucas1p2ceb557dffa15ea073f922bf59afb8578@eucas1p2.samsung.com>
	<20201214112437.18757-7-m.szyprowski@samsung.com>
	<c67d2024-019e-e671-b748-0b25d274d806@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On 14.12.2020 19:55, Neil Armstrong wrote:
> On 14/12/2020 12:24, Marek Szyprowski wrote:
>> Add options required to check the 'Function' button state.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   configs/khadas-vim3_defconfig | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
>> index 9d7ba72d440..bc174305692 100644
>> --- a/configs/khadas-vim3_defconfig
>> +++ b/configs/khadas-vim3_defconfig
>> @@ -29,6 +29,10 @@ CONFIG_CMD_REGULATOR=y
>>   CONFIG_OF_CONTROL=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_ADC=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_ADC=y
>>   CONFIG_DM_I2C=y
>>   CONFIG_SYS_I2C_MESON=y
>>   CONFIG_DM_MMC=y
>>
> If you separate the ADC configs and Button configs, I can directly apply the clk-ao & adc patches
> for next release.

Sure, no problem. I'm sorry for the change-id mess, I forgot to clean it 
before submission. I will send v2 soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

