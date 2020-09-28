Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.31312.1601278868032535390
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Sep 2020 00:41:08 -0700
Received: by mail-wm1-f67.google.com with SMTP id e11so3764690wme.0
        for <u-boot-amlogic@groups.io>; Mon, 28 Sep 2020 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGLriLniQ+TPw/NOmtptJ5OpqrJ0mbaTbmFoE6WVQqE=;
        b=1qQsRrKKxt8LM3XOVpXO4lCnuma7tRI3fT/fHZWateMvLYxEhvp8xoECd29ZkUOYXp
         3kciz3VjAYAAJs6yfHSw8KfgGwewGU4jWWGTeQXbbLjbZgmLE0ANEvHiYZfXMemioo/R
         Fnlc8prnyYmd5dlJhzRdcyiODjB9wPhUCsFtzFFfSMbAHTkPu1wzj0lbYNhN0UW5O0FK
         23s4N/rsoWmxGniPssQNr/fUPjA8jNn/UiOOr7ABUr0ul2J2+aoL6M4iI5eqOz/icbyh
         6tW4/ofeisoC50uJqD5tBS3cMSqBucCrdamwW52XiP66olV1q2a/yeUWy56TOxwBkSNU
         XmXg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/4] amlogic: vim3: add support for dynamic PCIe enable
References: <20200921073415.24211-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c85d1007-668c-b3e8-a0a6-48e8cf386ee9@baylibre.com>
Date: Mon, 28 Sep 2020 09:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200921073415.24211-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 21/09/2020 09:34, Neil Armstrong wrote:
> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> an USB3.0 Type A connector and a M.2 Key M slot.
> The PHY driving these differential lines is shared between
> the USB3.0 controller and the PCIe Controller, thus only
> a single controller can use it.
> 
> This serie adds a VIM3 specific board support and adds this dynamic
> switching right before booting Linux.
> 
> Changes since v1:
> - add missing khadas-mcu.h
> - add documentation to switch pcie on/off
> 
> Neil Armstrong (4):
>   ARM: dts: sync amlogic G12A/SM1 DT from Linux 5.9-rc1
>   board: amlogic: add a vim3 specific board support
>   configs: vim3: use the vim3 board support
>   board: amlogic: vim3: add support for dynamic PCIe enable
> 
>  arch/arm/dts/meson-g12-common.dtsi            |  55 ++++---
>  arch/arm/dts/meson-g12b-odroid-n2.dts         | 136 +++++++++++++++++-
>  arch/arm/dts/meson-khadas-vim3.dtsi           |  26 +++-
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  92 ++++++++++++
>  arch/arm/dts/meson-sm1-odroid-c4.dts          |  88 ++++++++++++
>  board/amlogic/vim3/MAINTAINERS                |   9 ++
>  board/amlogic/vim3/Makefile                   |   6 +
>  board/amlogic/vim3/khadas-mcu.h               |  81 +++++++++++
>  board/amlogic/vim3/vim3.c                     | 136 ++++++++++++++++++
>  board/amlogic/w400/MAINTAINERS                |   4 -
>  configs/khadas-vim3_defconfig                 |   5 +-
>  configs/khadas-vim3l_defconfig                |   5 +-
>  doc/board/amlogic/khadas-vim3.rst             |  27 ++++
>  doc/board/amlogic/khadas-vim3l.rst            |  27 ++++
>  include/dt-bindings/clock/g12a-clkc.h         |   2 +
>  .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 ++
>  16 files changed, 679 insertions(+), 30 deletions(-)
>  create mode 100644 board/amlogic/vim3/MAINTAINERS
>  create mode 100644 board/amlogic/vim3/Makefile
>  create mode 100644 board/amlogic/vim3/khadas-mcu.h
>  create mode 100644 board/amlogic/vim3/vim3.c
>  create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
> 

Applied to u-boot-amlogic-next
