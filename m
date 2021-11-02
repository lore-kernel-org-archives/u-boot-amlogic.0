Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web09.495.1635871498176880874
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Nov 2021 09:44:58 -0700
Received: by mail-qk1-f172.google.com with SMTP id bi29so20216104qkb.5
        for <u-boot-amlogic@groups.io>; Tue, 02 Nov 2021 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPkcE5T6hJHDFZqqE97mlIVWebGsCUaib3k9LdFQ7aY=;
        b=PnQoJWcwymCbQmQzFV2jLuv8okA3aKlvH5UIGZ5rfh6pOulWRIcRPLOynAWLpGOf50
         XjO5C87sLt2HQX8jSWjHdVMpZxolV/l6A9kTK6ZGROKCYkqXYRmWXdieQCNsTqwsaaVI
         BObHxAAREFsd7uUnotHe1b6kQYhvPW15UpsCY=
Return-Path: <trini@konsulko.com>
Date: Tue, 2 Nov 2021 12:44:54 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] env: setenv add resolve value option
Message-ID: <20211102164454.GQ24579@bill-the-cat>
References: <20211102071914.696963-1-art@khadas.com>
MIME-Version: 1.0
In-Reply-To: <20211102071914.696963-1-art@khadas.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xHR3sS2kvo5MIJEm"
Content-Disposition: inline
To: Artem Lapkin <email2tema@gmail.com>
Cc: sjg@chromium.org, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

--xHR3sS2kvo5MIJEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 02, 2021 at 03:19:14PM +0800, Artem Lapkin wrote:

> Add possibility setup env variable with additional resolving vars inside
> value.
>=20
> Usage examples
>=20
> =3D> setenv a hello
> =3D> setenv b world
> =3D> setenv c '${a} ${b}'
> =3D> setenv -r d '${c}! ${a}...'
> =3D> printenv d
> d=3Dhello world! hello...
>=20
> /* internal usage example */
> env_resolve("d", "${c}! ${a}...");
> /* d=3D"hello world! hello..." */
>=20
> Notes
>=20
> Resolving works only for ${var} "bracket" and didn't workd for
> "unbracket" $var
>=20
> =3D> setenv -r d '$c! $a...'
> =3D> printenv d
> d=3D$c! $a...
>=20
> Signed-off-by: Artem Lapkin <art@khadas.com>

The high level problem I have with this patch is that we keep going back
to "we really need to update to a modern hush (or other shell) rather
than patching new features in to our ancient fork".

--=20
Tom

--xHR3sS2kvo5MIJEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmGBawMACgkQFHw5/5Y0
tyzvVwwAppEYr+FDIcr87sscDkrQ9/68yb+VjsJAjppDmtgPK8+BpphlJ72FG/yZ
ABoWw+bpvXOwJESrQAmirKVjW3DOlykYik9IJDImkEj/RiCRuEbwMMgfxM4zIsE1
sRHCHFevIETHrdxiwmNuKAr+uFV0BcOixB8o8cL5svILMwyVjdHiFYkFInQhgHAC
Q86+i2MTc437vVb24kLV0qsBt0eTmh62+VlxoXUFhHwvbshmijLJkqvv8cuyPTO9
YdDRDN8LNMQtISxxRiJ9KOQGiMGe0NmS7o8b8wx0Oozff1JY7GqV24sFlPkU3P4H
Nl1ENJsoVpJ2vFMGvhSMAu5EFCR62J7ntzj2alOdi4uEhfvZEYnbMXHKMDraIply
pYBsmPZd+nhahnXLN86sV1pILbZx+1mdj7Xj+92NxYMwqijhS4Td7pNCjIo97AGC
aVLMnW4NPY3CZdnEEddlyhG/gTSibp0sj9EKAr2gEAN+0ZlSmnwn4izsMB9psHhG
tMFqe4NQ
=PIBt
-----END PGP SIGNATURE-----

--xHR3sS2kvo5MIJEm--
