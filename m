Received: by mail-wm1-f67.google.com with SMTP id 4so4341961wmf.1
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=9QJ38LdEud+NfrHdqS2ZFHUPsVh9TYSd7ouqTYEGa60=;
        b=nsYXQ74+kbFSzKVQS22EmHKWim0vV23pUqD7UJgVykCE74ofRR2hwR9/ARf0MhpUin
         tFt1lq/WLF6Bi1UJhIhR7ibmsW5XhyQnhLM5KdHDHoNd82+vWWT/Ow7dSAdf3Cg9xavs
         2PgwblgG6HkHzoAVHECI3qWGJNyYks1KY11Zs+5RSxqotRemboTCi3i5atpEOD5OlvIC
         ddbJvKbvOIWssZcVtykkPHLFGhTsd2jM4sFWELvFmxpLZSGll+mTIUzZB2+ckwC/3hlF
         Ql4d16NapzYoIp74RoGOF9E1y/xcoXTeni0IwYA9i/8WC5s1vVMa4f+l5rWwZ/uGC9Zj
         qU/g==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C96063D.3060204@baylibre.com>
Date: Sat, 23 Mar 2019 11:11:09 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] Arm: meson: add support for p200 and p201 boards
References: <20190315151109.17317-1-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151109.17317-1-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 15/03/2019 16:11, Mohammad Rasim a =E9crit :
>=20
> This adds support for p200 and p201 reference boards from amlogic
>=20
> Mohammad Rasim (5):
>   ARM: board: meson: rename odroid-c2 to p200
>   ARM: dts: meson: add p200 and p201 boards
>   Arm: dts: meson: add u-boot.dtsi for p200 and p201
>   ARM: board: meson: add p200 board
>   ARM: board: meson: add p201 board
>=20
>  arch/arm/dts/Makefile                         |   2 +
>  arch/arm/dts/meson-gxbb-p200-u-boot.dtsi      |   7 +
>  arch/arm/dts/meson-gxbb-p200.dts              |  99 +++++++
>  arch/arm/dts/meson-gxbb-p201-u-boot.dtsi      |   7 +
>  arch/arm/dts/meson-gxbb-p201.dts              |  26 ++
>  arch/arm/dts/meson-gxbb-p20x.dtsi             | 247 ++++++++++++++++++
>  arch/arm/mach-meson/Kconfig                   |   2 +-
>  board/amlogic/{odroid-c2 =3D> p200}/MAINTAINERS |   6 +-
>  board/amlogic/{odroid-c2 =3D> p200}/Makefile    |   2 +-
>  .../{odroid-c2 =3D> p200}/README.nanopi-k2      |   0
>  .../{odroid-c2 =3D> p200}/README.odroid-c2      |   0
>  board/amlogic/p200/README.p200                | 103 ++++++++
>  .../{odroid-c2/odroid-c2.c =3D> p200/p200.c}    |   0
>  board/amlogic/p201/MAINTAINERS                |   5 +
>  board/amlogic/p201/Makefile                   |   5 +
>  board/amlogic/p201/README.p201                | 103 ++++++++
>  board/amlogic/p201/p201.c                     |  43 +++
>  configs/nanopi-k2_defconfig                   |   1 +
>  configs/odroid-c2_defconfig                   |   1 +
>  configs/p200_defconfig                        |  41 +++
>  configs/p201_defconfig                        |  41 +++
>  21 files changed, 736 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>  rename board/amlogic/{odroid-c2 =3D> p200}/MAINTAINERS (70%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/Makefile (82%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/README.nanopi-k2 (100%)
>  rename board/amlogic/{odroid-c2 =3D> p200}/README.odroid-c2 (100%)
>  create mode 100644 board/amlogic/p200/README.p200
>  rename board/amlogic/{odroid-c2/odroid-c2.c =3D> p200/p200.c} (100%)
>  create mode 100644 board/amlogic/p201/MAINTAINERS
>  create mode 100644 board/amlogic/p201/Makefile
>  create mode 100644 board/amlogic/p201/README.p201
>  create mode 100644 board/amlogic/p201/p201.c
>  create mode 100644 configs/p200_defconfig
>  create mode 100644 configs/p201_defconfig
>=20
> --
> 2.21.0
>=20

With the two small changes and the p200 changes from patch 1 to patch 4, I'=
ll apply this to u-boot-amlogic !

Neil
