Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF2D1A443
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.5964.1728439047796379744
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 18:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=KXQE70Wt;
 spf=pass (domain: chromium.org, ip: 209.85.219.52, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbc7976a6dso4170916d6.1
        for <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728439047; x=1729043847; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pIbHQoLunftIinQY8Ln27ftQhEoMf6EpA08zh4sRTI=;
        b=KXQE70Wtlee2L3EjZA4lbwgqvMGdM5RoB1mBr9YO8MIoPkHPytZewf7j1/NV+Bjfok
         HdBuWiLgzQPm1GRih7scOq3IVK7mN9wPPQ9pw7KQm5qMBNuDslaA0ohbfOBZGxn+HSJK
         sysxNZbpS0XJZsEHGqx82wVE5XDRlM77GqtSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439047; x=1729043847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pIbHQoLunftIinQY8Ln27ftQhEoMf6EpA08zh4sRTI=;
        b=G7aPV37ZSU74aop8pidHz3O7s2DTzGcO8L9gM79g5S49PYvpJ/XqJXOupm3i9BQA30
         XpdfbkZV2kM/ChVlj8wSZH+5D17nQXuIwBwbUIALpjvGnEuRg4HQnmJuBcF+MSzJ/3bP
         ctlNl7CKETOJqwZ2dR6Yr/zfSD2qfkcNlqBgVDu7PpYa6ZlkI+1adGDWjAMAf6JpUvEb
         RGCb8XZzcUl6sCn0gj+irhmNxHUJWQAa1S/kpQOkrUdTM70CUb2ijax/TYUXvRQC5mg9
         P/NIeFy19+Df+8zkb0CSEJ/Q7uPtR8VfVIqDb9D5qo45Q6vFHh9EFA12F0fm3tI0bunY
         WtsA==
X-Forwarded-Encrypted: i=1; AJvYcCWavEP+MJlJwFd/f3IqiM9SAPEG4+zU9CmW9FV3WU1WQzMQYj6mgvWqnOJhSlBhIfnufCfNwyEDuD3VTJOtqg==@groups.io
X-Gm-Message-State: AOJu0YxEDQ64UULXPsN6h4Yt+oVwVp0455hWYHENr5ToNzKKAJ3IYNhy
	1485ELDwziv+xqcBQCTx7CUeoYFyF1Xl7kiYNE8dT5zRGgIk+UMWrTBLXDV4IPiO0hQHku2QcGC
	r3rYqp5QOmA+vIUJlo2V4Fzech5+UlxRu9ct2
X-Google-Smtp-Source: AGHT+IG9o8XvhScOIJ2obJfSs+zP22fDBtvtJP8twsULQFCWLWlWXtLG1zR51Rii4UUvdZzqdr/UJC6T0esiq6LD2vE=
X-Received: by 2002:a05:6214:5a04:b0:6cb:3c1e:76d0 with SMTP id
 6a1803df08f44-6cbc95a0b7emr16388846d6.40.1728439046899; Tue, 08 Oct 2024
 18:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com> <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:15 -0600
Message-ID: <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2473

On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
> > board# bcb ab_dump ubi 0#misc
> > Read 512 bytes from volume misc to 000000000bf07580
> > Read 512 bytes from volume misc to 000000000bf42f40
> > Bootloader Control:       [misc]
> > Active Slot:              _a
> > Magic Number:             0x42414342
> > Version:                  1
> > Number of Slots:          2
> > Recovery Tries Remaining: 0
> > CRC:                      0x2c8b50bc (Valid)
> >
> > Slot[0] Metadata:
> >       - Priority:         15
> >       - Tries Remaining:  0
> >       - Successful Boot:  1
> >       - Verity Corrupted: 0
> >
> > Slot[1] Metadata:
> >       - Priority:         14
> >       - Tries Remaining:  7
> >       - Successful Boot:  0
> >       - Verity Corrupted: 0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>  include/android_ab.h | 10 ++++++++
>  3 files changed, 113 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Can you also update the test?

