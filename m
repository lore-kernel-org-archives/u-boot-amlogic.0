Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web09.43164.1656704755784451349
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Jul 2022 12:45:56 -0700
Received: by mail-qt1-f178.google.com with SMTP id ck6so1168228qtb.7
        for <u-boot-amlogic@groups.io>; Fri, 01 Jul 2022 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nO4pH+05CFoTVrsztRL2DWYW+comka054L59FMjOZpg=;
        b=kr4+UbIIWP/FWFqL/teco5LtzTBlnLfokns9GyHHT0W/egSMZrYOI4GbCGYyF55Q0U
         7Uy8CmIqSBpnmTY2wOXabA3i9fRVik7YgJcw8d/VfgYXY7bmZOP0oJgVpZqj5LJIlwZ2
         3tmHlAqbAgU8x1Ptee5vgD3zl3z/0bq/BhSog=
Return-Path: <trini@konsulko.com>
Date: Fri, 1 Jul 2022 15:45:52 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20220701
Message-ID: <20220701194552.GS1146598@bill-the-cat>
References: <ecd6f37e-dd37-eeed-d5e4-eb0d107ce9e3@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <ecd6f37e-dd37-eeed-d5e4-eb0d107ce9e3@baylibre.com>
Content-Type: multipart/mixed; boundary="Groupsio=0t553BXEjhmeGT5fiw2E"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=0t553BXEjhmeGT5fiw2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2022 at 10:19:25AM +0200, Neil Armstrong wrote:

>=20
> Hi Tom,
>=20
> Here's changes for next release:
> - search dtb for meson-axg-usb-ctrl on board axg
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/12587
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 6f00b97d7e5760d92566317dde6c4b92247908=
27:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2022-05-20 2=
2:07:56 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20220701
>=20
> for you to fetch changes up to fdc55a6ba8309b688c9db6c3cf3f70ad7034c147:
>=20
>   meson: axg: search dtb for meson-axg-usb-ctrl on board axg (2022-05-23 =
10:40:01 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=0t553BXEjhmeGT5fiw2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmK/TvAACgkQFHw5/5Y0
tywvDQv/XLCBi0oVmiiqhl2KS3M3o8Y15MYQ4g/lD3qsq94tXyv4zwfMccAxaN5J
mQqsVpmC8AN8kyznb7tzR3T6tUfX1ueob9VQNKH+83E9Jht1o+tYdmRJYUk6yM0X
E6AM2VFH51Y4rpoQZ8YC3Z5rp0sG5lAPd2OHRcgI0J7cgmnuNRlpAEwyghik802j
8kNYd09U/gmGsIVb+iPQ1AZ0smZtwLRDlYYj4UnzB04roFprPPUaMzFgUh20/t1Q
EU6Q10tczeuq4T3Yhp5G8Hf677ikq6h3AUwYIxW3V8y47/rJnzQrTRwJBMqPjMfA
kYSSo5X09sEyVcPjwhA/d2/aJ3T9bXxq+hnj8Romd4O848y2PQpukTrXUeyDRsRw
xsSqFnAtyjK8AWs6eGbJ192Z0pTzSYsVhhoqLPq+ux7pjtrTJPonfMsCTxyAPHns
qiu2PGxGKgqnbNr9PvirVH4eLDOuOElObdao2m4zewBhx0uszlX/rcdBJL2cbaBZ
2xoZUK6F
=gN39
-----END PGP SIGNATURE-----

--Groupsio=0t553BXEjhmeGT5fiw2E--
