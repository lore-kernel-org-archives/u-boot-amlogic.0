Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web09.621.1635863841807070875
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Nov 2021 07:37:22 -0700
Received: by mail-qv1-f44.google.com with SMTP id gh1so13395454qvb.8
        for <u-boot-amlogic@groups.io>; Tue, 02 Nov 2021 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBFR4kvII+Eqgzi8on4MuOckgeYQSPyDxBroi7Y0+oQ=;
        b=l8HJC6bdp8bIlosnLN4AZozMJTSyKivd3ghgQug+4crzO1ifRDntP37VRKU/+loKeA
         rkBWd37IgoopQqODTyTb1MT2F07NxtjM4FlKf5z1WgdEXalGGregFvAaOQE1Fwz1EWaT
         /v1wEwuYMgtifRJ9Prip6cOzan1telPWHPPTg=
Return-Path: <trini@konsulko.com>
Date: Tue, 2 Nov 2021 10:37:18 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20211102
Message-ID: <20211102143718.GO24579@bill-the-cat>
References: <cde80735-f811-68f1-1b47-3daf4f597d6e@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <cde80735-f811-68f1-1b47-3daf4f597d6e@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rEhM+w5krfX9Wpv9"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--rEhM+w5krfX9Wpv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 02, 2021 at 09:44:32AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Here's 2 simple changes, one to add commands to read/write fuses and anot=
her to add
> proper MAC generation for the JetHub D1 product.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/9712
>=20
> Thanks,
> Neil
>=20
> The following changes since commit aafc378a6caef453a40f2f9f3d6bef69e592c2=
8d:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2021-10-=
28 07:57:54 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20211102
>=20
> for you to fetch changes up to 4f4f974a46244270c1c6723017711c0aa8250206:
>=20
>   ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI (2=
021-10-29 19:16:07 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rEhM+w5krfX9Wpv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmGBTRsACgkQFHw5/5Y0
tyyTEgv/RBc8FuAjiMM3NmrGuaIBxGEnQuAgf0JwgWYK6OVqMnIgzUOdwuUOq87i
69i6Uqm8R/l0d2f+SqjiXmaay5p6fj2Ea3cAmPvRbjX9qHkiE0QFZnNayjhWj26E
a3q4YOz/DusOJdikthEMOzoOC8qLNHCKUU26y7W5qyCdqkeJTnwEY+sw0ZnImytg
p956ns6X8ezVB7rCfBw7QNozp4kVqBYnNRL6wb4RVjn+cRN6ybCe+2yTsV+7VSDp
MVQPwHb/8YLlu23KCwLF+TR2GBWmPtTg2iinuDTeO2kAc7Ccn1XE7rZr9M+xpnIy
lkA07D2YjRbhl5rc8ZZJZcQDMq68peRpEdVTAs/odlCNGvYQeKSJomylw4efgFiD
akxcgmL+nkoUuHgg7yOwv7sk+wISJXaIc/OyN2TX5pVAVQYJ1Tiqev+JWsoHI3+n
aOaaLjbvgR+TsvIRrCjvo3yFc4yPek6d7fyYRZj93nuHHQtV7IvcPQ5ZJhXSw5bX
GScrC0BE
=Sju+
-----END PGP SIGNATURE-----

--rEhM+w5krfX9Wpv9--
