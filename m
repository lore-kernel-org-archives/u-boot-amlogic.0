Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web12.450.1607982591442202013
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 13:49:51 -0800
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201214214949epoutp0129ed49d8d83ddde378b54a1036d396bf~Qs6VHZhKv1695516955epoutp01h
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 21:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201214214949epoutp0129ed49d8d83ddde378b54a1036d396bf~Qs6VHZhKv1695516955epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607982589;
	bh=QrGKCx6a72ago0yDAGnLA+0uyIbcv0c1G2LKtSVlvFQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=lItPMTiwz4odvJlOZhH3eMcnBjCjamfjsBAh/GW3qGetvqDppwPpO79RvZFymD+2m
	 qiq/i/6GXT68ClojB/6fIdOTLxIvWBcxrsnqAJpTOqvBshhtkL+F1HIU2GZVvOCgKi
	 SYcnf/a2hbywdYfZM7EgMapPf56WfJI6HLy4H3Qw=
Subject: Re: [PATCH 2/6] adc: meson-saradc: add G12A variant
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <3342a152-e6ad-5e2f-bc98-9fdc2155cd2f@samsung.com>
Date: Tue, 15 Dec 2020 06:50:12 +0900
MIME-Version: 1.0
In-Reply-To: <cf38019c-b65a-ead2-cfd1-f58a2cd0f97f@baylibre.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112449eucas1p1ebcf51e2b91ed2bac7fc4d309a174499@eucas1p1.samsung.com>
	<20201214112437.18757-3-m.szyprowski@samsung.com>
	<cf38019c-b65a-ead2-cfd1-f58a2cd0f97f@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 3:54 AM, Neil Armstrong wrote:
> On 14/12/2020 12:24, Marek Szyprowski wrote:
>> Add support for the SARADC variant found on the G12A SoCs family.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Change-Id: If519d333e9773d089f37a8c7b4ccb144be68925b
> 
> Ditto
> 
>> ---
>>  drivers/adc/meson-saradc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
>> index 72b0cc4e5bd..998cef24d88 100644
>> --- a/drivers/adc/meson-saradc.c
>> +++ b/drivers/adc/meson-saradc.c
>> @@ -711,6 +711,8 @@ static const struct udevice_id meson_saradc_ids[] = {
>>  	  .data = (ulong)&gxl_saradc_data },
>>  	{ .compatible = "amlogic,meson-gxm-saradc",
>>  	  .data = (ulong)&gxl_saradc_data },
>> +	{ .compatible = "amlogic,meson-g12a-saradc",
>> +	  .data = (ulong)&gxl_saradc_data },
>>  	{ }
>>  };
>>  
>>
> 
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> 

