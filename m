Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF858D63938
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 12:57:03 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.12605.1732107414032317913
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Nov 2024 04:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=lJr950ky;
 spf=pass (domain: baylibre.com, ip: 209.85.128.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-432d86a3085so40257195e9.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Nov 2024 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732107412; x=1732712212; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkVFgaRDwf7z4n4lpcwh4MPreti3lTKYhW0vgfPUMVI=;
        b=lJr950kyblZQlkgnGnig1FT5vnv23Ip16MEs5rQzKrGF+eUZmbGT33MvTyIBRt4/wv
         E/77teRu0sI1rifCHOTJy4wbo4GANEPZTfAu2v1jr+1Ha+w2en1MUdp3JqrMv0y55+CR
         tlmOT4H9THk7m5nB5Sr8zCvR941doav6v3KrUEDkjZgFi2ZsyVBbb4dq3ZcpD6yYfveD
         V94rH4FYfkkatPZOPLhj70JvOhmoaaMU//+hbBSkwo5s9xlyh+NylZKCH8rkSDMGyDcD
         EvrI8JYlB1B6oJrkcDoejuuvGvWw88C05lmXAOh6WKpyMtpSO914wvHBKmFP9soM45g2
         3O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107412; x=1732712212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkVFgaRDwf7z4n4lpcwh4MPreti3lTKYhW0vgfPUMVI=;
        b=dYYmOusDg/LrdWcvyeA0+r36FVN1sLXJuPGd3FlITgc9C+6fRQmZkIyelRPYMCVPv3
         doeFFYISGHhLWfo3nSZm6P9Byn3HdEJABPxjidWg+meM3n343SSwH3jEXJnMW0HEEl4f
         zKABQRHIO6bwvSVRfiK+4eLkwg042ggEzxnf+fwoHvmqW2SqGV/GBZ3vBtC3Te8DRkmx
         tDC20IehS38SCyVC/++ppWiyPs0s2LUMRWbe7V7MYrhh2tj893tSplJ+IaKVDoEJOyXY
         eTT5nx2FgoleixY4hwrOUCIO7Yptt+SNJC1m/bMqJz6B6Knv2ShT+WpIk2jF6i5XFhVM
         GeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfe34wMbkTrjeDsb1AjhgbfuS+TaifdaiSjDOs+hN5IOYhpO+60QGIJXR4YHhIkWVfxYKHPmrxDfV7/jTUVQ==@groups.io
X-Gm-Message-State: AOJu0YwShhFqUDcOIKxYlno3m3LbhRqDJbLr1eEca/9LcnQIEyIDUu3o
	tFVh8vZeyppvuK3Vod6zMKTYJOh7OC4BBm+wOoPcZJqkZDYkLB+zu4wJcaazeo0=
X-Google-Smtp-Source: AGHT+IGvb8Gp4vrSqd8+L/OVAzmvfbm/xX7sEzxiy/f5wBe97V5OWtPTIecAx/7BBjnQI6TifkuQPQ==
X-Received: by 2002:a05:600c:4712:b0:431:518a:683b with SMTP id 5b1f17b1804b1-433489cac2dmr22961055e9.18.1732107412398;
        Wed, 20 Nov 2024 04:56:52 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea? ([2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1188sm19256995e9.1.2024.11.20.04.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 04:56:51 -0800 (PST)
Message-ID: <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
Date: Wed, 20 Nov 2024 13:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87mshvxhq3.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Nov 2024 12:57:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2575

Hi,

Le 19/11/2024 à 18:21, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>
>> Hi,
>>
>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>> Actually bootmethod android only support android boot image version 4
>>> and with AB image, some old platform wtill use android boot image
>>> version 2 with AB or without AB slot.
>>>
>>> This patchset add support of both version 2 and non-AB slot images.
>>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>>>
>>> [...]
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>
>> [1/5] bootstd: android: add support of bootimage v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
>> [2/5] bootstd: android: add non-A/B image support
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
>> [5/5] bootstd: Add test for Android boot image v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a
> CI has found some issues when applying these series:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>
> Could you have a look please?
i will check
>
> Thanks!
>
>> --
>> Mattijs



