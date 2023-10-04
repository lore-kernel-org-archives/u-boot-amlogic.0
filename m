Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.14254.1696411532611726040
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Oct 2023 02:25:32 -0700
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3248ac76acbso1749835f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 04 Oct 2023 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696411531; x=1697016331; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFdv021Rizo0irSmbiVZ2+j5AStRjh0n86anmc7BRps=;
        b=UOY7d75H4IeUaShr4EsxZl/T31LnzE/8yZ72ppH9CVjOpW8HSBfsV9NuG74TuoEBU+
         Ga99jp97sLir5UZFKsNemOLuaGJkDO395jMn8yd5C4VYIOIbdUhHryfwqLrX5PijXXjp
         WYxwExDNDcRVdNyK/lQCyIVWssWUHT/8qsIrJgZTt0zB8YtFQT6m0CLyJuMmHt/zzDh5
         E3tuAZiF5vCLetTt7UYRNYdSjyyax/UVWJm1U7aQXSXRob4yRMamgBiu5pBBz5U6/GBs
         uc7/JXnIcNnLL6/s0uGJn+wLTDD52lG/PsEKmQKaSFAvJk2amybbYpWkcFgrawpdwkph
         7r/w==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <63ee9c84-dfcd-4752-b51d-9ca9d313734f@linaro.org>
Date: Wed, 4 Oct 2023 11:25:29 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] ARM: amlogic: ad401: enable SPIFC
References: <20231003202908.16654-1-ivprusov@salutedevices.com>
 <20231003202908.16654-3-ivprusov@salutedevices.com>
In-Reply-To: <20231003202908.16654-3-ivprusov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@salutedevices.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 03/10/2023 22:29, Igor Prusov wrote:
> From: Igor Prusov <ivprusov@sberdevices.ru>
> 
> Enable Amlogic A1 SPI FLash Controller support.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   configs/ad401_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
> index 31752cc7f5..9a88e20a6a 100644
> --- a/configs/ad401_defconfig
> +++ b/configs/ad401_defconfig
> @@ -51,4 +51,5 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
> +CONFIG_MESON_SPIFC_A1=y
>   CONFIG_WDT=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
