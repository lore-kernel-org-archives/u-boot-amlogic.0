Received: by mail-ed1-f68.google.com with SMTP id q14so15633219edr.5
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8sC/u7h2O9OgVOlh12PzWCY/rjjMZ7mCrUd6WKBsSKU=;
        b=epWWy9IKscYXbuL5ZAE7agM5DOTdMb3ReKf59SA7uLEBFNwKrM8RlERoG1eP5f4sCc
         +dVOtHF76UuZoMYCbh0e+AcyyNeaRGEK1QmT/Sulke/X4i7rIT0tnHzfR+PRKNUzDzSn
         6nE5VynbaYPMs+RUzJf0xjqu6ASwComQ1wNXU=
Return-Path: <trini@konsulko.com>
Date: Wed, 3 Apr 2019 13:22:56 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] phy: Also allow MESON_GXM for MESON_GXL_USB_PHY
Message-ID: <20190403172256.GI4664@bill-the-cat>
References: <20190403114637.32068-1-narmstrong@baylibre.com>
 <20190403114637.32068-2-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190403114637.32068-2-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVYm2bz4YjPqKA1I"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: marex@denx.de, ldevulder@suse.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--JVYm2bz4YjPqKA1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 01:46:36PM +0200, Neil Armstrong wrote:

> The MESON_GXL_USB_PHY is also used on the Amlogic Meson GXM SoCs.
>=20
> Fixes: 2960e27e38 ("phy: Add Amlogic Meson USB2 & USB3 Generic PHY driver=
s")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--JVYm2bz4YjPqKA1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcpOvvAAoJEIf59jXTHXZSzOgP/2kKcQAYBd7oT+etVcE1LKKJ
euKSgNdRf45wyskU7IQiFRr3WNNi9k8Nc72x8CixzVL8X+mq7zhNywRfaEwrAZw7
56T9o7u3mp+1tpB8dT725sM/KpDvnEbM35/hCHyasJfBDJD+GCE45f2f7xC2QKTA
kacVraCSB8oLzVEnAu2+hNj9faj+s0NLUkjedV8YodMTg0BvNjZeDlRqCXcfIXwF
YS67MC/G4ey1hSp7DUqAi/xVWGlHsJxQalqS1Bz1rwNiye7p2sBGNuGCMOfxGhqS
SRLNK/p2EOz/8xwrdqNEvUNiM2aTHz9VytpKQesZn+leCvss5ymr0BLmBwT6AmBf
23sjKmaxUpdGbWgNA9vVKLxgR1ptJObUZzVowaIyf0O74SqadPEbAkicnDE1bsUd
LEyx7ARaBLRM7i/e2XzLkmCrI0grz0A4Ibe4L8O5dN+Ih5rOTXu34kRDB2ziv58P
7l7yRkVpcQ8Yk+zWYcW2FkfrauqELGfof3iQZFL9ahCjkwVwqAjcv0CK1wUe7ize
Xv8SiPhAl8GVbjNhOqyelkNoNBh7jQRS4C2R33K+k56Rf5ZffkkCx6ygUIqVRpPQ
WdFqK9ALJrsTSqiFg0Fa0Zz5i2BPIwQg29RsTpZ8yfi02QxZLRXGuU562KKFaA3x
ONfOKYP1zrppDYMIoXYF
=7w2r
-----END PGP SIGNATURE-----

--JVYm2bz4YjPqKA1I--
