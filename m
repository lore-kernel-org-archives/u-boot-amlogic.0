Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.26570.1650871303506594850
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 00:21:44 -0700
Received: by mail-wm1-f52.google.com with SMTP id m22-20020a05600c3b1600b00393ed50777aso660281wms.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Apr 2022 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=jP71VIhsFXc4vpW31nN7gx0RyWzoqJwb/CCvjDBOf5c=;
        b=vKUehDvBnDAV1IaH+K9Q1oeFJVmlTdsP1kIuL6t+GLAOkPeOBuIiGGas/EP1fv8lco
         XjCbCURs4ZyY/YvkwTyZrTU5t1A6AcpSVtzY2xgbTOjN4/FfKi+etgrQEWnvCvRNxf6v
         NUqV/kgett+4ztHvGzW00zgqrtdqWCkcSxZVBAGCJvUWF72IgBC2eOM/j6PHnGon+Gvr
         9BBzgiNt6+yjt8+9YRJy+Lv+oBVwOE0ddxotqcV3PXeIe8ycCuoXcjpMrflJr5aetYlt
         8GreL5W5W48skVCTf6L8Smq/GjzO/Xa+2TCIOiaTciPqdZI7WpIU8uwZTiT1jjDcRCZn
         VZZQ==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <88d5ccab-6f05-78d6-438f-1687f411e8d7@baylibre.com>
Date: Mon, 25 Apr 2022 09:21:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/6] board: amlogic: jethub j100: enable saradc in dts
References: <20220424082159.757622-1-adeep@lexina.in>
 <20220424082159.757622-6-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220424082159.757622-6-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2022 10:21, Vyacheslav Bocharov wrote:
> Prepare to use ADC channel 1 to check the hardware revision of the board:
> - add u-boot dts include with saradc node
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>   create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi b/arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
> new file mode 100644
> index 0000000000..3ecb233f8e
> --- /dev/null
> +++ b/arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Vyacheslav Bocharov <adeep@lexina.in>
> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
> + */
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
