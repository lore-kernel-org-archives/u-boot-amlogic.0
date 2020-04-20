Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web12.1165.1587417762516897757
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 14:22:42 -0700
Received: by mail-qt1-f169.google.com with SMTP id q17so9927594qtp.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUQuIyMqIUnf8yHZ7T66L70jk6Dpq8McLYfJPY+Yxt4=;
        b=MKNv3NTBzMxD7/UWz8kv8fEuG9U0aePmsMYfBoo0uh37a6heOv+95vGnApKeCMAPCy
         v9gkIRoNR49ioTVxA/Ve9Kw5+BcxdEutTW/yCLBTuJve2ke5UWn342OJ2uNLsO23eRQF
         eiq9RobWg948gOIhIALrQxE5tCR90PQBXGf1A=
Return-Path: <trini@konsulko.com>
Date: Mon, 20 Apr 2020 17:22:38 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200420
Message-ID: <20200420212238.GK4555@bill-the-cat>
References: <670f4516-c90e-4273-c918-71a0fe8cb069@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <670f4516-c90e-4273-c918-71a0fe8cb069@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l8YfOjwMha7d9KWK"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--l8YfOjwMha7d9KWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 05:15:13PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This respin PR of u-boot-amlogic-20200417 enables RNG on meson boards for=
 UEFI, fixes the SMBIOS
> information for ODROID-C2, fixes HDMI Video Output broken on GXBB/GXL/GXM=
 based boards and adds
> support for USB gadget on GXL/GXM boards.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/2832
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 142a07f2a44262d76fec609e1fcde51794a456=
eb:
>=20
>   Merge branch 'master' of git://git.denx.de/u-boot-marvell (2020-04-14 0=
8:47:07 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200420
>=20
> for you to fetch changes up to 699a33b9388607446452ed3457921cfd61fc094e:
>=20
>   configs: libretech-s912-pc: Enable USB gadget with Mass Storage functio=
n (2020-04-20 14:19:10 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--l8YfOjwMha7d9KWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6eEpsACgkQFHw5/5Y0
tyxhFwwAhYzu6aBbH98q7CndP9muISr1Rx4dkPm1yLHfQbjP8cstgWYSD03GRYi1
n5MnG7ajciPjmX2TMgzesX34xMU+qw18kvkvExAFk8uaPbu3Tb8aZIh0tbjXTS2w
sOsJflU2ZQq3yoWSr+cIyTx/WqRI+O9/WqY9bbCjlzHQoRbYB0xNQeZ6cusfWb+k
4t3HBNCewLn97d5ucPbW+od1la0EhhmikFH7nYF8runa3gi+KIz5XBA73SMWXuzS
4BSmrrCbOfqgc9x0c2izi0ER7KDqGvpKcTXNzQ0EcyA3u+9QsOggc2oJMFQSEmEf
zs9C3HrYuurYPs60mUQVCb+xa3/nT0cL4tDnN24op2gKTzGmNPBbMzJz2nNQYrve
cew/cexFfs2ZOHq9cZN8BidYflWcO2j/tDpqajVDseTHNJGbtpsijSGAOYpKMmj0
nhuOdBVhttR93DAfx62Sz6GrylF/5oG4ELYydwyWeZFNJaXbaCwEYPVlaD2NKvr5
0BW+KdR0
=N6//
-----END PGP SIGNATURE-----

--l8YfOjwMha7d9KWK--
