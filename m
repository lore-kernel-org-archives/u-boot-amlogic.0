Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B458FC35FF8
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:19:28 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.45752.1742191806897791199
 for <u-boot-amlogic@groups.io>;
 Sun, 16 Mar 2025 23:10:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=Dasfk6t2;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.216.54, mailfrom: michael@amarulasolutions.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so2632926a91.2
        for <u-boot-amlogic@groups.io>; Sun, 16 Mar 2025 23:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1742191806; x=1742796606; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Im+SEKkBx0ka4Rb93/n+FPrhbHZgh/rtT60QCwpXH14=;
        b=Dasfk6t24PxS4CKGJydanOrIkfnZw2WXLaMru2wmNkgdfQHatsHuMOr+ejEZTsu1H4
         PIAV832bQNyuR2YsiHsBS8TsvdRreT2jhCzu9wgsFr/+TwGqstMcHXH7jDRvHBB83wLk
         V897sv1zzRx9meD9380FReLwV5tfi0/OdurR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191806; x=1742796606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im+SEKkBx0ka4Rb93/n+FPrhbHZgh/rtT60QCwpXH14=;
        b=wHOxKFkM0FrghVvmdVm9FhevQ1Q86t+JN9krDOM6Tq1YWyzg9zwZ1bz9aBKlRgV9uQ
         h3NVVlmfwlNMmr7qh1NuTB0u3QB58OJ263PP+VXzfoWrK8H7V0g3jZS2v+3ufk2y1+d5
         mw18+E1adCoZtrSbjsUT22iH+zWTxJYLDhv90+kdhy/FLy2ojgx9FwQU/5N+98StgnW1
         IaRl1yakHS/mWPOeYD80ClZzu6TV2UKgZi7oHR0ORa42DyiOeDb0bm6HONLKpu26k4wE
         XUwQM8GKjuhLJggdnDsfLwlc66KpPvUn/Iy/szVCm2eEyf8/xSeK+w4NCxylEutPmJcq
         rlAA==
X-Forwarded-Encrypted: i=1; AJvYcCWgR/Ny+kH8NlpaCWtxGiDEMCfg1K5vBr7qQHmU8Ridk17WKQyLrIYCiABduh5qiE0p4psBuF1MyDuu7gSf5g==@groups.io
X-Gm-Message-State: AOJu0YwzihFTbGtdpzsYZfONxdh1kxKxvh5Ne4RPsQd92re0iftuCDd6
	gtbzEQxHDV6k4lqJhwem1EcFqlUS2ji6bjdc+/UTfj/qolitHsUHEAyryzs/D1Btbtpp2VQOkgy
	52N8N+nQhmI56y5evSYbYWyxZJk/duu2P/gTDHQ==
X-Gm-Gg: ASbGnctDsBsSNEEL0leR+qtG/NG8J03yOURaxMkMKNg6faXPqN8myMROoJcQ6crQmbF
	FlxgCnakkYn+xowsBY+z7TSnVWgEo9v8DJI+Phr0VJYxh/HvC/bvNC8iL8osOEX7PhmTdmcdTXb
	Ok101d8kS4ODTdDMqlk+YDfWk=
X-Google-Smtp-Source: AGHT+IHkpQqn2hEpVGLNHyxc7AUNlmVvQh6llwp3StzTseehZSMTTR6t/moamhnqdIZWfWvj/W/vmp9tSnHjmJM5/nQ=
X-Received: by 2002:a17:90b:1dc3:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30151c9a5a3mr16450140a91.14.1742191806228; Sun, 16 Mar 2025
 23:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
In-Reply-To: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 17 Mar 2025 07:09:53 +0100
X-Gm-Features: AQ5f1JrWT1PwikHmpOV9wPTIaeF7k-8UjcDBB-EZiXkzx_fzJ4Sx5-z1EKI3GUg
Message-ID: <CAOf5uwmftbyysOL_Gf1BRgQmP7EyCS_=Jn5ge4KUbA5efbe_Hw@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 17 Mar 2025 09:19:28 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2630

Hi Arseniy

On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov <
avkrasnov@salutedevices.com> wrote:

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
> diff --git a/drivers/mtd/nand/raw/meson_nand.c
> b/drivers/mtd/nand/raw/meson_nand.c
> index 81122315f4..82a12ac061 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info
> *mtd, struct nand_chip *ch
>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>
>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
> -
> -       if (oob_required)
> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>
>         return meson_nfc_write_page_sub(chip, page, false);
>  }
>

Applied and sent already the pull request

Michael


> --
> 2.30.1
>


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

