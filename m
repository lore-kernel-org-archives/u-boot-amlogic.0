Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web11.47421.1670861317224687104
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Dec 2022 08:08:37 -0800
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so8942341fac.2
        for <u-boot-amlogic@groups.io>; Mon, 12 Dec 2022 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERQtGAu8FD6iHkLZ3AVsV3I85jBSuZUkegmPM5dzZ8A=;
        b=DIsefykREhWVIhuqkTY/TRjukErOt+ffwCvooaCc+aR4jJZIHzAkaV/YpCfHJUjzW+
         VmLNtE65id1pnzPX0iZIwDA0uGpLJ4dO3K6JRRwX1V4P9YW4ekKVXLvvhGumEghK/lXT
         bs2o6mtKIPIws08dG0iV08TZzI8gMxrd25X7k=
Return-Path: <trini@konsulko.com>
Date: Mon, 12 Dec 2022 11:08:34 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] arch/arm: sm: introduce efusedump command
Message-ID: <20221212160834.GX3787616@bill-the-cat>
References: <20221209125204.62960-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20221209125204.62960-1-avromanov@sberdevices.ru>
Content-Type: multipart/mixed; boundary="Groupsio=Ks3fnhhxofqqsaDvWbTT"
To: Alexey Romanov <avromanov@sberdevices.ru>
Cc: narmstrong@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=Ks3fnhhxofqqsaDvWbTT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 03:52:04PM +0300, Alexey Romanov wrote:

> Using this command user can print efuse memory:
>=20
> $ sm efusedump 0 10
>   00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...
>=20
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  arch/arm/mach-meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

This needs to be moved done under cmd/ somewhere, perhaps cmd/meson/

--=20
Tom

--Groupsio=Ks3fnhhxofqqsaDvWbTT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmOXUfgACgkQFHw5/5Y0
tywTWgv+MjiJfUpA7opb6mmC3bFNtppXgw74+ZNp4LNddtB6ooiyVrYVWps2vJ+i
i3imCr6bl3regZf2KvvG3RN2SevUWp05db6wJVIvumaBjy9E082MYcxk3cAn7py7
VaZwS/Jl5GEGkEcVQUim/K/ggakweyJu0gR88vfqQhb5D6tFdY0GfygfQ/JBHWDx
2PMR4HpG+Zqf6OVcl7W1Zr3m1CoNsKeh/WBztWgZQqhvHnTP4g4w6QzTAwKl3f+C
f1Z+pLnyskoc872NN6aN1kH37CpIKBWE57RoCOdcBWArBkdY/NlwW6HwD88to7WT
vIwz8ETJhT7dl2rz0TdOShza/oT0pw8+Cy4KbxELHTb8LzxmvDPlIMBAZcug/mLU
JDA9PWVM4vU+QDi5cLaZd5vPygdMBe4VPNbWH16qH1mgPvpYmSxidlfOoba0tcXR
V79lCzu5eTV6q8rfRRdSIh298oS1DcOJADACuoJa/DKNekxblKnRualr9LY53h2b
hLt0nL15
=ejq9
-----END PGP SIGNATURE-----

--Groupsio=Ks3fnhhxofqqsaDvWbTT--
