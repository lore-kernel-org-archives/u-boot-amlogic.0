Received: by mail-wr1-f65.google.com with SMTP id n4so62083843wrs.3
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0xyVnRbTIKisUn3rWqLy3PI2B29NswEKkShI9IOAmS0=;
        b=ee2N2FRGlkoAk2Ft8RBirPkoPQJHPKLj+K2s8kGRZl7OaLDSxJ3YzwW/qh7hbnLI5Q
         AUL2TbHeLpCkJN9As1qRv4eFQGtyZ4PMu0Sj+Tha+NDN/GqPk7q13LSBm9fCI7+gmyEH
         DcBwbu88TdauF9sAb58PlcKwknhnViqyT20YGHvwd/RlzAe+utwvN/5WixrnfteGBoYz
         99nmI69N6LyrRSNc18AkknpKXiEqgxvko4n29f9lwjSIZRhSsAaUsIC/7UfTF8QB1ZMn
         RILmhZ9Wi1cWDqB9m7gxcsC8QLVYORCEgGVGNoK7tqN8mSeilAxtk9UO2frMtjZQZFTP
         2h2g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] amlogic: add support for the SEI Robotic SEI510
References: <20190729140158.6954-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8d5a5180-2e87-035e-a1ab-b2d43bbc15b9@baylibre.com>
Date: Mon, 29 Jul 2019 16:05:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190729140158.6954-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2019 16:01, Neil Armstrong wrote:
> The SEI510 board is based on the Amlogic S905X2 SoC
> from the Amlogic G12A SoC family.
> 
> The board has the following specifications :
> - Amlogic S905X2 ARM Cortex-A53 quad-core SoC
> - XGB DDR4 SDRAM
> - 10/100 Ethernet (Internal PHY)
> - 1 x USB 3.0 Host
> - eMMC
> - SDcard
> - Infrared receiver
> - SDIO WiFi Module
> 
> The board default behaviour is for booting Android and triggers
> fastboot on recovery or reboot mode.
> 
> Jerome Brunet (1):
>   boards: meson: add g12a sei510
> 
> Neil Armstrong (4):
>   ARM: dts: Import Amlogic G12A SEI510 DT from Linux 5.3-rc1
>   configs: meson64: permit redefining ENV_SIZE
>   ARM: meson: Add support for fastboot_set_reboot_flag()
>   configs: sei510: disable PSCI_RESET to support fastboot reboot_flag
> 
>  arch/arm/dts/Makefile                |   1 +
>  arch/arm/dts/meson-g12a-sei510.dts   | 502 +++++++++++++++++++++++++++
>  arch/arm/include/asm/arch-meson/sm.h |  18 +
>  arch/arm/mach-meson/board-common.c   |  33 ++
>  arch/arm/mach-meson/sm.c             | 155 +++++++++
>  board/amlogic/sei510/MAINTAINERS     |   5 +
>  board/amlogic/sei510/Makefile        |   6 +
>  board/amlogic/sei510/README          | 123 +++++++
>  board/amlogic/sei510/sei510.c        |  26 ++
>  configs/sei510_defconfig             |  75 ++++
>  include/configs/meson64.h            |   2 +
>  include/configs/sei510.h             | 137 ++++++++
>  12 files changed, 1083 insertions(+)
>  create mode 100644 arch/arm/dts/meson-g12a-sei510.dts
>  create mode 100644 board/amlogic/sei510/MAINTAINERS
>  create mode 100644 board/amlogic/sei510/Makefile
>  create mode 100644 board/amlogic/sei510/README
>  create mode 100644 board/amlogic/sei510/sei510.c
>  create mode 100644 configs/sei510_defconfig
>  create mode 100644 include/configs/sei510.h
> 

Missing my Signed-off-by tags.. resending sorry for the noise.

Neil
