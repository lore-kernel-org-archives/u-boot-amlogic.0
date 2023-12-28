Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B0C3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.124569.1703776193427672410
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 07:09:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=b3bTibD5;
 spf=pass (domain: chromium.org, ip: 209.85.219.54, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f95d69115so46961136d6.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703776192; x=1704380992; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXDah+Baey+RzKWosb0cwvIW97t/+dQttjj6rkLr0bE=;
        b=b3bTibD5ggPz+wFJ6XWGzGGT+a+eP/VYD2GugYLwwXVs9hWCnqLbShGU2I4VHX1ggF
         wUMFUEGY4GKCrk8MjKJJLyi/N4aLAp38lIlzOltYQjKnt0UWOZfHivFHI8eftkHZoS1X
         F6BQFY/KAZyjwiag435xjZi7FR0+x6sSl4PzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703776192; x=1704380992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDah+Baey+RzKWosb0cwvIW97t/+dQttjj6rkLr0bE=;
        b=OiW0IQZ6cDBDp8Jx7QcBA5tFHpgBnFNKFutvhqGrkJN/0pqnyDtI5ViS9fxjiDQRvH
         lKr4K3N/LsiBVPm2y+dgcRmdjsx0zCGRCtEHcxx/vTer5+p9eZIzAKPRqo3Z4j9egW5L
         oLHJunnCejkQjdpImH8LS/u4xRA5v1xQgWXrPYx8OKPUim9k2+DzpJxG1xtQ9Vy5tMr5
         UmG0cwewHUkZHPkqx15pWw34M+RKqrS5Dg9pQJexBSJ1vC/PMWcyrPtayQD77EbUFUA/
         IQGGFyek8PXI98Eryid6KXLvcYLo+CgfT7P6q8L+bLtTv8vvOrh/DD2akejgh+cHN8m8
         hjXg==
X-Gm-Message-State: AOJu0YwdsNxNJgY7x+oqmfT2BRpzdHQ/rvQ7EeeP6dXPsTkJFin0J4c8
	Fo0QVC2ppVtcvwF7k9827E0sjv7wflv8KEr+xHBwW4CA7212
X-Google-Smtp-Source: AGHT+IHsxFeVosMLiGVAAEImtUldTw1mENA2v0yLlx6YCQoyexQ6sR8AfZU8e1avzcx4cRvOjiFY698AtxyYR0bUP5c=
X-Received: by 2002:a05:6214:21e4:b0:67f:78e4:ed55 with SMTP id
 p4-20020a05621421e400b0067f78e4ed55mr14821944qvj.106.1703776192589; Thu, 28
 Dec 2023 07:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org> <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat>
In-Reply-To: <20231228135642.GA2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:41 +0000
Message-ID: <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2003

Hi Tom,

On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > Hi Sumit,
> >
> > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Although there were still some variations in board DTS files based on
> > > meson-gxbb SoC but I think those were minor differences from upstream
> > > and shouldn't impact boot on these devices.
> > >
> > > So switch to upstream DT via mirroring amlogic/ directory from
> > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directl=
y
> > > building DTB from there including *-u-boot.dtsi files from
> > > arch/$(ARCH)/dts/ directory.
> > >
> > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > > --------------
> > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
> > >
> > > Changes in v2:
> > > --------------
> > > - Picked up review tag
> > >
> > >  arch/arm/mach-meson/Kconfig           | 1 +
> > >  configs/nanopi-k2_defconfig           | 2 +-
> > >  configs/odroid-c2_defconfig           | 2 +-
> > >  configs/p200_defconfig                | 2 +-
> > >  configs/p201_defconfig                | 2 +-
> > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > >  configs/wetek-hub_defconfig           | 2 +-
> > >  configs/wetek-play2_defconfig         | 2 +-
> > >  dts/arch/arm64/amlogic                | 1 +
> > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > >  create mode 120000 dts/arch/arm64/amlogic
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfi=
g
> > > index d6c89058061..8ddb59161a0 100644
> > > --- a/arch/arm/mach-meson/Kconfig
> > > +++ b/arch/arm/mach-meson/Kconfig
> > > @@ -25,6 +25,7 @@ choice
> > >  config MESON_GXBB
> > >         bool "GXBB"
> > >         select MESON_GX
> > > +       imply OF_UPSTREAM
> > >         help
> > >           Select this if your SoC is an S905
> > >
> > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfi=
g
> > > index 41dbf7981f8..2e1c756bf7a 100644
> > > --- a/configs/nanopi-k2_defconfig
> > > +++ b/configs/nanopi-k2_defconfig
> > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > >  CONFIG_ENV_SIZE=3D0x2000
> > >  CONFIG_DM_GPIO=3Dy
> > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > >  CONFIG_DM_RESET=3Dy
> > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> >
> > So now I am wondering if we can (later) have the SoC be implied when
> > using OF_UPSTREAM so we can do:
> >
> > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> >
> > and it will add the 'amlogic/' automatically?
> >
> > Perhaps that might be a way to bridge the gap in terms of file layout?
>
> That's going to start to look real ugly real quick I suspect and I'm not
> sure what it really gets us? It seems to me that the convention of
> "vendor/board" has already been well enough adapted outside of the
> kernel, with the odd sticking point being getting everyone used to
> whatever will be happening for 32bit boards long term. So I think hiding
> the vendor part of the string here will be more, not less, confusing
> long term.

Now that I dig in a bit, I see that the devicetree-rebasing tree does
not have any Makefiles in it. How does Linux build with it? Does
anyone have instructions?

Regards,
Simon

