Received: by mail-yb1-f174.google.com with SMTP id y194so1882731ybe.13
        for <u-boot-amlogic@groups.io>; Thu, 29 Aug 2019 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dt8FwCL6mbWniaRV/YjFM8Cqnetm8UxXnAFFMtxRxS4=;
        b=oQBbyOY/XSyTX/YEFLjkJSzVxA8sxyB0JDCUkY4ZGVhgHfaTP1RO6DszRKfBTtxc3y
         1IKyNT89WYSdlWfab5kmYXpKIFe3bpvcLOjDP2tYkduBdUwQsXKyNv2KPBCneRBVe3CN
         wky45pH7paom5P8Y8brkc92f11IoD9cMi+kWk=
Return-Path: <trini@konsulko.com>
Date: Thu, 29 Aug 2019 21:36:36 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190828
Message-ID: <20190830013636.GJ26850@bill-the-cat>
References: <328a6134-2e7e-78a2-19fa-47c58e62d069@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <328a6134-2e7e-78a2-19fa-47c58e62d069@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Er1ntMVhQcukqcwj"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--Er1ntMVhQcukqcwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 03:20:00PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR simply adds a missing compatible enabling the G12B clock controll=
er.
>=20
> The CI jobs passed at https://gitlab.denx.de/u-boot/custodians/u-boot-aml=
ogic/pipelines/568
>=20
> Thanks,
> Neil
>=20
> The following changes since commit e4b8dd9b34021241cd05d5cc9d24b4ae346578=
30:
>=20
>   Merge https://gitlab.denx.de/u-boot/custodians/u-boot-mpc85xx (2019-08-=
27 07:11:37 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20190828
>=20
> for you to fetch changes up to d0e8c4ad513c0df492cc90bdc59f272687e90b32:
>=20
>   clk: meson-g12b: add compatible (2019-08-28 10:14:31 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Er1ntMVhQcukqcwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJdaH2kAAoJEIf59jXTHXZSAxUP/RRofn/B9KvvU21oQHOPscrd
JHJmeYS6c6n8IsyAWxqNP1HW5fzoy848rFfWhHLft0pCG3vD1O7XtZUJQECzQ7Jd
XtLbKW6uEeoK/KpsPifHS1wtl+bycZSdOoZuFg55bD6mbVj7eVh74k0gph0e0W3j
f70YQ2KNNHmgFC38GJxA5kpaJP4LNUS75vITw3laVTo5hf4rsMpK3v9pDE3bIxHp
1AtxUzNu6BPbaT0xnSmfi7SBfMcQWHCJqxRcf4S8fk+cTx7oUcTb+PkIyxhUC3Ra
Tjbq/oXBRxK52UVX+Y4eQMmSmILh+XJF3uDyne1ZwkNhlKZJgN6aXrpID6Kuh2Eh
mU+kdWbpGwySYGUn1ifVa2Sj26JxfCf8BKSdL1nHEIxrA2Vzxhyi0S/NiT8YeoIv
Ps3H5AIHbeLNxGC1q3PB084v2cpQbsc/4ReK63n1vwevV4DdMS78qMQccSEOKecp
B457PXpbwCCWZcYBFi7vQwjoc8vNO7SFZqKklivvPVBnk77B1d0q6UUPkwihsTxW
6WUrRcnNVOGKQcKW8w6FhOMJc+OmfDbqDe5ITgZkglwMQX1TH5uLy8Ew9OB/J2qb
kHzzuf1rtQV+mCaEvKPEEVGy0m+gIum7zXXqC6lK97ubqzby3AVDT7MbG6I6x+Ut
R6+gjVXoq0SqGuhW3Rqk
=H+qK
-----END PGP SIGNATURE-----

--Er1ntMVhQcukqcwj--
