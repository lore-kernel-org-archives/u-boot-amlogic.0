Received: by mail-qt1-f193.google.com with SMTP id v20so7347815qtv.12
        for <u-boot-amlogic@groups.io>; Thu, 11 Apr 2019 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57u97IxJGAjGlvYXfh8fvO22v2U638zmikgrxW13iRo=;
        b=aWCUEEGFTI7Oje0nXFMf9cUJDWQcNwTqVD/uhraa2Iahmyv/8q2p9zG2P2H9RT00r1
         IdWBnECQ/aZiP6agVIEj4Yy18vIsnEH8sDQs0UxGTPsR+/Ms5rdCArpPdckU/3ptx2Qs
         JzR2H++HcG7IbOdPrGVcUUYq6APkhi3ihCA2o=
Return-Path: <trini@konsulko.com>
Date: Thu, 11 Apr 2019 10:52:14 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190411
Message-ID: <20190411145214.GC4664@bill-the-cat>
References: <0ccf82f4-9490-b40c-419a-93eea9691992@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <0ccf82f4-9490-b40c-419a-93eea9691992@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KYDL+JEW1t54otQB"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

--KYDL+JEW1t54otQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 01:16:26PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR adds support for 3 more Amlogic boards, support printing SoC
> revision information, add AXG family support for I2C and Reset, then
> fixup the AXG pinctrl defintions.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 48ff1bc4f0a97c3291d0c87c2717fc1d79da5e=
f5:
>=20
>   Merge branch '2019-04-09-master-imports-fs' (2019-04-10 08:18:18 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190411
>=20
> for you to fetch changes up to 2c4e3cf21257f962e69264fe91ff2cc23cbd041a:
>=20
>   pinctrl: meson: axg: Fix PIN and BANK offsets (2019-04-10 16:54:59 +020=
0)
>=20

NAK:
   aarch64:  w+   libretech-ac
+(libretech-ac)     sandbox_timer_add_offset(test_add_time); \
+(libretech-ac)     ^
+(libretech-ac) include/regmap.h:289:2: note: in expansion of macro 'regmap=
_read_poll_timeout_test'
+(libretech-ac)   regmap_read_poll_timeout_test(map, addr, val, cond, sleep=
_us, \
+(libretech-ac)   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+(libretech-ac) drivers/spi/meson_spifc.c:169:8: note: in expansion of macr=
o 'regmap_read_poll_timeout'
+(libretech-ac)   ret =3D regmap_read_poll_timeout(spifc->regmap, REG_SLAVE=
, data,
+(libretech-ac)         ^~~~~~~~~~~~~~~~~~~~~~~~
w+(libretech-ac) drivers/spi/meson_spifc.c: In function 'meson_spifc_txrx':
w+(libretech-ac) include/regmap.h:277:4: warning: implicit declaration of f=
unction 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]

--=20
Tom

--KYDL+JEW1t54otQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcr1SeAAoJEIf59jXTHXZSDGoP/jOC7lc83UZ/ourQyzOwg+kq
znJX4Ja9YlQcdIxzhsNjb8FC1mhCiHZwIzdNpoqXkioaWp7v7ERg2Y8Ce3t/KWdI
8XrTbd7xR+u0RoPjHQcl2GXP7PalW89tdNiueiQyexYfks5UjM0zFF131UJrbAbI
H55S1V2QNcY7xlGhNwSph4UNkH8ZfPKNIWYbJSxunGbZHptLWFKlhLswWkfL1R0k
a0ve/RZl8DgErdMW04e2fU4Nz450IWLtqEL8qWBj+SDKG/dGPNvt99xGDtFcMTpA
twBGeC3QZpMnAPsUS1Wue7ueFNy4tjZU+yHH93VrXUmMfj2MKL9TRsjoCHeP+8SD
DNjMvAcmPJH5oi/2ZNM4C8Kod/wO/rnO04/NIU8Dk8AULUHQtVCywUcjp745JYYv
85xUuAUh2cIkPWJF9u8N9Ob4NcWFXsVxYwFix/3luOKAS2mHgnt9vFNhBkU99/k3
3r+fhDUfYTh3MSBvi+Mp6hsw9pqraYUx5sDQW7jF8GimBHTkRHJu5S7N5IwyHSb/
2Sk5JImt0i4s83no29HB402Nrh/z15G6NYUYymas/YzwZ4zd/mbVl/npmv4qvHO+
xTa1P4Wfi9O7NrbYRoU1O6pS8txaCYpmP92JtCPZUQA42hVhOUVc8Cwh5GPNAw/g
QgHaHtjrxjrVbfXZFj4U
=Gpiu
-----END PGP SIGNATURE-----

--KYDL+JEW1t54otQB--
