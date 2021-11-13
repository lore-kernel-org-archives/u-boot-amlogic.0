Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web08.48.1636818587061829506
 for <u-boot-amlogic@groups.io>;
 Sat, 13 Nov 2021 07:49:47 -0800
Received: by mail-qk1-f172.google.com with SMTP id a11so5521522qkh.13
        for <u-boot-amlogic@groups.io>; Sat, 13 Nov 2021 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJx0ZrQ4+sm0mtTVQHimbLZR5oNJ/xE1gGYDKcnHjD8=;
        b=VCNbdfXwzDkWtsgq8nWkzu5tXMHJvq4ClyAkQQL+VtFwM9RjByD7A0TAhi8b5Pg8sF
         NMue2avegfo6kawnSLUuug+vp4fjh342kjSnN2aciR8qZH2+yrnhlnoFSR7/14J1KgXo
         cjdlAc/O+5sGuBhXFgIpOh33TPo3f09xLkWhc=
Return-Path: <trini@konsulko.com>
Date: Sat, 13 Nov 2021 10:49:43 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] pinctrl: meson: Correct the driver GPIO declaration
Message-ID: <20211113154943.GX24579@bill-the-cat>
References: <20211113140716.371496-1-sjg@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20211113140716.371496-1-sjg@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34iIHvrQgZwTUPuz"
Content-Disposition: inline
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--34iIHvrQgZwTUPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 13, 2021 at 07:07:15AM -0700, Simon Glass wrote:

> This should use the provided U_BOOT_DRIVER() macro so that the driver gets
> added to the appropriate linker list. Fix it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 7c9dcfed50f ("pinctrl: meson: rework gx pmx function")

Reported-by: Tom Rini <trini@konsulko.com>
Tested-by: Tom Rini <trini@konsulko.com> on libretech-cc

--=20
Tom

--34iIHvrQgZwTUPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmGP3pQACgkQFHw5/5Y0
tyxgCgv8DR1Dl6pjWb7cqCM5jo68jRsM/LGlfTtwQj9Ar/DEV+wOmu2NskG95mCh
Kjj/tlNqOS8GP18iru/h+vAr6KkhgFE3Ca2ilpE3MFzRhAVYsNEACYjCjOD9sSb+
P4n8YOYTiQSjmgRr5iQFXoM27XtKt7Ji9M29DQWlxTVN9rPYWPs6+P0f6heSey8R
uzPkI5FGAXEYHsevsJl075f3Zgpgt7F1v5l9/0kKdRgjSlysyUyyJqqnIMrPcvn9
jscdV8Sd95/313DbsTR+HMQLkBCRL7soq06IBDZZlr9mJnN4gNXpiAxkPKkqAfQK
tO5374iTM73uJ5BHSf0xm7vaa1h4rG6O8qiRa4aRG//N2HnJIg6c2tWwhXKAe47b
EiVfwrWmKiR7Q3yIayq5GOEE2F1l/0nlh/RVtrLKsKDMmymHf9sC9u/v5pXKWe2F
tVgHI6+76X+jlTtYUyS0R4DXBi6QmzyMcbs+RJErpHyeBzQEtwnmY9CwI8UJW8sk
5+ZWvzSx
=wCu2
-----END PGP SIGNATURE-----

--34iIHvrQgZwTUPuz--
