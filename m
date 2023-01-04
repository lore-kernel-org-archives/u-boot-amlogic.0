Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.10837.1672835574028072486
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:32:54 -0800
Received: by mail-wm1-f44.google.com with SMTP id o15so25424404wmr.4
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsd9Joc7eUwkOZ4AJBpZWHOmVFjfsgrK79de1YKC/tQ=;
        b=ueTBMsdtGCkDjJ8wcA7V0zoyD4AD8ond/7gwQ3Ez/WuT7W98ezNwdhKT/UeDvb7exb
         XF4G0Am4G6w0gR0ARvhGrAEKdx2dm70JwkJ2J4JU10TVn2orlUDbZpEhm2+k0ZCo3vnU
         KFzqwHnn+Nd6os0Ty9hMST2gl+c7f8XVk7kMW1ocCDHR3GuChil082+lyv8c5jFakOST
         Ga0MCmIJ0swXih7B1pCqgGxfKPFHk2SAsLvEdQcs9sGHPXm+EAUsWKiDMdT6TBTVpLQq
         nAlxKDN8FU4Wm5hU0MqAtk3LwqOH+GIqWKX/Xy/1Mno7lFuBsc/zcP2HmzmP3CKIKAU9
         OShg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <694949c8-f142-aee3-4741-84330f73f54a@linaro.org>
Date: Wed, 4 Jan 2023 13:32:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 9/9] video: Enable VIDEO_DAMAGE for drivers that need it
References: <20230103215004.22646-1-agraf@csgraf.de>
 <20230103215004.22646-10-agraf@csgraf.de>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230103215004.22646-10-agraf@csgraf.de>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Alexander Graf <agraf@csgraf.de>, u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Le 03/01/2023 à 22:50, Alexander Graf a écrit :
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
>   arch/arm/mach-omap2/omap3/Kconfig | 1 +
>   arch/arm/mach-sunxi/Kconfig       | 1 +
>   drivers/video/Kconfig             | 9 +++++++++
>   drivers/video/exynos/Kconfig      | 1 +
>   drivers/video/imx/Kconfig         | 1 +
>   drivers/video/meson/Kconfig       | 1 +
>   drivers/video/rockchip/Kconfig    | 1 +
>   drivers/video/stm32/Kconfig       | 1 +
>   8 files changed, 16 insertions(+)
> 

<snip>

> --- a/drivers/video/meson/Kconfig
> +++ b/drivers/video/meson/Kconfig
> @@ -8,5 +8,6 @@ config VIDEO_MESON
>   	bool "Enable Amlogic Meson video support"
>   	depends on VIDEO
>   	select DISPLAY
> +	select VIDEO_DAMAGE
>   	help
>   	  Enable Amlogic Meson Video Processing Unit video support.

For Amlogic:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

<snip>
