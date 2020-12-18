Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.8150.1608288426534774043
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 02:47:07 -0800
Received: by mail-wr1-f46.google.com with SMTP id r3so1646813wrt.2
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2tV4wvJkzjRnZdwwa0FuikdGsUc98Z5MNkVhBtdlbU=;
        b=DXw2CbQtBvrSe1twib7I8IhrtdOSmEJYlbOVIs5WkYWdhxTYW43UMZFEjwNoDTVz2u
         OM8nCz9jt0UJOkP9AaF6ftTp+8ADu+4p++nNxpTfDIHU3859DjWE4ketvfpaqm1It2mS
         kV9S11Jj+fxUlDKpcMhNOjsoyup9hgfp1jNsNQYRWlZtp/un09TQ9ZNkrgt7MBrfH6r4
         Ie9WxUjmIlOnDE6B0ypR7n7S4GSGXcczIKhn0Yirj6Fu2mNoUGtZ/nJaXEq11nXnZlgU
         8G0amh44BHBdqgPcrOT8VavnxdeS/CF2TgTXJaT72P86Wg0s/OBeT4fvyoN6KGH9s6Ag
         5DBw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4
References: <CGME20201218104353eucas1p266e5210f6272fc60b316881e3fb3c210@eucas1p2.samsung.com>
 <20201218104345.18370-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a9274a4b-6012-e5af-a919-ec5ef0a57950@baylibre.com>
Date: Fri, 18 Dec 2020 11:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <20201218104345.18370-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 11:43, Marek Szyprowski wrote:
> For the proper reboot Odroid-C4 board requires to switch TFLASH_VDD_EN
> pin to the high impedance mode, otherwise the board is stuck in the
> middle of loading early stages of the bootloader from SD card.
> 
> This can be achieved by using the OPEN_DRAIN flag instead if the
> ACTIVE_HIGH, what will leave the pin in input to achieve high state (pin
> has the pull-up) and solve the issue.
> 
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This is a result of the discussion in the "[PATCH/RFC] board: amlogic:
> Fix Odroid-C4 SD card reboot issue" thread:
> https://lists.denx.de/pipermail/u-boot/2020-December/435295.html
> 
> Patch for the upstream Linux DTS has been already submitted:
> https://lore.kernel.org/linux-amlogic/20201218102228.16211-1-m.szyprowski@samsung.com/
> ---
>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> index c431988075..fbcc8287c5 100644
> --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> @@ -11,3 +11,7 @@
>  	snps,reset-delays-us = <0 10000 1000000>;
>  	snps,reset-active-low;
>  };
> +
> +&tflash_vdd {
> +	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
> +};
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applying it to u-boot-amlogic, and will send it asap so it's applied for v2020.10

Neil
