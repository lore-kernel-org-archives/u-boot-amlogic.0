Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBCC47258
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web10.124872.1703777109015006511
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 07:25:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=inlRPvKj;
 spf=pass (domain: konsulko.com, ip: 209.85.128.169, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e730eb1770so48456337b3.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703777108; x=1704381908; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5pPQAOFZvjdwYbvIJmTtI3GibSN+hHRfK0LXP8QNxE=;
        b=inlRPvKjILMalAUBzldzRFY05pmloEO0qf8WpeMdXDfK8awebNXlKAum/uAp6L2+jk
         aeKnjaK4uJIVMkJa++T97CpM4LC8RvLBp/onf7Vmt/3jxNlNX+zraXBpejdNqYc4GMec
         7jjEtkVJHiXhegVAlhYrb75Ubiu2m2I6aoCm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703777108; x=1704381908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5pPQAOFZvjdwYbvIJmTtI3GibSN+hHRfK0LXP8QNxE=;
        b=gGq48ZH/RiPJDpIxp2JPieizvHsq1bh9v7fHL+zh1MCuWzDjut+/X2EBe/n/fPBbOg
         5P6o9cb/muqLws7heL8AAtyNhgVzaMvtYh8pj9TkUTM6WNs8PA2y2xPwX+yZuMVJzvIL
         L0DKIVdGrRv0f4dKa8UZnUi3sLSUlXWl5t5KgUtt582AExwEksjKO0m8oNe3FbA9lDQZ
         6UrSlIQgvFjaovfl1qo4PDpdylJ4LvuX8u0p7FMzLm1FYVrgjOPfnr6RrvBJXlBeXo0N
         GjXQFzG0EFOYSX8vLWUl1uk8iEO91UcQV3XVu16Xbw7Ok1u2SePIrQyhkbZob8U9nE+N
         QC9w==
X-Gm-Message-State: AOJu0YwdKjrv1Vibw8Ap5v/9Ra43cb8eps+By9df4LAUcoeuw0VjzHa4
	6wBpkNU1Yw+qsQH7QshBUz6dgeYDT3qclA==
X-Google-Smtp-Source: AGHT+IF6qVORWiEfQSthAdjihIjx2lnsV46lpKAuIwz8bK+VtVq0r7ic5RCm4QJ8Cxev4ivs41TJQg==
X-Received: by 2002:a81:48d4:0:b0:5e9:f02a:5a23 with SMTP id v203-20020a8148d4000000b005e9f02a5a23mr5579752ywa.68.1703777108172;
        Thu, 28 Dec 2023 07:25:08 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id c5-20020a81c945000000b005ea9425db98sm5788251ywl.8.2023.12.28.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 07:25:07 -0800 (PST)
Date: Thu, 28 Dec 2023 10:25:04 -0500
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
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231228152504.GF2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
 <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat>
 <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=ZUpvyIM2GKnDPENYw4R9"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2005

--Groupsio=ZUpvyIM2GKnDPENYw4R9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > Hi Sumit,
> > >
> > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > Although there were still some variations in board DTS files based =
on
> > > > meson-gxbb SoC but I think those were minor differences from upstre=
am
> > > > and shouldn't impact boot on these devices.
> > > >
> > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby direc=
tly
> > > > building DTB from there including *-u-boot.dtsi files from
> > > > arch/$(ARCH)/dts/ directory.
> > > >
> > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > --------------
> > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
> > > >
> > > > Changes in v2:
> > > > --------------
> > > > - Picked up review tag
> > > >
> > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > >  configs/odroid-c2_defconfig           | 2 +-
> > > >  configs/p200_defconfig                | 2 +-
> > > >  configs/p201_defconfig                | 2 +-
> > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > >  configs/wetek-hub_defconfig           | 2 +-
> > > >  configs/wetek-play2_defconfig         | 2 +-
> > > >  dts/arch/arm64/amlogic                | 1 +
> > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > >  create mode 120000 dts/arch/arm64/amlogic
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kcon=
fig
> > > > index d6c89058061..8ddb59161a0 100644
> > > > --- a/arch/arm/mach-meson/Kconfig
> > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > @@ -25,6 +25,7 @@ choice
> > > >  config MESON_GXBB
> > > >         bool "GXBB"
> > > >         select MESON_GX
> > > > +       imply OF_UPSTREAM
> > > >         help
> > > >           Select this if your SoC is an S905
> > > >
> > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defcon=
fig
> > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > --- a/configs/nanopi-k2_defconfig
> > > > +++ b/configs/nanopi-k2_defconfig
> > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > >  CONFIG_ENV_SIZE=3D0x2000
> > > >  CONFIG_DM_GPIO=3Dy
> > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > >  CONFIG_DM_RESET=3Dy
> > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > >
> > > So now I am wondering if we can (later) have the SoC be implied when
> > > using OF_UPSTREAM so we can do:
> > >
> > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > >
> > > and it will add the 'amlogic/' automatically?
> > >
> > > Perhaps that might be a way to bridge the gap in terms of file layout=
?
> >
> > That's going to start to look real ugly real quick I suspect and I'm no=
t
> > sure what it really gets us? It seems to me that the convention of
> > "vendor/board" has already been well enough adapted outside of the
> > kernel, with the odd sticking point being getting everyone used to
> > whatever will be happening for 32bit boards long term. So I think hidin=
g
> > the vendor part of the string here will be more, not less, confusing
> > long term.
>=20
> Now that I dig in a bit, I see that the devicetree-rebasing tree does
> not have any Makefiles in it. How does Linux build with it? Does
> anyone have instructions?

Linux doesn't build with it, it's the relevant parts of the kernel tree
extracted for other projects to more easily use (more or less).

--=20
Tom

--Groupsio=ZUpvyIM2GKnDPENYw4R9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNk0oACgkQFHw5/5Y0
tywn5Qv/aQMBqT8pVUc8tFmt6cT4+DscisoSl+Ncrm9MYzWD3yGcfq4me3VJQbbE
3QK6fmj95e3CgTYCz4slvtSqdqIP/7i+t1/5s2c4IVs82m/u4NTLymBOwOzDkUoE
kQXTtZ9Ayqhe3lT2B6nD1QpyKbHuq86qOo2AyWk2beFh0rQI4GwT+jCp9RBNC6IH
+4Q8RO9wvs3O8SzYKnVhYXzfAMhdoCr46Og14vZq1HdX7z7/0VU4jI/M+275wyHO
T8UR/U1cHypSGz0R3X9Rm5M/YYdXelvathWlEqFCiMzZJcEyTrpU/0KvYFk0s+Gr
WTlLQd6dXIKIV+dbeWtj0bI0Ah02qGJiu2VgJ2fPND+riStZVXYJ4KEVWqX6PrHN
qrbVS9FhDmtjZBgSPDv/MJ491qaMiVWuOQGHadQm5EswBpmF8VoE8yteZ0fbCP/o
JpVQwDYjR6EAw5mytdDjl0LXT7UegmgVUr3Uohp8pvWuf12UIrb/hHvxEzLzoCSy
GLN9eVwo
=Xzm8
-----END PGP SIGNATURE-----

--Groupsio=ZUpvyIM2GKnDPENYw4R9--

