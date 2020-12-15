Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web09.1599.1608055730855166635
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 10:08:51 -0800
Received: by mail-qk1-f182.google.com with SMTP id n142so20039250qkn.2
        for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y7LoEzy48ajBRx5hAfbSZqfCBQEoLqMb2U3O7swYeNU=;
        b=k3UqwslxgFauDGwyD/QCbrdGu43/qu83+heHhJr3uV7LjWJJN0529C/Mm++RO0zfLQ
         VLQ9Dzb6lbHo15Sdwr804L+GrEmF6i/RaQs00bQlaf1aEQLEnxmhi2AUWuumQGxNGu+M
         7ZXe8HtKUZskMfR2pqteOR9e1OUIT0Nd2L96k=
Return-Path: <trini@konsulko.com>
Date: Tue, 15 Dec 2020 13:08:47 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20201215
Message-ID: <20201215180847.GD22942@bill-the-cat>
References: <7df22695-a473-2941-5399-98955174e10f@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <7df22695-a473-2941-5399-98955174e10f@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2020 at 09:02:27AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR fixes the pinctrl bias bit handling code and the dr-mode setup on=
 the G12A DWC3 glue driver
> when switching USB device/host back and forth.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/5575
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 5a1a8a63be8f7262a300eddafb18020926b12f=
b6:
>=20
>   Merge tag 'u-boot-atmel-fixes-2021.01-b' of https://gitlab.denx.de/u-bo=
ot/custodians/u-boot-atmel (2020-12-11 15:55:17 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20201215
>=20
> for you to fetch changes up to 5ccd5d2cc98224108ae9fb09593a862c9caa5e80:
>=20
>   pinctrl: meson: fix bit manipulation of pin bias configuration (2020-12=
-14 19:58:54 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl/Y+6wACgkQFHw5/5Y0
tyyv6Qv+LIMgZthxBpK0Z39b2Qbdizdw/9H2KbHbREZtOzAgx9JG/Qi/DjLHI1E6
/2KsY1nuS4+e08L7EibHn5Jvfb5aHkpIWjOJbhNlBaHNtUovFI421+afb+zmtKIx
3Ih4OY8flArf5AIAtEyWhMzzoIowJOYOMhn84ysJPjzZQBSMo1wMof600HzpoKoh
xK2se6xVDL0KNyd32Lm7E04WxpVQ+59Le8s2xBFcHXjta84xDDHJA5tml9sgr3qo
nNlsBMtCqx8ULgXwE2PD8sx0of7ZktxuWL0sPD6mWfJzePlRu4jx/MgN0cGdBX+w
0i2+aM7ymZXW/TqC4DeaLQf4DM7h2vHHBDDNpoykixe31xmtmHQrbe2qnycTTE84
5wPqD8BC6pRZ7qkHxDP7SXdMAzYYklTZLEUsQ1o0XUpdsTy+Mkvmv7dUDyhHFkh8
b9G7HB0bbe7qT2I7De1KpuCUUj56T04KmqEU3ow+74tpOGAafBw+EySu2tjJ0rPW
TN5PK+YY
=geI1
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
