Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.9996.1673050454264273409
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:14 -0800
Received: by mail-yb1-f170.google.com with SMTP id j206so3551517ybj.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UcKdRmjHnJsvGOUA5mzn863oKdV+j+rhZ82+/ItGmQQ=;
        b=exHFDxA7VU/s/WIUIA9WENOiCXsV+OvCG4ihCnIkP5WWVCuChveTxjYvH5fxyIlWyI
         CE+U6GZdqklRv9gH4qQ8Ha48Rs7RXUjNEO+2KjS6anyQxRyhJI0qgT3iohQbwSsDUR8+
         01AVGtGCwy+FDK8tFvqayiUx1/UxzB+IJAves=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-7-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-7-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:34 -0700
Message-ID: <CAPnjgZ2Fgbt0q3DA51HiM0qezEXuT1CafXBEoWHwF6Qbq7eL8Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] video: Only dcache flush damaged lines
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> Now that we have a damage area tells us which parts of the frame buffer
> actually need updating, let's only dcache flush those on video_sync()
> calls. With this optimization in place, frame buffer updates - especially
> on large screen such as 4k displays - speed up significantly.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
>
> ---
>
> v1 -> v2:
>
>   - Fix dcache range; we were flushing too much before
>   - Remove ifdefs
>
> v3 -> v4:
>
>   - Simplify first damage logic
> ---
>  drivers/video/video-uclass.c | 45 +++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
