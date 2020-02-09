Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
 by mx.groups.io with SMTP id smtpd.web09.9783.1581269089617377684
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 09:24:49 -0800
Received: by mail-il1-f195.google.com with SMTP id s18so3802251iln.0
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2Hkfqai3IgF+Wx0vZdGvW7N0AAZSjjGHUbLQ5SFuF8=;
        b=AVkCCk/X2MdKWzXZI92ow6kZrFHRfEVSBRTTRoUUols3a7c4iiSQLfZ/iENwH91Nje
         V27OsfmrhbxkzyOoLryTT5CLU2pusB0OwQmTC4tHz/cfkp5S0HBH8suPRH2CwbEV0XCs
         NUEOEVCm5If4sFewqvsoSfEtk7De5BtAalqNZSik1W51QW9wKp48cRlsp/+b4B3bB8eN
         VAD0Ti+9Z/VXkCuZ9UZAkSLt9UO6YAdcDJYNfFXhxjkzLVSO8/khhK+azraRtHToqpF6
         ehZ6fzjjNcOfyrIxRbv7PAkIFSts4faKQ1KniGsFZ39YMqLoigxqlJ+QvT4GUamqykZx
         BHnA==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-6-linux.amoon@gmail.com>
 <b5b4e697-34e7-d99c-5196-179c0ae83fc8@baylibre.com>
In-Reply-To: <b5b4e697-34e7-d99c-5196-179c0ae83fc8@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2020 22:54:40 +0530
Message-ID: <CANAwSgQza4D0N672zTS5kPOa9Y73WQsP7GKs1S8TXD=zjtfJ-A@mail.gmail.com>
Subject: Re: [PATCHv6 5/5] arm: dts: s400: Move common nodes to the -u-boot.dtsi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

hi Neil,

Thanks for your review comments.

On Sun, 9 Feb 2020 at 18:29, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
> Hi,
>
> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> > Move u-boot specific common nodes in the dts files to
> > meson-axg-s400-u-boot.dtsi. This allows us to keep the basic
> > dts[i] files up-to-date with the ones in kernel,
> > but at the same time allowing the u-boot to add its own
> > properties to the existing nodes.
> > Also add missing mmc alias to dts nodes to avoid
> > below debug warning.
> >
> > mmc_bind: alias ret=3D-2, devnum=3D-1
> > mmc_bind: alias ret=3D-2, devnum=3D-1
>
>
> Same as patch 4.
>
> Neil
>

$ git grep meson-axg-s400-u-boot.dtsi
it not show any thing, looks like it's not getting included.
so  I will update this in next version.

-Anand
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > no changes from previous changes
> > ---
> >  arch/arm/dts/meson-axg-s400-u-boot.dtsi | 16 ++++++++++++++++
> >  arch/arm/dts/meson-axg-s400.dts         |  9 ---------
> >  2 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/dts/meson-axg-s400-u-boot.dtsi b/arch/arm/dts/mes=
on-axg-s400-u-boot.dtsi
> > index c46eb3f38d..74241e9fcd 100644
> > --- a/arch/arm/dts/meson-axg-s400-u-boot.dtsi
> > +++ b/arch/arm/dts/meson-axg-s400-u-boot.dtsi
> > @@ -2,6 +2,22 @@
> >  /*
> >   * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
> >   */
> > +/ {
> > +     soc {
> > +             u-boot,dm-pre-reloc;
> > +     };
> > +
> > +     aliases {
> > +             serial0 =3D &uart_AO;
> > +             serial1 =3D &uart_A;
> > +             mmc1 =3D &sd_emmc_b;
> > +             mmc2 =3D &sd_emmc_c;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +};
> >
> >  /* wifi module */
> >  &sd_emmc_b {
> > diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s=
400.dts
> > index 18778ada7b..feb84255ad 100644
> > --- a/arch/arm/dts/meson-axg-s400.dts
> > +++ b/arch/arm/dts/meson-axg-s400.dts
> > @@ -55,11 +55,6 @@
> >               };
> >       };
> >
> > -     aliases {
> > -             serial0 =3D &uart_AO;
> > -             serial1 =3D &uart_A;
> > -     };
> > -
> >       linein: audio-codec@0 {
> >               #sound-dai-cells =3D <0>;
> >               compatible =3D "everest,es7241";
> > @@ -100,10 +95,6 @@
> >               reset-gpios =3D <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> >       };
> >
> > -     chosen {
> > -             stdout-path =3D "serial0:115200n8";
> > -     };
> > -
> >       memory@0 {
> >               device_type =3D "memory";
> >               reg =3D <0x0 0x0 0x0 0x40000000>;
> >
