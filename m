Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web09.5505.1578404522172294412
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 05:42:03 -0800
Received: by mail-wm1-f68.google.com with SMTP id u2so19434192wmc.3
        for <u-boot-amlogic@groups.io>; Tue, 07 Jan 2020 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ETfmeoV8TSpoP6drOJ8i3wJKPtOOJVspVYrJoxVhDBI=;
        b=hJPMM2FbMSw7iiOQtKrjpUs41JiJiE/LR9Fzcd/8I9CBCIKmpfQ2zna4/3+6oWrUSe
         p/tOumwPA9jJUJMzFBCUOldNZmQRVqF6ZtTtNZ0W5SNabFofY6Jaw4+f64FfDI4MYk39
         +h42Imz9yKUf1bFB6xNvkkR3dYnhN8lJ7meLEL1vIS+5RN54G1mFZjUHJVfGIUlaW6wA
         AcMIigPKPW8VQjKETnZaIu6PDfrshlyMR/oB0FsnpQ1j1ZfVflMYnQ71nf0cdiVdurE3
         JQdx+vj77S1pItqUJBGQBK0LNH9d61cUojeUOiRdMImXE+PVtKWg7/xXMHMwT98zmHHG
         ODPg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv3 2/3] configs: meson64: enable GIC support for G12A/G12B
References: <20191226113353.1757-1-linux.amoon@gmail.com>
 <20191226113353.1757-3-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c76c932d-2927-624e-d67b-7a332b9a439a@baylibre.com>
Date: Tue, 7 Jan 2020 14:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <20191226113353.1757-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/12/2019 12:33, Anand Moon wrote:
> Enable GIC support for G12A/G12B platform.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/configs/meson64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index 736081277d..50707a3197 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -8,7 +8,7 @@
>  #define __MESON64_CONFIG_H
>  
>  /* Generic Interrupt Controller Definitions */
> -#if defined(CONFIG_MESON_AXG)
> +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
>  #define GICD_BASE			0xffc01000
>  #define GICC_BASE			0xffc02000
>  #else /* MESON GXL and GXBB */
> 

Applied this patch to u-boot-amlogic

Neil
