Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.335.1610736221972728357
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 10:43:42 -0800
Received: by mail-qv1-f51.google.com with SMTP id j18so4436006qvu.3
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtXfNLX8QBTrk6mfxJe6oDerscCpHR3spEPsuaJ3VC8=;
        b=giKY6+hggOw3afd/GL9iTYstMfS1hw8rgWDHgGyF3Cg7HkKzW+Vci80zdr93mmzhVe
         CcaoeDUX1CkIi3iAFyJDkDonr6jF2AXxsw3YzNvXabvR4MErL8yJ+rTEQGYIUgE6f8Zd
         aga4e8O+sDqSujxHwHyQJjGPvXjmdD4KY5Mlw=
Return-Path: <trini@konsulko.com>
Date: Fri, 15 Jan 2021 13:43:38 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] phy: add support for Amlogic Meson AXG MIPI-DSI PHY function
Message-ID: <20210115184338.GE9782@bill-the-cat>
References: <20201229135901.30090-1-narmstrong@baylibre.com>
 <2639b559-a902-18b9-e0b9-174118890d98@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <2639b559-a902-18b9-e0b9-174118890d98@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 09:47:29AM +0100, Neil Armstrong wrote:

> Hi Simon, Tom,
>=20
> Could you review patches 1 & 2 of this serie ?

Patches 1 and 2 look fine to me, FWIW.

--=20
Tom

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmAB4loACgkQFHw5/5Y0
tyzH/wv/WmGN8U8kPWoELYFenb1KePiNs5RVXU/Ndzq9NcCbwH0o58YZJxFv7M6W
As+vpJUTflP4MCIZUTD2P1l+eb9G/g1+X2wVzQs87lcd+hagid0QgHru69QLo5j/
lxOI2BcnHBroDXp5Un7KIaiyCQWugifSfIJw11LczRlIFuuju/rg6u2amKWRiRyV
LDuEU2JYTDziPAVWPoavcdQzvEZttzKLLS1768gfcMgAMwD1IcnJwIYatFaolthr
gzjY2lroasF6J22huMLVkrYUEngk2VAo5yHa/X2UMS9iUTLXymDKCZnJfWA+TESx
cxHUMHePsIzS4vG7RaIcdMF7nPUtlnYMDsfemlt/wfFSe81c2g78TqDcmZbyXLfh
pFYV987byh29iVaIEx5UfeaUWDkDy3BKQjg18LanXngwizoH6Ekiz3sqq2nz/XTL
eZcJXBzIU71SRRAowPvVIXiUnIaFowtzAT0Y96F+Z3ahiFW7zR+rDTY3zCEdqbEt
BmpIfofJ
=6d8H
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
