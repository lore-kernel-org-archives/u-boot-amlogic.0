Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.158.1570798623972084357
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 05:57:04 -0700
Received: by mail-wm1-f65.google.com with SMTP id 5so10342971wmg.0
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6kreXuqDGq8z8tP28r9zz97IliqlND2TS8YC2jHJIwI=;
        b=Kck5imsMmT7JihHj2mj1MFSiSudg3HwYjS/q9AzIikCGwADcK7BLhZfMeygIY1O0iU
         afKECu2ARwEKxd4wIBf9yPgnpgF+dEGiHDyhoKIno89EEIZNynHmaBcZBpdsz5/aInYJ
         sX1RmzqyOyVi9xbTTObmTuymv8fZw+qBBWbicpr5IODDW2CdL4yLlrk6vsB/5oyEwJ72
         xcqafsC7aovB7EI5Z4yW89tiC95/NzPTBVJ0AdK9/AGOJMXJb34B77H+ZOtlrREpsBWK
         TSJLs2JMlqaAYIX1CBEPUnkKyBTIyuJ/CL2kv4272mW52cXsN+Oy9/Ucvk8tLV7BhNbZ
         u+FA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/8] arm: meson: add Video support for G12A and SEI510 board
References: <20190830120928.23890-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5cd9cf2e-1bff-2e96-4a88-62c1880b7636@baylibre.com>
Date: Fri, 11 Oct 2019 14:57:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, agust@denx.de, jh80.chung@samsung.com, lukma@denx.de
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 30/08/2019 14:09, Neil Armstrong wrote:
> This patchset adds Amlogic G12A support for HDMI & Composite video output like
> the Amlogic GXBB/GXL/GXM, by syncing from the latest Linux VPU DRM driver.
> 
> It also adds VPU/VAPB/HDMI Clock & VPU Power Domain support.
> 
> Finally it adds the necessary config to show a logo from a fastboot flashed
> partition on the SEI510 board.
> 
> U200 and Odroid-N2 config support will be added later.
> 
> Neil Armstrong (8):
>   power: domain: meson-gx-pwrc: add G12A support
>   clk: meson: g12a: add support for VPU/HDMI clocks
>   video: meson: remove power domain get
>   video: meson: sync with linux drm-misc tree
>   video: meson: add compatible for Amlogic G12A
>   arm: meson: board-g12a: Setup VPU in fdt
>   ARM: dts: meson-g12a: add U-Boot specific DT for graphics
>   configs: sei510: enable Video Display support
> 
>  arch/arm/dts/meson-g12a-sei510-u-boot.dtsi    |   7 +
>  arch/arm/dts/meson-g12a-u-boot.dtsi           |  29 +
>  arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |   7 +
>  arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |   7 +
>  arch/arm/mach-meson/board-g12a.c              |   5 +
>  configs/sei510_defconfig                      |  11 +
>  drivers/clk/meson/g12a.c                      | 620 +++++++++++++++++-
>  drivers/power/domain/meson-gx-pwrc-vpu.c      | 155 ++++-
>  drivers/video/meson/meson_dw_hdmi.c           |  61 +-
>  drivers/video/meson/meson_plane.c             |  47 +-
>  drivers/video/meson/meson_registers.h         | 373 ++++++++++-
>  drivers/video/meson/meson_vclk.c              | 233 +++++--
>  drivers/video/meson/meson_venc.c              | 169 ++++-
>  drivers/video/meson/meson_vpu.c               |  11 +-
>  drivers/video/meson/meson_vpu.h               |   2 +
>  drivers/video/meson/meson_vpu_init.c          | 205 ++++--
>  include/configs/sei510.h                      |  12 +
>  17 files changed, 1757 insertions(+), 197 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
> 

Applied to u-boot-amlogic !
