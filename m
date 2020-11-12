Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.4070.1605187820149287135
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Nov 2020 05:30:20 -0800
Received: by mail-wr1-f67.google.com with SMTP id d12so5961366wrr.13
        for <u-boot-amlogic@groups.io>; Thu, 12 Nov 2020 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCyrFQZqI8Cn01ngYku8PasF3nzG3zmpXx0QUP8Bs1Q=;
        b=atH+yGVuep3SaGCSPVv8AmhvNrK8tlYeidUamJNDFbwDC2MiKyL8iNaEjY7+8Us9P8
         5KxftNsHSHyXEVwL6WO/Z/OxWhjnhznpN1tqFqXIRYWaXdD0onyLXPJFIwixQrZJ4PDx
         0AeSorq6tY3n/ah72uOIFF54+3jzIRJ+iHmj2wPc6sWChlI8eG0peQiJEiYEnsdFWo4k
         9DgPD5ysKDFZi0UxKB99YV63Cm5vQnV6VI+GN5WoTpSnbgvVTvw7nb8KsjZX5dqpf2lr
         iTPhE+EZrKb71JD7mTAkiJlL71jS6WZRpZyGWnaNHLnSJHOjKi5E4lX03IooY6NWxs32
         1YMg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/3] mmc: meson-gx: fix mmc & sdcard failur on SM1 SoCs
References: <CGME20201110232156epcas1p11a12c40acfb7f04ad864f001c0e4ea77@epcas1p1.samsung.com>
 <20201110232211.3717-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <086ae2bf-ddcc-c544-67e9-a23a08181652@baylibre.com>
Date: Thu, 12 Nov 2020 14:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201110232211.3717-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

On 11/11/2020 00:22, Jaehoon Chung wrote:
> Amlogic SM1 SoCs doesn't work over 50MHz. When phase sets to 270', it's
> working fine over 50MHz on Amlogic SM1 SoCs.
> 
> To use a proper phase value adds an u-boot only sm1 compatible.
> 
> In future, it needs to find what value is a proper about each SoCs.
> 
> According to Neil's suggestion, applied code based on below patch.
> https://patchwork.ozlabs.org/project/uboot/patch/20201109031233.25320-1-jh80.chung@samsung.com
> 
> Tested on Odroid-C4/N2, VIM3.
> 
> Changelog v2:
> - Rewrote "[2/3] mmc: meson-gx: limit max frequency on SM1 SoCs" 
> - Applied "mmc: meson_gx_mmc: change a clock phase to stable value"
> - Add Jaehoon's Signed-off tag
> 
> Neil Armstrong (3):
>   mmc: meson-gx: move arch header to local header
>   mmc: meson-gx: change clock phase value on SM1 SoCs
>   ARM: dts: meson-sm1: add u-boot specific MMC controller compatible
> 
>  .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |  1 +
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  2 --
>  .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  1 +
>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |  2 +-
>  arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |  2 +-
>  arch/arm/dts/meson-sm1-u-boot.dtsi            | 20 +++++++++++++
>  drivers/mmc/meson_gx_mmc.c                    | 29 +++++++++++++++----
>  .../sd_emmc.h => drivers/mmc/meson_gx_mmc.h   | 10 ++++---
>  8 files changed, 54 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/dts/meson-sm1-u-boot.dtsi
>  rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (95%)
> 

Thanks !

Applying to u-boot-amlogic
