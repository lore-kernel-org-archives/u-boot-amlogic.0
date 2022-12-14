Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.95184.1670992806886502505
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 20:40:07 -0800
Received: by mail-ej1-f53.google.com with SMTP id b2so41768095eja.7
        for <u-boot-amlogic@groups.io>; Tue, 13 Dec 2022 20:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAqEu5/Q2gdpUpGqWvSETQ8yya9qGJcpu2nfoiEHn24=;
        b=fHXL6NhCWMF6NQBYsdI/5gftb1OPZKaL/YFtzrs8ZBgCkUcyr0UIb2WohupuV19mBx
         Fo/hr2y4N7A4F1z4Z2YWE7UjVTAaRm0DJW8KcgEekkYZBYOkS4qUxyWeeR7VpHjUAfwg
         ruV95lMyupJDXKOMbUy05O2g7HYjgw56kEUIc=
MIME-Version: 1.0
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
In-Reply-To: <20221213183129.75915-1-avromanov@sberdevices.ru>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Dec 2022 20:39:43 -0800
Message-ID: <CAPnjgZ09iXy42Xd4c1D0u6j1KN4yGGCT7x-Gah4CvHRtRU8yXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arch-meson: introduce efusedump command
Content-Type: text/plain; charset="UTF-8"
To: Alexey Romanov <avromanov@sberdevices.ru>
Cc: narmstrong@baylibre.com, trini@konsulko.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi Alexey,

On Tue, 13 Dec 2022 at 10:31, Alexey Romanov <avromanov@sberdevices.ru> wrote:
>
> Keeping the commands code in an arch/ is not correct. This patchset
> moves the meson smc commands from arch/arm/mach-meson to cmd/meson
> folder and also adds a new 'efusedump' command with which user can
> print efuse memory.
>
> Alexey Romanov (3):
>   asm/arch-meson: add missing meson_sm_write_efuse signature
>   arm/mach-meson: move smc commands in cmd/meson
>   cmd/arm: meson: sm: introduce efusedump command
>
>  MAINTAINERS                          |   1 +
>  arch/arm/include/asm/arch-meson/sm.h |   2 +
>  arch/arm/mach-meson/sm.c             | 144 ---------------------
>  cmd/Kconfig                          |   7 +
>  cmd/Makefile                         |   3 +
>  cmd/meson/Makefile                   |   5 +
>  cmd/meson/sm.c                       | 187 +++++++++++++++++++++++++++
>  7 files changed, 205 insertions(+), 144 deletions(-)
>  create mode 100644 cmd/meson/Makefile
>  create mode 100644 cmd/meson/sm.c
>
> --
> 2.25.1
>

It might be a good time to add some documentation in doc/usage/cmd/meson ?

Regards,
Simon
