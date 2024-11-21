Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14273D6E2A4
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 09:40:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7151.1732182030907077137
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Nov 2024 01:40:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=xIp/bywY;
 spf=pass (domain: baylibre.com, ip: 209.85.128.54, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so5547245e9.1
        for <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 01:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732182029; x=1732786829; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWgsTywPHfI31OysttwdqY606pvPKxlt5ldON59geHI=;
        b=xIp/bywY24cRglODShp5iGdeUtDuAhcUZWqxm9ke5wOQ8ouwD0EfWa05JK+aHaG3t0
         qcXDYmA8gtaROrfqFZdku1Qdr2NDN66aGeP+Ye8En9O5cbFZwJzsJlXquOo6klvpDPmv
         y6a/hrw1EMrQMvVd4ESm0O2hUDGIGOGG4HlkyaxgiNoGJwAtkqhrE0+IqBNx8fA/KBve
         cjG+V7dhiMpp8cD+XTo5x/9qVjcOpsqsD6Nm2lMWdIPKbPxJNF7Nj+pwoi1PRh/TTtAt
         nvKvUHzEhtU+WLCjxQtZV+M5XT6J+a/j3WaIuUiecdxtEZtnr9mSvnEa7ajE3IiGsHAF
         VSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182029; x=1732786829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWgsTywPHfI31OysttwdqY606pvPKxlt5ldON59geHI=;
        b=vn/Xx0IEjklK4BZzBTqPjGhlmZBLLX1jvY57kFg1gt45eld8jxYcUPbf96zUXhBMLv
         6jagGzLMQtwkX3H/zT9QzhsQrhwri/BPSpnGmzHhq35m4o4O0IqZirik36MoqSp6VdP4
         xlsAVdCL4Wbqdtq5Ife0W+p04L3n2hhhe3XElQ/pdDY5whx1/E4QJ7ytSd1NflJRGF8o
         T4TFHLnCMV9NzPOB61ijWxKIOtXpd3VGl8KIELVVTt5PhljQAIj6vkIeSJ/+dJPBv+C+
         VM9e0lvJosTzdnIivu0izWTaJTKlrLTt/i28LMCN/k3n95KVsqyg8tpBswH0AVMlAtKB
         VEpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpfiTj9c3z8nwx/j6W3ho5ljkzmDJq6SQLg1LkFlMnq4zJ3P4fvk60nP+Zodztf1V2K7qzX5JNrut2MO3dRg==@groups.io
X-Gm-Message-State: AOJu0YwywS0F3mi3jwY1/+UnlygA63yItoojfcbCXZEi2FcA0VDuLoSq
	1x1YamaCBavA4oUCxZKiWG9We9CKAC6OefsT9hoppgd5KLFTck920KD+d+hLiSE=
X-Google-Smtp-Source: AGHT+IE2JrSIldrhiGTv2t/asx5B6rQM6/VdGFmTOjSt3khqjDM/vUVIH8Ln3i+q4Tve+f0hJurIoQ==
X-Received: by 2002:a05:600c:19d1:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-433489867e7mr51026475e9.5.1732182028794;
        Thu, 21 Nov 2024 01:40:28 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933bf7sm4491385f8f.72.2024.11.21.01.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:40:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
Date: Thu, 21 Nov 2024 10:40:25 +0100
Message-ID: <877c8wncvq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 09:40:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2577

Hi Guillaume,

On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.com>=
 wrote:

> Hi,
>
> unfortunately i don't find for now how i can fix issue in test.
>
> i don't really understand with when we launch test individually it's=20
> working but if we launch test_ut test not working ,
> I see on android test for image version 4 to mmc7 in bootflow list detect=
ed.
>
> =3D> ut bootstd bootflow_android_image_v4
> Test: bootflow_android_image_v4: bootflow.c
> scan_mmc_android_bootdev: mmc7
> order 0: mmc2
> order 1: mmc1
> order 2: mmc7
> order 3: <NULL>
> Enabled mmc mmc7 bootdev
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slot=
 a, tries remaining 7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slot=
 a, tries remaining 7
> Older order: mmc2
> Showing all bootflows
> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 Uc=
lass=C2=A0=C2=A0=C2=A0 Part Name Filename
> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ------------=
------------=20
> ----------------
>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_1=20
> /extlinux/extlinux.conf
>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 m=
mc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.who=
le
>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 m=
mc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.who=
le
> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ------------=
------------=20
> ----------------
> (3 bootflows, 3 valid)
>
> if we just launch bootflow_android_image_v4 we have only a=20
> mmc7.bootdev.whole and so test is ok.
>
> if someone have an idea or can give some idea of what i can try or check .
>
> thanks for helping.

I'll have a look

>
> Guillaume
> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>> Hi,
>>
>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>> Hi Guillaume,
>>>
>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>> <mkorpershoek@baylibre.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>> Actually bootmethod android only support android boot image version 4
>>>>> and with AB image, some old platform wtill use android boot image
>>>>> version 2 with AB or without AB slot.
>>>>>
>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=20
>>>>> with 16GB eMMC
>>>>>
>>>>> [...]
>>>> Thanks, Applied to=20
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>
>>>> [1/5] bootstd: android: add support of bootimage v2
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee99=
2e90bbe84278db20d29159e3eedfe0d
>>>> [2/5] bootstd: android: add non-A/B image support
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7=
bd3665366ca2704d1142d3f16f22c36
>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b=
2df5e4cabbaec57a0f2e7f212dbf823
>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717=
f2f33ef0dbb422026ef71938f2265aa
>>>> [5/5] bootstd: Add test for Android boot image v2
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a=
33146f887948d34130229388280844a
>>> CI has found some issues when applying these series:
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>
>>> Could you have a look please?
>> i will check
>>>
>>> Thanks!
>>>
>>>> --=20
>>>> Mattijs
>>
>>

