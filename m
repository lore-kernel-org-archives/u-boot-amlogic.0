Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEAC48290
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
 by mx.groups.io with SMTP id smtpd.web11.12799.1704265597025325151
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 23:06:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=a0s8+y/V;
 spf=pass (domain: linaro.org, ip: 209.85.222.45, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cbf6ce782dso2536266241.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 23:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704265596; x=1704870396; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9iZV2kIycubkmLu8d5N7ka3Gkkzpn2prTWz5v3x4AI=;
        b=a0s8+y/VDaISbgcgIFP8S4wM9aR69aWdr+XZ7lAwR49mo8byhReliiSDDMmaFDt6ys
         piFVx9t26GwGJzCsxMGcVKMFg7XW56464EKoT7DyFX0yuauZQiF9yWZwwTP3y8Ov6dbD
         xrhf36qFdt+R6tGIw9sS/u5gTc59HIcr2s7nvfCpl5JMQ156PC94Y+mvfiwpWxu22a+i
         Au5f1bVAkoCqf14clGhdiBqrpKFPQI3baBzoeqq6yqk4HAks791PvUsUOreBXTPg6sJF
         WuGBKMXGRvXto08YNwp0NxqnG66ZAKALKQYgVoJcKUrrQwpO5hsjLhxN2HdLoCoOqRqE
         WUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704265596; x=1704870396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9iZV2kIycubkmLu8d5N7ka3Gkkzpn2prTWz5v3x4AI=;
        b=kmnSqDUSQjMWsRTDjQZR91hPhyChAICzin/nb0uYcPE2tmT0SSeNO3QcwOn2apS/6T
         ghJViQc408Gvws7zEXFDMEHBxVRhE9iSslAMOK5zB07aXloEuW6QjHW2KK3MFfNMC/8W
         hMQ/nbKJnfS4BVTZ+htIvaO549mgoofKuq/RBhzxj41gS9kTKOWyx3FV5r6/MmT55oGk
         rxPiCW+zIq2XmUJzsK0I4paBKB1swo7pPivSLNDDfT4LXZfYP2VSgN2lhn/s1THzeT6s
         I4VoNxbp2dXuyKEkwUw6KQQCUBaZl6543GnJ8/ixNQAiflbO4IOj/ZAwRtlh8/ivJkhd
         QrBg==
X-Gm-Message-State: AOJu0YzWl6AvQB0fNe0r84lrCnQZdlXhn/Axg1g6H2cORy8N57ntMVWe
	nFV2fzIXKTD3UCP4tEzoX+w1kRzTewNYo5ISGhN2iwhfRSfN3A==
X-Google-Smtp-Source: AGHT+IGn+0QI9GuO8rpjzWKrXtA/t1PwArbspMNxFYdG5JXnmsgx1krhFOwzYhCtl6/Deh7/FpmcNmz6aYN78bYRtKE=
X-Received: by 2002:a05:6102:3d84:b0:467:2212:a42c with SMTP id
 h4-20020a0561023d8400b004672212a42cmr6835062vsv.26.1704265595932; Tue, 02 Jan
 2024 23:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat> <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
In-Reply-To: <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Jan 2024 12:36:24 +0530
Message-ID: <CAFA6WYNS03gLmOoPb7tawkD__MJ7NW_iewg5w3hWvwnQu-iw0Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2027

On Tue, 2 Jan 2024 at 21:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
<snip>
>
> > 3. Adjust the build system to use the dts/ directory for .dts files
> > when OF_UPSTREAM is enabled
> >
> > Then it will be easy. People can enable OF_UPSTREAM for an SoC
> > (without changing DEFAULT_DEVICE_TREE)
>
> I am still not sure what we will gain via keeping DEFAULT_DEVICE_TREE
> the same. However, without a per vendor directory Makefile like:
> dts/arch/arm64/<vendor>/Makefile it won't be possible. But to do that
> we won't be able to softlink vendor directories from DT rebasing tree
> but rather have to softlink every board DTS file which is much more
> painful.

Even after this you have to tell <vendor> name via DEFAULT_DEVICE_TREE
because the DTB path is constructed via:

DEVICE_TREE ?= $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%)
ifeq ($(DEVICE_TREE),)
DEVICE_TREE := unset
endif

ifeq ($(CONFIG_OF_UPSTREAM),y)
ifeq ($(CONFIG_ARM64),y)
dt_dir := dts/arch/arm64
else
dt_dir := dts/arch/$(ARCH)
endif
else
dt_dir := arch/$(ARCH)/dts
endif

ifneq ($(EXT_DTB),)
DTB := $(EXT_DTB)
else
DTB := $(dt_dir)/$(DEVICE_TREE).dtb
endif

So with a move to Linux directory structure for dts directory,
DEFAULT_DEVICE_TREE have to specify <vendor>/<name> as DT filename.

-Sumit

>
> > and will get the same behaviour
> > as now, just with upstream .dts files. All the .dts files for an SoC
> > are built, as now, just as Linux does. We can continue cleaning up the
> > DT build rules as time permits.
>
> I will reiterate here, we can decide to add Makefile rules on a case
> by case basis. If there is a need (from packaging perspective or a
> particular SoC supports a generic U-Boot image) then we should be able
> to add them. The cleanup would be automatically part of the process as
> we switch SoCs to OF_UPSTREAM.
>
> -Sumit
>
> >
> > Regards,
> > Simon
> >
> > [1] http://patchwork.ozlabs.org/project/uboot/list/?series=388154
> > [2] https://git.pengutronix.de/cgit/barebox/tree/dts

