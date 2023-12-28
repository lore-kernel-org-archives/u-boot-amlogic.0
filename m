Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC2C47258
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web10.123277.1703772198161332673
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 06:03:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m8q5X7RI;
 spf=pass (domain: konsulko.com, ip: 209.85.128.181, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e266e8d39eso52196697b3.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703772197; x=1704376997; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy2OJGLQtp+A18eN3S211Lj0BausteOE9g4bZBrchOY=;
        b=m8q5X7RIuyH8dOw3dXG39zXeKRq54UQtddI6HZtsBl2PZFLep1Ha24NeEvb3cbEGu2
         vnZffOfhMee/GJlBs5JqAIzbWJWs2Cz4uK1QMcwc6GIbPMwPqD0ric1DFGbOZnH90AHJ
         eaiozqBDac6ETlT13mCmk+ZD00kdWtuNJIQ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772197; x=1704376997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy2OJGLQtp+A18eN3S211Lj0BausteOE9g4bZBrchOY=;
        b=n5c5x5F8TlohyES9kSmBwBsA9FCN5fIQJGkXqc/OxokwwxjEkHWwYvkoUkxYQmc7hh
         yBZ1wbCtwR2N6DLMedV5d0nu+7jai8v9COZKT8RoM+HVndFI4IRC+6kGxDXWozphnKWC
         KNg8oQHXlNz2/LR5kLczbwaGNEajrzxvrpBOnauea5XTXFHFuKgM6zkzTECofONBFqLK
         lLd1lNaunvbENRgdhf19PFHlUWxbfMXqRsRiCnCgxEfsE8fNmh454GAyVHXsU/lNg3W/
         vdCdRvNoMno8XvLbv8TIwZlBtfZixEd4j4fRv/feCfWgiulIM72VDRiGnIEgYhsiZ08s
         ixfQ==
X-Gm-Message-State: AOJu0YzP7bhkRsba7hjlbi7bxoL2KXrSnPUMAXuYd7556MkR/1NfcFks
	RceEwwuwxS3b7yx3G2FfOHD2c49rNo82lg==
X-Google-Smtp-Source: AGHT+IFMfXNrU0Duv74ybafmJpndQ7l4D7di3ydQ5oc+x0wVeR5/vizK1gdBNCC0TxgxrfdjEYLN5w==
X-Received: by 2002:a81:8a42:0:b0:5e8:dcdd:973e with SMTP id a63-20020a818a42000000b005e8dcdd973emr6916929ywg.39.1703772197166;
        Thu, 28 Dec 2023 06:03:17 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id et18-20020a05690c2e1200b005e9276a4cdcsm7456587ywb.7.2023.12.28.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 06:03:16 -0800 (PST)
Date: Thu, 28 Dec 2023 09:03:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Message-ID: <20231228140313.GB2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=Vj3TK0DyEy62d987A49Y"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2000

--Groupsio=Vj3TK0DyEy62d987A49Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> Hi Sumit,
>=20
> On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Allow platform owners to mirror devicetree files from devitree-rebasing
> > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dt=
s
> > directory. Also add a new Makefile for arm64.
> >
> > This will help easy migration for platforms which currently are complia=
nt
> > with upstream Linux kernel devicetree files.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v3:
> > --------------
> > - Minor commit message update
> >
> > Changes in v2:
> > --------------
> > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> >
> >  dts/Kconfig             | 11 +++++++++++
> >  dts/Makefile            | 17 ++++++++++++++---
> >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> >  3 files changed, 39 insertions(+), 3 deletions(-)
> >  create mode 100644 dts/arch/arm64/Makefile
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 00c0aeff893..e58c1c6f2ab 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -85,6 +85,17 @@ config OF_LIVE
> >           enables a live tree which is available after relocation,
> >           and can be adjusted as needed.
> >
> > +config OF_UPSTREAM
> > +       bool "Enable use of devicetree imported from Linux kernel relea=
se"
> > +       help
> > +         Traditionally, U-Boot platforms used to have their custom dev=
icetree
> > +         files or copy devicetree files from Linux kernel which are ha=
rd to
> > +         maintain and can usually get out-of-sync from Linux kernel. T=
his
> > +         option enables platforms to migrate to devicetree-rebasing re=
po where
> > +         a regular sync will be maintained every major Linux kernel re=
lease
> > +         cycle. However, platforms can still have some custom u-boot s=
pecific
> > +         bits maintained as part of *-u-boot.dtsi files.
>=20
> My only other suggestion here is to mention that this should be set in
> Kconfig, for the SoC as a whole. So I believe that means that it
> should be hidden, with no string for the 'bool':
>=20
>       bool  # Enable use of devicetree imported from Linux kernel release

I think we can just keep prompting for it now, to make the transition
easier, before this option just goes away in time, hopefully.

> Also, this doesn't seem to work for me. Before this series I get these
> files when building firefly-rk3399:
>=20
> rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> rk3399-evb.dtb                  rk3399-leez-p710.dtb
> rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> rk3399-rock-4c-plus.dtb
> rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock-4se=
.dtb
> rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock960.=
dtb
>=20
> Afterwards I get this:
>=20
> make[3]: *** No rule to make target
> 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
>=20
> So I set this manually for that one board:
>=20
> CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
>=20
> and get:
>=20
> make[3]: *** No rule to make target
> 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
>=20
> I am not sure how to fix this, nor how this can be made to build all
> the DTs for rk3399, as it does today.

Looking at the patch for amlogic boards, you need to make the link to
devicetree-rebasing inside dts/...

> > diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> > new file mode 100644
> > index 00000000000..16e9fea622d
> > --- /dev/null
> > +++ b/dts/arch/arm64/Makefile
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +include $(srctree)/scripts/Makefile.dts
> > +
> > +targets +=3D $(dtb-y)
> > +
> > +# Add any required device tree compiler flags here
> > +DTC_FLAGS +=3D -a 0x8
> > +
> > +PHONY +=3D dtbs
> > +dtbs: $(addprefix $(obj)/, $(dtb-y))
> > +       @:
> > +
> > +clean-files :=3D */*.dtb */*.dtbo */*_HS
>=20
> What is _HS for?

Should we even need the clean-files part here? I think this is fixed
with:
https://patchwork.ozlabs.org/project/uboot/patch/20231226154619.5071-9-maxi=
m.uvarov@linaro.org/

--=20
Tom

--Groupsio=Vj3TK0DyEy62d987A49Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNgCEACgkQFHw5/5Y0
tyzp+gv/XfEU2yysR4a2Tjfoa5Qw6wODpyqezTXZAvIOIGkcDVizZjuSHwrSYa6y
/1REvKlhvnRj341r174g4EEkTvj0mZ+YuROHpBLz43yp0Tau0acpBvGAuFDZpmxn
cBr5MojseoIyz24jKpE/lqM5hX/TIRAZuUQx4UUrmgL9jRv+Zbi+h8OhYTLbKhyL
LNOEfkLQSnhU9KdipjZcl0CnAo5N7IVwpN4eZyrYmrOZGP7ajN6Ra5QJIlfewici
RXn1KX5fws296kSsIVboeHwCY8I0DlSKM7Em/LvYoK2bYZfYG4Wes01jJOmSIJlb
ct7uU5uDmB4KkVtisJio/avDTclpNzF5iOZjApFCP47e3k9gV8RvmExPPJCQCORq
Q0Yatvc1Jq+oniMtLhefhCKjEQ2o7q0EcKurwoGASS1nK2o8uaD5EyETnLJPfEsH
UitMd8QAg1Vt9U6F/8OsWk60VC3pQM7+QvFH/CQ54vrTWz2oQF4hKSL0KBDVnN+/
Auis/xgb
=HIFb
-----END PGP SIGNATURE-----

--Groupsio=Vj3TK0DyEy62d987A49Y--

