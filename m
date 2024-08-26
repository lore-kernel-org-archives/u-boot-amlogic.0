Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57182C61CF0
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:35 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.50264.1724668936393611945
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Aug 2024 03:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=Y7KaAyo3;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.47, mailfrom: michael@amarulasolutions.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a869332c2c2so610154466b.0
        for <u-boot-amlogic@groups.io>; Mon, 26 Aug 2024 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724668935; x=1725273735; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1Ch/kEAqJ2L6v0885UsOA8IEmUuLGULblzPqqlLtE0=;
        b=Y7KaAyo3wGt4F0J7v8rTx7rwa4LtquUh8nA2pTprZ87K8EbMaajITK9ZIBX29n6qZ1
         6fI2GxU92DhX9eU6zKrL6nlNXiEla08IirROHavIeJsbXxynT7KVnSiov6ls54Jryf3H
         uUZD09l2B6wQY046UmpIT8sFwdvjqAWukr9SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724668935; x=1725273735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1Ch/kEAqJ2L6v0885UsOA8IEmUuLGULblzPqqlLtE0=;
        b=TdUZDKJu+7TX24plZ2f0y4w9HPNg4UhhyKDyPFpfbCeZPjITOqsTuLnl3qWrymy++2
         kMc7DBhOnleN6aFwDb9PY/AKWcG620J9/AVuBp4RiDH5VN3fqX81/jP2yKAbmOkiwIG3
         9VEDqLnCw+Nie6dAzvmtDoYg7ZjKonj763UI4duAFqSR9YcSh+0Z6oUHA6stl5fSSZAv
         7hGlHERp4X8Y1zKw3uAmGoVQK5S8uYncOv2VhDTFvE1oMQrh3YVLXDa29GA7D0Fnlrok
         dpU19FSQfq6hYkWsic4IAgGVqze7vBkDTtgCD0uH1M3mhl3PJ40oy9WbQUsTFHdGKpbC
         uZug==
X-Forwarded-Encrypted: i=1; AJvYcCXSh+GchXi0Oe7a/3zHdUFTDn1rM5yYtvI88Ni3XPm3ytO54XRFLOXOS1Ex9ctGGChWair8B2Lu/XD0fjj5sQ==@groups.io
X-Gm-Message-State: AOJu0YwmlHNC/wuX/rvigcCpxcfMkIKvMnNb343pILs8nlSsUO5EW9/U
	9F5JHv5HbxTePwTH8UwGaA6Y/05wyWIZtjTAjGeDFcEtWPLxkGnXB0dxkCVITwEuqf15u0flbq6
	sWfvXcE6YeSLNAf9ISDxduuCSXa3J3h4aBFX9+w==
X-Google-Smtp-Source: AGHT+IGJrV4MbiJW8z9tVIPoF4insWoP8zyr1EKJDY1ERIO+j0hgvnzShD2U1SltA2tjPzTmJQzKCn9c89RzVdv5w6s=
X-Received: by 2002:a17:907:2dac:b0:a7a:8dcd:ffb4 with SMTP id
 a640c23a62f3a-a868a69568cmr1274314566b.17.1724668934196; Mon, 26 Aug 2024
 03:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
 <20240826060411.3532105-4-avkrasnov@salutedevices.com> <CAOf5uw=UuB1YandpEziF1gp3Amh1J9fk15YCM7J4FZW6zoq7GA@mail.gmail.com>
 <6f361799-2cd2-9573-cb53-82b22ca56c06@salutedevices.com>
In-Reply-To: <6f361799-2cd2-9573-cb53-82b22ca56c06@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 12:42:03 +0200
Message-ID: <CAOf5uw=2T7VLdKA+45LedRDvPN29Sv73C8P1NEeB+BRKA=exQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mtd: rawnand: meson: read/write access for boot ROM pages
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
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2378

Hi

On Mon, Aug 26, 2024 at 11:00=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
>
>
> On 26.08.2024 10:16, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
> > <avkrasnov@salutedevices.com> wrote:
> >>
> >> Boot ROM on Meson needs some pages to be read/written in a special mod=
e:
> >> 384 byte ECC mode (so called "short" by Amlogic) and with scrambling
> >> enabled. Such pages are located on the chip in the following way (for
> >> example):
> >>
> >> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
> >>   ^           ^           ^           ^
> >>
> >> pX is page number "X". "^" means "special" page used by boot ROM - e.g=
.
> >> every 2nd page in the range of [0, 7]. Step (2 here) and last page in
> >> range is read from the device tree.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 56 +++++++++++++++++++++++++-----=
-
> >>  1 file changed, 46 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 19f005202b..54ea035d8d 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -40,6 +40,7 @@
> >>  #define NFC_CMD_RB                     BIT(20)
> >>  #define NFC_CMD_SCRAMBLER_ENABLE       BIT(19)
> >>  #define NFC_CMD_SCRAMBLER_DISABLE      0
> >> +#define NFC_CMD_SHORTMODE_ENABLE       1
> >>  #define NFC_CMD_SHORTMODE_DISABLE      0
> >>  #define NFC_CMD_RB_INT                 BIT(14)
> >>  #define NFC_CMD_RB_INT_NO_PIN          ((0xb << 10) | BIT(18) | BIT(1=
6))
> >> @@ -78,6 +79,8 @@
> >>
> >>  #define DMA_DIR(dir)           ((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
> >>
> >> +#define NFC_SHORT_MODE_ECC_SZ  384
> >> +
> >>  #define ECC_CHECK_RETURN_FF    -1
> >>
> >>  #define NAND_CE0               (0xe << 10)
> >> @@ -141,6 +144,8 @@
> >>  struct meson_nfc_nand_chip {
> >>         struct list_head node;
> >>         struct nand_chip nand;
> >> +       u32 boot_pages;
> >> +       u32 boot_page_step;
> >>
> >>         u32 bch_mode;
> >>         u8 *data_buf;
> >> @@ -229,33 +234,46 @@ static void meson_nfc_cmd_seed(const struct meso=
n_nfc *nfc, u32 seed)
> >>                nfc->reg_base + NFC_REG_CMD);
> >>  }
> >>
> >> +static int meson_nfc_is_boot_page(struct nand_chip *nand, int page)
> >> +{
> >> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
> >> +
> >> +       return (nand->options & NAND_IS_BOOT_MEDIUM) &&
> >> +              !(page % meson_chip->boot_page_step) &&
> >> +              (page < meson_chip->boot_pages);
> >> +}
> >> +
> >>  static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bo=
ol dir, int page)
> >>  {
> >> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
> >>         struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>         const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_t=
o_nand(mtd));
> >> -       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
> >> -       u32 bch =3D meson_chip->bch_mode, cmd;
> >>         int len =3D mtd->writesize, pagesize, pages;
> >>         int scrambler;
> >> +       u32 cmd;
> >>
> >>         if (nand->options & NAND_NEED_SCRAMBLING)
> >>                 scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> >>         else
> >>                 scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
> >>
> >
> > scrambler depends on NAND_NEED_SCRAMBLING so suppose
> > that is not set
> >
> > scrambler =3D NAND_NEED_SCRAMBLING;
> >
> >> -       pagesize =3D nand->ecc.size;
> >> -
> >>         if (raw) {
> >>                 len =3D mtd->writesize + mtd->oobsize;
> >>                 cmd =3D len | scrambler | DMA_DIR(dir);
> >> -               writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> -               return;
> >> -       }
> >> +       } else if (meson_nfc_is_boot_page(nand, page)) {
> >
> > Now here you  seems that you don't care anymore about this option and c=
heck
> > only meson_nfc_is_boot_page
> >
> > Is something am I missing?
>
> Idea is the following IIUC: such boot pages could be read in ECC mode onl=
y with enabled scrambling -
> otherwise we get ECC error. Or we need to read it in raw mode. So:
>
> if (read page in raw mode) {
>     use scrambler as provided
> } else if (read boot page in ECC mode) {
>     force scrambling mode + NFC_ECC_BCH8_1K + NFC_CMD_SHORTMODE_ENABLE
> } else {
>     //we read non-boot page in ECC mode
>    use scrambler as provided
> }
>
> Thanks
>
>
> >
> > Michael
> >
> >> +               pagesize =3D NFC_SHORT_MODE_ECC_SZ >> 3;
> >> +               pages =3D mtd->writesize / 512;
> >>
> >> -       pages =3D len / nand->ecc.size;
> >> +               scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> >> +               cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, NFC_ECC_BCH8=
_1K,
> >> +                              NFC_CMD_SHORTMODE_ENABLE, pagesize, pag=
es);
> >> +       } else {
> >> +               pagesize =3D nand->ecc.size >> 3;
> >> +               pages =3D len / nand->ecc.size;
> >>
> >> -       cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
> >> -                      NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
> >> +               cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, meson_chip->=
bch_mode,
> >> +                              NFC_CMD_SHORTMODE_DISABLE, pagesize, pa=
ges);
> >> +       }
> >>
> >>         if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
> >>                 meson_nfc_cmd_seed(nfc, page);
> >> @@ -1132,6 +1150,24 @@ static int meson_nfc_nand_chip_init(struct udev=
ice *dev, struct meson_nfc *nfc,
> >>                 goto err_chip_buf_free;
> >>         }
> >>
> >> +       if (nand->options & NAND_IS_BOOT_MEDIUM) {
> >> +               ret =3D ofnode_read_u32(node, "amlogic,boot-pages",
> >> +                                     &meson_chip->boot_pages);
> >> +               if (ret) {
> >> +                       dev_err(dev, "could not retrieve 'amlogic,boot=
-pages' property: %d",
> >> +                               ret);
> >> +                       goto err_chip_buf_free;
> >> +               }
> >> +
> >> +               ret =3D ofnode_read_u32(node, "amlogic,boot-page-step"=
,
> >> +                                     &meson_chip->boot_page_step);
> >> +               if (ret) {
> >> +                       dev_err(dev, "could not retrieve 'amlogic,boot=
-page-step' property: %d",
> >> +                               ret);
> >> +                       goto err_chip_buf_free;
> >> +               }
> >> +       }
> >> +
> >>         ret =3D nand_register(0, mtd);
> >>         if (ret) {
> >>                 dev_err(dev, "'nand_register()' failed: %d\n", ret);
> >> --
> >> 2.30.1
> >>
> >
> >

The first patch seems not apply clean to me on master

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

