Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4416C47DBA
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:32 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.2209.1704239666652543866
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 15:54:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=YX6rdi8V;
 spf=pass (domain: chromium.org, ip: 209.85.222.170, mailfrom: sjg@chromium.org)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-781599b8f3cso510064985a.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 15:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704239666; x=1704844466; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOVmsZ12RL5L5S09kR9KI+a1KBOqtnu8mqDdOsMqsbs=;
        b=YX6rdi8VvDOYEgw3PbdeMtM8CgsiQYB4DpUIHkDxXhaoCzadTuvAgseit9DzqisYxn
         cegxZf8VU7LzWqXltck3Zpx5jjLdMcXBM4vi7VTQTnJrb1UDuF+IlYl76SXpg9n6LDNR
         CqOEemO+VTZFFsge4SGAMhxthwM744AAmSrik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704239666; x=1704844466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOVmsZ12RL5L5S09kR9KI+a1KBOqtnu8mqDdOsMqsbs=;
        b=DUySeLhGLXLy3s6tF+JUMQZHvK5dUNlPw4fxxVJrGY3oOBCdWnaBK4ou/2AvERPmD/
         A95eSDXqHvX4cVDdnM2A9squrz56noSSIv2n3MZo8FPs0jFJXpAFm/rWuOApOAcHXss9
         B/SoOPgAoljRb1+9mptexEKHX96e7dwoIVSTCWI8CZeeQDDIyXiDrn0H+ZKUFW6eRPUq
         W8YU3OYNbsQMbDKqIqOiwRW8pg2Qq5lAOkft6RF91ErlEhT6wDAdve0+sjuETz+0uNoc
         qfTv9D/rBJ8SjCyanyJfteD+CyG7sa+FVrPA9/Lz/X+IIePLcdhmGeMXOhHSBlWTBdQz
         yeiQ==
X-Gm-Message-State: AOJu0YwWNGxVIWe/Fi0Dc/Pr6iA+VMitsYR42OngjM+ZM30wDWqSa/sJ
	D4+gLqRyScqCPThfr1Xf4qCXk8u4mGxBsbP/kE5+TA/0UAay
X-Google-Smtp-Source: AGHT+IFVaySy6ry1MJscV+1Bj0aLi4E1ZB0rQP2RDdGY/FfwR1qIPbXyzzfGb+j8Wg4GD5xAOp+DpC7T+2/kL3kVrP0=
X-Received: by 2002:a05:620a:4309:b0:781:bd80:afba with SMTP id
 u9-20020a05620a430900b00781bd80afbamr5079341qko.51.1704239665667; Tue, 02 Jan
 2024 15:54:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat> <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <20240102151046.GL2652760@bill-the-cat>
In-Reply-To: <20240102151046.GL2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 16:54:15 -0700
Message-ID: <CAFLszThysDjASn4U7CpBmmp4axjE-CrFk1x6TLhLpmVicpwGbQ@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2024

Hi Tom,

On Tue, Jan 2, 2024 at 8:10=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 07:06:40AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, Jan 1, 2024 at 4:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Mon, Jan 01, 2024 at 03:32:41PM -0700, Simon Glass wrote:
> > > > Hi Mark, Tom,
> > > >
> > > > On Sun, Dec 31, 2023 at 5:33=E2=80=AFPM Mark Kettenis <mark.ketteni=
s@xs4all.nl> wrote:
> > > > >
> > > > > > Date: Sun, 31 Dec 2023 15:39:53 -0500
> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote:
> > > > > > > Hi Sumit,
> > > > > > >
> > > > > > > On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit.gar=
g@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom, Sumit,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Sumit,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Ga=
rg <sumit.garg@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Allow platform owners to mirror devicetree file=
s from devitree-rebasing
> > > > > > > > > > > > > > directory into dts/arch/$(ARCH) (special case f=
or dts/arch/arm64). Then
> > > > > > > > > > > > > > build then along with any *-u-boot.dtsi file pr=
esent in arch/$(ARCH)/dts
> > > > > > > > > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This will help easy migration for platforms whi=
ch currently are compliant
> > > > > > > > > > > > > > with upstream Linux kernel devicetree files.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.or=
g>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Changes in v3:
> > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > - Minor commit message update
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot=
/
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > > > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > > > > > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > > > > > > > > >  3 files changed, 39 insertions(+), 3 deletions=
(-)
> > > > > > > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > > > > > > >           enables a live tree which is availabl=
e after relocation,
> > > > > > > > > > > > > >           and can be adjusted as needed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > > > > > > +       bool "Enable use of devicetree imported=
 from Linux kernel release"
> > > > > > > > > > > > > > +       help
> > > > > > > > > > > > > > +         Traditionally, U-Boot platforms used =
to have their custom devicetree
> > > > > > > > > > > > > > +         files or copy devicetree files from L=
inux kernel which are hard to
> > > > > > > > > > > > > > +         maintain and can usually get out-of-s=
ync from Linux kernel. This
> > > > > > > > > > > > > > +         option enables platforms to migrate t=
o devicetree-rebasing repo where
> > > > > > > > > > > > > > +         a regular sync will be maintained eve=
ry major Linux kernel release
> > > > > > > > > > > > > > +         cycle. However, platforms can still h=
ave some custom u-boot specific
> > > > > > > > > > > > > > +         bits maintained as part of *-u-boot.d=
tsi files.
> > > > > > > > > > > > >
> > > > > > > > > > > > > My only other suggestion here is to mention that =
this should be set in
> > > > > > > > > > > > > Kconfig, for the SoC as a whole. So I believe tha=
t means that it
> > > > > > > > > > > > > should be hidden, with no string for the 'bool':
> > > > > > > > > > > > >
> > > > > > > > > > > > >       bool  # Enable use of devicetree imported f=
rom Linux kernel release
> > > > > > > > > > > >
> > > > > > > > > > > > I think we can just keep prompting for it now, to m=
ake the transition
> > > > > > > > > > > > easier, before this option just goes away in time, =
hopefully.
> > > > > > > > > > > >
> > > > > > > > > > > > > Also, this doesn't seem to work for me. Before th=
is series I get these
> > > > > > > > > > > > > files when building firefly-rk3399:
> > > > > > > > > > > > >
> > > > > > > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edg=
e-v.dtb
> > > > > > > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > > > > > > > > > rk3399-evb.dtb                  rk3399-leez-p710.=
dtb
> > > > > > > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > > > > > > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.=
dtb
> > > > > > > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > > > > > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-=
2gb.dtb
> > > > > > > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b=
.dtb
> > > > > > > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanin=
e.dtb
> > > > > > > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.=
dtb
> > > > > > > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo=
4.dtb    rk3399-rock-4se.dtb
> > > > > > > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s=
.dtb     rk3399-rock960.dtb
> > > > > > > > > > > > >
> > > > > > > > > > > > > Afterwards I get this:
> > > > > > > > > > > > >
> > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'd=
tbs'.  Stop.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So I set this manually for that one board:
> > > > > > > > > > > > >
> > > > > > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-fir=
efly"
> > > > > > > > > > > > >
> > > > > > > > > > > > > and get:
> > > > > > > > > > > > >
> > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', nee=
ded by 'dtbs'.  Stop.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I am not sure how to fix this, nor how this can b=
e made to build all
> > > > > > > > > > > > > the DTs for rk3399, as it does today.
> > > > > > > > > > > >
> > > > > > > > > > > > Looking at the patch for amlogic boards, you need t=
o make the link to
> > > > > > > > > > > > devicetree-rebasing inside dts/...
> > > > > > > > > > >
> > > > > > > > > > > OK, let me give up on rk3399 for now...that doesn't s=
eem to work even
> > > > > > > > > > > with the link.
> > > > > > > > > > >
> > > > > > > > > > > Using odroid-c2 with -next I see:
> > > > > > > > > > >
> > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > meson-a1-ad401.dtb                 meson-g12b-odroid-=
n2l.dtb
> > > > > > > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-=
n2-plus.dtb
> > > > > > > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > > > > > > meson-axg-s400.dtb                 meson-g12b-radxa-z=
ero2.dtb
> > > > > > > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro=
.dtb
> > > > > > > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > > > > > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-=
k2.dtb
> > > > > > > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > > > > > > meson-g12a-u200.dtb                meson-gxbb-odroidc=
2.dtb
> > > > > > > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dt=
b
> > > > > > > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dt=
b
> > > > > > > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-h=
ub.dtb
> > > > > > > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-p=
lay2.dtb
> > > > > > > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > > > > > > meson-g12b-gtking.dtb              meson-gxl-s805x-li=
bretech-ac.dtb
> > > > > > > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-li=
bretech-pc.dtb
> > > > > > > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei=
610.dtb
> > > > > > > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-kh=
adas-vim.dtb
> > > > > > > > > > > $
> > > > > > > > > > > With this series (sort of, since I am really not sure=
 how to
> > > > > > > > > > > cherry-pick the commits from the PR) I see nothing:
> > > > > > > > > > >
> > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > $
> > > > > > > > > > >
> > > > > > > > > > > This shows some of the files:
> > > > > > > > > > >
> > > > > > > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-od=
roidc2.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-na=
nopi-k2.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-we=
tek-play2.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-ki=
i-pro.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p2=
00.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p2=
01.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-we=
tek-hub.dtb
> > > > > > > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > > > > > > >
> > > > > > > > > > > but where are the rest? Also, is it possible to put t=
he output .dtb
> > > > > > > > > > > files into the same directory? Otherwise we may have =
some pain with
> > > > > > > > > > > binman.
> > > > > > > > > >
> > > > > > > > > > What do you mean by same directory? But maybe also, wha=
t's an example of
> > > > > > > > > > a board you think might end up having problems? Convert=
ing that in a
> > > > > > > > > > follow-up series is likely a good idea, to highlight an=
d address these
> > > > > > > > > > issues sooner rather than later.#
> > > > > > > > >
> > > > > > > > > Today the .dtb files go into arch/arm/dts - so it would b=
e easier if
> > > > > > > > > this series could do the same.
> > > > > > > >
> > > > > > > > The kbuild infrastructure keeps the dtb alongside dts files=
 which is
> > > > > > > > the preferred way too as otherwise it would be complicated =
to locate
> > > > > > > > DT files for the users. Also, we have to move towards Linux=
 DT
> > > > > > > > directory structure and thereby the tools like binman have =
to be
> > > > > > > > adjusted. I will do that when I get to migrating SoCs suppo=
rting
> > > > > > > > binman.
> > > > > > >
> > > > > > > OK, I want to stop here and rethink this. This is the path ta=
ken so
> > > > > > > far, I believe:
> > > > > > >
> > > > > > > 1. We want to use devicetree files taken from Linux and
> > > > > > > devicetree-rebasing provides these
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > 2. We want to use 'git subtree' to avoid needing a script to =
do the
> > > > > > > sync / create a commit
> > > > > >
> > > > > > No. We want to use 'git subtree' to avoid having to use git sub=
modules.
> > > >
> > > > Well that is what I understood from Sumit, when I asked about a
> > > > script. I imagine a 100-line Python script could do the same as:
> > > >
> > > >    git subtree pull --prefix devicetree-rebasing
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree=
-rebasing.git
> > > > <release-tag> --squash
> > > >
> > > > and it could also put the files in the right place for U-Boot.
> > >
> > > I've been saying in various places for years that I want to move away
> > > from arch/*/dts being where we have the "just a copy" dts files and h=
ave
> > > them somewhere else so they are easier to manage and differentiate ou=
r
> > > changes / additions. So arch/*/dts cannot be some hard-coded "right"
> > > path.
> >
> > OK
> >
> > >
> > > > > > > 3. But this leaves us with a directory structure which doesn'=
t match
> > > > > > > U-Boot (no script to fix it up)
> > > > > >
> > > > > > No. We intentionally abandon arch/*/dts because it's so full of
> > > > > > out of date files and never fully re-synced, only re-synced ad-=
hoc.
> > > >
> > > > I mean that the dir structure doesn't match. I am not worried about
> > > > keeping arch/*/dts but I want the same structure somewhere else, e.=
g.
> > > > dtr/arch/*/dts
> > >
> > > And what I want here is to match the same structure everyone that's n=
ot
> > > U-Boot uses. For better or worse no one else seems to have gone with
> > > "treat aarch64 as just another ARM", and then the vendor directory
> > > structure only makes that more obviously a mismatch. We need to follo=
w
> > > what everyone else uses, and developers familiar with other projects
> > > will expect to see.
> >
> > So you are saying that U-Boot should move to what Linux uses. I agree
> > that seems like the best approach, so let's do it.
> >
> > >
> > > > > > > 4. So we deal with that by skipping the build rules and using=
 CONFIG
> > > > > > > options to select what is built
> > > > > > > 5. So now we cannot build all the files for an SoC, just the =
ones that
> > > > > > > are in the CONFIG options
> > > > > > > 6. Linux doesn't actually use devicetree-rebasing itself, so =
doesn't
> > > > > > > have this problem
> > > > > >
> > > > > > No. devicetree-rebasing skips the Makefiles because they're par=
t of the
> > > > > > kernel. We couldn't re-use them ourselves because we don't have=
 the same
> > > > > > CONFIG names the kernel does. And Sumit has not replicated the =
logic we
> > > > > > have under arch/*/dts/Makefile today because I've asked him not=
 to, and
> > > > > > we'll figure out what subsets of that logic make sense to add b=
ack in as
> > > > > > a second step not a first step.
> > > >
> > > > Again, you are missing my point. I am not suggesting using Linux's
> > > > build rules, just explaining why Linux doesn't have the problem we
> > > > would be creating here.
> > > >
> > > > > > > So this is heading in the wrong direction. Nor is it clear th=
at this
> > > > > > > would just be a temporary problem.
> > > > > >
> > > > > > A previous iteration of this series built all of the dtb files =
for the
> > > > > > SoC that Sumit has migrated with this series, but then dropped =
it.
> > > >
> > > > Oh.
> > > >
> > > > > >
> > > > > > [snip]
> > > > > > > I would like to do this series properly, maintaining the SoC-=
specific
> > > > > > > build rules, not removing what I see as an important feature.=
 It
> > > > > > > should not be that difficult to figure out and I am happy to =
help with
> > > > > > > it.
> > > > > >
> > > > > > The problem is that the rest of us do not understand the use ca=
se you're
> > > > > > describing where a dtb file that would be useful in a build is =
not
> > > > > > already in the list to build. The only one of those use cases I
> > > > > > understand thus far is the exynos4 (iirc) case you mentioned pr=
eviously
> > > > > > where yes, really, one defconfig + appending board.dtb is fine,=
 or fine
> > > > > > enough. It's not that far off of the SPL_LOAD_FIT case, but the=
re we
> > > > > > know what to build already.
> > > >
> > > > Perhaps the problem is that the rest of you think of the build as a=
ll
> > > > happening in U-Boot, similar to the proposed 'make image.fit' that =
I
> > > > am trying to add to Linux.
> > > >
> > > > But packaging can be (and often is) a separate step from building.
> > > > Linux has no packaging mechanism today...it just builds everything
> > > > (including all DTs) and stops.
> > > >
> > > > We should be able to pick up whatever .dtb files we want and use th=
em
> > > > in an image.
> > > >
> > > > > > And I guess trying to tie things up, that's my puzzle. SPL_LOAD=
_FIT is
> > > > > > how I see the use case you talk about being solved, if a full U=
-Boot is
> > > > > > generic enough for N boards, SPL_LOAD_FIT does the right thing =
(in this
> > > > > > non-bloblist DTB, non-reusing-OS-inntended DTB world). I really=
 don't
> > > > > > knnow how many modern SoCs can take a literal concatenated DTB =
and even
> > > > > > in those cases I don't get why that's the win we want now? 1 bu=
ild to N
> > > > > > binaries?
> > > >
> > > > Yes SPL_LOAD_FIT is fine although in practice we will likely need S=
PL
> > > > to use the correct DT as well, so the DT will need to be determined=
 in
> > > > TPL, perhaps.
> > >
> > > I mean, SPL_LOAD_FIT still can handle this case, with a call to the
> > > function to re-parse the tree, when needed. I thought we did this tod=
ay
> > > even, but perhaps I'm confusing my options here.
> > >
> > > > But anyway, this works OK with rk3399, for example. We need to supp=
ort
> > > > this use case.
> > > >
> > > > Also, it is pretty easy. We just need to stick with the dir structu=
re
> > > > we have today and copy our existing Makefiles into that dir. Or cha=
nge
> > > > to the kernel dir structure and use that. Or do one, then the other=
.
> > >
> > > I'm sorry, I don't understand what directory structure has to do with
> > > "build more dtbs". For the cases where it makes sense to, yes, we can
> > > build more dtbs, based on the SoC. I'm setting aside entirely the
> > > discussion on what SoCs that works for, for another thread.
> >
> > Well you said above that we should switch to the kernel dir structure,
> > so I believe that issue is resolved.
> >
> > 'build more dtbs' means build all the DTBs for an SoC, not just a
> > selection that a particular board vendor decided on.
>
> Yes, what other dtbs to build is the sticking point, in a number of
> threads now.

All of the ones for the SoC.

>
> > > Perhaps an issue here is that much like the kernel "install" target, =
we
> > > need an "install" target too, so that whatever dtbs we build can be
> > > more easily found for external packaging, but whatever tooling it is
> > > that wants it? And perhaps this is part of the problem, tooling that
> > > expects to pull things out of the object directory rather than an
> > > "installed" directory?
> >
> > This is where binman comes in. It can run as part of U-Boot build, to
> > build a few default firmware images. Then it can be run *later*,
> > outside the U-Boot build, with an augmented or more targeted image
> > definition, with mostly the same input files, to pull together images
> > for specific uses. As you say, the input files need to be in a defined
> > location, which they are today, for the most part.
> >
> > So even if a particular board only uses one DT, all the DTs for that
> > SoC are built and so can be used in that final-packaging step. Without
> > that build, there is no way to get the required .dtb files, other than
> > building every board one by one and then pulling out the .dtb files or
> > something weird like that.
> >
> > Note that this works independently of whether OF_LIST is used, etc.
>
> How about this. When you introduce generic-rk3399_defconfig is when we
> can also have dts-$(CONFIG_ROCKCHIP_RK3399) list everything, and insist
> it be kept up to date. That to me feels like the right order to go in.
> And we can have all of the implementation details be hashed out
> elsewhere, not in the thread about fixing our nightmare about dts file
> resync.

So long as Sumit can put it back so we can use build rules, that's
fine. But removing the build rules is the sticking point for me.

>
> > > > > > But even then, I don't object to adding those rules to the Make=
files. If
> > > > > > it works it works. I object to adding them when they don't work=
.
> > > >
> > > > What do you mean by 'work'? With this series as is, it simply isn't
> > > > possible to add Makefile rules, as they are ignored. Am I missing
> > > > something?
> > >
> > > Yes, I think you're missing something. Perhaps you need to publish a =
WIP
> > > tree somewhere so someone can see what you're doing as it sounds like
> > > you're not able to add another SoC of any type on top of Sumit's tree
> > > and have it work.
> >
> > The current -next source builds dtb files based on the SoC, for the
> > most part. I sent a series to clean that up a bit[1], but it is mostly
> > there.
>
> Yes, and that relied on Rasmus' series having been merged ages ago which
> fixed up a number of "people just copypasta'd something here,
> incorrectly".  Keep that in mind as part of why I have objections here.

OK.

>
> >
> > From the above it seems like the plan could be:
> > 1. Move arm64 .dts files to arch/arm64/dts/<vendor>/... and adjust
> > Makefiles accordingly
>
> Since we're going to move everyone to being from the upstream kernel,
> that seems like unneeded churn.

What is the timeline for that move?

We are talking about 1700 lines of Makefies and I already made a good
start on part of it. So if we are going to be a few months with two
different paths, fine, but this is going to drag on for a year, I
would rather clean it up now and have a unified path for both sets of
DTs.

>
> > 2. Choose a directory target for devicetree-rebasing. I see that
> > 'barebox' uses 'dts' which seems better to me than
> > 'devicetree-rebasing/src/'. Actually barebox even seems to have
> > scripts for handling all of this [2]??
>
> They've been doing this since longer than git subtree has existed I
> believe. I suspect that much like how Rob would like to move the
> in-kernel devicetree compiler sync from a script to git subtree, barebox
> will too.

Maybe, although the first barebox dts/ commit was 2014 and subtree is
claimed to come out in 2012...but then devicetree-rebasing might be
newer, which would explain why they have 'git filter-branch' stuff in
the script.

I thought devicetree-rebasing came from Linux. Is it its own repo? So
what is the DT upstream these days??

If subtree does what we want without making U-Boot look like
Franekstein's monster, that's fine. But I don't mind having a script.

>
> > 3. Adjust the build system to use the dts/ directory for .dts files
> > when OF_UPSTREAM is enabled
> >
> > Then it will be easy. People can enable OF_UPSTREAM for an SoC
> > (without changing DEFAULT_DEVICE_TREE) and will get the same behaviour
> > as now, just with upstream .dts files. All the .dts files for an SoC
> > are built, as now, just as Linux does. We can continue cleaning up the
> > DT build rules as time permits.
>
> Maybe the unasked / unanswered question here is, why don't we put the
> subtree in to dts/ ? Just because it would make us more likely to make
> changes rather than treat it as read only?

It is an easy checkpatch check, if that is your only concern.

Regards,
Simon

