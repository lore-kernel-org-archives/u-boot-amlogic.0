Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC129C5AE5A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.46807.1724653937812170542
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=YjjbemtD;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.208.41, mailfrom: michael@amarulasolutions.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so4548808a12.1
        for <u-boot-amlogic@groups.io>; Sun, 25 Aug 2024 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724653936; x=1725258736; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yARgcnDAtx3Yxw5LFT4MkJfArTZq9+tfuycjr0R/6DA=;
        b=YjjbemtD0119TtZIpEeNVU11k29f6gfpWJHNZRYHtlp6WK62fzYNZfnWdxRkLM39eA
         4TImTmnCx/AMEJ9tQgHWT8igQBQXajXZa3GeK2wGq+oHmwrB8A1NYU7ON1DOqcvoH6kE
         F3AkP1mWl2TDoQcWk+MCn/zxwxIylHkMVoLRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653936; x=1725258736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yARgcnDAtx3Yxw5LFT4MkJfArTZq9+tfuycjr0R/6DA=;
        b=Yxxl8w3odFSnZabyoE+c3cj9x7EngstJYoQmZEIVBAsYMqFIz5p2L8KHaTAT6ciziD
         H1xZnmWhkjOnYZMhjVQnEKyzzPnjEYQ+qgReX3Z/tByGroqov1u/LiixHbCTOSV5BH/h
         YwzgJ9ILMRV1aIbftJqxPQIjPb6KPRbORA9SixrUbrRqxAC1CQp3RzULzYArMQNkL0dH
         XGkYg9YAfIAHxmqJ6cmANnED5y4rAOxgh67uqpIP0S+dfjHLFuXqf6RSFJ2mJa1lTvws
         qw3Rf8G1PvPgIBNJuLupJCpScFx2feQGui7whD+h7aNL0wOhr46ii9c6S/+WPzAiUaR6
         SEYw==
X-Forwarded-Encrypted: i=1; AJvYcCWTP28CvV07jLDTpCb8CikKBy7dPE+M0R7RZyL9o63F7O8u1NZ+juuh5KJwMc+UZ1Bbe7q5PbdIagl8f92eUg==@groups.io
X-Gm-Message-State: AOJu0YyRzi0dx7yqZ+bSH2aWYji1tOp5ItPq4XMBZFUOG6GuxLvIysWg
	la94Cb7wIuzQThzxPglbOThV8p8D7DqQLkupsTK6x3e0ZiiS3CzQcucMvFAEXuKhV+jC1WDa69a
	M+uQ9EgYTpKhN1OUqcD+sQOmmsR4xspsUejozjQ==
X-Google-Smtp-Source: AGHT+IE3zwHmGc0ADbqzaCBwgxDk71z7sO07GB6/Gdx4SxVW/N9YyZlFQ2D/Pe4EXdbdgQcdfjp1hIHBXwoXMpmGNRA=
X-Received: by 2002:a17:907:6095:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a86a5178cd2mr652151366b.14.1724653935667; Sun, 25 Aug 2024
 23:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com> <20240826060411.3532105-3-avkrasnov@salutedevices.com>
In-Reply-To: <20240826060411.3532105-3-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:32:04 +0200
Message-ID: <CAOf5uw=GSTTJ_cUpefnFnL+aR-d2Tq6k7odvhqGUEhRrKbcACg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
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
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2362

Hi

On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Move call 'meson_nfc_cmd_seed()' and check for 'NAND_NEED_SCRAMBLING'
> to 'meson_nfc_cmd_access()', thus removing code duplication.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 5d411c4594..19f005202b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -229,14 +229,19 @@ static void meson_nfc_cmd_seed(const struct meson_n=
fc *nfc, u32 seed)
>                nfc->reg_base + NFC_REG_CMD);
>  }
>
> -static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir,
> -                                int scrambler)
> +static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir, int page)
>  {
>         struct mtd_info *mtd =3D nand_to_mtd(nand);
>         const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_n=
and(mtd));
>         const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(na=
nd);
>         u32 bch =3D meson_chip->bch_mode, cmd;
>         int len =3D mtd->writesize, pagesize, pages;
> +       int scrambler;
> +

unsigned int

> +       if (nand->options & NAND_NEED_SCRAMBLING)
> +               scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> +       else
> +               scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
>
>         pagesize =3D nand->ecc.size;
>
> @@ -252,6 +257,9 @@ static void meson_nfc_cmd_access(struct nand_chip *na=
nd, bool raw, bool dir,
>         cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
>                        NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
>
> +       if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
> +               meson_nfc_cmd_seed(nfc, page);
> +
>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  }
>
> @@ -566,14 +574,7 @@ static int meson_nfc_write_page_sub(struct nand_chip=
 *nand,
>                 return ret;
>         }
>
> -       if (nand->options & NAND_NEED_SCRAMBLING) {
> -               meson_nfc_cmd_seed(nfc, page);
> -               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -                                    NFC_CMD_SCRAMBLER_ENABLE);
> -       } else {
> -               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -                                    NFC_CMD_SCRAMBLER_DISABLE);
> -       }
> +       meson_nfc_cmd_access(nand, raw, DIRWRITE, page);
>
>         cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
> @@ -644,14 +645,7 @@ static int meson_nfc_read_page_sub(struct nand_chip =
*nand,
>         if (ret)
>                 return ret;
>
> -       if (nand->options & NAND_NEED_SCRAMBLING) {
> -               meson_nfc_cmd_seed(nfc, page);
> -               meson_nfc_cmd_access(nand, raw, DIRREAD,
> -                                    NFC_CMD_SCRAMBLER_ENABLE);
> -       } else {
> -               meson_nfc_cmd_access(nand, raw, DIRREAD,
> -                                    NFC_CMD_SCRAMBLER_DISABLE);
> -       }
> +       meson_nfc_cmd_access(nand, raw, DIRREAD, page);
>
>         meson_nfc_wait_dma_finish(nfc);
>         meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
> --
> 2.30.1
>

Please change to unsigned int because I think match options type

With this

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


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

