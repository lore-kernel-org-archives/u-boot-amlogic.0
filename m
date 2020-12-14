Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web10.468.1607982665959736117
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 13:51:06 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201214215103epoutp04a2fcf2d4d77a13c102f97c6b484978c2~Qs7aZUcKq1381013810epoutp04_
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 21:51:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201214215103epoutp04a2fcf2d4d77a13c102f97c6b484978c2~Qs7aZUcKq1381013810epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607982663;
	bh=1fpadl/USFN0KYmWDwA2AJpbzJWso4VoBsQt4pnKBhA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=l7O6pErGfR3ZNtCndbDZOGSOwvJT5UTK2Vh6Xs7vl7pXFxdBdHG3zPsAikkgrAtBv
	 PTPcS3HhFS5IkVrf09BpZ/F/h0qE1bxTEiVIHrfM8Trv1TRVSCedCEDIYVT2giaotJ
	 n0b4FDGC1rzyVVZMfvg819rvwpB5OPBdxV4XyXl0=
Subject: Re: [PATCH 6/6] configs: khadas-vim3: enable Function button support
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <2f0c611f-aa95-1358-791a-16c6948b0a60@samsung.com>
Date: Tue, 15 Dec 2020 06:51:26 +0900
MIME-Version: 1.0
In-Reply-To: <c67d2024-019e-e671-b748-0b25d274d806@baylibre.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112452eucas1p2ceb557dffa15ea073f922bf59afb8578@eucas1p2.samsung.com>
	<20201214112437.18757-7-m.szyprowski@samsung.com>
	<c67d2024-019e-e671-b748-0b25d274d806@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 3:55 AM, Neil Armstrong wrote:
> Hi,
> 
> On 14/12/2020 12:24, Marek Szyprowski wrote:
>> Add options required to check the 'Function' button state.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

>> ---
>>  configs/khadas-vim3_defconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
>> index 9d7ba72d440..bc174305692 100644
>> --- a/configs/khadas-vim3_defconfig
>> +++ b/configs/khadas-vim3_defconfig
>> @@ -29,6 +29,10 @@ CONFIG_CMD_REGULATOR=y
>>  CONFIG_OF_CONTROL=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_ADC=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_ADC=y
>>  CONFIG_DM_I2C=y
>>  CONFIG_SYS_I2C_MESON=y
>>  CONFIG_DM_MMC=y
>>
> 
> If you separate the ADC configs and Button configs, I can directly apply the clk-ao & adc patches
> for next release.
> 
> Neil
> 

