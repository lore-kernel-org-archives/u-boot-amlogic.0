Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web12.33.1592502440684819903
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jun 2020 10:47:20 -0700
Received: by mail-qt1-f169.google.com with SMTP id w90so5113835qtd.8
        for <u-boot-amlogic@groups.io>; Thu, 18 Jun 2020 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ew2X+ER1gZXRqUrymmZMC3/lutonROOEOBXU7w4R6FU=;
        b=QKby9gX8A5hdMAbZRC+swrYSufl+CDhBab+UtU2OxQBHjg5wqKMIvcx04CQM2ga8ev
         vcJlChaPJeEEVy3Q1W4otTGYMcsp5e/46eYaBpR8SyItWi61eW3MmkuRNdDMz7GW0Vl+
         IaYm9F6OxbrbOU8oxueN3vNWwqySmmMA+7aLk=
Return-Path: <trini@konsulko.com>
Date: Thu, 18 Jun 2020 13:47:16 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200618
Message-ID: <20200618174716.GR27801@bill-the-cat>
References: <e64ef508-6927-d9da-f7ea-8ca85729b82d@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <e64ef508-6927-d9da-f7ea-8ca85729b82d@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gk1bTGVZuaU9V5/"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--3gk1bTGVZuaU9V5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 03:44:11PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR moves the amlogic boards documentation in doc/board/amlogic in Rs=
T format.
>=20
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/3707
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 9cb895203a46654f7ee6dd95be5c8ab05e4dfb=
d3:
>=20
>   Merge tag 'u-boot-stm32-20200616' of https://gitlab.denx.de/u-boot/cust=
odians/u-boot-stm (2020-06-16 09:18:56 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200618
>=20
> for you to fetch changes up to 9c55f5d11260c5aa0f91d8cb32aa0ad00910659d:
>=20
>   board: amlogic: add board doc files to MAINTAINERS (2020-06-18 10:24:13=
 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3gk1bTGVZuaU9V5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl7rqKAACgkQFHw5/5Y0
tyx5IQv/bkmVBD5E+Tl5YOHXA2P8L+hAyRLu+oIEYsuU6Fhvc38BMueZ8NccvD+L
EqgjuA0ehceFK76W6fOWpeXJsCMu+cOdNiPNje16G3gfRmUfzNNDJkLqf/L6zNv2
B68V1r8DRdHTtkE7id6/02lJSt3+sXnN5vv5d2Ri7evcVOqAveYKyQ8x+kBEoKSd
ckvS3osV6RmHhMnl0dfydC9ssish73dzn03R4xiBUJvGNMaQpfXRsF7j682WbpIq
hIM7p1N2kMBHA5FAyaP3+8TZFdwTw/dK9PIk8cp7yU9QbKJkCiO2x5nS+1F0O/ON
JpZl2gUi+rpgLX2ea/XKVR6flQjCDavTyBoCzTH6JEbyj2xy9fkVU9ORB/zehyaW
5KalZw9w10Vsyi8G+a9/1dOj/FJ2gENp91aF+db/fzgO8Yv1p3fPiSupnLPdVME0
0x7Vcxo9DgUxY9v5SzqUWtKsgHpjyFgynz+6NTIPlOIyCCnXXBgUQXirVP69vTTY
EktBclth
=ZRDB
-----END PGP SIGNATURE-----

--3gk1bTGVZuaU9V5/--
