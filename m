Received: by mail-yw1-f50.google.com with SMTP id w18so4192571ywa.12
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNQOSkaikE8bCFqzbwoRFJIkWv1b7xxDf3U70JnbrSk=;
        b=ciUr+LVTbrl5ki664j6RrsEhK/elmbdnqxx4Sgjpo4hK0O7E5hf4AZ/2vK+h6hzGrq
         kBZRd2yjV2KM537+43/q4mLg2nm6N8ioEsH5FLo48mypjknJaR9JdIWOWXEP9FsKAuUg
         pu51Kb0llzMN3xmvycrY7rz76facnJ4wDGH2A=
Return-Path: <trini@konsulko.com>
Date: Fri, 31 May 2019 10:36:10 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190531
Message-ID: <20190531143610.GE20781@bill-the-cat>
References: <79cb920d-2608-86c6-f486-c50ada73f33a@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <79cb920d-2608-86c6-f486-c50ada73f33a@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5lHLQ5DB5n8Yi0p9"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

--5lHLQ5DB5n8Yi0p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2019 at 10:21:59AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR syncs G12A support (DT, clock, config) to enable full functionali=
ties
> with already merged drivers, fixes a bug for internal PHY routing on Amlo=
gic GXL/GXM
> soc when chainloading, and finally removes an useless PHY reset on the Q2=
00 board support.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit e2822ccc2c7c0ba8d7d959a1fa1e6221ed1354=
23:
>=20
>   Merge branch 'master' of git://git.denx.de/u-boot-tegra (2019-05-29 07:=
28:40 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190531
>=20
> for you to fetch changes up to d0b1f72a04e49cb2abfac5c4e13696eabc125132:
>=20
>   configs: u200: enable support for USB Host & Gadget (2019-05-31 10:09:4=
1 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--5lHLQ5DB5n8Yi0p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJc8TvaAAoJEIf59jXTHXZSO+IQALNZQlOYmzIGEqk4MuqZv7B5
QJRAMZJAXmjuvBPIKiLAlJs2F/XPh83ai4z38kU9lIqNBFsAfjVUpDS9BEDzoVxd
lUwH2SIWjRNRPN/mb6+mDfij2yXOQgIWfKOGyc4ZXdSZqvHJY9maU0gMLcQUBWyW
dhBlNnNGZEtkR/BrvbpbxgXXPiKeofI6dC6Uwm0c1pCoMlrz0ll1GqgUvdPOae2e
OUnzfTMmmoSFTARcJb7yZwTKt2l78gA4RgiZO9AdzVIqVPifAIkGX2EgJj75uFBC
HZ3/TMVVfmlRP6u0a+QRaxMT5bbwzU4MrvM4+bqiCIy/bre+tooKhmlhK8s/d4nx
npR73K/+Pn224sQ1m+fKVzQdL7C645rXy3o8UtoQsVa6sm5YR1C/OFecSP3suRo2
+4tseiqB4z9UCb6y0u4ZZY2kjTUOWCkpjdfbTeS0xtTZpreIO92TkX85E4CTypS6
ml/aCEwHXFFP46yh79jFuC4rl+nJEAA4xXrIL+YKlbBQ/BnYwE+/r9A2GSXS5mV0
KfthhRR67otdwrohJvXgmstK5cworgdjWkpvjZk7HtZGJXVKmwc1+IWkuCD7heff
RXQCEawzlM/yY85JpVOK2eoDwX2o//gmG22a3anE+FiLLQmUi5d/VcmDT/NNYOIs
11roCKpWgb572S4KPX0N
=6FyJ
-----END PGP SIGNATURE-----

--5lHLQ5DB5n8Yi0p9--
