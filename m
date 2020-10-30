Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.15388.1604071278309540408
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Oct 2020 08:21:18 -0700
Received: by mail-wm1-f65.google.com with SMTP id e2so3302920wme.1
        for <u-boot-amlogic@groups.io>; Fri, 30 Oct 2020 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xpcvfd6GUvBEXOyydeAi/kL+QiMn1GLk7kisVXYroi0=;
        b=QJ0i0A2QW6eAI2Ipv4KzUIt/UNCTg3tdULTxuLTybky6HPJF6ZbvE6uN9KW0Uhp6U7
         4pZYNAwUTj1y7i4NT98HELLqqi0/JCMvfxhYadyo3hoIcY2ggh7sXZMOcICunYSs18K6
         FgipPupMI6GIjbnqO5GS+C66KJnKfeEZhE7Afq7ed4zXYNnQ1vayRHMTH2iNZ26WGQLv
         ldqmK+82or8E8Lo/lfrr3Xnt0/D4x2DGeoSG+sM0AJ8g2wMdlZnSJslUTNWCRQI45eaC
         DE5wwzgZ3hiFmfWGGA0DmKFcnqXvQun9NfvCfHnadFZSnEAfFHEGUD0TVajRgZdZokI6
         bXPQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: meson64_android: don't show logo on ROM USB boot
References: <20201030150345.121429-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <19feb844-3fd9-ebe8-6a3a-6d18de201e6e@baylibre.com>
Date: Fri, 30 Oct 2020 16:21:09 +0100
MIME-Version: 1.0
In-Reply-To: <20201030150345.121429-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 30/10/2020 16:03, Mattijs Korpershoek wrote:
> From: Guillaume La Roque <glaroque@baylibre.com>
> 
> When booting from rom usb, skip the boot logo logic as it's possible
> that the partition containing the logo does not exist yet.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 8fff915b50a4..c47d51c85368 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -98,11 +98,14 @@
>  	func(SYSTEM, system, na) \
>  
>  #define PREBOOT_LOAD_LOGO \
> -	"mmc dev ${mmcdev};" \
> -	"part start mmc ${mmcdev} ${logopart} boot_start;" \
> -	"part size mmc ${mmcdev} ${logopart} boot_size;" \
> -	"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> +	"if test \"${boot_source}\" != \"usb\" && " \
> +		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
> +		"mmc dev ${mmcdev};" \
> +		"part start mmc ${mmcdev} ${logopart} boot_start;" \
> +		"part size mmc ${mmcdev} ${logopart} boot_size;" \
> +		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  			"bmp display ${loadaddr} m m;" \
> +		"fi;" \
>  	"fi;"
>  
>  #define CONFIG_EXTRA_ENV_SETTINGS                                     \
> 

Applied to u-boot-amlogic
