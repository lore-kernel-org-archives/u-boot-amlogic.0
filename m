Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF8D0D798
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:22:50 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.12933.1728656569753606484
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=B4cU9F39;
 spf=pass (domain: baylibre.com, ip: 209.85.208.173, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad784e304so23614671fa.2
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728656568; x=1729261368; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcOy+r/FU3kTGcYOGg4ThM0yvBHKqMIQKZkZP3gB81Y=;
        b=B4cU9F39ZqDcG2lPb8Bxf0ebSYHG5V7rYGvilcweSbzFbegcK+Zg/AfhiebdjAurxq
         q9J0yhwI2R9zKwjwp0/vsEE/fdkHY7o2J7ZQ4DyNeTRfRyyfkVhCpUkel8dG2JWt2Tdn
         BRZg04eTWDgnHgGfU5uOJ51E+80uiaHVutlneAm7zPbFBPwIPUO/9hKFpGAJrT1MiKFx
         d1ZJ5QX0QeqdGC2rSdaBuQ5QmPoA9niwzNRNqvIVLBhfoVIoyRvD4+3FyeeK6stTSw6Q
         YcLIiJ5lL/sky+0BVNO4RwLtRXAkdrKmO3j2dPJAYVUbEpyulIFoQeov77llQ+9ANDYy
         UaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656568; x=1729261368;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcOy+r/FU3kTGcYOGg4ThM0yvBHKqMIQKZkZP3gB81Y=;
        b=Clebg2KqGUQuZ4RknU2W0h1WHuGfSXIqGF7OTYnDRU8eco/aKkwImvr1xg5oAmRc6L
         LZMIcemPOSnsDTVF64uoaonDpMGJl9GI5e5UhoSq3lf2/QTt3A14d1hBuWW2iQfWKThw
         drEa6Tzjhr9OSPWOJzlYIUiDQPPcOSFCcso9TukhRGZ8YFL92VBg2WIC4qpE6NvUPnX6
         nZpSiX2X/HtePFgQOpdw53LFrHO8YbAGItzJT7jlEKkZnCD+mmdzxxaQ3OHgvsT+aD6c
         M9rGo/4BJvZ682+wFyz20efCdYqZTZFr51jxAwb1zrdS/qsJR24tUp33T43/ku9xkgIb
         q1yQ==
X-Gm-Message-State: AOJu0Yzqg9TPjBE2YVMqvU/O8U7Wn3TlFryoxt4EixLWtV1E1zQO1+T2
	iDDtDE18p1wi70au1OV6RYvzgZbnpxN7XnG9tXYUTFu5W29ey27C8dyyEwATw54UkFkBwm/rObZ
	v
X-Google-Smtp-Source: AGHT+IEig3YDLAB+pmbd/bzp+9P6x79a1HR0H1FNpDT5lqV89jsB9J1lPGvFz5zzNnzE+qpYKFMeYQ==
X-Received: by 2002:a05:651c:551:b0:2fa:c841:af36 with SMTP id 38308e7fff4ca-2fb327b0ff0mr17174111fa.30.1728656567556;
        Fri, 11 Oct 2024 07:22:47 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0071sm4022185f8f.62.2024.10.11.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:22:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <17FD1697482D61A4.19251@groups.io>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
 <17FD1697482D61A4.19251@groups.io>
Date: Fri, 11 Oct 2024 16:22:43 +0200
Message-ID: <87bjzqhg7g.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 14:22:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2441

Hi Dmitry,

On jeu., oct. 10, 2024 at 14:17, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:

[...]

>>> > >
>>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>>> > >
>>> > > Can you also update the test?
>>> >
>>> > I apologize, but I didn't quite understand your point. Could you please
>>> > clarify? This patch series includes additional tests for the 'ab_dump'
>>> > subcommand. For more details, please refer to:
>>> >
>>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>>> 
>>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>>> the test in the same commit.
>>
>> Should I resend the patch series with ab_dump implementation and tests
>> in the same commit?
>>
>> I can prepare new version, if needed, no problem.
>
> No need to resend a new version just for this, since it's already
> been reviewed.
>
> Keep the suggestion in mind for future series!

If you do need to re-spin this as v4, you can squash the test commit
with this one if you wish.

>
>>
>> -- 
>> Thank you,
>> Dmitry
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2438): https://groups.io/g/u-boot-amlogic/message/2438
> Mute This Topic: https://groups.io/mt/108927502/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

