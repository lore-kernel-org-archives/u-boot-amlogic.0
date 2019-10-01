Received: by mail-wr1-f66.google.com with SMTP id n14so14345739wrw.9
        for <u-boot-amlogic@groups.io>; Tue, 01 Oct 2019 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g5faoAMgA7/dRIljB7u3Zs+SS+8oN/QNKhlXGdzDEGs=;
        b=T5knndcfrnqwDLgIoIVASvHT673ufpuE0KCN4oSOLziKnX/XXOKsEZCd1uXrcORVf/
         h1UT2biLlZ8G7DqlDPx6u7RflgxMZyyA0Vo+QIqAvzrTw1L7FCkg0FMhodTC18mWxjy5
         Lswo9vVqm4ZwgiqMT7IIrSs9Bk8r4wMgSF1bzsriTSSFTILLEdmIWSZhrBfGvivfNuFH
         ngSeacLtmy5aupSFm/pI6/2aY2UryUJvENCsDcCYFuNzoJqrZt9OTbh53kHYNQSQ9HvB
         1BFgK/6UlaW1fkLLzJMIY1dJ0dZn5cNBMtVBG7bukkpjjY6n/+P4Ao4FvGZ0EgTxEmO4
         IUFw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/4] amlogic: Add Khadas VIM3 support
References: <20190902121914.18946-1-afaerber@suse.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e9e9709e-54d9-4f7a-8f5d-3d57316a3bf6@baylibre.com>
Date: Tue, 1 Oct 2019 10:38:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190902121914.18946-1-afaerber@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Andreas,

On 02/09/2019 14:19, Andreas Färber wrote:
> Hi Neil,
> 
> This mini-series adds initial support for Amlogic A311D based Khadas VIM3.
> 
> v2 fixes an oversight and adds some cleanups.
> 
> Regards,
> Andreas
> 
> v1 -> v2:
> * Fixed branch name in README
> * Mention linux-next tag for DT/header import (Neil)
> * Avoid "Unknown" SoC output for A311D, fixing a typo while at it

Do you have time to rebase patch 1 on Linux v5.3-rc1 ? Or do you allow me to rebase it myself ?

Neil

> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> 
> Andreas Färber (4):
>   arm: dts: Import and update DT for Khadas VIM3
>   configs: Add Khadas VIM3 defconfig
>   arm: meson: Tidy SoC information output
>   arm: meson: Recognize A311D SoC
> 
>  arch/arm/dts/Makefile                              |    3 +-
>  arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++++++++
>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
>  arch/arm/dts/meson-g12b.dtsi                       |   39 +-
>  arch/arm/mach-meson/board-info.c                   |    3 +-
>  board/amlogic/w400/MAINTAINERS                     |    1 +
>  board/amlogic/w400/README.khadas-vim3              |  132 ++
>  configs/khadas-vim3_defconfig                      |   54 +
>  include/dt-bindings/clock/g12a-clkc.h              |    6 +
>  include/dt-bindings/power/meson-g12a-power.h       |   13 +
>  .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
>  13 files changed, 3427 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12-common.dtsi
>  create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
>  create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
>  create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
>  create mode 100644 board/amlogic/w400/README.khadas-vim3
>  create mode 100644 configs/khadas-vim3_defconfig
>  create mode 100644 include/dt-bindings/power/meson-g12a-power.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
> 

