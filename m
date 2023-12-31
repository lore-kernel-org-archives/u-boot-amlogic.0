Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983DC47DB0
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.220857.1704032944112988537
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Dec 2023 06:29:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=bTHdE8VL;
 spf=pass (domain: chromium.org, ip: 209.85.219.48, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-680b1a2c966so1255306d6.3
        for <u-boot-amlogic@groups.io>; Sun, 31 Dec 2023 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704032943; x=1704637743; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv7DZty0SDcsSVyWLvPzg+7U+e0WwCsE/Ya66yJjvjE=;
        b=bTHdE8VL7ufIcnQYKAmdIjyc00ResVugF9vdsAqhCxHMcZdJNjyZqlMVDYOy0KlaJj
         hlDx8pdBOl8Xm50tk9K+uulx4/EZPQkt3Qj0xe11GyZMXAZPH/MDPLkYTIZd6yrHV5yM
         /j+asJUubKsGRngKIb7P59KXPOm8XKIyq1u8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704032943; x=1704637743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv7DZty0SDcsSVyWLvPzg+7U+e0WwCsE/Ya66yJjvjE=;
        b=xEJS7DxjhDVvTmnm73Uzks7hCUyMOArrE9LSv/kYh1lkleO/XYhnB7rGZjkOUob6El
         JxwI/hRFDjU/b03m3Rer9QwsthmIJ2PDN0+j1Xn5KCwo3ePuYq9kbUH+mCL5kDQD7GNe
         03GmAcHbdveQ0LeOG/3ORD+YcMQ5f5mBAirGZYvrI20Ykq6t5HGSxXfaUD/dlRedXbt3
         n5a+MrW70sVD9iJpYlCVx7O78FjnAyyv7xUy7q1eUfsN2ixbjuSgVR6xwRTs5IUKMN/Y
         OTSd13YpMkOkpKMcuFazKcybQnX/Ge7L6Xw8Kv8poiky8DcVy4ceYJnpMz9XRc+D0Hj6
         12uw==
X-Gm-Message-State: AOJu0YxIkepH4pYG9+uwXeInd3iW/aUftoulS5wHQZBvWjFuBe4JAKue
	JjsArM/7PrKsHDX5r0ZnZVk9H4U4tOQyRgsCM0LcsjWpb3NE
X-Google-Smtp-Source: AGHT+IHrnK2Phqwe62iauL+8GEjvMh2pHWDTJj7EfQKDrzJaED8YWpSlFw3npsl/saSNqDVg1+NNhRK97grvk0BhT1g=
X-Received: by 2002:ad4:5946:0:b0:680:b0f1:a952 with SMTP id
 eo6-20020ad45946000000b00680b0f1a952mr723804qvb.85.1704032943144; Sun, 31 Dec
 2023 06:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org> <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
In-Reply-To: <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 07:28:52 -0700
Message-ID: <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2013

Hi Sumit,

On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> > > > Hi Tom, Sumit,
> > > >
> > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg=
@linaro.org> wrote:
> > > > > > >
> > > > > > > Allow platform owners to mirror devicetree files from devitre=
e-rebasing
> > > > > > > directory into dts/arch/$(ARCH) (special case for dts/arch/ar=
m64). Then
> > > > > > > build then along with any *-u-boot.dtsi file present in arch/=
$(ARCH)/dts
> > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > >
> > > > > > > This will help easy migration for platforms which currently a=
re compliant
> > > > > > > with upstream Linux kernel devicetree files.
> > > > > > >
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > --------------
> > > > > > > - Minor commit message update
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > --------------
> > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > > > >
> > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > >
> > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > --- a/dts/Kconfig
> > > > > > > +++ b/dts/Kconfig
> > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > >           enables a live tree which is available after reloca=
tion,
> > > > > > >           and can be adjusted as needed.
> > > > > > >
> > > > > > > +config OF_UPSTREAM
> > > > > > > +       bool "Enable use of devicetree imported from Linux ke=
rnel release"
> > > > > > > +       help
> > > > > > > +         Traditionally, U-Boot platforms used to have their =
custom devicetree
> > > > > > > +         files or copy devicetree files from Linux kernel wh=
ich are hard to
> > > > > > > +         maintain and can usually get out-of-sync from Linux=
 kernel. This
> > > > > > > +         option enables platforms to migrate to devicetree-r=
ebasing repo where
> > > > > > > +         a regular sync will be maintained every major Linux=
 kernel release
> > > > > > > +         cycle. However, platforms can still have some custo=
m u-boot specific
> > > > > > > +         bits maintained as part of *-u-boot.dtsi files.
> > > > > >
> > > > > > My only other suggestion here is to mention that this should be=
 set in
> > > > > > Kconfig, for the SoC as a whole. So I believe that means that i=
t
> > > > > > should be hidden, with no string for the 'bool':
> > > > > >
> > > > > >       bool  # Enable use of devicetree imported from Linux kern=
el release
> > > > >
> > > > > I think we can just keep prompting for it now, to make the transi=
tion
> > > > > easier, before this option just goes away in time, hopefully.
> > > > >
> > > > > > Also, this doesn't seem to work for me. Before this series I ge=
t these
> > > > > > files when building firefly-rk3399:
> > > > > >
> > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > > > > rk3399-rock-4c-plus.dtb
> > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk339=
9-rock-4se.dtb
> > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk339=
9-rock960.dtb
> > > > > >
> > > > > > Afterwards I get this:
> > > > > >
> > > > > > make[3]: *** No rule to make target
> > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > > > > >
> > > > > > So I set this manually for that one board:
> > > > > >
> > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > > > > >
> > > > > > and get:
> > > > > >
> > > > > > make[3]: *** No rule to make target
> > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.=
  Stop.
> > > > > >
> > > > > > I am not sure how to fix this, nor how this can be made to buil=
d all
> > > > > > the DTs for rk3399, as it does today.
> > > > >
> > > > > Looking at the patch for amlogic boards, you need to make the lin=
k to
> > > > > devicetree-rebasing inside dts/...
> > > >
> > > > OK, let me give up on rk3399 for now...that doesn't seem to work ev=
en
> > > > with the link.
> > > >
> > > > Using odroid-c2 with -next I see:
> > > >
> > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
> > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
> > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
> > > >     meson-gxl-s905x-p212.dtb
> > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
> > > >     meson-gxm-gt1-ultimate.dtb
> > > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
> > > >     meson-gxm-khadas-vim2.dtb
> > > > meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
> > > >     meson-gxm-s912-libretech-pc.dtb
> > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> > > >     meson-gxm-wetek-core2.dtb
> > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
> > > >     meson-sm1-bananapi-m5.dtb
> > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
> > > >     meson-sm1-khadas-vim3l.dtb
> > > > meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
> > > >     meson-sm1-odroid-c4.dtb
> > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
> > > >     meson-sm1-odroid-hc4.dtb
> > > > meson-g12b-odroid-go-ultra.dtb
> > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
> > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
> > > > $
> > > > With this series (sort of, since I am really not sure how to
> > > > cherry-pick the commits from the PR) I see nothing:
> > > >
> > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > $
> > > >
> > > > This shows some of the files:
> > > >
> > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
> > > > /tmp/b/odroid-c2/u-boot.dtb
> > > >
> > > > but where are the rest? Also, is it possible to put the output .dtb
> > > > files into the same directory? Otherwise we may have some pain with
> > > > binman.
> > >
> > > What do you mean by same directory? But maybe also, what's an example=
 of
> > > a board you think might end up having problems? Converting that in a
> > > follow-up series is likely a good idea, to highlight and address thes=
e
> > > issues sooner rather than later.#
> >
> > Today the .dtb files go into arch/arm/dts - so it would be easier if
> > this series could do the same.
>
> The kbuild infrastructure keeps the dtb alongside dts files which is
> the preferred way too as otherwise it would be complicated to locate
> DT files for the users. Also, we have to move towards Linux DT
> directory structure and thereby the tools like binman have to be
> adjusted. I will do that when I get to migrating SoCs supporting
> binman.

OK, I want to stop here and rethink this. This is the path taken so
far, I believe:

1. We want to use devicetree files taken from Linux and
devicetree-rebasing provides these
2. We want to use 'git subtree' to avoid needing a script to do the
sync / create a commit
3. But this leaves us with a directory structure which doesn't match
U-Boot (no script to fix it up)
4. So we deal with that by skipping the build rules and using CONFIG
options to select what is built
5. So now we cannot build all the files for an SoC, just the ones that
are in the CONFIG options
6. Linux doesn't actually use devicetree-rebasing itself, so doesn't
have this problem

So this is heading in the wrong direction. Nor is it clear that this
would just be a temporary problem.

Possible options I see are:

a. Adjust U-Boot's dir structure to match Linux, first (but this might
be painful?)
b. Create a script to sync the files, so we can sync into a dir
structure that matches U-Boot
c. Add build rules to U-Boot's version of the devicetree-rebasing dir
(this seems to be supported)
d. Give up and just live with having boards (not SoCs) specify the
devicetree files they want to build

I would like to do this series properly, maintaining the SoC-specific
build rules, not removing what I see as an important feature. It
should not be that difficult to figure out and I am happy to help with
it.

>
> >
> > The problem I have described above applied to meson, so I believe it
> > is clear enough with that. I wasn't able to get rk3399 going, but I am
> > sure it would have the same problem.
> >
> > The fundamental question is (I believe) whether to:
> >
> > 1. Build only a single DT for a board
> > 2. Build all DTs for the SoC the board uses
> >
> > This series seems to head towards (1),
>
> v2 of this series had the Makefile rules [1] for meson gxbb SoC but..
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20231222061208.30099=
70-8-sumit.garg@linaro.org/
>
> > which worries me. We are
> > currently mostly at (2).
>
> ..after discussion with Tom, the Makefile rules are already coming via
> Kconfig options like DEFAULT_DEVICE_TREE, OF_LIST etc. So having
> redundant rules in Makefile doesn't add any value, so I took them off
> in v3.

Yes, I see that you did that.

This seems to be a fundamental point of disagreement. I would like all
boards for an SoC to have mostly the same defconfig and just use a
devicetree for differences, at least in U-Boot proper. That is what
devicetree is for. In fact, I would like to see a lot more defaults in
U-Boot, so that defconfig files are just a few lines like [2] and
there is no board-specific C code not gated by a compatible string.

>
> However, I am very much in favour of having a generalized U-Boot
> image. This might become true in some cases like U-Boot acts as a
> second stage bootloader for a particular SoC which is a unified image
> where the prior stage passes the DT to it. The Qcom effort in this
> direction can be an example here.

Not relevant to the topic at hand, perhaps, but Qualcomm uses a
closed-source blob to jump to U-Boot and is certainly not an example
we should emulate. But yes, passing a DT to U-Boot proper can be
useful.

>I am not sure at this point how we
> can enable different U-Boot features since there are many board
> specific bits needed currently not covered by DT.

I certainly see many examples of that, but the majority of features
are covered. It was of course the same in Linux until someone put his
foot down.

>
> The other common method is to embed board DT in U-Boot image
> especially where U-Boot acts as a first stage bootloader. Once that's
> done I don't see how we can call that a generic U-Boot image.

If you mean OF_EMBED, then I don't think that is much used. It is just
for using a JTAG debugger and these days, it is barely useful for
that.

We do use fdtgrep to create a smaller FDT for SPL, though. In general,
it will be harder to create a general SPL for an SoC. But it is also
less beneficial, since SPL is small. Also, it is possible, as shown by
rockchip.

>
> BTW, as Tom said we can very well add those Makefile rules later on a
> use case basis if a particular SoC requires a truly generic U-Boot
> image and the rules don't come via Kconfig options.

We mostly have them already, so we should not remove them.

We are setting policy here. The policy should bias towards the
generic, not to make that hard. There are over 900 arm64 devicetree
files in Linux but only a few dozen SoCs and only one build. We should
not have 900 arm64 U-Boots, only a few dozen and perhaps one day in
the dim, distant future, if the tradeoffs make sense, one.

Regards,
Simon

[2] https://patchwork.ozlabs.org/project/uboot/patch/20210619081645.42660-2=
-mtwget@gmail.com/

