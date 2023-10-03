Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.107703.1696339270437309119
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 06:21:10 -0700
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32487efc319so948347f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696339269; x=1696944069; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK8nmRmNQygjjViCiLRnGglt+F9y0kDV4bmr3SV9+Fk=;
        b=MaDNQHtHJRMjVJpJQpsIhuTS0d88MUiGKWFiX2PIO8AeA1dbSX31kl7WZ1nOZA7G+8
         umh3r7hgS+a2DgN7m4FUte0dV1SSL1fHeoY+/pRBupGGvE1c223avqPojCD93AAHz7w6
         xXbR6xFWnvbIdZ9hjEHq9QTIqsztc9Zf4OzjYIBwq8rai1qwqioJ8fy2j6/KpnTQTScY
         tTXQUs80e1YWRNbJKKfOJEMCuax3Tjwu+pekiYR9RfHeMfyg+rYdarAnztJ2URMfMHd+
         Ugtmf4auTsiCJh0u/BCKM7rpswXwdR6W1blv8+qkFqXh48GQMnTJd71lPJYxVWtwanGK
         2PVg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <e8f12d8c-aa70-45e9-b7f1-29840110b356@linaro.org>
Date: Tue, 3 Oct 2023 15:21:07 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 8/8] ad401: enable USB stack
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-9-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-9-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 03/10/2023 13:28, Alexey Romanov wrote:
> Currently we have all drivers for use USB stack on A1-series
> SoC's. Let's enable USB options for the Amlogic AD401 reference A1
> SoC board.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   configs/ad401_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
> index 529e553bac..b02ff47b7a 100644
> --- a/configs/ad401_defconfig
> +++ b/configs/ad401_defconfig
> @@ -51,4 +51,7 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_GADGET=y
>   CONFIG_WDT=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
