Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9EEC5B552
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.47170.1724652921334084691
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:15:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=mrJesZJj;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.47, mailfrom: michael@amarulasolutions.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a843bef98so372587266b.2
        for <u-boot-amlogic@groups.io>; Sun, 25 Aug 2024 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724652920; x=1725257720; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ5ifD7jTdcTz+YgMhdtDMZPEjK0J8HsxCROu7L+F7o=;
        b=mrJesZJj4lcpNCPv9zKjY/n0twqKODQEQSV5mkaK5GbUKXahKpT0+T7OxI5b2EWul2
         tObnfTfZA4/0Es8vgAXQ1Xw1hTXFohOoUarK/DCkzs3lpv4o1VX34VEnxedIroY7MLAi
         x+s6fwZwvN/F5S1dSKmAmxCx3i3ZmqCzWy2n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724652920; x=1725257720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ5ifD7jTdcTz+YgMhdtDMZPEjK0J8HsxCROu7L+F7o=;
        b=NwGXKijsSyzXDsEt0/vq8VrfKDQwnaN2zeXBh+C8W9VINVkPazMfo1N8cxuBqAozsI
         D+v0W+tfDAqIhV7TXl+t+tHZPzHVyIMYpx/CF/aJFI1H0KsEWk8fYbILAtg9rn8F+zIY
         EH//NeKp5+N1wRG6kmjRecVxeN9rj5ralqSMgvBlddHeYoVSxoxlAEWw5tTnYStXUZFh
         ldE2oH2Jw/GsGES2aTU8jCQqjfJl1Ivj2donI+cNa74ZNqfBpRsYejvXYQT7Qk1zvljr
         qmGAod1lxZSn/LKxpUhgxti8/r2+NGv34hvaOcSZvcT7XGOQQNdSNZ9fBYwGIsxzU2/k
         sKig==
X-Forwarded-Encrypted: i=1; AJvYcCUkB/RLDz285nmqQ4iBxDXNXpm8O7JgQW237xuZed16UqwwlulpVjPtFvxiVi7TWtkncxMPqTZnh77idepDDA==@groups.io
X-Gm-Message-State: AOJu0YyP6sUcp5oDmnpecYXX6NJV6s1W0V7/Wm8iB8yVU1IILb9dtPoX
	83bcwCC938ZXV/5fWRl4R/VvuK83Z18hO/JSv+IwpIo/Rg0QgPUogNYb8H20xKeKXuOy0Pd9apM
	n0Uv+oMh2XvERwCSy2dZ1irGUteBIKqKGPFtBfg==
X-Google-Smtp-Source: AGHT+IEhqZYwsswNemY7h5TdnfKNlvQonD884wkoY8B8jUX6fJfMXV8jKy1a0qqerynW9CeNNBxcH6ONDw2H843ptoI=
X-Received: by 2002:a17:907:2cc6:b0:a80:f893:51bb with SMTP id
 a640c23a62f3a-a86a54f2001mr627000566b.68.1724652919162; Sun, 25 Aug 2024
 23:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com> <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com> <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
 <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com> <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
In-Reply-To: <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:15:07 +0200
Message-ID: <CAOf5uwnH-RTPWshLt_SnB=U=Fdug38m7Jsvm_PDm3kaCQEb_jA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: neil.armstrong@linaro.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
	Sean Anderson <seanga2@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, 
	kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2372

Hi Aresenly

On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 23/08/2024 10:29, Arseniy Krasnov wrote:
> > Hi! Got it, thanks!
> >
> > On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
> >> Hi Arseniy
> >>
> >> On Thu, Aug 22, 2024 at 9:04=E2=80=AFAM Arseniy Krasnov
> >> <avkrasnov@salutedevices.com> wrote:
> >>>
> >>> Hi, thanks!
> >>>
> >>> Thanks, Arseniy
> >>>
> >>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
> >>>> Hi
> >>>>
> >>>> I will read them tomorrow ;)
> >>>>
> >>>> Thank you for understanding
> >>>>
> >>
> >> All the series are delegated to Neil. I will review anyway but I think
> >> that will then pick from him
>
> Sure I can pick them if reviewed!
>

Can you please resend the series? I don't find in my mailbox (strange)

Michael

> Neil
>
> >>
> >> Michael
> >>
> >>>> Michael
> >>>>
> >>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.c=
om> ha
> >>>> scritto:
> >>>>
> >>>>> Hi, sorry, pls ping  =F0=9F=98=84
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> >>>>>> Patchset is based on patchset for Linux (today merged to nand-next=
):
> >>>>>>
> >>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasno=
v@salutedevices.com/
> >>>>>>
> >>>>>> Here is description from it:
> >>>>>>
> >>>>>>   >  Amlogic's boot ROM code needs that some pages on NAND must be=
 written
> >>>>>>   >  in special "short" ECC mode with scrambling enabled. Such pag=
es:
> >>>>>>   >  1) Contain some metadata about hardware.
> >>>>>>   >  2) Located with some interval starting from 0 offset, until s=
ome
> >>>>>>   >     specified offset. Interval and second offset are set in th=
e
> >>>>>>   >     device tree.
> >>>>>>   >
> >>>>>>   >  This patchset adds R/W support for such pages. To enable it w=
e can
> >>>>> setup
> >>>>>>   >  it in dts:
> >>>>>>   >
> >>>>>>   >      nand-is-boot-medium;
> >>>>>>   >      amlogic,boot-pages =3D <1024>;
> >>>>>>   >      amlogic,boot-page-step =3D <128>;
> >>>>>>   >
> >>>>>>   >  It means that each 128th page in range 0 to 1024 pages will b=
e
> >>>>> accessed
> >>>>>>   >  in special mode ("short" ECC + scrambling). In practice this =
feature
> >>>>> is
> >>>>>>   >  needed when we want to update first block of NAND - driver wi=
ll
> >>>>> enable
> >>>>>>   >  required mode by itself using value from device tree.
> >>>>>>
> >>>>>> The only difference is that patchset for Linux updates DT bindings=
, while
> >>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
> >>>>>>
> >>>>>> Changelog:
> >>>>>>   v1 -> v2:
> >>>>>>   * Pls see per-patch changelog.
> >>>>>>
> >>>>>> Arseniy Krasnov (3):
> >>>>>>    mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >>>>>>    mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >>>>>>    mtd: rawnand: meson: read/write access for boot ROM pages
> >>>>>>
> >>>>>>   drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----=
------
> >>>>>>   drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >>>>>>   include/linux/mtd/rawnand.h       |  5 ++
> >>>>>>   3 files changed, 65 insertions(+), 27 deletions(-)
> >>>>>>
> >>>>>
> >>>>
> >>
> >>
> >>
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

