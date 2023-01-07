Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.10057.1673050471571534458
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Jan 2023 16:14:31 -0800
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4bf16baa865so42218297b3.13
        for <u-boot-amlogic@groups.io>; Fri, 06 Jan 2023 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+hKJVlKnPnW7JAVs4WmU+hp4/2yGYs8T/Cc0bvjlV4=;
        b=X3EypemoEmNB/dtMz9fGusACwwM7N1P0MCDtaZdeOW//o8n2DHu5RZYEgjIFwpXKyy
         GYD7TFBxtqrH/KBAT6szXF6w0U8SizB5ejcDV0l4UYBMc1q0a9Kh3QS20HHn3DfMoQll
         h4dxB935KNSqUTIJapeZ2PtaHCqMyCu7D+Ryc=
MIME-Version: 1.0
References: <20230103215004.22646-1-agraf@csgraf.de> <20230103215004.22646-10-agraf@csgraf.de>
In-Reply-To: <20230103215004.22646-10-agraf@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Jan 2023 17:13:40 -0700
Message-ID: <CAPnjgZ31HQ8jQicS0xRDCXrRGf30cA8kummDRcKUgcAEs0ESmw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] video: Enable VIDEO_DAMAGE for drivers that need it
Content-Type: text/plain; charset="UTF-8"
To: Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Alex,

On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>
> Some drivers call video_set_flush_dcache() to indicate that they want to
> have the dcache flushed for the frame buffer. These drivers benefit from
> our new video damage control, because we can reduce the amount of memory
> that gets flushed significantly.
>
> This patch enables video damage control for all device drivers that call
> video_set_flush_dcache() to make sure they benefit from it.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> ---
>  arch/arm/mach-omap2/omap3/Kconfig | 1 +
>  arch/arm/mach-sunxi/Kconfig       | 1 +
>  drivers/video/Kconfig             | 9 +++++++++
>  drivers/video/exynos/Kconfig      | 1 +
>  drivers/video/imx/Kconfig         | 1 +
>  drivers/video/meson/Kconfig       | 1 +
>  drivers/video/rockchip/Kconfig    | 1 +
>  drivers/video/stm32/Kconfig       | 1 +
>  8 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
> index 3e97ec2629..ea231f16a2 100644
> --- a/arch/arm/mach-omap2/omap3/Kconfig
> +++ b/arch/arm/mach-omap2/omap3/Kconfig
> @@ -113,6 +113,7 @@ config TARGET_NOKIA_RX51
>         select CMDLINE_TAG
>         select INITRD_TAG
>         select REVISION_TAG
> +       select VIDEO_DAMAGE

Please avoid using select since it means that boards cannot disable it.

You can use 'imply' instead.

Or you can use 'default y' for the damage Kconfig.

Regards,
Simon
