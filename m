Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web09.2204.1571495098322542946
 for <u-boot-amlogic@groups.io>;
 Sat, 19 Oct 2019 07:24:58 -0700
Received: by mail-yb1-f171.google.com with SMTP id z2so2726939ybn.6
        for <u-boot-amlogic@groups.io>; Sat, 19 Oct 2019 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXn4EwckCE0f6WFF53cbJcVJh9HPtvtgaxZ+f6jPgWM=;
        b=tw5PWh27fUrDD7IGHgcNh5xFMQiD+9IE1VdJM9ZlSmsg9ewGZCbMVAkuJkT2AeAmMP
         2qy02GUJf64k7/X09JIUwhTG85uTG69e3SalP3qQFlyQXNH0oul/EGWFS80E+9CPsy5n
         2lVUwVA3alUpv+z82XF36RVvj8u5y58KwKUnc=
Return-Path: <trini@konsulko.com>
Date: Sat, 19 Oct 2019 10:24:54 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20191018
Message-ID: <20191019142454.GE11173@bill-the-cat>
References: <e59e20b3-8cda-06a5-eae7-a97c419c1657@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <e59e20b3-8cda-06a5-eae7-a97c419c1657@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 04:58:06PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR adds more support for Amlogic G12A and derivatives SoCs based boa=
rds, by enabling
> HDMI/CVBS display support and 2 new boards, Khadas VIM3, and the SEI610 l=
ittle brother of
> the already supported SEI510.
> Daniel also pushed a documentation update to explicit the available alter=
natives to the currently
> used blobs and tools to created a bootable binary.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/1012
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a2fce50455c9831f36765e5813b0b5e98f55d7=
0b:
>=20
>   Merge tag 'for-v2020.01' of https://gitlab.denx.de/u-boot/custodians/u-=
boot-ubi (2019-10-17 07:26:16 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20191018
>=20
> for you to fetch changes up to be2ffa1656509cc974910224a87443868d7037d9:
>=20
>   configs: sei610: Add config file to fix userdata size (2019-10-18 14:54=
:37 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6HLbQJwaaH776GM2h/n2NdMddlIFAl2rHLYACgkQh/n2NdMd
dlL6Pg/+IhmCB/zSlmuNHBSrbZLMdXnI58XwJocBjlO0byoQdWmSbv9jCZjxkMLU
zHXOc/5jh70tVuMvbUuEzVPcjtwI6SvTJY+19aX6GuNKAqODNWX1Sb9m8RnWNNjs
msQwZTugV/cjpEe8GhQd95OikB89h25e3IO4Oc7OeP4QAhc1LQxSJx+a6aUC5A6V
W1EXcMo/ELBgMNMDW6CB2Rw3RBg9s97xwV7hptKgKcpJy/AL1ofrjVROIDtr4k/D
yTPhd71KylQ4VPJj3Ev7sQdVSUBwtuUshaqeYUDxD4Dxwq2pHU9CLZVp2EdUpJ7i
b+wooVAuPHecaytUJHdpVFleGokF+83xKr2HRPVNZPeM+nubuUb2Vor/w/U+48uO
rL7qDg8PcQn7RAOcPnVKBxFFmGTsg6XSWUszqGfsiN0C0rdyLLUfKFkgju7AJ1QL
x3mWguvl1/7SmUVYCGF1lydvYDvlGmPfbwCobFC1npJ8PJg3n0gXY8OLR3R2dUf3
th24/1Y6fCxSzham3f9Szm5UuISk68fs08TLYE2qnPNk3jCr/T9iBmay4deL28Yj
urAutAx6FeGiT6Iqedp6UUPBRGSc9TGV1HvghmEbc6BlbTTldPI1w2n5nxLEHY/B
S2KQN+TvtsO2+kZiMqRhJYKi6Py1DBoWHQBlAmqhLiRrDDZE6+s=
=fEtr
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
