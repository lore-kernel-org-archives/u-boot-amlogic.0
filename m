Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.12034.1589979830865509946
 for <u-boot-amlogic@groups.io>;
 Wed, 20 May 2020 06:03:51 -0700
Received: by mail-wr1-f67.google.com with SMTP id k13so3083109wrx.3
        for <u-boot-amlogic@groups.io>; Wed, 20 May 2020 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3hw3ps0RxANwWrnpvdGRULP9ziVcThDe++5KGnkqC94=;
        b=ot7jJI/jE/6HzYxdRk9uDKuTFwhhlB915jZRGRQBTjRjxF2pNyGZ/0ZWE/8aqy7Rf3
         GpRKyW3Hw5zS62Df9PxGYAjsoi4Tu1bTsXVfz1bemQhrxuRhGAth2oyQiF3h3elCamfW
         kYz9FFMCsSkUncs6eHxFZYadpzNeWyJkMHRJmSfFaAO9Ma04hLgk7/qOJB6MSKRbB/ka
         fh0PnNVJcB7527AdBu/TjsPtsX/VkcQM+Qqrbt3HptT/xk60v8xhgea4nzr+Mk/ZXH0t
         zYpOxqEr1BFSHY5enoqjoHBksDO7r6pCvcSvvY4C8JkRPfDo123CrzotF1kdeL5LSghG
         VvKA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/7] amlogic: Remove ARCH= references from documentation
References: <20200519145111.21515-1-trini@konsulko.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <37ea420a-a455-2e33-a7d8-1d1c6e135c62@baylibre.com>
Date: Wed, 20 May 2020 15:03:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200519145111.21515-1-trini@konsulko.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 19/05/2020 =E0 16:51, Tom Rini a =E9crit :
> When building U-Boot we select the architecture via Kconfig and not ARCH
> being passed in via the environment or make cmdline.
>=20
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: u-boot-amlogic@groups.io
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> As an aside, these files should be converted rST and moved to doc/board/
> and the MAINTAINERS file updated to include the new documentation file
> too.  Thanks!

Adding this to my TODO list !

Thanks,
Neil

> ---
>  board/amlogic/p200/README.nanopi-k2    | 1 -
>  board/amlogic/p200/README.odroid-c2    | 1 -
>  board/amlogic/p200/README.p200         | 1 -
>  board/amlogic/p201/README.p201         | 1 -
>  board/amlogic/p212/README.khadas-vim   | 1 -
>  board/amlogic/p212/README.libretech-ac | 1 -
>  board/amlogic/p212/README.libretech-cc | 1 -
>  board/amlogic/p212/README.p212         | 1 -
>  board/amlogic/q200/README.khadas-vim2  | 1 -
>  board/amlogic/q200/README.q200         | 1 -
>  board/amlogic/s400/README              | 1 -
>  board/amlogic/sei510/README            | 1 -
>  board/amlogic/sei610/README            | 1 -
>  board/amlogic/u200/README              | 1 -
>  board/amlogic/w400/README.khadas-vim3  | 1 -
>  board/amlogic/w400/README.khadas-vim3l | 1 -
>  board/amlogic/w400/README.odroid-n2    | 1 -
>  board/amlogic/w400/README.w400         | 1 -
>  18 files changed, 18 deletions(-)
>=20
> diff --git a/board/amlogic/p200/README.nanopi-k2 b/board/amlogic/p200/REA=
DME.nanopi-k2
> index d450d3c2b2af..c8dec3569b4d 100644
> --- a/board/amlogic/p200/README.nanopi-k2
> +++ b/board/amlogic/p200/README.nanopi-k2
> @@ -24,7 +24,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make nanopi-k2_defconfig
>   > make
> diff --git a/board/amlogic/p200/README.odroid-c2 b/board/amlogic/p200/REA=
DME.odroid-c2
> index bed48c5728ba..3b9f80df29d8 100644
> --- a/board/amlogic/p200/README.odroid-c2
> +++ b/board/amlogic/p200/README.odroid-c2
> @@ -29,7 +29,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make odroid-c2_defconfig
>   > make
> diff --git a/board/amlogic/p200/README.p200 b/board/amlogic/p200/README.p=
200
> index 01d82d1e79e3..84d5ca535691 100644
> --- a/board/amlogic/p200/README.p200
> +++ b/board/amlogic/p200/README.p200
> @@ -31,7 +31,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make p200_defconfig
>   > make
> diff --git a/board/amlogic/p201/README.p201 b/board/amlogic/p201/README.p=
201
> index c251096ce142..4bb5e9590532 100644
> --- a/board/amlogic/p201/README.p201
> +++ b/board/amlogic/p201/README.p201
> @@ -31,7 +31,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make p201_defconfig
>   > make
> diff --git a/board/amlogic/p212/README.khadas-vim b/board/amlogic/p212/RE=
ADME.khadas-vim
> index a2c7606454f8..ccf933861b79 100644
> --- a/board/amlogic/p212/README.khadas-vim
> +++ b/board/amlogic/p212/README.khadas-vim
> @@ -30,7 +30,6 @@ Currently the u-boot port supports the following device=
s:
>  U-Boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make khadas-vim_defconfig
>   > make
> diff --git a/board/amlogic/p212/README.libretech-ac b/board/amlogic/p212/=
README.libretech-ac
> index 538604261b84..3f713ec32634 100644
> --- a/board/amlogic/p212/README.libretech-ac
> +++ b/board/amlogic/p212/README.libretech-ac
> @@ -25,7 +25,6 @@ Currently the U-Boot port supports the following device=
s:
>  U-Boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make libretech-ac_defconfig
>   > make
> diff --git a/board/amlogic/p212/README.libretech-cc b/board/amlogic/p212/=
README.libretech-cc
> index 6af7de3cfa79..74434d4435ec 100644
> --- a/board/amlogic/p212/README.libretech-cc
> +++ b/board/amlogic/p212/README.libretech-cc
> @@ -30,7 +30,6 @@ Currently the U-Boot port supports the following device=
s:
>  U-Boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make libretech-cc_defconfig
>   > make
> diff --git a/board/amlogic/p212/README.p212 b/board/amlogic/p212/README.p=
212
> index ef5370c763c4..3776f2449391 100644
> --- a/board/amlogic/p212/README.p212
> +++ b/board/amlogic/p212/README.p212
> @@ -31,7 +31,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make p212_defconfig
>   > make
> diff --git a/board/amlogic/q200/README.khadas-vim2 b/board/amlogic/q200/R=
EADME.khadas-vim2
> index 8bcfc296f3e0..595998c4fabb 100644
> --- a/board/amlogic/q200/README.khadas-vim2
> +++ b/board/amlogic/q200/README.khadas-vim2
> @@ -31,7 +31,6 @@ Currently the u-boot port supports the following device=
s:
>  U-Boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make khadas-vim2_defconfig
>   > make
> diff --git a/board/amlogic/q200/README.q200 b/board/amlogic/q200/README.q=
200
> index 55d730a0d200..d4142c88bd42 100644
> --- a/board/amlogic/q200/README.q200
> +++ b/board/amlogic/q200/README.q200
> @@ -30,7 +30,6 @@ Currently the u-boot port supports the following device=
s:
>  U-Boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make khadas-vim2_defconfig
>   > make
> diff --git a/board/amlogic/s400/README b/board/amlogic/s400/README
> index ab21998dc836..a48db22a4282 100644
> --- a/board/amlogic/s400/README
> +++ b/board/amlogic/s400/README
> @@ -31,7 +31,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make s400_defconfig
>   > make
> diff --git a/board/amlogic/sei510/README b/board/amlogic/sei510/README
> index e47ebc7b3a5a..d9358aa50183 100644
> --- a/board/amlogic/sei510/README
> +++ b/board/amlogic/sei510/README
> @@ -22,7 +22,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make sei510_defconfig
>   > make
> diff --git a/board/amlogic/sei610/README b/board/amlogic/sei610/README
> index 1cc2b3c2a4e9..d96a94b5e970 100644
> --- a/board/amlogic/sei610/README
> +++ b/board/amlogic/sei610/README
> @@ -18,7 +18,6 @@ specifications:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make sei610_defconfig
>   > make
> diff --git a/board/amlogic/u200/README b/board/amlogic/u200/README
> index bffac5e7ae0a..a4080eb299c4 100644
> --- a/board/amlogic/u200/README
> +++ b/board/amlogic/u200/README
> @@ -27,7 +27,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make u200_defconfig
>   > make
> diff --git a/board/amlogic/w400/README.khadas-vim3 b/board/amlogic/w400/R=
EADME.khadas-vim3
> index 45ef90c1b0a9..399bf49295f6 100644
> --- a/board/amlogic/w400/README.khadas-vim3
> +++ b/board/amlogic/w400/README.khadas-vim3
> @@ -29,7 +29,6 @@ Currently the U-Boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make khadas-vim3_defconfig
>   > make
> diff --git a/board/amlogic/w400/README.khadas-vim3l b/board/amlogic/w400/=
README.khadas-vim3l
> index 0afff16c0c26..b2d9abbfd9b2 100644
> --- a/board/amlogic/w400/README.khadas-vim3l
> +++ b/board/amlogic/w400/README.khadas-vim3l
> @@ -29,7 +29,6 @@ Currently the U-Boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make khadas-vim3l_defconfig
>   > make
> diff --git a/board/amlogic/w400/README.odroid-n2 b/board/amlogic/w400/REA=
DME.odroid-n2
> index a8f2c3d7daa6..8142eebea007 100644
> --- a/board/amlogic/w400/README.odroid-n2
> +++ b/board/amlogic/w400/README.odroid-n2
> @@ -28,7 +28,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make odroid-n2_defconfig
>   > make
> diff --git a/board/amlogic/w400/README.w400 b/board/amlogic/w400/README.w=
400
> index 25b786d817c4..c129717a1189 100644
> --- a/board/amlogic/w400/README.w400
> +++ b/board/amlogic/w400/README.w400
> @@ -27,7 +27,6 @@ Currently the u-boot port supports the following device=
s:
>  u-boot compilation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - > export ARCH=3Darm
>   > export CROSS_COMPILE=3Daarch64-none-elf-
>   > make w400_defconfig
>   > make
>=20

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
