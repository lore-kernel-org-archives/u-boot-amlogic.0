Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C522D62069
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 10:18:09 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.17623.1732011483633165331
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 02:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=RvdfufZG;
 spf=pass (domain: baylibre.com, ip: 209.85.221.51, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so1009552f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732011482; x=1732616282; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q2R1FVRc58kit64B4CWcn/ODtKazHZVF9HxpGMd1Vk=;
        b=RvdfufZG9o69nFjl6+rP4OIXND40dEQ/OdubwxRnEvfVv0SGMWpx8LuOj6DBdi3FSZ
         FCj+uvCLe24dsZG0Ca6R+oURl1RfaMyxCFVPMD2DWoH499T33/4oyOgbovXZpKPHJpRn
         qY9vyNqSoxEaFlQULkdNo6tJ45acC2q9BKigjS5CvLwhQmStm2W8+oD1t7TuKmMD5Zrd
         TjVpWEys7BI1N5gCFw7ib4X2du+NDFpWxL4WIhIxqUhqSQmohB38ftfbZgOEPXRBgG0s
         LSGmNwCLrRbqOtp991hDuZ9nva3ZCsqT+PB8Wmq17D2AFWwq6Y3pZf7U2vlUNsi82SKu
         KnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011482; x=1732616282;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q2R1FVRc58kit64B4CWcn/ODtKazHZVF9HxpGMd1Vk=;
        b=xS1nORpj8t2qQa4ADJj252qCRIYRYsigXZhdCZ5mcnAL8PEHqfvFFigveoV8l4R1SP
         rx83CQLmcybi126cHTpvwgSWIeWX++XK3JuGMwqdLiqo0lKKEOXoiTkvlm3A+ftVFEeN
         ERINk74bgUlSfWxDI97R5JapBRRRSU1KRSwST2VzoQHqO+lBOmbj/FDpjfwuxT8ZvOMp
         RJZOjFSup7ZTB9cpmH3icDTrhu5L9gnZWhRkplOmXJ5X8OLcduPwzBCtSZFWnenOQUZl
         Rwx7qIubNkfvVvwuEkHnd9wE/dU0v4vkXjkrFLytGlAlmate2CMHYUnvgY81o/FRGcIC
         k5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUolppQQMl5p7CyTkf7+DtxtYme3XsNoif9+h8guZtAOw9mbx/Ti5xX7JBHzuVI3OSW8FPJVmToDh9mxCfBNQ==@groups.io
X-Gm-Message-State: AOJu0Yz3f7RPSc8NaDlWy/gsKnNS6XtM32ZXJbCmFF2WGEX2+nkA/n6L
	x4V+/KRIZGoWHTzCMvKHTA5VZ6v67KT9Aqy1RRIo613lClVY+N2TTFdgWsSIbQw=
X-Google-Smtp-Source: AGHT+IFAulfPrHbBs0dnO8WchmigaP6MndegB5MPM3HHtXA4RcmdxIVS7eHuvvcKdVbk9sDB3qblsQ==
X-Received: by 2002:a05:6000:1562:b0:382:2a2b:f81e with SMTP id ffacd0b85a97d-3822a2bf928mr12817421f8f.51.1732011482130;
        Tue, 19 Nov 2024 02:18:02 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824770f3dasm5680944f8f.54.2024.11.19.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:18:01 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 2/5] bootstd: android: add non-A/B image support
In-Reply-To: <20241114-adnroidv2-v2-2-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-2-015bffb1373a@baylibre.com>
Date: Tue, 19 Nov 2024 11:17:58 +0100
Message-ID: <87y11fy1bd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 10:18:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2561

Hi Guillaume,

Thank you for the patch.

On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Update android bootmeth to support non-A/B image.
> Enable AB support only when ANDROID_AB is enabled.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/Kconfig                     |  1 -
>  boot/bootmeth_android.c          | 51 +++++++++++++++++++++++++++++++++-------
>  configs/am62x_a53_android.config |  1 +
>  configs/sandbox_defconfig        |  1 +
>  4 files changed, 44 insertions(+), 10 deletions(-)
>

[...]

