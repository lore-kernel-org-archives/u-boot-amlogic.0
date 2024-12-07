Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3EE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 09:24:57 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.70157.1733615003584786520
 for <u-boot-amlogic@groups.io>;
 Sat, 07 Dec 2024 15:43:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=cXk6AMXI;
 spf=pass (domain: chromium.org, ip: 209.85.218.53, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa560a65fd6so583709666b.0
        for <u-boot-amlogic@groups.io>; Sat, 07 Dec 2024 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733615002; x=1734219802; darn=groups.io;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJIhuMAWzV8raRAv1jJAZT5DP5cIG7000jONP2NFqBk=;
        b=cXk6AMXIUUrdd389iXGNuWLLfz6VmQI7mXh/s1XmTeyYkVrG/sJ3K6bhKT1qLZrxzt
         C3j+J/ngMdUw95Sxs4WzcHYWwxaz+q9HBu6BJLBfqgFPRQ3+wND1kh3zkNUDWAWxf9Ch
         DRP3txrMAb1q0Po/QR64YTQlcvqBha5AFwtf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733615002; x=1734219802;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJIhuMAWzV8raRAv1jJAZT5DP5cIG7000jONP2NFqBk=;
        b=xU2mPsfkJWkqmZ4Ye1qD6C6WDtxEmuuxuIRajxH/2Yi8mpOIA8HmsC233DeT2pIXzK
         +KPwvdbVDGqliqFTNouN1KPanTRfxyBLcpAlEdM3Qa8ilKk+pq8AUFigQl5Ionbhz0OK
         vozITSdVOPvC4LRl+Kk7ZD1Fds0+xLeXb7Ru2/ZEpmlO8oBLeHbUzyIWhB20le1SsKe8
         JlrLIWzfmP7z3y4ETeMLQkHiwZRi2gyEmtCyr7D4Wuj0Gas5ysTVLnYo1oKpC9r3Dgog
         0ssfMoX4MLIqjsUF/mdmQm1pDnW/KPewlinx142OWwu5tMG0JLG2Bge9S/hlpIsEBujy
         3IjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcI8njYPHiiJRks5/RRz7YULl7mVqLcZLnq8zei83eErif+RGiXk9EO9/K+jeU/qYU34o3oXo2w3xC0DUDw==@groups.io
X-Gm-Message-State: AOJu0YzI11Zyb9yd3f2lTPBqEJBXkO0JF7vjjGol1FzR2RO7RelKgrSY
	fYIUtBptNmamZ5uGJw2rn5pYs4CdDqX5jTsgk+B771N6JIC5HL5S2s+uUFZf7VPn+S/O1NsQGbJ
	AZa2+5qbnWZ+pAbUG2iFL7CqRC7xxvZS5jrun
X-Gm-Gg: ASbGnctWSvUEfUXHIqs/smthB95kexmRE7P7SkgbbzmPag75ybvM57aIv7FWTlCOfv0
	2b2xfiAOyIe/gzfIifPfm89noDi5Kqztb
X-Google-Smtp-Source: AGHT+IHAMN9I8KQXAfG6e5u6VUP6pyv2OADyqO/u7npItgclDHcsKtlK9yh4KNj4zcb/jlRbovX9KNG8rQyXSs/z1Kg=
X-Received: by 2002:a17:906:2929:b0:aa5:f2c0:2378 with SMTP id
 a640c23a62f3a-aa6373a1bf4mr811424866b.13.1733615001794; Sat, 07 Dec 2024
 15:43:21 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 16:43:10 -0700
Message-ID: <CAFLszThXbhVtYqi27BtKv6PHwVNnhvwJ5+vKQ_yMMJ33GrYd4g@mail.gmail.com>
Subject: [PATCH v5 00/13] Add video damage tracking
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Andre Przywara <andre.przywara@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>, Da Xue <da@libre.computer>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Derald Woods <woods.technical@gmail.com>, 
	Anatolij Gustschin <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com, 
	Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 10 Dec 2024 09:24:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2592

On Mon, Aug 21, 2023 at 01:50 PM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> This is a rebase of Alexander Graf's video damage tracking series, with
> some tests and other changes. The original cover letter is as follows:
>
>
> > This patch set speeds up graphics output on ARM by a factor of 60x.
> >
> > On most ARM SBCs, we keep the frame buffer in DRAM and map it as cached,
> > but need it accessible by the display controller which reads directly
> > from a later point of consistency. Hence, we flush the frame buffer to
> > DRAM on every change. The full frame buffer.
> >
> > Unfortunately, with the advent of 4k displays, we are seeing frame buffers
> > that can take a while to flush out. This was reported by Da Xue with grub,
> > which happily print 1000s of spaces on the screen to draw a menu. Every
> > printed space triggers a cache flush.
> >
> > This patch set implements the easiest mitigation against this problem:
> > Damage tracking. We remember the lowest common denominator region that was
> > touched since the last video_sync() call and only flush that. The most
> > typical writer to the frame buffer is the video console, which always
> > writes rectangles of characters on the screen and syncs afterwards.
> >
> > With this patch set applied, we reduce drawing a large grub menu (with
> > serial console attached for size information) on an RK3399-ROC system
> > at 1440p from 55 seconds to less than 1 second.
> >
> > Version 2 also implements VIDEO_COPY using this mechanism, reducing its
> > overhead compared to before as well. So even x86 systems should be faster
> > with this now :).
> >
> >
> > Alternatives considered:
> >
> >   1) Lazy sync - Sandbox does this. It only calls video_sync(true) ever
> >      so often. We are missing timers to do this generically.
> >
> >   2) Double buffering - We could try to identify whether anything changed
> >      at all and only draw to the FB if it did. That would require
> >      maintaining a second buffer that we need to scan.
> >
> >   3) Text buffer - Maintain a buffer of all text printed on the screen with
> >      respective location. Don't write if the old and new character are
> >      identical. This would limit applicability to text only and is an
> >      optimization on top of this patch set.
> >
> >   4) Hash screen lines - Create a hash (sha256?) over every line when it
> >      changes. Only flush when it does. I'm not sure if this would waste
> >      more time, memory and cache than the current approach. It would make
> >      full screen updates much more expensive.
>
>
> Changes in v5:
> - Add patch "video: test: Split copy frame buffer check into a function"
> - Add patch "video: test: Support checking copy frame buffer contents"
> - Add patch "video: test: Test partial updates of hardware frame buffer"
> - Use xstart, ystart, xend, yend as names for damage region
> - Document damage struct and fields in struct video_priv comment
> - Return void from video_damage()
> - Fix undeclared priv error in video_sync()
> - Drop unused headers from video-uclass.c
> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
> - Call video_damage() also in video_fill_part()
> - Use met->baseline instead of priv->baseline
> - Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
> - Update console_rotate.c video_damage() calls to pass video tests
> - Remove mention about not having minimal damage for console_rotate.c
> - Add patch "video: test: Test video damage tracking via vidconsole"
> - Document new vdev field in struct efi_gop_obj comment
> - Remove video_sync_copy() also from video_fill(), video_fill_part()
> - Fix memmove() calls by removing the extra dev argument
> - Call video_sync() before checking copy_fb in video tests
> - Imply VIDEO_DAMAGE for video drivers instead of selecting it
> - Imply VIDEO_DAMAGE also for VIDEO_TIDSS
>
>
> v4: https://lore.kernel.org/all/20230103215004.22646-1-agraf@csgraf.de/
>
>
> Changes in v4:
> - Move damage clear to patch "dm: video: Add damage tracking API"
> - Simplify first damage logic
> - Remove VIDEO_DAMAGE default for ARM
> - Skip damage on EfiBltVideoToBltBuffer
> - Add patch "video: Always compile cache flushing code"
> - Add patch "video: Enable VIDEO_DAMAGE for drivers that need it"
>
>
> v3: https://lore.kernel.org/all/20221230195828.88134-1-agraf@csgraf.de/
>
>
> Changes in v3:
> - Adapt to always assume DM is used
> - Adapt to always assume DM is used
> - Make VIDEO_COPY always select VIDEO_DAMAGE
>
>
> v2: https://lore.kernel.org/all/20220609225921.62462-1-agraf@csgraf.de/
>
>
> Changes in v2:
> - Remove ifdefs
> - Fix ranges in truetype target
> - Limit rotate to necessary damage
> - Remove ifdefs from gop
> - Fix dcache range; we were flushing too much before
> - Add patch "video: Use VIDEO_DAMAGE for VIDEO_COPY"
>
>
> v1: https://lore.kernel.org/all/20220606234336.5021-1-agraf@csgraf.de/
>
>
> Alexander Graf (9):
>   dm: video: Add damage tracking API
>   dm: video: Add damage notification on display fills
>   vidconsole: Add damage notifications to all vidconsole drivers
>   video: Add damage notification on bmp display
>   efi_loader: GOP: Add damage notification on BLT
>   video: Only dcache flush damaged lines
>   video: Use VIDEO_DAMAGE for VIDEO_COPY
>   video: Always compile cache flushing code
>   video: Enable VIDEO_DAMAGE for drivers that need it
>
>
> Alper Nebi Yasak (4):
>   video: test: Split copy frame buffer check into a function
>   video: test: Support checking copy frame buffer contents
>   video: test: Test partial updates of hardware frame buffer
>   video: test: Test video damage tracking via vidconsole
>
>
>  arch/arm/mach-omap2/omap3/Kconfig |   1 +
>  arch/arm/mach-sunxi/Kconfig       |   1 +
>  drivers/video/Kconfig             |  26 +++
>  drivers/video/console_normal.c    |  27 ++--
>  drivers/video/console_rotate.c    |  94 +++++++----
>  drivers/video/console_truetype.c  |  37 +++--
>  drivers/video/exynos/Kconfig      |   1 +
>  drivers/video/imx/Kconfig         |   1 +
>  drivers/video/meson/Kconfig       |   1 +
>  drivers/video/rockchip/Kconfig    |   1 +
>  drivers/video/stm32/Kconfig       |   1 +
>  drivers/video/tegra20/Kconfig     |   1 +
>  drivers/video/tidss/Kconfig       |   1 +
>  drivers/video/vidconsole-uclass.c |  16 --
>  drivers/video/video-uclass.c      | 190 ++++++++++++----------
>  drivers/video/video_bmp.c         |   7 +-
>  include/video.h                   |  59 +++----
>  include/video_console.h           |  52 ------
>  lib/efi_loader/efi_gop.c          |   7 +
>  test/dm/video.c                   | 256 ++++++++++++++++++++++++------
>  20 files changed, 483 insertions(+), 297 deletions(-)
>
>
>
> base-commit: 3881c9fbb7fdd98f6eae5cd33f7e9abe9455a585

Rebased and applied to ci/master, thanks!

