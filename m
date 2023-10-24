Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBFC07545
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 07:05:17 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.12432.1698131112914595681
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Oct 2023 00:05:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=LaX98h56;
 spf=pass (domain: baylibre.com, ip: 209.85.167.54, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50797cf5b69so5647446e87.2
        for <u-boot-amlogic@groups.io>; Tue, 24 Oct 2023 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698131111; x=1698735911; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vvERfCuXPlDXu2dUvdAlNm8Az0AGvwpFt3aWrDt2cY=;
        b=LaX98h565QV+MzIJOLCydYk6wkLJiMDg9KZrLI737ndAemaSkdbIcuV2vC7H6uY5Er
         KQ1jtuKIglMJZiba/HR39ze7UJTuJd/GlL/nAf7j3TgNsinUWAU6x2ZcsveCBuEnV7ct
         jROs9lNr6XCJQNk90du/MD3calRk8DKU9Awk8t392DiV8yTmQDJbwhK+ZnlE+P0/LI5N
         E5uhyB+FkNIyc6pXthEHl+XM1/dTQDvzsYIv2AtsXPMFdBZ3RINRL1Y1/YVuWYz5JewK
         tts75LUdN9dGqmH/b1tOSKpIE5ppFRorl7yf2l3o/f4pBKfD8ZpS7va4LZTSemz16H2R
         vWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131111; x=1698735911;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vvERfCuXPlDXu2dUvdAlNm8Az0AGvwpFt3aWrDt2cY=;
        b=Tkgra7Rbq5W5VLgwj6ulnsg125Ylo0aoTwjUAc7al5TJN8E9caJ+ViD/NqBg5cJGXY
         iG5CFcV9lO0KSF+FDRS7b+Gy+lZJzK3aDZSB0gVZZKq8LwZAz8QAfN/Qo9OJjrJbJkjJ
         TZzGn2PrqiL8kA0B/2L6gXxTslKqHi9IhpGPzs626d3V0vTKylkJpH0nbwWi4eXPTzXa
         fFQ9PsPCzf7+9Ptg68Ccb8PT3BQ877x9WU8NkDZChDz+3pVEEkFVSWuq97BKZ15qC+R7
         A54qOGLXsMTyJlz9JPywiPUbSxlBa89LE01nsvxQ99Zutbu6Kc6/Pm6sWAX4lbHAGMXJ
         oMoQ==
X-Gm-Message-State: AOJu0Yzimj/G1IOVK1zWl8tdUrQo4+XE3d6F6BC2/zp2iXBpoldqYCDt
	5cKVc95W7aLxQiMiyp9MqX6Wqf4iIOX5ahRoxKI=
X-Google-Smtp-Source: AGHT+IEc5B6S+JSHIQnZeesEGsLvoVMYAhizlCIaQjC1TkcHNwKctui0SH8Lk5hN5JjaVY7gjyGCNQ==
X-Received: by 2002:ac2:4c16:0:b0:507:cb61:2054 with SMTP id t22-20020ac24c16000000b00507cb612054mr8291613lfq.49.1698131110691;
        Tue, 24 Oct 2023 00:05:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c210100b004068de50c64sm11025728wml.46.2023.10.24.00.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:05:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org, Christian Hewitt
 <christianshewitt@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong
 <neil.armstrong@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
Date: Tue, 24 Oct 2023 09:05:05 +0200
Message-ID: <874jigsdpa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 24 Oct 2023 07:05:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1795

Hi Neil,

Thank you for the series.

On lun., oct. 23, 2023 at 14:41, "Neil Armstrong" <neil.armstrong@linaro.org> wrote:

> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
>
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
>
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I did a simple boot to aosp/main test on vim3 and also used fastboot to
flash the bootloader.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
> Neil Armstrong (4):
>       ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
>       configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
>       configs: meson64: add alternate USB DFU boot target
>       ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget
>
>  configs/ad401_defconfig                   |  2 ++
>  configs/bananapi-cm4-cm4io_defconfig      |  6 ++++
>  configs/bananapi-m2-pro_defconfig         |  6 ++++
>  configs/bananapi-m2s_defconfig            |  6 ++++
>  configs/bananapi-m5_defconfig             |  6 ++++
>  configs/beelink-gsking-x_defconfig        |  6 ++++
>  configs/beelink-gt1-ultimate_defconfig    |  6 ++++
>  configs/beelink-gtking_defconfig          |  6 ++++
>  configs/beelink-gtkingpro_defconfig       |  6 ++++
>  configs/jethub_j100_defconfig             |  6 ++++
>  configs/jethub_j80_defconfig              |  6 ++++
>  configs/khadas-vim2_defconfig             |  6 ++++
>  configs/khadas-vim3_android_ab_defconfig  |  4 +++
>  configs/khadas-vim3_android_defconfig     |  4 +++
>  configs/khadas-vim3_defconfig             |  6 ++++
>  configs/khadas-vim3l_android_ab_defconfig |  4 +++
>  configs/khadas-vim3l_android_defconfig    |  4 +++
>  configs/khadas-vim3l_defconfig            |  6 ++++
>  configs/khadas-vim_defconfig              |  6 ++++
>  configs/libretech-ac_defconfig            |  6 ++++
>  configs/libretech-cc_defconfig            |  6 ++++
>  configs/libretech-cc_v2_defconfig         |  6 ++++
>  configs/libretech-s905d-pc_defconfig      |  6 ++++
>  configs/libretech-s912-pc_defconfig       |  6 ++++
>  configs/nanopi-k2_defconfig               |  4 +++
>  configs/odroid-c2_defconfig               |  4 +++
>  configs/odroid-c4_defconfig               |  6 ++++
>  configs/odroid-go-ultra_defconfig         |  6 ++++
>  configs/odroid-hc4_defconfig              |  6 ++++
>  configs/odroid-n2_defconfig               |  6 ++++
>  configs/odroid-n2l_defconfig              |  6 ++++
>  configs/p200_defconfig                    |  4 +++
>  configs/p201_defconfig                    |  4 +++
>  configs/p212_defconfig                    |  4 +++
>  configs/radxa-zero2_defconfig             |  6 ++++
>  configs/radxa-zero_defconfig              |  6 ++++
>  configs/s400_defconfig                    |  6 ++++
>  configs/sei510_defconfig                  |  6 ++++
>  configs/sei610_defconfig                  |  6 ++++
>  configs/u200_defconfig                    |  6 ++++
>  configs/videostrong-kii-pro_defconfig     |  4 +++
>  configs/wetek-core2_defconfig             |  6 ++++
>  configs/wetek-hub_defconfig               |  4 +++
>  configs/wetek-play2_defconfig             |  4 +++
>  include/configs/meson64.h                 | 49 ++++++++++++++++++++++++++-----
>  45 files changed, 278 insertions(+), 7 deletions(-)
> ---
> base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
> change-id: 20231023-usb-dfu-boot-f47849f9fb34
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1789): https://groups.io/g/u-boot-amlogic/message/1789
> Mute This Topic: https://groups.io/mt/102134207/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/leave/9114030/1991006/1716920881/xyzzy [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

