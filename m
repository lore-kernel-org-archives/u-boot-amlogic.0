Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.36077.1679926886823955403
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 07:21:27 -0700
Received: by mail-wr1-f52.google.com with SMTP id v1so8996161wrv.1
        for <u-boot-amlogic@groups.io>; Mon, 27 Mar 2023 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926885;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QhLnEwjwsoWc9aZTSn67ibLwJ87PQNQMnbYTZ4CEi4s=;
        b=X9dOLlwNgQNZtTPmCh+2m457iV6i02S/z07+EXNX/Lg6sgq5aUpjyDb8WamkQx0HiR
         TDjd7fy96R7/clPGzK480WbgODjJpp6RdiTv+GGCX9ZU7XfBLf54YKjdaBlcOfdqNFTV
         nTQjfJxzw6pePCAzevhui0HX+CktmhhxrCCQUxX9ARlGJm0IgDPF3sutpcwO8rjAcGBc
         3ueXQZJdwXE0pg73FqYoJcgo0o2e7VvD2eonKawacZVmnG7C86vvOtQkMSmiyM1u0lYh
         jbhbje+QEJN1EqIDeKVcfJd1aSW+5x1weY4AkVjHTpS/OuajtzIAmudK4ToZVe99ErYw
         LMLg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <f4ab8920-6d9a-539d-e5fe-2173aa80081c@linaro.org>
Date: Mon, 27 Mar 2023 16:21:23 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] boards: amlogic: switch LibreTech-CC v2 and WeTek Core2 to EE powerdomain
References: <20230326060625.2734090-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230326060625.2734090-1-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 26/03/2023 08:06, Christian Hewitt wrote:
> The LibreTech-CC (LePotato) v2 and WeTek Core2 boards are still using
> the older GX VPU powerdomain driver. Update their configs to use the
> newer EE driver like other Amlogic boards [0].
> 
> [0] https://lore.kernel.org/all/20201106101901.2472557-5-narmstrong@baylibre.com/T/#u
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/libretech-cc_v2_defconfig | 2 +-
>   configs/wetek-core2_defconfig     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
> index 30b1651554..ea71f055d9 100644
> --- a/configs/libretech-cc_v2_defconfig
> +++ b/configs/libretech-cc_v2_defconfig
> @@ -51,7 +51,7 @@ CONFIG_MESON_GXL_USB_PHY=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_MESON_GXL=y
>   CONFIG_POWER_DOMAIN=y
> -CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
> diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
> index f5149fc002..07d2587f77 100644
> --- a/configs/wetek-core2_defconfig
> +++ b/configs/wetek-core2_defconfig
> @@ -44,7 +44,7 @@ CONFIG_MESON_GXL_USB_PHY=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_MESON_GXL=y
>   CONFIG_POWER_DOMAIN=y
> -CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
>   CONFIG_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
