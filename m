Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B701C47DA7
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.18093.1704152150079851227
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Jan 2024 15:35:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cJ+CHTFu;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67fa018c116so54329976d6.3
        for <u-boot-amlogic@groups.io>; Mon, 01 Jan 2024 15:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704152149; x=1704756949; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lA9dODUjlb5uJ9E2XwQwKLuXbBLJEO0K27g5Zs8TVWk=;
        b=cJ+CHTFuLxx53pnsw9uiV/J4Z163d5gKfKXcVuEqR7R6CsHz+ynJcut2SKJcYhkMLD
         Mrz43VDTr2UhriOgnzfea7nTi++mb6c95+ieJ9pSAXSxtit5rHWuJjszzWf45HsagxEh
         x0t0gWb/C7s/GWBcDdIg96C1XaAuZ3ptsSMfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704152149; x=1704756949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA9dODUjlb5uJ9E2XwQwKLuXbBLJEO0K27g5Zs8TVWk=;
        b=mU52SpPoLtExNfKVO8fTiMDeFOjyDPaYDxzZnacVd57OywfDIpedSM4QmUk45FQ0er
         vSao//R7qAdwQZLq718rFShEkHgS1SM8sEOhoKoBirKB3tihXyWlFWW4ptKSTSLdN8mU
         eY8QntBzck10EjFV9dz0Guvf0G6qeIIu7/lfc0D118u3CDQU3jeLjAA6k64LPLTerYxb
         9SZQDnoLLV7JsBmz+3x6zqIb0neQGVqKcSoKqBoTTpRgWESadNTZzGnbjeO1ppDFYRBh
         s+1ccHQTvtgDp+Vn85iTtQr+dc5x3tmipU0woAvUIAOni/i4iOCNi5FanhYO3gzkRb5+
         WYmg==
X-Gm-Message-State: AOJu0Yx+Ixt5v+2su4N2N4gIayyPgqENobGtNjuF2z5KfIZwaYQmokGQ
	+kLT9rrChm+g1pfg43qgbwuQk4Icu/+o7WRWOQ71zlv2Ubc=
X-Google-Smtp-Source: AGHT+IHiXb+T1RrNke794iWCexWG4Sv2S3cjr+qe2WQafBhkgm9YmrxeTeo9cm9iqjKcmfyw7uJlsw==
X-Received: by 2002:a05:6214:2388:b0:680:b957:b275 with SMTP id fw8-20020a056214238800b00680b957b275mr1480376qvb.122.1704152149026;
        Mon, 01 Jan 2024 15:35:49 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id d9-20020a0cf6c9000000b0067f8f04a2fcsm9083452qvo.57.2024.01.01.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 15:35:48 -0800 (PST)
Date: Mon, 1 Jan 2024 18:35:45 -0500
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
Message-ID: <20240101233545.GI2652760@bill-the-cat>
References: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=6xwsB0vUYSZ6Iu3j3hKK"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2017

--Groupsio=6xwsB0vUYSZ6Iu3j3hKK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 01, 2024 at 03:32:41PM -0700, Simon Glass wrote:
> Hi Mark, Tom,
>=20
> On Sun, Dec 31, 2023 at 5:33=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4a=
ll.nl> wrote:
> >
> > > Date: Sun, 31 Dec 2023 15:39:53 -0500
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote:
> > > > Hi Sumit,
> > > >
> > > > On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom, Sumit,
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wro=
te:
> > > > > > > > > > Hi Sumit,
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <su=
mit.garg@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Allow platform owners to mirror devicetree files from=
 devitree-rebasing
> > > > > > > > > > > directory into dts/arch/$(ARCH) (special case for dts=
/arch/arm64). Then
> > > > > > > > > > > build then along with any *-u-boot.dtsi file present =
in arch/$(ARCH)/dts
> > > > > > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > > > > > >
> > > > > > > > > > > This will help easy migration for platforms which cur=
rently are compliant
> > > > > > > > > > > with upstream Linux kernel devicetree files.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > --------------
> > > > > > > > > > > - Minor commit message update
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > --------------
> > > > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > > > > > > > >
> > > > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > > > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > > > >           enables a live tree which is available afte=
r relocation,
> > > > > > > > > > >           and can be adjusted as needed.
> > > > > > > > > > >
> > > > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > > > +       bool "Enable use of devicetree imported from =
Linux kernel release"
> > > > > > > > > > > +       help
> > > > > > > > > > > +         Traditionally, U-Boot platforms used to hav=
e their custom devicetree
> > > > > > > > > > > +         files or copy devicetree files from Linux k=
ernel which are hard to
> > > > > > > > > > > +         maintain and can usually get out-of-sync fr=
om Linux kernel. This
> > > > > > > > > > > +         option enables platforms to migrate to devi=
cetree-rebasing repo where
> > > > > > > > > > > +         a regular sync will be maintained every maj=
or Linux kernel release
> > > > > > > > > > > +         cycle. However, platforms can still have so=
me custom u-boot specific
> > > > > > > > > > > +         bits maintained as part of *-u-boot.dtsi fi=
les.
> > > > > > > > > >
> > > > > > > > > > My only other suggestion here is to mention that this s=
hould be set in
> > > > > > > > > > Kconfig, for the SoC as a whole. So I believe that mean=
s that it
> > > > > > > > > > should be hidden, with no string for the 'bool':
> > > > > > > > > >
> > > > > > > > > >       bool  # Enable use of devicetree imported from Li=
nux kernel release
> > > > > > > > >
> > > > > > > > > I think we can just keep prompting for it now, to make th=
e transition
> > > > > > > > > easier, before this option just goes away in time, hopefu=
lly.
> > > > > > > > >
> > > > > > > > > > Also, this doesn't seem to work for me. Before this ser=
ies I get these
> > > > > > > > > > files when building firefly-rk3399:
> > > > > > > > > >
> > > > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dt=
b
> > > > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > > > > > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > > > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dt=
b
> > > > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb =
   rk3399-rock-4se.dtb
> > > > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb  =
   rk3399-rock960.dtb
> > > > > > > > > >
> > > > > > > > > > Afterwards I get this:
> > > > > > > > > >
> > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'. =
 Stop.
> > > > > > > > > >
> > > > > > > > > > So I set this manually for that one board:
> > > > > > > > > >
> > > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > > > > > > > > >
> > > > > > > > > > and get:
> > > > > > > > > >
> > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by=
 'dtbs'.  Stop.
> > > > > > > > > >
> > > > > > > > > > I am not sure how to fix this, nor how this can be made=
 to build all
> > > > > > > > > > the DTs for rk3399, as it does today.
> > > > > > > > >
> > > > > > > > > Looking at the patch for amlogic boards, you need to make=
 the link to
> > > > > > > > > devicetree-rebasing inside dts/...
> > > > > > > >
> > > > > > > > OK, let me give up on rk3399 for now...that doesn't seem to=
 work even
> > > > > > > > with the link.
> > > > > > > >
> > > > > > > > Using odroid-c2 with -next I see:
> > > > > > > >
> > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dt=
b
> > > > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plu=
s.dtb
> > > > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > > > meson-axg-s400.dtb                 meson-g12b-radxa-zero2.d=
tb
> > > > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
> > > > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
> > > > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > > > meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
> > > > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> > > > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> > > > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
> > > > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.d=
tb
> > > > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > > > meson-g12b-gtking.dtb              meson-gxl-s805x-libretec=
h-ac.dtb
> > > > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretec=
h-pc.dtb
> > > > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dt=
b
> > > > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-v=
im.dtb
> > > > > > > > $
> > > > > > > > With this series (sort of, since I am really not sure how t=
o
> > > > > > > > cherry-pick the commits from the PR) I see nothing:
> > > > > > > >
> > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > $
> > > > > > > >
> > > > > > > > This shows some of the files:
> > > > > > > >
> > > > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2=
.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k=
2.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-pl=
ay2.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.=
dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hu=
b.dtb
> > > > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > > > >
> > > > > > > > but where are the rest? Also, is it possible to put the out=
put .dtb
> > > > > > > > files into the same directory? Otherwise we may have some p=
ain with
> > > > > > > > binman.
> > > > > > >
> > > > > > > What do you mean by same directory? But maybe also, what's an=
 example of
> > > > > > > a board you think might end up having problems? Converting th=
at in a
> > > > > > > follow-up series is likely a good idea, to highlight and addr=
ess these
> > > > > > > issues sooner rather than later.#
> > > > > >
> > > > > > Today the .dtb files go into arch/arm/dts - so it would be easi=
er if
> > > > > > this series could do the same.
> > > > >
> > > > > The kbuild infrastructure keeps the dtb alongside dts files which=
 is
> > > > > the preferred way too as otherwise it would be complicated to loc=
ate
> > > > > DT files for the users. Also, we have to move towards Linux DT
> > > > > directory structure and thereby the tools like binman have to be
> > > > > adjusted. I will do that when I get to migrating SoCs supporting
> > > > > binman.
> > > >
> > > > OK, I want to stop here and rethink this. This is the path taken so
> > > > far, I believe:
> > > >
> > > > 1. We want to use devicetree files taken from Linux and
> > > > devicetree-rebasing provides these
> > >
> > > Yes.
> > >
> > > > 2. We want to use 'git subtree' to avoid needing a script to do the
> > > > sync / create a commit
> > >
> > > No. We want to use 'git subtree' to avoid having to use git submodule=
s.
>=20
> Well that is what I understood from Sumit, when I asked about a
> script. I imagine a 100-line Python script could do the same as:
>=20
>    git subtree pull --prefix devicetree-rebasing
> git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebas=
ing.git
> <release-tag> --squash
>=20
> and it could also put the files in the right place for U-Boot.

I've been saying in various places for years that I want to move away
from arch/*/dts being where we have the "just a copy" dts files and have
them somewhere else so they are easier to manage and differentiate our
changes / additions. So arch/*/dts cannot be some hard-coded "right"
path.

> > > > 3. But this leaves us with a directory structure which doesn't matc=
h
> > > > U-Boot (no script to fix it up)
> > >
> > > No. We intentionally abandon arch/*/dts because it's so full of
> > > out of date files and never fully re-synced, only re-synced ad-hoc.
>=20
> I mean that the dir structure doesn't match. I am not worried about
> keeping arch/*/dts but I want the same structure somewhere else, e.g.
> dtr/arch/*/dts

And what I want here is to match the same structure everyone that's not
U-Boot uses. For better or worse no one else seems to have gone with
"treat aarch64 as just another ARM", and then the vendor directory
structure only makes that more obviously a mismatch. We need to follow
what everyone else uses, and developers familiar with other projects
will expect to see.

> > > > 4. So we deal with that by skipping the build rules and using CONFI=
G
> > > > options to select what is built
> > > > 5. So now we cannot build all the files for an SoC, just the ones t=
hat
> > > > are in the CONFIG options
> > > > 6. Linux doesn't actually use devicetree-rebasing itself, so doesn'=
t
> > > > have this problem
> > >
> > > No. devicetree-rebasing skips the Makefiles because they're part of t=
he
> > > kernel. We couldn't re-use them ourselves because we don't have the s=
ame
> > > CONFIG names the kernel does. And Sumit has not replicated the logic =
we
> > > have under arch/*/dts/Makefile today because I've asked him not to, a=
nd
> > > we'll figure out what subsets of that logic make sense to add back in=
 as
> > > a second step not a first step.
>=20
> Again, you are missing my point. I am not suggesting using Linux's
> build rules, just explaining why Linux doesn't have the problem we
> would be creating here.
>
> > > > So this is heading in the wrong direction. Nor is it clear that thi=
s
> > > > would just be a temporary problem.
> > >
> > > A previous iteration of this series built all of the dtb files for th=
e
> > > SoC that Sumit has migrated with this series, but then dropped it.
>=20
> Oh.
>=20
> > >
> > > [snip]
> > > > I would like to do this series properly, maintaining the SoC-specif=
ic
> > > > build rules, not removing what I see as an important feature. It
> > > > should not be that difficult to figure out and I am happy to help w=
ith
> > > > it.
> > >
> > > The problem is that the rest of us do not understand the use case you=
're
> > > describing where a dtb file that would be useful in a build is not
> > > already in the list to build. The only one of those use cases I
> > > understand thus far is the exynos4 (iirc) case you mentioned previous=
ly
> > > where yes, really, one defconfig + appending board.dtb is fine, or fi=
ne
> > > enough. It's not that far off of the SPL_LOAD_FIT case, but there we
> > > know what to build already.
>=20
> Perhaps the problem is that the rest of you think of the build as all
> happening in U-Boot, similar to the proposed 'make image.fit' that I
> am trying to add to Linux.
>=20
> But packaging can be (and often is) a separate step from building.
> Linux has no packaging mechanism today...it just builds everything
> (including all DTs) and stops.
>
> We should be able to pick up whatever .dtb files we want and use them
> in an image.
>
> > > And I guess trying to tie things up, that's my puzzle. SPL_LOAD_FIT i=
s
> > > how I see the use case you talk about being solved, if a full U-Boot =
is
> > > generic enough for N boards, SPL_LOAD_FIT does the right thing (in th=
is
> > > non-bloblist DTB, non-reusing-OS-inntended DTB world). I really don't
> > > knnow how many modern SoCs can take a literal concatenated DTB and ev=
en
> > > in those cases I don't get why that's the win we want now? 1 build to=
 N
> > > binaries?
>=20
> Yes SPL_LOAD_FIT is fine although in practice we will likely need SPL
> to use the correct DT as well, so the DT will need to be determined in
> TPL, perhaps.

I mean, SPL_LOAD_FIT still can handle this case, with a call to the
function to re-parse the tree, when needed. I thought we did this today
even, but perhaps I'm confusing my options here.

> But anyway, this works OK with rk3399, for example. We need to support
> this use case.
>=20
> Also, it is pretty easy. We just need to stick with the dir structure
> we have today and copy our existing Makefiles into that dir. Or change
> to the kernel dir structure and use that. Or do one, then the other.

I'm sorry, I don't understand what directory structure has to do with
"build more dtbs". For the cases where it makes sense to, yes, we can
build more dtbs, based on the SoC. I'm setting aside entirely the
discussion on what SoCs that works for, for another thread.

Perhaps an issue here is that much like the kernel "install" target, we
need an "install" target too, so that whatever dtbs we build can be
more easily found for external packaging, but whatever tooling it is
that wants it? And perhaps this is part of the problem, tooling that
expects to pull things out of the object directory rather than an
"installed" directory?

> > > But even then, I don't object to adding those rules to the Makefiles.=
 If
> > > it works it works. I object to adding them when they don't work.
>=20
> What do you mean by 'work'? With this series as is, it simply isn't
> possible to add Makefile rules, as they are ignored. Am I missing
> something?

Yes, I think you're missing something. Perhaps you need to publish a WIP
tree somewhere so someone can see what you're doing as it sounds like
you're not able to add another SoC of any type on top of Sumit's tree
and have it work.

--=20
Tom

--Groupsio=6xwsB0vUYSZ6Iu3j3hKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWTTEoACgkQFHw5/5Y0
tywONgwAt4KM2wfCsJhP8H11rLNj5e6NRKp0YOpXZBvJktwksDEJ6FgbmCsC8EmO
xQSzVLcChW2IlBUnBTQVlxMkhOK/KYsCkk/3hKnTwcYjHlCYLXHaKO1v60wPlMpa
RaLceGUx/Sknoka/Mc2sL1F23Y+qfugvrORyFwzxuG9VlA+9Dnc9kvIk0Wc6x8Mk
vpYZugHVjiFwHd489Ok+S/qM0cdpP3nLwQM+V3iurXF+Ou2P/YTNBbPCq1XPu6Su
WkXNCvnI2IoxyR1zefkkeuT9xu8NYi9lf2lzZvG0jv4y1+WHIfV6zLHJE6XkdMFz
LOa9aMqC/fZNZVSuhdzZjb22gVvfgn4378AjcwzA50YDxuUrNNid0NLFhoahTZuP
xYCZHVubkkZyQxyv4BSOOJxEjGPFS5LbVGe4S700xT3L4NLELIzRRsAYqcEvvamf
QVzCJJtuBvJKFgDD72jA8YVyO2KPTb8RDDFUjv4qH5qm8FLJALeNEBUrmCP4VZm9
MfAFbPWE
=LeNe
-----END PGP SIGNATURE-----

--Groupsio=6xwsB0vUYSZ6Iu3j3hKK--

