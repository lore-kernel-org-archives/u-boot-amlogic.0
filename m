Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.26225.1641779370882376369
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Jan 2022 17:49:31 -0800
Received: by mail-qk1-f170.google.com with SMTP id t66so13326609qkb.4
        for <u-boot-amlogic@groups.io>; Sun, 09 Jan 2022 17:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3tARD80uxV8cc+buBcZ4x38n1221dTsovyu+QZLQQw8=;
        b=REMs6Xs62BFUq8mr3d4qZbL1/nfCOOpM7L6dNFafA00MCepvXhLENRxvTDcSxDrGZI
         N1J6Q4MTblIPcafCYY3mn+LrarQQo0kYkTlpfFG2h8n0/34nEFLv0i5oN9WFBjwhrn4r
         EnzYe/wf3nLaAtHuNfjrAAR0puMq7DCrTSsA0=
Return-Path: <trini@konsulko.com>
Date: Sun, 9 Jan 2022 20:49:27 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20220107
Message-ID: <20220110014927.GM2773246@bill-the-cat>
References: <a62eb809-699c-0f94-0e6a-e119bcea28dd@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <a62eb809-699c-0f94-0e6a-e119bcea28dd@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQC2pbIvkpPv3Ssp"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--pQC2pbIvkpPv3Ssp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 04:14:29PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Here's changes for next release, nothing particular, no new boards either:
> - CONFIG_NET_RANDOM_ETHADDR cleanup as you suggested
> - android boot support for Khadas VIM3/L, and will ease support android b=
oot for any amlogic boards
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/10491
>=20
> Thanks,
> Neil
>=20
> The following changes since commit c00c147dae51f06e012841371f9baffb4b9dc1=
b3:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2022-01-=
05 13:08:45 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20220107
>=20
> for you to fetch changes up to 4c8d067bc520fc2ce6dcd7c5833b090f22c67185:
>=20
>   configs: khadas-vim3{l}_android_ab: enable A/B support (2022-01-07 10:1=
2:43 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--pQC2pbIvkpPv3Ssp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmHbkJwACgkQFHw5/5Y0
tyxrGwv/VeNCSanvGkzg3PJvaQkUEizZlQlVhTYyu40rXcKv94ivslFMuwhLwtBB
Mp9d1z2PEnjVzqIVmMAQGhqzFA2/LpjIGXOB1GR4kAXUGMPBPp6qIzO0kKqNZ+Sh
wZx7NV8bllFNYvKyUqKlkZjeqgVlR4TD7Cy4E90G5JtA3wlQNEiBdDQ4RM8+q6oD
zZNufrIRQ9cZ/LKO9UnWwnfdk3Zc7A63nKy4Bn+EEChx5q77vlMeZzWHbtUr1zPl
AJ+gGc/BYoOLlzy4cKgcOUlm20g/Z9b4joUNLKGvynOscw/PFfQS9RRwLwrWjjT0
u/uVazFx1mV2wLRUDOCWRrNfioLoK5ec0JOc2h64udcFXmaDSSe5qxr07ZWFD7xb
OVw30DK7wC8+QUwaNzA9VO9wlZ0GqBjfULGQQS0Hg20hmm32TWs8IimNXkvDMM7p
2ytmQ82zOQpYVz2IllSbAVjKrYhsuBWC9K+qNDK9qtz4zs7fyet4WeBl0NFlyt2c
RBYs68F0
=c554
-----END PGP SIGNATURE-----

--pQC2pbIvkpPv3Ssp--
