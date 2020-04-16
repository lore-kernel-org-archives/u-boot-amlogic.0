Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.2105.1587022255539177682
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Apr 2020 00:30:56 -0700
Received: by mail-wr1-f66.google.com with SMTP id f13so3524422wrm.13
        for <u-boot-amlogic@groups.io>; Thu, 16 Apr 2020 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2ElZptzwu3S9RY2D5tpGyC+eJKOmcDj7y6VKwyo5Ig=;
        b=cKRTyjOfXOwPRf8CAwuhUpDBOUV4QZEfxjbxg5AGcttDJRe4OikGYXo+YOiQmPaj4Z
         7tGn6q+CSYdXRwobBPaRlL2/gl3ZL43odFi60NV8fUHqY0YytG9SyGJa5RwMBZRFmXF2
         UNi2N4XJO1CPRw2V3d2uoRumGIzOIjqtzOePjJHc/SzupnN962mpZ7iL5N5JhckiIw13
         LW4g6YOjAapUypDz/TbQ6xGAQ14xFhpG8v1T8rJOFDEBF58Ow0gYXWs5e/Cx/wG3/Hb5
         aeRJHQHmJdS39whYFutajZFo60YhTzlBR/0rRAHOrtiwgwxa+fJe+A6ZdvQZkrQgaPpy
         7TBA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: add missing meson-gxl-s805x-libretech-ac-u-boot.dtsi file
References: <20200415155830.2649-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <308343e1-2901-c157-6b61-aa64abc6876d@baylibre.com>
Date: Thu, 16 Apr 2020 09:30:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200415155830.2649-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Jerome Brunet <jbrunet@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 15/04/2020 17:58, Neil Armstrong wrote:
> The libretech-ac u-boot.dtsi file is missing to enabled DT nodes changes
> to enable Video output on U-Boot.
> 
> Fixes: 671b1db8f8 ("arm64: dts: meson-gx: vpu should be probed before relocation")
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> new file mode 100644
> index 0000000000..c35158d7e9
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> 

Applied to u-boot-amlogic
