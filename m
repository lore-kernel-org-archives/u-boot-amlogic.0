Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C113C4706E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.15140.1703047671702340112
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 20:47:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=cHf31074;
 spf=pass (domain: google.com, ip: 209.85.221.44, mailfrom: sjg@google.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33671384e50so1483603f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 20:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047670; x=1703652470; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kAVYF8zMbbeSRptMp0piciVuVCSIiXV7VVXvv87BbpA=;
        b=cHf31074t6IrDlojXRoHe0B+YnjLGEk8s5mCHkF9eAAOr61WYObSyX79oZV74FylC8
         HE/OdW66VWxio3JSDfR8AdV0T0IyEHUIzcWU99NOh3A1JVVMX8jAwuCSZn6mXS17eN+w
         9mhoJFgI5LHuM1nNg069HK1O8GZ7rKyaldfs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047670; x=1703652470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAVYF8zMbbeSRptMp0piciVuVCSIiXV7VVXvv87BbpA=;
        b=FBqn/DUgXdFhZ69u3OF0/u3k2rwK9TRWdz05rbI6T+qtmmAkhuV41j9wrGQcsE1rhr
         65O9JBInv1sc1Usk5eXLmbe7OzPqrP/hSDeFD4fqTvpoVoKkD68Hc/hoHgveuFsN/kBG
         LaaIBfILapK9Kxo1uNW/5Pz/X1a7pIf/mRy87BcJlETMx5kWk3L7/W+XYfbw7PA+XXVf
         s/434b7UiEcD5RjpEzMykmg4OFVjhU1HLJ+Yctm8KhsDmIB/KFWynR5RU/N9Yp3vJ2nQ
         OXtFFK0nBJIuU5Nyg/2mutxEwPTrrb6JMOwArVHp+IuYmQCWo1PrjYV1nk9Nkr9A625r
         lKow==
X-Gm-Message-State: AOJu0Yy1ym1maGs7wziRchdbT7va+hDw+XPfn9ZX2wavAWb0iNQklfJO
	tzjNzm4uFQm6iA2jQ2holD2y8zX3XCCd3eYQ3KM/sziwGRvUMcfw5yo=
X-Google-Smtp-Source: AGHT+IGz7UuauJkWmRvsgeDcPDAm/Gg3/HL6qLIhb3me9kc+hnH6afdpU8BR1GaS0mXzpk5JkNbrJKjt7VrdSt57oC8=
X-Received: by 2002:a17:906:109a:b0:a26:8dd9:7bf5 with SMTP id
 u26-20020a170906109a00b00a268dd97bf5mr352058eju.44.1703047649290; Tue, 19 Dec
 2023 20:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org> <20231214135103.1606605-5-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-5-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:17 -0700
Message-ID: <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1953

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Allow platform owners to mirror devicetree files from devitree-rebasing
> directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> directory.

Also add a new Makefile for arm64.

>
> This will help easy migration for platforms which currently are compliant
> with upstream Linux kernel devicetree files.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  dts/Kconfig             | 11 +++++++++++
>  dts/Makefile            | 17 ++++++++++++++---
>  dts/arch/arm64/Makefile | 14 ++++++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 dts/arch/arm64/Makefile
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff893..96396f12b67 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -85,6 +85,17 @@ config OF_LIVE
>           enables a live tree which is available after relocation,
>           and can be adjusted as needed.
>
> +config OF_UPSTREAM
> +       bool "Enable use of devicetree imported from Linux kernel release"
> +       help
> +         Traditionally, U-boot platforms used to have their custom devicetree

U-Boot

(I think I mentioned this, but you thought I said U-boot...but it
really is U-Boot). Perhaps grep your patches next time.

> +         files or copy devicetree files from Linux kernel which are hard to
> +         maintain and can usually get out-of-sync from Linux kernel. This
> +         option enables platforms to migrate to devicetree-rebasing repo where
> +         a regular sync will be maintained every major Linux kernel release
> +         cycle. However, platforms can still have some custom u-boot specific
> +         bits maintained as part of *-u-boot.dtsi files.

I'm a bit nervous about this. It means that boards chose between this
dir of the local files. It means there is some effort to switch.

I wonder if we could default to using the rebasing thing, with boards
having to 'opt out'? So this should be 'default y' ?


> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
> diff --git a/dts/Makefile b/dts/Makefile
> index 3437e54033d..8098bf8191a 100644
> --- a/dts/Makefile
> +++ b/dts/Makefile
> @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
>  DEVICE_TREE := unset
>  endif
>
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +DEVICE_TREE_LOC := dts/arch/arm64

dt_dir ?

Should we move the arm64 DTs to arch/arm64 ?

What about the subdirs used in Linux?

> +else
> +DEVICE_TREE_LOC := dts/arch/$(ARCH)
> +endif
> +else
> +DEVICE_TREE_LOC := arch/$(ARCH)/dts
> +endif
> +
>  ifneq ($(EXT_DTB),)
>  DTB := $(EXT_DTB)

>
>  else
> -DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
> +DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
>  endif
>
>  $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
> @@ -41,7 +51,7 @@ $(DTB): arch-dtbs
>
>  PHONY += arch-dtbs
>  arch-dtbs:
> -       $(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
> +       $(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
>
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
> @@ -65,4 +75,5 @@ clean-files := dt.dtb.S
>  # Let clean descend into dts directories
>  subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts     \
>            ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts     \
> -          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
> +          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts        \
> +          ./arch/arm64 ./arch/$(ARCH)
> diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> new file mode 100644
> index 00000000000..16e9fea622d
> --- /dev/null
> +++ b/dts/arch/arm64/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets += $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS += -a 0x8
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := */*.dtb */*.dtbo */*_HS
> --
> 2.34.1

Regards,
Simon

