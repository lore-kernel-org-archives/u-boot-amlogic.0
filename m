Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web10.40810.1635749552996867131
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Oct 2021 23:52:33 -0700
Received: by mail-il1-f173.google.com with SMTP id k1so2130131ilo.7
        for <u-boot-amlogic@groups.io>; Sun, 31 Oct 2021 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDOdynOhrf0wwNZ1bz8HIZaF+Qt+5i2DSUJZ8YMmK78=;
        b=SJ/AVXMOaQrDbEomJgYD0bZUnQ6OuEQP3b26bK7ReGJv+es1thRmP+YXDq7r3PZW9G
         PrDByp9p+20UiCv/IcFyBmlYoPgprILNzYbEDR+N2K6lzXhri7umBRsCzBCUPSPkp0S4
         J/CY8t7lKx8eNhlrmwT9Tx3v/ZDcFjzYu/5a3n3FHBkDwK9Oww4putGL76X7aaWuxYnX
         h/2yeAFim3xEXt8mAmpVIbCrtUdM7iK3Eorb7iEWbcny9bxpc8zBGYmWwi0rZpOirFKM
         NRkp95K2RMw0i9RtT6MTtxho8sk+GnGHiNUNrV/5dACBeedAK1FNLgX7lkPtcSLbtdSl
         rx2g==
MIME-Version: 1.0
References: <20211016051915.4157293-1-art@khadas.com> <ADMAagBDICVLCaddIATUA4rw.9.1635724039413.Hmail.art@khadas.com>
In-Reply-To: <ADMAagBDICVLCaddIATUA4rw.9.1635724039413.Hmail.art@khadas.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 1 Nov 2021 14:52:20 +0800
Message-ID: <CAKaHn9+vAobcypVrBrG5t1gppFDLsSbWrzogdW_t305P5EbJxQ@mail.gmail.com>
Subject: Re: [PATCH] image-board: fix wrong implementation ram disk address setup from cmdline
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <TWarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

hi Simon

> Fixes: f33a2c1bd0f ("image: Remove #ifdefs from select_ramdisk()")
> (I believe, can you confirm?)

confirm f33a2c1bd0f has wrong implementation logic for raw ramdisk image
sure i have tested it ...

On Mon, Nov 1, 2021 at 7:47 AM Simon Glass <sjg@chromium.org> wrote:
>
> Hi Artem,
>
> On Fri, 15 Oct 2021 at 23:19, Artem Lapkin <email2tema@gmail.com> wrote:
> >
> > Problem
> >
> > Wrong implementation logic: ramdisk cmdline image address always ignored!
> > Next block { rd_addr = hextoul(select, NULL) } unusable for raw initrd.
> >
> > We have unbootable raw initrd images because, select_ramdisk for raw
> > initrd images ignore submited select addr and setup rd_datap value to 0
> >
> > Come-from: https://patchwork.ozlabs.org/project/uboot/patch/20211015101501.4091141-1-art@khadas.com/
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  common/image-board.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Fixes: f33a2c1bd0f ("image: Remove #ifdefs from select_ramdisk()")
>
> (I believe, can you confirm?)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>
> >
> > diff --git a/common/image-board.c b/common/image-board.c
> > index e7660352e9..e7063016ef 100644
> > --- a/common/image-board.c
> > +++ b/common/image-board.c
> > @@ -333,7 +333,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
> >
> >         if (select) {
> >                 ulong default_addr;
> > -               bool done = true;
> > +               bool done = false;
> >
> >                 if (CONFIG_IS_ENABLED(FIT)) {
> >                         /*
> > @@ -351,13 +351,13 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
> >                                            &fit_uname_config)) {
> >                                 debug("*  ramdisk: config '%s' from image at 0x%08lx\n",
> >                                       fit_uname_config, rd_addr);
> > +                               done = true;
> >                         } else if (fit_parse_subimage(select, default_addr,
> >                                                       &rd_addr,
> >                                                       &fit_uname_ramdisk)) {
> >                                 debug("*  ramdisk: subimage '%s' from image at 0x%08lx\n",
> >                                       fit_uname_ramdisk, rd_addr);
> > -                       } else {
> > -                               done = false;
> > +                               done = true;
> >                         }
> >                 }
> >                 if (!done) {
> > --
> > 2.25.1
> >
