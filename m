Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web10.6399.1637312800702703833
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 01:06:40 -0800
Received: by mail-io1-f50.google.com with SMTP id p23so11911755iod.7
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cUav5o24drH1NrhOZ83vEwS1F7GxL11UxnzeA/m3ZU=;
        b=HB9Wq+pxsRagR2dC0fGUjo3OtyIGjbbg/+laeWTTSD+s92e8GF89bVl1X/MtOQQh2G
         6SiPIxE/LQpNfRsrI3eb528X/11lMdeD6p+7aZ0NHxT54ipYf0ogBIv5WlQ9+FqlMKHx
         d+Sb8y/bl86qnomRb+psPCuT1EJoi9DpKhgSUof9eqXcwqMCRijKySV8Up3pkTTE47eK
         aGiVJ7R7Qgu1WKXAo454U0M3o6U+i0lOij3YkAcBgmAE1vR7os2bLuetiinOvYVGGe1u
         IAetquyDUlK62v9Vqf764wnQQU6yy5YAiyX/r0I97p0Yac6o/UO5wue/IrIgJh06oiSV
         VeXw==
MIME-Version: 1.0
References: <20211119043647.1251416-1-art@khadas.com> <2004466.1637308134@gemini.denx.de>
In-Reply-To: <2004466.1637308134@gemini.denx.de>
From: Art Nikpal <email2tema@gmail.com>
Date: Fri, 19 Nov 2021 17:06:28 +0800
Message-ID: <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
Content-Type: text/plain; charset="UTF-8"
To: Wolfgang Denk <wd@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

hi Wolfgang
tnx for your comments

On Fri, Nov 19, 2021 at 3:49 PM Wolfgang Denk <wd@denx.de> wrote:
>
> Dear Artem,
>
> In message <20211119043647.1251416-1-art@khadas.com> you wrote:
> > Add possibility setup env variable with additional resolving vars inside
> > value.
>
> Hm... if you want to evaluate variables, you should not prevent the
> shell to do that by enclosing them in apostrophes?
>

next examples just demonstrate how its works for already defined env
variables which contain other variables (like storred env variables)

> > Usage examples:
> >
> > => setenv a hello; setenv b world; setenv c '${a} ${b}'
> > => setenv -r d '${c}! ${a}...'
> > => printenv d
> > d=hello world! hello...
>
> Without any new code added:
>

sure I know about this ! see my prev message please .

> => setenv a hello; setenv b world; setenv c ${a} ${b}
> => setenv d ${c}! ${a}...
> => printenv d
> d=hello world! hello...
>
>
> I know very well that this does not cover all use cases you might

Why not have this new opportunity ?

> have in mind, as you speak of "deep resolve". But then, I'm first
> missing an explanation (and documentation) of what "deep resolve"

recurrent  resolving for variables

> actually means in this context, i. e. how many levels down you
> evaluat.   Oh...  the code has "int max_loop = 32;" - this is a

i think its will be enough

> limitation mentioned nowhere.  And are you really sure this is a
> clever idea?  I am not convinced.  If we do something like this, we
> should not invent a new non-standard way.  We should implement

I believe it's a good idea ;-)

> standard shell behaviour instead (i. e. for example something like
> the eval command).

1) this option did not broke any exist compatibilities
2) there we talk not only about uboot shell, same time will be useful
to have env_resolve for internal c usage, because env_set dont have
this feature

>
> > Artem Lapkin (2):
> >   env: setenv add resolve value option
> >   test: env: deep resolve value testing
>
> This is one more of the patches that actually try to fix existing
> problems with our ancient verion of the hush shell.  As far as I
> understand, Francis (added to Cc:) has started working on an update
> of hush to a current version.  We should rather help him with that
> instead of implementing non-standard workarounds.

yes i'm informed  about this plans  (and think its happens  not  so
soon - but i provide some simple elegant solution already)
but again we dont have env_resolve for internal c usage which must be
very useful

for example: pxe_utils.c: and some other places
env_set("bootargs", finalbootargs);
can be replaced by env_resolve("bootargs", ..... )
will be easy get useful features via simple solution ( deep resolve
all vars by one line )

>
> Best regards,
>

Big tnx again ! and waiting any other ideas about this

> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> When choosing between two evils, I always like to take the  one  I've
> never tried before.                     -- Mae West, "Klondike Annie"
