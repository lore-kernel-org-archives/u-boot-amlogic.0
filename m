Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.95751.1670992808007455991
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 20:40:08 -0800
Received: by mail-ed1-f43.google.com with SMTP id v8so20892070edi.3
        for <u-boot-amlogic@groups.io>; Tue, 13 Dec 2022 20:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEeqvuPc3x8aC+ZII6Kj9xl/mv7me/dzsDl2wX+fEDI=;
        b=W2qCbHLPacqB6oaqalQLE81Y00qzDS+3+qtbtB//Dbm9o5IgYhaD/lwHcZf172F07O
         yf3zE8/AwZiR1rkHB1Q1Ea/5FYa1lb83Y0oLqQsOSmngQtezkOhHXqm2LX63mYRLei7V
         FrkQ00sULRp7blwQBvAUX9JOxUI4/tKnkO9Kg=
MIME-Version: 1.0
References: <20221213183129.75915-1-avromanov@sberdevices.ru> <20221213183129.75915-2-avromanov@sberdevices.ru>
In-Reply-To: <20221213183129.75915-2-avromanov@sberdevices.ru>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Dec 2022 20:39:46 -0800
Message-ID: <CAPnjgZ2CEz=L=cAstFYOszMxDN8FZ3UmG2UQ-=8GY4913ogGLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] asm/arch-meson: add missing meson_sm_write_efuse signature
Content-Type: text/plain; charset="UTF-8"
To: Alexey Romanov <avromanov@sberdevices.ru>
Cc: narmstrong@baylibre.com, trini@konsulko.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi Alexey,

On Tue, 13 Dec 2022 at 10:32, Alexey Romanov <avromanov@sberdevices.ru> wrote:
>
> This function can be used by other modules.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  arch/arm/include/asm/arch-meson/sm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
> index f3ae46a6d6b..b68edf842e4 100644
> --- a/arch/arm/include/asm/arch-meson/sm.h
> +++ b/arch/arm/include/asm/arch-meson/sm.h
> @@ -8,6 +8,8 @@
>
>  ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
>
> +ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
> +
>  #define SM_SERIAL_SIZE 12
>
>  int meson_sm_get_serial(void *buffer, size_t size);
> --
> 2.25.1
>

Should add function comments.

Also, you might consider adding a uclass for this. It seems like an
important use case that is not handled right now.

Regards,
Simon
