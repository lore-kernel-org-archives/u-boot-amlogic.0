Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.7341.1627551469934752038
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:37:50 -0700
Received: by mail-wr1-f46.google.com with SMTP id q3so6155614wrx.0
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66BNa11kdUyKcaqMavUIPwOU70DECPo0ZxOi9eAjRMg=;
        b=t2TtmTGKIBoatP4eGWwXb2zziKpFxaT0eTWZAmw+6vu/qgzJdU0HnT7ELE5/qkRQu3
         jxjM9/K9jxEB6e9gZDskpqg6MfdfsKEvzdcN//S2eVN2tL8qlvzGQufVUTNJwuLf4Ypm
         opJS1OVi325uWam61VH612c0PobjjQbf6sk0cskHIvvudjKsQxAh7mNv37pF2DHirTLn
         bQffr8C5C/m26k9Ua4t/FIRDCegbO96LaoDZo9LACFjQXyWI8jW9uS3cXRlhRVq0RVwV
         6CZbdzCTCrDUNEK+X9bz94FFEGTjTmnXpoLY4W+APnb8suksdJ6NCQI4/h9O/obqm+ev
         MnPw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/6] VIM3: misc cleanups to prepare android support
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0c9e9076-e0a8-9b81-da35-52c944be1de8@baylibre.com>
Date: Thu, 29 Jul 2021 11:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> The Khadas VIM3 and VIM3L boards are well supported in the
> Android Open Source project via the yukawa[1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> These series a couple of cleanups to prepare to add mainline U-Boot support
> for vim3 / vim3l so that we can boot Android.
> 
> [1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> Mattijs Korpershoek (6):
>   configs: sei610: fix typo in header comment
>   configs: meson64_android: fix bad indent in EXTRA_ENV_SETTINGS
>   configs: meson64_android: use CONFIG_FASTBOOT_USB_DEV
>   configs: meson64_android: use boot part label instead of index
>   configs: meson64_android: use logo part label instead of index
>   configs: meson64_android: don't set console bootargs
> 
>  include/configs/meson64_android.h | 30 +++++++++++++++++-------------
>  include/configs/sei610.h          |  2 +-
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 

Applied to u-boot-amlogic


Thanks,
Neil
