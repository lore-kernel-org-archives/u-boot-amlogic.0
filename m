Received: by mail-qt1-f195.google.com with SMTP id 44so17485548qtg.11
        for <u-boot-amlogic@groups.io>; Tue, 09 Jul 2019 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BuLu1r56m6W53UhpRNcsAp2WT/y5WzK6gRIjymM4bk=;
        b=scdIYI2cIVomWRmUqfIwkvmOvgBF8DzazPQZbMqVQwMXuRDKiNlt1+JCADN51ddejb
         lvzI+kzlm2LwlE8uXj7nFqVFOYKUz62qfbiW+WwN8/1weGxVkmM+qoBxHM56HS5/sSLi
         F5TQyfUvgMebFykjvX93X1VAzFzIOFq7mrxtA=
Return-Path: <trini@konsulko.com>
Date: Tue, 9 Jul 2019 08:16:15 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190704
Message-ID: <20190709121615.GV8554@bill-the-cat>
References: <6963e3dd-9003-e696-5cc7-bfec825752d0@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <6963e3dd-9003-e696-5cc7-bfec825752d0@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnnalMW64b1v2e1G"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

--MnnalMW64b1v2e1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 04:12:53PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This is my first PR from gitlab !
> Since I'll be on vacation next 2 weeks, this PR is for the next release, =
after v2019.07 is tagged.
>=20
> It contains a small typo fix from Andreas, and adds support for generatin=
g an unique MAC
> addresses from the SoC serial number in case none has been fused or saved=
 in the env.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit ca4491f2d2af93d8b77c48c5d272d88094fc06=
eb:
>=20
>   Merge tag 'rockchip-for-v2019.07-rc5-2' of https://gitlab.denx.de/u-boo=
t/custodians/u-boot-rockchip (2019-07-02 08:18:19 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20190704
>=20
> for you to fetch changes up to 3f1f9f08eb2031e14a7e2037feed18a69f1437c6:
>=20
>   board: amlogic: Generate unique MAC address for Q200 and P212 based boa=
rds (2019-07-04 16:04:59 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--MnnalMW64b1v2e1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJdJIWPAAoJEIf59jXTHXZSXVsP/3DGA3/iwPRhxw57itIJVWvn
GTOm2w8U0pHwvXd4kOHTPOlJxqRkpAhtQZ6yFRLqBrYQ2DZRpL3lbXCKjcopQEqQ
WzQ/nEgA6DHePOPpAsp/jmcxfXYKOurvHgdzpepNHE5qTLLCOyG0WdrFL3t1nzMM
FRU51mgtS+8TMWAVTVsIN/UJlX+r9Ui6Qc/O8qfYNoFhlyiYa4yGKj4q1dUhJ097
qjonUgW4PffKopRebFOC5o9QOuT5Mm+zzPt8EmWu/DNHEr5T5D0IDuXYuBWW8RN0
d+9vfVWXi4rh39kRq7yO7slV2czkL+hdZMxPN5AVHPgCEF9uPKD+lzgAku1rsfjH
wuCIdtTP88snyFh1fWeMJvzWMR274eXMw/UF+UlmN/fkx2IUPIpWKHONq8zQW24A
mRLjnE8yJvHNLvxoRyUxtzq7rAcfQ37LXP7NEmRqKsrNUvrm0Egi2/EiMF98RSWm
vEAGPsR0SiUnq3WshAyXwK9m0RHQmeTc1vejUR7eiohYqApRuPDBLPevDEtq8CHs
v30CQjej0IMSHADMyfyZTWfmjSx5dobr1Hi7bjPPQ+woATw8GEid5YpXcMGFKPGG
yo8h0Jupt0n99s2lh26ibq3OfLS4qa7NulFK7PW25yEmvTy61BzYLf7SQUM3Ie8n
D8e8XAQjDiD5MWGnfd6c
=VZBY
-----END PGP SIGNATURE-----

--MnnalMW64b1v2e1G--
