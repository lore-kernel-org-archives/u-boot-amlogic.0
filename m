Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web09.1777.1578527756170356448
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Jan 2020 15:55:56 -0800
Received: by mail-qk1-f169.google.com with SMTP id z14so4385094qkg.9
        for <u-boot-amlogic@groups.io>; Wed, 08 Jan 2020 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12Kh+trt1O5KSN7kqgDm/Xgj1Wutl+gcDlDfzfMEK4o=;
        b=N8jzbLsev4L24Gz48jYY+ViEMtmnfRjykqhaMwufVAf8ptiz6uz6rZN1AAufmzWusg
         sVo3sln2cOesSjJUONeRYPFA0qDbbNhxKYqqGMRubg15exUKtpaamgdjIhTxbaNedOP7
         JmqnBAt4g+UwGvXbq083dloJorUbBlcM+DY5s=
Return-Path: <trini@konsulko.com>
Date: Wed, 8 Jan 2020 18:55:52 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200108
Message-ID: <20200108235552.GV31026@bill-the-cat>
References: <107d6eb8-08a8-fe3e-7c48-5c66fc6d28c5@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <107d6eb8-08a8-fe3e-7c48-5c66fc6d28c5@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aYKnuo739dxkFWAR"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--aYKnuo739dxkFWAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 01:58:36PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR adds more support for the Khadas VIM3L, variant of VIM3 but
> using the Amlogic SM1 S905D3 SoC, plus various small fixes.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/1780
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 0b0c6af38738f2c132cfd41a240889acaa031c=
8f:
>=20
>   Prepare v2020.01 (2020-01-06 15:56:31 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200108
>=20
> for you to fetch changes up to 262d34363373c10a00279036c1561283c30495c2:
>=20
>   board: amlogic: select PWRSEQ for all amlogic platform (2020-01-07 14:5=
0:41 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--aYKnuo739dxkFWAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6HLbQJwaaH776GM2h/n2NdMddlIFAl4WbAQACgkQh/n2NdMd
dlIE7Q/9FZmkxBUqGS8S3f6CrSkfP0P+n/5Zdyfb8whdN97S0G34hOMauQIiHKpb
yqkAARSsoDKs6fIb9uhrGafZrd7tULdGMtc9dQOb8fJOnkWpL4U1wloYzIMQ4Ppj
cWI7BhJArWRTBi2AlBFfAOE1Mwm3163/rrE7Hh1ulLOlSYgFHDniLqmJL00aYtNq
biZFgDQvYdOIW1s1HOAZ0nJ/prst1ccEGlhwtSY1mrsfTF9fSMd5tOupGSm7Gf9N
W5E2jsFHTih3G1e7VY8dhMVOfA39LHHetGOyjztFjfPUpWCHsAI5BjKp591jS8zZ
9prQob/NbxWltZtZWPX3FMuuc1R9VThBTWzq2s6yiB3SCN1IydSdMDRiXS7C8utp
myiuuEjdv/msH3FaWbM+T60m28f0Po4EiMs7wKDqu+adyJ982hoAfF3I08jbTI20
/1JRSsf0ROKvIG/Yvkr9rMNuVoekDbTcNqAlmGhGueio+v1nZKcGb/OrDXU0vpoK
W0Oz43Wr6sD/xwRooU3KQ1sXwLSg5AIlg5xIYElHiMXx2jyQEQjmySfCLsFlzjpT
xB3cYJ7KSaerHz8dCpDbOmnN8uWYhUzYeQdUVWP9r7qEyARJ4OYUX4CqKmVEP9mL
Cxcbl1YqRN2MXofNhJjRcvm9rQZjBjC4p934IAkH7Pv8Uba/0js=
=SXX2
-----END PGP SIGNATURE-----

--aYKnuo739dxkFWAR--
