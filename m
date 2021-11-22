Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web09.4039.1637571131022000576
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 00:52:12 -0800
Received: from janitor.denx.de (unknown [62.91.23.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 648DE836E1
	for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 09:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1637571127;
	bh=PXDs/fbOPZ+3I55WICvRycOl85f+vwbh2JA0A/C4Ofg=;
	h=To:cc:From:Subject:In-reply-to:References:Date:From;
	b=herpzNhyT8s03oXnV4Ze7UVn416TSA6b6kr4hfzibPfxilaVpQerySefgt7IN1V71
	 6tKF8ixyfrlC4QIOcbPBSsQdWEEc6LIKhuZvIJk2wF1Zxf6PSrALvo/UdJfRg06ss/
	 MbpsImr2q+Ig/owSO0QMGN7XqB+PwPDXLAA18bzmU2UDlgB9suptSpjvcjHYCg18tw
	 42+Ni2R8oc7KL4eOlQFhU2802OTqAMH2hNmn712ODQIVl6NMinFhnOgQC6RiG8CDOD
	 gAK9050yAsVys02HK7ZeR4PwjF3zD9LXpp6TuzUIpGLK7hMD1HOfT+cTwQohpABibV
	 Eb/369AbrF72Q==
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
MIME-Version: 1.0
In-reply-to: <CAKaHn9+yL3naiDqbsQJWQ0Po=g=TmjjcPSKxkx5C4ay1M1AsUA@mail.gmail.com>
References: <20211119043647.1251416-1-art@khadas.com> <2004466.1637308134@gemini.denx.de> <CAKaHn9KZg13r=pGCo=Lv69pBP-s-EW4uxjBVuH9veT+o5j9v+g@mail.gmail.com> <6198ebca.1c69fb81.fc50c.bf0bSMTPIN_ADDED_BROKEN@mx.google.com> <CAKaHn9+yL3naiDqbsQJWQ0Po=g=TmjjcPSKxkx5C4ay1M1AsUA@mail.gmail.com>
Date: Mon, 22 Nov 2021 09:51:59 +0100
Message-ID: <2497688.1637571119@gemini.denx.de>
Content-type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Art Nikpal <email2tema@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

Dear Artem,

In message <CAKaHn9+yL3naiDqbsQJWQ0Po=3Dg=3DTmjjcPSKxkx5C4ay1M1AsUA@mail.=
gmail.com> you wrote:
> > >
> > > next examples just demonstrate how its works for already defined en=
v
> > > variables which contain other variables (like storred env variables=
)
> >
> > Which next examples?
>
> Usage examples (from commit message):
>
> =3D> setenv a hello; setenv b world; setenv c '${a} ${b}'
> =3D> setenv -r d '${c}! ${a}...'
> =3D> printenv d
> d=3Dhello world! hello...

This is a very simple example, and I showed you how you can solve
this one by just omitting the apostrophes:

=3D> setenv a hello; setenv b world; setenv c ${a} ${b}
=3D> setenv d ${c}! ${a}...
=3D> printenv d
d=3Dhello world! hello...


I _think_ what you actually have in mind is something like this:

=3D> setenv a hello
=3D> setenv b world
=3D> setenv c '${a} ${b}'
=3D> setenv a goodbye
=3D> setenv b sunshine

something to set d to: '${c}! ${a}...'

=3D> printenv d

Here my simple approach does not show what you want to have:

=3D> setenv a hello
=3D> setenv b world
=3D> setenv c ${a} ${b}
=3D> setenv a goodbye
=3D> setenv b sunshine
=3D> setenv d ${c}! ${a}...
=3D> printenv d
d=3Dhello world! goodbye...

That's because here evaluation takes place at assignment, but you
want it when used - but being recursive here is neither a good idea
nor standard.

How would you do it in a standard posix shell?  You would have to
use "eval", like that:

$ a=3Dhello
$ b=3Dworld
$ c=3D'${a} ${b}'
$ a=3Dgoodbye
$ b=3Dsunshine
$ d=3D$(eval echo $c)
$ echo $d
goodbye sunshine

But please note that "eval" is _not_ recursive!!

$ a=3D'$b'
$ eval echo $c
$b sunshine

And this is why I object against this patch.

Oh, and in U-Boot you could write this as:

=3D> setenv a hello
=3D> setenv b world
=3D> setenv c '${a} ${b}'
=3D> setenv a goodbye
=3D> setenv b sunshine
=3D> setenv foo "setenv d ${c}! ${a}..."
=3D> run foo
=3D> printenv d                        =20
d=3Dgoodbye sunshine! goodbye...

And yes, here you have to be careful about using ' or " as there is
no recursion like you might expect.

So yes, it would be nice if we had "eval" (which will ocme with the
hush update), and no, "eval" does not recurse either.



Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Real computer scientists despise the idea of actual  hardware.  Hard-
ware has limitations, software doesn't. It's a real shame that Turing
machines are so poor at I/O.
