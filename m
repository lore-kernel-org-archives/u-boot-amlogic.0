Received: by mail-yb1-f193.google.com with SMTP id s17so725302ybp.6
        for <u-boot-amlogic@groups.io>; Wed, 30 Jan 2019 18:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqLcobByDQmmVFaPGSekFg3sIFxUTNoGrlwKRFoFTrQ=;
        b=tSi5RXBJYfUKJ3tkWSatJ38dUA6IXKZKqerg4ncyltkoMxtW/mBwYoKIt4iv/jqeGO
         ybEDeYWfnJ8H9wsZTn0WPqOtauQCIkoWWNMGYXtmbJKlyFSyNi8PtCBe4ZN2skTxTYRl
         S2JjAWmddlq98ULAi8cndzKBddfU9Orsd3AbE=
Return-Path: <trini@konsulko.com>
Date: Wed, 30 Jan 2019 21:42:29 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [U-Boot,u-boot] MAINTAINERS: Add Amlogic entry
Message-ID: <20190131024229.GT30838@bill-the-cat>
References: <20190130095310.8803-1-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190130095310.8803-1-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWnKfPfB2seWFM1r"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, linux-amlogic@lists.infradead.org, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--DWnKfPfB2seWFM1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:53:10AM +0100, Neil Armstrong wrote:

> Add entry for Amlogic SoC maintained files and the freshly
> created mailing-list.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--DWnKfPfB2seWFM1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcUmCUAAoJEIf59jXTHXZSbTQQALpyVStu7UeP1VPiK2otg7Ek
XvKubOzPm1PPYVQ1ClX08u5d4rHAOntKnkl/zedZKEC3/CyK+6/xTQCd3MmcjAjW
Swf+ditl/wEQH8NdCM4feInP7sfZaBgDhuljWRI8dFS78y5aKvMnLDQi/kEvkC5I
T6+Roo/UxwacYZngsm4atlwh/qwwxUVhhcazVyDBKhjT11XpGqC1tOhyZa7KwfHo
C5kP+LWPc9nZxU0r2gKxD754/mRys2vjTWNrsc9XBHwqWCxtk9JBvtxcik4Pg4kP
VodpWc3K08DM42LHEqrS0Gx7XlXc0jbNDEB840MKh7x09uVVCKV0NTNohEJBdp+1
3wj0UYa0gvaVPMU/pHS1+vPhqvkq2PTQ+f6fH6iFkxL98PUhyV3TFDJeBEKiRJB4
YS8hbpaP8ur1RHSklg7wTfl3xMf6cVT5CnoG04DqCANXITZa/+yhlpi2IZCb4dmZ
L0ar5a38Y6clIMx6Hz990N2YIZAA8RH2yjxYdKmDz3GgJ/hHSgGHhQJ8mFm9Hzxl
sstN6q6UYbysjnwpTbitoLzGGX8R5tNukPDf5b++vhdZ0HsFyOdolLgGaILbcnSk
G0NFxe3uSoLSVy930EXqycIrQkov+A5mVoSEjC4PRlb2K7+mMoeKA6tWIFc7U+R9
/PNVs5UY7PPhKUejxuhi
=194f
-----END PGP SIGNATURE-----

--DWnKfPfB2seWFM1r--
