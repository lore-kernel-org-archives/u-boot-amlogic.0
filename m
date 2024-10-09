Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35CD1A429
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.28660.1728508449223168666
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 14:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=aWDTvW94;
 spf=pass (domain: chromium.org, ip: 209.85.219.171, mailfrom: sjg@chromium.org)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso224272276.2
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728508448; x=1729113248; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1ZzFY8ew3PgEyyA7L8n1a58td38iOPZJavZPfRIK2o=;
        b=aWDTvW94hzJpWQF+i7ihTvjKSFgA5CTIJk8L/pJERLDU526maOzlTbMOCuYtaAGToE
         dexqBu6iy6Cp2vufFhpGbDJQSpeF7qKtcuy9AnyfbSoWRmw2nXjnjAz8tmy81VCPzaPV
         AR78bt7xz2M14bWMSs5UQVwwh0C10P/SN5+bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508448; x=1729113248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1ZzFY8ew3PgEyyA7L8n1a58td38iOPZJavZPfRIK2o=;
        b=pg7hSZnNx8g/kByZ8qy3AFNJqNUu//xhJO3srbwBhaEFktzV0BQalN/J85EpoVk+wB
         5U/qoHr57vkunN+/4u/Alhpip00mgR5WDN+xf8Hkek0Re79+t0JgY64IaqGgRZPpTv7t
         TaIoGDggRH0gzfXOHGk+VgeWrOavFD6K82Zt9zj+iuoGRRsr9GYfdvG1t8cpHnFDcfJQ
         v24o1qSVNuJ2B5FNjJGEVRCE4ppafwu8mKl1U0CbMVWsIfh4SLdBKHndgcGGP9DGUIf6
         FAcsk83i2920cWvwhC1seIKtB4TVqP5+ntU1vQ5oFhB3YJdGryuAw9VYAmMqyryi4cZZ
         nshg==
X-Forwarded-Encrypted: i=1; AJvYcCV92yc+invKpTqB6nlAgJ/W6DKKvdg9AKtOhAOXswQrrIPTGG9sU/7Bp7G+vGS1Z0tO0G3QSa592V8lMud7Uw==@groups.io
X-Gm-Message-State: AOJu0YwxUO8Jcg4mlyZIdWzb5kjsQ5m6uwMaapoYYNYdC4vTydVwrV/z
	Tgb42WRnvlluZ3apKCQzZk8NJrUBxF5syZQ/dTGEcEFbuXYOruQdoe1ldn/J3LdqOE/1NQoKdys
	Vyu2cq70ibpEikx+PuyVXTWv1s2GaXhwNoJE7
X-Google-Smtp-Source: AGHT+IGMmgFMOhIRUZWbRUVbY8B2v8wdTyV6Y3CTd9wc4tIg5PMLFEwTYB+eogyHnkvX7GhhXaqpNO/01ajFFW+4VR8=
X-Received: by 2002:a05:6902:c06:b0:e22:5c14:4c4 with SMTP id
 3f1490d57ef6-e28fe4f1395mr3223189276.56.1728508448391; Wed, 09 Oct 2024
 14:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com> <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
In-Reply-To: <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:13:57 -0600
Message-ID: <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
	"Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
	u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2478

Hi Dmitry,

On Wed, 9 Oct 2024 at 07:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> Hello Simon,
>
> On Tue, Oct 08, 2024 at 07:57:15PM -0600, Simon Glass wrote:
> > On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > >
> > > It's really helpful to have the ability to dump BCB block for debugging
> > > A/B logic on the board supported this partition schema.
> > >
> > > Command 'bcb ab_dump' prints all fields of bootloader_control struct
> > > including slot_metadata for all presented slots.
> > >
> > > Output example:
> > > =====
> > > > board# bcb ab_dump ubi 0#misc
> > > > Read 512 bytes from volume misc to 000000000bf07580
> > > > Read 512 bytes from volume misc to 000000000bf42f40
> > > > Bootloader Control:       [misc]
> > > > Active Slot:              _a
> > > > Magic Number:             0x42414342
> > > > Version:                  1
> > > > Number of Slots:          2
> > > > Recovery Tries Remaining: 0
> > > > CRC:                      0x2c8b50bc (Valid)
> > > >
> > > > Slot[0] Metadata:
> > > >       - Priority:         15
> > > >       - Tries Remaining:  0
> > > >       - Successful Boot:  1
> > > >       - Verity Corrupted: 0
> > > >
> > > > Slot[1] Metadata:
> > > >       - Priority:         14
> > > >       - Tries Remaining:  7
> > > >       - Successful Boot:  0
> > > >       - Verity Corrupted: 0
> > > ====
> > >
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > ---
> > >  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
> > >  include/android_ab.h | 10 ++++++++
> > >  3 files changed, 113 insertions(+)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Can you also update the test?
>
> I apologize, but I didn't quite understand your point. Could you please
> clarify? This patch series includes additional tests for the 'ab_dump'
> subcommand. For more details, please refer to:
>
> https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/

OK, thank you. Sometimes it is easier (for reviewers) if you update
the test in the same commit.

Regards,
Simon

