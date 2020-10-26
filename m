Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
 by mx.groups.io with SMTP id smtpd.web09.13785.1603724361229683023
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Oct 2020 07:59:21 -0700
Received: by mail-vs1-f67.google.com with SMTP id s6so4892653vss.13
        for <u-boot-amlogic@groups.io>; Mon, 26 Oct 2020 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AWSNUu/BwjRK3PvrHUQXFR3zOC05mCeaXTwKPGHz+g=;
        b=m8qlb55t7QTsvwd5ng/Kth2+loU4H+A3NL6BuksiltcXOFDz3Q7x8VzISXM007Kyfg
         PY08TMLqwqQfsox6sKa/blszaZK3k5/2UorTS+rVXhV+1M8xouhA/PE4/6LToZ6BuEBy
         9EutZnz63FcSszlvjLw5lFDwTR8T7OnXDnADafQz6wy/DqhKce//gVSkjQuiyqCZE93N
         +d74BvnP9bEpAC9LaqWu1mnM2r1vhTWsjWE/yoLtwyw6EZzG7ssCo3ADbHVA0AFqZtV9
         GNXV0oAc0WO62nraAojit0kNERMrMDTY/qj7/UrTmHmZM4VnDWlYYdW53btlfx/RTefQ
         dM6Q==
MIME-Version: 1.0
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
 <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com>
In-Reply-To: <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com>
From: Anton Arapov <arapov@gmail.com>
Date: Mon, 26 Oct 2020 15:59:09 +0100
Message-ID: <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: jbrunet@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Another observation is that u-boot with mentioned patch can't
find/initialize ethernet on a brand new Odroid C2, rev0.2 20171114.
But after booting without this patch at least once - ethernet is found
and working fine. And amazingly it keeps working even after the patch
is applied again later.

@

On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> Thanks for the report.
>
> Next time, please send the email to u-boot-amlogic@groups.io
>
> It's weird this fixes the issue, because the BOOT_0 to BOOT_8 have default Pull-Up by default,
> and Linux works fine with this.
>
> S905_Public_Datasheet_V1.1.4.pdf pages 17 & 18
>
> Maybe there is another issue in pinctrl instead ?
>
> Neil
>
>
> On 26/10/2020 15:36, Anton Arapov wrote:
> > Neil, Jerome,
> >
> > the commit:
> > https://gitlab.denx.de/u-boot/u-boot/-/commit/dd5f2351e99aad8fcbedbc1305b8b51b09952336
> > introduced "bias-pull-up" for emmc:
> > https://gitlab.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/meson-gxbb.dtsi#L411
> > and breaks booting from eMMC on the Odroid C2 board.
> >
> > uboot output:
> >   => mmc dev 1
> >   Card did not respond to voltage select!
> >
> > removing bias-pull-up fixes the issue, though it is not the fix obviously.
> >
> > Could you suggest what could be done in order to fix the issue? Where
> > should I look?
> > Any hint would be helpful.
> >
> > Thanks,
> > Anton
> >
>
