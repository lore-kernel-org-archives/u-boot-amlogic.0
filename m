Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
 by mx.groups.io with SMTP id smtpd.web12.9942.1581269127799923382
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 09:25:27 -0800
Received: by mail-io1-f67.google.com with SMTP id m25so4979593ioo.8
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 09:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dy8HxLe3XQWkhS3yI+C+r2XrLyHf1yasuWXTrswYIH4=;
        b=s2VUKbTsKFVL+3N9K3Tn3nNk/0Bm7LomWQWIZ4Db3j2dwGR9ZR+E6hI4V3+3j03C9A
         l6fQqU6rMcitaMcHOmoVVymR8tEW5Dbn5cx6lYB+qgGD9P7i4QH1qABBIfVjiXiZgsa5
         l+2X8zYE6srCzkD1Kd+ymfF7Vpd6Z9Cs9qehK235dQwL1aPq73H7FSGw3oHsIu7c7IkC
         6YabpYryRmuraZq51Ezm1pPVA59CPYjjHotdO54zO3lzseg1SirSg9O9Do8166TkBAI/
         5COXVO8QSO0TS+LUfkB9tjnIPr01QHUd/Svm7qVih/pBJf6N3QFExzdSmqX1flkNPts9
         SP0A==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-5-linux.amoon@gmail.com>
 <9056c007-eb79-d031-ac41-02d8f6ef09f2@baylibre.com>
In-Reply-To: <9056c007-eb79-d031-ac41-02d8f6ef09f2@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2020 22:55:18 +0530
Message-ID: <CANAwSgSJohN8Pg7yTssk4X4DzP_36+EpYonYXX-nNaN8cU3qHQ@mail.gmail.com>
Subject: Re: [PATCHv6 4/5] arm: dts: g12: Move common nodes to the -u-boot.dtsi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

Thanks for your review comments.

On Sun, 9 Feb 2020 at 18:28, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
> Hi,
>
> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> > Move u-boot specific common nodes in the dts files to
> > meson-g12-common-u-boot.dtsi. This allows us to keep the basic
> > dts[i] files up-to-date with the ones in kernel,
> > but at the same time allowing the u-boot to add its own
> > properties to the existing nodes.
> > Also add missing mmc alias to dts nodes to avoid
> > below debug warning.
> >
> > mmc_bind: alias ret=3D-2, devnum=3D-1
> > mmc_bind: alias ret=3D-2, devnum=3D-1
>
> Same as patch 4.
>
> Neil
>

$ git grep meson-g12-common-u-boot.dtsi
arch/arm/dts/meson-g12a-sei510-u-boot.dtsi:#include
"meson-g12-common-u-boot.dtsi"
arch/arm/dts/meson-g12a-u200-u-boot.dtsi:#include "meson-g12-common-u-boot.=
dtsi"
arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi:#include
"meson-g12-common-u-boot.dtsi"
arch/arm/dts/meson-sm1-sei610-u-boot.dtsi:#include
"meson-g12-common-u-boot.dtsi"

So all the common nodes is included in *meson-g12-common-u-boot.dtsi*
for G12 dts.

-Anand

> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > No changes from previous patch
> > ---
> >  arch/arm/dts/meson-g12-common-u-boot.dtsi | 12 ++++++++++++
> >  arch/arm/dts/meson-g12a-sei510.dts        |  9 ---------
> >  arch/arm/dts/meson-g12a-u200.dts          |  9 ---------
> >  arch/arm/dts/meson-g12b-odroid-n2.dts     |  9 ---------
> >  arch/arm/dts/meson-khadas-vim3.dtsi       |  9 ---------
> >  arch/arm/dts/meson-sm1-sei610.dts         |  9 ---------
> >  6 files changed, 12 insertions(+), 45 deletions(-)
> >
> > diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/m=
eson-g12-common-u-boot.dtsi
> > index 38fd3d3feb..347b8ded22 100644
> > --- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
> > +++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
> > @@ -8,6 +8,18 @@
> >       soc {
> >               u-boot,dm-pre-reloc;
> >       };
> > +
> > +     aliases {
> > +             serial0 =3D &uart_AO;
> > +             ethernet0 =3D &ethmac;
> > +             mmc0 =3D &sd_emmc_a;
> > +             mmc1 =3D &sd_emmc_b;
> > +             mmc2 =3D &sd_emmc_c;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> >  };
> >
> >  &canvas {
> > diff --git a/arch/arm/dts/meson-g12a-sei510.dts b/arch/arm/dts/meson-g1=
2a-sei510.dts
> > index c7a8736885..c6a48ebbe5 100644
> > --- a/arch/arm/dts/meson-g12a-sei510.dts
> > +++ b/arch/arm/dts/meson-g12a-sei510.dts
> > @@ -28,11 +28,6 @@
> >               };
> >       };
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> >       mono_dac: audio-codec-0 {
> >               compatible =3D "maxim,max98357a";
> >               #sound-dai-cells =3D <0>;
> > @@ -49,10 +44,6 @@
> >               sound-name-prefix =3D "MIC";
> >       };
> >
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       cvbs-connector {
> >               compatible =3D "composite-video-connector";
> >
> > diff --git a/arch/arm/dts/meson-g12a-u200.dts b/arch/arm/dts/meson-g12a=
-u200.dts
> > index 8551fbd4a4..8be7b6985b 100644
> > --- a/arch/arm/dts/meson-g12a-u200.dts
> > +++ b/arch/arm/dts/meson-g12a-u200.dts
> > @@ -13,15 +13,6 @@
> >       compatible =3D "amlogic,u200", "amlogic,g12a";
> >       model =3D "Amlogic Meson G12A U200 Development Board";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       cvbs-connector {
> >               compatible =3D "composite-video-connector";
> >
> > diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson=
-g12b-odroid-n2.dts
> > index 42f1540575..a37f66a5e0 100644
> > --- a/arch/arm/dts/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
> > @@ -15,15 +15,6 @@
> >       compatible =3D "hardkernel,odroid-n2", "amlogic,g12b";
> >       model =3D "Hardkernel ODROID-N2";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       memory@0 {
> >               device_type =3D "memory";
> >               reg =3D <0x0 0x0 0x0 0x40000000>;
> > diff --git a/arch/arm/dts/meson-khadas-vim3.dtsi b/arch/arm/dts/meson-k=
hadas-vim3.dtsi
> > index 8647da7d66..c6b0ce9a88 100644
> > --- a/arch/arm/dts/meson-khadas-vim3.dtsi
> > +++ b/arch/arm/dts/meson-khadas-vim3.dtsi
> > @@ -11,15 +11,6 @@
> >  / {
> >       model =3D "Khadas VIM3";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       memory@0 {
> >               device_type =3D "memory";
> >               reg =3D <0x0 0x0 0x0 0x80000000>;
> > diff --git a/arch/arm/dts/meson-sm1-sei610.dts b/arch/arm/dts/meson-sm1=
-sei610.dts
> > index 3435aaa4e8..4372708811 100644
> > --- a/arch/arm/dts/meson-sm1-sei610.dts
> > +++ b/arch/arm/dts/meson-sm1-sei610.dts
> > @@ -14,15 +14,6 @@
> >       compatible =3D "seirobotics,sei610", "amlogic,sm1";
> >       model =3D "SEI Robotics SEI610";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       emmc_pwrseq: emmc-pwrseq {
> >               compatible =3D "mmc-pwrseq-emmc";
> >               reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> >
