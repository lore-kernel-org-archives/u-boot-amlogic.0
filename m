Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.3964.1571390546626772844
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Oct 2019 02:22:27 -0700
Received: by mail-wm1-f66.google.com with SMTP id 3so5359942wmi.3
        for <u-boot-amlogic@groups.io>; Fri, 18 Oct 2019 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K3mdtlf2PF6Mpa2RFT2JqV61Z3kXlVzW5K4mCT71LEs=;
        b=cWzWvhna1sZPUva9CoJR2dHAzPcOR45Tr7CQ701BdyMHSjJ1xmL8ZKq9IEImhBuG6H
         qQyG0GLJR0VMO/MQjGHWWaUtjhDpm8ddZyodQgLwuM+cVHpK8lpVI+St5TW3OzSOi8e6
         Z/odbdyvmsVIFnczjf8RF1s/WjRCZZOZTQHuygifEoragipgdi+Rrk7uirMZRexKpuks
         yWmS26jtcI0EmPV1Y9RtDWWvLl+THAtY2jKn1sF8dde1KtXr+Uf0j+oVkClI22m74RSM
         d1ZEku6nndxTi2CRnrbPpG8Y4pRDWN4tJeHhp19QZR48ZWHIpAwvliCX5FOUK5tvVhyb
         v5mg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/8] amlogic: add SEI610 support
References: <20191011153358.29739-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <db736ee2-67a3-a9d3-acb2-8e9e4038cc18@baylibre.com>
Date: Fri, 18 Oct 2019 11:22:22 +0200
MIME-Version: 1.0
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/10/2019 17:33, Neil Armstrong wrote:
> Add support for the customer board SEI610 manufactured by SEI Robotics
> with the following specifications:
>  - Amlogic S905X3 ARM Cortex-A35 quad-core SoC
>  - 2GB DDR4 SDRAM
>  - 10/100 Ethernet (Internal PHY)
>  - 1 x USB 3.0 Host
>  - 1 x USB Type-C DRD
>  - 1 x FTDI USB Serial Debug Interface
>  - eMMC
>  - SDcard
>  - Infrared receiver
>  - SDIO WiFi Module
> 
> Like it's SEI510 counterpart, the boot flow is designed to boot
> Android AOSP built for the Yukawa Android device.
> 
> The SM1 SoC is very close to G12A, so it uses the same arm board code
> and reuses what was pushed for SEI510.
> 
> For that it needs to reuse the SEI510 android boot flow into
> a common flow with custom partitions for each board.
> 
> Guillaume La Roque (2):
>   configs: sei510: rework header and fix userdata size
>   configs: sei610: Add config file to fix userdata size
> 
> Neil Armstrong (6):
>   ARM: meson: add SM1 SoC id
>   mmc: meson-gx: add support for mmc-pwrseq-emmc
>   clk: meson-sm1: add compatible
>   ARM: dts: Import SEI610 DT from Linux 5.4-rc2
>   ARM: dts: meson-sm1: add U-Boot specific DT for graphics
>   boards: amlogic: add SEI610 support
> 
>  MAINTAINERS                                   |   1 +
>  arch/arm/dts/Makefile                         |   3 +-
>  ...boot.dtsi => meson-g12-common-u-boot.dtsi} |   0
>  arch/arm/dts/meson-g12a-sei510-u-boot.dtsi    |   2 +-
>  arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |   2 +-
>  arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |   2 +-
>  arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |   7 +
>  arch/arm/dts/meson-sm1-sei610.dts             | 383 ++++++++++++++++++
>  arch/arm/dts/meson-sm1.dtsi                   | 147 +++++++
>  arch/arm/mach-meson/board-info.c              |   2 +
>  board/amlogic/sei610/MAINTAINERS              |   7 +
>  board/amlogic/sei610/Makefile                 |   6 +
>  board/amlogic/sei610/README                   | 119 ++++++
>  board/amlogic/sei610/sei610.c                 |  26 ++
>  configs/sei610_defconfig                      |  76 ++++
>  drivers/clk/meson/g12a.c                      |   1 +
>  drivers/mmc/meson_gx_mmc.c                    |  51 +++
>  include/configs/meson64_android.h             | 136 +++++++
>  include/configs/sei510.h                      | 121 +-----
>  include/configs/sei610.h                      |  31 ++
>  include/dt-bindings/power/meson-sm1-power.h   |  18 +
>  21 files changed, 1018 insertions(+), 123 deletions(-)
>  rename arch/arm/dts/{meson-g12a-u-boot.dtsi => meson-g12-common-u-boot.dtsi} (100%)
>  create mode 100644 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-sm1-sei610.dts
>  create mode 100644 arch/arm/dts/meson-sm1.dtsi
>  create mode 100644 board/amlogic/sei610/MAINTAINERS
>  create mode 100644 board/amlogic/sei610/Makefile
>  create mode 100644 board/amlogic/sei610/README
>  create mode 100644 board/amlogic/sei610/sei610.c
>  create mode 100644 configs/sei610_defconfig
>  create mode 100644 include/configs/meson64_android.h
>  create mode 100644 include/configs/sei610.h
>  create mode 100644 include/dt-bindings/power/meson-sm1-power.h
> 

Applied to u-boot-amlogic + typo fixes
