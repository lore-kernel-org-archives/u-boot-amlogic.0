Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E914D6ED09
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 11:11:52 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.8186.1732187501452857636
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Nov 2024 03:11:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=qMeRwL+E;
 spf=pass (domain: baylibre.com, ip: 209.85.221.45, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so509560f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732187500; x=1732792300; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WptBH79be/xHpGCQR+RCMRy74m8idxdy2atR7o1SHFg=;
        b=qMeRwL+E5jVECJ4dVxM7bg3LG10Qc4CbUYZQTgF+yK7NT5txUmHo8l8jMf7BCe9iXs
         ndvAEvW9urSA9npFA36nVvmNzd094mvRD4KC3LtJgGnPlqw7dWKnCSjFDvBFwwNJzifw
         5v+Lri/9i0bOnTtjvnAjDgFUXrQZoN0f+dtOVlp5bkexPfptMU8bduGz7tcwF+mmtVEN
         QdhWqzAB8ODfKN0zlHzRMXj/k3/c5P3XdWy/gXz89Wj2CsEBrcFAYDyJmwA4DpuhjZoS
         71M10EIv2TLGcfnUWPvqognB115pFsgSarDBfkibYS4yZHZFlovwFGXt/M+irnN6Q8ET
         /7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732187500; x=1732792300;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WptBH79be/xHpGCQR+RCMRy74m8idxdy2atR7o1SHFg=;
        b=WtvIwF5BHP7QaKRpJLzJk/+kGcvhaSnajj/ofoz2VYgSJ9gAeIC1gcT7PJ75q6867l
         T1KYQg9RIFerjZCBodFlv9h2/PtFoHsuadg8e/F9fRHCs55FSX0fZVzkukLX+xv5jtEy
         HO3CsV8DC7mbxWmg4Jxt5/iza4X5x2JLJ//pxUavKF8Ua27RB/1A5E8v/CHilB5JmoZi
         ZPWfmCfVa/qg96m2ocucELH4yx8MQZT4k+avBZAkWSXaDR/lprGxc9SCuNxgDlHqUEUp
         FomlxNkeDPRnOjRSbi/xD5xjypbdwab7wcLnXYndAM4tWpyVP2Ee9UnJ1kIA/CaL5zA3
         ANfA==
X-Forwarded-Encrypted: i=1; AJvYcCUKrvBIr+1n43K40/YFYcv1O5n2W7IpMVGCJ5KVF/PL0D2U05bwjEDi9q+WpBfyKT5nG7pp6/W7riytE3Ejwg==@groups.io
X-Gm-Message-State: AOJu0YyqA1TX7LSxNFO9e5VPSsDkab0wI1kMmtwy02OdGUbWyN0adVST
	xw84PDrwSAGLdQluD27pirgB+z+DJuzReHSoD4GTibddAYwPoRwsYCojtJzmZRg=
X-Gm-Gg: ASbGncsXsrxbUY3BSO5R9xnHpprEKwGG1iChe9w0iJt+TAkWktRjNbCAgYIJP9RcTDS
	2f08p2kl5WbV/Ike+qDa++OxadidGBTH3td0R12Z5egymcL44YSdMlNvZ51YRRXTknBukZqn7Hq
	TYCsVN/pHLhOocOC8PoXJQJTsrD6nid7IlJdQXyGuVRGV56NkF1+SK2FSydnvoaGSGZNMNgkS5i
	ka5eZcn8iUHnGu95i7ZDdRKB0AtrbABqL3FFtV6qgWUTGXFmmvfLg==
X-Google-Smtp-Source: AGHT+IHGEBWxHz15xkeGgnNptxuXrPJ16T9RzK3iSJHSRcGqDY3gGI7hQ5b4MAeDEnSL4o2DVu9RQA==
X-Received: by 2002:a5d:6dab:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-38254ae039cmr4902345f8f.7.1732187499842;
        Thu, 21 Nov 2024 03:11:39 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905421sm4702514f8f.14.2024.11.21.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 03:11:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <877c8wncvq.fsf@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
 <877c8wncvq.fsf@baylibre.com>
Date: Thu, 21 Nov 2024 12:11:35 +0100
Message-ID: <871pz4n8ns.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Nov 2024 11:11:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2578

Hi,

On jeu., nov. 21, 2024 at 10:40, Mattijs Korpershoek <mkorpershoek@baylibre=
.com> wrote:

> Hi Guillaume,
>
> On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.co=
m> wrote:
>
>> Hi,
>>
>> unfortunately i don't find for now how i can fix issue in test.
>>
>> i don't really understand with when we launch test individually it's=20
>> working but if we launch test_ut test not working ,
>> I see on android test for image version 4 to mmc7 in bootflow list detec=
ted.
>>
>> =3D> ut bootstd bootflow_android_image_v4
>> Test: bootflow_android_image_v4: bootflow.c
>> scan_mmc_android_bootdev: mmc7
>> order 0: mmc2
>> order 1: mmc1
>> order 2: mmc7
>> order 3: <NULL>
>> Enabled mmc mmc7 bootdev
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slo=
t a, tries remaining 7
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slo=
t a, tries remaining 7
>> Older order: mmc2
>> Showing all bootflows
>> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 U=
class=C2=A0=C2=A0=C2=A0 Part Name Filename
>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- -----------=
-------------=20
>> ----------------
>>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_=
1=20
>> /extlinux/extlinux.conf
>>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 =
mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.wh=
ole
>>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 =
mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.wh=
ole
>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- -----------=
-------------=20
>> ----------------
>> (3 bootflows, 3 valid)
>>
>> if we just launch bootflow_android_image_v4 we have only a=20
>> mmc7.bootdev.whole and so test is ok.
>>
>> if someone have an idea or can give some idea of what i can try or check=
 .
>>
>> thanks for helping.
>
> I'll have a look

The following command fails:
$ ./test/py/test.py --bd sandbox --build -k test_ut

Running both test at the same time fails as well:
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v

However, running individually, no issues are observed:
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v4
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v2

Going back to look at the v1 series [1], the tests were working fine.

If we use the following base (from [1]), it works fine:
commit 9e1cd2f2cb86 ("Merge https://source.denx.de/u-boot/custodians/u-boot=
-usb")

However, the don't when using this base:
commit b7d4c80fce44 ("Merge tag 'efi-next-2024-11-18' of https://source.den=
x.de/u-boot/custodians/u-boot-efi into next")

I've bisected the issue and I've found that the following patch from
Simon causes the issue:
commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()=
")

Reverting the above patch fixes the problem when running with:
$ ./test/py/test.py --bd sandbox --build -k test_ut

However, I don't understand why Simon's patch causes a duplicate mmc7
dev to be mounted.

I will continue the investigation.

[1] https://lore.kernel.org/all/20241017-adnroidv2-v1-0-781c939902c9@baylib=
re.com/

>
>>
>> Guillaume
>> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>>> Hi,
>>>
>>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>>> Hi Guillaume,
>>>>
>>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>>> <mkorpershoek@baylibre.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>>> Actually bootmethod android only support android boot image version 4
>>>>>> and with AB image, some old platform wtill use android boot image
>>>>>> version 2 with AB or without AB slot.
>>>>>>
>>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=20
>>>>>> with 16GB eMMC
>>>>>>
>>>>>> [...]
>>>>> Thanks, Applied to=20
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>>
>>>>> [1/5] bootstd: android: add support of bootimage v2
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee9=
92e90bbe84278db20d29159e3eedfe0d
>>>>> [2/5] bootstd: android: add non-A/B image support
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e=
7bd3665366ca2704d1142d3f16f22c36
>>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773=
b2df5e4cabbaec57a0f2e7f212dbf823
>>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e5871=
7f2f33ef0dbb422026ef71938f2265aa
>>>>> [5/5] bootstd: Add test for Android boot image v2
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35=
a33146f887948d34130229388280844a
>>>> CI has found some issues when applying these series:
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>>
>>>> Could you have a look please?
>>> i will check
>>>>
>>>> Thanks!
>>>>
>>>>> --=20
>>>>> Mattijs
>>>
>>>

