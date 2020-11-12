Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web08.3983.1605187733855973484
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Nov 2020 05:28:54 -0800
Received: by mail-wm1-f66.google.com with SMTP id c16so5514703wmd.2
        for <u-boot-amlogic@groups.io>; Thu, 12 Nov 2020 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpCg3yJDcOV9T6X+UekcwupgBfh8fnWK99Y2TGwzBgA=;
        b=HcMN0vzveh9UlV1XHez3nr8KMWuG+zaB2AwlqAXqPQ3idZWBDDXh1838U3fmKjWA1s
         PeN36pBJ8EVjE2nXie75fZa7hzzzFeGCSocRyxTkHDlSvTaN0mAn8v80wOForbBmuOUl
         ANMR9XHtXEyJcVPDL5twpMaWEdJjr7coxYygaF/OnHzi4wfUIQi1Pt421RTC7XzUEAbo
         XhsuWShfcqJz4p8AqfremOaMdyG9MBHcU3ANT3a7ILucXW/67zBz2qetTY4pt1Lko7tF
         7lBjhCKhvgMmFz5bfLr5L26MpF3m3QOYORcODivEm+ZyrJSQ0h4oBccFgnno1U3ersm6
         LLvQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: mach-meson: update SoC IDs
References: <20201109133355.2794045-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <833d6056-1a59-afe2-c01c-17721673bd50@baylibre.com>
Date: Thu, 12 Nov 2020 14:28:49 +0100
MIME-Version: 1.0
In-Reply-To: <20201109133355.2794045-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 09/11/2020 14:33, Neil Armstrong wrote:
> Update From Linux commits
> - 240051cb833b ("soc: amlogic: meson-gx-socinfo: Add A1 and A113L IDs")
> - 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L")
> - fdfc6997bd08 ("soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L")
> - d16d0481e6ba ("soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3 ID's")
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-meson/board-info.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index 3abb27e03b..e61d1adb10 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -38,6 +38,7 @@ static const struct meson_gx_soc_id {
>  	{ "G12A",   0x28 },
>  	{ "G12B",   0x29 },
>  	{ "SM1",    0x2b },
> +	{ "A1",	    0x2c },
>  };
>  
>  static const struct meson_gx_package_id {
> @@ -65,7 +66,11 @@ static const struct meson_gx_package_id {
>  	{ "S905X2", 0x28, 0x40, 0xf0 },
>  	{ "A311D",  0x29, 0x10, 0xf0 },
>  	{ "S922X",  0x29, 0x40, 0xf0 },
> -	{ "S905X3", 0x2b, 0x5, 0xf },
> +	{ "S905D3", 0x2b, 0x4, 0xf5 },
> +	{ "S905X3", 0x2b, 0x5, 0xf5 },
> +	{ "S905X3", 0x2b, 0x10, 0x3f },
> +	{ "S905D3", 0x2b, 0x30, 0x3f },
> +	{ "A113L", 0x2c, 0x0, 0xf8 },
>  };
>  
>  DECLARE_GLOBAL_DATA_PTR;
> 

Applied to u-boot-amlogic
