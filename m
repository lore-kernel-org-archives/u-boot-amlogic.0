Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8384EC47073
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
 by mx.groups.io with SMTP id smtpd.web11.19443.1703071832656062374
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 03:30:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FcU/5m9B;
 spf=pass (domain: linaro.org, ip: 209.85.217.43, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4669bf184aeso659433137.0
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071831; x=1703676631; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/NnJBFiq7FYUkg4WYQtWt2kuFZ4wePHGcRAjEMRO7c=;
        b=FcU/5m9BPPgmNt5fhEHfvcnv1RRhSk6RUuwzGyYt4/EnWo0D9Ev3uSx+CbXam4sHT3
         Ib+qkLA4zcubUvD8DArGvhWRaAEVqqzj7nq80oBsCuuAilVZHDpaYzKDR2IUo7hQG/S1
         9jxhAzj1P7bogiNXor5Q76MwwPHP0AElPnnK54tWIutiiqavX/byCt4yYr3EcSTAoWZe
         CjEBvxchIiOT1AZZ4BvbAtd5Qdf0KevfVI+9CurhlZCiZyp6hyWnph8Vjqloudh13z7q
         a3oqgHXWRzqRpbuQBWv71dz3DEEF0MB9xJeET1yJp3KiuP95VGRrNpXpe14WpnQb4VYq
         W1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071831; x=1703676631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/NnJBFiq7FYUkg4WYQtWt2kuFZ4wePHGcRAjEMRO7c=;
        b=stxeUNV16M+Q/t3wUqpRa5ndITDwVHxmA7JU2ihsdZM61RBpFkkuK/jURPEMEGg1NI
         G5FiELdLNVGsKQQbr2Kbm24nw8VBHfgCZITgkhD1BJgiVmcMTSkNAc8aj7mV5219eTOq
         F/lEEX0u2y0kp+UGlHT8WzbI2envlsLr4H2OomrD6GkD5HuGBmHkDsQPYThJIrTeELmb
         80O5bXrdmkRGpgbYzrOZgxUOz26jVijgSE00irOs27yknKwXODKEcQYHuwRLI2KN9f7i
         RlxS0X533sdVrEpO40iiAXLNN4OpBKGtsoVWtiHp9IF9awyPFE7F771V3hTfNTNG1aHp
         GF3Q==
X-Gm-Message-State: AOJu0YxnWTq7u/O+voajYzYTMecqt4m9yR/gyQZH3wA01Tr24FXzzaip
	1xGcwq15JyM4YO7ABwI51ZT92yY0PoqaNcc36NQsGg==
X-Google-Smtp-Source: AGHT+IGXe29Niiy5kV6p53MnUBl3AIcjeVE4XTxt9BKsFJ8tPKUoNSr3K0RAVhjn1lA4FPfa44+maGOuCFifbpwvbLQ=
X-Received: by 2002:a05:6102:6d3:b0:466:c048:49dd with SMTP id
 m19-20020a05610206d300b00466c04849ddmr309805vsg.6.1703071831562; Wed, 20 Dec
 2023 03:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org> <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 17:00:20 +0530
Message-ID: <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1957

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 27b9437027c..4a002b0e0ca 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
> >  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> >
> >  # Try these files in order to find the U-Boot-specific .dtsi include file
> > -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)u-boot.dtsi))
> > +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
>
> How about lower case since it is internal. Also we know it is U-Boot,
> so perhap  ?

Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
too. So I will use that instead.

>
> Otherwise looks OK to me.

Thanks,
-Sumit

>
> > +
> > +u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
> >
> >  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> > -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> > -       $(dir $<)u-boot.dtsi ... \
> > +       $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)u-boot.dtsi ... \
> >         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
> >
> >  # Uncomment for debugging
> > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> >                  $(UBOOTINCLUDE)                                         \
> >                  -I$(dir $<)                                             \
> > +                -I$(UBOOT_DTSI_LOC)                                     \
> >                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
> >                  -I$(srctree)/include                                    \
> >                  -D__ASSEMBLY__                                          \
> > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >         $(DTC) -O dtb -o $@ -b 0 \
> > -               -i $(dir $<) $(DTC_FLAGS) \
> > +               -i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
> >                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> >                 ; \
> > --
> > 2.34.1
> >
>
> Regards,
> Simon

