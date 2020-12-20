Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.31745.1608505591098865905
 for <u-boot-amlogic@groups.io>;
 Sun, 20 Dec 2020 15:06:31 -0800
Received: by mail-qk1-f173.google.com with SMTP id 143so7408130qke.10
        for <u-boot-amlogic@groups.io>; Sun, 20 Dec 2020 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=13e9bsARgqXIt/6LcgKdYTdZtWYouGnKAzS7ahLLJ3g=;
        b=VrLyG4BMKyf1prm8JLZ6NcuVptKeh66WP+uKLs/N8Ssx810SXSe6Oqy84TeSG0LWHa
         nVBr2njHgelKQDfm64js0m/JPhl3qOohlB7jT6/5/f2EvR96kjrfoLQpF9hFhllTL9DP
         esb+kJgO9bV4aufKOcN2x00a8XGrKGXxH5sVk=
Return-Path: <trini@konsulko.com>
Date: Sun, 20 Dec 2020 18:06:27 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20201218
Message-ID: <20201220230627.GV22942@bill-the-cat>
References: <2154a13d-8cee-94ab-f853-c4fdc173233e@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <2154a13d-8cee-94ab-f853-c4fdc173233e@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 06:24:51PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> A (hopefully) last PR for 2020 with an one-liner fixing the Odroid-C4 res=
et when booting over SDCard,
> a bug we had in our backlog for a long time !
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/5613
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a4391365995a00f196373cddd35d99f74a9e62=
ff:
>=20
>   configs: Resync with savedefconfig (2020-12-16 10:58:24 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20201218
>=20
> for you to fetch changes up to 21a1bc6a900c33efe4da4cc1b33efcfa543fd9d0:
>=20
>   ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4 (2=
020-12-18 11:50:27 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl/f2PAACgkQFHw5/5Y0
tyxGJgv9G2U06auas28bqRIT1laIzkP7iizCR32q2iFwQytY/eQs/G4eFQEAyBt4
mrny0T9c2imMZ3kgBFfehLOTKzr829x9Df/2ih9+2sL5wKVkCRGDOV5NuQ3Q6g0a
rnn2PyR5Ld+HE+FlwxgyFZ0bkWPrL2HDBnEtf2JfE/SRS4wYhdo9GRCQpjT+B6ZH
pqlgEegpBs1NSJraCyVwQZ1C84Mh+5Uc8cGu6HO4XgS3plHw5abZSoo3i/oP90vr
Zjeri6NMrclerjR/FXANJFPc6B+DhYp1nP+IAMtHceVf56T5lLKXTg3hO45+6FeV
kAU5xoG1g5SRnPwxI6tHrMv+bOQ2bxph7X15UgBPGYITXIg4REUtzquB+YVAzAT4
9l+v2N5nTOUEUqXL+Sk7AQWij2xDdyEaCM1e7SL0Lf0pCW7xOYwxWSqnsFY/nPKn
z352bSlWYbPfZcetI12QnkVx4QiP7Xl9K4GWkM0A7ERw+8RYr7UnjjXc/1vTFaRC
rbPzWQE2
=8QJK
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
