Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.3929.1622101564422449889
 for <u-boot-amlogic@groups.io>;
 Thu, 27 May 2021 00:46:04 -0700
Received: by mail-wm1-f54.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so1926058wmq.0
        for <u-boot-amlogic@groups.io>; Thu, 27 May 2021 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rflc6De9JUWRW+9nDSA5kKRINlKLYOja+bYCQrzJi4U=;
        b=dVGNTimClvqATiOQoj+KfqlpGeKvF4Tye2NNnFGrRY+mBAmaPHUsr3AXrau3lDq8AF
         lk5YTf3lA4xaUboL0YCaVl0MQaS7ZQKDRRyl/fRJAqAyttPsEzwO9lZEuRXWwhc9lBTx
         qjGYmYBdwLve9nT/j2X/SK7qICQDAb4HNQulZMIH/79bZRpRxmj7gPTywt7QNF7+wQgb
         DaL+nnFvMZzKSR4eFzx96FKDG/rXaD4CfmeIWyfX1EcJdOWAjQbygOc7iBPhYCBWPp0y
         sIB5G/7rTJADGDOWptXyYlBeE/ZMCt3jl7zYYqotFIXDr1QRUKCAKIZ74MnMJAHpUhnm
         Mgxg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] meson64: add kernel compression vars
References: <20210527064351.3102968-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <89473d20-fbbf-bdd5-70f5-5f0bb8860d26@baylibre.com>
Date: Thu, 27 May 2021 09:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <20210527064351.3102968-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 27/05/2021 08:43, Artem Lapkin wrote:
> make possible to load simple compressed linux kernel for meson64
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  include/configs/meson64.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index e3d25493..552a08c2 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -113,6 +113,8 @@
>  	"stdin=" STDIN_CFG "\0" \
>  	"stdout=" STDOUT_CFG "\0" \
>  	"stderr=" STDOUT_CFG "\0" \
> +	"kernel_comp_addr_r=0x0d080000\0" \
> +	"kernel_comp_size=0x2000000\0" \
>  	"fdt_addr_r=0x08008000\0" \
>  	"loadaddr=0x01000000\0" \
>  	"scriptaddr=0x08000000\0" \
> 

Looks fine, I'll let other comment on it and apply it if it's ok for everyone

Neil
