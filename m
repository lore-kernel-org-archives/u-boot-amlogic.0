Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web12.323.1617731309629112967
 for <u-boot-amlogic@groups.io>;
 Tue, 06 Apr 2021 10:48:29 -0700
Received: by mail-qv1-f45.google.com with SMTP id es6so985755qvb.0
        for <u-boot-amlogic@groups.io>; Tue, 06 Apr 2021 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LhKIFyqdGOId7V9zjnAQAvkCE/QsEhnanqvfFLx/DnU=;
        b=CMzMxvkYblOFpSDNDIGQEXcIc9x1XPItTNQPOgJlkMuakZsZdI2BNmAJVXyheDZaXB
         pNia5gLbfelPisUylmEGGM4SUORzFCQqiwbEyg4FON/MXfyXvZkFxa6PNPulryiX9My7
         hsm1GuO88aLMztNfE2txFGeVwzcAyryKhJLiU=
Return-Path: <trini@konsulko.com>
Date: Tue, 6 Apr 2021 13:48:26 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210406
Message-ID: <20210406174826.GM1310@bill-the-cat>
References: <f67d9f94-3bc2-5ee0-a709-48a2ef0fbe3c@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <f67d9f94-3bc2-5ee0-a709-48a2ef0fbe3c@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbYrksqalqMykfDY"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--VbYrksqalqMykfDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 02:19:39PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> Let's start this new version with finally all changes to remove static et=
hernet MAC & PHY
> setup for Amlogic SoCs, with DM_MDIO to support MDIO mux driver and a pro=
per designware
> Glue driver. And finally it removes a whole bunch of ugly static code, ya=
y !
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/7021
>=20
> Thanks,
> Neil
> The following changes since commit 90eba245a66aa20589404ba537215faf2012c1=
a3:
>=20
>   Merge branch 'next' (2021-04-05 11:29:57 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20210406
>=20
> for you to fetch changes up to 2fbd37001c77f0b78d43c578d8e350a6afa27e24:
>=20
>   arm: meson: remove static ethernet link setup (2021-04-06 11:10:29 +020=
0)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--VbYrksqalqMykfDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmBsnukACgkQFHw5/5Y0
tyyC1gwArFTO0mj9lI5GxCqSA3omjgaEGgWp7Xo89aDMaJ+ozS4xVGTz9IAiTUTR
S7rnAjq0DeAwV/gwLIN51FNjhG443YpmQZ7peDVK7m7gW/z1eueRMCv9FTrFR+eZ
YXDSLbDCaFnNiSjhCso2usBfZw/QSbXVPto84QocdIeLnq7etHgjl2Au5dK+Rcc5
ykq688TNaPYhxy/Nj68tgHsEnq601/SzvQbBjLgbIn1eN1ZeBfMBWOGRmbl83pcs
scmhd1HQUnhX+ve2sqzAtvkd7rr7x0aRWnOfZRBUBAm677FcYZMoE/W/BdQjsTAV
now3IbEYRohedgwp0YTBom6gJkqjeHPUY0wGq67Nsmc27rxNF38fEsgX5x2vnspP
Vzu6CIODpvaUNyFfXOdcIdGHrxTexBah9/gmk+yExD4WAjbZo/89Vpd8d/A4QXuh
HfQMPk9F5XjbLlRsDQCfc9Q4M2y66F5AcCN9+IL34/H78rxSKcRl8B8m3zjDymKR
rJk07ruq
=fvdH
-----END PGP SIGNATURE-----

--VbYrksqalqMykfDY--
