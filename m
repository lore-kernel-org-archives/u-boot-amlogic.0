Received: by mail-wr1-f65.google.com with SMTP id b1so7920697wru.3
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g5L0RCJsqA47JgSw3VHnNaVhWpGMfDz5siAiy9V8VJk=;
        b=ISMZoxOgNt2hDuRYg1shTLSuxIc2zQxpWGx9RiSKc+LwzaJCl7xp19dh1XTIQpmcFO
         HQxKdRUqeqNh5Olbh2PsuT/CY50HAYqQjHj5qlXz1piYma3O3gfb6xrtw9NR+gMQffVR
         MrOk7bf+1a35le8xb9LuZf+JS9rUSrenAPQ5ANrVpad6+qSk2HkNd2BQ15AIuKYtSnuI
         kdXg0P7TSWQgnjckjK0qJJ4tfvneCLq20boUIaBhF4p1R5tkYU81yRRFd7UaRTV2yTQb
         rCLndYWDee+8BGIvgq+PzZQruQYIiyjF4VhnKa8QPCBWmC7eJk/Gqe7j40x02EDZ1C+t
         K78Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/6] ARM: meson: Add support for G12A based U200 board
References: <20190410152348.13777-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <11305140-ad85-6eb4-b7f5-d6be9991cb28@baylibre.com>
Date: Tue, 23 Apr 2019 11:29:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190410152348.13777-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/04/2019 17:23, Neil Armstrong wrote:
> This patchset adds basic support for the recent Amlogic G12A SoC family.
> 
> This SoC family embeds 4xCortex A53 CPUs, and is very similar to
> the AXG SoC Family with the multimedia features of previous families.
> 
> This patchset adds :
> - pinctrl support
> - clk driver atfer a rework of the drivers files
> - import Linux 5.1-rc1 G12A & U200 DT files
> - add board/amlogic/u200 to support the U200 reference design
> 
> Changes since v1:
> - add fixup for pinctrl like for AXG
> 
> Jerome Brunet (5):
>   pinctrl: meson: add g12a support
>   clk: create meson directory and move related drivers
>   clk: meson: add g12a support
>   ARM: meson: add G12a support
>   boards: meson: add g12a u200
> 
> Neil Armstrong (1):
>   ARM: dts: Import Amlogic G12A u200 DT from Linux 5.1-rc1
> 
>  MAINTAINERS                                   |    2 +-
>  arch/arm/dts/Makefile                         |    3 +-
>  arch/arm/dts/meson-g12a-u200.dts              |   29 +
>  arch/arm/dts/meson-g12a.dtsi                  |  192 +++
>  arch/arm/include/asm/arch-meson/clock-g12a.h  |  104 ++
>  arch/arm/include/asm/arch-meson/g12a.h        |   66 +
>  arch/arm/mach-meson/Kconfig                   |    9 +-
>  arch/arm/mach-meson/Makefile                  |    1 +
>  arch/arm/mach-meson/board-g12a.c              |  150 ++
>  board/amlogic/u200/MAINTAINERS                |    5 +
>  board/amlogic/u200/Makefile                   |    6 +
>  board/amlogic/u200/README                     |  128 ++
>  board/amlogic/u200/u200.c                     |   22 +
>  configs/u200_defconfig                        |   40 +
>  drivers/clk/Kconfig                           |    1 +
>  drivers/clk/Makefile                          |    2 +-
>  drivers/clk/meson/Kconfig                     |   23 +
>  drivers/clk/meson/Makefile                    |    9 +
>  drivers/clk/{clk_meson_axg.c => meson/axg.c}  |    0
>  drivers/clk/{ => meson}/clk_meson.h           |    0
>  drivers/clk/meson/g12a.c                      |  315 ++++
>  drivers/clk/{clk_meson.c => meson/gxbb.c}     |    0
>  drivers/pinctrl/meson/Kconfig                 |    4 +
>  drivers/pinctrl/meson/Makefile                |    1 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1294 +++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson.c         |   17 +-
>  drivers/pinctrl/meson/pinctrl-meson.h         |    1 +
>  include/dt-bindings/clock/g12a-aoclkc.h       |   34 +
>  include/dt-bindings/clock/g12a-clkc.h         |  135 ++
>  include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
>  .../reset/amlogic,meson-g12a-reset.h          |  134 ++
>  include/dt-bindings/reset/g12a-aoclkc.h       |   18 +
>  32 files changed, 2850 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12a-u200.dts
>  create mode 100644 arch/arm/dts/meson-g12a.dtsi
>  create mode 100644 arch/arm/include/asm/arch-meson/clock-g12a.h
>  create mode 100644 arch/arm/include/asm/arch-meson/g12a.h
>  create mode 100644 arch/arm/mach-meson/board-g12a.c
>  create mode 100644 board/amlogic/u200/MAINTAINERS
>  create mode 100644 board/amlogic/u200/Makefile
>  create mode 100644 board/amlogic/u200/README
>  create mode 100644 board/amlogic/u200/u200.c
>  create mode 100644 configs/u200_defconfig
>  create mode 100644 drivers/clk/meson/Kconfig
>  create mode 100644 drivers/clk/meson/Makefile
>  rename drivers/clk/{clk_meson_axg.c => meson/axg.c} (100%)
>  rename drivers/clk/{ => meson}/clk_meson.h (100%)
>  create mode 100644 drivers/clk/meson/g12a.c
>  rename drivers/clk/{clk_meson.c => meson/gxbb.c} (100%)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
> 


Applied to u-boot-amlogic
