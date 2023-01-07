Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.10062.1673050481705581581
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:41 -0800
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4b6255ce5baso42364727b3.11
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bd7UBhsAwbyOt1kCOGuYuLUTMIjEItxb7m/t74Qf/W8=;
        b=NrxxP0tZoZBSq0lc9wl44t4nGesWsUHXgqeElcrdqr1uq/OiBKPLlooCbTymV/Ydot
         hsU9FeNNeZIqe64YZ2kzTUI/iPBvmh214hs6GJEJTFU6SPhz013LZrhUbtQVP9WmuWWR
         A6764Ve2IltNrNiwQzSaOsOtpHYC/pUDCnmt0=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-8-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-8-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:35 -0700
Message-ID: <CAPnjgZ1uDNY4T65Q4EdW-xRnFiGhvWcCs=YtcwLCpRbZpTNJQg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] video: Use VIDEO_DAMAGE for VIDEO_COPY
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Alexander,

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> CONFIG_VIDEO_COPY implemented a range based copying mechanism: If we

range-based

> print a single character, it will always copy the full range of bytes
> from the top left corner of the character to the lower right onto the
> uncached frame buffer. This includes pretty much the full line contents
> of the printed character.
>
> Since we now have proper damage tracking, let's make use of that to reduce
> the amount of data we need to copy. With this patch applied, we will only
> copy the tiny rectangle surrounding characters when we print them,
> speeding up the video console.
>
> As a bonus, we remove a lot of code.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>
> ---
>
> v2 -> v3:
>
>   - Rebase
>   - Make CONFIG_COPY always select VIDEO_DAMAGE
> ---
>  drivers/video/Kconfig             |  5 ++
>  drivers/video/console_normal.c    | 14 +----
>  drivers/video/console_rotate.c    | 37 ++-----------
>  drivers/video/console_truetype.c  | 17 +-----
>  drivers/video/vidconsole-uclass.c | 16 ------
>  drivers/video/video-uclass.c      | 91 ++++++++-----------------------
>  drivers/video/video_bmp.c         |  7 ---
>  include/video.h                   | 37 -------------
>  include/video_console.h           | 49 -----------------
>  9 files changed, 37 insertions(+), 236 deletions(-)
>

This feature needs some tests in test/dm/video.c

For sandbox, I think you will need to allow it to be enabled /
disabled at runtime, so the some tests can use it and some not?

Regards,
Simon
