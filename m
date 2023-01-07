Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web10.10011.1673050498829952732
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:58 -0800
Received: by mail-yb1-f172.google.com with SMTP id e21so3543796ybb.3
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nlcr1MaP75MRPGOTCNBS5WKL1SI8NFsmRCC6xIZOnY=;
        b=KZZD3fsLugLnPm/mh8lCdxfHbtduOCW1NKpUtwRyhYHnTLRG2BG1BMAIUBYyo9vATR
         DOHWwQ9gPYgIT1lDI0QGjtrlBF1xj/mqACC1O+hWSZR3thJcuG3fo8isLFNshapc6Ru/
         p+dvsQfxXnfJn3VN8QNT8mlLFi75/YMuseom0=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-5-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-5-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:33 -0700
Message-ID: <CAPnjgZ3Gd3AZyUPi_9BzWmZUYhizipXgjeg9qU1MjnJ8aiVUXA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] video: Add damage notification on bmp display
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> Let's report the video damage when we draw a bitmap on the screen. This
> way we can later lazily flush only relevant regions to hardware.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> ---
>  drivers/video/video_bmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
