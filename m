Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317FE77188
	for <webhook@archiver.kernel.org>; Mon, 30 Dec 2024 14:04:52 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.33568.1735048577502981145
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Dec 2024 05:56:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=ix71mCeE;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.216.46, mailfrom: michael@amarulasolutions.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so5489200a91.2
        for <u-boot-amlogic@groups.io>; Tue, 24 Dec 2024 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1735048577; x=1735653377; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfbfivRxVkzrTJotmsXRReXiVYHwDjMnDH2ADEzFvLE=;
        b=ix71mCeEXjvqEi/oWZkz28UXDo8RLwlC4mUY6fptY1GDtbgP6ejcyv/LR2O+ToUyyg
         1YVRXZhJwJKkXZ6tQLcQaPn1U91KeJecqNtxnaAaEF2Sv7pJnyNFQNzmlG0EHtCj5MhV
         eIufF8OjBV8fsg+biO8QyVAEj767zWfccFVns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735048577; x=1735653377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfbfivRxVkzrTJotmsXRReXiVYHwDjMnDH2ADEzFvLE=;
        b=nfDILkhN1crXOrXpW2gwhSAK+gCI4StvFvA9phZSWkQ4bWlcAb2OYubzJFSV7rdCnJ
         t0fxcjetvzM1+1TE2Eprcq1WCgUu9FAgJe5ClLK6U8hVNJp8+bwOeTpqHmKmZJ2AEVBL
         SD4D0HL/mu7CjBnxyC3UoTTzqnjznrWt3+lRUm+AheYadyjb1TYF0PBcA+TsXUu20VQD
         tEYQ0US+Nm704AoHzF7JSldvuVXj8o6I9ZudwWdVd87D3sMxSr+ONu75GACSGoN/SrRV
         +OgDljIuQravMYow8pd710vb91FB3aG691nTRlX1b+smFxLRbnl7DpD6UtT6k0AFFUQQ
         ML/w==
X-Forwarded-Encrypted: i=1; AJvYcCUibVYR1R0cgPiwgezdr3RO9NhO+yvnciILXsx90tvoPDe/pmdZ2mvE5jcREeftHCUywInrV13KDicd4KNM1A==@groups.io
X-Gm-Message-State: AOJu0YxoKiCkf8NZpzYl5bgocSmwB3b9XDNG+V+ObdNMqOd9CrJh7tru
	Ux10rABH1eQoRxABL+dkxSKbnEY9aNul7jfG+xwck8qlyrVbN7JorTNkIEp2ko/m7LTJ0b664cv
	j3gwq/zeHclD4kzZaotQXW2s6MmZgOAaW1JZQEycg+HCbVa/yI40=
X-Gm-Gg: ASbGncvaTjeXrWGSlZLNvQo8IcxNGv75bqHu+mTY2B01QlTAg3jE/NyDBJJpmvSIZDS
	VmhUjs91Ycale0wcn7yYIAgPEDaNvmbpRIyo=
X-Google-Smtp-Source: AGHT+IG24bkZ58YNXR3Odzwd7Uoo4zz5PFP6eQAprmQW59EKFqIFJY0AgFigy2F0BfKZPK7z4of3h2f8JtiiKOEotOU=
X-Received: by 2002:a17:90a:d448:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2f452edbd0fmr25330025a91.33.1735048576863; Tue, 24 Dec 2024
 05:56:16 -0800 (PST)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
 <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com> <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
In-Reply-To: <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 24 Dec 2024 14:56:04 +0100
Message-ID: <CAOf5uwn7OAhkhxbjcFYkHdmxy4R_VsqSb7ertn09zPcGpPgQrQ@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@salutedevices.com, 
	oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Dec 2024 14:04:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2594

Hi

Yes

Michael

On Tue, Dec 24, 2024 at 8:55=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
>
>
> On 23.12.2024 15:57, Michael Nazzareno Trimarchi wrote:
> > On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov
> > <avkrasnov@salutedevices.com> wrote:
> >>
> >> If 'oob_required' is not set by the caller (for example 'oobbuf' is NU=
LL),
> >> then driver doesn't copy OOB data from 'oob_poi' to special controller
> >> structures, so zeroes will be written as OOB. But, generic raw NAND lo=
gic
> >> in 'nand_base.c' already handles case when OOB is not required to writ=
e by
> >> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
> >> always read 'oob_poi' data for OOB.
> >>
> >> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same wa=
y,
> >> so need to keep same behaviour here.
> >>
> >> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 81122315f4..82a12ac061 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_i=
nfo *mtd, struct nand_chip *ch
> >>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
> >>
> >>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYT=
E);
> >> -
> >> -       if (oob_required)
> >> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> >> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
> >>
> >
> > Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > I will queue it
>
> Thanks. You mean it will be merged to https://source.denx.de/u-boot/custo=
dians/u-boot-nand-flash ?
>
>
> >
> >>         return meson_nfc_write_page_sub(chip, page, false);
> >>  }
> >> --
> >> 2.30.1
> >
> >
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

