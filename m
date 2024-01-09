Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF8C4725D
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 08:47:47 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web11.10481.1704776940026509576
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Jan 2024 21:09:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CO1yQCkL;
 spf=pass (domain: linaro.org, ip: 209.85.210.50, mailfrom: sumit.garg@linaro.org)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc035ee106so1672064a34.3
        for <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 21:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704776939; x=1705381739; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mms3BAEVl3p07ppv3W8+q853INrtQ1XzDvXKNxchagM=;
        b=CO1yQCkLS+IKifkDUFC8BLrJI1739DZ6B4jXgy7a+fiH5zi5jcKQQWGLVnomkjSihM
         UjLhwLOWOE1qG5GPFMwMZhEOB6ibe9JcGps7U1wph15ziIQnO3A8x4iZIT37GHW73RWL
         8FfBOzkix72GVky57zewLt2iUjIJ76u7bDwxNfXG2OtlWUV6pqAbBTtOjUGRb9yoaBYZ
         KkqiVr1zYiaD9uRDDAW8SoPpDvGVLQ6qkPblSJwLWJDDb3qJF0NqYfDAmUnUWZGNEkE+
         ILgxs7x6H61Y/RRa8IdBwd1pO++ES/gA6HpMVs4FlO3J0UXZ+wY8XUqN4ImzXEebVzNd
         BEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704776939; x=1705381739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mms3BAEVl3p07ppv3W8+q853INrtQ1XzDvXKNxchagM=;
        b=J3uJJmCG9bedka79mmizRG3ZJnGVXiCJGkMf2ZjEoJxA8frSrDLsExr+9izijz9zN1
         2XMX0+9aXuZ2ng7GaRNOYR8nWBVb5iF1mqgGtzx/bCDidtL4Sss0u4rP3Z7u2aRzHxCc
         PnRnmDMXCkIMfc6Jr+8uTonYIte94hI8wx+pC6NrXGfpsnu7zwwoA2Z7E2bl2Orp53cQ
         iJZ26U0doaXI1uqEEaPByMOTBIm0quMkl6K1EjN5+aCCGf8q5Pp34GI9xh6Egd68PXiF
         SCku3usi91Yg+nratL3f8e8xwLYHNDu0gwW9tTeFwsxj3jRkvDIsFe19WKkWcdgBMNm+
         E2FA==
X-Gm-Message-State: AOJu0YxE8uhjEOAImNQTSL/xHzIhOc1QJ0Ht5f7QC0gc3T67hTjhS2c4
	iTSSySNPvke6FB3gLBDursuow/UaYX8iM8huDMojYsgaytnSDw==
X-Google-Smtp-Source: AGHT+IGHnH0QzjHeQrV4B3qFkX8/sYv913QDnYOFZmaTTHU0AJUWD0DFpr3X2/0HchKY1xZ7evhqSy2r2ICqYFtwMcY=
X-Received: by 2002:a05:6830:4787:b0:6da:3409:fd90 with SMTP id
 df7-20020a056830478700b006da3409fd90mr3014641otb.62.1704776939291; Mon, 08
 Jan 2024 21:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-4-sumit.garg@linaro.org> <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
 <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com> <20240109015419.f6lwlhkudqy7uvly@bryanbrattlof.com>
In-Reply-To: <20240109015419.f6lwlhkudqy7uvly@bryanbrattlof.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 9 Jan 2024 10:38:48 +0530
Message-ID: <CAFA6WYM5P_8OaFuOMGwqCFFBwGwAui_uyVPX+gPFDsKFT_eePA@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 08:47:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2051

On Tue, 9 Jan 2024 at 07:24, Bryan Brattlof <bb@ti.com> wrote:
>
> On January  8, 2024 thus sayeth Sumit Garg:
> > Hi Bryan,
> >
> > On Sat, 6 Jan 2024 at 02:12, Bryan Brattlof <bb@ti.com> wrote:
> > >
> > > Hi Sumit!
> > >
> > > On December 28, 2023 thus sayeth Sumit Garg:
> > > > Allow u-boot to build DTB from a different directory tree such that
> > > > *-u-boot.dtsi files can be included from a common location. Currently
> > > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > > location.
> > > >
> > > > This is needed for platform owners to start building DTB files from
> > > > devicetree-rebasing directory but still being able to include
> > > > *-u-boot.dtsi files.
> > > >
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > >
> > > ...
> > >
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 27b9437027c..09330421856 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > >
> > > ...
> > >
> > > >  # Uncomment for debugging
> > > > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> > > >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> > > >                $(UBOOTINCLUDE)                                         \
> > > >                -I$(dir $<)                                             \
> > > > +              -I$(u_boot_dtsi_loc)                                     \
> > > >                -I$(srctree)/arch/$(ARCH)/dts/include                   \
> > > >                -I$(srctree)/include                                    \
> > > >                -D__ASSEMBLY__                                          \
> > > > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> > > >         echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> > > >       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> > > >       $(DTC) -O dtb -o $@ -b 0 \
> > > > -             -i $(dir $<) $(DTC_FLAGS) \
> > > > +             -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> > > >               -d $(depfile).dtc.tmp $(dtc-tmp) || \
> > > >               (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> > > >               ; \
> > >
> > > One of the issues I see with having a separate OF_UPSTREAM and U-Boot dt
> > > directory is when we have U-Boot board files that use dtsi files in the
> > > OF_UPSTREAM folder.
> > >
> > > For example our reference boards uses the primary bootloader's dtb (eg:
> > > k3-am62a7-r5-sk.dts) which #includes the k3-am62a7-sk.dts that will be
> > > found in the OF_UPSTREAM directory and modifies it to give it the
> > > perspective of the micro-controller it will be running on during boot.
> >
> > Thanks for bringing this up. I have been playing with the idea to
> > reuse DT includes from upstream.
> >
> > >
> > > What do you think if we have both paths included regardless if
> > > OF_UPSTREAM is selected or not? IDK if this will break anyone else
> >
> > Sure, we should be able to do that if we maintain the correct order of
> > include paths as per following patch [1]. If this works for you let me
> > know and I will include it for v4.
> >
>
> This works beautifully.
>
> I did have to hack around to get Makefile.spl working but this is headed
> in the right direction for me :)

Thanks for testing. I hope I can take that as a tested-by tag for this patch.

-Sumit

>
> Thank you
> ~Bryan

