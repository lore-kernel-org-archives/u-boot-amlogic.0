Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.7982.1675154983383769295
 for <u-boot-amlogic@groups.io>;
 Tue, 31 Jan 2023 00:49:43 -0800
Received: by mail-wr1-f42.google.com with SMTP id y1so13489820wru.2
        for <u-boot-amlogic@groups.io>; Tue, 31 Jan 2023 00:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=18tB/IIL8IweANTyGwc4apfI5buwobJEHFpIIW7HfnY=;
        b=yNI9H6W4yDGV9Q/FAjYaOe1Zld4a16dN+MGWb/8dhOQ8UGrYYL8BIJkRzBa3xPk5ol
         0eQL7c0IwOrLNdjR8v0t/8YgA3hKNErRKPh4j+Q7GKWUX4IRO8qtPFFZ4oFNgRsR4ioJ
         gh8ETsivcuPg4hPixD0XghO2oeaqUIL2vBMn9bYaCRTo0ix+T/kyjyHdipoShi63Kcz/
         IAKZVKpnLOSNRji1E1D+4UqLiJVPhJWzSI7EwO8Oa17DOEZ0H5Ermg2F5ZTjLgY7PVFL
         Vl8OqTUiqkVJkIzIPAge7ugmo8ob3sCsAqoH038crssLpyQS53MT35RJBOHLgdwHWq5G
         95xQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <8d27bdbd-a633-9f08-1845-7333d00e49a4@linaro.org>
Date: Tue, 31 Jan 2023 09:49:40 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 162/171] Correct SPL uses of USB_GADGET_DWC2_OTG
References: <20230130151612.212732-102-sjg@chromium.org>
 <20230130151612.212732-163-sjg@chromium.org>
In-Reply-To: <20230130151612.212732-163-sjg@chromium.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 30/01/2023 16:16, Simon Glass wrote:
> This converts 3 usages of this option to the non-SPL form, since there is
> no SPL_USB_GADGET_DWC2_OTG defined in Kconfig
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arm/mach-meson/board-axg.c  | 2 +-
>   arch/arm/mach-meson/board-g12a.c | 2 +-
>   arch/arm/mach-meson/board-gx.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
> index 8bcb0b3a212..4baf045d416 100644
> --- a/arch/arm/mach-meson/board-axg.c
> +++ b/arch/arm/mach-meson/board-axg.c
> @@ -92,7 +92,7 @@ static struct mm_region axg_mem_map[] = {
>   struct mm_region *mem_map = axg_mem_map;
>   
>   #if IS_ENABLED(CONFIG_USB_DWC3_MESON_GXL) && \
> -	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +	IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG)
>   static struct dwc2_plat_otg_data meson_gx_dwc2_data;
>   
>   int board_usb_init(int index, enum usb_init_type init)
> diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
> index d9f1acdef74..46507c6a0f9 100644
> --- a/arch/arm/mach-meson/board-g12a.c
> +++ b/arch/arm/mach-meson/board-g12a.c
> @@ -98,7 +98,7 @@ static struct mm_region g12a_mem_map[] = {
>   struct mm_region *mem_map = g12a_mem_map;
>   
>   #if IS_ENABLED(CONFIG_USB_DWC3_MESON_G12A) && \
> -	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +	IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG)
>   static struct dwc2_plat_otg_data meson_g12a_dwc2_data;
>   
>   int board_usb_init(int index, enum usb_init_type init)
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index 41f767302ec..b850460c26c 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -110,7 +110,7 @@ static struct mm_region gx_mem_map[] = {
>   struct mm_region *mem_map = gx_mem_map;
>   
>   #if IS_ENABLED(CONFIG_USB_DWC3_MESON_GXL) && \
> -	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +	IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG)
>   static struct dwc2_plat_otg_data meson_gx_dwc2_data;
>   
>   int board_usb_init(int index, enum usb_init_type init)

Same as 160, this code is getting removed in This code is getting removed in the last PR I sent at https://lore.kernel.org/all/ec3802ba-6e79-5370-e41e-cd2487cd618f@linaro.org/
