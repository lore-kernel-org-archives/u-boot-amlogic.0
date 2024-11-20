Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C6D711D3
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 17:54:46 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.20534.1732125282866918238
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Nov 2024 09:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=jJxDuzks;
 spf=pass (domain: baylibre.com, ip: 209.85.221.44, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38242abf421so1772081f8f.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Nov 2024 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732125281; x=1732730081; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mSSvYR6M3LefEAuVMqo653aoAx3Hdp8FcheopxUrD8=;
        b=jJxDuzksbDf45WRg/plYDqKqN7BrkkjfOHqiIIrzdeIR643RU32u7j2zYnzXFkDOzI
         1MZL0sUDKvYkhvZcIL6tO/Aii7cEqnP0/GzDjCLvPQHGh3mrycspgeNkH/Piib7HjG5M
         6i/ZcY/ehX4hpCu9b3aT91C+lr1z2v1T0S8B8yHLVKB2hT/y4QwPPUSlNVk++wn3bseo
         vsf5ONIjW084t0sEwH7ExR2Uy/6kWeSByQu1VRKdvd7HIMmtZzEVyRJ6yVP3AVZBl3yj
         fcSH3nGrM63D5rtzLfNw+On2h40gA4dXBDuSjE+se9pKFu5UxKbDUwKB7EGNYYVp/JTM
         yWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732125281; x=1732730081;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mSSvYR6M3LefEAuVMqo653aoAx3Hdp8FcheopxUrD8=;
        b=Rv4h87sZEcCKXRfyXtGibcQlO+Eaqwo6g8s32qgk0xFbrn9nJCTRnFJxH7x+vA7LOf
         WSdaCUp4xQvAXBoqnbKeFhUwGuibvkhoPX5NDgqJ8nN1mpGm6CUcrftFSxFv3zzKGfah
         K4pmbaHCip1Zmvn5GeJSK2gUhkl/bFHPjynbX3y3Fu464sp+8gb+1zPTo378cCrAP7ta
         0TB5Up08Dwh7iHlgU7USEmlezZf5lMRwvad+sukI80wUqC1nNx3FvBsWfhRR1aH02p34
         YzHzdVIg9hnOAr9HqP34Tvp2o9bv9U8i/pqTCM4/1+ooJUjONfVQCBgeyIH2x6xeMpnX
         /BGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3jVjnTzUzoCvC3VpHSxhqvARav6741pSbcHr9EON8LjhC3b7ymCjwI8tWSiqQppDdCqXDUaRz6bv2lGReA==@groups.io
X-Gm-Message-State: AOJu0Yz0gAIaRrViC6bhBVFgalmwhxBT5eUZtgb4YaVMVTUSpdt6hMWC
	/V+hmnnQ8FbWdxPdHvYgm9Hv04wcGhk3z/d1Vc9sbDQLMmL4Al26rsgZzPzFeSaKuRrGI5yNeXF
	4ebA=
X-Gm-Gg: ASbGnctggM+B5GPjwilC7CKlFBHCIJidQ6OuXird98zjyDR4bxoWcYurhE45LyEGckg
	mKGGmjfO200x4IBCAe2lKyAD7Q3eIznYWjN/fTzT5GYDVdVH3hmYhq921hjZ6Xd6Gum0WFOGoYZ
	ribelDj4oCuh2aScRqT/i1IiC5P8amfUnXTvkXIMOEhQvAEx2H7aQMY88qTv02RATTsLPpQ92LL
	swNzKcmlTV2fW9jbDI4qvy/RZ7mJ6jmwJyzxa+6VKN/qAeFW+Pj6bKreWc3RSK+oCaW6R6Sq4Ie
	LdMdVq4Amwrf9GMVo4XYEA==
X-Google-Smtp-Source: AGHT+IE9Y5ni/jOADx8OiZZLaFP32DV2Oo+q4BoE8Z8SwMZ19e2RF3iLZMLxsenE2TSChJWQSLsqtg==
X-Received: by 2002:a05:6000:1541:b0:382:383e:850e with SMTP id ffacd0b85a97d-38254ae5da8mr3235957f8f.13.1732125281262;
        Wed, 20 Nov 2024 09:54:41 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea? ([2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905495sm2669140f8f.20.2024.11.20.09.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:54:40 -0800 (PST)
Message-ID: <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
Date: Wed, 20 Nov 2024 18:54:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
From: Guillaume LA ROQUE <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
Content-Language: en-US
In-Reply-To: <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Nov 2024 17:54:46 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2576

Hi,

unfortunately i don't find for now how i can fix issue in test.

i don't really understand with when we launch test individually it's 
working but if we launch test_ut test not working ,
I see on android test for image version 4 to mmc7 in bootflow list detected.

=> ut bootstd bootflow_android_image_v4
Test: bootflow_android_image_v4: bootflow.c
scan_mmc_android_bootdev: mmc7
order 0: mmc2
order 1: mmc1
order 2: mmc7
order 3: <NULL>
Enabled mmc mmc7 bootdev
       ab_select_slot() ANDROID: Attempting slot a, tries remaining 7
       ab_select_slot() ANDROID: Attempting slot a, tries remaining 7
Older order: mmc2
Showing all bootflows
Seq  Method       State   Uclass    Part Name Filename
---  -----------  ------  --------  ---- ------------------------ 
----------------
   0  extlinux     ready   mmc          1 mmc1.bootdev.part_1 
/extlinux/extlinux.conf
   1  android      ready   mmc          0 mmc7.bootdev.whole
   2  android      ready   mmc          0 mmc7.bootdev.whole
---  -----------  ------  --------  ---- ------------------------ 
----------------
(3 bootflows, 3 valid)

if we just launch bootflow_android_image_v4 we have only a 
mmc7.bootdev.whole and so test is ok.

if someone have an idea or can give some idea of what i can try or check .

thanks for helping.

Guillaume
Le 20/11/2024 à 13:56, Guillaume LA ROQUE a écrit :
> Hi,
>
> Le 19/11/2024 à 18:21, Mattijs Korpershoek a écrit :
>> Hi Guillaume,
>>
>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek 
>> <mkorpershoek@baylibre.com> wrote:
>>
>>> Hi,
>>>
>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>> Actually bootmethod android only support android boot image version 4
>>>> and with AB image, some old platform wtill use android boot image
>>>> version 2 with AB or without AB slot.
>>>>
>>>> This patchset add support of both version 2 and non-AB slot images.
>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board 
>>>> with 16GB eMMC
>>>>
>>>> [...]
>>> Thanks, Applied to 
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>
>>> [1/5] bootstd: android: add support of bootimage v2
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
>>> [2/5] bootstd: android: add non-A/B image support
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
>>> [5/5] bootstd: Add test for Android boot image v2
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a
>> CI has found some issues when applying these series:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>
>> Could you have a look please?
> i will check
>>
>> Thanks!
>>
>>> -- 
>>> Mattijs
>
>


