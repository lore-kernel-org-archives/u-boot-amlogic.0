Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web12.3851.1637568562687410475
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 00:09:22 -0800
Received: by mail-il1-f182.google.com with SMTP id l8so17191559ilv.3
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSCFnOfNfaAvPsWD9zwpP5lrer+shsb/NnyQ3FfYfVU=;
        b=Q+dL4uZMEXhkp54W9jqdgFHDbgniWZSD3xU6JgiFlLVLN5P02MVoRrF5ngFUb38bcv
         5KigsdnMvltNgM9ojGfOUr/uDabvpNPCVXWUuX+qwv9OjxMFif3fK/O7RHTM8ytEVwXK
         NmZURh74G+rO0gSfAYJAJu7xU+QzRZ6pUdIxTR1DqZ1nPLUwmxZsaUoKGRVoRNXnvS0H
         msORNYwdzdt6ApJvrhLWbc2V7L+WpJtbUYtu9bQ2IRsUlBxcIgHdCvOPWYLho3LInOBX
         5tO7lb7Usu+T+tzmuAGPuJzH8lcdfE0BH9BGARpVa9AzGk/G6Ak3yF+/1+1fzk3FaI8/
         KqQw==
MIME-Version: 1.0
References: <20211119043647.1251416-1-art@khadas.com> <2004466.1637308134@gemini.denx.de>
 <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com> <6198ebca.1c69fb81.fc50c.bf0bSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6198ebca.1c69fb81.fc50c.bf0bSMTPIN_ADDED_BROKEN@mx.google.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 22 Nov 2021 16:09:10 +0800
Message-ID: <CAKaHn9+yL3naiDqbsQJWQ0Po=g=TmjjcPSKxkx5C4ay1M1AsUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
Content-Type: text/plain; charset="UTF-8"
To: Wolfgang Denk <wd@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

On Sat, Nov 20, 2021 at 8:36 PM Wolfgang Denk <wd@denx.de> wrote:
>
> Dear Artem,
>
> In message <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com> you wrote:
> >
> > next examples just demonstrate how its works for already defined env
> > variables which contain other variables (like storred env variables)
>
> Which next examples?

Usage examples (from commit message):

=> setenv a hello; setenv b world; setenv c '${a} ${b}'
=> setenv -r d '${c}! ${a}...'
=> printenv d
d=hello world! hello...

>
> > sure I know about this ! see my prev message please .
>
> Which exact message are you referring to here?
>
> > Why not have this new opportunity ?
>
> I think the suggested code is adding more problems than it solves.
>
> > > have in mind, as you speak of "deep resolve". But then, I'm first
> > > missing an explanation (and documentation) of what "deep resolve"
> >
> > recurrent  resolving for variables
>
> Your implementation of recursion has an arbiotrary and undocumented
> depth limit. Also, I cannot see a way to prevent resolving in case I
> want to keep something like "$foo" in the result.
>
> But that's to be expected from such a non-standard way.
>
> Why don't you stick with what "eval" in a standard shell does?
>
> > > actually means in this context, i. e. how many levels down you
> > > evaluat.   Oh...  the code has "int max_loop = 32;" - this is a
> >
> > i think its will be enough
>
> It is a reallybad habt to implement code with arbitrary limits, as
> it will blow into your face (or more likely that of an innocent
> user) rather sooner than later.  It's even worse that this limit is
> nowhere documented.
>
> > 1) this option did not broke any exist compatibilities
> > 2) there we talk not only about uboot shell, same time will be useful
> > to have env_resolve for internal c usage, because env_set dont have
> > this feature
>
> I did not say that an "eval" like construct would not be useful.
> But uncontrolled recursion with an undocumented depth limit is
> a problem.
>
> > yes i'm informed  about this plans  (and think its happens  not  so
> > soon - but i provide some simple elegant solution already)
> > but again we dont have env_resolve for internal c usage which must be
> > very useful
>
> On the CLI, we use the "run" command to get the desired effect. Yes,
> this is neither perfect nor elegant. But you can use that in C code
> as well.
>
> > will be easy get useful features via simple solution ( deep resolve
> > all vars by one line )
>
> I understand what you want, but this is not a good way to solve the
> problem.  I'd really rather see such efforts invested in helping
> Francis with the hush update - which will make such code unnecessary.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Success in marriage is not so much finding the right person as it  is
> being the right person.
