Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633FC47079
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.15137.1703047649342394775
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 20:47:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=PvEharK6;
 spf=pass (domain: google.com, ip: 209.85.128.44, mailfrom: sjg@google.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so65988925e9.2
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 20:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047647; x=1703652447; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0j0XoX/F4CYjfrrCPTxHlaT+yiksoIM6Qy8SYqbu4M=;
        b=PvEharK6+WAWJTEJrDbsDv6Rl71FCL0qGucdtnzSi0GQCGhZwLDc6xQ4S2azRsI+6O
         fTM1oyp76P5oX0n8iym5U10LcSAQcJRyAiAVgLUaRcalINutsatouglRlbKenQKH18gL
         8Mj11KJ/k6w4SVmx76quzXD/MQ2lOCUTd0kls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047647; x=1703652447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0j0XoX/F4CYjfrrCPTxHlaT+yiksoIM6Qy8SYqbu4M=;
        b=VRvq0gKzEjNje8+6BDH/FlmSGX+ooIPNF0S1l899gvhemv5Tbm676alUfw+Q5h4H7l
         0mQQJcHVweeYoS/YHSduCQF6Zvs8uC+2j2mXyt5KNCFMcpnRzZXkpZSQB70g8we6HYMQ
         JY0nIIsQ2oB9Buoz2uAebvrjTXfF6URfLtmjeJVhr5MnGMTBiJR27DzGInwMk43BrooJ
         Y4ocIrfqmewYAF+tvRDjM7K8/AMcTrc8Z/wfVN5mNxD4UEL2VlZjz6ZCkWpJnpIdvBgx
         Gc1+XKYCx7t+gmCyG3Kg/x9CTlxZGvh7RoDoPyA9azmPJXB5wvNidmlVf+fDWv0WV1jf
         bw8w==
X-Gm-Message-State: AOJu0Yx8N+hjlkgFRaAwH09+H44hBhjQ5A9DAV94IN4nBd0QTU/Eu9gO
	UesvwRWhTCuov0aoEIUWozkSzPFJ2XVt13TMYdSLjg==
X-Google-Smtp-Source: AGHT+IH/9tW5NV6GCaMzuxvXkKRxguwQaOwhT3X3RkI6cJ8E1LvdCj5G9z/urywVSYomWPSAuBUoTGKCKRA1S6Gc6Bg=
X-Received: by 2002:a05:600c:808b:b0:40c:32c7:84fd with SMTP id
 ew11-20020a05600c808b00b0040c32c784fdmr10727069wmb.80.1703047647489; Tue, 19
 Dec 2023 20:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org> <20231214135103.1606605-4-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-4-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:15 -0700
Message-ID: <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1950

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
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
> index 27b9437027c..4a002b0e0ca 100644
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
> +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/

How about lower case since it is internal. Also we know it is U-Boot,
so perhap dtsi_loc ?

Otherwise looks OK to me.

> +
> +u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
>
>  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -       $(dir $<)u-boot.dtsi ... \
> +       $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)u-boot.dtsi ... \
>         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
>
>  # Uncomment for debugging
> @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  $(UBOOTINCLUDE)                                         \
>                  -I$(dir $<)                                             \
> +                -I$(UBOOT_DTSI_LOC)                                     \
>                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
>                  -I$(srctree)/include                                    \
>                  -D__ASSEMBLY__                                          \
> @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
> -               -i $(dir $<) $(DTC_FLAGS) \
> +               -i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
>                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>                 ; \
> --
> 2.34.1
>

Regards,
Simon

