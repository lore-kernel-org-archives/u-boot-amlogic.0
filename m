Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46FC48289
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.219364.1704026885557984861
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Dec 2023 04:48:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=MkvGwflU;
 spf=pass (domain: chromium.org, ip: 209.85.219.42, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-680b1335af6so1066396d6.1
        for <u-boot-amlogic@groups.io>; Sun, 31 Dec 2023 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704026884; x=1704631684; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uBr+h3iLkOIMAzd+O7b24oUIqsNprWnVuK3SY/whsA=;
        b=MkvGwflUzdUAHR34Zz8mc8rGPfymUAVI2tXPdUC4x/+92K0TYS0JQZPU31Si5z94cX
         x+kb48aMhPY6CSDYuXMZng8i/WzUfH3XQhItLVzKwu6Sf0eJ3w4wdqAPF7W91mVTmQ7q
         k2Hn05sYdypCMRFQgFjHR1QA/+WTSd673Uipc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704026884; x=1704631684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uBr+h3iLkOIMAzd+O7b24oUIqsNprWnVuK3SY/whsA=;
        b=M6B7QaZ7ZcdRMkuv+Rlqp9jB632Pi9+nlu7VnYSPTjHPmDM8+wIsVLPVV8CoyvuUdq
         oaTxCO9mI5NPgqpMcriPykyearV3o7H9FYXUo3xAwXYVNL446KpSVL9jZa2z8YBuvLHP
         pEN02rqu/dGdCPZH3MKSAHkqIcAcOOjDOhlnRvNaPZQlBFiPEyJlwvKXuvkvvG9xf0UL
         rw1cUL33jFOh2Burk5w5JnrZ/jWT+PzEFN0YwiK9BOLBBBGb34r1C5/nVJ594ZuuxBVM
         z+ECvPSuOWlXTanRqvZaJYcKDnpPyKKEatERprJwJ7xXcnXyC+1hIU/DsLTrs6RTlcPX
         L1oA==
X-Gm-Message-State: AOJu0YyVwDy1ctUvrGJ+82a4Bf0Me6XaKA0qah178TxpX/84uTC8xif6
	V3VAhu2Y25rv55GrfJ9CCgt2oGWcbvVFBeFqfXrqBcLF/z6J
X-Google-Smtp-Source: AGHT+IEC0g8765OVqOGsbNGeI0qUX/SazfofItNrYpoDm0N5AForFh7q59X/gCs204G+Mx8hchc2a2NYoanC0e5kr8A=
X-Received: by 2002:ad4:5c6e:0:b0:67f:5749:b927 with SMTP id
 i14-20020ad45c6e000000b0067f5749b927mr21830299qvh.16.1704026884731; Sun, 31
 Dec 2023 04:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org> <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat> <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
 <20231228152504.GF2652760@bill-the-cat> <CAFLszTh24c1L4xfab7EmgSYJt6HhwfK+0h6quEMNt9QxW01DqA@mail.gmail.com>
 <20231228203209.GP2652760@bill-the-cat>
In-Reply-To: <20231228203209.GP2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:47:54 -0700
Message-ID: <CAFLszTge10mi6HooHkE5wUeU6ZB7M=1QQMXn+at+W1j2rsGtkw@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2012

Hi Tom,

On Thu, Dec 28, 2023 at 1:32=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 07:48:13PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 3:25=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg=
@linaro.org> wrote:
> > > > > > >
> > > > > > > Although there were still some variations in board DTS files =
based on
> > > > > > > meson-gxbb SoC but I think those were minor differences from =
upstream
> > > > > > > and shouldn't impact boot on these devices.
> > > > > > >
> > > > > > > So switch to upstream DT via mirroring amlogic/ directory fro=
m
> > > > > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby=
 directly
> > > > > > > building DTB from there including *-u-boot.dtsi files from
> > > > > > > arch/$(ARCH)/dts/ directory.
> > > > > > >
> > > > > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > --------------
> > > > > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC in=
stead.
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > --------------
> > > > > > > - Picked up review tag
> > > > > > >
> > > > > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > > > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > > > > >  configs/odroid-c2_defconfig           | 2 +-
> > > > > > >  configs/p200_defconfig                | 2 +-
> > > > > > >  configs/p201_defconfig                | 2 +-
> > > > > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > > > > >  configs/wetek-hub_defconfig           | 2 +-
> > > > > > >  configs/wetek-play2_defconfig         | 2 +-
> > > > > > >  dts/arch/arm64/amlogic                | 1 +
> > > > > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > > > > >  create mode 120000 dts/arch/arm64/amlogic
> > > > > > >
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meso=
n/Kconfig
> > > > > > > index d6c89058061..8ddb59161a0 100644
> > > > > > > --- a/arch/arm/mach-meson/Kconfig
> > > > > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > > > > @@ -25,6 +25,7 @@ choice
> > > > > > >  config MESON_GXBB
> > > > > > >         bool "GXBB"
> > > > > > >         select MESON_GX
> > > > > > > +       imply OF_UPSTREAM
> > > > > > >         help
> > > > > > >           Select this if your SoC is an S905
> > > > > > >
> > > > > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_=
defconfig
> > > > > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > > > > --- a/configs/nanopi-k2_defconfig
> > > > > > > +++ b/configs/nanopi-k2_defconfig
> > > > > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > > > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > > > > >  CONFIG_ENV_SIZE=3D0x2000
> > > > > > >  CONFIG_DM_GPIO=3Dy
> > > > > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > > > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > > > > >  CONFIG_DM_RESET=3Dy
> > > > > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > > > > >
> > > > > > So now I am wondering if we can (later) have the SoC be implied=
 when
> > > > > > using OF_UPSTREAM so we can do:
> > > > > >
> > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > > >
> > > > > > and it will add the 'amlogic/' automatically?
> > > > > >
> > > > > > Perhaps that might be a way to bridge the gap in terms of file =
layout?
> > > > >
> > > > > That's going to start to look real ugly real quick I suspect and =
I'm not
> > > > > sure what it really gets us? It seems to me that the convention o=
f
> > > > > "vendor/board" has already been well enough adapted outside of th=
e
> > > > > kernel, with the odd sticking point being getting everyone used t=
o
> > > > > whatever will be happening for 32bit boards long term. So I think=
 hiding
> > > > > the vendor part of the string here will be more, not less, confus=
ing
> > > > > long term.
> > > >
> > > > Now that I dig in a bit, I see that the devicetree-rebasing tree do=
es
> > > > not have any Makefiles in it. How does Linux build with it? Does
> > > > anyone have instructions?
> > >
> > > Linux doesn't build with it, it's the relevant parts of the kernel tr=
ee
> > > extracted for other projects to more easily use (more or less).
> >
> > Hmmm, in that case can we add Makefiles into the U-Boot version of the
> > tree, for U-Boot use?
>
> No? Why would we do that? I think you're missing how the amlogic
> conversion works.

I will reply on the other thread about this.

Regards,
Simon

