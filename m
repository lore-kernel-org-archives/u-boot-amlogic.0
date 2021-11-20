Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.7315.1637411783100364164
 for <u-boot-amlogic@groups.io>;
 Sat, 20 Nov 2021 04:36:24 -0800
Received: from janitor.denx.de (unknown [62.91.23.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C6790834AC
	for <u-boot-amlogic@groups.io>; Sat, 20 Nov 2021 13:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1637411779;
	bh=4m9hp1rOf3Pj7SfVk1xnmyewDVjJhwPH+AAApfOz+rw=;
	h=To:cc:From:Subject:In-reply-to:References:Date:From;
	b=X4Hl3DRELfd+s7IwIl/u0q+siok5kBAt/Hyua0RAUx9Ktay5xyx04JSHypekF36d2
	 XcuvOyjZjlDyVNt2+20bSk08I8Jl+SCG/99xkuWP1Rd9Q0XE2N96ZCTltgWSJdL7Wa
	 YS0FlcSZsyhcK5STNz+YoXqz8MKnoSVIFDpiJfKvQWeZ2CKHW4suByfFN3PzzLuKjz
	 WIJLb1+utJ8SzlMGE5TI1U/vvtpI3UM6ZC7rg/2yF2+TcA4tC//k5izi+lFeWSPbac
	 QF8BKWVAZJXAfAa5hnFeHE8s8s4YwAbfdnlSAQJHX6RyZXhGths6s/ud5M3Nq9iUFT
	 F42EkJ1tXqMdg==
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
MIME-Version: 1.0
In-reply-to: <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com>
References: <20211119043647.1251416-1-art@khadas.com> <2004466.1637308134@gemini.denx.de> <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com>
Date: Sat, 20 Nov 2021 13:36:09 +0100
Message-ID: <2235982.1637411769@gemini.denx.de>
Content-type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Art Nikpal <email2tema@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

Dear Artem,

In message <CAKaHn9KZg13r=3DpGCo=3DLv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.=
gmail.com> you wrote:
>
> next examples just demonstrate how its works for already defined env
> variables which contain other variables (like storred env variables)

Which next examples?

> sure I know about this ! see my prev message please .

Which exact message are you referring to here?

> Why not have this new opportunity ?

I think the suggested code is adding more problems than it solves.

> > have in mind, as you speak of "deep resolve". But then, I'm first
> > missing an explanation (and documentation) of what "deep resolve"
>
> recurrent  resolving for variables

Your implementation of recursion has an arbiotrary and undocumented
depth limit. Also, I cannot see a way to prevent resolving in case I
want to keep something like "$foo" in the result.

But that's to be expected from such a non-standard way.

Why don't you stick with what "eval" in a standard shell does?

> > actually means in this context, i. e. how many levels down you
> > evaluat.   Oh...  the code has "int max_loop =3D 32;" - this is a
>
> i think its will be enough

It is a reallybad habt to implement code with arbitrary limits, as
it will blow into your face (or more likely that of an innocent
user) rather sooner than later.  It's even worse that this limit is
nowhere documented.

> 1) this option did not broke any exist compatibilities
> 2) there we talk not only about uboot shell, same time will be useful
> to have env_resolve for internal c usage, because env_set dont have
> this feature

I did not say that an "eval" like construct would not be useful.
But uncontrolled recursion with an undocumented depth limit is
a problem.

> yes i'm informed  about this plans  (and think its happens  not  so
> soon - but i provide some simple elegant solution already)
> but again we dont have env_resolve for internal c usage which must be
> very useful

On the CLI, we use the "run" command to get the desired effect. Yes,
this is neither perfect nor elegant. But you can use that in C code
as well.

> will be easy get useful features via simple solution ( deep resolve
> all vars by one line )

I understand what you want, but this is not a good way to solve the
problem.  I'd really rather see such efforts invested in helping
Francis with the hush update - which will make such code unnecessary.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Success in marriage is not so much finding the right person as it  is
being the right person.
