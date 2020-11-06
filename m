Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.10051.1604659063510674905
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:37:43 -0800
Received: by mail-wr1-f67.google.com with SMTP id y12so788835wrp.6
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JbUR8VolZ3Oi2bfhKi2wiqzDvt6+yIjQ/SSIstqmMc=;
        b=J0jRbg7S2WLR8n5d5k8QgE4fQrjwtCs6LRy2Rer96eibmu0zcEtyahyMVKxNkf5dsp
         11Vm5PXbA9T1T9VCZVfHGer34ZPDqq08Dkl+9lMmb2YjhyEjzpVWQ2Mi6ys1OrtbWoEE
         biXU1CVARxqlQQfIHqNxPET0yqOSl8lgxLfh6fcJ+aO70YH66seOyJoGVGg1FZEB+mvh
         Aab3iGzyVW5va+vWSgP0XpbY4D+lmZQEPfggY7hhFAG/hcGziAIIrUUfdjbjEqZ2WyrZ
         b9qu+Fue7LlP+dc3HWyJD1TYycR8SUrOzhJu7cpveGdwl0sVzg4iVxd8HDfqEvEwakHj
         KHXQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] mmc: meson-gx: limit max frequency on SM1 SoCs
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
 <CGME20201106093033epcas1p22f885b3691e135923c305f39e5d327e0@epcas1p2.samsung.com>
 <20201106092755.2250773-3-narmstrong@baylibre.com>
 <dd0d520d-c213-96eb-3301-fba2adbed187@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <62ee27b0-6667-38de-5369-ddd744786b36@baylibre.com>
Date: Fri, 6 Nov 2020 11:35:30 +0100
MIME-Version: 1.0
In-Reply-To: <dd0d520d-c213-96eb-3301-fba2adbed187@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 11:32, Jaehoon Chung wrote:
> On 11/6/20 6:27 PM, Neil Armstrong wrote:
>> Amlogic SM1 SoCs doesn't handle very well high clocks from the DIV2 input
>> Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
>> frequencies via the first input from a composite clock.
>>
>> Here 26MHz corresponds to MMC_HS clock speed.
>>
>> We also add a u-boot only sm1 compatible to distinguish the controller.
> 
> Well, it's workaround for using eMMC.

It's for the next release, to have a temporary fix.
The goal is to not have such workaround....

> I didn't check all SM1 SoCs..but odroid-c4 is supported hs200 mode (200MHz) on Kernel side.
> It means that bootloader can also support its mode.
> 
> I'm checking this problem with odroid-c4 target. If i find how to fix, i will share.

H200 will need a big work including tuning and proper clock management.

If you manage to got that far, I'll be great !

Neil

> 
> Best Regards,
> Jaehoon Chung
> 
> 
>>
>> Finally a TOFIX is added to precise the clock management should use
>> the clock controller instead of local management with fixed clock rates.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/meson_gx_mmc.c | 26 +++++++++++++++++++++++---
>>  drivers/mmc/meson_gx_mmc.h |  5 +++++
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index 9350edf3fa..2c6b6cd15b 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -17,6 +17,14 @@
>>  #include <linux/log2.h>
>>  #include "meson_gx_mmc.h"
>>  
>> +bool meson_gx_mmc_is_compatible(struct udevice *dev,
>> +				enum meson_gx_mmc_compatible family)
>> +{
>> +	enum meson_gx_mmc_compatible compat = dev_get_driver_data(dev);
>> +
>> +	return compat == family;
>> +}
>> +
>>  static inline void *get_regbase(const struct mmc *mmc)
>>  {
>>  	struct meson_mmc_platdata *pdata = mmc->priv;
>> @@ -42,6 +50,8 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>  	if (!mmc->clock)
>>  		return;
>>  
>> +	/* TOFIX This should use the proper clock taken from DT */
>> +
>>  	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
>>  	if (mmc->clock > 16000000) {
>>  		clk = SD_EMMC_CLKSRC_DIV2;
>> @@ -265,7 +275,16 @@ static int meson_mmc_probe(struct udevice *dev)
>>  	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
>>  			MMC_MODE_HS_52MHz | MMC_MODE_HS;
>>  	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
>> -	cfg->f_max = 100000000; /* 100 MHz */;
>> +	/*
>> +	 * TOFIX SM1 SoCs doesn't handle very well high clocks from the DIV2 input
>> +	 * Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
>> +	 * frequencies via the first input from a composite clock
>> +	 * 26MHz corresponds to MMC_HS clock speed
>> +	 */
>> +	if (meson_gx_mmc_is_compatible(dev, MMC_COMPATIBLE_SM1))
>> +		cfg->f_max = 26000000; /* 26 MHz */
>> +	else
>> +		cfg->f_max = 100000000; /* 100 MHz */
>>  	cfg->b_max = 511; /* max 512 - 1 blocks */
>>  	cfg->name = dev->name;
>>  
>> @@ -308,8 +327,9 @@ int meson_mmc_bind(struct udevice *dev)
>>  }
>>  
>>  static const struct udevice_id meson_mmc_match[] = {
>> -	{ .compatible = "amlogic,meson-gx-mmc" },
>> -	{ .compatible = "amlogic,meson-axg-mmc" },
>> +	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_GX },
>> +	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_GX },
>> +	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_SM1 },
>>  	{ /* sentinel */ }
>>  };
>>  
>> diff --git a/drivers/mmc/meson_gx_mmc.h b/drivers/mmc/meson_gx_mmc.h
>> index b4544b5562..92aec5329f 100644
>> --- a/drivers/mmc/meson_gx_mmc.h
>> +++ b/drivers/mmc/meson_gx_mmc.h
>> @@ -9,6 +9,11 @@
>>  #include <mmc.h>
>>  #include <linux/bitops.h>
>>  
>> +enum meson_gx_mmc_compatible {
>> +	MMC_COMPATIBLE_GX,
>> +	MMC_COMPATIBLE_SM1,
>> +};
>> +
>>  #define SDIO_PORT_A			0
>>  #define SDIO_PORT_B			1
>>  #define SDIO_PORT_C			2
>>
> 

