Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36996D5A6EF
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:03:11 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.40820.1732608187443933021
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:03:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=MSaIhKOB;
 spf=pass (domain: baylibre.com, ip: 209.85.128.42, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a45f05feso9621655e9.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608186; x=1733212986; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMOQpomcuAjM7OMIKK4o9zAv9bVdyoTZnabgN7EeIxI=;
        b=MSaIhKOBqpCbkkUFPI2egyhHxlm2thohxnD26/Qbq7sfwXlm1a7x04RZwde9yz+UW+
         H4g1yvbOGBVSjE2lYJybESSv3RsbA2P7vQpHFZG+UQpcD30B8zgP+PgvexudC12QIN32
         /N2ueo1+vjRZS/cldzzgIBkrCoRA5SRHStBBNBFlwFFNfJxva/lMHz3yqXKtn/+lfU4l
         FT0dhDaebK5fU59MHxouVbC8AgbyOJAx2jaPZL4JhBA7QgonLZ5Bf8WEC4RDuKQegJza
         7jRyiQswUz6z1a+JbHRijQrdzmI3XQqkLy88aOinPGBNjNG3mSMbQHn5JIaQkwTUsn9W
         AdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608186; x=1733212986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMOQpomcuAjM7OMIKK4o9zAv9bVdyoTZnabgN7EeIxI=;
        b=wzbp0C8/oCX0pWIuwrl89JhTi7+GIRz1qeiJB7ezQRfrFDEmq7P+dx8ra9fAjuWb8Z
         5WVsTdzz18qE2d0M7EqecxyNxE6ew+pXn6hVAuD7s23qe7nZ09ChB35T5VC4hPygPcPa
         iFXPLaNrCMGsODyv96oZMxT3G4g0dzliumDZg9eyxcIZisFhbGAicjVOZuPfvHwovJYq
         4Bqp8t6AoUhzde+VIK8McpYy08FY6thmeEB8KeZdbs8d6mhour5u78W852IyyhvdGre6
         19G5U9TTpMS5qSpAPXjqpu1PEz9cNgmABHmA1xykb1+HMERkVZ/fxUwsL31m9ZK8re82
         rbpA==
X-Forwarded-Encrypted: i=1; AJvYcCXq+yDKaFbkdf3qK5xNnZc6MO3Ngmm5RE0l9nhCjXCw7Z71TcTPW4EI43uv3lAcSTCd/vNWGIXHZgnZ7RUbFw==@groups.io
X-Gm-Message-State: AOJu0YzlRB6P4SAYgPw+sKwW4fijLZi3QuxeldVmbwHZAqZrDOW2X//S
	2JJoKtgv8wf4B4rLc8WwtEIsKa6K8MmVXq683xi2VMbMGr/q+6FUgSfOobfWrwA=
X-Gm-Gg: ASbGncs5x0X0Fsoq8eZNbcU8fCsaWZUZQY7Re631+1ZqXp6gUN8PM0W34zma9+RMS8r
	LQh+MPJv9pUKs7UHpMJJYB42q8/imteccfJ4NYnyDPuk8Tit/gcpT650Hat/4HY8/cMvoGfCMtf
	GgTCW8N3BuVR+LXMkO2QTj5Bbq/ckhcUaAC8+K7uSaPGHwG+vogrw2pc3o26NiX3BCMc5qDrdc1
	4iz41kdNV9u0vzWHy4CTICjT035TWH+kO4CZ6PZbPTKzWREAIobzNvtjMw1xysT1P5OfWJMgdYQ
	dSbgCfMzyQjHiVtwU/sMhg==
X-Google-Smtp-Source: AGHT+IFAfyvf7aVhTKT5OyuDHDDmDnfWhuuhylU/ootwcvZcJ/YJSXbgyYhhWOBQOI5QgJjr8xG8tA==
X-Received: by 2002:a05:600c:3ac3:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-433ce410255mr155896445e9.5.1732608185602;
        Tue, 26 Nov 2024 00:03:05 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:3c0b:832b:cf30:eeea? ([2001:861:d40:ed60:3c0b:832b:cf30:eeea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43499bdfc0fsm96647115e9.19.2024.11.26.00.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:03:05 -0800 (PST)
Message-ID: <6b46f8e0-acfd-48a8-a54f-e1e35e572138@baylibre.com>
Date: Tue, 26 Nov 2024 09:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <1809644DD9DF8FC7.18574@groups.io> <87serfbjq6.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87serfbjq6.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:03:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2582

Hi,

Le 25/11/2024 à 13:06, Mattijs Korpershoek a écrit :
> Hello,
>
> On mar., nov. 19, 2024 at 15:16, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
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
> Due to the test regressions discussed in this thread, I'm dropping this
> series from the u-boot-dfu tree.
>
> Please submit a v4 targetting next once [1] lands in next.
next was update so i will send v4 today, thanks for fix on test.

Guillaume
>
> Thanks,
> Mattijs
>
> [1] https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/
>
>> --
>> Mattijs
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#2573): https://groups.io/g/u-boot-amlogic/message/2573
>> Mute This Topic: https://groups.io/mt/109662676/1991006
>> Group Owner: u-boot-amlogic+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
>> -=-=-=-=-=-=-=-=-=-=-=-



