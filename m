Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.26994.1627285061144781333
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Jul 2021 00:37:41 -0700
Received: by mail-wr1-f51.google.com with SMTP id n12so6309946wrr.2
        for <u-boot-amlogic@groups.io>; Mon, 26 Jul 2021 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCYQiDt5goT8t2LxOTaBvgXyMozFFmRoQKL3DCPt8CA=;
        b=kO7RhEv1p8rEvcrp5pmqMBzJ/hziWNmWh7FWjFHbbmvXtDIn/J/EczNf9pXZXugcUC
         dma6YrbE64LgZS4oqAhZ60a5qjYDrQBj9YwRzLDXy5sH8QR5tDx11I4WPAjNDThy0Jk3
         uWq9YmxUudVSt5ilwPmgXANMxlPZtcDBJHD2/GVYoKL85MUhFgqhn/cJ8lPSytyJGdMO
         Pcw/aYW3CnCGOqvkC4RuUPImFVhZb3drzaTr4Fqm+g8qXWOVa3CDXyrokJYJYq1PB967
         CtZg/TQIIvFI4JKalemxUwFjc2ZXu6sHkz5H8gCLahijxBH02CEHeq4+UPJnCBUwKnt3
         /3zQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: khadas-vim*: Enable SMBIOS
References: <20210715050026.2940786-1-art@khadas.com>
 <20210715050026.2940786-2-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <48207d6e-17d8-302b-8944-23796ea286b3@baylibre.com>
Date: Mon, 26 Jul 2021 09:37:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210715050026.2940786-2-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Subject should be: "[PATCH] configs: Enable SMBIOS for Khadas VIM boards"

with that:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

On 15/07/2021 07:00, Artem Lapkin wrote:
> Enable configs to support SMBIOS for all Khadas vim* boards
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  configs/khadas-vim2_defconfig  | 2 ++
>  configs/khadas-vim3_defconfig  | 2 ++
>  configs/khadas-vim3l_defconfig | 2 ++
>  configs/khadas-vim_defconfig   | 2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
> index 32513998..5d673463 100644
> --- a/configs/khadas-vim2_defconfig
> +++ b/configs/khadas-vim2_defconfig
> @@ -50,6 +50,8 @@ CONFIG_DM_RESET=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
> index c4b24fc3..5a7a9006 100644
> --- a/configs/khadas-vim3_defconfig
> +++ b/configs/khadas-vim3_defconfig
> @@ -61,6 +61,8 @@ CONFIG_DM_RESET=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
> diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
> index 0c731d4c..d719511f 100644
> --- a/configs/khadas-vim3l_defconfig
> +++ b/configs/khadas-vim3l_defconfig
> @@ -61,6 +61,8 @@ CONFIG_DM_RESET=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
> diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
> index 2df00d54..dc6365fc 100644
> --- a/configs/khadas-vim_defconfig
> +++ b/configs/khadas-vim_defconfig
> @@ -44,6 +44,8 @@ CONFIG_DM_RESET=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
>  CONFIG_DM_USB=y
>  CONFIG_USB_XHCI_HCD=y
> 

