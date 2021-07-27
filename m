Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.8496.1627374832227510526
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:33:52 -0700
Received: by mail-wm1-f48.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so1224645wmg.4
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9RkMN3GAtM8HgUerQcoefG3JAiHq/1LwBdG84sga/BY=;
        b=rpXwiAmbbBWREemd85DgdsTj1+sqdNJWLly5XDWeoyyUqfi9/8gIURRtaCsVRlrgkW
         8DRcUrhdYW6PR4CQj5Ukye7uRgVLatYGEShiC7Hj0haIl4MU5tggAaNO1tGyyfOuDJvK
         w/cpg9yeHHkFOfH1Sb4eUYfNfMByKyCTkBG5moS/RrxRt/TnJbt3HEEwOqStCiwVHhVC
         uYWOzF9J8ocfweYBjijPc0m0MgU5VslJoknTY+RHxV1e5oXXKe/IzsNkXUs1l8u/mxkb
         BAbhi9jrdE0sdjgde1geEb4pLCopf+JXkSsq0gydg1KtWj0xYB1Cyk79ky7TZs9wtMxl
         SayQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: Enable SMBIOS for Khadas VIM boards
References: <20210727012319.1024276-1-art@khadas.com>
 <20210727012319.1024276-2-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0dc762d3-7ef5-f158-0deb-212305885bb5@baylibre.com>
Date: Tue, 27 Jul 2021 10:33:49 +0200
MIME-Version: 1.0
In-Reply-To: <20210727012319.1024276-2-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 27/07/2021 03:23, Artem Lapkin wrote:
> Enable configs to support SMBIOS for all Khadas VIM boards
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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



Applied to u-boot-amlogic,

Thanks,
Neil

