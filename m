Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.5528.1628585263293753670
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Aug 2021 01:47:43 -0700
Received: by mail-wm1-f44.google.com with SMTP id 203-20020a1c00d40000b02902e6a4e244e4so346461wma.4
        for <u-boot-amlogic@groups.io>; Tue, 10 Aug 2021 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2w43PWVhK/cnpa1hg+GaMGtPCRKL76Y17fb8kMgAaMk=;
        b=TCKp3WIh8JlZgwrHeq3ANBrqxtJ/6lKEPcx+aAoVmQB5jKJHqmEXH81B/84m0rrU0Z
         BUtO/rkaR1eyKomoq4ARGWEFHQlo3eMcRoX+OvxvFPpOHYsNnOJ4Qx5Gg6FQy5ZIWQ2N
         drhY5R2qse/H4/4QrQ0X7RQaagkJIgRGtutRaSMUBXBXsEoj9zoK8beDTJEXZPTT1Pfr
         Essj42cFkdVlqI+4YUfvlAebhoqdyvxMX/un9bOX8m8tPVDMztzFWjE1V/Q1Zmmup2AM
         yvTnC30lNu+ov06pnJ3HdlVeEvQRQu572wSpVMIzy5c0F1hm6a7cx2iw2v84yFg46Ehx
         43sw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/9] meson64_android: Android boot flow using abootimg
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0ed3f1bf-4d9e-f639-0b4d-7965976e4105@baylibre.com>
Date: Tue, 10 Aug 2021 10:47:40 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> The SEI-610 and SEI-510 boards are well supported in the
> Android Open Source project via the yukawa [1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> Android 10 and higher have significantly reworked the bootloader
> requirements:
> 
> * bootloader should pass slot information in case of A/B
> * bootloader should perform AVB verification in case it's supported
> * bootloader should read and apply dtb overlays from a dtbo partition
> 
> These series add support for all the above.
> 
> [1] https://android.googlesource.com/device/amlogic/yukawa
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> Guillaume La Roque (2):
>   configs: meson64_android: boot android via abootimg
>   configs: sei510/610: android bootflow via abootimg
> 
> Mattijs Korpershoek (7):
>   configs: meson64: permit redefining SYS_MALLOC_LEN
>   configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB
>   configs: meson64_android: implement AVB support
>   configs: meson64_android: implement A/B slot support
>   configs: meson64_android: define BOOT_CMD macro
>   configs: sei510/sei610: reformat PARTS_default
>   configs: sei510/sei610: don't use hard-coded gpt uuids
> 
>  configs/sei510_defconfig          |   5 ++
>  configs/sei610_defconfig          |   5 ++
>  include/configs/meson64.h         |   2 +
>  include/configs/meson64_android.h | 139 ++++++++++++++++++++++++++++--
>  include/configs/sei510.h          |  23 +++--
>  include/configs/sei610.h          |  23 +++--
>  6 files changed, 165 insertions(+), 32 deletions(-)
> 

Applied to u-boot-amlogic

Thanks,
Neil
