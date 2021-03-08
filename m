Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web12.39087.1615222320026449404
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 08:52:00 -0800
Received: by mail-qt1-f177.google.com with SMTP id t13so6608176qta.11
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kHHXz+ylHC/9KMXQCg0jeOD+dgXzxAuqub9xTqYfm74=;
        b=DjIynsXjaCrRD6/nt7qVIpIzWHZkQoEZrabEFGZf5w8LGayNKDvyjPRaGHZViGGYeY
         Itj5R//B3JD5UqlBugIRHB5n07raHqzhGBFsTDIiT7GUnbN2a+MTO4mRvaOB6BgYFRoV
         DOJ/Z+QG/NHIPaXTM6WavozqO/WHTZr6vFuXE=
Return-Path: <trini@konsulko.com>
Date: Mon, 8 Mar 2021 11:51:56 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210308
Message-ID: <20210308165156.GH1310@bill-the-cat>
References: <476093dd-ca30-f8e2-7e11-8a0f179750cc@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <476093dd-ca30-f8e2-7e11-8a0f179750cc@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8+CqTvXrScYT5Y9Z"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--8+CqTvXrScYT5Y9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 10:49:20AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> These changes fixes s/treshold/threshold/ in ADC button driver, and adds =
the missing fdtoverlay_addr_r
> env variable to make usage of FDT overlay support in PXE boot on Amlogic =
boards.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/6696
>=20
> Thanks,
> Neil
>=20
> The following changes since commit e4dba4ba6f61e8128be0b4200ca2d8cebf6218=
0b:
>=20
>   Merge https://gitlab.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2021-0=
3-06 07:25:04 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git u-boot-amlo=
gic-20210308
>=20
> for you to fetch changes up to 266637db88e37686b160722e183571567c61ad1a:
>=20
>   configs: meson64: add fdtoverlay_addr_r (2021-03-08 10:32:35 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8+CqTvXrScYT5Y9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmBGViwACgkQFHw5/5Y0
tyxEqgv+K1SaoZhWK+ClQ2xdtgYrIvilPDRD0zo32zcXAEAltoJk64ZexMkGJFXa
5wSyMGheZcTxwagepzVMa7R6K5+UvCgVXFJW78dvQvMOyj58KhrWy7ZL2SQgei6V
vLeqvDHEkmoamwAOnFwxMjDio9vDDqZKwUsrYXWOJ78z+cSnk5no+yUQlRSnt1AO
2UcJwep864R72Yowh0PmzCkqs7ZAf2F3+ck7pyl0Pquek2CristpK1agozj5s3Zp
PwIegvEkHhJEnO8SuDllP4toNf5wAE9xYqVnRAJULWPsG3JYq+p6iKPbT8nZxP7Y
9FzXDlDjPjORb9XRkKMj6/YwhRj88CFqW15bJ95kfLUXfIZif6bgC4yv5MmjvjGc
PsHnbSu/EvXABEFFC2zbES9qXDQaM5c8101WA0XJZcVs1Xddx0KekAIDGOgaOe0a
Homwap3xCpFXiGyJC/Vcd29BzD7fYg6bxFTdyPrhM9MOeUCUQYItoHkSC+5y2lHV
lDF7Wx73
=g7Ma
-----END PGP SIGNATURE-----

--8+CqTvXrScYT5Y9Z--
