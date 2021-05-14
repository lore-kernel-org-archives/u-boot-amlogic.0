Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.10550.1621006894972506272
 for <u-boot-amlogic@groups.io>;
 Fri, 14 May 2021 08:41:36 -0700
Received: by mail-wm1-f50.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso1653793wmj.2
        for <u-boot-amlogic@groups.io>; Fri, 14 May 2021 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SU1DpgNZJkRsQ5zUHw37RcOX3bWjRuzLIbm2Bttkvq4=;
        b=xV1aD833tFL0+Khuq++CRh5uXVu/mb3FceEemuRuAXtKUH++3CckSvblBjVU9B9ncy
         xXFwa7SCK3GcArTPHAm4V1Kz/uw1yfO9TXZbZXQfLZzfVJ0MtBRG6YgjVOVJ2D96IdkS
         DJQvN8z7At3qRdNsIkTmGPPAUmmYBvtZSC3xpYNHhUuzGPqTfF7EFr3oGhdijm2nBlF5
         p+OaMUjM4+XImOn83KzkG1Gb/kb70XLxa7rlC4rRjaATPbQ7Su8ifcP1O/M1gjC4EWqM
         WLSQRI1f8COI5mZBnHYPYX/1XOZRJnibuFwpDQpPvOdNpVU67exMlegyIirnYJ8i5pzU
         eRXg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: add missing -u-boot.dtsi to enable HDMI on Beelink GTKing/King-Pro
References: <20210420084716.2997327-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8d873c86-73f3-855d-96b2-2d3dbd6a1402@baylibre.com>
Date: Fri, 14 May 2021 17:41:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210420084716.2997327-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, B1oHazard <ty3uk@mail.ua>
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2021 10:47, Neil Armstrong wrote:
> This lacks the right u-boot specific DT include to make HDMI work.
> 
> Reported-by: B1oHazard <ty3uk@mail.ua>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi | 7 +++++++
>  arch/arm/dts/meson-g12b-gtking-u-boot.dtsi     | 7 +++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi b/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
> new file mode 100644
> index 0000000000..236f2468dc
> --- /dev/null
> +++ b/arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-g12-common-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi b/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
> new file mode 100644
> index 0000000000..236f2468dc
> --- /dev/null
> +++ b/arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-g12-common-u-boot.dtsi"
> 

Applied to u-boot-amlogic

Neil
