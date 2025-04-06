Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D6C3601A
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.32818.1743973876351480638
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 14:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=jgA+yfby;
 spf=pass (domain: chromium.org, ip: 209.85.218.51, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac29af3382dso599147666b.2
        for <u-boot-amlogic@groups.io>; Sun, 06 Apr 2025 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743973875; x=1744578675; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcI15po75c4DpryXM6XE2KAMbEcEzy/h6oWlMhrtVqM=;
        b=jgA+yfbyTEdcQS5hallE7EK8Kw1imuQUse82EsDCZfke5jTrX3AAHJCw31OcFnXNLp
         tF7dkWnV/xPpCL+Pl25UGz9+BqyPwsI2pbvvJPern/iPnLHq6vJzNm1Q32bsQ29bVkRp
         AdS+fLulWEQWrLWI12Xau9PokU+IZ0arBk5sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743973875; x=1744578675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcI15po75c4DpryXM6XE2KAMbEcEzy/h6oWlMhrtVqM=;
        b=CJNCRAtWuT5kP39RhHmLoz5G8wF85DlzhewhYl245Pfky3nyyyXFTEind+oOsMZwW1
         oO0ADZWehWLn6zNRGHUC33FA2ly1/o+daMLy4baRM6aVKRjvbEddbcI2IDFYBjf0cFA8
         jFIGijoaf3Hpu0IEgirKMDVHQrLmkRDZwrGCgdaegsZ2+55eSE+YNTdhcooFvG0xu1vL
         TLWvKqQuvpqlTLR3LYXPJsEQkCwCoo/Hra9+8e3Vh0pX4TMiHYxhWBdSRBjmg4QSK8SQ
         mTAY+iNQv+3wqLl6kc3eiaqq8mpmXdqB2Whv7LKXBqkZAnMkBivO/K+7Ii04qjpWLt9l
         D6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWsd3L7j0U1mbA3B9MPdnxFvRLScJlbsyasjf93C0+bRHWdwcIivzwhodn43aFSzPic0l2fjGHcVa//nddtSA==@groups.io
X-Gm-Message-State: AOJu0Yw+5IVqLnoDnq8oEw9Y+CEDziueIF5IHsaB/rm1caC2gmbxtaWo
	rZHpQA+jQBryBWg1llK/xwbWs/DN1uYC7r/+cfzhZNC/A0kvhfyC4hWMLE+Ndla3z/ugWXzbDAj
	6fOtSka3SrKoQ0W8bBG608Mfmbe8+tvpbBe9T
X-Gm-Gg: ASbGnctOl0WkC9r7xAiogBLoDU71nODWNPtNSqgMK1eOQUAWzogNair4H6QJlviZwk7
	R5cYNTg5zZJ13KSq2JWPDPdK9eWAaEHmOOLuez0JAG5HQU4u4/eDG6sES7e5aWJlhztholZUEA4
	8Pme9H970gRkYNRThhyHSXNQiRz+6S5EfNc40k2O4=
X-Google-Smtp-Source: AGHT+IHUXT5Sy73XKgX7gMs/LPVH8sVlT7v62WEMiuOkIXO37c7mf175CsjSCtNvAWklKH7BwyQ14R9l+DJTtVVbtHg=
X-Received: by 2002:a17:907:1b26:b0:ac7:3912:5ea7 with SMTP id
 a640c23a62f3a-ac7d6f22f82mr842672266b.60.1743973874523; Sun, 06 Apr 2025
 14:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org> <20250405221308.498047-2-sjg@chromium.org>
 <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
In-Reply-To: <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:10:59 +1200
X-Gm-Features: ATxdqUEnyd67I1bf3xTSw1_xYgch-V5k86_kPtngIUOEXajn_iWbdrZFvEhoYvo
Message-ID: <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] designware: Use the remove() method with related drivers
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	neil.armstrong@linaro.org, 
	=?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
	Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
	Kongyang Liu <seashell11234455@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>, 
	u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2652

Hi Jonas,

On Sun, 6 Apr 2025 at 21:02, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-04-06 00:12, Simon Glass wrote:
> > Several drivers make use of the designware Ethernet driver but do not
> > implement the remove() method. Add this so that DMA is stopped when the
> > OS is booted to avoid memory corruption, etc.
>
> The designware Ethernet driver core should not need the remove() ops as
> the eth_ops.stop() ops already should stop DMA. And the eth-uclass
> pre_remove() ops already call the eth_ops.stop() ops.
>
> All these drivers seem to use designware_eth_ops and thus have correct
> stop() ops configured and should really not need the remove() ops.
>

That's interesting. I wrote that code about 9 years ago so perhaps can
be forgiven for forgetting.

Very few drivers set the DM_FLAG_ACTIVE_DMA flag, certainly not the
designware ones. So how would they be removed?

> Side note, this also misses the gmac rockchip driver that uses its own
> eth_ops instead of designware_eth_ops, however it also use same stop()
> ops as all these drivers.

Hmm yes I saw that but then apparently forgot to include it.

I can perhaps redo this patch to add the DMA flag.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> > ---
> >
> >  drivers/net/designware.c    |  2 +-
> >  drivers/net/designware.h    | 12 ++++++++++++
> >  drivers/net/dwmac_meson8b.c |  6 ++++++
> >  drivers/net/dwmac_s700.c    |  6 ++++++
> >  drivers/net/dwmac_socfpga.c |  6 ++++++
> >  5 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> > index eebf14bd51a..d4d31925fca 100644
> > --- a/drivers/net/designware.c
> > +++ b/drivers/net/designware.c
> > @@ -805,7 +805,7 @@ clk_err:
> >       return err;
> >  }
> >
> > -static int designware_eth_remove(struct udevice *dev)
> > +int designware_eth_remove(struct udevice *dev)
> >  {
> >       struct dw_eth_dev *priv =3D dev_get_priv(dev);
> >
> > diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> > index e47101ccaf6..8c9d0190e03 100644
> > --- a/drivers/net/designware.h
> > +++ b/drivers/net/designware.h
> > @@ -247,6 +247,18 @@ struct dw_eth_dev {
> >
> >  int designware_eth_of_to_plat(struct udevice *dev);
> >  int designware_eth_probe(struct udevice *dev);
> > +
> > +/**
> > + * designware_eth_remove() - Remove the device
> > + *
> > + * Disables DMA and marks the device as remove. This must be called be=
fore
> > + * booting an OS, to ensure that DMA is inactive.
> > + *
> > + * @dev: Device to remove
> > + * Return 0 if OK, -ve on error
> > + */
> > +int designware_eth_remove(struct udevice *dev);
> > +
> >  extern const struct eth_ops designware_eth_ops;
> >
> >  struct dw_eth_pdata {
> > diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> > index fde4aabbace..b2152f8da9b 100644
> > --- a/drivers/net/dwmac_meson8b.c
> > +++ b/drivers/net/dwmac_meson8b.c
> > @@ -145,6 +145,11 @@ static int dwmac_meson8b_probe(struct udevice *dev=
)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_meson8b_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static const struct udevice_id dwmac_meson8b_ids[] =3D {
> >       { .compatible =3D "amlogic,meson-gxbb-dwmac", .data =3D (ulong)dw=
mac_setup_gx },
> >       { .compatible =3D "amlogic,meson-g12a-dwmac", .data =3D (ulong)dw=
mac_setup_axg },
> > @@ -158,6 +163,7 @@ U_BOOT_DRIVER(dwmac_meson8b) =3D {
> >       .of_match       =3D dwmac_meson8b_ids,
> >       .of_to_plat =3D dwmac_meson8b_of_to_plat,
> >       .probe          =3D dwmac_meson8b_probe,
> > +     .remove         =3D dwmac_meson8b_remove,
>
> There is no reason to add the dwmac_meson8b_remove function above, you
> could just use designware_eth_remove directly here.
>
> Same for remaining drivers below.

Yes, I wasn't sure which way to go on that. I'll remove them.

>
> Regards,
> Jonas
>
> >       .ops            =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct dwmac_meson8b_plat),
> > diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> > index 969d247b4f3..cfb37c3aa71 100644
> > --- a/drivers/net/dwmac_s700.c
> > +++ b/drivers/net/dwmac_s700.c
> > @@ -44,6 +44,11 @@ static int dwmac_s700_probe(struct udevice *dev)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_s700_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static int dwmac_s700_of_to_plat(struct udevice *dev)
> >  {
> >       return designware_eth_of_to_plat(dev);
> > @@ -60,6 +65,7 @@ U_BOOT_DRIVER(dwmac_s700) =3D {
> >       .of_match =3D dwmac_s700_ids,
> >       .of_to_plat =3D dwmac_s700_of_to_plat,
> >       .probe  =3D dwmac_s700_probe,
> > +     .remove =3D dwmac_s700_remove,
> >       .ops    =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct eth_pdata),
> > diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> > index a9e2d8c0972..8e7a9975d28 100644
> > --- a/drivers/net/dwmac_socfpga.c
> > +++ b/drivers/net/dwmac_socfpga.c
> > @@ -130,6 +130,11 @@ static int dwmac_socfpga_probe(struct udevice *dev=
)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_socfpga_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static const struct udevice_id dwmac_socfpga_ids[] =3D {
> >       { .compatible =3D "altr,socfpga-stmmac" },
> >       { }
> > @@ -141,6 +146,7 @@ U_BOOT_DRIVER(dwmac_socfpga) =3D {
> >       .of_match       =3D dwmac_socfpga_ids,
> >       .of_to_plat =3D dwmac_socfpga_of_to_plat,
> >       .probe          =3D dwmac_socfpga_probe,
> > +     .remove         =3D dwmac_socfpga_remove,
> >       .ops            =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct dwmac_socfpga_plat),
>

Regards,
Simon

