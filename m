Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F993E77198
	for <webhook@archiver.kernel.org>; Mon, 30 Dec 2024 14:05:02 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.12789.1734958648512245499
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Dec 2024 04:57:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=O75xGGOr;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.215.179, mailfrom: michael@amarulasolutions.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fdc6e04411so2585942a12.2
        for <u-boot-amlogic@groups.io>; Mon, 23 Dec 2024 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1734958648; x=1735563448; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZD13oQAbi+cgeDfVij/3RHq+oj2t2uLrgbryBS1OAk=;
        b=O75xGGOroFGrMZtG5c3BODalW17/LYYabTOqii+9b/R2OqNb199fp8Kje8E4RGwilu
         uRjWtsiEn2BnCMceqBKMwTZpF9GLGVVzXoYAeWYPWo5B4jzWrdhOwVC4OkCz1BzyMdV8
         OmpWsICH5aTtWmi9AdsATwHfBI552SseQiOsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734958648; x=1735563448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZD13oQAbi+cgeDfVij/3RHq+oj2t2uLrgbryBS1OAk=;
        b=Kw+GeF5wsOZDun7Sl0Ywdt6xhQ/SqTdcSqrMuqTtfB7P/1e8DSPW6ReFFZplb150TK
         y6lgsTircFeoofk9+/4A9Lr79yqVHHwxTem4bv4XVunRZnSqRIo7tbMf94CZOE25LW+j
         0uNAddnxTWWwW6aKojfCz3pHF3hLanb0lpDvz2jbf5OXBHogjCgOm4gQsXcnDmqpxTvS
         JVidCPZ6NV2wDETm3Dlg0hoJ3iRrc22G+wPGholr+nre9JSttd0xuKHaR7h0u9UMygu4
         s/EpjuNqSqUV7M0JRAuAsHB7ipag9/dOcbMPF1Hu01CEs9qRip29ILniH6BxayF+jSNc
         o/zA==
X-Forwarded-Encrypted: i=1; AJvYcCUV5KtYRHKO3zK8MhSVx1P5mqHZJV/30AhbmTfTztmCTwDhGpPedsrl5Mit5SUOLcTfRwYxsYWbjNp4CxD6Vw==@groups.io
X-Gm-Message-State: AOJu0YyqsEiJbT3XqKiLmWGY/bGiUe8GJBwco28v//2vUDgwENZp1ieX
	ljn6EEae5VYiuTdnkph4Z/tOm3rsE/ctSZYmqitGsAQ8/qfdYCA/3xvoxNwLsI/Tmq/aBKzyw9T
	X0Yj9pWmzRXDKRQAMULueWrPHDW55UVwm+YBZ4A==
X-Gm-Gg: ASbGnctgzG8p4HOwDoFrH1rkWP6WGpB7lWNMHF3qMj9HjCVU7N0In7tPY51g2zZFNy4
	rFiy4NEuvhkomeaJLvDTX6S2t3NYOFBmwuQY=
X-Google-Smtp-Source: AGHT+IEjxvpHJ6eqEWih0OLTElLUoOP6jIxUikvVIMZsWPRRZC2Pz92H/efoHTlaC7l4G2PnySh04O1SJfTvKPLhSrE=
X-Received: by 2002:a17:90a:c88b:b0:2ee:f687:6ad3 with SMTP id
 98e67ed59e1d1-2f452eb0eb9mr17968084a91.28.1734958647786; Mon, 23 Dec 2024
 04:57:27 -0800 (PST)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
In-Reply-To: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 23 Dec 2024 13:57:16 +0100
Message-ID: <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 30 Dec 2024 14:05:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2596

On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL)=
,
> then driver doesn't copy OOB data from 'oob_poi' to special controller
> structures, so zeroes will be written as OOB. But, generic raw NAND logic
> in 'nand_base.c' already handles case when OOB is not required to write b=
y
> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
> always read 'oob_poi' data for OOB.
>
> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
> so need to keep same behaviour here.
>
> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 81122315f4..82a12ac061 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info=
 *mtd, struct nand_chip *ch
>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>
>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
> -
> -       if (oob_required)
> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

I will queue it

>         return meson_nfc_write_page_sub(chip, page, false);
>  }
> --
> 2.30.1



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

