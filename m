Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.9996.1673050454264273409
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:38 -0800
Received: by mail-yb1-f170.google.com with SMTP id j206so3552144ybj.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBH+N5sW9ZV4cqPQF4JOwEm501eXtSezEi905kpazbI=;
        b=d2EpE/4lXwes6TBX1Dc4CTfiJ9NmlXZJJb1MDodoY5WpNkk9wadYhwpCRWvovtwmCB
         OF14wROURpbDBacyBwNvW4Yf2SgUHv8ic5TUjd8/Va7poxr7IpD5v6zWV5gh+TC9EGKc
         ofnFpYH5SJukFq4XDwh7o8we/QZSoTzuZKvNw=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-4-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-4-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:32 -0700
Message-ID: <CAPnjgZ0+ApQYVHnNNV=Yfp_YDsFuzi52s_sUAzd3dQgsQyyp-A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] vidconsole: Add damage notifications to all vidconsole drivers
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> Now that we have a damage tracking API, let's populate damage done by
> vidconsole drivers. We try to declare as little memory as damaged as
> possible, with the exception of rotated screens that I couldn't get my
> head wrapped around. On those, we revert to the old behavior and mark
> the full screen as damaged on every update.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
>
> ---
>
> v1 -> v2:
>
>   - Fix ranges in truetype target
>   - Limit rotate to necessary damange
> ---
>  drivers/video/console_normal.c   | 10 ++++++
>  drivers/video/console_rotate.c   | 54 ++++++++++++++++++++++++++++++++
>  drivers/video/console_truetype.c | 15 +++++++++
>  3 files changed, 79 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
