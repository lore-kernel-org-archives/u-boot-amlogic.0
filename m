Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.17508.1586966808497723556
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Apr 2020 09:06:48 -0700
Received: by mail-wm1-f65.google.com with SMTP id y24so173181wma.4
        for <u-boot-amlogic@groups.io>; Wed, 15 Apr 2020 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nn+TmA5t/1ultT5UPPAk3rYfIznLS0qLCmhAAD4Bz1A=;
        b=vP+FIC+HxM9MrDxodaHqojIdUcTQqC4DQP+mlALFAtCLPWknXrDZE9+AjmvKsFONDA
         txcfBx0HwUpcXfS1gtOQoSL0y8JskOwJgpVguQM++RTIZTM+5p1atcVrFkbvtduF+LHp
         tsk1866is6/oNSlo8JLze9Qd2tnOW79g5TYhYznSFuAX92LwI5X6lncCQ6eDIPyUcgdf
         gJgOhBIGZijzsgSJAApV4L0JOl1pMC7R2kSUUapf3UPYUPplHNqb3oMYO3jWs+stvea0
         vfLQR/Al0rz1/ELOaNfuBXdwj9cRdUocvoy/FZ/dS0WLi018UHpd3/XHFn+pgPFeLX22
         OK1A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/1] configs: correct SMBIOS information for ODROID-C2
References: <20200407063200.6426-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d5fce7fc-98ee-e49f-40df-48a78a72eb9f@baylibre.com>
Date: Wed, 15 Apr 2020 18:06:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200407063200.6426-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 07/04/2020 08:32, Heinrich Schuchardt wrote:
> CONFIG_SMBIOS_MANUFACTURER="amlogic"
> CONFIG_SMBIOS_PRODUCT_NAME="p200"
> 
> is incorrect for the ODROID-C2.
> 
> Show correct board name and manufacturer in SMBIOS.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  configs/odroid-c2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 64fbfdf064..39279b40db 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_DEBUG_UART_BASE=0xc81004c0
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_IDENT_STRING=" odroid-c2"
> +CONFIG_SMBIOS_PRODUCT_NAME="ODROID-C2"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_CONSOLE_MUX=y
> @@ -41,3 +42,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SMBIOS_MANUFACTURER="Hardkernel Co., Ltd."
> --
> 2.25.1
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot-amlogic
