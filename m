Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.2213.1589360494948266622
 for <u-boot-amlogic@groups.io>;
 Wed, 13 May 2020 02:01:35 -0700
Received: by mail-wm1-f67.google.com with SMTP id g12so27552296wmh.3
        for <u-boot-amlogic@groups.io>; Wed, 13 May 2020 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fetRFR4pCMS1ghE6/vRsdMX4Iv0cIUOhvaw0WA+t4P8=;
        b=BfOL5dnzWvqJau/T8kG+DVvp9zG289Qkp7CcseJM44VukdSJxbs1BYhClNPjlbV9k8
         ONspUgV6JsdjswF4+1V3l2645g07kX5jTJUHITewqkkbnj/iaAyelBLTVISZ7U991Qy8
         h5KP0cpyuyvI+eYE8oYpivNT15FVY4NZgA3a0dMhKxeigOhoQc/DdIYYsqsXL/b1Lvbj
         e8f+rZdOeA0d2KrVGdm7lDHb1ELxIQ6SLFPoOmtz/A83Cz9e1OM51nl3z+vj3OxTf6yM
         vde2By0JX/y5Xgk/QUh/nQFUlJsHjxm2Fnp1LCQS/vdg49icjpxcuRBuVdntIaVgvmri
         3O5g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm: dts: khadas-vim3: include meson-g12-common-u-boot.dtsi to enable HDMI output
References: <20200511131728.5570-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c26ce4d5-ffbc-add7-5aaa-e43e7c171261@baylibre.com>
Date: Wed, 13 May 2020 11:01:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200511131728.5570-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/05/2020 15:17, Neil Armstrong wrote:
> Include the common g12 u-boot tweaks to permit enabling video output tweaks
> on Khadas VIM3 boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> index 81fd5be378..b5da4fdfc3 100644
> --- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> +++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> @@ -4,6 +4,8 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> +#include "meson-g12-common-u-boot.dtsi"
> +
>  / {
>  	aliases {
>  		spi0 = &spifc;
> 

Applied to u-boot-amlogic

Neil
