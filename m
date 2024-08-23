Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A4BC5B54A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:25 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.11454.1724400639478199667
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Aug 2024 01:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=patQVyx2;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.208.173, mailfrom: michael@amarulasolutions.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so25138261fa.1
        for <u-boot-amlogic@groups.io>; Fri, 23 Aug 2024 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724400637; x=1725005437; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzJK3iM0w8U7WyyNHLMy+vVzW9roXN6bQ3bF10Diwic=;
        b=patQVyx2qPpr8vB3Td4hylqDso1dJJcQq9ArnBr6y/AqnFpvoPjxNysoDSO6OIOQgy
         qru3C3G7N4f6hFW3m2psSGZG5v52wnu2/LH9WjoUh+WKwAYQpaBN/hZrse0tpvXNUZQP
         Y74NbVklZ5v3+P0OATXN4gUjWSIOy28caDH98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400637; x=1725005437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzJK3iM0w8U7WyyNHLMy+vVzW9roXN6bQ3bF10Diwic=;
        b=WhTy6TrBA2vl/pw4vEx66dsyB0heNVUXEwdDBefetQdUw+1xKq8tkRYSDW4Ch3F3kP
         reRdAdYOsl0vyyJhDSxDTJb/XDW/39TsHdVdP2rN45lMjBOrtiK4/st7uDD5+q7Wqmdz
         p3crsQkg1fxPjvcsYo3AwglEPn8ms4yV/3UK1Rv++d+OCy0G6IcqUiN/mKaKTmbBkZzs
         jWPq5AEpM+9qCjUFK2JyrjCohgaPpxPKwIJSWldujU/ByS6SSgmn2J7F0EBt6DpVAnI8
         15Go1FAhMvxWDcdelYlGcNKlgnsVKq6XAK6hN0Joecc+e2vBrBjyjTox81btZvXhCiTJ
         GXYA==
X-Forwarded-Encrypted: i=1; AJvYcCWSuUph1MKeW5glyqKCcbhY/OsnZJkRi1bvUXd/2Or9kYwNoLlAWMmbtTj3R+4TYJqTeh6j66StfpVOqXLdrQ==@groups.io
X-Gm-Message-State: AOJu0YzNtUVnbYLa92F6LZzPtTBu7REHKh4yKH1BjCtQTkE6kfs23Eua
	hRn9vHicloV7oCcuipox8Vb612YTJPWzL1pE3qr4ifesDLa1n2yKOf9K+TAIDbakvI9gIPzmT1Z
	9Q7XD+oaoppE7J//4nzcr6DzdwSRsmRr5HmQKmg==
X-Google-Smtp-Source: AGHT+IHcUeAr+70IxxFcfv0eey6h/QQN3ytSBL+ileJ12GGUj+fEJfjkaTmC5RsqXEXTuhCUiMovJtuiTllsan+H+iA=
X-Received: by 2002:a2e:361a:0:b0:2f3:cd65:cf65 with SMTP id
 38308e7fff4ca-2f4f577655emr9448881fa.28.1724400636908; Fri, 23 Aug 2024
 01:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com> <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
In-Reply-To: <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 23 Aug 2024 10:10:25 +0200
Message-ID: <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2364

Hi Arseniy

On Thu, Aug 22, 2024 at 9:04=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, thanks!
>
> Thanks, Arseniy
>
> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > I will read them tomorrow ;)
> >
> > Thank you for understanding
> >

All the series are delegated to Neil. I will review anyway but I think
that will then pick from him

Michael

> > Michael
> >
> > Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com>=
 ha
> > scritto:
> >
> >> Hi, sorry, pls ping  =F0=9F=98=84
> >>
> >> Thanks
> >>
> >> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> >>> Patchset is based on patchset for Linux (today merged to nand-next):
> >>>
> >> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@s=
alutedevices.com/
> >>>
> >>> Here is description from it:
> >>>
> >>>  >  Amlogic's boot ROM code needs that some pages on NAND must be wri=
tten
> >>>  >  in special "short" ECC mode with scrambling enabled. Such pages:
> >>>  >  1) Contain some metadata about hardware.
> >>>  >  2) Located with some interval starting from 0 offset, until some
> >>>  >     specified offset. Interval and second offset are set in the
> >>>  >     device tree.
> >>>  >
> >>>  >  This patchset adds R/W support for such pages. To enable it we ca=
n
> >> setup
> >>>  >  it in dts:
> >>>  >
> >>>  >      nand-is-boot-medium;
> >>>  >      amlogic,boot-pages =3D <1024>;
> >>>  >      amlogic,boot-page-step =3D <128>;
> >>>  >
> >>>  >  It means that each 128th page in range 0 to 1024 pages will be
> >> accessed
> >>>  >  in special mode ("short" ECC + scrambling). In practice this feat=
ure
> >> is
> >>>  >  needed when we want to update first block of NAND - driver will
> >> enable
> >>>  >  required mode by itself using value from device tree.
> >>>
> >>> The only difference is that patchset for Linux updates DT bindings, w=
hile
> >>> this adds NAND_IS_BOOT_MEDIUM flag support.
> >>>
> >>> Changelog:
> >>>  v1 -> v2:
> >>>  * Pls see per-patch changelog.
> >>>
> >>> Arseniy Krasnov (3):
> >>>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >>>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >>>   mtd: rawnand: meson: read/write access for boot ROM pages
> >>>
> >>>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++--------=
--
> >>>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >>>  include/linux/mtd/rawnand.h       |  5 ++
> >>>  3 files changed, 65 insertions(+), 27 deletions(-)
> >>>
> >>
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

