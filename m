Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web12.14762.1586361976839095254
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Apr 2020 09:06:17 -0700
Received: by mail-qt1-f172.google.com with SMTP id g7so190268qtj.13
        for <u-boot-amlogic@groups.io>; Wed, 08 Apr 2020 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPDxa79Ark6N8Gy3TPuYtoRXTRXcEVKjX+WchsQavaY=;
        b=XTDv6IxO3xXgYWjfSNAfJGuns43VyscvahN+L1MGs6jSx5u4wP9Zy8A8q/yLySKXdA
         oEQZCMPX9ukIwTQJeyfY/8lC+cyks1wKimD/AGJuGmlkx7dzncKSCJSSdGcyux6FiDEh
         OKMtxOdYK7HszXpdHNwyvmDWq+yqKD/rnsmlA=
Return-Path: <trini@konsulko.com>
Date: Wed, 8 Apr 2020 12:06:11 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200406
Message-ID: <20200408160611.GG27133@bill-the-cat>
References: <a4fa8d05-31c5-6b6a-3087-e2378f1c9296@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <a4fa8d05-31c5-6b6a-3087-e2378f1c9296@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="igABDXH78n6Jl+Hn"
Content-Disposition: inline
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--igABDXH78n6Jl+Hn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 02:16:06PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR adds support for Libre Computer AML-S905D-PC and AML-S912-PC while
> doing a full sync of Linux v5.6 DT plus fixups on MMC clocks and typos.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/2631
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 74bf17db394d49c7041ee01a277fcf8d99b9a5=
14:
>=20
>   Merge branch 'master' of git://git.denx.de/u-boot-sh (2020-04-04 19:20:=
45 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200406
>=20
> for you to fetch changes up to e13e7c9daec54f387468098aa1f857e99a1333ec:
>=20
>   arm64: dts: meson: add libretech-pc support (2020-04-06 09:56:35 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--igABDXH78n6Jl+Hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6N9nAACgkQFHw5/5Y0
tywl8gv/U4qW18aTQg/sMjkujuirCrjLtyQxbo6/79rJ2B8+lcHLVLpIwqeqHfFi
5LVRKi1h7jUplus6hr+mJr+MIOvb1zMX62W9j6LOz0xq2H2kKucXW5slB/d7F3kN
4n1VDbO/CgBSpjZ2AQSqtKRnc3zIQGQCCdv+e+wb3MFmQgVRU0PK80/pK/aAxvSv
Cur09/jH2e+dbr1JoRU9+nT1l99fBqL6qsTtgxrP/lXTNWV+Ieszcs48A0DDVbfz
IzC9SpotYDXdlbsmQUG5s1VKwzaNVuKmH8Q0XsgJFnXKGUWLzAkTJr1TOKpRyKyy
XUic6xDrWi7OR5Myih46fWVVc5nqEjQDf9i+gmoOuYbz1oaYBslcwne8B8WLtzBn
s3mPQJDG8d11KxMwNMx/QLqO0cTvwPObkZPdSm9//tOJ4COkgrHdRBkEDZWXxEFE
Z51l/8FywfnHKSwZJyAtFYwsBMdWj/kz4pmUhtdnP+UTOU+CTpK/vuez8Cwx7kqn
p69hkm91
=ApuS
-----END PGP SIGNATURE-----

--igABDXH78n6Jl+Hn--
