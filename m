Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.21112.1683269552708363063
 for <u-boot-amlogic@groups.io>;
 Thu, 04 May 2023 23:52:33 -0700
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3062678861fso895292f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 04 May 2023 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269551; x=1685861551;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaxqWtBn8NHcvZoJjn4wEVkNLukyQDTRbUORt8B3rd4=;
        b=GSfK6/qiy+592cURt7Lg5//CuDuBC/g0DZNGJ4K7nKGslcQZIjspSyMhdHck4ixnTH
         j0358WsUu/ke/H+ALMnw13L+WhQ5Iajy0q6IKW53ckr3mzyz+n4TpIERAJdrKZxn/n0v
         e94JhxcshiReB+jEuGEjvs+z1fNIG16miA55SoWoh4ziY82qqMuORBgaBYX2jaOH7+uS
         wLd8sDTfaIUju2Me+TMCYDZViMX7GbOi2gnbFb8zcj5m6DxVnqUBH0NcdTMEBRVkaF16
         GARFT1KztIzRGkQvbLRcNHA2PjQfpTQ58at4xTQmCJnkB+mtG1TfHjg5aMrQFL5zFiat
         qIwQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <b80bbf23-14d3-7073-6db9-2a410cc034d6@linaro.org>
Date: Fri, 5 May 2023 08:52:30 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1 2/5] ARM: dts: sync meson-a1-ad401 from Linux 6.3-rc7
References: <20230424180151.9524-1-ivprusov@sberdevices.ru>
 <20230424180151.9524-3-ivprusov@sberdevices.ru>
In-Reply-To: <20230424180151.9524-3-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@sberdevices.ru>
Cc: kernel@sberdevices.ru, prusovigor@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2023 20:01, Igor Prusov wrote:
> Add meson-a1-ad401.dts file from Linux 6.3-rc7
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   arch/arm/dts/Makefile           |  1 +
>   arch/arm/dts/meson-a1-ad401.dts | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 arch/arm/dts/meson-a1-ad401.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3385948d22..8de35c5454 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -185,6 +185,7 @@ dtb-$(CONFIG_ARCH_S5P4418) += \
>   	s5p4418-nanopi2.dtb
>   
>   dtb-$(CONFIG_ARCH_MESON) += \
> +	meson-a1-ad401.dtb \
>   	meson-axg-s400.dtb \
>   	meson-axg-jethome-jethub-j100.dtb \
>   	meson-gxbb-nanopi-k2.dtb \
> diff --git a/arch/arm/dts/meson-a1-ad401.dts b/arch/arm/dts/meson-a1-ad401.dts
> new file mode 100644
> index 0000000000..69c25c68c3
> --- /dev/null
> +++ b/arch/arm/dts/meson-a1-ad401.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-a1.dtsi"
> +
> +/ {
> +	compatible = "amlogic,ad401", "amlogic,a1";
> +	model = "Amlogic Meson A1 AD401 Development Board";
> +
> +	aliases {
> +		serial0 = &uart_AO_B;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x8000000>;
> +	};
> +};
> +
> +&uart_AO_B {
> +	status = "okay";
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
