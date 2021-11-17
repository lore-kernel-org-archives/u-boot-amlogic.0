Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.6337.1637152264843309313
 for <u-boot-amlogic@groups.io>;
 Wed, 17 Nov 2021 04:31:05 -0800
Received: by mail-wr1-f45.google.com with SMTP id w29so4307367wra.12
        for <u-boot-amlogic@groups.io>; Wed, 17 Nov 2021 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pTEmm/ypT/c4lnt4/Pc/nEwGWFAT5YMnKyHI9D3oVA=;
        b=60HMaJS1MmMOseVBhWAAupDwvADJJRYR0/y/FfqvHzCuKKS18nTosNSxqdtg51/uaY
         WkS52iUZ/Yd2ff9c/tM5oQWu9+bBVO5uVsqD3oa9ymuKfUsVgV7tWS2INjFLWtCmSuk0
         QqD0hLyGfSKv9KWkl52TttWknRQcpRWCAD/OwlZSPxSy5DmQzhUfKkb759ltZHz6JKk2
         1IALcu4R+Gxj5ebeGft697f1IW/KMzuscqAuJMnBxBqq5sDV2x10neXTRxK2yphxc2Py
         r8FLiDUBf3JCBWF8VGO9B2iQKtcnQU3sC9gADC/Bbv2LzqxaLcdOjDLbw3vHWGjJ1XsN
         9ItA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] meson64_android: fix initial flashing failures
References: <20211117110411.710190-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <dbcb4a53-ddbd-78c9-210b-9a38fc09005f@baylibre.com>
Date: Wed, 17 Nov 2021 13:31:02 +0100
MIME-Version: 1.0
In-Reply-To: <20211117110411.710190-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 17/11/2021 12:04, Mattijs Korpershoek wrote:
> The SEI-610 and SEI-510 boards are well supported in the
> Android Open Source project via the yukawa [1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> For initial boards, with an empty eMMC, we can have boot loops
> while using the flashing process described in [3].
> 
> This series add 2 fixes for these bootloops.
> 
> [1] https://android.googlesource.com/device/amlogic/yukawa
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> [3] https://gitlab.com/baylibre/amlogic/atv/aosp/device/amlogic/yukawa/-/wikis/Khadas_VIM3#flash-android-bootloader
> 
> Neil Armstrong (2):
>   configs: meson64_android: bypass other checks on run_fastboot=1
>   configs: meson64_android: add PANIC stage for SYSTEM fails
> 
>  include/configs/meson64_android.h | 47 +++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 4f4f974a46244270c1c6723017711c0aa8250206
> 

Thanks,
Applied to u-boot-amlogic

Neil
