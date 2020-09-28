Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.31592.1601278889661518538
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Sep 2020 00:41:30 -0700
Received: by mail-wr1-f68.google.com with SMTP id k10so61678wru.6
        for <u-boot-amlogic@groups.io>; Mon, 28 Sep 2020 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4tVQw4XAGUql+UByovTMzp5L885j1iW/mznpfKknBcs=;
        b=gZKJsy4hAyuwN+XLt+ugL3IBXE5qZfk6vBleNw3Wng+uPs3ZMggHyc9cSnu4Pm0rc0
         0fsYNEwzmqxbFwOlPk5NRxJIOmuMUJcDERuUl6lcN2JfrAoePrhqNmConW4cLoXEtEqg
         zLWLUKYvcU1iViIsFoj9rCsYWkWQHh1EA2+/Kr6xrP0pwp/X0c+4rEr7hFR3LULzQOxd
         K/DVzDu2GnHyxGRabHGlE0IRVkQz8Ak1q91R42vKO1eebSny5dW0R8XNEjFtQSg0u7EA
         CSCVzYjhl8ZOHmhm5e7x4WEm2PZrFrTV/jL8ekzbePMcTDsz8Q/h5x1W4o9sxRBVe1+e
         GjEA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/8] ARM: mach-meson: update & rework USB for GXL, GXM & AXG
References: <20200910084819.25312-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e51656c6-fe0a-b826-50bc-2477aa19e95f@baylibre.com>
Date: Mon, 28 Sep 2020 09:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 10/09/2020 10:48, Neil Armstrong wrote:
> This serie follows the recent work under Linux to rework and update support of
> the USB complex in the Amlogic GXL, GXM & AXG SoCs.
> 
> This rework follows the clean implementation for the G12A & following SoCs to support
> Host, Device & OTG functionnality.
> 
> The GXL, GXM & AXG USB complex is architectured in the same was as the G12A & later USB complex,
> thus we can use the same architecture but adapted to the different init & config flow found
> in the Amlogic GXL, GXM & AXG SoCs.
> 
> With this patchset, USB Host functionnality is retained, working & tested on the Khadas VIM2 (GXM),
> Libretech-CC (GXL) & S400 (AXG), with Device mode added and tested by using the UMS gadget.
> 
> Neil Armstrong (8):
>   ARM: dts: sync amlogic AXG/GXL/GXM DT from Linux 5.8-rc1
>   usb: dwc3: add Amlogic GXL & GXL DWC3 Glue
>   ARM: mach-meson: use new DWC3 glue for GXL & GXM
>   phy: meson-gxl: remove invalid USB3 PHY driver
>   phy: meson-gxl-usb: depend on Meson AXG aswell
>   arm: meson-axg: add board_usb_init()/cleanup() for USB gadget
>   ARM: dts: meson-axg: add USB nodes for S400
>   configs: s400: enable USB
> 
>  arch/arm/dts/meson-axg-s400-u-boot.dtsi       |  12 +
>  arch/arm/dts/meson-axg-u-boot.dtsi            |  62 +++
>  arch/arm/dts/meson-axg.dtsi                   |   6 +-
>  arch/arm/dts/meson-gx-libretech-pc.dtsi       |  78 +++-
>  arch/arm/dts/meson-gx.dtsi                    |  23 +-
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |   2 +-
>  arch/arm/dts/meson-gxbb-odroidc2.dts          |   2 +-
>  arch/arm/dts/meson-gxbb.dtsi                  |  23 +
>  .../meson-gxl-s805x-libretech-ac-u-boot.dtsi  |   4 -
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |  73 ++-
>  .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |   4 -
>  .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    |   4 -
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |   4 +
>  .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  |   4 -
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  77 +++-
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        |   3 +-
>  arch/arm/dts/meson-gxl-u-boot.dtsi            |  16 -
>  arch/arm/dts/meson-gxl.dtsi                   |  79 +++-
>  .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi |   4 -
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        |   3 +-
>  .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |   4 -
>  arch/arm/dts/meson-gxm.dtsi                   |   7 +-
>  arch/arm/include/asm/arch-meson/usb-gx.h      |   3 +-
>  arch/arm/mach-meson/board-axg.c               | 128 ++++++
>  arch/arm/mach-meson/board-gx.c                | 127 +++---
>  configs/khadas-vim2_defconfig                 |   2 +-
>  configs/khadas-vim_defconfig                  |   2 +-
>  configs/libretech-ac_defconfig                |   2 +-
>  configs/libretech-cc_defconfig                |   2 +-
>  configs/libretech-s905d-pc_defconfig          |   2 +-
>  configs/libretech-s912-pc_defconfig           |   2 +-
>  configs/p212_defconfig                        |   2 +-
>  configs/s400_defconfig                        |  15 +
>  drivers/phy/Kconfig                           |   2 +-
>  drivers/phy/Makefile                          |   2 +-
>  drivers/phy/meson-gxl-usb3.c                  | 219 ---------
>  drivers/usb/dwc3/Kconfig                      |   8 +
>  drivers/usb/dwc3/Makefile                     |   1 +
>  drivers/usb/dwc3/dwc3-meson-gxl.c             | 425 ++++++++++++++++++
>  .../reset/amlogic,meson-gxbb-reset.h          |   2 +-
>  include/dt-bindings/sound/meson-aiu.h         |  18 +
>  41 files changed, 1092 insertions(+), 366 deletions(-)
>  create mode 100644 arch/arm/dts/meson-axg-u-boot.dtsi
>  delete mode 100644 drivers/phy/meson-gxl-usb3.c
>  create mode 100644 drivers/usb/dwc3/dwc3-meson-gxl.c
>  create mode 100644 include/dt-bindings/sound/meson-aiu.h
> 

Applied to u-boot-amlogic-next

