Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web12.23347.1627649672697213779
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:54:33 -0700
Received: by mail-wm1-f41.google.com with SMTP id m19so5937847wms.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+wQVwM5PvVbWmwrfatQcKv2gTVwb1pNmXG11MAJMmk=;
        b=gROI8vuIE7DT41cu6elRJUES2Gbt/kblPcrHkNxvYAAt51GmNj9g7JWqNICbS8lla7
         yfnRwSneLbZlLcZxH9ttvc/z43N/6KIiw1xPOCg3ZrMhqM6QS6M6iruDKvEsjNqmS+f6
         GUkc5V8tpEHlWNYm1KDkb9nFzksxa8uxKcflGDPUrHVxVU0u95H4ZGuHPm13Zydg7sgc
         ssFXln4RRjrMlhyB4qUCNZSmY3cVpqm+64g2ppUQEl046uCB3tZRUb3w7thmhPBsxvr9
         OKjlQ+218NNXyRdGPb8FaSGGe+qT5wtd+vrQoV45JBrh1Uki4y6+DOp3NZuaGApWRYlJ
         bv4w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/5] meson64_android: use BCB for reboot reason
References: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <906b58e6-be5f-c87b-acc3-6c31284a7dcd@baylibre.com>
Date: Fri, 30 Jul 2021 14:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 30/07/2021 14:28, Mattijs Korpershoek wrote:
> The SEI-610 and SEI-510 boards are well supported in the
> Android Open Source project via the yukawa [1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> Android has multiple OSes it can boot into:
> * Main android
> * Recovery OS
> * Fastbootd (recovery OS with fastboot mode)
> * Bootloader (U-Boot) with fastboot mode
> 
> The decision of which OS to boot into is taken by the bootloader based on
> the "reboot reason".
> 
> For amlogic boards, we pass the reboot reason via a custom smc call.
> This support is limited: we don't r
> 
> These series reworks the reboot reason handling to use the BCB, which
> is the standard Android way.
> 
> [1] https://android.googlesource.com/device/amlogic/yukawa
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> Changes in v2:
> * re-ordered commits
> * added Neil's Acked-by
> 
> Mattijs Korpershoek (5):
>   configs: meson64_android: use BCB for reboot to bootloader
>   configs: meson64_android: implement recovery boot via BCB
>   configs: meson64_android: reboot to fastbootd from bootloader
>   configs: sei610/sei510: set CONFIG_CMD_BCB=y
>   Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
> 
>  arch/arm/mach-meson/board-common.c | 34 -----------------
>  configs/sei510_defconfig           |  1 +
>  configs/sei610_defconfig           |  1 +
>  include/configs/meson64_android.h  | 60 ++++++++++++++++++++----------
>  4 files changed, 42 insertions(+), 54 deletions(-)
> 

Applied to u-boot-amlogic

Thanks,
Neil
