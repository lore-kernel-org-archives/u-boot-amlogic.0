Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web11.10071.1673050498841565772
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:58 -0800
Received: by mail-yb1-f169.google.com with SMTP id 203so3506738yby.10
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAQcoOR82t3pwyNwvvAM7lFOeUMHsg8SJVGf5m5TpRQ=;
        b=TGgQXD4j61owrlYCR+O645TUts7ZV6HPIHer7YcsV6lrm+vGmF5GZfWwGgpoZdrpy9
         9QXEBS8cvhtR8oSg3PrqPdFn/amKkcYQtM3DpZVTdDOwu+4dwQnfk2M3uFLIaErBk+aG
         YEyJz0umGaDQbPfkZelJyLjzVPGWYCFy7wmk8=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-9-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-9-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:39 -0700
Message-ID: <CAPnjgZ3xAuGooVVhvqsqe9hA_6CSo0sT_6h2+XGF-qnETC9PWA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] video: Always compile cache flushing code
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> The dcache flushing code path was conditional on ARM && !DCACHE config
> options. However, dcaches exist on other platforms as well and may need
> clearing if their driver requires it.
>
> Simplify the compile logic and always enable the dcache flush logic in
> the video core. That way, drivers can always rely on it to call the arch
> specific callbacks.
>
> This will increase code size for non-ARM platforms with CONFIG_VIDEO=y
> slightly.
>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> ---
>  drivers/video/video-uclass.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
