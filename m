Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web09.39400.1605552000768924798
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Nov 2020 10:40:00 -0800
Received: by mail-qk1-f175.google.com with SMTP id y197so17773435qkb.7
        for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2020 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnZiYyKusGP+3CHqXA9ut2f6zUq9jrDfRZ1Vd/rco4k=;
        b=koy0tPwZTwmBHhuGJM/XYCIQXxrgsDkujPOyX4eq+Y/66hCiYowooMSeeNrAU6p+Ao
         VD69fAOUc0oTuy5yGQT9U0urb7CPi7CdJP0j33kX/3bjzJ3swNswuEDT5JSfgsSFVwBk
         mMyLzALEMcSzKYmwUx7Owmkq9TaLwLZos8SxE=
Return-Path: <trini@konsulko.com>
Date: Mon, 16 Nov 2020 13:39:54 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20201116
Message-ID: <20201116183954.GX5340@bill-the-cat>
References: <d04edf13-4004-d39f-1280-8589a880e2c9@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <d04edf13-4004-d39f-1280-8589a880e2c9@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4hrGwnOWmUtdCfj"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--p4hrGwnOWmUtdCfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 11:23:19AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR fixes the MMC driver on SM1 based platforms, syncs the SoC Ids an=
d fixes 2 potential
> build warning.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/5354
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 832bfad7451e2e7bd23c96edff2be050905ac3=
f6:
>=20
>   libfdt: Fix signedness comparison warnings (2020-11-10 14:31:08 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20201116
>=20
> for you to fetch changes up to c87eab81616d671a6004ffc95847bad21b7eb005:
>=20
>   ARM: dts: meson-sm1: add u-boot specific MMC controller compatible (202=
0-11-12 14:31:29 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--p4hrGwnOWmUtdCfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl+yx3oACgkQFHw5/5Y0
tyw96Av/dE9ajc5d4XAA5RJ1ZuYpZ065BlPhRxnvywFB6f+JZg9Wo9UtN9loVDsv
MqHDbRtB3EfYjMW3lZaCcclnS2tImlC1DASydHUGnGx3+zshaGhYldVESflQ99C1
AYm0V4++3SfAVupg+0RbQBnIKSyjej0pEi+HlP5cM2AHwZc8IPl4fmqDdkHxBu4G
Caec11FpMyCmYmEg7ynsauI/JsivFy5Ek2C7GqN3x/mjh8yL1r2AIIjiw8SAr+ol
mOtd7III4A/mhU/dRXML2d4elIxbbXkgFGgxkrnJsXcrGp4HTPgToXtUODqEiEUz
6TQzcz0HODPFJAGhl3FzxSKe4xts5hklmTRQNjjcIOT+hGRW0O0X5J0HZMdbVcDy
i5wnPVShQZiSjkGTyFxszL8NQUHuC9svhy0cCBbMbk9veNjD3Hujlex55Hq5uWD0
Z5fY/JdwlUYjHdDFLP9G19aXzQJ0daL5iVMToYwOXf3/ab/L0eoGppmC0MbnFaDY
iYixRFi7
=m3W0
-----END PGP SIGNATURE-----

--p4hrGwnOWmUtdCfj--
