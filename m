Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E0C4828C
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.130595.1703792904719767285
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 11:48:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=inEFa2Lm;
 spf=pass (domain: chromium.org, ip: 209.85.160.171, mailfrom: sjg@chromium.org)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-427e69f70afso15143281cf.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703792904; x=1704397704; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nm3vgKsckklqjNzAO8oqsgXSj1huNJyVodZNruQUPA=;
        b=inEFa2Lm5cOXK0droVQszB6k+iPESOyWprfD7MAbwVYyuj11Y4Y/auP6GprRBGOXQ4
         XhkZ5n1F1okRrzyyg3xITAYt7fCaXbS3CBhiuggKVozAKbSFVgv2jASGmBPBwV6zoUhQ
         JfXMgRGFMvXx1u35yiQqcwp4S8yfR+R0HHvxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703792904; x=1704397704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nm3vgKsckklqjNzAO8oqsgXSj1huNJyVodZNruQUPA=;
        b=mSJlrjFFx9LrXVkijwjf1DYYyZU66XwssHXHymSq6n0LXgeZiRi/qCmJaQawKWNYPF
         H5qSqNoFkjLxIo8+ncKY64K4f4LoonUiGNReUYUwEfee+2Hc8tif25qF7k9Jxjf6hEMz
         lYuibtyLtFKJjxP+vVxWjO5Dz1ceE61xQaHSPxrW+4qtjiBPucKQdpkDxAGVpMuf1IWz
         ZapkkR/2R9Jfydbz35SzqhXAJ0tVY1c3GM19Zk4UfcLQpP6IjT3qSXfutRQQOC1eKQUI
         P+lPNwqGbAFiyedQcnoT4hciPtv6qoRLXwVHIIzY2Dkfh92lONnpRRsDIP4lSN91p/ZT
         j28g==
X-Gm-Message-State: AOJu0YxKb0x7rvVs4bzAFXOIMc2MPgynJLh1YAQPtrEQtT2O6TrONa+0
	2/6Qfu+tfVVCdIX8p8wEjY4hDKEhtPM16ZwukZPEgmH+p6d6
X-Google-Smtp-Source: AGHT+IFzWnbwyeVFfCQT35A1ZnwpYai9+l/Sy8oBOJnnbahIUDxN2eMlg5Jhm3dHZjgJ1O/MZtBseQdx8NaE1zMk7+I=
X-Received: by 2002:a05:6214:caf:b0:67f:40eb:bfa7 with SMTP id
 s15-20020a0562140caf00b0067f40ebbfa7mr17380942qvs.48.1703792903810; Thu, 28
 Dec 2023 11:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org> <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat> <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
 <20231228152504.GF2652760@bill-the-cat>
In-Reply-To: <20231228152504.GF2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:13 +0000
Message-ID: <CAFLszTh24c1L4xfab7EmgSYJt6HhwfK+0h6quEMNt9QxW01DqA@mail.gmail.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2008

Hi Tom,

On Thu, Dec 28, 2023 at 3:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > > Hi Sumit,
> > > >
> > > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@lin=
aro.org> wrote:
> > > > >
> > > > > Although there were still some variations in board DTS files base=
d on
> > > > > meson-gxbb SoC but I think those were minor differences from upst=
ream
> > > > > and shouldn't impact boot on these devices.
> > > > >
> > > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby dir=
ectly
> > > > > building DTB from there including *-u-boot.dtsi files from
> > > > > arch/$(ARCH)/dts/ directory.
> > > > >
> > > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > --------------
> > > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instea=
d.
> > > > >
> > > > > Changes in v2:
> > > > > --------------
> > > > > - Picked up review tag
> > > > >
> > > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > > >  configs/odroid-c2_defconfig           | 2 +-
> > > > >  configs/p200_defconfig                | 2 +-
> > > > >  configs/p201_defconfig                | 2 +-
> > > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > > >  configs/wetek-hub_defconfig           | 2 +-
> > > > >  configs/wetek-play2_defconfig         | 2 +-
> > > > >  dts/arch/arm64/amlogic                | 1 +
> > > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > > >  create mode 120000 dts/arch/arm64/amlogic
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kc=
onfig
> > > > > index d6c89058061..8ddb59161a0 100644
> > > > > --- a/arch/arm/mach-meson/Kconfig
> > > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > > @@ -25,6 +25,7 @@ choice
> > > > >  config MESON_GXBB
> > > > >         bool "GXBB"
> > > > >         select MESON_GX
> > > > > +       imply OF_UPSTREAM
> > > > >         help
> > > > >           Select this if your SoC is an S905
> > > > >
> > > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defc=
onfig
> > > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > > --- a/configs/nanopi-k2_defconfig
> > > > > +++ b/configs/nanopi-k2_defconfig
> > > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > > >  CONFIG_ENV_SIZE=3D0x2000
> > > > >  CONFIG_DM_GPIO=3Dy
> > > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > > >  CONFIG_DM_RESET=3Dy
> > > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > > >
> > > > So now I am wondering if we can (later) have the SoC be implied whe=
n
> > > > using OF_UPSTREAM so we can do:
> > > >
> > > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > >
> > > > and it will add the 'amlogic/' automatically?
> > > >
> > > > Perhaps that might be a way to bridge the gap in terms of file layo=
ut?
> > >
> > > That's going to start to look real ugly real quick I suspect and I'm =
not
> > > sure what it really gets us? It seems to me that the convention of
> > > "vendor/board" has already been well enough adapted outside of the
> > > kernel, with the odd sticking point being getting everyone used to
> > > whatever will be happening for 32bit boards long term. So I think hid=
ing
> > > the vendor part of the string here will be more, not less, confusing
> > > long term.
> >
> > Now that I dig in a bit, I see that the devicetree-rebasing tree does
> > not have any Makefiles in it. How does Linux build with it? Does
> > anyone have instructions?
>
> Linux doesn't build with it, it's the relevant parts of the kernel tree
> extracted for other projects to more easily use (more or less).

Hmmm, in that case can we add Makefiles into the U-Boot version of the
tree, for U-Boot use?

Regards,
Simon

