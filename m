Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.14136.1604680004610930599
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 08:26:44 -0800
Received: by mail-qk1-f181.google.com with SMTP id i21so1546536qka.12
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AO3R842Ff+jE23AXMDAFfyI3pFZvRp/XTMGFpDYkzY=;
        b=ggE7GF7nhfLAK4caoBcwDoUWGpz5c2XDtsglqeTmk0bg7F+IHWCj5RzZkIBVD0DT8q
         iSLj/NL8RVvdyYxUWLBDoPjSNA1/24ksX3BH0wvGqAM599Eei5xPlfgVMm/t4lGgQC6v
         EB9YFBW3J5FVCnJwviuRmu3U8ApXOBfuAd/yQ=
Return-Path: <trini@konsulko.com>
Date: Fri, 6 Nov 2020 11:26:40 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20201105
Message-ID: <20201106162640.GF5340@bill-the-cat>
References: <c64adb73-4f9a-b7a1-7355-e59664b352cd@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <c64adb73-4f9a-b7a1-7355-e59664b352cd@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DlulSKxyeiBpYDZ7"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--DlulSKxyeiBpYDZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 10:49:31AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR fixes some documentation and the android early logo boot flow.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/5274
>=20
> Thanks,
> Neil
>=20
> The following changes since commit cdeb7b8f984e6d9bcdc5a6fdda6107af156d47=
bf:
>=20
>   configs: Resync with savedefconfig (2020-10-29 10:48:01 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20201105
>=20
> for you to fetch changes up to 014b9f96762d17d04038d8902d419b6476753e4f:
>=20
>   configs: meson64: relocate config_distro_bootcmmd header (2020-11-05 16=
:27:31 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--DlulSKxyeiBpYDZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl+leUAACgkQFHw5/5Y0
tyz71gwAtSYaFkK8ylA21Xmg7CkGUCdRPiMqnuEnWO0+oPAHrqdJCpChWElKLWUr
E1glU/jiTGj79R8/XBsFkPn00n9FBJeXheDQb0i9MJUIWbzM4ED5VURySa1jtQ+i
NeFZvwUtZ4yB7BGUVgHE8qxj0JzPSX+qXeu66Gu7qMtDSyWGP0OGsmIi70hfGvU+
RR+i3eTHVUtvuePTTXAM6mShrUkRxzFnHdc+dzUXgV9RosE42BnCWcTZI/3a7u5Y
oK8JsH1b8Tet80LqxgxUQTj1YKQ9FIKWK50Pm5b0A20VWZ6256uvTkCCYjr+ekbZ
ExksM5tvLocLWKCbCFCoPk8aBjQapjCqkMsCcndxDv0z/TR0PDVR+feLTJFxcCY8
4M2bPkWP33r69Sr2UHNxGfnqJr83BHWSQo+gbDkmxd7vSw2iCVlD3ptV+YDhuIiI
DKcQwHKFi21PsFvzTh5Os04L8W5EGhsk6sBhLHeHORMRF47to26ad3cQWq/GCOLu
wJzHBMzl
=IIoS
-----END PGP SIGNATURE-----

--DlulSKxyeiBpYDZ7--
