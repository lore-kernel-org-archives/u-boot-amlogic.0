Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07823C47DDA
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.98266.1703666373448414646
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Dec 2023 00:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=f+AwW3ht;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e80d40a41so1342646e87.1
        for <u-boot-amlogic@groups.io>; Wed, 27 Dec 2023 00:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703666371; x=1704271171; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+71rxcQ4tKfwCLlKcqp3uUBwlFV73S+sxYa2p4O/HU=;
        b=f+AwW3ht43cCdzzdRdGsl8e4CeC/wUaKB7UmIzmtlTO88Ehe4EblFa/1CCtpLid/VV
         KnsMkJi1sniaop+krZvSy/LfG75g5/hYDjE9EzqUZB8PMyNaNpI4vB7eGJQdyzT1vZl/
         AgaagWgbH47krDDXWN5oHZokcvSCYu2Lx09PHw4CryXC83d7T5siJFrIXT/JlXXFGJP3
         bjm98Pmupq7Sr0m8rCBtDl/lWc6gJxcrwDss/ZU2liqS7KKJuYbdPbsdeDdjMzubdZmk
         AiOrJqVqArmRCz9Joy6+cJ44lWN3jCqZ4GRMG95KWCDYOikC1D0UFXU+sMVtKcQL2Rb6
         NQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703666371; x=1704271171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+71rxcQ4tKfwCLlKcqp3uUBwlFV73S+sxYa2p4O/HU=;
        b=mSK/tQBKfn89f4a74TAd0sOBplQt04/nFEMqxi7X3w04ZWAgf8Ba4RRDD6acZj7j6j
         Aqsf7BBfGXqiNv/GwHeSlJz9BDw138m7D4A89sBAZX8XWK2QqZqCIwkHLYS9M/+UehMx
         Y/q5K7u/crbU8KJL1GhpKhgPHMHIwrDIocesBaxvvBX/QEZcVN6hSCQS/GI8Bpc2Kr4A
         N5VVoT4FvSBj4eoeUKjiIyZBTtOxKb6F4btvIIQjbPmFU1HHm7D2qwNwlmmiQgoiiWZK
         38sYp3in5wABjZR8bDWJy5qIRk/q5vQ6J2+DM3IjOsWnJQc2dIEIOhYQR/SDt9I+ihk5
         59ig==
X-Gm-Message-State: AOJu0Yx/8orAhlA2phoAeeDnfva6HciZolTpSkrIDD7nXPU8SA8RFvzI
	TOYKo2nAxAZVewBRCWyaVH59FbSwquGrNvbsb8PgoubNTaMV/A==
X-Google-Smtp-Source: AGHT+IF615JeVVQerag8IApiJkfg/Dol0flL4S4XWJANjO9y7DJgDj8neeZVt/XdD/tg2HOkNo8rnjztkn6RCJQCKCw=
X-Received: by 2002:a05:6512:3093:b0:50e:7fdc:6eda with SMTP id
 z19-20020a056512309300b0050e7fdc6edamr1211106lfd.93.1703666371524; Wed, 27
 Dec 2023 00:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org> <20231222061208.3009970-4-sumit.garg@linaro.org>
In-Reply-To: <20231222061208.3009970-4-sumit.garg@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:38:55 +0200
Message-ID: <CAC_iWjL7A857Hdd8gdAC_XqV=kap_hDwEzPf6R77_QUpcKyzdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1978

Hi Sumit,

Thanks this looks great


On Fri, 22 Dec 2023 at 08:12, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Allow u-boot to build DTB from a different directory tree such that
> *-u-boot.dtsi files can be included from a common location. Currently
> that location is arch/$(ARCH)/dts/, so statically define that common
> location.
>
> This is needed for platform owners to start building DTB files from
> devicetree-rebasing directory but still being able to include
> *-u-boot.dtsi files.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  scripts/Makefile.lib | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 27b9437027c..09330421856 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
>  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
>
>  # Try these files in order to find the U-Boot-specific .dtsi include file
> -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)u-boot.dtsi))
> +u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
> +
> +u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
>
>  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -       $(dir $<)u-boot.dtsi ... \
> +       $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)u-boot.dtsi ... \
>         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
>
>  # Uncomment for debugging
> @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  $(UBOOTINCLUDE)                                         \
>                  -I$(dir $<)                                             \
> +                -I$(u_boot_dtsi_loc)                                     \
>                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
>                  -I$(srctree)/include                                    \
>                  -D__ASSEMBLY__                                          \
> @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
> -               -i $(dir $<) $(DTC_FLAGS) \
> +               -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
>                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>                 ; \
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

