Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web12.5912.1637308143051793457
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Nov 2021 23:49:04 -0800
Received: from janitor.denx.de (unknown [62.91.23.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 22A6480F3F
	for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 08:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1637308140;
	bh=tHvjRkc0x+mMoxk722HWZTKgZrAXXiwSzRKVeFlL6/s=;
	h=To:cc:From:Subject:In-reply-to:References:Date:From;
	b=tS/dUfske79U3WB8aAFYExbQlNma2qZN76lKnjxFRkLO+DjvEMKFQBavblU4rvn1L
	 /UOWCpqayx9pqK2XYDPZZoaFxcxdwbySwYIpMl+wkcIhuluYJYBR9wlmqx8j5cDRb5
	 JQ7VWbumKkaWbBuRHiv0xWA1HXINkKBlZopIjk4o/wM6csgam+99Dh5xWgd4Y1jtOF
	 PMOnd/cPud3rr2pFkXuQrEpaCBOqkJpowHCdtJprXoSUsPQXkZ4gd9jnUxha2sFqKq
	 YVNx0KOwz2bUwjrVJb9kBAPChxYNp5N/MzJMBGA9zxzqTkI10rWdARfpYPOQjHTBLB
	 e05oXp+/HxbMg==
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 0/2] env: setenv add resolve value option
MIME-Version: 1.0
In-reply-to: <20211119043647.1251416-1-art@khadas.com>
References: <20211119043647.1251416-1-art@khadas.com>
Date: Fri, 19 Nov 2021 08:48:54 +0100
Message-ID: <2004466.1637308134@gemini.denx.de>
Content-type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Artem Lapkin <email2tema@gmail.com>
Cc: sjg@chromium.org, trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com, Francis Laniel <francis.laniel@amarulasolutions.com>
List-ID: <u-boot-amlogic@groups.io>

Dear Artem,

In message <20211119043647.1251416-1-art@khadas.com> you wrote:
> Add possibility setup env variable with additional resolving vars insid=
e
> value.

Hm... if you want to evaluate variables, you should not prevent the
shell to do that by enclosing them in apostrophes?

> Usage examples:
>
> =3D> setenv a hello; setenv b world; setenv c '${a} ${b}'
> =3D> setenv -r d '${c}! ${a}...'
> =3D> printenv d
> d=3Dhello world! hello...

Without any new code added:

=3D> setenv a hello; setenv b world; setenv c ${a} ${b}
=3D> setenv d ${c}! ${a}...
=3D> printenv d
d=3Dhello world! hello...


I know very well that this does not cover all use cases you might
have in mind, as you speak of "deep resolve". But then, I'm first
missing an explanation (and documentation) of what "deep resolve"
actually means in this context, i. e. how many levels down you
evaluat.   Oh...  the code has "int max_loop =3D 32;" - this is a
limitation mentioned nowhere.  And are you really sure this is a
clever idea?  I am not convinced.  If we do something like this, we
should not invent a new non-standard way.  We should implement
standard shell behaviour instead (i. e. for example something like
the eval command).

> Artem Lapkin (2):
>   env: setenv add resolve value option
>   test: env: deep resolve value testing

This is one more of the patches that actually try to fix existing
problems with our ancient verion of the hush shell.  As far as I
understand, Francis (added to Cc:) has started working on an update
of hush to a current version.  We should rather help him with that
instead of implementing non-standard workarounds.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When choosing between two evils, I always like to take the  one  I've
never tried before.                     -- Mae West, "Klondike Annie"
