Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2231C3064D
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.135759.1719218260936731626
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Jun 2024 01:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=Nr51eYND;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.208.47, mailfrom: michael@amarulasolutions.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so4171853a12.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Jun 2024 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1719218259; x=1719823059; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ND4MEjNhUWG1UC/XT0vmhFU1y3Ke+pQUvXQAAbb2Zw=;
        b=Nr51eYNDsMRzHeZkt5EBjXvFWVKIPiUiYVNV63ZsB50AOeWb75C19vWjSQmf0P2Azl
         aasvA8RaXz6vPVZBA79+lH7aZHjP4Q7dmJ+y48COHLdjTvEVX/c1C6XW5L0yjhztVfAP
         nNy29C50WISMeXha73AIv14wAc4ZtSGU8J8Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218259; x=1719823059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ND4MEjNhUWG1UC/XT0vmhFU1y3Ke+pQUvXQAAbb2Zw=;
        b=us8fvUJFet51Kr4IM8Zt2lOvzaLzIfgfKG0IYs4xEM+jVPjOsUuP/dJPcwUG3H7cQN
         g3MnfIbA3zU1KmPzC7KOhUdWBJgRXyRxY2erbWCyFlTpaBNEIAsRCtggp6YSVNATYdhb
         Xgw+KmGjx2AQ/epx+G3u29U3HeY8DzGkll+ydUBdQ+O3RUjGRu6ShyRdby9+GFr1iDm9
         W5U2eFaIkBemx3yuvuyzx9Bvx9IkN57vrUmp3R9oJYcitifrEN28IQuq6Dtl8WgI6cSq
         pTEKLfngegzpbDU771KATKF+8woylsL7rL8IuzsWK0RYf1UeFcqKkH5Zjp0DwdjOB0yA
         oa0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkXhCiKmMChHgNlVh/eKNajXHcItTwCQ6sOkXk37pfINBtOrAe7+4hJz8VGSLDxpxIJABhKPhmu9DM5sqEJtkTn2TqTDaIzBU=
X-Gm-Message-State: AOJu0YybqwICb9YefNK0SKzd4kHjxTnkLNjRdShh3WZmbSrKQBPtsIsb
	8um6wnHBg4315yEd7TOXJSxmJvnP11RA2QblerPOTedqkcLW0nRhMb47DqikuJq+8H67E36Z+u7
	+MDxJyeoecdsPT66e7Sd2WYH47TEIM8bP0h8CPqWodY2SkWioJAj6MA==
X-Google-Smtp-Source: AGHT+IHYgLO0QjGwTI3X/hwj/kFMeDPwJfWnQms61MIlVyXYH6JoPTcTLdjUcl766+vmW5j7WYyq+L5U7NYx7p2znlE=
X-Received: by 2002:a50:f696:0:b0:57d:669:cafb with SMTP id
 4fb4d7f45d1cf-57d4bde244cmr2165829a12.40.1719218259254; Mon, 24 Jun 2024
 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com> <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
In-Reply-To: <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 24 Jun 2024 10:37:27 +0200
Message-ID: <CAOf5uwnmMmY5c0zj9Y1EOYxfFJ0mUy9Vvj9-7kZ0=Ry-uVrS_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2324

Hi

Yes I have seen and I will review today and cross-check. Did you lunch
the testing on the other patches series? I would like to merge
at all but we were having some build breakage

Michael

On Mon, Jun 24, 2024 at 7:16=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, sorry, pls ping :)
>
> Thanks
>
> On 02.06.2024 23:08, Arseniy Krasnov wrote:
> > Based on Linux kernel:
> > commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip =
as a boot device")
> >
> > Allow to define a NAND chip as a boot device. This can be helpful
> > for the selection of the ECC algorithm and strength in case the boot
> > ROM supports only a subset of controller provided options.
> >
> > Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 3 +++
> >  include/linux/mtd/rawnand.h      | 6 ++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index c40a0f23d7..ed605b4af5 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, str=
uct nand_chip *chip, ofnode nod
> >       if (ret =3D=3D 16)
> >               chip->options |=3D NAND_BUSWIDTH_16;
> >
> > +     if (ofnode_read_bool(node, "nand-is-boot-medium"))
> > +             chip->options |=3D NAND_IS_BOOT_MEDIUM;
> > +
> >       if (ofnode_read_bool(node, "nand-on-flash-bbt"))
> >               chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> >
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index fb002ae641..4eb880d8fb 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -218,6 +218,12 @@ enum nand_ecc_algo {
> >  /* Device needs 3rd row address cycle */
> >  #define NAND_ROW_ADDR_3              0x00004000
> >
> > +/*
> > + * Whether the NAND chip is a boot medium. Drivers might use this info=
rmation
> > + * to select ECC algorithms supported by the boot ROM or similar restr=
ictions.
> > + */
> > +#define NAND_IS_BOOT_MEDIUM  0x00400000
> > +
> >  /* Options valid for Samsung large page devices */
> >  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
> >



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

