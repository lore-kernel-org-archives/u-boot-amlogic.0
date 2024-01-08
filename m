Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0837C47DB1
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:32 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web11.1832.1704698314683899935
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Jan 2024 23:18:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=EKngyjIR;
 spf=pass (domain: linaro.org, ip: 209.85.222.53, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cdef012c0eso365611241.2
        for <u-boot-amlogic@groups.io>; Sun, 07 Jan 2024 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704698313; x=1705303113; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3IJUtLA31KDEmQZJf2wIpr2FmV2YYPsu2bBaA+p5br4=;
        b=EKngyjIR2T85m8f4+0/23VmpFwkVAWp9G7HxetT8IsLFkklYPVVHeXMxzOvPVnqMYN
         Bi3AaDet/GyKFxRD5PrnmlWv+CW45YxXdE2tu3LIv1388kqI8taA6M6Rh0gyjpNTBj7T
         edjhvcyv6eJAEPjZ0c1zwn0fjWyGaDCp3poBaQlaB8s86fPILp3/z8ZviQV+7bWNjQ+C
         BHo+r+hMBzo6UYvEzcC+SpMaqHo6gaRrGha2kGa4h7VZS3oeefDeXvhiBnfYfc+xRsT/
         q2vtsMfz7bm7FcUWKLu/R8YXbxzg7OAFpyYB4NxzbkDs5IyQunExkYr4zukksDVP0Bkq
         9sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704698313; x=1705303113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IJUtLA31KDEmQZJf2wIpr2FmV2YYPsu2bBaA+p5br4=;
        b=r+hhqC9ZZlYqLifgjOPeWGZ9CqaIqM3gwIHMb3qxgLWVtRuknsnDbN4QW9FSS0yvT+
         aASBsAtHlPuSVuYBo4H0bx0bIFov9NqGOurEYafENpcwDEeOpygOrMhwcRLM5yb+6Xb7
         cKEfUDkLtfQSDpln2TPc/U4t9czdijBNRMF58J6KFUBTNzGiSCeP2Ka61rnCy5MGTmou
         LD9wko2sW9D14L6qNcuUoJHBiPGMd2CfKiHpO9YTJXFhWnAp8/54nNFiqZO30b7PQzAB
         auCaHyblU/97orYBcJoWYx74wN0czSh+8+yEjwYIkmiuHYaplrseZI5Fc9Yg77MMin+k
         GF4Q==
X-Gm-Message-State: AOJu0YxB6fawjrVdc5Pjl6lLk00I3OJcyDwaH+e6aKIzEgW5H5tAp5mV
	PoonhBEFmGyKQW8dhCqQDThIfv3x2hgfDLSEVH/dm7dhRSTMfA==
X-Google-Smtp-Source: AGHT+IEqifHfiawO1ux4wVSt0x4QBRSGCEXwFGMXQJVkCVeLcEt+yYRhusHGoVOekYV9T4VLUAIfePeDLXIv22KwSb8=
X-Received: by 2002:a05:6102:32c1:b0:467:b9e2:6898 with SMTP id
 o1-20020a05610232c100b00467b9e26898mr1298185vss.34.1704698313671; Sun, 07 Jan
 2024 23:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-4-sumit.garg@linaro.org> <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
In-Reply-To: <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 8 Jan 2024 12:48:22 +0530
Message-ID: <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2047

Hi Bryan,

On Sat, 6 Jan 2024 at 02:12, Bryan Brattlof <bb@ti.com> wrote:
>
> Hi Sumit!
>
> On December 28, 2023 thus sayeth Sumit Garg:
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
>
> ...
>
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 27b9437027c..09330421856 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
>
> ...
>
> >  # Uncomment for debugging
> > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> >                $(UBOOTINCLUDE)                                         \
> >                -I$(dir $<)                                             \
> > +              -I$(u_boot_dtsi_loc)                                     \
> >                -I$(srctree)/arch/$(ARCH)/dts/include                   \
> >                -I$(srctree)/include                                    \
> >                -D__ASSEMBLY__                                          \
> > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >         echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >       $(DTC) -O dtb -o $@ -b 0 \
> > -             -i $(dir $<) $(DTC_FLAGS) \
> > +             -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> >               -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >               (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> >               ; \
>
> One of the issues I see with having a separate OF_UPSTREAM and U-Boot dt
> directory is when we have U-Boot board files that use dtsi files in the
> OF_UPSTREAM folder.
>
> For example our reference boards uses the primary bootloader's dtb (eg:
> k3-am62a7-r5-sk.dts) which #includes the k3-am62a7-sk.dts that will be
> found in the OF_UPSTREAM directory and modifies it to give it the
> perspective of the micro-controller it will be running on during boot.

Thanks for bringing this up. I have been playing with the idea to
reuse DT includes from upstream.

>
> What do you think if we have both paths included regardless if
> OF_UPSTREAM is selected or not? IDK if this will break anyone else

Sure, we should be able to do that if we maintain the correct order of
include paths as per following patch [1]. If this works for you let me
know and I will include it for v4.

[1]

commit 7fcebc044c69c57b43ff0e59f2d8c3713bc68b6c
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Tue Jan 2 19:20:01 2024 +0530

    Makefile: Allow upstream DT subtree to provide DT includes

    Allow platforms to reuse DT headers and dtsi includes directly form
    upstream DT subtree which will be frequently synced with Linux kernel.
    This will further allow us to drop corresponding DT includes copy from
    U-Boot tree.

    Also, since the DT includes from upstream DT subtree are done after DT
    includes from U-Boot tree, so it shouldn't cause any conflicts.

    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

diff --git a/Makefile b/Makefile
index d8d168cd4c3..0160e827a29 100644
--- a/Makefile
+++ b/Makefile
@@ -834,7 +834,8 @@ UBOOTINCLUDE    := \
                                -I$(srctree)/arch/arm/thumb1/include), \
                        -I$(srctree)/arch/arm/thumb1/include)) \
        -I$(srctree)/arch/$(ARCH)/include \
-       -include $(srctree)/include/linux/kconfig.h
+       -include $(srctree)/include/linux/kconfig.h \
+       -I$(srctree)/devicetree-rebasing/include

 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 09330421856..30033092597 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,12 +189,17 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)

 # Modified for U-Boot
+upstream_dtsi_include = $(addprefix -I, $(srctree)/devicetree-rebasing/src/ \
+       $(sort $(dir $(wildcard
$(srctree)/devicetree-rebasing/src/$(ARCH)/*/*))) \
+       $(if (CONFIG_ARM64), \
+                $(sort $(dir $(wildcard
$(srctree)/devicetree-rebasing/src/arm64/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
                 $(UBOOTINCLUDE)                                         \
                 -I$(dir $<)                                             \
                 -I$(u_boot_dtsi_loc)                                     \
                 -I$(srctree)/arch/$(ARCH)/dts/include                   \
                 -I$(srctree)/include                                    \
+                $(upstream_dtsi_include)                                \
                 -D__ASSEMBLY__                                          \
                 -undef -D__DTS__

-Sumit

