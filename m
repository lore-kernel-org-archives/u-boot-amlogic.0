Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.3451.1637379761233579415
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 19:42:41 -0800
Received: by mail-qt1-f175.google.com with SMTP id 8so11394241qtx.5
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=doQb+q0mias76hrT04DFWGUu9H04cO2fAcdgQOFzCsE=;
        b=ePWO56QZnEDvHWuJKPRr19xfqG1nqUKFrPBOzZWB1jmYuh2uBveiA9VQtyosTOLNy4
         4Q/Bcm/ELf2Rmj5yLQJM6yAjskkmfQ6Ih9uQ/pJZwYQm/Ph/nm7XI8+VMYaj3wNnjE+m
         cYg77RUQCYin7hvN0rsaEGyCU0oMm8YA97xEA=
Return-Path: <trini@konsulko.com>
Date: Fri, 19 Nov 2021 22:42:38 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20211119
Message-ID: <20211120034238.GN24579@bill-the-cat>
References: <eec6afbf-97d1-2e65-3c16-3ea75f0aefe2@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <eec6afbf-97d1-2e65-3c16-3ea75f0aefe2@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x40GMfxvo2H+SiQC"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--x40GMfxvo2H+SiQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 06:45:12PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Here's a change to fix GPIO declaration in the Meson PINCTRL driver, and =
a couple
> of changes to handle boot errors when using the meson64 android config an=
d permit
> recovering the board via fastboot when the boot media is invalid.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/9918
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 8391a0f3d97c0300d7eafe7581b6712afb18f2=
83:
>=20
>   Merge branch '2021-11-18-regression-fixes' (2021-11-18 18:25:19 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20211119
>=20
> for you to fetch changes up to 28f70cfcfd82ac509c8da772b74e5dc2df795fd2:
>=20
>   configs: meson64_android: add PANIC stage for SYSTEM fails (2021-11-19 =
18:15:26 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--x40GMfxvo2H+SiQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmGYbq4ACgkQFHw5/5Y0
tyxiqAwAlO6Cb5/NhyGLyX6YSWthJIgssuepEvTAZRbhOQBabMNxHbDwssMgHWUD
d/gS7REl36KqcaUxqZx822WGD3uY/v5Ps45CXdMLJCnrG/Aei1F6cNwrfnIddwqE
SE+g8X+LgVHvXBR1bwkYeFqNC+ktobOYeb5aiWHugLqxS6oAaa6VcNTjRy3kbtFt
GuH0Mm5sMJdZBVMdZYk5CHuTLwCGwLU1G/0VvB6zivODpKNkvXgXG2v8Z6+c24CZ
Kn+Q/cANuKT9xGEhrBhiS1mPPhj3js1lIG79jTNYGHhG60SRTRqqi09OjjqiyAo0
JHyBx9yszkzp5ZuUR0YIEHpQnjIE1gMMdQSqKyAVgesTaauj3jZ12gvZnNRySN6d
zVGxIBNu5MeWx+iGOVl9mRqeW9xJpNDK9DetvOXjHp/V9CvZSwdfrrLNalinss/z
a+jaVByVbkj0MPni5IAnrVCYSosqm0yG0SFYsHEfRfcVpsbnbYWQJKTnXGRPaQw5
RSjmReAh
=tatH
-----END PGP SIGNATURE-----

--x40GMfxvo2H+SiQC--
