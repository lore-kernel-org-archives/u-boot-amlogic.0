Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB27C47DAC
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 by mx.groups.io with SMTP id smtpd.web10.233712.1704069196900387898
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Dec 2023 16:33:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@xs4all.nl header.s=xs4all01 header.b=mclICfi5;
 spf=pass (domain: xs4all.nl, ip: 195.121.94.184, mailfrom: mark.kettenis@xs4all.nl)
X-KPN-MessageId: 55cc4607-a83d-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 55cc4607-a83d-11ee-91e7-005056994fde;
	Mon, 01 Jan 2024 01:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:to:from:message-id:date;
	bh=GcEK0se+LFsJRhsvUnrMXlvPetbDgDpidjH8MYDU7Bw=;
	b=mclICfi5ISx9a7H7cgGs4723FZYtoBKVn1zoRz7wNddS7ZbWdZxeTpCLOLsBxiahL5gZgHKcTXBdn
	 oJ4yBfMH1QjvNH7Qh7pzQrjk4XKyrNdA3ndGkKMZNpldKVMXZx60q0/YZvgQmKBt61A7aedX25gkM6
	 dhlNEo8OxoF10jISZZcOk6R/XgMiuwzRr5VxCSeITYUO1vBEqBhm6YVOotCWVNHzsYxlmO2g2exJuv
	 Bq10uPH06na6jWRSM/TY0OWNQSmgK4bm5T8D9laHxs+Mgy2+5r0/7gAOtPu3OrDUP+QRbmC2xamjIl
	 eJuL7ANaGDDZ6ZhXm1VMHUTdQbril8A==
X-KPN-MID: 33|pKxXrIxqQ/uaSNjS/oCsPRFuvgRThyxSTxWZ+HNYpaKXfGi8lP8xYtEeSUR4ZJs
 uu65bu9Hockr1YulGBC3ceTzpiiltKa/fgXmpFbOWDVI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1F7CJMwSks67R39HTwmeZrlTsuCWS3ctY0NilbQiL0R/dANSg3S7MsQqAgP8Gna
 JdRqdm+m/oS13ak6TAiwJIw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 586ac424-a83d-11ee-ad2d-005056998788;
	Mon, 01 Jan 2024 01:33:13 +0100 (CET)
Date: Mon, 01 Jan 2024 01:33:12 +0100
Message-Id: <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, sumit.garg@linaro.org, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com,
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
In-Reply-To: <20231231203953.GG2652760@bill-the-cat> (message from Tom Rini on
	Sun, 31 Dec 2023 15:39:53 -0500)
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com> <20231231203953.GG2652760@bill-the-cat>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2015

> Date: Sun, 31 Dec 2023 15:39:53 -0500
> From: Tom Rini <trini@konsulko.com>
> 
> On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote:
> > Hi Sumit,
> > 
> > On Fri, Dec 29, 2023 at 8:30 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Thu, Dec 28, 2023 at 3:54 PM Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> > > > > > Hi Tom, Sumit,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 2:03 PM Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > > > > > > Hi Sumit,
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 11:58 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Allow platform owners to mirror devicetree files from devitree-rebasing
> > > > > > > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> > > > > > > > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> > > > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > > > >
> > > > > > > > > This will help easy migration for platforms which currently are compliant
> > > > > > > > > with upstream Linux kernel devicetree files.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > --------------
> > > > > > > > > - Minor commit message update
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > --------------
> > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > > > > > >
> > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > >
> > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > >           enables a live tree which is available after relocation,
> > > > > > > > >           and can be adjusted as needed.
> > > > > > > > >
> > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > +       bool "Enable use of devicetree imported from Linux kernel release"
> > > > > > > > > +       help
> > > > > > > > > +         Traditionally, U-Boot platforms used to have their custom devicetree
> > > > > > > > > +         files or copy devicetree files from Linux kernel which are hard to
> > > > > > > > > +         maintain and can usually get out-of-sync from Linux kernel. This
> > > > > > > > > +         option enables platforms to migrate to devicetree-rebasing repo where
> > > > > > > > > +         a regular sync will be maintained every major Linux kernel release
> > > > > > > > > +         cycle. However, platforms can still have some custom u-boot specific
> > > > > > > > > +         bits maintained as part of *-u-boot.dtsi files.
> > > > > > > >
> > > > > > > > My only other suggestion here is to mention that this should be set in
> > > > > > > > Kconfig, for the SoC as a whole. So I believe that means that it
> > > > > > > > should be hidden, with no string for the 'bool':
> > > > > > > >
> > > > > > > >       bool  # Enable use of devicetree imported from Linux kernel release
> > > > > > >
> > > > > > > I think we can just keep prompting for it now, to make the transition
> > > > > > > easier, before this option just goes away in time, hopefully.
> > > > > > >
> > > > > > > > Also, this doesn't seem to work for me. Before this series I get these
> > > > > > > > files when building firefly-rk3399:
> > > > > > > >
> > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > > > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock-4se.dtb
> > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock960.dtb
> > > > > > > >
> > > > > > > > Afterwards I get this:
> > > > > > > >
> > > > > > > > make[3]: *** No rule to make target
> > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > > > > > > >
> > > > > > > > So I set this manually for that one board:
> > > > > > > >
> > > > > > > > CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-firefly"
> > > > > > > >
> > > > > > > > and get:
> > > > > > > >
> > > > > > > > make[3]: *** No rule to make target
> > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > > > > > > >
> > > > > > > > I am not sure how to fix this, nor how this can be made to build all
> > > > > > > > the DTs for rk3399, as it does today.
> > > > > > >
> > > > > > > Looking at the patch for amlogic boards, you need to make the link to
> > > > > > > devicetree-rebasing inside dts/...
> > > > > >
> > > > > > OK, let me give up on rk3399 for now...that doesn't seem to work even
> > > > > > with the link.
> > > > > >
> > > > > > Using odroid-c2 with -next I see:
> > > > > >
> > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
> > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
> > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
> > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
> > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
> > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
> > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
> > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
> > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
> > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
> > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
> > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
> > > > > > $
> > > > > > With this series (sort of, since I am really not sure how to
> > > > > > cherry-pick the commits from the PR) I see nothing:
> > > > > >
> > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > $
> > > > > >
> > > > > > This shows some of the files:
> > > > > >
> > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
> > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > >
> > > > > > but where are the rest? Also, is it possible to put the output .dtb
> > > > > > files into the same directory? Otherwise we may have some pain with
> > > > > > binman.
> > > > >
> > > > > What do you mean by same directory? But maybe also, what's an example of
> > > > > a board you think might end up having problems? Converting that in a
> > > > > follow-up series is likely a good idea, to highlight and address these
> > > > > issues sooner rather than later.#
> > > >
> > > > Today the .dtb files go into arch/arm/dts - so it would be easier if
> > > > this series could do the same.
> > >
> > > The kbuild infrastructure keeps the dtb alongside dts files which is
> > > the preferred way too as otherwise it would be complicated to locate
> > > DT files for the users. Also, we have to move towards Linux DT
> > > directory structure and thereby the tools like binman have to be
> > > adjusted. I will do that when I get to migrating SoCs supporting
> > > binman.
> > 
> > OK, I want to stop here and rethink this. This is the path taken so
> > far, I believe:
> > 
> > 1. We want to use devicetree files taken from Linux and
> > devicetree-rebasing provides these
> 
> Yes.
> 
> > 2. We want to use 'git subtree' to avoid needing a script to do the
> > sync / create a commit
> 
> No. We want to use 'git subtree' to avoid having to use git submodules.
> 
> > 3. But this leaves us with a directory structure which doesn't match
> > U-Boot (no script to fix it up)
> 
> No. We intentionally abandon arch/*/dts because it's so full of
> out of date files and never fully re-synced, only re-synced ad-hoc.
> 
> > 4. So we deal with that by skipping the build rules and using CONFIG
> > options to select what is built
> > 5. So now we cannot build all the files for an SoC, just the ones that
> > are in the CONFIG options
> > 6. Linux doesn't actually use devicetree-rebasing itself, so doesn't
> > have this problem
> 
> No. devicetree-rebasing skips the Makefiles because they're part of the
> kernel. We couldn't re-use them ourselves because we don't have the same
> CONFIG names the kernel does. And Sumit has not replicated the logic we
> have under arch/*/dts/Makefile today because I've asked him not to, and
> we'll figure out what subsets of that logic make sense to add back in as
> a second step not a first step.
> 
> > So this is heading in the wrong direction. Nor is it clear that this
> > would just be a temporary problem.
> 
> A previous iteration of this series built all of the dtb files for the
> SoC that Sumit has migrated with this series, but then dropped it.
> 
> [snip]
> > I would like to do this series properly, maintaining the SoC-specific
> > build rules, not removing what I see as an important feature. It
> > should not be that difficult to figure out and I am happy to help with
> > it.
> 
> The problem is that the rest of us do not understand the use case you're
> describing where a dtb file that would be useful in a build is not
> already in the list to build. The only one of those use cases I
> understand thus far is the exynos4 (iirc) case you mentioned previously
> where yes, really, one defconfig + appending board.dtb is fine, or fine
> enough. It's not that far off of the SPL_LOAD_FIT case, but there we
> know what to build already.
> 
> And I guess trying to tie things up, that's my puzzle. SPL_LOAD_FIT is
> how I see the use case you talk about being solved, if a full U-Boot is
> generic enough for N boards, SPL_LOAD_FIT does the right thing (in this
> non-bloblist DTB, non-reusing-OS-inntended DTB world). I really don't
> knnow how many modern SoCs can take a literal concatenated DTB and even
> in those cases I don't get why that's the win we want now? 1 build to N
> binaries?
> 
> But even then, I don't object to adding those rules to the Makefiles. If
> it works it works. I object to adding them when they don't work.
> 
> > > > The fundamental question is (I believe) whether to:
> > > >
> > > > 1. Build only a single DT for a board
> > > > 2. Build all DTs for the SoC the board uses
> > > >
> > > > This series seems to head towards (1),
> > >
> > > v2 of this series had the Makefile rules [1] for meson gxbb SoC but..
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20231222061208.3009970-8-sumit.garg@linaro.org/
> > >
> > > > which worries me. We are
> > > > currently mostly at (2).
> > >
> > > ..after discussion with Tom, the Makefile rules are already coming via
> > > Kconfig options like DEFAULT_DEVICE_TREE, OF_LIST etc. So having
> > > redundant rules in Makefile doesn't add any value, so I took them off
> > > in v3.
> > 
> > Yes, I see that you did that.
> > 
> > This seems to be a fundamental point of disagreement. I would like all
> > boards for an SoC to have mostly the same defconfig and just use a
> > devicetree for differences, at least in U-Boot proper. That is what
> > devicetree is for. In fact, I would like to see a lot more defaults in
> > U-Boot, so that defconfig files are just a few lines like [2] and
> > there is no board-specific C code not gated by a compatible string.
> 
> That's a nice goal to aim for. Sumit's work doesn't stop that being
> aimed for, and by making it easy to keep our device trees modern, it
> makes that easier, not harder.
> 
> Heck, it's something I've been working with the TI folks with for a few
> years now, and this work will make things easier for them because the
> dts files will get synced back, for all of the chips, sooner rather than
> later, and we can push towards getting rid of most of the -u-boot.dtsi
> work, and deal with the hard question of "where do r5 dts files go?".
> But that will not get rid of board/siemens/iot2050/ because that's what
> a custom hardware design needs and wants. Not "just pass the new DTB".
> This is another of the valid use cases that we need to keep in mind and
> design around, the explicit and intentional starting point of "don't
> just run the EVM binary for custom hardware design production".
> 
> > > However, I am very much in favour of having a generalized U-Boot
> > > image. This might become true in some cases like U-Boot acts as a
> > > second stage bootloader for a particular SoC which is a unified image
> > > where the prior stage passes the DT to it. The Qcom effort in this
> > > direction can be an example here.
> > 
> > Not relevant to the topic at hand, perhaps, but Qualcomm uses a
> > closed-source blob to jump to U-Boot and is certainly not an example
> > we should emulate. But yes, passing a DT to U-Boot proper can be
> > useful.
> 
> It's a very valid use case we need to continue to support. And to save
> Mark from having to repeat himself, again, it's intentionally and not
> changing, how the Apple M1/M2/etc platforms boot. I'm pretty sure the
> fact that one can use U-Boot this way is part of how engineers get proof
> of concept work done to show that if they had U-Boot available then they
> could also support X/Y/Z easier. And maybe they'll be able to longer
> term push internally to use bloblist to pass things along.
> 
> Heck, trying to not go too far off on a tangent, maybe the m1n1 loader
> can implement both conventions, as both Linux Kernel[0] and Bloblist[1]
> use x0 for device tree, but bloblist has x1 non-zero and Linux does not,
> so both could be present here? Or is there some incompatibility I don't
> see on quick skimming?

Right.  Some time ago I suggested Simon to lobby the Linux kernel
folks to change the arm64 Linux kernel entry convention to state that
x1 can be non-zero in which case it points at a bloblist.  If that
happened I'd probably do the work to make m1n1 pass a bloblist.  And
it would probably make the folks who want to directly boot a Linux
kernel from TF-A (without going through U-Boot) happy as well.

Cheers,

Mark

