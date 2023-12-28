Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC9EC47DAC
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.122629.1703770666926478318
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=U2VzgFn3;
 spf=pass (domain: chromium.org, ip: 209.85.215.172, mailfrom: sjg@chromium.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so4391526a12.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770666; x=1704375466; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gma/ydfZ8aeBRPViM2E/0C3wBGaMzHueiyT6FzBcoI4=;
        b=U2VzgFn3grYRBcSzDYUTIyYnQhNqAzJz0tjdwSVZ/ZDU7Ve7EFlNcMIjCEzOACjC8m
         VUtD7qTikyL1ThGCHiMcraZToDGXJ2rS3TbQJQyUqYGVVm6/3Km3TR0+Oa7wjyPLuXtC
         T3ZcoBCDFQpCcUL2M2kTiTNpKmToMIAW0AelY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770666; x=1704375466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gma/ydfZ8aeBRPViM2E/0C3wBGaMzHueiyT6FzBcoI4=;
        b=NtvTk/3hgEMuL2ehLWBR+smcbYl6eqmWF/ZqwTfWBPnweP1iso18VlkGeTM71pczX4
         ZepMbJdo6kxi6IZ+8QRF9EWuz88lzVDUwCgUi/d/CY6WGpXTBGmSvDzVnO4lHa3s1PZv
         El3WplGOvMVG9cyxRCoWyS+KHH6jv3N5sgdcjBMAaUrVFhAqRyK6ntj7tbAbg8Q3eRWw
         BfUbqZ3oQQZlFOGvjNb7BrMfK0Ex2YqEzBcLaCnA027AB+3fA3oocbVfoQt4waZynigG
         45ZjieSUhaI+iFlhjYJLAzMkLtz20OsRcuPhVra+KlRtcA1aFD15w2MXaSos/nqAbH2E
         RDzA==
X-Gm-Message-State: AOJu0YwohFMm6peaUyWVw4j2G0W1j/DJydwojid0QloZJslkPQRkSgjV
	RAfsR8CejoChwBSuynFAaZbttpi+yV6vFaiHwhf5Tl6cO1zb
X-Google-Smtp-Source: AGHT+IGc8N40uqDXV2QYzafb64DJyZ4HmSt75LGoB2KDr8FaCDesUxEURgd19PsAl48CrLyQXfqu9afruBxY5UFD1H4=
X-Received: by 2002:a05:6a21:612:b0:194:f17b:f877 with SMTP id
 ll18-20020a056a21061200b00194f17bf877mr9702550pzb.61.1703770666438; Thu, 28
 Dec 2023 05:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-5-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-5-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:26 +0000
Message-ID: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1996

Hi Sumit,

On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Allow platform owners to mirror devicetree files from devitree-rebasing
> directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> directory. Also add a new Makefile for arm64.
>
> This will help easy migration for platforms which currently are compliant
> with upstream Linux kernel devicetree files.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Minor commit message update
>
> Changes in v2:
> --------------
> - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
>
>  dts/Kconfig             | 11 +++++++++++
>  dts/Makefile            | 17 ++++++++++++++---
>  dts/arch/arm64/Makefile | 14 ++++++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 dts/arch/arm64/Makefile
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff893..e58c1c6f2ab 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -85,6 +85,17 @@ config OF_LIVE
>           enables a live tree which is available after relocation,
>           and can be adjusted as needed.
>
> +config OF_UPSTREAM
> +       bool "Enable use of devicetree imported from Linux kernel release=
"
> +       help
> +         Traditionally, U-Boot platforms used to have their custom devic=
etree
> +         files or copy devicetree files from Linux kernel which are hard=
 to
> +         maintain and can usually get out-of-sync from Linux kernel. Thi=
s
> +         option enables platforms to migrate to devicetree-rebasing repo=
 where
> +         a regular sync will be maintained every major Linux kernel rele=
ase
> +         cycle. However, platforms can still have some custom u-boot spe=
cific
> +         bits maintained as part of *-u-boot.dtsi files.

My only other suggestion here is to mention that this should be set in
Kconfig, for the SoC as a whole. So I believe that means that it
should be hidden, with no string for the 'bool':

      bool  # Enable use of devicetree imported from Linux kernel release

Also, this doesn't seem to work for me. Before this series I get these
files when building firefly-rk3399:

rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
rk3399-evb.dtb                  rk3399-leez-p710.dtb
rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
rk3399-rock-4c-plus.dtb
rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock-4se.d=
tb
rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock960.dt=
b

Afterwards I get this:

make[3]: *** No rule to make target
'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.

So I set this manually for that one board:

CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"

and get:

make[3]: *** No rule to make target
'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.

I am not sure how to fix this, nor how this can be made to build all
the DTs for rk3399, as it does today.

> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
> diff --git a/dts/Makefile b/dts/Makefile
> index 3437e54033d..68daaf45ec7 100644
> --- a/dts/Makefile
> +++ b/dts/Makefile
> @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
>  DEVICE_TREE :=3D unset
>  endif
>
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir :=3D dts/arch/arm64
> +else
> +dt_dir :=3D dts/arch/$(ARCH)
> +endif
> +else
> +dt_dir :=3D arch/$(ARCH)/dts
> +endif
> +
>  ifneq ($(EXT_DTB),)
>  DTB :=3D $(EXT_DTB)
>  else
> -DTB :=3D arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
> +DTB :=3D $(dt_dir)/$(DEVICE_TREE).dtb
>  endif
>
>  $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
> @@ -41,7 +51,7 @@ $(DTB): arch-dtbs
>
>  PHONY +=3D arch-dtbs
>  arch-dtbs:
> -       $(Q)$(MAKE) $(build)=3Darch/$(ARCH)/dts dtbs
> +       $(Q)$(MAKE) $(build)=3D$(dt_dir) dtbs
>
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_OF_EMBED) :=3D dt-spl.dtb.o
> @@ -65,4 +75,5 @@ clean-files :=3D dt.dtb.S
>  # Let clean descend into dts directories
>  subdir- +=3D ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/mi=
croblaze/dts     \
>            ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch=
/riscv/dts     \
> -          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xte=
nsa/dts
> +          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xte=
nsa/dts        \
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
> +targets +=3D $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS +=3D -a 0x8
> +
> +PHONY +=3D dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files :=3D */*.dtb */*.dtbo */*_HS

What is _HS for?

> --
> 2.34.1
>

Regards,
Simon

