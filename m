Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.4342.1641546788958824113
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Jan 2022 01:13:09 -0800
Received: by mail-wm1-f54.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so3290104wmb.1
        for <u-boot-amlogic@groups.io>; Fri, 07 Jan 2022 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXwQnLfFSW0PnZHuwxoJAnx/QsKgz9n0lHqO/vbIMQY=;
        b=cKVlsbhXOAXQB+86QeP/Hro0tXCwhwAdPSvrl9P9SSEqtYYCf6Yk+wFLfJyuJehsNZ
         GtrvEtsZWz8lSmFS3OLu+LqkyneMz24fhaT0S9pEnhcAYNR3bGGZcRX4hsJjDJRqOnzI
         2mtkJEVJa6in3ryfWIGNUqPFLKe64aCXJarishetlFKaQ0wINyP2Ih8VhqxX5swgJLoj
         Y8pMeZnwarmRNx4jL8YLb7BItF54WQB0lI2ph3iwKVRgW+sSDWe7HTu0q3Iu1pJm60bI
         2Akd947rE5J7/EmWBytvQ571TeliybxADL7G8peM7nzkNUuBHU0epgK13T7tkvBHpCaU
         wv2w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/4] meson64_android: add support for vim3/vim3l boards
References: <20211122152207.219023-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e95854dd-1fdb-141f-cf12-fab1f45781b3@baylibre.com>
Date: Fri, 7 Jan 2022 10:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <20211122152207.219023-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 22/11/2021 16:22, Mattijs Korpershoek wrote:
> The VIM3 and VIM3L boards are well supported in the
> Android Open Source project via the yukawa [1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> [1] https://android.googlesource.com/device/amlogic/yukawa
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> Add defconfigs for both vim3, vim3l to support
> traditional and A/B booting/partitioning schemes.
> 
> Changes in v2:
> * Squashed defconfig changes for initial support
> * Split out partitition changes for A/B
> 
> v1:
> * https://lore.kernel.org/u-boot/20211119100829.843139-1-mkorpershoek@baylibre.com/T/#t
> 
> 
> Mattijs Korpershoek (4):
>   configs: meson64_android: add board specific env settings
>   configs: add khadas-vim3{l}_android for AOSP support
>   configs: prepare khadas-vim3{l}_ab_android for AOSP support
>   configs: khadas-vim3{l}_android_ab: enable A/B support
> 
>  board/amlogic/vim3/MAINTAINERS            |   4 +
>  configs/khadas-vim3_android_ab_defconfig  | 109 ++++++++++++++++++++++
>  configs/khadas-vim3_android_defconfig     | 107 +++++++++++++++++++++
>  configs/khadas-vim3l_android_ab_defconfig | 109 ++++++++++++++++++++++
>  configs/khadas-vim3l_android_defconfig    | 107 +++++++++++++++++++++
>  include/configs/khadas-vim3_android.h     |  50 ++++++++++
>  include/configs/khadas-vim3l_android.h    |  50 ++++++++++
>  include/configs/meson64_android.h         |  17 ++++
>  8 files changed, 553 insertions(+)
>  create mode 100644 configs/khadas-vim3_android_ab_defconfig
>  create mode 100644 configs/khadas-vim3_android_defconfig
>  create mode 100644 configs/khadas-vim3l_android_ab_defconfig
>  create mode 100644 configs/khadas-vim3l_android_defconfig
>  create mode 100644 include/configs/khadas-vim3_android.h
>  create mode 100644 include/configs/khadas-vim3l_android.h
> 


Applied to u-boot-amlogic

Thanks,
Neil
