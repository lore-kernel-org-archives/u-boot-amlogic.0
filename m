Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.360.1588090290357264437
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Apr 2020 09:11:30 -0700
Received: by mail-qk1-f177.google.com with SMTP id o135so9908685qke.6
        for <u-boot-amlogic@groups.io>; Tue, 28 Apr 2020 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QBFj1kRjM9ktjDZygt5WkfLTvNLYwRWNIsSZdAmBaw=;
        b=szUmhBadi20+8UoowNf/mtBMdCSR18BOc7x0b2UHMUD2OP5P1xJMyzocotfKw0mxd/
         YVBYcYiIBzOJXNm+nWKepzi0IUPRDPpH1QC/AOz+6cowCdnXSvHmRrlKJWCwj2BQtYWl
         x4/AtyVOTq5z5c9WOYnLyCDOhycyeMwpnggOk=
Return-Path: <trini@konsulko.com>
Date: Tue, 28 Apr 2020 12:11:23 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200428
Message-ID: <20200428161123.GD4468@bill-the-cat>
References: <6acb7fbf-a4b0-b020-0451-d3daaa70f7e6@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <6acb7fbf-a4b0-b020-0451-d3daaa70f7e6@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dBTySC83OhS/t4p9"
Content-Disposition: inline
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--dBTySC83OhS/t4p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 03:14:17PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR enables access to SPI NOR flash on the Khadas VIM2 & VIM3, adds t=
he GXBB USB PHY driver,
> fixes MMC driver init freeze on G12A/G12B/SM1 SoCs and finally fixes USB =
PHY power-up on
> Khadas VIM3/VIM3L boards.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/2972
>=20
> Thanks,
> Neil
>=20
> The following changes since commit d16d37bcd4087b8ea0f66cb76a73edad182d15=
1a:
>=20
>   Merge tag 'video-for-v2020.07-rc1' of https://gitlab.denx.de/u-boot/cus=
todians/u-boot-video (2020-04-27 09:41:51 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200428
>=20
> for you to fetch changes up to 3dc4f8397015dac7c343f86a93bfb962ff4e8d6f:
>=20
>   usb: dwc3-meson-g12a: add power-on/off of the PHYs (2020-04-28 10:23:10=
 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dBTySC83OhS/t4p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6oVasACgkQFHw5/5Y0
tyzFNgv+OveyVBxe7jTis27gRWTNE4bOElv6sLNBnEISgyMqAxuTz1J/iOdfkWJT
IY66yNcCvQby2lnZhM9qSk/3P5CYxcmmdUkdwN0Ut4QwvxXZx3dlINodjaBQDQb3
SOd7wRFx+jqKkeWAaxgFg+iXFagWodHiFBxoMcpSyGfBB8gH1DDXQyEizukwX29B
M4vLd13eCO84qBF50QmdIVyUe1W5vU0yLREu6J2w+iusO08v5JfxBaNN8i3lu2U9
7T13lLPGhVBW+yKAwfu+YQEfLWtRXQ3XlK1ViBiVMov6Ulho9G1ccUcTOGLoUCBd
uQl0zNEpcr5Lj+JDYX+mW18S5GBds9KnXi5Y/JPHP2+9ylY6sZ2Y9Teg8nFbepkl
AIFzv6M3Qlq6GYsUhmxNTjkEsXXP1XSud56rHJxt0nJetw3TiT7dlKbb6rxTlkoZ
loODwSm+SKOSDOCa3pqs1N62UDVyMfUh/PEtGS5tOs+IGMvcbaie0IcShXDA2WSj
/tmtpzkL
=S+Oe
-----END PGP SIGNATURE-----

--dBTySC83OhS/t4p9--
