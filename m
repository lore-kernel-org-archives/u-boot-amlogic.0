Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90EECF11E1
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 12:17:59 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.41904.1728562670117124999
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2024 05:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=vzLJ6NX8;
 spf=pass (domain: baylibre.com, ip: 209.85.128.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso6791205e9.0
        for <u-boot-amlogic@groups.io>; Thu, 10 Oct 2024 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728562668; x=1729167468; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yct/5vTfEK0KbuV0R39yqWSGgpQy682lpprL4gUtnyM=;
        b=vzLJ6NX8KnuQwWX6Lmq+lQ6MZiOSBs1koSLMdiU7hvteXwJ82J2JZTtN3tthddUa6A
         bb/8Y1vaaQzRrDQo84J2fxfZNpxymh7/4Mgtm6JHJwYeJWr/QO8oil6TDU9ykVO5ZVKq
         6uWwFN4I7tsAUL3KF+v2jI8lWlLpbV8ENTPfF4zxgVU+Mo2dEIjJfzMnefGTcnwJ2Gxs
         4A2z/lBSHsNE15pOoIOfa0gA5+i9XddQwA59pZhXUSmx7+vdmhJUFvOwWa50R/kl6O8o
         pwSshxTQm9aAnbOI9biTP9s8wn/rnnxj304VEp9yGZHzoq/2DRxDrGMZjHLUkKrLeLLn
         WMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562668; x=1729167468;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yct/5vTfEK0KbuV0R39yqWSGgpQy682lpprL4gUtnyM=;
        b=lV+oWVpVWrRrDZCjrrtHidjY8xmC+By3qkuIlYVS+cfU6tdFFyj+hcf7++qkQzIpE9
         rOP7UTVrOpZyMp80Es2k6MKlCxOo8fbVXZLMh3nVNl3r9aWXmrxF3YwOGW0U5kfekgEI
         RFS+ITgWef7NqLapNWXbfAFsRwGVUcQRRR5U3VL8HegtAyRO0U/Os5sdf70ZU4qB0AVC
         GFWmTXuNP6/UoCGVY7pTHessqKqocZ8nYK6iQ962mEWbwyHmZ8jOehNFq/9o4Ve8ZlHN
         xg/Hts4jggtc1LIrdDbgBHkliuMo/aT1+vgvLR3SVi+mV5O9UsnF/HnV0aYazrNr+Cy1
         IuhA==
X-Forwarded-Encrypted: i=1; AJvYcCWgb5i2LZmZ6lENViEpZKaTEwgaJC35UySAX4G7pOryWrZUdGMK/5BGzXmOOA22SrWIVOC7/HViS1ww0766uw==@groups.io
X-Gm-Message-State: AOJu0YzCziMsBhTx95XEEsVT/TM48Vu71+A8GFHeLGnhbUpZL1g8gN0D
	SBiJZQw3RlrtbNH9oIzmW6NdW8/3qRHbQ77RUSUvAdc9vlUckjd8i7eDoFTBD1w=
X-Google-Smtp-Source: AGHT+IECXvqbNp7uku69+CANRCG2CY3TCHqI7JQuc+QtLMQlZIODyZ1EqzstcNY7XENW/ve/OTmaaw==
X-Received: by 2002:a05:600c:1c14:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-430d70b3f8dmr44462405e9.33.1728562668359;
        Thu, 10 Oct 2024 05:17:48 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7929sm14982945e9.4.2024.10.10.05.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:17:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
Date: Thu, 10 Oct 2024 14:17:47 +0200
Message-ID: <87set49mok.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Oct 2024 12:17:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2438

Hi Dmitry,

On jeu., oct. 10, 2024 at 13:20, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> On Wed, Oct 09, 2024 at 03:13:57PM -0600, Simon Glass wrote:
>> Hi Dmitry,
>> 
>> On Wed, 9 Oct 2024 at 07:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> >
>> > Hello Simon,
>> >
>> > On Tue, Oct 08, 2024 at 07:57:15PM -0600, Simon Glass wrote:
>> > > On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> > > >
>> > > > It's really helpful to have the ability to dump BCB block for debugging
>> > > > A/B logic on the board supported this partition schema.
>> > > >
>> > > > Command 'bcb ab_dump' prints all fields of bootloader_control struct
>> > > > including slot_metadata for all presented slots.
>> > > >
>> > > > Output example:
>> > > > =====
>> > > > > board# bcb ab_dump ubi 0#misc
>> > > > > Read 512 bytes from volume misc to 000000000bf07580
>> > > > > Read 512 bytes from volume misc to 000000000bf42f40
>> > > > > Bootloader Control:       [misc]
>> > > > > Active Slot:              _a
>> > > > > Magic Number:             0x42414342
>> > > > > Version:                  1
>> > > > > Number of Slots:          2
>> > > > > Recovery Tries Remaining: 0
>> > > > > CRC:                      0x2c8b50bc (Valid)
>> > > > >
>> > > > > Slot[0] Metadata:
>> > > > >       - Priority:         15
>> > > > >       - Tries Remaining:  0
>> > > > >       - Successful Boot:  1
>> > > > >       - Verity Corrupted: 0
>> > > > >
>> > > > > Slot[1] Metadata:
>> > > > >       - Priority:         14
>> > > > >       - Tries Remaining:  7
>> > > > >       - Successful Boot:  0
>> > > > >       - Verity Corrupted: 0
>> > > > ====
>> > > >
>> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > > > ---
>> > > >  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > > >  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>> > > >  include/android_ab.h | 10 ++++++++
>> > > >  3 files changed, 113 insertions(+)
>> > > >
>> > >
>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>> > >
>> > > Can you also update the test?
>> >
>> > I apologize, but I didn't quite understand your point. Could you please
>> > clarify? This patch series includes additional tests for the 'ab_dump'
>> > subcommand. For more details, please refer to:
>> >
>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>> 
>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>> the test in the same commit.
>
> Should I resend the patch series with ab_dump implementation and tests
> in the same commit?
>
> I can prepare new version, if needed, no problem.

No need to resend a new version just for this, since it's already
been reviewed.

Keep the suggestion in mind for future series!

>
> -- 
> Thank you,
> Dmitry

