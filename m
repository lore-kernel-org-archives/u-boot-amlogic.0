Received: by mail-qt1-f195.google.com with SMTP id h39so19778561qte.2
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dipPRvn/80hRdlT0kVChNoS9bJ20VLzrHX1IeG2nL28=;
        b=gntB19kpNBsfoJ7yYu3lwd6Y9DwqyQzyhsSm7+wwt4Ur3r/ad/FalLwy+tXB6dXU3c
         mW8MyAg+k7NYUOzzBTWzyjQuzVQ0ek5hHBgjGZRBbUrpNCL0gRHaEwE8M0izTuu7Dd9X
         e5PAz2wzRNHbonagzWP4LNIMkNb7gzSeuwpZQ=
Return-Path: <trini@konsulko.com>
Date: Wed, 3 Apr 2019 10:28:30 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/2] arm: meson: Fix khadas-vim2 USB
Message-ID: <20190403142830.GF4664@bill-the-cat>
References: <20190403114637.32068-1-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190403114637.32068-1-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmZL0FsH2xLo8uCy"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: marex@denx.de, ldevulder@suse.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--tmZL0FsH2xLo8uCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 01:46:35PM +0200, Neil Armstrong wrote:

> This patchset :
> - fixes the MESON_GXL_USB_PHY dependency to also allow MESON_GXM
> - fixes the khadas-vim2 defconfig
>=20
> Tom, I know it's _very_ late in the cycle, is it still OK for final
> 2019.04 release ?
>=20
> Neil Armstrong (2):
>   phy: Also allow MESON_GXM for MESON_GXL_USB_PHY
>   configs: khadas_vim2: Fix defconfig
>=20
>  configs/khadas-vim2_defconfig | 3 +++
>  drivers/phy/Kconfig           | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

I'm putting this through CI now, thanks!

--=20
Tom

--tmZL0FsH2xLo8uCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcpMMNAAoJEIf59jXTHXZSovkP/0PX/G27DOPjEGTXYA06Faux
I/AoWKXTtFOfN3YFjpE8r1spFj315U1vFFrKTFoMHzCBw4R7chOxJPj60udg53zP
lCjB64ud+/bEYsKnffxFg83Cn5NlegQwWmdSbdwJMuD2mFAC/c5MkXCT9GQ9eSOi
XI8REoFIB92CgP1t/upPornqn38iXnbZIYpH98fjvJ2krJDG3XEWjlqB5cb5eFaY
9WPiaYtv8KZ0w8Az9DqtG7dO+ru4R2w7BDOfYMB3EvJKLEEwnC+Gslrkg7BYW/v2
Mm6t6SNTiM8M7joTsZ31mVbez+UpRbM70CUKP5pLrCjsUDWX/1nCKcjAbiJ+uKt/
tgnsTz8Q7upz54OcxwJ+LmuZAuBOagzVwTBCV12/LVMkkMWI8acXXaMSTZRSzEtM
EJL8pos5InBK5cNJ1ARQArsG+EoCpXEEeZ+0/dFpgcRZNBvUgfZTpyYN17c0rxtS
EXgGxF6FOBR71QgG/yHkn4CPbT+KGjPqhIy8RURPxReaR5oqleGQY8Fq4lxfhEeN
+VzTser7YAdZEVFVPhFGfZ5OxCz22R/QHfyRhuCkqxzJPl5a4FSniiE8RE+fD8qh
Ziw04Cpdd/4LLe07cnpYaXNU+LyOoTcob9LwsO6KtPFLEglnkxAPy/29cHYgIbzy
L8e/VGgC4qtVxkdKmSXK
=1jeZ
-----END PGP SIGNATURE-----

--tmZL0FsH2xLo8uCy--
