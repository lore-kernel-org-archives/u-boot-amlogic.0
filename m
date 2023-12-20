Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC3C46CD8
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.20075.1703073711845959424
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 04:01:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=YkPs1mFj;
 spf=pass (domain: linaro.org, ip: 209.85.167.179, mailfrom: sumit.garg@linaro.org)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so5152707b6e.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703073711; x=1703678511; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKGoDZ48ZEczAEgArq9tcfMOds642x44asCqXniP7yw=;
        b=YkPs1mFjXG3iW2p1zleqqhSCl0BSeJNvgyv5qZ03VmRHdnYbz9/eo+ogyoGhyqlIuU
         dwxl9t1O2JaIKdVkbjfQLN9/E7NpqJLzUPyLwj+4oCDUrxvKcPPFEXdQDfm30uLAYyyP
         NZ/bBlYX3rfauxjJzfb5wbsjmcRdIFrew2FgFnt5jYxGvVEvp0ykn6DSL2zT9PXRNm4p
         /7fRewAy2iVcRxKxWIElNDDBhZGdZNGZprzWuMGLPFoYaGrzeO+JdUTiUGptT+bbQV6I
         ltKZdRe6XOsVdbzPY2yriSdvTUnU8mu89MoD7T/AB3aljnAEjVR6q31sFkfr/CDMJ3+y
         So8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073711; x=1703678511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKGoDZ48ZEczAEgArq9tcfMOds642x44asCqXniP7yw=;
        b=ZIKGsaqs1tP8RGDz057iR4U+qqR37x/0Fn3uftDTTSUZv9gUZsEw4AIUjKJGlcsRNY
         PjS+FZHOGcGR33eZMkEY/RFuFkpVLtiMHYdxcqRUstJOJYGMky4kduO1IiQFYS6k4dpy
         oPxQ21yS8ozcsNj0T3VFbmdEciiuL5k8aDDABEkV6sVfoELfkAq7B7hLbnfEe9cblPe2
         Tkkj0dxCvh+ACnzHTGB4oYuemvEaMWNWgeGDmFfbAg5pZ8o5gJjabY/FvO+Q6ZyY1ut2
         mlfHxZX/JTnZuUbsqtTwVelcdDSlruKkjnYxuyWgZq3VyVWMGvw2h1PVNwWnFUhKOYQd
         wPwA==
X-Gm-Message-State: AOJu0YyctsFtQKPhuxzmcQdLtYkpQvyXd6V0HQeGFE+jOQeCLtnVtPG0
	DKbqiN8ao9K3npEuGbe62X+nuoR9RhwWXSoVJDXCwg==
X-Google-Smtp-Source: AGHT+IFVOHk/KR8nGQ9GxeOkB1v+ACQBkyFEjY07+zftdemeE06DM43suts4BOVHjOBkeurrg2BDhDI/ll5A7dpONjI=
X-Received: by 2002:a05:6808:f09:b0:3b9:d5e3:8f28 with SMTP id
 m9-20020a0568080f0900b003b9d5e38f28mr26593640oiw.57.1703073710627; Wed, 20
 Dec 2023 04:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org> <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 17:31:39 +0530
Message-ID: <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1958

Hi Simon,

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Allow platform owners to mirror devicetree files from devitree-rebasing
> > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> > directory.
>
> Also add a new Makefile for arm64.

I suppose you are referring to dts/arch/arm64/Makefile which has been
added by this patch.

>
> >
> > This will help easy migration for platforms which currently are compliant
> > with upstream Linux kernel devicetree files.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  dts/Kconfig             | 11 +++++++++++
> >  dts/Makefile            | 17 ++++++++++++++---
> >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> >  3 files changed, 39 insertions(+), 3 deletions(-)
> >  create mode 100644 dts/arch/arm64/Makefile
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 00c0aeff893..96396f12b67 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -85,6 +85,17 @@ config OF_LIVE
> >           enables a live tree which is available after relocation,
> >           and can be adjusted as needed.
> >
> > +config OF_UPSTREAM
> > +       bool "Enable use of devicetree imported from Linux kernel release"
> > +       help
> > +         Traditionally, U-boot platforms used to have their custom devicetree
>
> U-Boot
>
> (I think I mentioned this, but you thought I said U-boot...but it
> really is U-Boot). Perhaps grep your patches next time.

Ah, I see. It looks like I missed that bit, and will take care of it
in the next revision.

>
> > +         files or copy devicetree files from Linux kernel which are hard to
> > +         maintain and can usually get out-of-sync from Linux kernel. This
> > +         option enables platforms to migrate to devicetree-rebasing repo where
> > +         a regular sync will be maintained every major Linux kernel release
> > +         cycle. However, platforms can still have some custom u-boot specific
> > +         bits maintained as part of *-u-boot.dtsi files.
>
> I'm a bit nervous about this. It means that boards chose between this
> dir of the local files. It means there is some effort to switch.
>
> I wonder if we could default to using the rebasing thing, with boards
> having to 'opt out'? So this should be 'default y' ?

Ideally that should be our migration path going forward once we get
enough boards migrated to use rebasing repo. But at this initial stage
we have to put some effort on migrating boards to use rebasing
subtree, although effort should be just adding (given DT bindings
compliance) following to defconfig (see patch #7):

CONFIG_OF_UPSTREAM=y
CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"

and create a mirrored copy of:
../../../devicetree-rebasing/src/arm64/amlogic/ into
dts/arch/arm64/amlogic/ with modifications to add targets to
dts/arch/arm64/Makefile.

I am happy to put in that effort but certainly for new board support
that would like to import DT from Linux it should be the default. That
stands true for the Qcom platform series for which Caleb is currently
working on.

>
>
> > +
> >  choice
> >         prompt "Provider of DTB for DT control"
> >         depends on OF_CONTROL
> > diff --git a/dts/Makefile b/dts/Makefile
> > index 3437e54033d..8098bf8191a 100644
> > --- a/dts/Makefile
> > +++ b/dts/Makefile
> > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> >  DEVICE_TREE := unset
> >  endif
> >
> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > +ifeq ($(CONFIG_ARM64),y)
> > +DEVICE_TREE_LOC := dts/arch/arm64
>
> dt_dir ?

Okay I will rename it.

>
> Should we move the arm64 DTs to arch/arm64 ?

IMO, the migration path should be to use rebasing subtree via
dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
like a redundant change to me.

>
> What about the subdirs used in Linux?

I hope I have described above regarding how subdirs are mirrored.
However, have a look at patch #7 for the amlogic/ subdir example.

-Sumit

>
> > +else
> > +DEVICE_TREE_LOC := dts/arch/$(ARCH)
> > +endif
> > +else
> > +DEVICE_TREE_LOC := arch/$(ARCH)/dts
> > +endif
> > +
> >  ifneq ($(EXT_DTB),)
> >  DTB := $(EXT_DTB)
>
> >
> >  else
> > -DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
> > +DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
> >  endif
> >
> >  $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
> > @@ -41,7 +51,7 @@ $(DTB): arch-dtbs
> >
> >  PHONY += arch-dtbs
> >  arch-dtbs:
> > -       $(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
> > +       $(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
> >
> >  ifeq ($(CONFIG_SPL_BUILD),y)
> >  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
> > @@ -65,4 +75,5 @@ clean-files := dt.dtb.S
> >  # Let clean descend into dts directories
> >  subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts     \
> >            ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts     \
> > -          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
> > +          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts        \
> > +          ./arch/arm64 ./arch/$(ARCH)
> > diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> > new file mode 100644
> > index 00000000000..16e9fea622d
> > --- /dev/null
> > +++ b/dts/arch/arm64/Makefile
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +include $(srctree)/scripts/Makefile.dts
> > +
> > +targets += $(dtb-y)
> > +
> > +# Add any required device tree compiler flags here
> > +DTC_FLAGS += -a 0x8
> > +
> > +PHONY += dtbs
> > +dtbs: $(addprefix $(obj)/, $(dtb-y))
> > +       @:
> > +
> > +clean-files := */*.dtb */*.dtbo */*_HS
> > --
> > 2.34.1
>
> Regards,
> Simon

