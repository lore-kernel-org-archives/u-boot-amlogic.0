Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.10856.1672835625307091155
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:33:45 -0800
Received: by mail-wm1-f53.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so20677907wmk.4
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=984Q6d0ir0/1xlebWEVquFwicZvXvJTmNcsvZkUUeCo=;
        b=Vgl1WwX2nPQHXjhru44RRoWyeo/M2iDMHzyXWzDJgwsMtmOnNpDRJBXvQ2IncYQ4w4
         WEtsRLjihyzRupLO7rCqss86MTj076pNetl4zJrXerbMqj0cghJpicG5GCpOVzR5dOse
         tLs82sXNRoGwknztbYIxg66Z9wJXpDwPeObkR3EEGF9gfoDfflnI2R6c/ww9iGa8Vjxw
         Udlx0Xn+3gGJRm4aYaf6DJ6KSux1OYmNXSirkjFYV86C3z+MBp4F7z6PB0RfrZBZXOpm
         80IC8Yu6OViEjhnA/BBWWkar+UtudpMTUBQOYIt1BxklMGelLZBZsooP0F8Sv7L1tF1c
         bavw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <1eca5b7f-07b4-4e09-e657-09654514f836@linaro.org>
Date: Wed, 4 Jan 2023 13:33:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/5] asm/arch-meson: add missing meson_sm_write_efuse signature
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-2-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222125727.47893-2-avromanov@sberdevices.ru>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Le 22/12/2022 à 13:57, Alexey Romanov via groups.io a écrit :
> This function can be used by other modules. Also add comments.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   arch/arm/include/asm/arch-meson/sm.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
> index f3ae46a6d6b..53b75176493 100644
> --- a/arch/arm/include/asm/arch-meson/sm.h
> +++ b/arch/arm/include/asm/arch-meson/sm.h
> @@ -6,10 +6,35 @@
>   #ifndef __MESON_SM_H__
>   #define __MESON_SM_H__
>   
> +/**
> + * meson_sm_read_efuse - read efuse memory into buffer
> + *
> + * @offset: offset from the start efuse memory
> + * @buffer: pointer to buffer
> + * @size: number of bytes to read
> + * @return: number of bytes read
> + */
>   ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
>   
> +/**
> + * meson_sm_write_efuse - write into efuse memory from buffer
> + *
> + * @offset: offset from the start efuse memory
> + * @buffer: pointer to buffer
> + * @size: number of bytes to write
> + * @return: number of bytes written
> + */
> +ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
> +
>   #define SM_SERIAL_SIZE	12
>   
> +/**
> + * meson_sm_get_serial - read chip unique id into buffer
> + *
> + * @buffer: pointer to buffer
> + * @size: buffer size.
> + * @return: zero on success or -errno on failure
> + */
>   int meson_sm_get_serial(void *buffer, size_t size);
>   
>   enum {
> @@ -28,6 +53,9 @@ enum {
>   	REBOOT_REASON_WATCHDOG_REBOOT = 13,
>   };
>   
> +/**
> + * meson_sm_get_reboot_reason - get reboot reason
> + */
>   int meson_sm_get_reboot_reason(void);
>   
>   #endif /* __MESON_SM_H__ */


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
