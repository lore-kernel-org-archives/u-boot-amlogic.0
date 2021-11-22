Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web08.4651.1637575601745006971
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 02:06:41 -0800
Received: by mail-il1-f169.google.com with SMTP id j21so11900792ila.5
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 02:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r99/OjTfOOJSNWaQ+R6Hyulm5SLTaGj+HpOLbDXoV18=;
        b=AfAGZcxbZbnJLgV0BfeYuucqtUaEpusFl+lKvyTEM6JBsRxZlWrq7v9IdE7ZLgq0O6
         PM87YBY9rKCHAaIGP4dU80X3Tqm/+SYJwzQIdqqrynitSrpLz4+Hc/RbXgaA4VTJLpFY
         dBg0GAzpjy7jrjbSlbhRZHTwxnvexGylEsExyCHDJIu7I6ZUo7wDzILtqMA8tQeTDOKN
         hsob6O11TXundOLWQZCqO5iWJdTzfEg5B43TBqLAq8d0ihmRpyniKOLGIopJljtidakx
         1vGC7l1/hbb/V2nJdGoOSLkA3vYVY3LQ1JdCivwKtH4sUaFAViJO0lXOu5uoHBdQAkx6
         yiIA==
MIME-Version: 1.0
References: <20211119043647.1251416-1-art@khadas.com> <2004466.1637308134@gemini.denx.de>
 <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com>
 <6198ebca.1c69fb81.fc50c.bf0bSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKaHn9+yL3naiDqbsQJWQ0Po=g=TmjjcPSKxkx5C4ay1M1AsUA@mail.gmail.com> <2497688.1637571119@gemini.denx.de>
In-Reply-To: <2497688.1637571119@gemini.denx.de>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 22 Nov 2021 18:06:30 +0800
Message-ID: <CAKaHn9K2Y1Ct5fe1Z2J3E=WLuZ6NW8Xb1U+Myg1Dt_6MD60-Lw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
Content-Type: text/plain; charset="UTF-8"
To: Wolfgang Denk <wd@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

On Mon, Nov 22, 2021 at 4:52 PM Wolfgang Denk <wd@denx.de> wrote:
>
> Dear Artem,
>
> In message <CAKaHn9+yL3naiDqbsQJWQ0Po=g=TmjjcPSKxkx5C4ay1M1AsUA@mail.gmail.com> you wrote:
> > > >
> > > > next examples just demonstrate how its works for already defined env
> > > > variables which contain other variables (like storred env variables)
> > >
> > > Which next examples?
> >
> > Usage examples (from commit message):
> >
> > => setenv a hello; setenv b world; setenv c '${a} ${b}'
> > => setenv -r d '${c}! ${a}...'
> > => printenv d
> > d=hello world! hello...
>
> This is a very simple example, and I showed you how you can solve
> this one by just omitting the apostrophes:
>
> => setenv a hello; setenv b world; setenv c ${a} ${b}
> => setenv d ${c}! ${a}...
> => printenv d
> d=hello world! hello...
>

sure i know it and its easy, but we still have some misunderstanding,
and i will try explain again our problem

our problem (TASK)

we have:
some env variables which already defined and we totally dont know
about content ( for example its was improved by `env import` or loaded
from env storage  and  "setenv a hello; setenv b world; setenv c '${a}
${b}'; setenv d '${c}! ${a}...' ;"  just example how emulate this env
state )

we need:
setup/resolve env variable for example from d (and need resolve all
sub included vars)
=> setenv -r e $d
=> printenv e
=> e=hello world! hello...

please explain how we can get it without -r (deep resolve option) via
standard way ?


>
> I _think_ what you actually have in mind is something like this:
>
> => setenv a hello
> => setenv b world
> => setenv c '${a} ${b}'
> => setenv a goodbye
> => setenv b sunshine
>
> something to set d to: '${c}! ${a}...'
>
> => printenv d
>
> Here my simple approach does not show what you want to have:
>
> => setenv a hello
> => setenv b world
> => setenv c ${a} ${b}
> => setenv a goodbye
> => setenv b sunshine
> => setenv d ${c}! ${a}...
> => printenv d
> d=hello world! goodbye...
>
> That's because here evaluation takes place at assignment, but you
> want it when used - but being recursive here is neither a good idea
> nor standard.
>
> How would you do it in a standard posix shell?  You would have to
> use "eval", like that:
>
> $ a=hello
> $ b=world
> $ c='${a} ${b}'
> $ a=goodbye
> $ b=sunshine
> $ d=$(eval echo $c)
> $ echo $d
> goodbye sunshine
>
> But please note that "eval" is _not_ recursive!!
>
> $ a='$b'
> $ eval echo $c
> $b sunshine
>
> And this is why I object against this patch.
>
> Oh, and in U-Boot you could write this as:
>
> => setenv a hello
> => setenv b world
> => setenv c '${a} ${b}'
> => setenv a goodbye
> => setenv b sunshine
> => setenv foo "setenv d ${c}! ${a}..."
> => run foo
> => printenv d
> d=goodbye sunshine! goodbye...
>
> And yes, here you have to be careful about using ' or " as there is
> no recursion like you might expect.
>
> So yes, it would be nice if we had "eval" (which will ocme with the
> hush update), and no, "eval" does not recurse either.
>
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Real computer scientists despise the idea of actual  hardware.  Hard-
> ware has limitations, software doesn't. It's a real shame that Turing
> machines are so poor at I/O.
