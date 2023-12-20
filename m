Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F4C46CD4
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 08:48:18 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web11.21399.1703079691294898949
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 05:41:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wG9Lzatt;
 spf=pass (domain: linaro.org, ip: 209.85.222.53, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7c5f29423c5so722504241.1
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703079690; x=1703684490; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=md9E5mLeLouK9uKNB5ejrZhS4Rb0/93xO0dOsJEslD8=;
        b=wG9Lzatt/D3uMCrsCuK7BuAoTp8F2g2mvsqxnFQVALmb1YeINtP6b/IwrU7I1zXvj8
         9AVse46inC35sOT7rFs7M6rAUftHD2pE+oOdsVu893SckH8glpvrejxsFcrMDv735FGH
         XgM0uc3A6CPU3oXfo09yAEIE8ETbhhQ/ZSgW0RtHohwHFb3i7cTeNqdURdLKTADA+kPJ
         2UcmmguXGh0u1+3mtDfCZ2oEAXu9O3Ljip9Syag8VaX6b0SGCSA5bBx3Kq1fE52MYdLR
         R/ePIweMGd6x9iomt2qc3U36POvmM/PtNyG6sLj+6doQyNDQ7TyhsUI2IzmniEa6Sja9
         8VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079690; x=1703684490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md9E5mLeLouK9uKNB5ejrZhS4Rb0/93xO0dOsJEslD8=;
        b=IWBgcNRAPCDDkPDCn2Zw/GCTV265urkU9RIpZk+MKXzlv/Z0EmHHRA/Z8dFwyoqMSU
         QM3f2TBy3PAevDyZlMbmgmuotQjObIi3f4jAjfaGfHU5iVYqJOJmoC1+EI0BVT4CbWaj
         xxJ/B8CVScgFesNANkRet35kQ1W1RxJUFJLUNwLMiFXxwU1+3gEc0ekmYhK+xuZrtrGW
         bA3YnAD6hN+LROVptu/A8eFlU8NYiwaQSd+bdm6iwLx4BgZMhX36j6JWfNcX+VZ0ZIlp
         rDjr9Mw+UaOeDNE6UHnSB63Vv1pSImxVI0ZyBg3H7rsRKTTlp9dOLbdgowwQOXpCi6os
         +4mg==
X-Gm-Message-State: AOJu0Yw/+3UZOV8Mfh0YCRK9KubwMPKiTI3mZprOjGNJ09coAe3oZ+Uf
	C5ZtSKEjxENx7nDj7lg8V4wYBGUmCAXna4FE5B4QBQ==
X-Google-Smtp-Source: AGHT+IEy92Cix0RhwuYgeQFCIK0/I83rJ3PsorFTJiaytY3V7u5B7P3PCPZQh3dx3PjO+pdHeCIX9A3y6F4B4JjNOsA=
X-Received: by 2002:a05:6102:5586:b0:466:afed:f2d2 with SMTP id
 dc6-20020a056102558600b00466afedf2d2mr1484922vsb.16.1703079690347; Wed, 20
 Dec 2023 05:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org> <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
 <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com> <20231220132903.GL2513409@bill-the-cat>
In-Reply-To: <20231220132903.GL2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 19:11:19 +0530
Message-ID: <CAFA6WYNS9yksD+e7ZJo46cnPufuviN6js5=yCK4SXN_qLrFgBA@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Dec 2023 08:48:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1962

On Wed, 20 Dec 2023 at 18:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 20, 2023 at 05:00:20PM +0530, Sumit Garg wrote:
> > On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Allow u-boot to build DTB from a different directory tree such that
> > > > *-u-boot.dtsi files can be included from a common location. Currently
> > > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > > location.
> > > >
> > > > This is needed for platform owners to start building DTB files from
> > > > devicetree-rebasing directory but still being able to include
> > > > *-u-boot.dtsi files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 27b9437027c..4a002b0e0ca 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
> > > >  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> > > >
> > > >  # Try these files in order to find the U-Boot-specific .dtsi include file
> > > > -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > > > -       $(wildcard $(dir $<)u-boot.dtsi))
> > > > +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
> > >
> > > How about lower case since it is internal. Also we know it is U-Boot,
> > > so perhap  ?
> >
> > Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
> > too. So I will use that instead.
>
> I was going to say lets use "uboot_dtsi_loc" so it's both clear what the
> variable does and for future re-syncs.

Okay that makes further sense. I will use it if I don't see any
objection from Simon.

-Sumit

>
> --
> Tom

