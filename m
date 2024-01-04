Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ECDC48286
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.45052.1704332574949806160
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Jan 2024 17:42:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=lL9XE1+G;
 spf=pass (domain: chromium.org, ip: 209.85.222.176, mailfrom: sjg@chromium.org)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7815aca9a4eso5282485a.0
        for <u-boot-amlogic@groups.io>; Wed, 03 Jan 2024 17:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704332574; x=1704937374; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubiBpFwLdj+EPXJKjieqfKpC5SttKd+jHD+pLrGEd0=;
        b=lL9XE1+GZyy9CPn7NeGQEgWQczf97NxTFCeo4SkyuKHkjGD8Chzs+oCasBijeRktmQ
         zY/S6Z2GUrou7wGKlELnxxM/NzxLhRwn9gBj1fMw4PTYTTyloPuoot7E/qRUWKvYygwH
         jx3zU/wL003zVooRxu+PAR7XE6CTwfpEdqwS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704332574; x=1704937374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ubiBpFwLdj+EPXJKjieqfKpC5SttKd+jHD+pLrGEd0=;
        b=AuKZQa3ehKCLGDCU9sHWIUsh2eQ2ud5FE6Uwix4d/DqerY/tvVEIfaof9zaQxi1K+/
         9khwPLAN4U31QPK/JcmFspfgeKGBAr0a6x8Wcg1P59JghEjz58R/iDKvfN3sHLhQHdBR
         BQbeKdZoN7Kxg6c76naA0fgqW+5UxHYb8oQyz9oSaF0oNXAtPXjtCYjdw8swyaBjZL4u
         LxCeLxR/ncYPYMSHCnTGiKpdMTbaSEZi1/NC4PsNsobTPDCeflsyneUDQbb1+NQjA+Xm
         5Mdb3uX40jXmqXUkoKwXeTRNpHQwwiX4WxDYHNLzJDapeEUzWNsX+UDZfitg/yomPSuH
         W5aQ==
X-Gm-Message-State: AOJu0YzD/I9cVqQcWhQyR0TmhespEuuKSwHKcztBpzV2Qsqa/iaRwp/O
	6n9V9KHvdwzxb9gxKXkt036YAFO/Lx6ildHqw9Xx9Zhdes5u
X-Google-Smtp-Source: AGHT+IEr58OVmgUpe//wZwE4NMMx5aAr6zU/VQw8AkDypWIdniUrFLCzrqYeigYw2Hh2W7lXB8by/lKaXNGFETsIFiU=
X-Received: by 2002:a0c:e889:0:b0:67f:935c:3b22 with SMTP id
 b9-20020a0ce889000000b0067f935c3b22mr18380750qvo.108.1704332573759; Wed, 03
 Jan 2024 17:42:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat> <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <20240102151046.GL2652760@bill-the-cat> <CAFLszThysDjASn4U7CpBmmp4axjE-CrFk1x6TLhLpmVicpwGbQ@mail.gmail.com>
 <20240103004138.GC1610741@bill-the-cat>
In-Reply-To: <20240103004138.GC1610741@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jan 2024 18:42:42 -0700
Message-ID: <CAFLszTgiARqxr+J1zt+q9kTrBoU=nrCbZ=QRzUMzmxztSawjfg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, sumit.garg@linaro.org, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2032

Hi Tom,

On Tue, Jan 2, 2024 at 5:41=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 04:54:15PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, Jan 2, 2024 at 8:10=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Tue, Jan 02, 2024 at 07:06:40AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, Jan 1, 2024 at 4:35=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > > >
> > > > > On Mon, Jan 01, 2024 at 03:32:41PM -0700, Simon Glass wrote:
> > > > > > Hi Mark, Tom,
> > > > > >
> > > > > > On Sun, Dec 31, 2023 at 5:33=E2=80=AFPM Mark Kettenis <mark.ket=
tenis@xs4all.nl> wrote:
> > > > > > >
> > > > > > > > Date: Sun, 31 Dec 2023 15:39:53 -0500
> > > > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > > >
> > > > > > > > On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote=
:
> > > > > > > > > Hi Sumit,
> > > > > > > > >
> > > > > > > > > On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit=
.garg@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium=
.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom, Sumit,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini =
<trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Sumit,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumi=
t Garg <sumit.garg@linaro.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Allow platform owners to mirror devicetree =
files from devitree-rebasing
> > > > > > > > > > > > > > > > directory into dts/arch/$(ARCH) (special ca=
se for dts/arch/arm64). Then
> > > > > > > > > > > > > > > > build then along with any *-u-boot.dtsi fil=
e present in arch/$(ARCH)/dts
> > > > > > > > > > > > > > > > directory. Also add a new Makefile for arm6=
4.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This will help easy migration for platforms=
 which currently are compliant
> > > > > > > > > > > > > > > > with upstream Linux kernel devicetree files=
.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linar=
o.org>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Changes in v3:
> > > > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > > > - Minor commit message update
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-=
Boot/
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > > > > > > > > >  dts/Makefile            | 17 +++++++++++++=
+---
> > > > > > > > > > > > > > > >  dts/arch/arm64/Makefile | 14 +++++++++++++=
+
> > > > > > > > > > > > > > > >  3 files changed, 39 insertions(+), 3 delet=
ions(-)
> > > > > > > > > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > > > > > > > > >           enables a live tree which is avai=
lable after relocation,
> > > > > > > > > > > > > > > >           and can be adjusted as needed.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > > > > > > > > +       bool "Enable use of devicetree impo=
rted from Linux kernel release"
> > > > > > > > > > > > > > > > +       help
> > > > > > > > > > > > > > > > +         Traditionally, U-Boot platforms u=
sed to have their custom devicetree
> > > > > > > > > > > > > > > > +         files or copy devicetree files fr=
om Linux kernel which are hard to
> > > > > > > > > > > > > > > > +         maintain and can usually get out-=
of-sync from Linux kernel. This
> > > > > > > > > > > > > > > > +         option enables platforms to migra=
te to devicetree-rebasing repo where
> > > > > > > > > > > > > > > > +         a regular sync will be maintained=
 every major Linux kernel release
> > > > > > > > > > > > > > > > +         cycle. However, platforms can sti=
ll have some custom u-boot specific
> > > > > > > > > > > > > > > > +         bits maintained as part of *-u-bo=
ot.dtsi files.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > My only other suggestion here is to mention t=
hat this should be set in
> > > > > > > > > > > > > > > Kconfig, for the SoC as a whole. So I believe=
 that means that it
> > > > > > > > > > > > > > > should be hidden, with no string for the 'boo=
l':
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       bool  # Enable use of devicetree import=
ed from Linux kernel release
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think we can just keep prompting for it now, =
to make the transition
> > > > > > > > > > > > > > easier, before this option just goes away in ti=
me, hopefully.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Also, this doesn't seem to work for me. Befor=
e this series I get these
> > > > > > > > > > > > > > > files when building firefly-rk3399:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas=
-edge-v.dtb
> > > > > > > > > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.=
dtb
> > > > > > > > > > > > > > > rk3399-evb.dtb                  rk3399-leez-p=
710.dtb
> > > > > > > > > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.=
dtb
> > > > > > > > > > > > > > > rk3399-ficus.dtb                rk3399-nanopc=
-t4.dtb
> > > > > > > > > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.d=
tb
> > > > > > > > > > > > > > > rk3399-firefly.dtb              rk3399-nanopi=
-m4-2gb.dtb
> > > > > > > > > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi=
-m4b.dtb
> > > > > > > > > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezz=
anine.dtb
> > > > > > > > > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi=
-m4.dtb
> > > > > > > > > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi=
-neo4.dtb    rk3399-rock-4se.dtb
> > > > > > > > > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi=
-r4s.dtb     rk3399-rock960.dtb
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Afterwards I get this:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed b=
y 'dtbs'.  Stop.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So I set this manually for that one board:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399=
-firefly"
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > and get:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb',=
 needed by 'dtbs'.  Stop.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I am not sure how to fix this, nor how this c=
an be made to build all
> > > > > > > > > > > > > > > the DTs for rk3399, as it does today.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Looking at the patch for amlogic boards, you ne=
ed to make the link to
> > > > > > > > > > > > > > devicetree-rebasing inside dts/...
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK, let me give up on rk3399 for now...that doesn=
't seem to work even
> > > > > > > > > > > > > with the link.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Using odroid-c2 with -next I see:
> > > > > > > > > > > > >
> > > > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > > > meson-a1-ad401.dtb                 meson-g12b-odr=
oid-n2l.dtb
> > > > > > > > > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > > > > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odr=
oid-n2-plus.dtb
> > > > > > > > > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > > > > > > > > meson-axg-s400.dtb                 meson-g12b-rad=
xa-zero2.dtb
> > > > > > > > > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > > > > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii=
-pro.dtb
> > > > > > > > > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > > > > > > > > meson-g12a-sei510.dtb              meson-gxbb-nan=
opi-k2.dtb
> > > > > > > > > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > > > > > > > > meson-g12a-u200.dtb                meson-gxbb-odr=
oidc2.dtb
> > > > > > > > > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > > > > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p20=
0.dtb
> > > > > > > > > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > > > > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p20=
1.dtb
> > > > > > > > > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > > > > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wet=
ek-hub.dtb
> > > > > > > > > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > > > > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wet=
ek-play2.dtb
> > > > > > > > > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > > > > > > > > meson-g12b-gtking.dtb              meson-gxl-s805=
x-libretech-ac.dtb
> > > > > > > > > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > > > > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905=
d-libretech-pc.dtb
> > > > > > > > > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > > > > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > > > > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1=
-sei610.dtb
> > > > > > > > > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905=
x-khadas-vim.dtb
> > > > > > > > > > > > > $
> > > > > > > > > > > > > With this series (sort of, since I am really not =
sure how to
> > > > > > > > > > > > > cherry-pick the commits from the PR) I see nothin=
g:
> > > > > > > > > > > > >
> > > > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > > > $
> > > > > > > > > > > > >
> > > > > > > > > > > > > This shows some of the files:
> > > > > > > > > > > > >
> > > > > > > > > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-odroidc2.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-nanopi-k2.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-wetek-play2.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-kii-pro.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-p200.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-p201.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxb=
b-wetek-hub.dtb
> > > > > > > > > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > > > > > > > > >
> > > > > > > > > > > > > but where are the rest? Also, is it possible to p=
ut the output .dtb
> > > > > > > > > > > > > files into the same directory? Otherwise we may h=
ave some pain with
> > > > > > > > > > > > > binman.
> > > > > > > > > > > >
> > > > > > > > > > > > What do you mean by same directory? But maybe also,=
 what's an example of
> > > > > > > > > > > > a board you think might end up having problems? Con=
verting that in a
> > > > > > > > > > > > follow-up series is likely a good idea, to highligh=
t and address these
> > > > > > > > > > > > issues sooner rather than later.#
> > > > > > > > > > >
> > > > > > > > > > > Today the .dtb files go into arch/arm/dts - so it wou=
ld be easier if
> > > > > > > > > > > this series could do the same.
> > > > > > > > > >
> > > > > > > > > > The kbuild infrastructure keeps the dtb alongside dts f=
iles which is
> > > > > > > > > > the preferred way too as otherwise it would be complica=
ted to locate
> > > > > > > > > > DT files for the users. Also, we have to move towards L=
inux DT
> > > > > > > > > > directory structure and thereby the tools like binman h=
ave to be
> > > > > > > > > > adjusted. I will do that when I get to migrating SoCs s=
upporting
> > > > > > > > > > binman.
> > > > > > > > >
> > > > > > > > > OK, I want to stop here and rethink this. This is the pat=
h taken so
> > > > > > > > > far, I believe:
> > > > > > > > >
> > > > > > > > > 1. We want to use devicetree files taken from Linux and
> > > > > > > > > devicetree-rebasing provides these
> > > > > > > >
> > > > > > > > Yes.
> > > > > > > >
> > > > > > > > > 2. We want to use 'git subtree' to avoid needing a script=
 to do the
> > > > > > > > > sync / create a commit
> > > > > > > >
> > > > > > > > No. We want to use 'git subtree' to avoid having to use git=
 submodules.
> > > > > >
> > > > > > Well that is what I understood from Sumit, when I asked about a
> > > > > > script. I imagine a 100-line Python script could do the same as=
:
> > > > > >
> > > > > >    git subtree pull --prefix devicetree-rebasing
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git
> > > > > > <release-tag> --squash
> > > > > >
> > > > > > and it could also put the files in the right place for U-Boot.
> > > > >
> > > > > I've been saying in various places for years that I want to move =
away
> > > > > from arch/*/dts being where we have the "just a copy" dts files a=
nd have
> > > > > them somewhere else so they are easier to manage and differentiat=
e our
> > > > > changes / additions. So arch/*/dts cannot be some hard-coded "rig=
ht"
> > > > > path.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > > > > 3. But this leaves us with a directory structure which do=
esn't match
> > > > > > > > > U-Boot (no script to fix it up)
> > > > > > > >
> > > > > > > > No. We intentionally abandon arch/*/dts because it's so ful=
l of
> > > > > > > > out of date files and never fully re-synced, only re-synced=
 ad-hoc.
> > > > > >
> > > > > > I mean that the dir structure doesn't match. I am not worried a=
bout
> > > > > > keeping arch/*/dts but I want the same structure somewhere else=
, e.g.
> > > > > > dtr/arch/*/dts
> > > > >
> > > > > And what I want here is to match the same structure everyone that=
's not
> > > > > U-Boot uses. For better or worse no one else seems to have gone w=
ith
> > > > > "treat aarch64 as just another ARM", and then the vendor director=
y
> > > > > structure only makes that more obviously a mismatch. We need to f=
ollow
> > > > > what everyone else uses, and developers familiar with other proje=
cts
> > > > > will expect to see.
> > > >
> > > > So you are saying that U-Boot should move to what Linux uses. I agr=
ee
> > > > that seems like the best approach, so let's do it.
> > > >
> > > > >
> > > > > > > > > 4. So we deal with that by skipping the build rules and u=
sing CONFIG
> > > > > > > > > options to select what is built
> > > > > > > > > 5. So now we cannot build all the files for an SoC, just =
the ones that
> > > > > > > > > are in the CONFIG options
> > > > > > > > > 6. Linux doesn't actually use devicetree-rebasing itself,=
 so doesn't
> > > > > > > > > have this problem
> > > > > > > >
> > > > > > > > No. devicetree-rebasing skips the Makefiles because they're=
 part of the
> > > > > > > > kernel. We couldn't re-use them ourselves because we don't =
have the same
> > > > > > > > CONFIG names the kernel does. And Sumit has not replicated =
the logic we
> > > > > > > > have under arch/*/dts/Makefile today because I've asked him=
 not to, and
> > > > > > > > we'll figure out what subsets of that logic make sense to a=
dd back in as
> > > > > > > > a second step not a first step.
> > > > > >
> > > > > > Again, you are missing my point. I am not suggesting using Linu=
x's
> > > > > > build rules, just explaining why Linux doesn't have the problem=
 we
> > > > > > would be creating here.
> > > > > >
> > > > > > > > > So this is heading in the wrong direction. Nor is it clea=
r that this
> > > > > > > > > would just be a temporary problem.
> > > > > > > >
> > > > > > > > A previous iteration of this series built all of the dtb fi=
les for the
> > > > > > > > SoC that Sumit has migrated with this series, but then drop=
ped it.
> > > > > >
> > > > > > Oh.
> > > > > >
> > > > > > > >
> > > > > > > > [snip]
> > > > > > > > > I would like to do this series properly, maintaining the =
SoC-specific
> > > > > > > > > build rules, not removing what I see as an important feat=
ure. It
> > > > > > > > > should not be that difficult to figure out and I am happy=
 to help with
> > > > > > > > > it.
> > > > > > > >
> > > > > > > > The problem is that the rest of us do not understand the us=
e case you're
> > > > > > > > describing where a dtb file that would be useful in a build=
 is not
> > > > > > > > already in the list to build. The only one of those use cas=
es I
> > > > > > > > understand thus far is the exynos4 (iirc) case you mentione=
d previously
> > > > > > > > where yes, really, one defconfig + appending board.dtb is f=
ine, or fine
> > > > > > > > enough. It's not that far off of the SPL_LOAD_FIT case, but=
 there we
> > > > > > > > know what to build already.
> > > > > >
> > > > > > Perhaps the problem is that the rest of you think of the build =
as all
> > > > > > happening in U-Boot, similar to the proposed 'make image.fit' t=
hat I
> > > > > > am trying to add to Linux.
> > > > > >
> > > > > > But packaging can be (and often is) a separate step from buildi=
ng.
> > > > > > Linux has no packaging mechanism today...it just builds everyth=
ing
> > > > > > (including all DTs) and stops.
> > > > > >
> > > > > > We should be able to pick up whatever .dtb files we want and us=
e them
> > > > > > in an image.
> > > > > >
> > > > > > > > And I guess trying to tie things up, that's my puzzle. SPL_=
LOAD_FIT is
> > > > > > > > how I see the use case you talk about being solved, if a fu=
ll U-Boot is
> > > > > > > > generic enough for N boards, SPL_LOAD_FIT does the right th=
ing (in this
> > > > > > > > non-bloblist DTB, non-reusing-OS-inntended DTB world). I re=
ally don't
> > > > > > > > knnow how many modern SoCs can take a literal concatenated =
DTB and even
> > > > > > > > in those cases I don't get why that's the win we want now? =
1 build to N
> > > > > > > > binaries?
> > > > > >
> > > > > > Yes SPL_LOAD_FIT is fine although in practice we will likely ne=
ed SPL
> > > > > > to use the correct DT as well, so the DT will need to be determ=
ined in
> > > > > > TPL, perhaps.
> > > > >
> > > > > I mean, SPL_LOAD_FIT still can handle this case, with a call to t=
he
> > > > > function to re-parse the tree, when needed. I thought we did this=
 today
> > > > > even, but perhaps I'm confusing my options here.
> > > > >
> > > > > > But anyway, this works OK with rk3399, for example. We need to =
support
> > > > > > this use case.
> > > > > >
> > > > > > Also, it is pretty easy. We just need to stick with the dir str=
ucture
> > > > > > we have today and copy our existing Makefiles into that dir. Or=
 change
> > > > > > to the kernel dir structure and use that. Or do one, then the o=
ther.
> > > > >
> > > > > I'm sorry, I don't understand what directory structure has to do =
with
> > > > > "build more dtbs". For the cases where it makes sense to, yes, we=
 can
> > > > > build more dtbs, based on the SoC. I'm setting aside entirely the
> > > > > discussion on what SoCs that works for, for another thread.
> > > >
> > > > Well you said above that we should switch to the kernel dir structu=
re,
> > > > so I believe that issue is resolved.
> > > >
> > > > 'build more dtbs' means build all the DTBs for an SoC, not just a
> > > > selection that a particular board vendor decided on.
> > >
> > > Yes, what other dtbs to build is the sticking point, in a number of
> > > threads now.
> >
> > All of the ones for the SoC.
>
> Yes, that's your position, and it's not anyone elses position.

Indeed, I seem to be in a minority of one.

>
> > > > > Perhaps an issue here is that much like the kernel "install" targ=
et, we
> > > > > need an "install" target too, so that whatever dtbs we build can =
be
> > > > > more easily found for external packaging, but whatever tooling it=
 is
> > > > > that wants it? And perhaps this is part of the problem, tooling t=
hat
> > > > > expects to pull things out of the object directory rather than an
> > > > > "installed" directory?
> > > >
> > > > This is where binman comes in. It can run as part of U-Boot build, =
to
> > > > build a few default firmware images. Then it can be run *later*,
> > > > outside the U-Boot build, with an augmented or more targeted image
> > > > definition, with mostly the same input files, to pull together imag=
es
> > > > for specific uses. As you say, the input files need to be in a defi=
ned
> > > > location, which they are today, for the most part.
> > > >
> > > > So even if a particular board only uses one DT, all the DTs for tha=
t
> > > > SoC are built and so can be used in that final-packaging step. With=
out
> > > > that build, there is no way to get the required .dtb files, other t=
han
> > > > building every board one by one and then pulling out the .dtb files=
 or
> > > > something weird like that.
> > > >
> > > > Note that this works independently of whether OF_LIST is used, etc.
> > >
> > > How about this. When you introduce generic-rk3399_defconfig is when w=
e
> > > can also have dts-$(CONFIG_ROCKCHIP_RK3399) list everything, and insi=
st
> > > it be kept up to date. That to me feels like the right order to go in=
.
> > > And we can have all of the implementation details be hashed out
> > > elsewhere, not in the thread about fixing our nightmare about dts fil=
e
> > > resync.
> >
> > So long as Sumit can put it back so we can use build rules, that's
> > fine. But removing the build rules is the sticking point for me.
>
> But it's not a sticking point for anyone else for the series. Because
> no one else gets the point you're trying to make.

OK

>
> > > > > > > > But even then, I don't object to adding those rules to the =
Makefiles. If
> > > > > > > > it works it works. I object to adding them when they don't =
work.
> > > > > >
> > > > > > What do you mean by 'work'? With this series as is, it simply i=
sn't
> > > > > > possible to add Makefile rules, as they are ignored. Am I missi=
ng
> > > > > > something?
> > > > >
> > > > > Yes, I think you're missing something. Perhaps you need to publis=
h a WIP
> > > > > tree somewhere so someone can see what you're doing as it sounds =
like
> > > > > you're not able to add another SoC of any type on top of Sumit's =
tree
> > > > > and have it work.
> > > >
> > > > The current -next source builds dtb files based on the SoC, for the
> > > > most part. I sent a series to clean that up a bit[1], but it is mos=
tly
> > > > there.
> > >
> > > Yes, and that relied on Rasmus' series having been merged ages ago wh=
ich
> > > fixed up a number of "people just copypasta'd something here,
> > > incorrectly".  Keep that in mind as part of why I have objections her=
e.
> >
> > OK.
>
> And since I think you're missing the point I was raising, because no one
> else has the "any dtb from the SoC with this binary", we'll just be
> getting back to re-introducing those kind of problems with what you're
> demanding.
>
> > > > From the above it seems like the plan could be:
> > > > 1. Move arm64 .dts files to arch/arm64/dts/<vendor>/... and adjust
> > > > Makefiles accordingly
> > >
> > > Since we're going to move everyone to being from the upstream kernel,
> > > that seems like unneeded churn.
> >
> > What is the timeline for that move?
>
> It could probably, largely, be done in 2024, for the platforms that
> actively sync. For the ones that aren't behaving well right now? I don't
> know, it'll depend on when someone shows up being active about them
> again.
>
> > We are talking about 1700 lines of Makefies and I already made a good
> > start on part of it. So if we are going to be a few months with two
> > different paths, fine, but this is going to drag on for a year, I
> > would rather clean it up now and have a unified path for both sets of
> > DTs.
>
> The sticking point for migration is going to be the testing of the
> platforms that are not well in sync at all.
>
> > > > 2. Choose a directory target for devicetree-rebasing. I see that
> > > > 'barebox' uses 'dts' which seems better to me than
> > > > 'devicetree-rebasing/src/'. Actually barebox even seems to have
> > > > scripts for handling all of this [2]??
> > >
> > > They've been doing this since longer than git subtree has existed I
> > > believe. I suspect that much like how Rob would like to move the
> > > in-kernel devicetree compiler sync from a script to git subtree, bare=
box
> > > will too.
> >
> > Maybe, although the first barebox dts/ commit was 2014 and subtree is
> > claimed to come out in 2012...but then devicetree-rebasing might be
> > newer, which would explain why they have 'git filter-branch' stuff in
> > the script.
>
> Well, it was just a guess on my part. It took a while for subtree to
> catch on, and yes, it's taken a while for everything to reach the state
> it's in today, for dts sources outside of the linux kernel itself.
>
> > I thought devicetree-rebasing came from Linux. Is it its own repo? So
> > what is the DT upstream these days??
>
> I'll let Rob chime in again here if he likes. In short,
> devicetree-rebasing is the kernel dts files/bindings copied out and
> tagged, matching upstream kernel tags, and with assorted useful bits of
> git history available.
>
> > If subtree does what we want without making U-Boot look like
> > Franekstein's monster, that's fine. But I don't mind having a script.
>
> Yes, everyone else thus far seems fine with what we get via this series.
>
> > > > 3. Adjust the build system to use the dts/ directory for .dts files
> > > > when OF_UPSTREAM is enabled
> > > >
> > > > Then it will be easy. People can enable OF_UPSTREAM for an SoC
> > > > (without changing DEFAULT_DEVICE_TREE) and will get the same behavi=
our
> > > > as now, just with upstream .dts files. All the .dts files for an So=
C
> > > > are built, as now, just as Linux does. We can continue cleaning up =
the
> > > > DT build rules as time permits.
> > >
> > > Maybe the unasked / unanswered question here is, why don't we put the
> > > subtree in to dts/ ? Just because it would make us more likely to mak=
e
> > > changes rather than treat it as read only?
> >
> > It is an easy checkpatch check, if that is your only concern.
>
> Yeah, checkpatch isn't great for catching and stopping things. I don't
> know how many other custodians check their PRs before I get to them. So
> if it's not a fatal CI thing, it's not going to always be caught before
> I see it, and I don't always catch "ERROR" things in checkpatch in a PR
> either. But it might still be more annoying than not to have subtree be
> shoved in to "dts". I'm hoping for some feedback from Sumit on this
> point since I think he's played around.

It seems to me that the base issue here (in various threads both now
and in previous months) is whether U-Boot should control over the
devicetree it uses, either through managing to get schema upstream, or
by having its own local pieces. That question is relevant both at
build time and at runtime.

Anway, I think I have said my piece. Please go ahead with whatever you
think makes sense.

I would like to continue to clean up the existing Makefile rules though.

Regards,
Simon

