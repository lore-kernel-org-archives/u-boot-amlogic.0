Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.11480.1585315778486034687
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Mar 2020 06:29:39 -0700
Received: by mail-wm1-f65.google.com with SMTP id c81so11397801wmd.4
        for <u-boot-amlogic@groups.io>; Fri, 27 Mar 2020 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9C+B42TPvMElHJDFhcdGiQBgNt59ngSwDUJs8pCV6U=;
        b=oKCgHw8IGpGe8Q8gN8JuAEEtnmPFr/m8+HV1MiOTRw8N8679MgpocFZ9uh7xLp6VOT
         RFHpd7+bqBsMm2lJ2FIlJu02uWO3k/qndiMCeu436BLAGa4QW5M/64tY1RHcNFbDUeYT
         BQRBFXIT6UzJfh9vPM7uGtwMrF4/zG/FhD7TwJt1Ov37Z15a/9hvDvQxrWziTcBL189w
         ZjQtVXobwvqQC0fp3PoAa5XFpaSCOxVTqLxd8ZvHtMNL1NhccFzM8EfckcdNnRCK732b
         AYCQ/CV5uX1sG5QX0JiE68nEBAF3P5wdNfAM3xosI2yHG1Vj06XDBCxVEyKcsZADc7+g
         oLtw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/6] arm64: meson: add libretech-pc support
References: <20200305111240.129010-1-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8e5b4f93-236b-7998-9bd6-e402d05cf7a4@baylibre.com>
Date: Fri, 27 Mar 2020 14:29:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200305111240.129010-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/03/2020 12:12, Jerome Brunet wrote:
> Add libretech PC platform support. This platform comes in 2 variants,
> one with the s905d and the other s912.
> 
> While working on these boards, I've found a problem related the mmc
> clock. In some cases, the ROM code will leave the mmc clocks in such
> a weird state that any access to the mmc controller would lock the
> device.
> 
> Making sure the MMC clocks are properly reset and enabled is enough
> to solve the problem.
> 
> I have also synced all amlogic supported dts. Since I had to update
> the gx dsti files, it made sense to update the dts as well. This is
> done to keep things coherent even if it is not the original purpose
> of this series.
> 
> Changes since v2:
>  - actually rebase on master
> 
> Changes since v1:
>  - Split dt sync, libretech-pc import and config addition.
>  - Rebase on master (... not really)
> 
> Jerome Brunet (6):
>   dt-bindings: leds: import common led bindings from linux v5.5
>   mmc: meson-gx: enable input clocks
>   clk: meson: reset mmc clock on probe
>   arm64: dts: meson: sync dt and bindings from v5.6-rc2
>   arm64: dts: meson: import libretech-pc from linux v5.6-rc2
>   arm64: dts: meson: add libretech-pc support
> 
>  arch/arm/dts/Makefile                         |   2 +
>  arch/arm/dts/meson-axg-s400.dts               |  70 ++-
>  arch/arm/dts/meson-axg.dtsi                   | 273 ++++++++--
>  arch/arm/dts/meson-g12-common.dtsi            | 478 ++++++------------
>  arch/arm/dts/meson-g12.dtsi                   | 398 +++++++++++++++
>  arch/arm/dts/meson-g12a-sei510.dts            |  64 +++
>  arch/arm/dts/meson-g12a-u200.dts              |  54 ++
>  arch/arm/dts/meson-g12a.dtsi                  |  33 +-
>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts |  25 +
>  arch/arm/dts/meson-g12b-odroid-n2.dts         |   2 +-
>  arch/arm/dts/meson-g12b.dtsi                  |  26 +-
>  arch/arm/dts/meson-gx-libretech-pc.dtsi       | 375 ++++++++++++++
>  arch/arm/dts/meson-gx.dtsi                    |  87 +++-
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  26 +-
>  arch/arm/dts/meson-gxbb-odroidc2.dts          | 100 +++-
>  arch/arm/dts/meson-gxbb-p200.dts              |   9 +-
>  arch/arm/dts/meson-gxbb-p201.dts              |   2 +-
>  arch/arm/dts/meson-gxbb-p20x.dtsi             |   9 +-
>  arch/arm/dts/meson-gxbb.dtsi                  | 118 ++++-
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |   2 +-
>  .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |   7 +
>  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts |  16 +
>  arch/arm/dts/meson-gxl-s905d.dtsi             |  12 +
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  20 +-
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  26 +-
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        |  10 +-
>  arch/arm/dts/meson-gxl.dtsi                   |  76 ++-
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        |  71 +--
>  .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |   7 +
>  arch/arm/dts/meson-gxm-s912-libretech-pc.dts  |  62 +++
>  arch/arm/dts/meson-gxm.dtsi                   |  39 +-
>  arch/arm/dts/meson-khadas-vim3.dtsi           |   7 +
>  arch/arm/dts/meson-sm1-sei610.dts             | 236 ++++++++-
>  arch/arm/dts/meson-sm1.dtsi                   | 356 +++++++++++++
>  configs/libretech-s905d-pc_defconfig          |  73 +++
>  configs/libretech-s912-pc_defconfig           |  73 +++
>  drivers/clk/meson/axg.c                       |   7 +
>  drivers/clk/meson/g12a.c                      |   7 +
>  drivers/clk/meson/gxbb.c                      |   7 +
>  drivers/mmc/meson_gx_mmc.c                    |  14 +-
>  include/dt-bindings/clock/axg-audio-clkc.h    |  10 +
>  include/dt-bindings/clock/gxbb-aoclkc.h       |   7 +
>  include/dt-bindings/clock/gxbb-clkc.h         |  21 +
>  include/dt-bindings/gpio/meson-gxbb-gpio.h    |   8 +-
>  include/dt-bindings/gpio/meson-gxl-gpio.h     |   8 +-
>  include/dt-bindings/leds/common.h             |  75 +++
>  .../reset/amlogic,meson-axg-audio-arb.h       |   2 +
>  .../reset/amlogic,meson-axg-reset.h           |   3 +-
>  .../reset/amlogic,meson-g12a-audio-reset.h    |  15 +
>  .../reset/amlogic,meson-gxbb-reset.h          |  51 +-
>  50 files changed, 2855 insertions(+), 624 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12.dtsi
>  create mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
>  create mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
>  create mode 100644 configs/libretech-s905d-pc_defconfig
>  create mode 100644 configs/libretech-s912-pc_defconfig
>  create mode 100644 include/dt-bindings/leds/common.h
> 

Applied to u-boot-amlogic for next release

I'll run tests on most board to check nothing was broken.

Neil
