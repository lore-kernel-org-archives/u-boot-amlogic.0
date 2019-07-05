Received: by mail-wr1-f66.google.com with SMTP id p11so3570986wro.5
        for <u-boot-amlogic@groups.io>; Fri, 05 Jul 2019 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=9fyiH7nunWxWGxPQHM38qciC3Vsn+hL/SpowoWARDCY=;
        b=e5V83Vxsaz1/WvKKfYsVk+MIMZZXXdV1a2S9V/N/fA0QczRNpc0b2AL6HXZpks7pud
         XuUFRReZv412RX94DAXE7sMtvpgXbugeQdoFAUL5JVnvv8aRCbwK9iFbzbS4VbXBQT6p
         A8x3L+pvjGnBzZJu112/eFL9Kr92/XdLqMVjHsg3Bp2U6YsYnQzu4DVS+ZAAu/HZlPdh
         cG6xQl8c5auEnLTZSaONWazmVLjw5D5HJm4pY9u1NCRhDmw3/IryM1p+5xBX7XhKhPvx
         cQniD/9rlFJPZNi60MgoELkaZsLfi6yykwdybuuFKRGmxMHA04NNZiWmk2TCj+uLHfcA
         ElVg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: add mailing-list to MAINTAINERS
References: <20190704135938.1193-1-narmstrong@baylibre.com>
 <20190705000155.GV8554@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c647f75c-2098-5089-15ac-d0345a88612a@baylibre.com>
Date: Fri, 5 Jul 2019 10:52:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190705000155.GV8554@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=IZjb0uDSal9u7OkPmE7K"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=IZjb0uDSal9u7OkPmE7K
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/07/2019 02:01, Tom Rini wrote:
> On Thu, Jul 04, 2019 at 03:59:38PM +0200, Neil Armstrong wrote:
>=20
>> Add missing mailing-list to the amlogic boards MAINTAINERS file.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>=20
> Since you're going on vacation and this makes sense for the current
> release, I'm grabbing this for you, I hope you don't mind!

Not at all, thanks for applying it !

Neil

>=20
> Applied to u-boot/master, thanks!
>=20



--Groupsio=IZjb0uDSal9u7OkPmE7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJdHw+9AAoJEHfc29rIyEnRaNgQAKNd71SqTu7RBsEOY70fRNAU
hR9ilxhUKkgJA88UafPMDM1hf2iKj+KSQjtjcWi8qViUBv8yesfXyLBm3OOS2zsR
boIUa2LcFd9JMwXaACk5XTCAjfxNDtH3geVCKAEWXeXLbEOmGs5SDDf8smYqeQrk
nhoblQz7hZg7PP+VsbglKkVMuwf5g4CNoB+uUU5eKfHuS9/ALdAdguZjaFOIjK8b
E/u8saIOYOWNb7BNtzWp3koahGN+aEtyd1h/j4ATU5uU0nwtHRkZebfHXx/RHt0C
tq697OFFLd0o8jiXvigZFJUpF3W3fssZRWH/Cp8jl0GV5STdc2HshbhjF5KGbAUn
kN3X8aT/qYH1PcSACE0ScxgD2lETgka/yTjFJZZp0ZIUR5BD7wO3EloCX9O7zYQE
ydhukjwi3FO9OFLPtuaLWkZr1q1VIti98t6721XITI/l76Wl4vNW+bHIaUVm73kl
U2c2fW8Kfq+6tpq8yYpwvrgRyxB9LP39nJRw2mPka7SoLa0EwikoV5DFHXJV+7ks
t08F3Brd2b3Dtcqr6YRt9Vg3WU+ZNL+OTOggeE19RafOQqzW9mL2lpxGsdK3R449
gkDcqW7s1JuROQpGH0bpQ/NpTd8nVlOZjrvK0v4HgDuEX34XIlug1ngYy2IjkgdV
KO7stym+BjubHuQz+AVb
=EHyP
-----END PGP SIGNATURE-----

--Groupsio=IZjb0uDSal9u7OkPmE7K--
