Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D8C47DDA
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web11.52553.1704371015679888921
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 04:23:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=D4mFxplH;
 spf=pass (domain: linaro.org, ip: 209.85.217.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-46746edb7bcso78313137.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 04:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704371014; x=1704975814; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FGiciZ7OX5H3bVBZ2+/aeu3RFl4bMDdqAfCTjNAYrA=;
        b=D4mFxplHWq/I2lCUzOsouSAqe0y4N7dtolzk+ncYkjmMIBC5WxdWzb3vsuma+pj5JV
         kLwVKtuSyv9wDlZfJY6DZo6DglFawMKn32QePwm98IRE/YP18rg8+yJztoIWBOTl4I/T
         d+2wYOlPFaX1qVYS0cMqG9+vTqZ/HZrA0vXacZetWzzMu38tzTV3DF2LnjPgltToJo/O
         sFQygnEzrgNZ0DLZDEacooHVNFR1+9m9sFwnSwfpOhCKIdvUMN28JMFYlIiwhdZfTfwR
         dn3uYs307/jCGuqlcvnnsEANTjJq/QRofr0uQ35kV1qDtnPNCv0TpKgSp5khmflhbkiU
         vsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371014; x=1704975814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FGiciZ7OX5H3bVBZ2+/aeu3RFl4bMDdqAfCTjNAYrA=;
        b=dqN30urhP8KcxtbkAUOGh8TrtSi2Puaj441e5sO8EvjyGV9jMT8zZGU0uKJ5pFSnnz
         mP6cC6wfxnbLfHAKtiVZiJbq5KscsMgmuhRb9ey8ZT+mFxEQMWkC0+/PtXw7cXaIBpfs
         m9nxIzXfGci2/Z/7XHfampHG3hBfWhS+MbmH9EOoINcswwNSFJPDHwVyLdZ+FcdFnUHF
         rNgBoEWQOQfpQhwrTTUnLCmrWq4Y9cUlQokX/VxLRf9casam3BC6VyCpZruuzoy2MGy7
         iCqdpXcq+n1g9+Mg6edV8jVWR4nkBrba26nKCgQ5T4qr1sHggqDMg/yrSdu+IERKTnk1
         Fz4A==
X-Gm-Message-State: AOJu0YxxCCvIwLLIpwpHMPG+NDU7TZfY4TL6+f1EX5EhTVjaty+Xm3c5
	5/d2rRUJVdfUTd5r/xZjOXhd8Vs1PiBQI7TKMhQf6MdlPF2iDg==
X-Google-Smtp-Source: AGHT+IFjfdhwG/IdaT+z8UTJJzNgXMAqQWPRnQDtnBC8kVfZPGGaJ/dv4b3xeODJ25teCDPbSPERpXTnfUQB289wifg=
X-Received: by 2002:a05:6102:6690:b0:467:810:b410 with SMTP id
 gw16-20020a056102669000b004670810b410mr369327vsb.21.1704371014664; Thu, 04
 Jan 2024 04:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org> <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
In-Reply-To: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 17:53:23 +0530
Message-ID: <CAFA6WYMtpZowkhXccj+R5Teop11XbA26DzKadV0x25GCVPMDaQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2037

Hi Simon,

On Thu, 28 Dec 2023 at 20:39, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom, Sumit,
>
> On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > Hi Sumit,
> > >
> > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > Allow platform owners to mirror devicetree files from devitree-reba=
sing
> > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). =
Then
> > > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH=
)/dts
> > > > directory. Also add a new Makefile for arm64.
> > > >
> > > > This will help easy migration for platforms which currently are com=
pliant
> > > > with upstream Linux kernel devicetree files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > --------------
> > > > - Minor commit message update
> > > >
> > > > Changes in v2:
> > > > --------------
> > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > >
> > > >  dts/Kconfig             | 11 +++++++++++
> > > >  dts/Makefile            | 17 ++++++++++++++---
> > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > >  create mode 100644 dts/arch/arm64/Makefile
> > > >
> > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > --- a/dts/Kconfig
> > > > +++ b/dts/Kconfig
> > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > >           enables a live tree which is available after relocation,
> > > >           and can be adjusted as needed.
> > > >
> > > > +config OF_UPSTREAM
> > > > +       bool "Enable use of devicetree imported from Linux kernel r=
elease"
> > > > +       help
> > > > +         Traditionally, U-Boot platforms used to have their custom=
 devicetree
> > > > +         files or copy devicetree files from Linux kernel which ar=
e hard to
> > > > +         maintain and can usually get out-of-sync from Linux kerne=
l. This
> > > > +         option enables platforms to migrate to devicetree-rebasin=
g repo where
> > > > +         a regular sync will be maintained every major Linux kerne=
l release
> > > > +         cycle. However, platforms can still have some custom u-bo=
ot specific
> > > > +         bits maintained as part of *-u-boot.dtsi files.
> > >
> > > My only other suggestion here is to mention that this should be set i=
n
> > > Kconfig, for the SoC as a whole. So I believe that means that it
> > > should be hidden, with no string for the 'bool':
> > >
> > >       bool  # Enable use of devicetree imported from Linux kernel rel=
ease
> >
> > I think we can just keep prompting for it now, to make the transition
> > easier, before this option just goes away in time, hopefully.
> >
> > > Also, this doesn't seem to work for me. Before this series I get thes=
e
> > > files when building firefly-rk3399:
> > >
> > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > rk3399-rock-4c-plus.dtb
> > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock=
-4se.dtb
> > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock=
960.dtb
> > >
> > > Afterwards I get this:
> > >
> > > make[3]: *** No rule to make target
> > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > >
> > > So I set this manually for that one board:
> > >
> > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > >
> > > and get:
> > >
> > > make[3]: *** No rule to make target
> > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop=
.
> > >
> > > I am not sure how to fix this, nor how this can be made to build all
> > > the DTs for rk3399, as it does today.
> >
> > Looking at the patch for amlogic boards, you need to make the link to
> > devicetree-rebasing inside dts/...
>
> OK, let me give up on rk3399 for now...that doesn't seem to work even
> with the link.

I went ahead to debug this rk3399 issue. It turned out to be a subtle
Makefile dependency corner case that I missed in v3. Following change
should fix the issue, I will incorporate it in v4. However, while
switching rk3399 to upstream DT I noticed many gaps from upstream DT,
one that occured to me was difference in clk id SCLK_DDRCLK (U-Boot)
vs SCLK_DDRC (upstream DT).

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index bdc1da43e7a..9526eb073f1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -358,7 +359,7 @@ ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
 dtsi_include_list +=3D $(capsule_esl_dtsi)
 endif

-dtsi_include_list_deps =3D $(addprefix $(obj)/,$(subst
$(quote),,$(dtsi_include_list)))
+dtsi_include_list_deps =3D $(addprefix $(u_boot_dtsi_loc)/,$(subst
$(quote),,$(dtsi_include_list)))

 ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?=3D dt-validate

-Sumit

