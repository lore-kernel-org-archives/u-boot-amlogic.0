Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3DC4829B
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 15:01:09 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.3719.1707733690220184948
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Feb 2024 02:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QTT822xb;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: igor.opaniuk@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b182249a1so871101f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 02:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707733688; x=1708338488; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7Uf/bPWaXxmP4NCM20OY8pz/seJRydGGW8gS9Ety0Q=;
        b=QTT822xbAdYM7DBabbW2cFgPqNqjqdeaZ+7bGCMI7W+Xv5KFHdohboB8YsoJOrcnke
         V8oEIeMLn2FEx4chhWfz/Afv4cZEVeZcLUvj3iA2/rAwOL55MbcJBH697FPT7ZSeJNN4
         3a9OItHgEHEuk1kWW52VVjmc7AYYr8CE040Ixg9tj5zjccljR1J2MdHUsHeRoNgudji0
         xdVBZs7ehMXGJ4Uba4ZvYAsDbWaSIOQ/N0ertRAmRIS14C8UgscmXL32ZQKhrvRWvF8E
         grjeFTmpAcdR9u7WxXrGXbqz1Bf0AQK0nEBNovJVgVjqWdtGuxw3HPoqQfemkFXksZWZ
         CjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733688; x=1708338488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7Uf/bPWaXxmP4NCM20OY8pz/seJRydGGW8gS9Ety0Q=;
        b=wAhrPyfCIJgHTzeR/ugQCQKd2SMUXLd3Pu7JGe+8I5ltbvoL+vQJ9P2wPXVDpBqM7p
         BOOs1JMINZA0HQhqqOoIxUa1gAX10gl7pbMUzdnFyGm/aDxm/3CL6DZmVoM8aTzdyZ3W
         sHtHkO/g4miJdqznQOLFhwUimFNsfGYrtzrN9k8nvFO3Dip50KcfjRSxZCYR42hrWuSG
         vPwLwnewYuRffquUB9ywShzMb4v+xfYdRuL/O7ETTX2emTQTe/mn2B+Y61gJT2wbIT7Z
         eGAIN4iIDmZR1KyeCxDEYaW5zT3pGjaa3juurwCqKoGRV96BijHwsEzdfJWJqh3G9p2D
         Z6tw==
X-Forwarded-Encrypted: i=1; AJvYcCVGfZ0u0R6/4ZqUla2SqKnbbxj2D1OBwRh5uD+qEq+pH5wvttG0Dj4SrEBmUGlA07ecpG86/1ZgKLWW0h+dHPkt3GVCeOltky4=
X-Gm-Message-State: AOJu0Yz2sBgftD76yJuxhbQYSf9ioh9o99uA2UuXLPe3lLa+vsjDOo+s
	fmXUZ14yGwgeIRRWmxCJrAhs9DPaKfXYDr76EnGMAE2QZwvd3m/kPGd64yApyHwWu3gpxmgKWZY
	zQlAf8iVbWrVyI5kLRmcD6mL+juI=
X-Google-Smtp-Source: AGHT+IFAwjSK5rYmHcGkRN64gMzQiu+w9KBbRmle6rR0dTje7PzOlQcm58r0X40+WIU0Jhh9At63Zj8xzjBIjaf41jg=
X-Received: by 2002:a05:6000:1e05:b0:33b:43d9:7ec7 with SMTP id
 bj5-20020a0560001e0500b0033b43d97ec7mr5951619wrb.3.1707733688436; Mon, 12 Feb
 2024 02:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 12 Feb 2024 11:27:56 +0100
Message-ID: <CAByghJYa1TpEO9kWdy9w1vKBMVp5TkMxQ9dbkmOYPaXzAJFwOw@mail.gmail.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Guillaume La Roque <glaroque@baylibre.com>, 
	u-boot-amlogic@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 15:01:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2123

On Fri, Feb 9, 2024 at 10:07=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When booting Android with AVB enabled, an OOM is observed:
>
>   =3D> avb init ${mmcdev}
>   =3D> avb verify _a
>   ## Android Verified Boot 2.0 version 1.1.0
>   read_is_device_unlocked not supported yet
>   read_rollback_index not supported yet
>   avb_util.c:182: ERROR: Failed to allocate memory.
>   OOM error occurred during verification
>
> A custom malloc length of 128MB is required as documented in
> commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN t=
o 128M for AVB")
>
> However, this 128M custom malloc length was not ported to Kconfig in
> commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
>
> Add it back to fix AVB verification on VIM3/VIM3L.
>
> Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig  | 1 +
>  configs/khadas-vim3_android_defconfig     | 1 +
>  configs/khadas-vim3l_android_ab_defconfig | 1 +
>  configs/khadas-vim3l_android_defconfig    | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vi=
m3_android_ab_defconfig
> index b41c2660fff0..ee62fe36d414 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_=
android_defconfig
> index 88197f5f5e99..cecbe5061793 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-v=
im3l_android_ab_defconfig
> index 3381d2e92701..ec4e0dc72e22 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3l_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3=
l_android_defconfig
> index 3fa587ef1db5..206f8defca6b 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3l_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
>
> ---
> base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
> change-id: 20240209-vim3-avb-malloc-aa3de534d6a0
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk

