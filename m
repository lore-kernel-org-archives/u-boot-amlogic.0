Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.7773.1675154968005708700
 for <u-boot-amlogic@groups.io>;
 Tue, 31 Jan 2023 00:49:28 -0800
Received: by mail-wm1-f50.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7183377wms.4
        for <u-boot-amlogic@groups.io>; Tue, 31 Jan 2023 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wXnWrCSfmKHXyHyEyKR6+nPof2YNF/a3hvAiMxEXsxY=;
        b=R7HMg8GwUGfpkOjLvf/cONGYi/ImFPzyCYpfDCRB+3tb2Jw0QSbtMS75eJ1a6ywzeI
         nWY2SzZzMAtwSzqylCrAHKWAw+DW8hL/qhEj7kSCPhnPf0J9aX1IY5J8CCyA+hP03F0O
         EFkSEO2Sj2/HWk/CcV6Kscufq2QvYe+vzeOsIISf656r/B/PPa+pn59jc/HO36vaEjKA
         Cmo7m0ecQtw2jeSNotT9aYoxiX8SlQdsGQUyumTtsjiIRJPnpTfWO0U8OCch4m5K/HJm
         YbbXYOlV5j29hCxmwflZXqPsS+N1py70lELz1UjpZkSA7GeEDwaVcxv1+ZiH6iiDJORB
         blLg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <8e5d713d-fb6b-8cf7-e758-5898076708d3@linaro.org>
Date: Tue, 31 Jan 2023 09:49:25 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 160/171] Correct SPL uses of USB_DWC3_MESON_GXL
References: <20230130151612.212732-102-sjg@chromium.org>
 <20230130151612.212732-161-sjg@chromium.org>
In-Reply-To: <20230130151612.212732-161-sjg@chromium.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 30/01/2023 16:16, Simon Glass wrote:
> This converts 2 usages of this option to the non-SPL form, since there is
> no SPL_USB_DWC3_MESON_GXL defined in Kconfig
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arm/mach-meson/board-axg.c | 2 +-
>   arch/arm/mach-meson/board-gx.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
> index 236ec815799..8bcb0b3a212 100644
> --- a/arch/arm/mach-meson/board-axg.c
> +++ b/arch/arm/mach-meson/board-axg.c
> @@ -91,7 +91,7 @@ static struct mm_region axg_mem_map[] = {
>   
>   struct mm_region *mem_map = axg_mem_map;
>   
> -#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
> +#if IS_ENABLED(CONFIG_USB_DWC3_MESON_GXL) && \
>   	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
>   static struct dwc2_plat_otg_data meson_gx_dwc2_data;
>   
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index 01fafd81c48..41f767302ec 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -109,7 +109,7 @@ static struct mm_region gx_mem_map[] = {
>   
>   struct mm_region *mem_map = gx_mem_map;
>   
> -#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
> +#if IS_ENABLED(CONFIG_USB_DWC3_MESON_GXL) && \
>   	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
>   static struct dwc2_plat_otg_data meson_gx_dwc2_data;
>   

This code is getting removed in the last PR I sent at https://lore.kernel.org/all/ec3802ba-6e79-5370-e41e-cd2487cd618f@linaro.org/
