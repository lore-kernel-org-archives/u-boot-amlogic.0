Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.10009.1604658711087189447
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:31:51 -0800
Received: by mail-wm1-f65.google.com with SMTP id h22so852809wmb.0
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Km+EQSBTYCpVRPuDZoLvSO5pxwn3wnFzEi6PlXnY8sw=;
        b=Z5QXq/I1DD9/joz1hJTjTj4mbltvcqwPvIXDPHv5iTm9WZfOEQhGaVwX6r0FRebfZE
         HT7DqiYi2ztF1U3Fd51jNTQRPWx35mREEYGbVR/HYxWjSZiZwmj4ggDbhu/wMUzB1QAm
         JMwXI1yiDnaCkupf2EaqCC8wtk4NMzEnoQhypkD/8xVi25+GV7EkNKfE9tgX5QnfI7FV
         qHOrYMNLC/7zQC6GmEBpApddwCfnjyPsk7joOwkt4EeUcotqKnuJTj/uM5Us4bc18i1g
         21Gxm7Afcfdo6UmZXdg+Hn9dHMuSJgYl/k8ISE6G/JHUiLPPzezaGby5TF+Srykd06dp
         Ba4Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/3] mmc: meson-gx: move arch header to local header
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
 <CGME20201106093044epcas1p1d135ac4920a18769398028054507ae34@epcas1p1.samsung.com>
 <20201106092755.2250773-2-narmstrong@baylibre.com>
 <c9712225-3ddb-a058-74b3-3121eb58b8e7@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <dbc48b70-bd9b-7fd0-ee71-23cb43b474b4@baylibre.com>
Date: Fri, 6 Nov 2020 11:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <c9712225-3ddb-a058-74b3-3121eb58b8e7@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 11:27, Jaehoon Chung wrote:
> On 11/6/20 6:27 PM, Neil Armstrong wrote:
>> Move the asm/arch-meson/sd_emmc.h to a local meson_gx_mmc.h,
>> remove the useless if/then and fix the meson_gx_mmc.c include.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/meson_gx_mmc.c                                 | 4 ++--
>>  .../asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h | 7 ++-----
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>  rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (97%)
>>
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index 719dd1e5e5..9350edf3fa 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -13,9 +13,9 @@
>>  #include <mmc.h>
>>  #include <asm/io.h>
>>  #include <asm/gpio.h>
>> -#include <asm/arch/sd_emmc.h>
>>  #include <linux/delay.h>
>>  #include <linux/log2.h>
>> +#include "meson_gx_mmc.h"
>>  
>>  static inline void *get_regbase(const struct mmc *mmc)
>>  {
>> @@ -265,7 +265,7 @@ static int meson_mmc_probe(struct udevice *dev)
>>  	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
>>  			MMC_MODE_HS_52MHz | MMC_MODE_HS;
>>  	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
>> -	cfg->f_max = 100000000; /* 100 MHz */
>> +	cfg->f_max = 100000000; /* 100 MHz */;
> 
> Don't need to touch. Remove ";"

Oops it's a spurious change, thanks for noticing.

Neil

> 
>>  	cfg->b_max = 511; /* max 512 - 1 blocks */
>>  	cfg->name = dev->name;
>>  
>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/drivers/mmc/meson_gx_mmc.h
>> similarity index 97%
>> rename from arch/arm/include/asm/arch-meson/sd_emmc.h
>> rename to drivers/mmc/meson_gx_mmc.h
>> index 1e9f8cf498..b4544b5562 100644
>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
>> +++ b/drivers/mmc/meson_gx_mmc.h
>> @@ -3,14 +3,11 @@
>>   * (C) Copyright 2016 Carlo Caione <carlo@caione.org>
>>   */
>>  
>> -#ifndef __SD_EMMC_H__
>> -#define __SD_EMMC_H__
>> +#ifndef __MESON_GX_MMC_H__
>> +#define __MESON_GX_MMC_H__
>>  
>>  #include <mmc.h>
>> -#ifndef __ASSEMBLY__
>>  #include <linux/bitops.h>
>> -#endif
>> -
>>  
>>  #define SDIO_PORT_A			0
>>  #define SDIO_PORT_B			1
>>
> 

