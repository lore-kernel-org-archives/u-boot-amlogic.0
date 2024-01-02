Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DAC47422
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.30853.1704208251408451764
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 07:10:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LRj9QuOu;
 spf=pass (domain: konsulko.com, ip: 209.85.128.172, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ebca94cf74so53180127b3.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704208250; x=1704813050; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Av/CihhfHIZzLH6wwLoBuXpGe5LTMamcQfG9Dqm3Src=;
        b=LRj9QuOuLr8SY5K3RZdIeSbqeRzZAZqgMrcb2sxTMvSfG5yc0arzo7H0qtRxcOrLSi
         PZPOLeXElofdv6Z6sGYl/mDVp6BSoFiwm73TbSrTTfQjkkCS9QQWe7SyK1jdSp45bJ1w
         RffHnRKsI2rjhPd1F8gyt9DR3tPoLfKj4yjwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208250; x=1704813050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av/CihhfHIZzLH6wwLoBuXpGe5LTMamcQfG9Dqm3Src=;
        b=VbXVmwBuY0haFItyQM9TiqQi9eMxFHDFNmGeRcbY6PGs+0hMTnizIJCbFuS3pWpiy4
         gytAyaYCnmR4vfGNKDVoDTGTmcdM1oxu4DUCt4tQGb+Vqg71se5pMtKym4CN6B/bkw2p
         cbTAFgswqCMcD1fGvFchoqJHjvkDuPXSc/g2U44Fpv0HqDdt0rfewPuYY4QfNm6UtjLy
         7fZHFTfOZwX8zK/3QTX76L+7XVxjeKdrg6dkgST9dxn+kAaNJwUrbY+zV48xsbcSRSx+
         +ah2sUYvOYPAjEEzmE7HWjED+A2lRWtHuQLuxNFrHh4LwcEm+qc+8YWEuBL0s4LnmWzF
         MSGw==
X-Gm-Message-State: AOJu0YwZRmaAnLcdZARpLkv+V3j4tAqZHh3xrR5yshLxlbh7dMPUlk9h
	GA4vEVXMuhgJVYH6+Lc1h6Z/LbKCKffsIg==
X-Google-Smtp-Source: AGHT+IHapFVDLRwcsmU8F7+tFEu1mQbr2kPtMwldhKlR6J/oJUfp23RSCUcJr50PomGJvH0k9ebHZQ==
X-Received: by 2002:a81:bb41:0:b0:5e8:89f9:1103 with SMTP id a1-20020a81bb41000000b005e889f91103mr10147233ywl.85.1704208250328;
        Tue, 02 Jan 2024 07:10:50 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id u66-20020a818445000000b005e6d6903934sm12210941ywf.9.2024.01.02.07.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:10:49 -0800 (PST)
Date: Tue, 2 Jan 2024 10:10:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, sumit.garg@linaro.org,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, caleb.connolly@linaro.org,
	ff@shokubai.tech, daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org, pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Message-ID: <20240102151046.GL2652760@bill-the-cat>
References: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=FiyYKQWC1rCrVtdTb9QI"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2021

--Groupsio=FiyYKQWC1rCrVtdTb9QI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 07:06:40AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, Jan 1, 2024 at 4:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Mon, Jan 01, 2024 at 03:32:41PM -0700, Simon Glass wrote:
> > > Hi Mark, Tom,
> > >
> > > On Sun, Dec 31, 2023 at 5:33=E2=80=AFPM Mark Kettenis <mark.kettenis@=
xs4all.nl> wrote:
> > > >
> > > > > Date: Sun, 31 Dec 2023 15:39:53 -0500
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote:
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit.garg@=
linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom, Sumit,
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Sumit,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg=
 <sumit.garg@linaro.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Allow platform owners to mirror devicetree files =
from devitree-rebasing
> > > > > > > > > > > > > directory into dts/arch/$(ARCH) (special case for=
 dts/arch/arm64). Then
> > > > > > > > > > > > > build then along with any *-u-boot.dtsi file pres=
ent in arch/$(ARCH)/dts
> > > > > > > > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This will help easy migration for platforms which=
 currently are compliant
> > > > > > > > > > > > > with upstream Linux kernel devicetree files.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v3:
> > > > > > > > > > > > > --------------
> > > > > > > > > > > > > - Minor commit message update
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > --------------
> > > > > > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > > > > > > > > > >
> > > > > > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > > > > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > > > > > > > >  3 files changed, 39 insertions(+), 3 deletions(-=
)
> > > > > > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > > > > > >           enables a live tree which is available =
after relocation,
> > > > > > > > > > > > >           and can be adjusted as needed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > > > > > +       bool "Enable use of devicetree imported f=
rom Linux kernel release"
> > > > > > > > > > > > > +       help
> > > > > > > > > > > > > +         Traditionally, U-Boot platforms used to=
 have their custom devicetree
> > > > > > > > > > > > > +         files or copy devicetree files from Lin=
ux kernel which are hard to
> > > > > > > > > > > > > +         maintain and can usually get out-of-syn=
c from Linux kernel. This
> > > > > > > > > > > > > +         option enables platforms to migrate to =
devicetree-rebasing repo where
> > > > > > > > > > > > > +         a regular sync will be maintained every=
 major Linux kernel release
> > > > > > > > > > > > > +         cycle. However, platforms can still hav=
e some custom u-boot specific
> > > > > > > > > > > > > +         bits maintained as part of *-u-boot.dts=
i files.
> > > > > > > > > > > >
> > > > > > > > > > > > My only other suggestion here is to mention that th=
is should be set in
> > > > > > > > > > > > Kconfig, for the SoC as a whole. So I believe that =
means that it
> > > > > > > > > > > > should be hidden, with no string for the 'bool':
> > > > > > > > > > > >
> > > > > > > > > > > >       bool  # Enable use of devicetree imported fro=
m Linux kernel release
> > > > > > > > > > >
> > > > > > > > > > > I think we can just keep prompting for it now, to mak=
e the transition
> > > > > > > > > > > easier, before this option just goes away in time, ho=
pefully.
> > > > > > > > > > >
> > > > > > > > > > > > Also, this doesn't seem to work for me. Before this=
 series I get these
> > > > > > > > > > > > files when building firefly-rk3399:
> > > > > > > > > > > >
> > > > > > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-=
v.dtb
> > > > > > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > > > > > > > > rk3399-evb.dtb                  rk3399-leez-p710.dt=
b
> > > > > > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > > > > > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dt=
b
> > > > > > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > > > > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2g=
b.dtb
> > > > > > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.d=
tb
> > > > > > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.=
dtb
> > > > > > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dt=
b
> > > > > > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.=
dtb    rk3399-rock-4se.dtb
> > > > > > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.d=
tb     rk3399-rock960.dtb
> > > > > > > > > > > >
> > > > > > > > > > > > Afterwards I get this:
> > > > > > > > > > > >
> > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtb=
s'.  Stop.
> > > > > > > > > > > >
> > > > > > > > > > > > So I set this manually for that one board:
> > > > > > > > > > > >
> > > > > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firef=
ly"
> > > > > > > > > > > >
> > > > > > > > > > > > and get:
> > > > > > > > > > > >
> > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', neede=
d by 'dtbs'.  Stop.
> > > > > > > > > > > >
> > > > > > > > > > > > I am not sure how to fix this, nor how this can be =
made to build all
> > > > > > > > > > > > the DTs for rk3399, as it does today.
> > > > > > > > > > >
> > > > > > > > > > > Looking at the patch for amlogic boards, you need to =
make the link to
> > > > > > > > > > > devicetree-rebasing inside dts/...
> > > > > > > > > >
> > > > > > > > > > OK, let me give up on rk3399 for now...that doesn't see=
m to work even
> > > > > > > > > > with the link.
> > > > > > > > > >
> > > > > > > > > > Using odroid-c2 with -next I see:
> > > > > > > > > >
> > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > meson-a1-ad401.dtb                 meson-g12b-odroid-n2=
l.dtb
> > > > > > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2=
-plus.dtb
> > > > > > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > > > > > meson-axg-s400.dtb                 meson-g12b-radxa-zer=
o2.dtb
> > > > > > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.d=
tb
> > > > > > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > > > > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2=
.dtb
> > > > > > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > > > > > meson-g12a-u200.dtb                meson-gxbb-odroidc2.=
dtb
> > > > > > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> > > > > > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> > > > > > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub=
.dtb
> > > > > > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-pla=
y2.dtb
> > > > > > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > > > > > meson-g12b-gtking.dtb              meson-gxl-s805x-libr=
etech-ac.dtb
> > > > > > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libr=
etech-pc.dtb
> > > > > > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei61=
0.dtb
> > > > > > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khad=
as-vim.dtb
> > > > > > > > > > $
> > > > > > > > > > With this series (sort of, since I am really not sure h=
ow to
> > > > > > > > > > cherry-pick the commits from the PR) I see nothing:
> > > > > > > > > >
> > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > $
> > > > > > > > > >
> > > > > > > > > > This shows some of the files:
> > > > > > > > > >
> > > > > > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odro=
idc2.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nano=
pi-k2.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wete=
k-play2.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-=
pro.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200=
.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201=
.dtb
> > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wete=
k-hub.dtb
> > > > > > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > > > > > >
> > > > > > > > > > but where are the rest? Also, is it possible to put the=
 output .dtb
> > > > > > > > > > files into the same directory? Otherwise we may have so=
me pain with
> > > > > > > > > > binman.
> > > > > > > > >
> > > > > > > > > What do you mean by same directory? But maybe also, what'=
s an example of
> > > > > > > > > a board you think might end up having problems? Convertin=
g that in a
> > > > > > > > > follow-up series is likely a good idea, to highlight and =
address these
> > > > > > > > > issues sooner rather than later.#
> > > > > > > >
> > > > > > > > Today the .dtb files go into arch/arm/dts - so it would be =
easier if
> > > > > > > > this series could do the same.
> > > > > > >
> > > > > > > The kbuild infrastructure keeps the dtb alongside dts files w=
hich is
> > > > > > > the preferred way too as otherwise it would be complicated to=
 locate
> > > > > > > DT files for the users. Also, we have to move towards Linux D=
T
> > > > > > > directory structure and thereby the tools like binman have to=
 be
> > > > > > > adjusted. I will do that when I get to migrating SoCs support=
ing
> > > > > > > binman.
> > > > > >
> > > > > > OK, I want to stop here and rethink this. This is the path take=
n so
> > > > > > far, I believe:
> > > > > >
> > > > > > 1. We want to use devicetree files taken from Linux and
> > > > > > devicetree-rebasing provides these
> > > > >
> > > > > Yes.
> > > > >
> > > > > > 2. We want to use 'git subtree' to avoid needing a script to do=
 the
> > > > > > sync / create a commit
> > > > >
> > > > > No. We want to use 'git subtree' to avoid having to use git submo=
dules.
> > >
> > > Well that is what I understood from Sumit, when I asked about a
> > > script. I imagine a 100-line Python script could do the same as:
> > >
> > >    git subtree pull --prefix devicetree-rebasing
> > > git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-r=
ebasing.git
> > > <release-tag> --squash
> > >
> > > and it could also put the files in the right place for U-Boot.
> >
> > I've been saying in various places for years that I want to move away
> > from arch/*/dts being where we have the "just a copy" dts files and hav=
e
> > them somewhere else so they are easier to manage and differentiate our
> > changes / additions. So arch/*/dts cannot be some hard-coded "right"
> > path.
>=20
> OK
>=20
> >
> > > > > > 3. But this leaves us with a directory structure which doesn't =
match
> > > > > > U-Boot (no script to fix it up)
> > > > >
> > > > > No. We intentionally abandon arch/*/dts because it's so full of
> > > > > out of date files and never fully re-synced, only re-synced ad-ho=
c.
> > >
> > > I mean that the dir structure doesn't match. I am not worried about
> > > keeping arch/*/dts but I want the same structure somewhere else, e.g.
> > > dtr/arch/*/dts
> >
> > And what I want here is to match the same structure everyone that's not
> > U-Boot uses. For better or worse no one else seems to have gone with
> > "treat aarch64 as just another ARM", and then the vendor directory
> > structure only makes that more obviously a mismatch. We need to follow
> > what everyone else uses, and developers familiar with other projects
> > will expect to see.
>=20
> So you are saying that U-Boot should move to what Linux uses. I agree
> that seems like the best approach, so let's do it.
>=20
> >
> > > > > > 4. So we deal with that by skipping the build rules and using C=
ONFIG
> > > > > > options to select what is built
> > > > > > 5. So now we cannot build all the files for an SoC, just the on=
es that
> > > > > > are in the CONFIG options
> > > > > > 6. Linux doesn't actually use devicetree-rebasing itself, so do=
esn't
> > > > > > have this problem
> > > > >
> > > > > No. devicetree-rebasing skips the Makefiles because they're part =
of the
> > > > > kernel. We couldn't re-use them ourselves because we don't have t=
he same
> > > > > CONFIG names the kernel does. And Sumit has not replicated the lo=
gic we
> > > > > have under arch/*/dts/Makefile today because I've asked him not t=
o, and
> > > > > we'll figure out what subsets of that logic make sense to add bac=
k in as
> > > > > a second step not a first step.
> > >
> > > Again, you are missing my point. I am not suggesting using Linux's
> > > build rules, just explaining why Linux doesn't have the problem we
> > > would be creating here.
> > >
> > > > > > So this is heading in the wrong direction. Nor is it clear that=
 this
> > > > > > would just be a temporary problem.
> > > > >
> > > > > A previous iteration of this series built all of the dtb files fo=
r the
> > > > > SoC that Sumit has migrated with this series, but then dropped it=
.
> > >
> > > Oh.
> > >
> > > > >
> > > > > [snip]
> > > > > > I would like to do this series properly, maintaining the SoC-sp=
ecific
> > > > > > build rules, not removing what I see as an important feature. I=
t
> > > > > > should not be that difficult to figure out and I am happy to he=
lp with
> > > > > > it.
> > > > >
> > > > > The problem is that the rest of us do not understand the use case=
 you're
> > > > > describing where a dtb file that would be useful in a build is no=
t
> > > > > already in the list to build. The only one of those use cases I
> > > > > understand thus far is the exynos4 (iirc) case you mentioned prev=
iously
> > > > > where yes, really, one defconfig + appending board.dtb is fine, o=
r fine
> > > > > enough. It's not that far off of the SPL_LOAD_FIT case, but there=
 we
> > > > > know what to build already.
> > >
> > > Perhaps the problem is that the rest of you think of the build as all
> > > happening in U-Boot, similar to the proposed 'make image.fit' that I
> > > am trying to add to Linux.
> > >
> > > But packaging can be (and often is) a separate step from building.
> > > Linux has no packaging mechanism today...it just builds everything
> > > (including all DTs) and stops.
> > >
> > > We should be able to pick up whatever .dtb files we want and use them
> > > in an image.
> > >
> > > > > And I guess trying to tie things up, that's my puzzle. SPL_LOAD_F=
IT is
> > > > > how I see the use case you talk about being solved, if a full U-B=
oot is
> > > > > generic enough for N boards, SPL_LOAD_FIT does the right thing (i=
n this
> > > > > non-bloblist DTB, non-reusing-OS-inntended DTB world). I really d=
on't
> > > > > knnow how many modern SoCs can take a literal concatenated DTB an=
d even
> > > > > in those cases I don't get why that's the win we want now? 1 buil=
d to N
> > > > > binaries?
> > >
> > > Yes SPL_LOAD_FIT is fine although in practice we will likely need SPL
> > > to use the correct DT as well, so the DT will need to be determined i=
n
> > > TPL, perhaps.
> >
> > I mean, SPL_LOAD_FIT still can handle this case, with a call to the
> > function to re-parse the tree, when needed. I thought we did this today
> > even, but perhaps I'm confusing my options here.
> >
> > > But anyway, this works OK with rk3399, for example. We need to suppor=
t
> > > this use case.
> > >
> > > Also, it is pretty easy. We just need to stick with the dir structure
> > > we have today and copy our existing Makefiles into that dir. Or chang=
e
> > > to the kernel dir structure and use that. Or do one, then the other.
> >
> > I'm sorry, I don't understand what directory structure has to do with
> > "build more dtbs". For the cases where it makes sense to, yes, we can
> > build more dtbs, based on the SoC. I'm setting aside entirely the
> > discussion on what SoCs that works for, for another thread.
>=20
> Well you said above that we should switch to the kernel dir structure,
> so I believe that issue is resolved.
>=20
> 'build more dtbs' means build all the DTBs for an SoC, not just a
> selection that a particular board vendor decided on.

Yes, what other dtbs to build is the sticking point, in a number of
threads now.

> > Perhaps an issue here is that much like the kernel "install" target, we
> > need an "install" target too, so that whatever dtbs we build can be
> > more easily found for external packaging, but whatever tooling it is
> > that wants it? And perhaps this is part of the problem, tooling that
> > expects to pull things out of the object directory rather than an
> > "installed" directory?
>=20
> This is where binman comes in. It can run as part of U-Boot build, to
> build a few default firmware images. Then it can be run *later*,
> outside the U-Boot build, with an augmented or more targeted image
> definition, with mostly the same input files, to pull together images
> for specific uses. As you say, the input files need to be in a defined
> location, which they are today, for the most part.
>=20
> So even if a particular board only uses one DT, all the DTs for that
> SoC are built and so can be used in that final-packaging step. Without
> that build, there is no way to get the required .dtb files, other than
> building every board one by one and then pulling out the .dtb files or
> something weird like that.
>=20
> Note that this works independently of whether OF_LIST is used, etc.

How about this. When you introduce generic-rk3399_defconfig is when we
can also have dts-$(CONFIG_ROCKCHIP_RK3399) list everything, and insist
it be kept up to date. That to me feels like the right order to go in.
And we can have all of the implementation details be hashed out
elsewhere, not in the thread about fixing our nightmare about dts file
resync.

> > > > > But even then, I don't object to adding those rules to the Makefi=
les. If
> > > > > it works it works. I object to adding them when they don't work.
> > >
> > > What do you mean by 'work'? With this series as is, it simply isn't
> > > possible to add Makefile rules, as they are ignored. Am I missing
> > > something?
> >
> > Yes, I think you're missing something. Perhaps you need to publish a WI=
P
> > tree somewhere so someone can see what you're doing as it sounds like
> > you're not able to add another SoC of any type on top of Sumit's tree
> > and have it work.
>=20
> The current -next source builds dtb files based on the SoC, for the
> most part. I sent a series to clean that up a bit[1], but it is mostly
> there.

Yes, and that relied on Rasmus' series having been merged ages ago which
fixed up a number of "people just copypasta'd something here,
incorrectly".  Keep that in mind as part of why I have objections here.

>=20
> From the above it seems like the plan could be:
> 1. Move arm64 .dts files to arch/arm64/dts/<vendor>/... and adjust
> Makefiles accordingly

Since we're going to move everyone to being from the upstream kernel,
that seems like unneeded churn.

> 2. Choose a directory target for devicetree-rebasing. I see that
> 'barebox' uses 'dts' which seems better to me than
> 'devicetree-rebasing/src/'. Actually barebox even seems to have
> scripts for handling all of this [2]??

They've been doing this since longer than git subtree has existed I
believe. I suspect that much like how Rob would like to move the
in-kernel devicetree compiler sync from a script to git subtree, barebox
will too.

> 3. Adjust the build system to use the dts/ directory for .dts files
> when OF_UPSTREAM is enabled
>=20
> Then it will be easy. People can enable OF_UPSTREAM for an SoC
> (without changing DEFAULT_DEVICE_TREE) and will get the same behaviour
> as now, just with upstream .dts files. All the .dts files for an SoC
> are built, as now, just as Linux does. We can continue cleaning up the
> DT build rules as time permits.

Maybe the unasked / unanswered question here is, why don't we put the
subtree in to dts/ ? Just because it would make us more likely to make
changes rather than treat it as read only?

--=20
Tom

--Groupsio=FiyYKQWC1rCrVtdTb9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUJ3MACgkQFHw5/5Y0
tyw6Fwv/TI0MIfqQgYLuWzNSCSIlrY8EUFnlFw4Uf6tddXEW36Sm3soKms4nF+aB
AIak7UzodlevuA/u+gnsD3k7Dy4y0T6op+Ggmrm5hhyrKp2f96cYHSsmPuHGEx2U
fu2wOGOdMvK4qPL8x28olnbhdZFsWiatCUNI57D2kkspGKi3bOCA14yJiouARQMR
UJueZCNF70ByFFRESID1qTwXjjn+eqQK5LLQRon/9k9ATqs+FZKYDG9GBb+r/Zds
nV3W48CyvOLYVQwvYx4jVtjOU8qKhtOGqFZS+5okP4CT9yM1Y3+stBQC+JaJlGrr
8edo6Er8rV4IdsoOmP0hSwwvg6Z/dIDSZcZIX3pkb7NO68+BQKdxWLHAELFP7BY9
UevURXsPFEVZo5ABK3aMVQpjdyPkZvQxOqj9cDXnLA8ndlVFRk9A6eM7ErtFWsCl
JjDRSNs0xqlBcl5sn3bennEFAwxYEHBk6C+kLEBKduQaHbJQ5ZzYZimDwBlM8yXa
NnATX2ak
=khVF
-----END PGP SIGNATURE-----

--Groupsio=FiyYKQWC1rCrVtdTb9QI--

