Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
 by mx.groups.io with SMTP id smtpd.web11.9819.1581269143516147251
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 09:25:43 -0800
Received: by mail-io1-f68.google.com with SMTP id z8so5029875ioh.0
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7uxMGSR0nZUR0GXMqDc/CVwYkNmn2jcxf/SNBkBOtT4=;
        b=TZ10Ls9/VfUUS21lxiAsHUG6Z/vTnV8qEIhBJ3lohagxvSImx/tkmfCR6y2IXXGXgD
         2Sb++L/PKGaYH9bJOa8Ey+wgsz23UIc9rYk18vUDHIqKgHcNekrkN+cM3VLGwGraCkEj
         jQMA2K3ekHBOAQcd9uVhknPKdh4ld0ELPLbDedMN6ycA1U01XbVGEBtSLdtGyIvLR4Rt
         c/MWQjWIBkr8ugCvC4mcKAPPKE+WF5ZMQU4x9jfFJ3ivCBlq1q11xHegpocqlCbH+xXq
         bTej+Ba6KBbdfN2DQnmMklYNeX+g9jNDe/7NVAkgZJ1x25v3Kk28n4BOGAZJxYrEiEIS
         /5sw==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-4-linux.amoon@gmail.com>
 <3a8d18d5-f253-8a15-9e5c-34f31bec6925@baylibre.com>
In-Reply-To: <3a8d18d5-f253-8a15-9e5c-34f31bec6925@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2020 22:55:34 +0530
Message-ID: <CANAwSgSx3mSub7=KFoCC8-VVMg2drjFdCBDmhP8p9ccR+S_Ymw@mail.gmail.com>
Subject: Re: [PATCHv6 3/5] arm: dts: gx: Move common nodes to the -u-boot.dtsi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

Thanks for your review.

On Sun, 9 Feb 2020 at 18:28, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
> Hi,
>
> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> > Move u-boot specific common nodes in the dts files to
> > meson-gx-u-boot.dtsi. This allows us to keep the basic
> > dts[i] files up-to-date with the ones in kernel,
> > but at the same time allowing the u-boot to add its own
> > properties to the existing nodes.
> > Also add missing mmc alias to dts nodes to avoid
> > below debug warning.
> >
> > mmc_bind: alias ret=3D-2, devnum=3D-1
> > mmc_bind: alias ret=3D-2, devnum=3D-1
>
> The mmc aliases are u-boot specific, so only those should be
> moved into the meson-gx-u-boot.dtsi.
>
> Please keep the other aliases in the their linux sync'ed files.
>
> Neil
>

meson-gx-u-boot.dtsi is included in following dts file so
their is no another common -u-boot.dtsi for all the SBC dts.

$ git grep meson-gx-u-boot.dtsi
arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi:#include "meson-gx-u-boot.dts=
i"
arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi:#include "meson-gx-u-boot.dtsi=
"
arch/arm/dts/meson-gxbb-p200-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
arch/arm/dts/meson-gxbb-p201-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi:#include
"meson-gx-u-boot.dtsi"
arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi:#include
"meson-gx-u-boot.dtsi"
arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi:#include "meson-gx-u-boot.dts=
i"
arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi:#include "meson-gx-u-boot.dt=
si"

So all the common nodes is included in *meson-gx-u-boot.dtsi* for GXBB
and GXL dts.



-Anand

> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > no changes from previous
> > ---
> >  arch/arm/dts/meson-gx-u-boot.dtsi             | 15 +++++++++++++++
> >  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  9 ---------
> >  arch/arm/dts/meson-gxbb-odroidc2.dts          |  9 ---------
> >  arch/arm/dts/meson-gxbb-p20x.dtsi             |  9 ---------
> >  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ----------
> >  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 -----
> >  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---------
> >  arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ----------
> >  arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ----------
> >  9 files changed, 15 insertions(+), 71 deletions(-)
> >
> > diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-=
u-boot.dtsi
> > index b84e5edba4..13be3a7b8f 100644
> > --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> > +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> > @@ -8,6 +8,21 @@
> >       soc {
> >               u-boot,dm-pre-reloc;
> >       };
> > +
> > +     aliases {
> > +             serial0 =3D &uart_AO;
> > +             serial1 =3D &uart_A;
> > +             serial2 =3D &uart_AO_B;
> > +             ethernet0 =3D &ethmac;
> > +             spi0 =3D &spifc;
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
> >  &vpu {
> > diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson=
-gxbb-nanopi-k2.dts
> > index cbe99bd4e0..11690d6c46 100644
> > --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> > +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> > @@ -11,15 +11,6 @@
> >  / {
> >       compatible =3D "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
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
> > diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-=
gxbb-odroidc2.dts
> > index 54954b314a..f8cd76a2ef 100644
> > --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
> > @@ -14,15 +14,6 @@
> >       compatible =3D "hardkernel,odroid-c2", "amlogic,meson-gxbb";
> >       model =3D "Hardkernel ODROID-C2";
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
> > diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxb=
b-p20x.dtsi
> > index 0be0f2a5d2..c9822e50f9 100644
> > --- a/arch/arm/dts/meson-gxbb-p20x.dtsi
> > +++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
> > @@ -8,15 +8,6 @@
> >  #include "meson-gxbb.dtsi"
> >
> >  / {
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
> > diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/d=
ts/meson-gxl-s805x-libretech-ac.dts
> > index 82b1c48511..4f9072a83e 100644
> > --- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> > +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
> > @@ -16,16 +16,6 @@
> >                    "amlogic,meson-gxl";
> >       model =3D "Libre Computer Board AML-S805X-AC";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             ethernet0 =3D &ethmac;
> > -             spi0 =3D &spifc;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       cvbs-connector {
> >               /*
> >                * The pads are present but no connector is soldered on
> > diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts=
/meson-gxl-s905x-khadas-vim.dts
> > index ceb34afe42..072e4575d2 100644
> > --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> > +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
> > @@ -26,11 +26,6 @@
> >               };
> >       };
> >
> > -     aliases {
> > -             serial2 =3D &uart_AO_B;
> > -             ethernet0 =3D &ethmac;
> > -     };
> > -
> >       gpio-keys-polled {
> >               compatible =3D "gpio-keys-polled";
> >               #address-cells =3D <1>;
> > diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/d=
ts/meson-gxl-s905x-libretech-cc.dts
> > index a23252efc6..8d3965ab42 100644
> > --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> > +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
> > @@ -15,15 +15,6 @@
> >       compatible =3D "libretech,cc", "amlogic,s905x", "amlogic,meson-gx=
l";
> >       model =3D "Libre Computer Board AML-S905X-CC";
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
> > diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meso=
n-gxl-s905x-p212.dtsi
> > index a1b31013ab..70f437fc3a 100644
> > --- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
> > +++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
> > @@ -13,16 +13,6 @@
> >  #include "meson-gxl-s905x.dtsi"
> >
> >  / {
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             serial1 =3D &uart_A;
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
> > diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meso=
n-gxm-khadas-vim2.dts
> > index 782e9edac8..4e68e289d3 100644
> > --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
> > +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> > @@ -16,16 +16,6 @@
> >       compatible =3D "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm"=
;
> >       model =3D "Khadas VIM2";
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             serial1 =3D &uart_A;
> > -             serial2 =3D &uart_AO_B;
> > -     };
> > -
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       memory@0 {
> >               device_type =3D "memory";
> >               reg =3D <0x0 0x0 0x0 0x80000000>;
> >
