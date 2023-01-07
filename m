Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.9990.1673050428519748550
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:13:48 -0800
Received: by mail-ej1-f42.google.com with SMTP id qk9so7028112ejc.3
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lpSg6EMmTZvLheMvEeU4/lANzpxRiekO0KSW4dQmRs=;
        b=lL6q8+Kuva74IvjDXKpVAAL83+h/DxXsZBhzO+rz+sVdV1ZBY5Bhcf3jU/+gXysHNc
         CdOOD+fDuAW6qN02sTQeLL64KfkgbAz8M8bw+jB4Y3TQh5TeB5sDyEhdyTafPfCFvyN6
         9YfU6t8YxpJo8RLH8xCDAfqITXvE17lEteKSs=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-3-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-3-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:31 -0700
Message-ID: <CAPnjgZ0Ca3yJSWs6fj8eh+-M=KHtRuLtia-hCXBEKX58EZVY0w@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] dm: video: Add damage notification on display clear
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> Let's report the video damage when we clear the screen. This
> way we can later lazily flush only relevant regions to hardware.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> ---
>  drivers/video/video-uclass.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
