Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC2DD7877B
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 15:04:29 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.379.1732201461103313844
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Nov 2024 07:04:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Rot5ML1n;
 spf=pass (domain: baylibre.com, ip: 209.85.128.41, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316cce103dso11729795e9.3
        for <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732201459; x=1732806259; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfH5Xi3WDUzoeUSYXg+RXgfHV+/fyqAZja2rvBUMHyw=;
        b=Rot5ML1nF9ZK8O/E0GJk1wnsynQ+UUN0+gElVjEU58mChvvgblb1yu+++qtr+C8ZpF
         uW06vXaECu4CR02CNZyjfIG+iasRq0h4xXQQQ9B2n+cW8yjadLKCJxDfgKEQf7rNvw8s
         +p3MdV4YjYocWrOnlZ87/xKOYWEyFKOZRxwZIf3G/O+07sTy6Zz1VO7ODq+hYcCF2ZKP
         kMICl1O21NQ8zGRsCUctctqjrS3mNV7JbNbHsUTFS61ycgkuz/UhqGMNgMeyBJBB+YOU
         IaJoUqlvtDD9JcpyWlWgigiXNI6VewEn4EvV16/P+TQ3Xy+wMR5jkACbMf5jYUqCjC4c
         pPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201459; x=1732806259;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfH5Xi3WDUzoeUSYXg+RXgfHV+/fyqAZja2rvBUMHyw=;
        b=k8w/3c4wH+5OUns/Zvh75JlO4YWJoBOfbo3IMxlctTKN+uOOY70lutHOZPG68GZGQr
         ikRsOllsA/Vp3ER6m2jEbyEQ3KzPiJJX8v6DMIQ6lK+FJT0jlO9Kzc/TK2MIiqtCJYQl
         cKQFruKCSa4tPPrShSEy4qrYZFhoHsFSS2V7G6yRaHdT3h2v5VUUZuGPzyVP5xZmFjwy
         0NWA/i+jCOj9nDlQo40YrUYmiMX2oawzLkwZIUGSHpojLm5XUkg4oyg64NuHRIAqbouE
         DpjSY+cISTB2mc+0rTp/ItOyGsyeeQe5iNd4x4uzQah1HaWj3fldcP7Z6Ke2laJgaQ/8
         Gx+g==
X-Gm-Message-State: AOJu0YxqO6xsp85noNC/HZOVsZOzc15GHsAfkRtIfCzALcAylKXi11zx
	TwdCcff0mrJyXh1MF+X8odZc5uuuAklviwN3GaGOkNanVFe6kSKNNNGq/+DEPIxXEMkvb86Irgf
	s
X-Gm-Gg: ASbGncukGOmaQkoyuPT1KtA65DGocwhTGLyHEv7Sfhdb+ZKbSyPjf1KSGzk8vmYZey6
	yFzdjmwQa+Qmp4EeTmX7ZMCC+4tMrgoUt04RqTLD0Ulu0k5yiHfhn0T8Wt2TvG3M/nIpBnO33lh
	Vf1JIPHIpdSQZJFvrBSRDsYGO+mQUzEDsH7DuOUd0IbanpaE/qs3xR7wnyWTgQ+eFXa0dWP1Zue
	xg0iuc43B9IMBdSLIUBa88LM7SpqkPSC+t1BG0GEeQo3hFIUIy0AQ==
X-Google-Smtp-Source: AGHT+IH/JUIMQD3LIAqXvDK6Oz6ACNHxyii15HD0lUUEsWr/xIkjGizhA3wMLm+GrVKjDE0mft6Mvg==
X-Received: by 2002:a05:6000:184e:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-38254b012a6mr7003374f8f.34.1732201448039;
        Thu, 21 Nov 2024 07:04:08 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549051c7sm5376493f8f.8.2024.11.21.07.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:04:07 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Guillaume LA ROQUE <glaroque@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil
 Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <87plmolkhy.fsf@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
 <877c8wncvq.fsf@baylibre.com> <1809F75B2A63D1F3.14676@groups.io>
 <87plmolkhy.fsf@baylibre.com>
Date: Thu, 21 Nov 2024 16:04:04 +0100
Message-ID: <87mshsljbv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 15:04:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2580

On jeu., nov. 21, 2024 at 15:38, Mattijs Korpershoek <mkorpershoek@baylibre=
.com> wrote:

> On jeu., nov. 21, 2024 at 12:11, "Mattijs Korpershoek via groups.io" <mko=
rpershoek=3Dbaylibre.com@groups.io> wrote:
>
>> Hi,
>>
>> On jeu., nov. 21, 2024 at 10:40, Mattijs Korpershoek <mkorpershoek@bayli=
bre.com> wrote:
>>
>>> Hi Guillaume,
>>>
>>> On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.=
com> wrote:
>>>
>>>> Hi,
>>>>
>>>> unfortunately i don't find for now how i can fix issue in test.
>>>>
>>>> i don't really understand with when we launch test individually it's=20
>>>> working but if we launch test_ut test not working ,
>>>> I see on android test for image version 4 to mmc7 in bootflow list det=
ected.
>>>>
>>>> =3D> ut bootstd bootflow_android_image_v4
>>>> Test: bootflow_android_image_v4: bootflow.c
>>>> scan_mmc_android_bootdev: mmc7
>>>> order 0: mmc2
>>>> order 1: mmc1
>>>> order 2: mmc7
>>>> order 3: <NULL>
>>>> Enabled mmc mmc7 bootdev
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting s=
lot a, tries remaining 7
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting s=
lot a, tries remaining 7
>>>> Older order: mmc2
>>>> Showing all bootflows
>>>> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0=
 Uclass=C2=A0=C2=A0=C2=A0 Part Name Filename
>>>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ---------=
---------------=20
>>>> ----------------
>>>>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_=
1=20
>>>> /extlinux/extlinux.conf
>>>>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=
=A0 mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootde=
v.whole
>>>>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=
=A0 mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootde=
v.whole
>>>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ---------=
---------------=20
>>>> ----------------
>>>> (3 bootflows, 3 valid)
>>>>
>>>> if we just launch bootflow_android_image_v4 we have only a=20
>>>> mmc7.bootdev.whole and so test is ok.
>>>>
>>>> if someone have an idea or can give some idea of what i can try or che=
ck .
>>>>
>>>> thanks for helping.
>>>
>>> I'll have a look
>>
>> The following command fails:
>> $ ./test/py/test.py --bd sandbox --build -k test_ut
>>
>> Running both test at the same time fails as well:
>> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v
>>
>> However, running individually, no issues are observed:
>> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v4
>> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v2
>>
>> Going back to look at the v1 series [1], the tests were working fine.
>>
>> If we use the following base (from [1]), it works fine:
>> commit 9e1cd2f2cb86 ("Merge https://source.denx.de/u-boot/custodians/u-b=
oot-usb")
>>
>> However, the don't when using this base:
>> commit b7d4c80fce44 ("Merge tag 'efi-next-2024-11-18' of https://source.=
denx.de/u-boot/custodians/u-boot-efi into next")
>>
>> I've bisected the issue and I've found that the following patch from
>> Simon causes the issue:
>> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_test=
s()")
>>
>> Reverting the above patch fixes the problem when running with:
>> $ ./test/py/test.py --bd sandbox --build -k test_ut
>>
>> However, I don't understand why Simon's patch causes a duplicate mmc7
>> dev to be mounted.
>>
>> I will continue the investigation.
>
> Ok, I found the issue. it's not a duplicate mmc7, but we bind the
> bootmeth multiple times, which causes issues.
>
> This can also be reproduced on next with:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
> $ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow=
_cros"
>
> I will send a patch.

https://patchwork.ozlabs.org/project/uboot/patch/20241121-bootstd-test-fix-=
multiple-bind-v1-1-f6c06b9581b1@baylibre.com/

>
>>
>> [1] https://lore.kernel.org/all/20241017-adnroidv2-v1-0-781c939902c9@bay=
libre.com/
>>
>>>
>>>>
>>>> Guillaume
>>>> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>>>>> Hi,
>>>>>
>>>>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>>>>> Hi Guillaume,
>>>>>>
>>>>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>>>>> <mkorpershoek@baylibre.com> wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>>>>> Actually bootmethod android only support android boot image versio=
n 4
>>>>>>>> and with AB image, some old platform wtill use android boot image
>>>>>>>> version 2 with AB or without AB slot.
>>>>>>>>
>>>>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=
=20
>>>>>>>> with 16GB eMMC
>>>>>>>>
>>>>>>>> [...]
>>>>>>> Thanks, Applied to=20
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-nex=
t)
>>>>>>>
>>>>>>> [1/5] bootstd: android: add support of bootimage v2
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7ee=
e992e90bbe84278db20d29159e3eedfe0d
>>>>>>> [2/5] bootstd: android: add non-A/B image support
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e=
0e7bd3665366ca2704d1142d3f16f22c36
>>>>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/885477=
73b2df5e4cabbaec57a0f2e7f212dbf823
>>>>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58=
717f2f33ef0dbb422026ef71938f2265aa
>>>>>>> [5/5] bootstd: Add test for Android boot image v2
>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f=
35a33146f887948d34130229388280844a
>>>>>> CI has found some issues when applying these series:
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>>>>
>>>>>> Could you have a look please?
>>>>> i will check
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>>> --=20
>>>>>>> Mattijs
>>>>>
>>>>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#2578): https://groups.io/g/u-boot-amlogic/message/25=
78
>> Mute This Topic: https://groups.io/mt/109662676/1991006
>> Group Owner: u-boot-amlogic+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@bayl=
ibre.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

