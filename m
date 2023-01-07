Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.10057.1673050471571534458
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:56 -0800
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4bf16baa865so42226467b3.13
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6MDKFfNMpUwDT4kpz1nwZ1PpW0xfg2y1jjQxeeOyrQ=;
        b=aSI1TdCmtsNjAExEa6zqfBhcefSoAR3/BEgt+QIFf3XD8ji+vuO0rKSrAPGNbI4lvK
         hn3O647iuJ1tSa0IoK2P0OPFoYWnsbbCsPpVonmq+KI/n8UlWnb8zeuI2j81t3WOxlqB
         thcU6amTUWmLLwSzVdngaqQe9967deX1EZW4Y=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-1-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:37 -0700
Message-ID: <CAPnjgZ1tg8YU5bKqnjwNRRk0A=3drrvXw8O_Sjen8ZgKeRkcaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Add video damage tracking
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Alex,

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> This patch set speeds up graphics output on ARM by a factor of 60x.
>
> On most ARM SBCs, we keep the frame buffer in DRAM and map it as cached,
> but need it accessible by the display controller which reads directly
> from a later point of consistency. Hence, we flush the frame buffer to
> DRAM on every change. The full frame buffer.
>
> Unfortunately, with the advent of 4k displays, we are seeing frame buffers
> that can take a while to flush out. This was reported by Da Xue with grub,
> which happily print 1000s of spaces on the screen to draw a menu. Every
> printed space triggers a cache flush.
>
> This patch set implements the easiest mitigation against this problem:
> Damage tracking. We remember the lowest common denominator region that was
> touched since the last video_sync() call and only flush that. The most
> typical writer to the frame buffer is the video console, which always
> writes rectangles of characters on the screen and syncs afterwards.
>
> With this patch set applied, we reduce drawing a large grub menu (with
> serial console attached for size information) on an RK3399-ROC system
> at 1440p from 55 seconds to less than 1 second.
>
> Version 2 also implements VIDEO_COPY using this mechanism, reducing its
> overhead compared to before as well. So even x86 systems should be faster
> with this now :).
>
>
> Alternatives considered:
>
>   1) Lazy sync - Sandbox does this. It only calls video_sync(true) ever
>      so often. We are missing timers to do this generically.
>
>   2) Double buffering - We could try to identify whether anything changed
>      at all and only draw to the FB if it did. That would require
>      maintaining a second buffer that we need to scan.
>
>   3) Text buffer - Maintain a buffer of all text printed on the screen with
>      respective location. Don't write if the old and new character are
>      identical. This would limit applicability to text only and is an
>      optimization on top of this patch set.
>
>   4) Hash screen lines - Create a hash (sha256?) over every line when it
>      changes. Only flush when it does. I'm not sure if this would waste
>      more time, memory and cache than the current approach. It would make
>      full screen updates much more expensive.
>
> v1 -> v2:
>
>   - new patch: video: Use VIDEO_DAMAGE for VIDEO_COPY
>   - Remove ifdefs
>   - Fix dcache range; we were flushing too much before
>   - Fix ranges in truetype target
>   - Limit rotate to necessary damange

damage

>
> v2 -> v3:
>
>   - Rebase
>   - Adapt to DM_VIDEO always
>   - Make CONFIG_COPY always select VIDEO_DAMAGE
>
> v3 -> v4:
>
>   - New patch: video: Always compile cache flushing code
>   - New patch: video: Enable VIDEO_DAMAGE for drivers that need it
>   - Simplify first damage logic
>   - Skip damage on EfiBltVideoToBltBuffer
>   - Move damage clear from patch 6 to patch 1
>   - Remove VIDEO_DAMAGE default for ARM
>
> Alexander Graf (9):
>   dm: video: Add damage tracking API
>   dm: video: Add damage notification on display clear
>   vidconsole: Add damage notifications to all vidconsole drivers
>   video: Add damage notification on bmp display
>   efi_loader: GOP: Add damage notification on BLT
>   video: Only dcache flush damaged lines
>   video: Use VIDEO_DAMAGE for VIDEO_COPY
>   video: Always compile cache flushing code
>   video: Enable VIDEO_DAMAGE for drivers that need it
>
>  arch/arm/mach-omap2/omap3/Kconfig |   1 +
>  arch/arm/mach-sunxi/Kconfig       |   1 +
>  drivers/video/Kconfig             |  27 +++++
>  drivers/video/console_normal.c    |  22 ++--
>  drivers/video/console_rotate.c    |  87 +++++++++-----
>  drivers/video/console_truetype.c  |  30 ++---
>  drivers/video/exynos/Kconfig      |   1 +
>  drivers/video/imx/Kconfig         |   1 +
>  drivers/video/meson/Kconfig       |   1 +
>  drivers/video/rockchip/Kconfig    |   1 +
>  drivers/video/stm32/Kconfig       |   1 +
>  drivers/video/vidconsole-uclass.c |  16 ---
>  drivers/video/video-uclass.c      | 187 +++++++++++++++++-------------
>  drivers/video/video_bmp.c         |   7 +-
>  include/video.h                   |  54 ++++-----
>  include/video_console.h           |  49 --------
>  lib/efi_loader/efi_gop.c          |   6 +
>  17 files changed, 251 insertions(+), 241 deletions(-)
>
> --
> 2.37.1 (Apple Git-137.1)
>

This looks good but needs tests and a rebase to -next

Regards,
Simon
