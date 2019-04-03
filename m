Received: by mail-ed1-f67.google.com with SMTP id d11so5899000edp.11
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbKGcyARXJUt5f/ZFMNi+uoTEMBzKdIzZQjoCkIiPiQ=;
        b=B0A7Qwz/d+vtAhTzMAk+JmpL6+5O5riW3/bJ6tKJMaJrLcpLtetuLQ3XYPKjHVwEeV
         5eShcEx2LquSsrcQNeTk9nm5ys5zAftJplgtGXsanZkmpmuGRTUo04GQ9l0W0GTl2sdO
         xflr9FGpDXadbEYTtl/m1NvOae7lBPUu0RSmo=
Return-Path: <trini@konsulko.com>
Date: Wed, 3 Apr 2019 13:23:05 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] configs: khadas_vim2: Fix defconfig
Message-ID: <20190403172305.GJ4664@bill-the-cat>
References: <20190403114637.32068-1-narmstrong@baylibre.com>
 <20190403114637.32068-3-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190403114637.32068-3-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aRzsUE0Mp86t8N62"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: marex@denx.de, ldevulder@suse.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--aRzsUE0Mp86t8N62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 01:46:37PM +0200, Neil Armstrong wrote:

> The Khadas VIM2 defconfig was missing the USB PHY config and
> two other misc configs to setup dram banks and call misc_init_r.
> Align it on the other Amlogic SoC based boards defconfig.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--aRzsUE0Mp86t8N62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcpOv5AAoJEIf59jXTHXZSQOAQAI2O9HXLbc0ViTXs0wWYXInY
aH+1JGi0nq5zWPdW+mxK3p6OI5z14AzoewzQLMY1zG1aPjantiOweDFFQa5TJCXN
QQT66mWJy3EHKw89O5ThJYl4brov4pHbkXddiQg2HFXf2+DQBSQEZlNIxQvUypRm
U4ZEGdsJkFHaQveUbM/6oadT0ZbE3qFEcpdtxggTccbuLjkBKnOs/im/nPjXTUX4
iTqcQzVKENwl+PDHdqGERrpyISsSEdCo6mte99THF6ApVe8dhXbdgbvd1Yb85iL5
iS4Z0bKhvJ22ZO76cBFHYPe468y4LAmkFi0oCRGmInse1WxYaIF5qb5kMqhBgxWx
fnZ+464AImjOxeFIo4BteVGpd7ui4Ov03yby4V9y6qlH8iAC8cBO/VjSee0QrMDb
IvE70JtK9TdIwQziU4L1A6WOhllAi2bKHM56UlNlsqipQteQ+sUmzl1Wzde37Qh6
2cYziLI8BmMYhnGaK0ENxDuwVo1i8Gsr6GspIC+l9kv0sccTo99KsvglViEFvlQM
VbH3s3JrB4kQAlU8O/IHehlGRBkkWwIuQTxF8Vxt1Q1/STcDi9CMA/EdiSrXiwJf
uolZOO1w3DwbyRzyyGohOInxKErHS48X1OkSn9GMr9U+hiA1HHTUkjhR1DnOAem0
xN1wjdEOCP4RgHHzqyQ0
=ivsE
-----END PGP SIGNATURE-----

--aRzsUE0Mp86t8N62--
