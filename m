Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.33853.1615196628706030182
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:43:49 -0800
Received: by mail-wr1-f46.google.com with SMTP id 7so10729665wrz.0
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydzx+HlMTP2VowxE4Rk5kCzprXBVckpcqv7qY1weRMk=;
        b=HyaIkzVr05wbhxGeTsbRyv+//Bf0DIh4CmBgrP6IQC3WNoDrpGZmT75zgRi9XNoI6L
         B6eCK86BUwRNnUF7Jy1X3tBHxFUJSyI4oKSQgk86LCjdB5/phoIJuylmTej01mMvnsBe
         i2pZoH1tFWQOPPdhsmkIcJH7/uhc9tqx03D2IwI6ANsDNjw9B5pcBz2N+wPcv/2QudXh
         WLjwfZl3nCWcUnUGX9Ddby6UGdEo9qfnUH+3KK8Ltuqo9bmhqG/9AGybe5OgmL8zgQkA
         QFo4pluHSLjTamFAIkOZJ6IQCGjJU/T+fkFCEoxVFQNBfjm4rmhg4lhGhtf1fgzre72n
         fyVg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [RFC/RFT 0/7] arm: meson: static ethernet init cleanup
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b656a51b-83c9-a0f1-bcab-eda1cc1f3091@baylibre.com>
Date: Mon, 8 Mar 2021 10:43:45 +0100
MIME-Version: 1.0
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com
List-ID: <u-boot-amlogic@groups.io>

On 25/02/2021 09:44, Neil Armstrong wrote:
> This serie finally removes the static ethernet link setup, MDIO mux & memory
> power domain after introduction of :
>  - "net: add MMIO Register MDIO MUX driver" at [1]
>  - "net: designware: add DM_MDIO support" at [2]
>  - "net: add Amlogic Meson G12A MDIO MUX driver" at [3]
>  - "net: designware: add Amlogic Meson8b & later glue driver" at [4]
> 
> These patches makes all this happen automagically thanks to DM_MDIO introduced
> last year.
> 
> This has been tested on libretech-ac and Khadas VIM3 to check to most opposite
> setups, but the GXBB boards hasn't been tested.
> 
> Note, you'll need [1], [2], [3], [4] applied before these patches
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20210224140223.2617536-1-narmstrong@baylibre.com/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20210224140239.2617642-1-narmstrong@baylibre.com/
> [3] https://patchwork.ozlabs.org/project/uboot/patch/20210224163153.2678768-1-narmstrong@baylibre.com/
> [4] https://patchwork.ozlabs.org/project/uboot/patch/20210224193356.2948805-1-narmstrong@baylibre.com/
> 
> Neil Armstrong (7):
>   configs: update Amlogic Meson GXL & GXM config for MDIO MUX
>   configs: update Amlogic Meson G12A, G12B & SM1 configs for MDIO MUX
>   arm: meson: remove static MDIO mux handling
>   configs: meson: use Designware glue driver for Amlogic Meson8b & later
>     SoCs
>   net: designware: remove amlogic compatibles
>   arm: meson: remove static ethernet memory power domain enable
>   arm: meson: remove static ethernet link setup
> 
>  arch/arm/include/asm/arch-meson/axg.h       | 22 -------
>  arch/arm/include/asm/arch-meson/eth.h       | 12 ----
>  arch/arm/include/asm/arch-meson/g12a.h      | 35 -----------
>  arch/arm/include/asm/arch-meson/gx.h        | 20 ------
>  arch/arm/mach-meson/board-axg.c             | 34 -----------
>  arch/arm/mach-meson/board-g12a.c            | 67 ---------------------
>  arch/arm/mach-meson/board-gx.c              | 48 ---------------
>  board/amlogic/beelink-s922x/beelink-s922x.c |  2 -
>  board/amlogic/odroid-n2/odroid-n2.c         |  2 -
>  board/amlogic/p200/p200.c                   |  2 -
>  board/amlogic/p201/p201.c                   |  2 -
>  board/amlogic/p212/p212.c                   |  3 -
>  board/amlogic/q200/q200.c                   |  2 -
>  board/amlogic/s400/s400.c                   |  2 -
>  board/amlogic/sei510/sei510.c               |  3 -
>  board/amlogic/sei610/sei610.c               |  3 -
>  board/amlogic/u200/u200.c                   |  3 +-
>  board/amlogic/vim3/vim3.c                   |  2 -
>  board/amlogic/w400/w400.c                   |  2 +-
>  configs/beelink-gtking_defconfig            |  5 +-
>  configs/beelink-gtkingpro_defconfig         |  5 +-
>  configs/khadas-vim2_defconfig               |  5 +-
>  configs/khadas-vim3_defconfig               |  5 +-
>  configs/khadas-vim3l_defconfig              |  5 +-
>  configs/khadas-vim_defconfig                |  7 ++-
>  configs/libretech-ac_defconfig              |  7 ++-
>  configs/libretech-cc_defconfig              |  7 ++-
>  configs/libretech-cc_v2_defconfig           |  7 ++-
>  configs/libretech-s905d-pc_defconfig        |  5 +-
>  configs/libretech-s912-pc_defconfig         |  5 +-
>  configs/nanopi-k2_defconfig                 |  2 +-
>  configs/odroid-c2_defconfig                 |  2 +-
>  configs/odroid-c4_defconfig                 |  5 +-
>  configs/odroid-n2_defconfig                 |  5 +-
>  configs/p200_defconfig                      |  2 +-
>  configs/p201_defconfig                      |  2 +-
>  configs/p212_defconfig                      |  7 ++-
>  configs/s400_defconfig                      |  2 +-
>  configs/sei510_defconfig                    |  7 ++-
>  configs/sei610_defconfig                    |  7 ++-
>  configs/u200_defconfig                      |  7 ++-
>  configs/wetek-core2_defconfig               |  5 +-
>  drivers/net/designware.c                    |  3 -
>  43 files changed, 79 insertions(+), 306 deletions(-)
> 

Applied to u-boot-amlogic-next
