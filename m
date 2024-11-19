Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1835D44145
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:21:19 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.18436.1732015278501771736
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:21:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=t3+8Zqri;
 spf=pass (domain: baylibre.com, ip: 209.85.221.41, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so1048370f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732015277; x=1732620077; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTDkm0j7kvVXyGL/5eB1HDRYOQ4Nzof96j0rHheD5fc=;
        b=t3+8Zqris6/vmuP34/XFJ+h85LK5dVA99vPi2KRkesV/VG7/GHTuXPptDPy+zQL0eS
         dwFjmi3fIJe1z0qzzHYH1jDxrCYMRQuxNvf9oA9rbE9Sos6loUmurz81UvO00BTq9GuB
         EawlQQeREhSVMnTZD2sowGR1heahtGeLjL7RcWZ0xHIchlsmEtGhqALBfcXReqRLfFRt
         C3ZsFcdF9nKHgQXModrC73bgO/z+Qhh1G8F6I2wa8RQBejeMogjc9fvkRs2Ko1qasZT0
         Ck98IKcEgTsTejA00vCUqBxTjIZ4s7gClTM4BxdHMY6QYdyAYdTgTWu29G0rMnHmChQ1
         bjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015277; x=1732620077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTDkm0j7kvVXyGL/5eB1HDRYOQ4Nzof96j0rHheD5fc=;
        b=e50oLPV3VdOsIJo7U1MqhDef0xzYjvmBykArWfymqHdqfGWKJp+VO+UuE+Zw6K1z/6
         2WmNN53YOGWDIZcvGwf2lnz1c0KTmWlAy+xJRwsvqA5hNz7iLLqLfljPuMCN4Cf4bN6r
         79wb8Vr/IVf6gPR43GVi7s7etm1aa8rDtJMzCr1USkRB0Z0I/3pJJMpTqTRUb3bf3O84
         5rF45gwi4L4UBZtvlatPcZnSDTfLJZUt6pR8/aE8IaAOBoCVgGUif3DA4Qk2LSOIgbaY
         Ct1psKau2GTu7BXk7OYApxlR1M8Ks52u0A8svDcPgX6jeNKYsCCXspvJPNZJZz7w3kFc
         dOdg==
X-Forwarded-Encrypted: i=1; AJvYcCXb/AzGy8foZ+EYbFyg3KAnI5lJDtPtIX8aXBThd3gUai5tGEnmyxIB9VQTlx7nIp0kcL1IhOYnev43f6UljQ==@groups.io
X-Gm-Message-State: AOJu0YwGYauWLBmNZk7QRz3qfbqusjNSMbiGaye1zHYvRucMdjw+mizz
	ZtZB2389HlyWRSwG+KErdoxapRxGCvavwh40XfLMfRyweitGIOO+7curweIX9VE=
X-Google-Smtp-Source: AGHT+IF3dq1xhCu3+EEjTh8OMNpcydBZZzKxGHnrLTBLqwM3SMNW7g2EUfqUcSdasgN0CSgaE4Xxkg==
X-Received: by 2002:a05:6000:1f88:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-38225a922b7mr13166062f8f.40.1732015276882;
        Tue, 19 Nov 2024 03:21:16 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:3c21:a12b:c34b:7f11? ([2001:861:d40:ed60:3c21:a12b:c34b:7f11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823e0c910asm8528075f8f.39.2024.11.19.03.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:21:16 -0800 (PST)
Message-ID: <70ea37d9-01ae-4173-8fb5-49ceb77b830c@baylibre.com>
Date: Tue, 19 Nov 2024 12:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
 <87v7wjy0il.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87v7wjy0il.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 11:21:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2566

Hi,

Le 19/11/2024 à 11:35, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
>> Actually khadas vim3l use distro command to boot android image.
>> Move on new bootmeth android for A/B and non-A/B vim3l android.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>>   configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>>   include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
>>   include/configs/meson64_android.h         |  3 ---
>>   4 files changed, 34 insertions(+), 9 deletions(-)
> [...]
>
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_I2C=y
>> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
>> index f39a3782d663..31068c59d5ed 100644
>> --- a/include/configs/khadas-vim3l_android.h
>> +++ b/include/configs/khadas-vim3l_android.h
>> @@ -41,10 +41,28 @@
>>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>>   #endif
>>   
>> -#define EXTRA_ANDROID_ENV_SETTINGS \
>> -	"board=vim3l\0" \
>> -	"board_name=vim3l\0" \
>> +#define CFG_EXTRA_ENV_SETTINGS                                    \
>> +	"board=vim3l\0"                                               \
>> +	"board_name=vim3l\0"                                          \
>> +	"bootmeths=android\0"                                         \
>> +	"bootcmd=bootflow scan\0"                                     \
>> +	"adtb_idx=2\0"                                                \
>> +	"partitions=" PARTS_DEFAULT "\0"                              \
>> +	"mmcdev=2\0"                                                  \
>> +	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
>> +	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
>> +	"gpio_recovery=88\0"                                          \
> gpio_recovery is not used anywhere. Can we please drop this?
yes i forgot this part of gpio recovery not needed anymore i will do in v3
>
> With that addressed, please add:
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
>> +	"stdin=" STDIN_CFG "\0"                                       \
>> +	"stdout=" STDOUT_CFG "\0"                                     \
>> +	"stderr=" STDOUT_CFG "\0"                                     \
>> +	"dtboaddr=0x08200000\0"                                       \
>> +	"loadaddr=0x01080000\0"                                       \
>> +	"fdt_addr_r=0x01000000\0"                                     \
>> +	"scriptaddr=0x08000000\0"                                     \
>> +	"kernel_addr_r=0x01080000\0"                                  \
>> +	"pxefile_addr_r=0x01080000\0"                                 \
>> +	"ramdisk_addr_r=0x13000000\0"                                 \
>>   
>> -#include <configs/meson64_android.h>
>> +#include <configs/meson64.h>
>>   
>>   #endif /* __CONFIG_H */
>> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
>> index 77364bbf9cf0..37ef8b8f7a7e 100644
>> --- a/include/configs/meson64_android.h
>> +++ b/include/configs/meson64_android.h
>> @@ -104,9 +104,6 @@
>>   	"elif test $board_name = sei610; then " \
>>   		"echo \"  Reading DTB for sei610...\"; " \
>>   		"setenv dtb_index 1;" \
>> -	"elif test $board_name = vim3l; then " \
>> -		"echo \"  Reading DTB for vim3l...\"; " \
>> -		"setenv dtb_index 2;" \
>>   	"elif test $board_name = vim3; then " \
>>   		"echo \"  Reading DTB for vim3...\"; " \
>>   		"setenv dtb_index 3;" \
>>
>> -- 
>> 2.34.1



