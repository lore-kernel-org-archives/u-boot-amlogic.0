Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web09.2256.1636776517655697924
 for <u-boot-amlogic@groups.io>;
 Fri, 12 Nov 2021 20:08:37 -0800
Received: by mail-qt1-f174.google.com with SMTP id j17so10435479qtx.2
        for <u-boot-amlogic@groups.io>; Fri, 12 Nov 2021 20:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nm49UL9xp9NOlqnPQl9VxiuhBmVOo3RIaC59+SEub2k=;
        b=NFmO6cGNpDm7yYvaTKz34ivy+zRHWmzngTApV+LPsUYvvYQEsc+Fjh4S1d66Jmh9mn
         +ARfDvoGJI0cRv+Vqj3Sl0IO5hzViBTNc43xVGZKjtfRsTrTFB3hqiIDwZthqDNSImlO
         SXtBn4VBaqpN4gKAJ2FXW+IXuLDvck2m8VBdQ=
Return-Path: <trini@konsulko.com>
Date: Fri, 12 Nov 2021 23:08:34 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] pinctrl: meson: Correct the driver GPIO declaration
Message-ID: <20211113040834.GV24579@bill-the-cat>
References: <20211113020034.263468-1-sjg@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20211113020034.263468-1-sjg@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3KuK5VE1Y0LRBuV"
Content-Disposition: inline
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--t3KuK5VE1Y0LRBuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 12, 2021 at 07:00:34PM -0700, Simon Glass wrote:

> This should use the provided U_BOOT_DRIVER() macro so that the driver gets
> added to the appropriate linker list. Fix it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 7c9dcfed50f ("pinctrl: meson: rework gx pmx function")

Doesn't build for me:
/home/trini/work/u-boot/u-boot/drivers/pinctrl/meson/pinctrl-meson-gxl.c:70=
4:28:
error: 'meson_
gx_gpio_driver' undeclared here (not in a function); did you mean
'meson_gpio_probe'?
  704 |         .gpio_driver    =3D &meson_gx_gpio_driver,
        |                            ^~~~~~~~~~~~~~~~~~~~
	      |                            meson_gpio_probe

For libretech-cc

--=20
Tom

--t3KuK5VE1Y0LRBuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmGPOjsACgkQFHw5/5Y0
tyxnKwv+NXP5J5Y80LiuN5Y+fLadnTe6jdCDb8IyOV8TiJ4YYyTispoGXmZ+KJ2R
hJfdmjRZlleT0Xqb0UoJEirMPY9J2Zt/c7eYxPZnLE0P0XtsM9mJvANkd6fDMBeI
mOvAe86qXPUPanZpGkwpAuhBMK0MXT6hHVmmvTHUlGz9BTkc5l3AwXhrunPj9pyk
AL2VRAQXtiHOLmRoa57M1SSurLpDh5OfvQK25r51AvKBJPRTJACSeLo1iwymqy34
c9EhAASEFOLDv/n8ob160pthk8etSMXMV8HxUS+hbdDqweTslH0Ff4LH3SR2S6Fh
omkIeUdg4U2V9vJo8ugwIb7sXPWrTssqR/ksXrraT6HAAAvOH/k7G9dVpVDR1MsU
GiIx3PXRIhQzgsAHU4/k/OAx0KQsdE51v1CLY1nxA0+AxgRXXDRndYM62UmHWqlx
fTrKBLekdCGl8Ny77HJPdjuzAVvceUIVaE9/RL1RJHv5aU+4/5qz9doA/kwO7TXA
sR2xlFk4
=d6rk
-----END PGP SIGNATURE-----

--t3KuK5VE1Y0LRBuV--
