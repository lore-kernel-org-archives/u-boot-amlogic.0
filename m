Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web10.8889.1610549036257095316
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Jan 2021 06:43:56 -0800
Received: by mail-io1-f54.google.com with SMTP id q1so4530783ion.8
        for <u-boot-amlogic@groups.io>; Wed, 13 Jan 2021 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lpdHGVJjpyJYnGmMPLT9JnvPKBZZpKL59BGNNdQx6wI=;
        b=h14peIcfuMJwHhNeKeaECCySjJ8KxXamXpT19L37zU/rGK9pr/9jKK6zs3rl346xJi
         HWdFYtXWDEqI3Grt2jbohnAqLPmZGCVGqywndqzwVhlJA+2lfCM7vJ/0nzQYxulOPYK1
         GcKyo8Udc1qGvKgnORoU9XNXHBE/EosODlqis=
Return-Path: <trini@konsulko.com>
Date: Wed, 13 Jan 2021 09:43:52 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210112
Message-ID: <20210113144352.GI19813@bill-the-cat>
References: <c4315c42-2711-c40f-f843-9cef24a24f20@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <c4315c42-2711-c40f-f843-9cef24a24f20@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 05:39:54PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> These are the changes for the next release, in brief is adds some feature=
s to the VIM3 boards
> (drivers fro function button detect using ADC, mac from efuses), new boar=
ds (V2 of libretech-cc,
> GT-King/Pro and Wetek Core2), all this with DT sync'ed over Linux 5.10 wi=
th new Power Domain
> driver support. A new DSI panel driver has been added, the rest of suppor=
t will come next (PHYs, ...).
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/5836
>=20
> Thanks,
> Neil
>=20
> The following changes since commit c8f2a060a15b8a21cef90c82cc49f70517356a=
50:
>=20
>   xea: config: Disable CONFIG_SPL_OF_PLATDATA_PARENT on XEA (imx28) (2021=
-01-08 08:42:08 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20210112
>=20
> for you to fetch changes up to 6bfa331a6e22507ae839fb8474ce1b3fd58808df:
>=20
>   board: amlogic: vim3: fix setup ethernet mac from efuse (2021-01-12 14:=
25:55 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl//BygACgkQFHw5/5Y0
tyy4YAv9ESrgCEJ8uP0Tco9obpPaeu7GTM01+hQmdyanxFzDUm8joZgdrrSi6WDv
f1VahpruMa5NonBFrazHT5NzkqMP8VKSiCfEGA0UY2Mix+KtC1R9a9m0GT9lwsqE
+zTYN80pQhVwlpRwIZvrxzi68EpZVZkSWkGvLVegnwly3CJVquM/3DjQi1UFvBr4
b/vEAXlOBvkgwH//curDGgXaEgUl7pvUefQ+Od+juEF8RT2NtPSQTHmSMffrLC1P
VKbfv/x5i2l8MEI71HUIBC4b6NjjToLRDbvbsUx6QKKSbs95+oCsnkiWzIitEI8Q
TjPkwZKs3xyIzLGZu1m++ELsn3NSOf5CRkHE/gaXSHmLI5+LEc6GfjV80Mmo+8l3
NPXyVx3Y46YScHp3IFMr0o0cUVlOImy9N8htYU6FWJj8m8bExLQXLGSC16oAUIgO
b0D3k2SHdUVGJt/qHkmOGvJved/+wFxQp4ZW0ihTn5RhMuyz8lgJZjNp9d/hOeF7
IDUg7paO
=ERV9
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
