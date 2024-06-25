Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D8C41513
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.169015.1719311269779198016
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Jun 2024 03:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=hAsjm+U6;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 29F1B100007;
	Tue, 25 Jun 2024 13:27:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 29F1B100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719311266;
	bh=dMGzS5n7LKisn48TGqv7KuYr9H5aW7kDOnMGaToe5vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=hAsjm+U6lApjxsQwFRJWaCvfj+WspklaoddV4HsToVEkcIQccFwG3TdKcn592Y9Ng
	 frxsXRJA5l5prNODvoOpYpbWe+nfv7vy3ddlOXeCEo6ZU0000CkBYhQ/N/9wTtr8Cf
	 Os91F7wxKvkABhHkVN33PlYeWu/L6RvAL8XN0l+eMp/l2EU1/79lN7IuEaPDE6IJX7
	 mKW0n95NLhbrBBSLXemaNyGqkj/WaUncGmS97uJNpaWzI7nx8JacBrsLzvcW4pQ60U
	 FDvc9VP8wGUmmQxcUlrw3DoPbvzvVbPzf9yjeCqyG70CQPy4dOWaHGzuXpoVjfU1rQ
	 qi/hNGTfnAfyg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 13:27:46 +0300 (MSK)
Received: from [172.28.65.100] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 25 Jun 2024 13:27:45 +0300
Message-ID: <2d5d992d-cd14-1391-e860-4bf64785d64e@salutedevices.com>
Date: Tue, 25 Jun 2024 13:16:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>, <u-boot@lists.denx.de>,
	<u-boot-amlogic@groups.io>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
 <20240624-preacher-sharpness-b33541d3302d@thorsis.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240624-preacher-sharpness-b33541d3302d@thorsis.com>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186120 [Jun 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/25 01:39:00 #25693004
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2320



On 24.06.2024 12:14, Alexander Dahl wrote:
> Hello Arseniy,
> 
> Am Sun, Jun 02, 2024 at 11:08:34PM +0300 schrieb Arseniy Krasnov:
>> Based on Linux kernel:
>> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")
>>
>> Allow to define a NAND chip as a boot device. This can be helpful
>> for the selection of the ECC algorithm and strength in case the boot
>> ROM supports only a subset of controller provided options.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>>  include/linux/mtd/rawnand.h      | 6 ++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> index c40a0f23d7..ed605b4af5 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>>  	if (ret == 16)
>>  		chip->options |= NAND_BUSWIDTH_16;
>>  
>> +	if (ofnode_read_bool(node, "nand-is-boot-medium"))
>> +		chip->options |= NAND_IS_BOOT_MEDIUM;
>> +
>>  	if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>>  
>> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
>> index fb002ae641..4eb880d8fb 100644
>> --- a/include/linux/mtd/rawnand.h
>> +++ b/include/linux/mtd/rawnand.h
>> @@ -218,6 +218,12 @@ enum nand_ecc_algo {
>>  /* Device needs 3rd row address cycle */
>>  #define NAND_ROW_ADDR_3		0x00004000
>>  
>> +/*
>> + * Whether the NAND chip is a boot medium. Drivers might use this information
>> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
>> + */
>> +#define NAND_IS_BOOT_MEDIUM	0x00400000
>> +
>>  /* Options valid for Samsung large page devices */
>>  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
> 
> The entries in that file are ordered numerically.  Comparing with the
> same file in Linux this should go before NAND_KEEP_TIMINGS, not
> anywhere in between.  Makes later diffs and ports from Linux easier.

Ok, I'll update this in the next version.

Thanks

> 
> Greets
> Alex
> 
>>  
>> -- 
>> 2.35.0
>>

