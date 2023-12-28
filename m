Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D81C47077
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.124339.1703776164314574896
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 07:09:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=Gynu3Wc2;
 spf=pass (domain: chromium.org, ip: 209.85.219.41, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f8a5ed1a0so40395716d6.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703776163; x=1704380963; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no58KO7DxbMxIZ5ojulTOZwDRMrp2Sexn2Z6gScpYu8=;
        b=Gynu3Wc2WjsL3Burby+BnNbo9g02I8kg0shs225YfBE+/Zbazudd9XeNBpK7WTwi4+
         IQhuGUJZHA8dWHCI5yeBoG9ArY25BZ9q7qCMgeaQSIUYVi7/UITA30UPvUzrR0954VJB
         f5HIcSviYI5J78iYWu0NEbImX7WqQronLobCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703776163; x=1704380963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no58KO7DxbMxIZ5ojulTOZwDRMrp2Sexn2Z6gScpYu8=;
        b=oFBc+P4zDSvs3Fzo1Fi2kmz+ocrJGoCPkM4phpKW2CB91SzAIwEjz6WBFQvdo6m/FL
         eUm+Wh+nZPW7Gkfuym6piEjljA2uzM7H8W8DMlaGSBD/ugnuF08VbTNCMG7wY0cXB2BR
         PCVoF3v048YDsrr3D/eLJdhzhPIuLzL/rcPmOUKeGBxog0ZyIZh/xLuQUM4B9NJEa3HI
         ija/lSSUSvq11SV1uIbNQSK8Oe3dd28K3HTCV04kbrV4kcustTgixigE19Vv9Vxkvzlg
         KaroYalbZxEdcXMnRwqnBFIKd/OZcWsVcmvwGQNxREPup1hMpAMBQvmFfYHZ1Hz5oQI1
         iDIg==
X-Gm-Message-State: AOJu0YyEeXb6t67UAv+j+1HP02Zl+E7Fq6IFB6mOPcX29WpTeAiK7b9p
	LFfNGppGat93OqLoJXKN07gxYjcF3fF5vW4b9uolcrYrTfmz
X-Google-Smtp-Source: AGHT+IGXobipWD9AF+Dr6vuXuZ8xSzaJ16THTAe2IDx5kjzf4GRn6OHi0yl+naUUwM1p7INNs75ruJWacCShFzs2Deo=
X-Received: by 2002:ad4:530d:0:b0:67f:ac30:6256 with SMTP id
 y13-20020ad4530d000000b0067fac306256mr8275485qvr.104.1703776163433; Thu, 28
 Dec 2023 07:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org> <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
In-Reply-To: <20231228140313.GB2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:12 +0000
Message-ID: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2002

Hi Tom, Sumit,

On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > Hi Sumit,
> >
> > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Allow platform owners to mirror devicetree files from devitree-rebasi=
ng
> > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Th=
en
> > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/=
dts
> > > directory. Also add a new Makefile for arm64.
> > >
> > > This will help easy migration for platforms which currently are compl=
iant
> > > with upstream Linux kernel devicetree files.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > > --------------
> > > - Minor commit message update
> > >
> > > Changes in v2:
> > > --------------
> > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > >
> > >  dts/Kconfig             | 11 +++++++++++
> > >  dts/Makefile            | 17 ++++++++++++++---
> > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > >  create mode 100644 dts/arch/arm64/Makefile
> > >
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 00c0aeff893..e58c1c6f2ab 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -85,6 +85,17 @@ config OF_LIVE
> > >           enables a live tree which is available after relocation,
> > >           and can be adjusted as needed.
> > >
> > > +config OF_UPSTREAM
> > > +       bool "Enable use of devicetree imported from Linux kernel rel=
ease"
> > > +       help
> > > +         Traditionally, U-Boot platforms used to have their custom d=
evicetree
> > > +         files or copy devicetree files from Linux kernel which are =
hard to
> > > +         maintain and can usually get out-of-sync from Linux kernel.=
 This
> > > +         option enables platforms to migrate to devicetree-rebasing =
repo where
> > > +         a regular sync will be maintained every major Linux kernel =
release
> > > +         cycle. However, platforms can still have some custom u-boot=
 specific
> > > +         bits maintained as part of *-u-boot.dtsi files.
> >
> > My only other suggestion here is to mention that this should be set in
> > Kconfig, for the SoC as a whole. So I believe that means that it
> > should be hidden, with no string for the 'bool':
> >
> >       bool  # Enable use of devicetree imported from Linux kernel relea=
se
>
> I think we can just keep prompting for it now, to make the transition
> easier, before this option just goes away in time, hopefully.
>
> > Also, this doesn't seem to work for me. Before this series I get these
> > files when building firefly-rk3399:
> >
> > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > rk3399-rock-4c-plus.dtb
> > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock-4=
se.dtb
> > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock96=
0.dtb
> >
> > Afterwards I get this:
> >
> > make[3]: *** No rule to make target
> > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> >
> > So I set this manually for that one board:
> >
> > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> >
> > and get:
> >
> > make[3]: *** No rule to make target
> > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> >
> > I am not sure how to fix this, nor how this can be made to build all
> > the DTs for rk3399, as it does today.
>
> Looking at the patch for amlogic boards, you need to make the link to
> devicetree-rebasing inside dts/...

OK, let me give up on rk3399 for now...that doesn't seem to work even
with the link.

Using odroid-c2 with -next I see:

$ ls /tmp/b/odroid-c2/arch/arm/dts/
meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
    meson-gxl-s905x-libretech-cc.dtb
meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
    meson-gxl-s905x-libretech-cc-v2.dtb
meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
    meson-gxl-s905x-p212.dtb
meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
    meson-gxm-gt1-ultimate.dtb
meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
    meson-gxm-khadas-vim2.dtb
meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
    meson-gxm-s912-libretech-pc.dtb
meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
    meson-gxm-wetek-core2.dtb
meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
    meson-sm1-bananapi-m2-pro.dtb
meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
    meson-sm1-bananapi-m5.dtb
meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
    meson-sm1-khadas-vim3l.dtb
meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
    meson-sm1-odroid-c4.dtb
meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
    meson-sm1-odroid-hc4.dtb
meson-g12b-odroid-go-ultra.dtb
meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
$
With this series (sort of, since I am really not sure how to
cherry-pick the commits from the PR) I see nothing:

$ ls /tmp/b/odroid-c2/arch/arm/dts/
$

This shows some of the files:

$ find /tmp/b/odroid-c2/ -name "*.dtb"
/tmp/b/odroid-c2/dts/dt.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
/tmp/b/odroid-c2/u-boot.dtb

but where are the rest? Also, is it possible to put the output .dtb
files into the same directory? Otherwise we may have some pain with
binman.

[..]

Regards,
Simon

