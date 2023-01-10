Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.103534.1673358059361555837
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 05:41:00 -0800
Received: by mail-wm1-f46.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso6988505wmq.3
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHothP/PBUXaTEGoPRYkQ/DsflCm9NFEWkeqeprbyrI=;
        b=NSSajHMQEWNbiMe57Gv8GEN3m2H+DAjNpI8WIF74ZKkY3ndnNJLHjZV1W+T+Kel7sT
         iq0cVbIL3lI0yxvgjwJYoAQovNopDUhagiWNwqLi1Gz1oKzp0ZJJT79JmXQmeIeMEohs
         1GzAElDtG5F00AGW2wkIgV768h0eipEeJypgebD/Wks1zyl+y60t0cEG/er7q4XPg9Zy
         s4YfFSbsiuv+glCMXJ2LTg+BO5ktgwphvJ77tewukUQEoIvy90dHjLjmO2yPa6kvb+RX
         VWbXd3/+LTACZW3fzcqN0PB2hQydG2ed2Zwk7Z7UUo376GboxSX+WPpOun41P3Lkmbfc
         IjAw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 1/5] asm/arch-meson: add missing meson_sm_write_efuse signature
In-Reply-To: <20230110105650.54580-2-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
 <20230110105650.54580-2-avromanov@sberdevices.ru>
Date: Tue, 10 Jan 2023 14:40:56 +0100
Message-ID: <87bkn68q3b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Jan 10, 2023 at 13:56, Alexey Romanov <avromanov@sberdevices.ru> wrote:

> This function can be used by other modules. Also add comments.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/arm/include/asm/arch-meson/sm.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
> index f3ae46a6d6b..53b75176493 100644
> --- a/arch/arm/include/asm/arch-meson/sm.h
> +++ b/arch/arm/include/asm/arch-meson/sm.h
> @@ -6,10 +6,35 @@
>  #ifndef __MESON_SM_H__
>  #define __MESON_SM_H__
>  
> +/**
> + * meson_sm_read_efuse - read efuse memory into buffer
> + *
> + * @offset: offset from the start efuse memory
> + * @buffer: pointer to buffer
> + * @size: number of bytes to read
> + * @return: number of bytes read
> + */
>  ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
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
>  #define SM_SERIAL_SIZE	12
>  
> +/**
> + * meson_sm_get_serial - read chip unique id into buffer
> + *
> + * @buffer: pointer to buffer
> + * @size: buffer size.
> + * @return: zero on success or -errno on failure
> + */
>  int meson_sm_get_serial(void *buffer, size_t size);
>  
>  enum {
> @@ -28,6 +53,9 @@ enum {
>  	REBOOT_REASON_WATCHDOG_REBOOT = 13,
>  };
>  
> +/**
> + * meson_sm_get_reboot_reason - get reboot reason
> + */
>  int meson_sm_get_reboot_reason(void);
>  
>  #endif /* __MESON_SM_H__ */
> -- 
> 2.25.1
