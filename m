Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web08.11388.1618928362941455110
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Apr 2021 07:19:23 -0700
Received: by mail-qk1-f177.google.com with SMTP id q136so18485230qka.7
        for <u-boot-amlogic@groups.io>; Tue, 20 Apr 2021 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awdSDJIrBFzs3uZRvHybsjC2n2R75Yanbi21ou4qz70=;
        b=OR58jaWiuQbCNMrJQQo/JS5sBEb/aUgV0wwhjXwKiQTEwTCNQL0UXVoVNGDdcUf7xw
         lzwtNr+QVAB+UkEGqk35/HTBdBHrs16OwT/mcN5zfSYCsrAOmAHqQr/vu8ggEsrrGGi3
         IBsEZnv4SRjWxfZg74y7IgHI1rZ20nosoYb1g=
Return-Path: <trini@konsulko.com>
Date: Tue, 20 Apr 2021 10:19:19 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210419
Message-ID: <20210420141919.GM1310@bill-the-cat>
References: <08d42f1d-2d55-0bc2-2e7f-fc2993fd4726@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <08d42f1d-2d55-0bc2-2e7f-fc2993fd4726@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vFoH9b99aVotZEy"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--/vFoH9b99aVotZEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 05:35:01PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This serie fixes Ethernet on Odroid-C2 and enables support for PCIe on th=
e Khadas VIM3 & VIM3L
> with all the necessary bits after Bin merged the PCIe driver.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/7216
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 3a9aaefcaa3efc2a1cef86fbe0bf229a1bff99=
02:
>=20
>   Merge tag 'efi-2021-07-rc1-2' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi (2021-04-18 08:47:27 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20210419
>=20
> for you to fetch changes up to fcf3c9deae1acfda81051c8c211fcbefd4217e1d:
>=20
>   boards: amlogic: update documentation for PCIe support (2021-04-19 16:5=
9:33 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--/vFoH9b99aVotZEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmB+4ucACgkQFHw5/5Y0
tyxZYwv+Mt+7J6ZuTVyXVX0ZDosdSeyFN8Ahb3jWlrsREDkO6kkldkxvCesFvYHl
T1+4ehlxfaQqaed0P5+PyvWSCoAlHNRfpJyTst0nOTl9YKQDgwNkJfVJWMShxMJF
PF5kIW8EPgoupriCMeYs/vZYMzUf+hglbAyl9SKsDZBP+DEdB2NomF+rpr71vioG
f45kDTWQlOZHFxnbvGB5dnuWFwngRyLYFSYbHt2Gzrn7DQMCkhNWYvByl186R7QI
e/TjXieFCV+C52CALHQZgUUlbCCz+qbA7I2Wz+f4Fo+cF46LmkzQC6mKs2tpxxGN
jIYMT49PrQYH5RkWKf1sf4jgtTWTVppwbGB/HYkcfsLDtLkouTzJzjnvDJzrdqIG
HGgHajUZXmva2opYub4rDakKESyFlTv5EIPDshqSGGZj10+qKbDhR6NvBIuYrj+P
C7VCRNvfTC0r0baGWn29Zvf+f7tNiiVSNBBSknPsPwqvUb7M1IWlzrlEUemYKB51
Gd8BL1Lm
=H1LI
-----END PGP SIGNATURE-----

--/vFoH9b99aVotZEy--
