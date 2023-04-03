Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.64929.1680509441986837352
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Apr 2023 01:10:42 -0700
Received: by mail-wm1-f48.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so18866199wmq.2
        for <u-boot-amlogic@groups.io>; Mon, 03 Apr 2023 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680509440; x=1683101440;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4YTLsvZXuKPI+bQLaGf8VHiSKW8VyFtQuobtXNVM98=;
        b=Vnrt282OBYDpYJHLFn0e99ZSW162hVi5JTKNZTnVkpwPnojkxj8tL5mLlD95lZAvox
         9yKq/Ax1WpE5OoS5MVz+VT83JnMQXoFAhhLTkSoAR1x0g284kyYn0rvAQ6idBU+16raR
         0pbKSasjKxF9rlzTzMNYavrN0EgvTMn6vVjsEazBm1JswHXbz+PrxGaXCw++6dRCIcAp
         GqEViDg3/FwudEwo8Np1EtAYLVGCzsAZXBQzB17g88+2+BJBTICkjmJD/8b8s8eciPkr
         b8odH7AlTV9kHzfmueyoGB508kQFZqCQKTQ4yiApL0WjEOawmz5j9o0Zg4AwGsa+yNtn
         DEqg==
Return-Path: <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce the image
From: "Christian Hewitt" <christianshewitt@gmail.com>
In-Reply-To: <CAPnjgZ0Js43JOi3xaeY8tYuELSPXWL-PCBq1-iANLs1074MzbQ@mail.gmail.com>
Date: Mon, 3 Apr 2023 12:10:36 +0400
Message-Id: <1973D65D-692D-4AA7-B074-942D4E9ADB4B@gmail.com>
References: <20230401185458.2280200-1-sjg@chromium.org>
 <87zg7rb8dd.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ0Js43JOi3xaeY8tYuELSPXWL-PCBq1-iANLs1074MzbQ@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, AML <linux-amlogic@lists.infradead.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

> On 2 Apr 2023, at 6:41 am, Simon Glass <sjg@chromium.org> wrote:
>=20
> Hi Mark,
>=20
> On Sun, 2 Apr 2023 at 09:28, Mark Kettenis <mark.kettenis@xs4all.nl> wrot=
e:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Sun,  2 Apr 2023 06:54:57 +1200
> > >
> > > The Odroid-C2 is quite a complicated image with many steps. It is an =
ideal
> > > example for how Binman can be used.
> >
> > You say Odroid-C2, but the patches seem to address the Odroid-C4...
>=20
> Ah, yes. The difference seems to be an Amlogic S905 on the C2 and an S902=
X3 on the C4. I wonder if that affects the image makeup?

There are currently four different signing recipes that depend on the
board family that you are building for:

- GXBB
- GXL/GXM
- G12A/SM1
- G12B

The G12A/SM1 and G12B recipes are identical except for a different
signing binary used. The latest Amlogic boards (S905X4, T7, etc.)
also have incremental changes, but none are currently supported in
Linux or u-boot.

One of the challenges for binman will be the signing tools. Currently
this patchset depends upon Amlogic binaries. Apart from them being
closed-source and thus undesirable, they are also x86_64 only and
there are quite a few users (and at least one major distro) needing
to build on arm64 hardware.

There is an open-source tool called gxlimg which supports GXL and newer
boards. IMHO it would make a lot of sense for u-boot to absorb the
functionality of gxlimg (and extend support backwards to GXBB) as this
would remove the dependency on Amlogic binaries and allow u-boot build
and binman signing to be done anywhere.

https://github.com/repk/gxlimg

> The patch is for testing by Christian, who I hope can help get this lande=
d for all the Amlogic boards.

I will try to find the time to test this, but it=E2=80=99s not something I
could do more with (as only supporting 1/4 of the board families
that I need to build for, bu I do appreciate it=E2=80=99s a POC).

In case you=E2=80=99re not aware, Makefile based signing is implemented in
the amlogic-boot-fip repo that I=E2=80=99m currently tooled around:

https://github.com/LibreELEC/amlogic-boot-fip=20

This is the =E2=80=9Ccompetition=E2=80=9D so to speak. It=E2=80=99s quite s=
imple and widely
used by most of the Amlogic supporting distros right now.

Christian

> >
> > > Add a binman description and update the instructions accordingly.
> > >
> > > Changes in v2:
> > > - Rebase to -next
> > >
> > > Simon Glass (1):
> > >   RFC: Move Odroid-C2 to use binman to produce the image
> > >
> > >  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 107 ++++++++++++++++
> > >  arch/arm/mach-meson/Kconfig                  |   1 +
> > >  doc/board/amlogic/odroid-c4.rst              | 127 +++++------------=
--
> > >  tools/binman/etype/aml_encrypt.py            | 124 +++++++++++++++++=
+
> > >  tools/binman/ftest.py                        |   3 +
> > >  tools/binman/missing-blob-help               |   6 +
> > >  tools/binman/test/213_aml_encrypt.dts        |  38 ++++++
> > >  tools/binman/test/214_list_no_dtb.dts        |  23 ++++
> > >  8 files changed, 337 insertions(+), 92 deletions(-)
> > >  create mode 100644 tools/binman/etype/aml_encrypt.py
> > >  create mode 100644 tools/binman/test/213_aml_encrypt.dts
> > >  create mode 100644 tools/binman/test/214_list_no_dtb.dts
> > >
>=20
> Regards,
> SImon

