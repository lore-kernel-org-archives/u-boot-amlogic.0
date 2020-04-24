Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.1230.1587712720197544401
 for <u-boot-amlogic@groups.io>;
 Fri, 24 Apr 2020 00:18:40 -0700
Received: by mail-wr1-f66.google.com with SMTP id b11so9465390wrs.6
        for <u-boot-amlogic@groups.io>; Fri, 24 Apr 2020 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBoyiCqTX/SfRDbVss0soYvRc/bRVfdmptYdYqH+4ek=;
        b=dUO2aVnaonil78lq+8yUE1ofJjtLez4Ki+PQ5vECo8HWnvLM40wuxHelU7zIs6gCGJ
         d0zZdiv6QckRl1HBTABQRTbXO8cOsg2iANfxdjfHb/5CJ7cK4LtBd5ewHuko2mQ6gBBX
         1V4c9AvnDwMEve3x8JLbRU5iyg/xTExV+t1SDJdsP0qEVxa92erq8+ZkOqCMW1nSDqmY
         Hw0YUkHhtdX70uq/Cq9bpnyhmdYkG7rC2MrOcf1cuEU6Dix58ahA/p2zoaWLNPvdOG2d
         RgDzZ/oqmJGiTlfEyaF5Jik3GT7hhlHrW/dpmJ7CyNddxPfpmcgRFO/gBmUZPHwvCbok
         EW3Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] arm: khadas-vim: enable support for SPI NOR Flash
References: <16078B1116115F52.6073@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <cc323da9-9c01-e13e-f009-b2fcfb584a21@baylibre.com>
Date: Fri, 24 Apr 2020 09:18:37 +0200
MIME-Version: 1.0
In-Reply-To: <16078B1116115F52.6073@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 15:44, Neil Armstrong via groups.io wrote:
> This serie enables support of the on-board SPI NOR Flash found on the
> Khadas VIM2, VIM3 and VIM3L board.
> 
> Neil Armstrong (5):
>   arm64: dts: meson: sync dt and bindings from v5.7-rc1
>   arm: dts: meson-gxm-khadas-vim2-u-boot: enable SPI NOR flash
>   configs: khadas-vim2: enable support for SPI NOR flash
>   arm: dts: meson-khadas-vim3: enable SPI NOR flash
>   configs: khadas-vim3: enable support for SPI NOR flash
> 
>  arch/arm/dts/meson-axg-s400.dts               |   6 +-
>  arch/arm/dts/meson-g12-common.dtsi            | 136 ++++++++++++++++--
>  arch/arm/dts/meson-g12.dtsi                   |   1 +
>  arch/arm/dts/meson-g12a-sei510.dts            |   4 +-
>  arch/arm/dts/meson-g12a-u200.dts              |   2 +-
>  .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |   7 +
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi      |   4 +-
>  arch/arm/dts/meson-g12b-odroid-n2.dts         |  25 +++-
>  arch/arm/dts/meson-gx.dtsi                    |  52 +++++++
>  arch/arm/dts/meson-gxbb-odroidc2.dts          |   1 +
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        |   9 +-
>  .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi |  15 ++
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        |  89 +++---------
>  arch/arm/dts/meson-gxm.dtsi                   |  28 ++++
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  21 +++
>  arch/arm/dts/meson-khadas-vim3.dtsi           |  24 +++-
>  .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |   7 +
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts       |   8 +-
>  arch/arm/dts/meson-sm1-sei610.dts             |   3 +-
>  arch/arm/dts/meson-sm1.dtsi                   |   1 +
>  configs/khadas-vim2_defconfig                 |   8 ++
>  configs/khadas-vim3_defconfig                 |   9 ++
>  configs/khadas-vim3l_defconfig                |   9 ++
>  include/dt-bindings/clock/g12a-clkc.h         |   2 +
>  include/dt-bindings/clock/gxbb-clkc.h         |   1 +
>  25 files changed, 371 insertions(+), 101 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
> 

Applied to u-boot-amlogic
