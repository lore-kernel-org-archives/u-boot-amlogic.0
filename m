Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591CC46CCD
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 08:48:18 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web10.21484.1703078947435656929
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 05:29:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=I/PqfstS;
 spf=pass (domain: konsulko.com, ip: 209.85.219.177, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db538b07865so4824330276.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703078946; x=1703683746; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdgBG+r/j6b59w65SjtBlhXZEMjPAa9m3KTDlVkKr1s=;
        b=I/PqfstSVzP8BcR0+eHEEZs5RBfWCzTI4Sa0ygEvpKkiv9BnSFXlFdgaYiRSWMUZP+
         r9PVGAjAOTlCAigBHjePun5mDp8iwT6xbNSEicAX0Oo2tay66nJqpNTBQD11rMnNmvtD
         iwIID1IivgjNRJo0yey0wumvRA8LwXOrVuSG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078946; x=1703683746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdgBG+r/j6b59w65SjtBlhXZEMjPAa9m3KTDlVkKr1s=;
        b=JQRyS7OmJQCwySSFLGXgn2HLFGSfBWl3TcvR33lpBuY+rO9FCXPI7PXkeUAUgdzNJJ
         fLeEKmgOSQ+lKiTgcfMV7uxfNQFWkhtbXov1FzsPfv6P23mqqES+UOaiVe3JO/x9OeZ1
         vpzrF2p0yAZn55G9qQwe/STddHV1vDpstmlTldeTkhMaH7/Oayz83rfPpATWqe7am7ex
         mDI/q4h+yW9AL8DK8yJ1r50CYalU5XtFRBZ1QAdo3Jd9jMBskB7ZAZeccZ1g/Ngx5j5Q
         1OW2EjcVf4qYLVhok7uxFqZ00zucxIqyLxl/6dTAgWedmzL6iX1iWOrD2Kj8EB6ycz8W
         p9AQ==
X-Gm-Message-State: AOJu0YwdCC+y31Eo8/RkC4XT934Ghyw2ELJC+TsTaVVBctxh1ZA2AX8/
	o4s8rJxJZ+yA7CE/tLgwgf/Vag==
X-Google-Smtp-Source: AGHT+IHKZ8nQQlfe4zU5OdrdmifkaaRKBpcwZ1TZrUEFHlJGxvVBMz/1LznueXeWJ/BxNI5Uw7+dhQ==
X-Received: by 2002:a25:1f46:0:b0:dbc:cb56:8a30 with SMTP id f67-20020a251f46000000b00dbccb568a30mr6943196ybf.118.1703078946541;
        Wed, 20 Dec 2023 05:29:06 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com. [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
        by smtp.gmail.com with ESMTPSA id t3-20020a255f03000000b00d9cceda7947sm9294171ybb.3.2023.12.20.05.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:29:06 -0800 (PST)
Date: Wed, 20 Dec 2023 08:29:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
Message-ID: <20231220132903.GL2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org>
 <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
 <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=CgmSatme7twm5iAucbo3"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Dec 2023 08:48:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1961

--Groupsio=CgmSatme7twm5iAucbo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 05:00:20PM +0530, Sumit Garg wrote:
> On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Allow u-boot to build DTB from a different directory tree such that
> > > *-u-boot.dtsi files can be included from a common location. Currently
> > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > location.
> > >
> > > This is needed for platform owners to start building DTB files from
> > > devicetree-rebasing directory but still being able to include
> > > *-u-boot.dtsi files.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 27b9437027c..4a002b0e0ca 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -159,18 +159,20 @@ cpp_flags      =3D -Wp,-MD,$(depfile) $(NOSTDIN=
C_FLAGS) $(UBOOTINCLUDE)     \
> > >  ld_flags       =3D $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> > >
> > >  # Try these files in order to find the U-Boot-specific .dtsi include=
 file
> > > -u_boot_dtsi_options =3D $(strip $(wildcard $(dir $<)$(basename $(not=
dir $<))-u-boot.dtsi) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dt=
si) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dt=
si) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot=
.dtsi) \
> > > -       $(wildcard $(dir $<)u-boot.dtsi))
> > > +UBOOT_DTSI_LOC =3D $(srctree)/arch/$(ARCH)/dts/
> >
> > How about lower case since it is internal. Also we know it is U-Boot,
> > so perhap  ?
>=20
> Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
> too. So I will use that instead.

I was going to say lets use "uboot_dtsi_loc" so it's both clear what the
variable does and for future re-syncs.

--=20
Tom

--Groupsio=CgmSatme7twm5iAucbo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC7B8ACgkQFHw5/5Y0
tywDywv8CJDdrJonbBm62QXBvDGKLJew43seqeK4KdG4b6J7PkM0sjDSlhgbiYRb
D4VckoPsGj0p58nn1cemWiJ8PLGzT+JNLqnoW/L6vYQd7spuna4179NMa8nVQy2K
WAVAbE/KOFnJMSGpv1bSX6zZea52bDeQXZ3uD4VzBozKCGKLJrBNO19CHXWPNeBn
MjrO6LOkAAp/eGmoI2Zg+QImvmFQwXzyN6VFYxLPO2yX8V2VzJS7nQw9G3Bvh0Ds
xe52b4ssbrHVCledAfZE+bjYdiORzWF2QSc3qNnV+LllJ/NVhDPaHKw3J8eOftSd
mBDwBxS7U72kwY0sT0y2qnNHnydgQeLUk8/eygEbQyng083mPxOT6V2Mn9DNQGBG
2hEBk0ga9iPArUr1xeNUKLGbXgd3tqYXw0ys+2Vqb7XDu4ZteiY2gSv+KIDW64Po
lxNv4DgdeotNGNoetaDjDoNv/sRPnyRcpIMHd/OA80YQOddvOQ1LkKW62VHzfyGU
A7lmHIG+
=Py2d
-----END PGP SIGNATURE-----

--Groupsio=CgmSatme7twm5iAucbo3--

