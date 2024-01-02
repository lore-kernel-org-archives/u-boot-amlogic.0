Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DBC47073
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
 by mx.groups.io with SMTP id smtpd.web11.31515.1704209881846524598
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 07:38:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CpuveIRJ;
 spf=pass (domain: linaro.org, ip: 209.85.222.42, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7cbe98278f8so2613325241.1
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704209881; x=1704814681; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSGeSP4F5N7dZ/ALWuM1yEcNrAsfThBJjwK53fdyhBo=;
        b=CpuveIRJeviBVlDZmNh+jPuwrgjp1CrlQ8I5xOOksNq3NTw9EXRaerW14JT0IEhJyK
         1gQWT7AyJw/bGFzOWycubEzSHHbfQ4kq60ybwtOvXwx786+YKlbiz4yEVze688txk3/m
         Vg+7qwJ8cZB6RcfajZqNNEQol/6jWZMwoXkgGiBjAGdXSzSzwOvSKwQnMiRnVb8cmVSU
         Q858xehi8Bhim1CBsl841hJpSgpCDwlq8Uj+oyY+BvPAWIjWz4eZdw1WnH4nZikcXQhk
         8GiEToSTLmAEfUguzhmbdYG7gZamsbC3/AAbvA+dZpAgVfhjGYXBvPYRqLTwXJtdLk5K
         oNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209881; x=1704814681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSGeSP4F5N7dZ/ALWuM1yEcNrAsfThBJjwK53fdyhBo=;
        b=kEv+2FadPrIEINQZUtopUyl7S0k8uHPSVmSlGr5eyog68tihVMwmaeXkX1VQEMjuyk
         BASSDKp5a5pPi3PuPuPTrFXRyeXgypZfqLyAbCaGp3J1DjthfXMWcdIDY40pgv0dcu9p
         EJcAANRY6XgYnOWeKloY/oRk9RE22Hu5l/1c5f9NNY2qQRRVgI5EyDNWkCCzSlMb9t07
         yDa+/80qXZaRcwq9Z0Ox5/U7i126lrgPEB6tvBadLhOSzT/S3jCfRg8RBa/N0zrLq/di
         BNQfVVfse2fLfzuBT4kOO9AdFzdiNSB6/f36sBuyqTSQ6X4SvEgIc7Ao/b/8qyGdcYEh
         WRxQ==
X-Gm-Message-State: AOJu0Yx4nbCdKMDi20qp/LS/FJpPPNBoBtyB85K/cQlgv+FPa67JJHFH
	VaWXaAvzJXGyR3ruQh8FwzvM5tUczTQYo9dGrPY0B2Ctuw/C1g==
X-Google-Smtp-Source: AGHT+IHqaAAULjgBCSE9bIf+WlZtqaSAd6LuKArcyHLrMfUwoNK051wFd8Q+HNXmfvjddhgRwevh7KrLkX/JxX7XPoc=
X-Received: by 2002:a05:6102:3e12:b0:466:ff2d:6c0b with SMTP id
 j18-20020a0561023e1200b00466ff2d6c0bmr7401542vsv.11.1704209880379; Tue, 02
 Jan 2024 07:38:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat> <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
In-Reply-To: <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 2 Jan 2024 21:07:48 +0530
Message-ID: <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2022

On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
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
>
> OK
>
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
>
> So you are saying that U-Boot should move to what Linux uses. I agree
> that seems like the best approach, so let's do it.
>
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
>
> Well you said above that we should switch to the kernel dir structure,
> so I believe that issue is resolved.
>
> 'build more dtbs' means build all the DTBs for an SoC, not just a
> selection that a particular board vendor decided on.
>
> >
> > Perhaps an issue here is that much like the kernel "install" target, we
> > need an "install" target too, so that whatever dtbs we build can be
> > more easily found for external packaging, but whatever tooling it is
> > that wants it? And perhaps this is part of the problem, tooling that
> > expects to pull things out of the object directory rather than an
> > "installed" directory?
>
> This is where binman comes in. It can run as part of U-Boot build, to
> build a few default firmware images. Then it can be run *later*,
> outside the U-Boot build, with an augmented or more targeted image
> definition, with mostly the same input files, to pull together images
> for specific uses. As you say, the input files need to be in a defined
> location, which they are today, for the most part.
>
> So even if a particular board only uses one DT, all the DTs for that
> SoC are built and so can be used in that final-packaging step. Without
> that build, there is no way to get the required .dtb files, other than
> building every board one by one and then pulling out the .dtb files or
> something weird like that.
>
> Note that this works independently of whether OF_LIST is used, etc.
>
> >
> > > > > But even then, I don't object to adding those rules to the Makefi=
les. If
> > > > > it works it works. I object to adding them when they don't work.
> > >
> > > What do you mean by 'work'? With this series as is, it simply isn't
> > > possible to add Makefile rules, as they are ignored. Am I missing
> > > something?

That's not correct. Just to demonstrate this I have gone a step
further to switch all Amlogic SoCs to use DT rebasing tree here [1].
As I have said before, the Makefile rules were just dropped based on
Tom's feedback. However, if they really serve the existing tools from
a packaging perspective I am open to migrate them as demonstrated here
[2]. As before it will build all the DTBs corresponding to all the
Amlogic SoCs supported in U-Boot for a single board defconfig.

[1] https://github.com/b49020/u-boot/commits/dt_for_test/
[2] https://github.com/b49020/u-boot/commit/ca5525673cdcafd71b51b48fe33c076=
f97a287fe

> >
> > Yes, I think you're missing something. Perhaps you need to publish a WI=
P
> > tree somewhere so someone can see what you're doing as it sounds like
> > you're not able to add another SoC of any type on top of Sumit's tree
> > and have it work.
>
> The current -next source builds dtb files based on the SoC, for the
> most part. I sent a series to clean that up a bit[1], but it is mostly
> there.
>
> From the above it seems like the plan could be:
> 1. Move arm64 .dts files to arch/arm64/dts/<vendor>/... and adjust
> Makefiles accordingly

As I said before it will be a redundant effort when you can just drop
them in favour of dts/arch/arm64/<vendor>/.. We just have to maintain
the *-u-boot.dtsi file in arch/*/dts/.

> 2. Choose a directory target for devicetree-rebasing. I see that
> 'barebox' uses 'dts' which seems better to me than
> 'devicetree-rebasing/src/'.

Actually as part of this patch-set we try to reuse the U-Boot 'dts'
directory (via dts/arch/arm64/<vendor> soft links) since it was
already taken for U-Boot specific DT Makefile. However, I am open to
renaming 'devicetree-rebasing' but to me that sounds more clear that
we maintain a specific subtree within U-Boot.

> Actually barebox even seems to have
> scripts for handling all of this [2]??

That script is just doing the same thing as the DTC import script. git
subtree is just another standardized way to do it.

[1] https://www.barebox.org/doc/latest/devicetree/index.html#barebox-device=
-trees

> 3. Adjust the build system to use the dts/ directory for .dts files
> when OF_UPSTREAM is enabled
>
> Then it will be easy. People can enable OF_UPSTREAM for an SoC
> (without changing DEFAULT_DEVICE_TREE)

I am still not sure what we will gain via keeping DEFAULT_DEVICE_TREE
the same. However, without a per vendor directory Makefile like:
dts/arch/arm64/<vendor>/Makefile it won't be possible. But to do that
we won't be able to softlink vendor directories from DT rebasing tree
but rather have to softlink every board DTS file which is much more
painful.

> and will get the same behaviour
> as now, just with upstream .dts files. All the .dts files for an SoC
> are built, as now, just as Linux does. We can continue cleaning up the
> DT build rules as time permits.

I will reiterate here, we can decide to add Makefile rules on a case
by case basis. If there is a need (from packaging perspective or a
particular SoC supports a generic U-Boot image) then we should be able
to add them. The cleanup would be automatically part of the process as
we switch SoCs to OF_UPSTREAM.

-Sumit

>
> Regards,
> Simon
>
> [1] http://patchwork.ozlabs.org/project/uboot/list/?series=3D388154
> [2] https://git.pengutronix.de/cgit/barebox/tree/dts

