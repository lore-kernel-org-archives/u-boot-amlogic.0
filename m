Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.6638.1587116617170972311
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Apr 2020 02:43:38 -0700
Received: by mail-wm1-f68.google.com with SMTP id c195so4510945wme.1
        for <u-boot-amlogic@groups.io>; Fri, 17 Apr 2020 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khXmgzYr1h+ngw42v76iwOZW6OhAFK8/3YpzFi8shk4=;
        b=z/Zfvu+M4MT43S3hoBOsJgft/IAm6oOk4DYwYdihR4UI8HoKcYYAzpfHWwGd5P6p6E
         Pu6LrFo4vrI7/YcEDlqnKJn0Ub4YrO0amF7LLdf46H0tnmpa81pwMP22m/on7Cb7ByLZ
         xPIKomX/X+HxfnyqtuekWPbx2Tx62gaEIIrqMZ+VK9+3oL9JQVDvWstVdQm5GG7T71ck
         +H8YVUL6N8n08McMgzjahQCBC5sW7+DRexwcluD4DyjaNrF5kXOAOVOVgcwLKFR/i7z7
         zhlI2B/uil5NPun8GAKGiUwDKJ2dBlocGrkZBRy9XoLm4ApiXUqMtI/EXRi+nIVB49XI
         pGCw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 00/10] meson: enable USB Gadget support fot GXL/GXM SoCs
References: <20200330092732.7198-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5eb8d29c-2133-11c5-e0c4-63189332afb4@baylibre.com>
Date: Fri, 17 Apr 2020 11:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 30/03/2020 11:27, Neil Armstrong wrote:
> Thit patchset adds support for OTG Gadget mode on the GXL/GXM SoCs.
> 
> It adds a new API generic_phy_get_by_node() to get the PHY by it's node.
> 
> It enabled Gadget and USB Mass Storage for libretech-cc, libretech-ac,
> khadas-vim, khadas-vim2, libretech-s905d-pc and libretech-s912-pc boards.
> 
> Neil Armstrong (10):
>   generic-phy: add generic_phy_get_by_node()
>   phy: meson-gxl-usb: add set_mode call to force switch to peripheral
>     mode
>   arm: meson-gx: add board_usb_init()/cleanup() for USB gadget
>   arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot
>   configs: libretech-cc: Enable USB gadget with Mass Storage function
>   configs: libretech-ac: Enable USB gadget with Mass Storage function
>   configs: khadas-vim2: Enable USB gadget with Mass Storage function
>   configs: khadas-vim: Enable USB gadget with Mass Storage function
>   configs: libretech-s905d-pc: Enable USB gadget with Mass Storage
>     function
>   configs: libretech-s912-pc: Enable USB gadget with Mass Storage
>     function
> 
>  .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    |   2 +-
>  .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  |   6 +-
>  arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi |   2 +-
>  arch/arm/dts/meson-gxl-u-boot.dtsi            |  23 ++++
>  arch/arm/include/asm/arch-meson/usb-gx.h      |  16 +++
>  arch/arm/mach-meson/board-gx.c                | 118 ++++++++++++++++++
>  configs/khadas-vim2_defconfig                 |   7 ++
>  configs/khadas-vim_defconfig                  |   7 ++
>  configs/libretech-ac_defconfig                |   7 ++
>  configs/libretech-cc_defconfig                |   7 ++
>  configs/libretech-s905d-pc_defconfig          |   7 ++
>  configs/libretech-s912-pc_defconfig           |   7 ++
>  drivers/phy/meson-gxl-usb2.c                  |  30 ++++-
>  drivers/phy/meson-gxl-usb3.c                  |  44 +++++--
>  drivers/phy/phy-uclass.c                      |  17 ++-
>  include/generic-phy.h                         |  27 ++++
>  16 files changed, 301 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gxl-u-boot.dtsi
>  create mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h
> 

Applied to u-boot-amlogic with tom's review tag on patch 1
