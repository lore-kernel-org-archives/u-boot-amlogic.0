Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.5621.1574859385320921634
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 04:56:25 -0800
Received: by mail-wm1-f65.google.com with SMTP id f129so7369142wmf.2
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eyt9z5U1LhMHOJwla5FklXjTWwzPUlVaUsRah/4a0Lc=;
        b=V7v1EOaDNN4j6DudZMxUd43/smuXl/JE5HpS3y5fHDSw1gz8N7tCo5GEXk7CnujqOH
         fXwuT8WHAvY94cX6O8G4aw7onlwMvgSgyKLURh1DtT0DrWdyUlw/lyVBWcFPtayavsup
         Gwy3imzJbkNuL1GugLgEml6zc7BSF3z7E6vW6DjhbmDNV5fb4ky9ou58KU1O28K6Oti3
         SOfsXlcLOm09QkGfUpKin0CaulrWl2nbD8xfueHYu4hCPU4eSrufUK9Cr9iST8P+Khze
         +0xzJ7zsc6E/TNBiL3L50KjQUcTZs2uerYUV3Beg3p62N96nEHx/HC91RukLKkWtz3El
         mWOA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 2/4] configs: meson64: enable GIC support for G12A/G12B
References: <20191126211206.4537-1-linux.amoon@gmail.com>
 <20191126211206.4537-3-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <de438115-9fe4-c78b-0e33-fb1b3a00b773@baylibre.com>
Date: Wed, 27 Nov 2019 13:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <20191126211206.4537-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/11/2019 22:12, Anand Moon wrote:
> Enable GIC support for G12A/G12B platform.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
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

Thanks for spotting this !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
