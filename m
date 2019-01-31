Received: by mail-yb1-f194.google.com with SMTP id 64so1923192ybs.2
        for <u-boot-amlogic@groups.io>; Thu, 31 Jan 2019 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vkn2CYk9T+hXTubzBwApOuvm7Vq8XmCuRMTvoJpHjfs=;
        b=nfTffwT2rHRWiMxxNUKoR4nIbGMyxHkw9vgaoo7PfSd4wqqEct8Jfqzbhawh8peSI0
         Ys+eE6gCiaItVXB8reyHWiRFIAbgypfoCeVjjlCPY1CfHs89HhXcm8wWbdo/zA9VDfrR
         a4uohSwU5gjD32OR/jhLM7yqz3O34OOZKUVJg=
Return-Path: <trini@konsulko.com>
Date: Thu, 31 Jan 2019 16:07:20 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190131
Message-ID: <20190131210720.GI30838@bill-the-cat>
References: <71a64c72-a9fc-4002-00f0-0dc632809513@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <71a64c72-a9fc-4002-00f0-0dc632809513@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T3gMhG0dRUMlbdt/"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--T3gMhG0dRUMlbdt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 09:42:50AM +0100, Neil Armstrong wrote:

> [Oops, wrong subject, now fixed]
>=20
> Hi Tom,
>=20
> This PR adds support for HDMI & CVBS video output support for Amlogic GX =
SoCs.
> For simplicity, Anatolij acked to include the video patches along the pla=
tform
> changes in this PR.
> Video has been enabled only on libretech-cc, but will be enabled on the o=
ther
> boards after broader testing.
>=20
> Thanks,
> Neil
>=20
>=20
> The following changes since commit 535d74a8ae8d194269cefdf59ae17a92cd6e75=
dc:
>=20
>   MAINTAINERS: Add Amlogic entry (2019-01-30 21:22:53 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190131
>=20
> for you to fetch changes up to fce1069bfb9b0b12fb760c408833c33243492257:
>=20
>   arm: libretech-cc: enable video by default (2019-01-31 09:35:01 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--T3gMhG0dRUMlbdt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcU2OIAAoJEIf59jXTHXZSKM8QAMVl2NZ27zeEfbfBt+AqmBB0
7ITlnn9JmJRuQf51bKygMwOhurb5/hR9Ov54Mz2bwBR7vocyjDW27aOSBu9FDLMA
cMnkk/9dHiQYJ2swrjY7MoeGm5VXTkRUVdaxxe5SAvdo/7Wug8rBH6V/+75zICpp
58L4/NLEEcmgsFQYeiOoI8Q8Q2u5tH0cV7Zu4H9Gg1PmdQIz9ySKGLoMfc0OvVY/
a/VWe1j80FezN2ZYI3pJBC0RLTtkCAvy/k+b2E9CGqwH8ah1NWjVyRoD7022TgRU
WaA1PT2hJVMDyy4Fr0dWM5wfda1lVFpOi0QKVq3WA7WUQ9zg8LlDkATEF62P8Ldk
RjbWdR+zznrH2Xvp2AvzTe+sQYH/vCqD8kF3CGSAG5k84PMQwSuVsl4qxfjVYh9a
mPscc+qRvGsEzlOFPR+g9nTyFGXEmrzcJyOx64Hb8KfABl+8LhppXp+eTdu45ND2
UWwxxJM+bv2xqmBxvcwZu3cQdlUEBGjtFeA8j5RMd9dZRCf3LBTdWpjoL3ADvv/B
sGGzky6rfdfbA5yGTDsG5bDSq6OclbMs5pGg2nFyezzMOvEgfJqiZyG/KIwg/YXn
rshLYEUphDyGYZMq31zeQwweoZYHiSOlBLMaks/yQl46f5LeeSj21WygtTCRmOlh
7FAMXZPdcdTI4gdM57jJ
=bwXF
-----END PGP SIGNATURE-----

--T3gMhG0dRUMlbdt/--
