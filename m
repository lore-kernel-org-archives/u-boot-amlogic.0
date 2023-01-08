Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.47390.1673192940680925413
 for <u-boot-amlogic@groups.io>;
 Sun, 08 Jan 2023 07:49:01 -0800
Received: by mail-ej1-f50.google.com with SMTP id qk9so14459659ejc.3
        for <u-boot-amlogic@groups.io>; Sun, 08 Jan 2023 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+JOWs4wj4/oiFUG6FbaopMRN1qj7IG0blzXydEiJR0=;
        b=GSFFlwRxl8Hy4q2YdmnWXzVH4kQeG4JQBbWE33zyYMrj5hDlbEmgKocNFota7LPiJf
         gaARsgTZSK7EnaNQPIfsFPvsjx+ZUBTXxSdj8WbdAvOUbJpwMh4WbubhXL2nSZwyD2BV
         maIGJWauWAUgaB/jY3nXPwUw83HmFAASpGqzY=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-8-agraf@csgraf.de>
 <CAPnjgZ1uDNY4T65Q4EdW-xRnFiGhvWcCs=YtcwLCpRbZpTNJQg@mail.gmail.com> <b03e611b-2150-9bf9-0cb1-b15752ef9ae5@gmx.de>
In-Reply-To: <b03e611b-2150-9bf9-0cb1-b15752ef9ae5@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Jan 2023 08:48:47 -0700
Message-ID: <CAPnjgZ0Bw9=oVC5gy_d4x5DeWHWJt_Uyq2EdXoxbY1o1Zmzw5Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] video: Use VIDEO_DAMAGE for VIDEO_COPY
Content-Type: text/plain; charset="UTF-8"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io, Alexander Graf <agraf@csgraf.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Heinrich,

On Sat, 7 Jan 2023 at 16:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/7/23 01:13, Simon Glass wrote:
> > Hi Alexander,
> >
> > On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
> >>
> >> CONFIG_VIDEO_COPY implemented a range based copying mechanism: If we
> >
> > range-based
> >
> >> print a single character, it will always copy the full range of bytes
> >> from the top left corner of the character to the lower right onto the
> >> uncached frame buffer. This includes pretty much the full line contents
> >> of the printed character.
> >>
> >> Since we now have proper damage tracking, let's make use of that to reduce
> >> the amount of data we need to copy. With this patch applied, we will only
> >> copy the tiny rectangle surrounding characters when we print them,
> >> speeding up the video console.
> >>
> >> As a bonus, we remove a lot of code.
> >>
> >> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> >>
> >> ---
> >>
> >> v2 -> v3:
> >>
> >>    - Rebase
> >>    - Make CONFIG_COPY always select VIDEO_DAMAGE
> >> ---
> >>   drivers/video/Kconfig             |  5 ++
> >>   drivers/video/console_normal.c    | 14 +----
> >>   drivers/video/console_rotate.c    | 37 ++-----------
> >>   drivers/video/console_truetype.c  | 17 +-----
> >>   drivers/video/vidconsole-uclass.c | 16 ------
> >>   drivers/video/video-uclass.c      | 91 ++++++++-----------------------
> >>   drivers/video/video_bmp.c         |  7 ---
> >>   include/video.h                   | 37 -------------
> >>   include/video_console.h           | 49 -----------------
> >>   9 files changed, 37 insertions(+), 236 deletions(-)
> >>
> >
> > This feature needs some tests in test/dm/video.c
> >
> > For sandbox, I think you will need to allow it to be enabled /
> > disabled at runtime, so the some tests can use it and some not?
>
> It should be good enough to enable the feature in one of the sandbox
> defconfigs and disable it in another.

Yes that would work, e.g. enable in sandbox but not sandbox_flattree

Regards,
Simon
