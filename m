Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web10.40857.1635750059111745653
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Nov 2021 00:00:59 -0700
Received: by mail-io1-f52.google.com with SMTP id z144so19224935iof.0
        for <u-boot-amlogic@groups.io>; Mon, 01 Nov 2021 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aAz7VRs9hMsMltcFn0yQwyLlCiWGQTGyItu97x2qpU=;
        b=RmOz2EETPNp0wbN+pWLK10w3LpbsafJMSJAfu4DbZIx4NxMFPXAbQxifoP7NPqLa+L
         ozxbW8sd4UTvFjNQZohuQrvLkAT6gqKow75b+n2BQXahpaay+3GsM4FMvBZVkXKji6s7
         DivXIP6krHEnvL8lgfnJthbe+GUxfZP/DkrtONJzzaf02Pz1nveFRDJuMKUmM6i+VE8p
         i1zex1Lzf9vYKEyn87Lad1qIIpzqlAGQ8o6v1CTFIqf44agVrNVP1/eQw93N2kkMhL3+
         HsbRwPAQr9UCQmVbLyWBh0aUOZUZgFu5HyNScrlV5dPhemZH0rkz3ta/7MrKmCJaHIcO
         HC0Q==
MIME-Version: 1.0
References: <20211015101501.4091141-1-art@khadas.com> <AN6A0QAgIIdLnqeOIKHW84rw.9.1635724039553.Hmail.art@khadas.com>
In-Reply-To: <AN6A0QAgIIdLnqeOIKHW84rw.9.1635724039553.Hmail.art@khadas.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 1 Nov 2021 15:00:47 +0800
Message-ID: <CAKaHn9JQyO06-nKftOmMEXaywLt-7Z8wYimtwFfq26R_mgd62A@mail.gmail.com>
Subject: Re: [PATCH] image: fix select_ramdisk for raw initrd
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <TWarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Simon, Tom , and ...

> Do we need this patch as well as the other one? If so, can you combine them?
> Also, is it possible to drop the assignment to rd_addr at the top of
the function?

this patch must be replaced by another one
https://patchwork.ozlabs.org/project/uboot/patch/20211016051915.4157293-1-art@khadas.com/
( last patch will be enough alone)

On Mon, Nov 1, 2021 at 7:47 AM Simon Glass <sjg@chromium.org> wrote:
>
> Hi Artem,
>
> On Fri, 15 Oct 2021 at 04:15, Artem Lapkin <email2tema@gmail.com> wrote:
> >
> > Problem
> >
> > We have unbootable raw initrd images because, select_ramdisk for raw
> > initrd images ignore submited select addr and setup rd_datap value to 0
> >
> > Solution: setup rd_datap value from select
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  common/image-board.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Do we need this patch as well as the other one? If so, can you combine them?
>
> Also, is it possible to drop the assignment to rd_addr at the top of
> the function?
>
> >
> > diff --git a/common/image-board.c b/common/image-board.c
> > index e7660352e9..e3c6ea806a 100644
> > --- a/common/image-board.c
> > +++ b/common/image-board.c
> > @@ -439,7 +439,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
> >                                 end = strchr(select, ':');
> >                         if (end) {
> >                                 *rd_lenp = hextoul(++end, NULL);
> > -                               *rd_datap = rd_addr;
> > +                               *rd_datap = hextoul(select, NULL);
> >                                 processed = true;
> >                         }
> >                 }
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
