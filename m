Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B3C5B541
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.919.1724275086442164305
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Aug 2024 14:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=pxVdno1c;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.51, mailfrom: michael@amarulasolutions.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8657900fc1so15878566b.1
        for <u-boot-amlogic@groups.io>; Wed, 21 Aug 2024 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724275085; x=1724879885; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KMi8C0AJXRHh3lmRYJZnB3PwuOFkimgNngB9W4ADE9s=;
        b=pxVdno1cS308xZPWBdnb729eMwyv8o2asMjyWYIdbnRRBV1xrOG6gPY6EHrvqySG7a
         E6Z5ZZ9Roe6FIe9KYM0MHbqX1us7//yI1imq4FoEIcM7/Pir6ralxzW1zdEF2N9UFEoe
         oOtT9pFf1AufBNItidP+0FO3rev5zO8OQjiy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275085; x=1724879885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMi8C0AJXRHh3lmRYJZnB3PwuOFkimgNngB9W4ADE9s=;
        b=SJPys/iR9fmFFbJOZSDAoeuZzJKuA+FHYJAXAgPzr1GJZvp5GSiI1+FHYENZxNgwfN
         umA8Yif6V7ceclukdLHWbefGh1mkwGstQTRHYcK2pOhL8Ya12VMwdFSxQmy3P4Hd8S/P
         OTK0drQVWlOGqkcOWyXHYcsObxWhhw1og+vpXH6HVnkuGLKLLpcnx9tJOVeMlIzZs9qo
         yPt2MExRl4jfXhx00sdArVsBWM5osNxOMUkpY3E1B29f/CfV+kwGD7StbLwHnWr2tUeZ
         M6K4Gr4taS9jATwGfDXz3DtAgB3htLfoK2Zxx5wQ1AdQKUpWlVKVVDueOtG7jajv7kRS
         Wtvg==
X-Forwarded-Encrypted: i=1; AJvYcCW7e3soGRhZxnuYuc8IG4ZflLaKHwrJRJ3I1MNUpxdeuG2Q9++Qx/mS4hc0kL0wW7d5F93V59YLa8UpM366Ag==@groups.io
X-Gm-Message-State: AOJu0YwyxZOXTgbxJ7K8xLb4NIdxEFFo0H7qAqM64HJHBix2U6Wv8iDz
	9FleqpeakE5/f4LTtPRIxxINyMsi0nMBJuzW9eRQejR91qacVbw+iYr/zoVU4VnX5AihdK81fsl
	3FtHabBjeeB8ztkzZw9bC86cM5nKjgNXDTUJ8wg==
X-Google-Smtp-Source: AGHT+IGDipYZkKfJWEymzdq80zTmK50hLFcxUTfPQS0WYOmcAdqOBsfmKH6uGHYNmi5l4pRhq0XA43fk5xx9GYdoLkw=
X-Received: by 2002:a17:907:7f94:b0:a86:8b2f:49b3 with SMTP id
 a640c23a62f3a-a868b2f4dedmr59305466b.46.1724275084276; Wed, 21 Aug 2024
 14:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com> <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
In-Reply-To: <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 21 Aug 2024 23:17:51 +0200
Message-ID: <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
	U-Boot-Denx <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, 
	kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2361

Hi

I will read them tomorrow ;)

Thank you for understanding

Michael

Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
scritto:

> Hi, sorry, pls ping  =F0=9F=98=84
>
> Thanks
>
> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> > Patchset is based on patchset for Linux (today merged to nand-next):
> >
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salu=
tedevices.com/
> >
> > Here is description from it:
> >
> >  >  Amlogic's boot ROM code needs that some pages on NAND must be writt=
en
> >  >  in special "short" ECC mode with scrambling enabled. Such pages:
> >  >  1) Contain some metadata about hardware.
> >  >  2) Located with some interval starting from 0 offset, until some
> >  >     specified offset. Interval and second offset are set in the
> >  >     device tree.
> >  >
> >  >  This patchset adds R/W support for such pages. To enable it we can
> setup
> >  >  it in dts:
> >  >
> >  >      nand-is-boot-medium;
> >  >      amlogic,boot-pages =3D <1024>;
> >  >      amlogic,boot-page-step =3D <128>;
> >  >
> >  >  It means that each 128th page in range 0 to 1024 pages will be
> accessed
> >  >  in special mode ("short" ECC + scrambling). In practice this featur=
e
> is
> >  >  needed when we want to update first block of NAND - driver will
> enable
> >  >  required mode by itself using value from device tree.
> >
> > The only difference is that patchset for Linux updates DT bindings, whi=
le
> > this adds NAND_IS_BOOT_MEDIUM flag support.
> >
> > Changelog:
> >  v1 -> v2:
> >  * Pls see per-patch changelog.
> >
> > Arseniy Krasnov (3):
> >   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >   mtd: rawnand: meson: read/write access for boot ROM pages
> >
> >  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
> >  drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >  include/linux/mtd/rawnand.h       |  5 ++
> >  3 files changed, 65 insertions(+), 27 deletions(-)
> >
>

