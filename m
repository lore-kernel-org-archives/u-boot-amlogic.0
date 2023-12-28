Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C101C47DA2
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.130592.1703792897975931354
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 11:48:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=i4YAOu+9;
 spf=pass (domain: chromium.org, ip: 209.85.219.53, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6803466a1ccso18725606d6.3
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703792897; x=1704397697; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSh89mdgjuPnVooqNlwgpnW5/Bf+Pn7GpiERk//yKgk=;
        b=i4YAOu+9lzcsWzbcPjoDy6GKeB+YoToUuw5iZDmzEtBawDOx7GdWuM5DihBTtZ1N6V
         Hjg5wVTm9lfes+dlYFG0V+VyCExEwJp+2lytKfi8bbFrwGuMpFD45tI0l4GcyEJ2PQfo
         vqYVDUeqZepuQax1kDoZE7wnOA5TlApI4fYyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703792897; x=1704397697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSh89mdgjuPnVooqNlwgpnW5/Bf+Pn7GpiERk//yKgk=;
        b=uKOEA0HfqRi45ODuiZ7UJBRtp6fJjs5f45o0erqIZmHrYDpNYyMU2m32O6RxIvsbX0
         Gx+3BJ6qbC70djzJa0EEC7kQk7e43yKuT06uG1m35DDkDeO3oTOQOK+XXrxrwoZDoo6D
         dtX6oQPXswJet1h1dG9jUKbIyFPOGTp0DqP2RrQJbLjY8QV6fTqyd4aZI5VLPe+VOAyf
         /KZbr9hniZA3LVM5qT88UxJIfWQsKVWSCdvNzM2CIr0HhtIneBqKELc4qO1k3GK0ofXD
         d4YsKY7HBazUtv1LYpVWu1L/Pi3YkVQ6q06hp9eWvfMnVrhSGegzhpgOO3v0QLYIVbxd
         xqYw==
X-Gm-Message-State: AOJu0YxdWxHoCd6h1XcslEiihZoolAYHLYGfhiVVYH1B9YHckSXmI46P
	c71a+/QxebzScFD64s358dreGg7pDgnjrHqW+Td4DuxoReEY
X-Google-Smtp-Source: AGHT+IF2dgeWSPb/5yneyxldv2uhIf63qykqDB3GHgiClYHmmPkiDRn+LS22tn0hkGZClatY6NEQkuUAngoaD4g7E+U=
X-Received: by 2002:a05:6214:c49:b0:67f:666b:adac with SMTP id
 r9-20020a0562140c4900b0067f666badacmr15033040qvj.16.1703792897047; Thu, 28
 Dec 2023 11:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org> <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
In-Reply-To: <20231228155428.GI2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:06 +0000
Message-ID: <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2007

Hi Tom,

On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> > Hi Tom, Sumit,
> >
> > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > > Hi Sumit,
> > > >
> > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@lin=
aro.org> wrote:
> > > > >
> > > > > Allow platform owners to mirror devicetree files from devitree-re=
basing
> > > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64)=
. Then
> > > > > build then along with any *-u-boot.dtsi file present in arch/$(AR=
CH)/dts
> > > > > directory. Also add a new Makefile for arm64.
> > > > >
> > > > > This will help easy migration for platforms which currently are c=
ompliant
> > > > > with upstream Linux kernel devicetree files.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > --------------
> > > > > - Minor commit message update
> > > > >
> > > > > Changes in v2:
> > > > > --------------
> > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > >
> > > > >  dts/Kconfig             | 11 +++++++++++
> > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > >
> > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > --- a/dts/Kconfig
> > > > > +++ b/dts/Kconfig
> > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > >           enables a live tree which is available after relocation=
,
> > > > >           and can be adjusted as needed.
> > > > >
> > > > > +config OF_UPSTREAM
> > > > > +       bool "Enable use of devicetree imported from Linux kernel=
 release"
> > > > > +       help
> > > > > +         Traditionally, U-Boot platforms used to have their cust=
om devicetree
> > > > > +         files or copy devicetree files from Linux kernel which =
are hard to
> > > > > +         maintain and can usually get out-of-sync from Linux ker=
nel. This
> > > > > +         option enables platforms to migrate to devicetree-rebas=
ing repo where
> > > > > +         a regular sync will be maintained every major Linux ker=
nel release
> > > > > +         cycle. However, platforms can still have some custom u-=
boot specific
> > > > > +         bits maintained as part of *-u-boot.dtsi files.
> > > >
> > > > My only other suggestion here is to mention that this should be set=
 in
> > > > Kconfig, for the SoC as a whole. So I believe that means that it
> > > > should be hidden, with no string for the 'bool':
> > > >
> > > >       bool  # Enable use of devicetree imported from Linux kernel r=
elease
> > >
> > > I think we can just keep prompting for it now, to make the transition
> > > easier, before this option just goes away in time, hopefully.
> > >
> > > > Also, this doesn't seem to work for me. Before this series I get th=
ese
> > > > files when building firefly-rk3399:
> > > >
> > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > > rk3399-rock-4c-plus.dtb
> > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-ro=
ck-4se.dtb
> > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-ro=
ck960.dtb
> > > >
> > > > Afterwards I get this:
> > > >
> > > > make[3]: *** No rule to make target
> > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > > >
> > > > So I set this manually for that one board:
> > > >
> > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > > >
> > > > and get:
> > > >
> > > > make[3]: *** No rule to make target
> > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  St=
op.
> > > >
> > > > I am not sure how to fix this, nor how this can be made to build al=
l
> > > > the DTs for rk3399, as it does today.
> > >
> > > Looking at the patch for amlogic boards, you need to make the link to
> > > devicetree-rebasing inside dts/...
> >
> > OK, let me give up on rk3399 for now...that doesn't seem to work even
> > with the link.
> >
> > Using odroid-c2 with -next I see:
> >
> > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
> >     meson-gxl-s905x-libretech-cc.dtb
> > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
> >     meson-gxl-s905x-libretech-cc-v2.dtb
> > meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
> >     meson-gxl-s905x-p212.dtb
> > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
> >     meson-gxm-gt1-ultimate.dtb
> > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
> >     meson-gxm-khadas-vim2.dtb
> > meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
> >     meson-gxm-s912-libretech-pc.dtb
> > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> >     meson-gxm-wetek-core2.dtb
> > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> >     meson-sm1-bananapi-m2-pro.dtb
> > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
> >     meson-sm1-bananapi-m5.dtb
> > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
> >     meson-sm1-khadas-vim3l.dtb
> > meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
> >     meson-sm1-odroid-c4.dtb
> > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
> >     meson-sm1-odroid-hc4.dtb
> > meson-g12b-odroid-go-ultra.dtb
> > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
> > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
> > $
> > With this series (sort of, since I am really not sure how to
> > cherry-pick the commits from the PR) I see nothing:
> >
> > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > $
> >
> > This shows some of the files:
> >
> > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > /tmp/b/odroid-c2/dts/dt.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
> > /tmp/b/odroid-c2/u-boot.dtb
> >
> > but where are the rest? Also, is it possible to put the output .dtb
> > files into the same directory? Otherwise we may have some pain with
> > binman.
>
> What do you mean by same directory? But maybe also, what's an example of
> a board you think might end up having problems? Converting that in a
> follow-up series is likely a good idea, to highlight and address these
> issues sooner rather than later.#

Today the .dtb files go into arch/arm/dts - so it would be easier if
this series could do the same.

The problem I have described above applied to meson, so I believe it
is clear enough with that. I wasn't able to get rk3399 going, but I am
sure it would have the same problem.

The fundamental question is (I believe) whether to:

1. Build only a single DT for a board
2. Build all DTs for the SoC the board uses

This series seems to head towards (1), which worries me. We are
currently mostly at (2).

Regards,
Simon

