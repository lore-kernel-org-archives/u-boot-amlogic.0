Received: by mail-wr1-f66.google.com with SMTP id g17so68422826wrr.5
        for <u-boot-amlogic@groups.io>; Wed, 31 Jul 2019 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JoXf3o5b8X5D5gBOBvsv6EFaTPkhq9aru9F7eu3zn1E=;
        b=Spzqk9PBdQopQkEgXvcJCSOAPIXULilgPchIqhROirR9mbiFX1byr3HJGObA/H1y3s
         6gR05l6a1cjwlWysT013MMJquznWSWlsPI7wB8YNsx2JbDD695Xs2c2IZtumf6fPC+tH
         QbJ+rCInzORegQmSwFKY7IO6VcW50slB7ruEidtvr5ovW4jkixwcItBRpJXt1n007F/u
         8vv+SYp++k6v+VGgLvYiy9Q3etxk1Y3o8k1yP3JgkyYYFM5B2cBrpfWDMQ+hA7gEthSI
         sXSc/5RZm6InnfMo5quolSX2wzhhyKjsOeBFlMH0JSW2I/jI0ix+h0R6bH9jIvjQscLQ
         RIAA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] amlogic: Add support for Odroid-N2
References: <20190729134552.8860-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e7b105e3-d40f-16fc-9dc0-09a3108730bd@baylibre.com>
Date: Wed, 31 Jul 2019 09:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190729134552.8860-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2019 15:45, Neil Armstrong wrote:
> ODROID-N2 is a single board computer manufactured by Hardkernel Co. Ltd
> with the following specifications:
> 
>  - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
>  - 4GB DDR4 SDRAM
>  - Gigabit Ethernet
>  - HDMI 2.1 4K/60Hz display
>  - 40-pin GPIO header
>  - 4 x USB 3.0 Host, 1 x USB OTG
>  - eMMC, microSD
>  - Infrared receiver
> 
> This patchset :
> - adds the Odroid-N2 from Linux 5.3-rc1
> - fixes 4GiB memory support
> - adds board support
> 
> The board directory is W400, the name of the Amlogic Reference Design
> of Amlogic G12B with Gigabit boards, which will be used for similar
> boards.
> 
> Changes since v1:
> - Fix typo in README.odroid-n2
> 
> Neil Armstrong (3):
>   ARM: dts: add support for Odroid-N2
>   ARM: meson-g12a: Handle 4GiB DRAM size
>   board: amlogic: add support for Odroid-N2
> 
>  arch/arm/dts/Makefile                         |   3 +-
>  arch/arm/dts/meson-g12b-odroid-n2.dts         | 386 ++++++++++++++++++
>  arch/arm/dts/meson-g12b.dtsi                  |  82 ++++
>  arch/arm/mach-meson/board-g12a.c              |  13 +-
>  board/amlogic/w400/MAINTAINERS                |   6 +
>  board/amlogic/w400/Makefile                   |   6 +
>  board/amlogic/w400/README.odroid-n2           | 130 ++++++
>  board/amlogic/w400/README.w400                | 130 ++++++
>  board/amlogic/w400/w400.c                     |  18 +
>  configs/odroid-n2_defconfig                   |  56 +++
>  .../dt-bindings/sound/meson-g12a-tohdmitx.h   |  13 +
>  11 files changed, 836 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
>  create mode 100644 arch/arm/dts/meson-g12b.dtsi
>  create mode 100644 board/amlogic/w400/MAINTAINERS
>  create mode 100644 board/amlogic/w400/Makefile
>  create mode 100644 board/amlogic/w400/README.odroid-n2
>  create mode 100644 board/amlogic/w400/README.w400
>  create mode 100644 board/amlogic/w400/w400.c
>  create mode 100644 configs/odroid-n2_defconfig
>  create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h
> 

Applied on u-boot-amlogic

Neil
