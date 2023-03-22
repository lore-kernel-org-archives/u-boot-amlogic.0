Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.42495.1679491680564773928
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 06:28:00 -0700
Received: by mail-qt1-f172.google.com with SMTP id c19so22499649qtn.13
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1679491679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bd/W3Xf6isNJ05Focbx8LH8YwpmzS+zWox79kvAfBVw=;
        b=YkTInJePMQZxKWliV28FOQU+5WXSOxThMoixfKShXgiYdWDsmyNkBProYXt6+zTdRp
         QEDQT7UiQb+VHM0S81G8LO0jza5M0DTXLudvmk9cRjOyfnGEDbzeBX7Y/IXLXdSWNLnm
         aqonVsy/msPdyPmGnku7m7G7MIbCWQXIEysTw=
Return-Path: <trini@konsulko.com>
Date: Wed, 22 Mar 2023 09:27:57 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20230131
Message-ID: <20230322132757.GC8135@bill-the-cat>
References: <1f1304e3-9f03-0420-c9d0-d36338f413d0@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1f1304e3-9f03-0420-c9d0-d36338f413d0@linaro.org>
Content-Type: multipart/mixed; boundary="Groupsio=SjamMFFsLViivTzOnTPX"
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=SjamMFFsLViivTzOnTPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 11:46:42AM +0100, Neil Armstrong wrote:

>=20
> Hi Tom,
>=20
> A single change to enable the odroid-go-ultra PMIC regulator at boot.
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/15691
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 88e08fc5f6e508eac46cd1dfb0379b11ae032c=
0a:
>=20
>   Prepare v2023.04-rc4 (2023-03-13 20:52:48 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20230322
>=20
> for you to fetch changes up to de58694f0d5431627d7389f50a6b2034a682ba24:
>=20
>   ARM: meson: odroid-go-ultra: setup PMIC regulators are board init (2023=
-03-14 09:03:16 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=SjamMFFsLViivTzOnTPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmQbAl0ACgkQFHw5/5Y0
tyzv+wv9EEcD2uos8/ZAmIecJ3HV01aQYpsVWKnR9AcMIe1Vn3QMusP3VqYDnzgD
y99X3ZO5wM7S2npGrAGLzC3y7Dh7obAFCM4cUSa0nEx7iKU5ZUZ6cuMN6mMEq7fb
qPSQEkD4itj6So/grAqFrsiz4bHtjyjQmy2wwnHPF9FFnIZfozWOAb2dM74tVkja
HL2rY62O/TU9swuxrgdM9yIaFjJYySUcZsoiIBw7vWhk17U4Fo/YTANQBUD1sq0u
i859kD2uY4vFT6Qwa6X83vPPpqYM8ORqhUSakKaVmfXLsfzz6HzyJmLzikJReNjL
FG2QUDMEAJWS+D4jpW7LFP916WvD8SeA4OZEsFV58A4RfOf3AdmA7UOJTT3Pi9ml
aEhMtEH/dxNGo79hpbD+T0JaDy2pyiy8OGUKJETXZjra3uvJOEMvfLtOvjsL0YYa
xh3pg7U2tUiH7xF2G3FGqZXNYmXXTXsFpNUxDCn+v5GhAF6c1CIrZ9qpXzTc1btc
4xA/U0p8
=7qd+
-----END PGP SIGNATURE-----

--Groupsio=SjamMFFsLViivTzOnTPX--
