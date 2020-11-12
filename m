Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.4157.1605188115911334315
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Nov 2020 05:35:16 -0800
Received: by mail-wm1-f66.google.com with SMTP id a3so5515609wmb.5
        for <u-boot-amlogic@groups.io>; Thu, 12 Nov 2020 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lRZDWZo/tDEQhGPzPnRAtyQxcJVbxx3lf3wOFs14iYw=;
        b=tolcEOSQfCbPb5XI43WC/5Z3B8yuXm/btkLi9B5ylYK2saFmhwKUNHpc7dSIJ8/qKz
         tAON2qwW3xsI8Yq3kLUyuA+d+x3XQ9Hf/lKxBf0iD1tfAfxIz4Cp2qz9mp0pTprRuPcT
         5RenG/upJzUXmOQJEqb7FVo1wPq6/PWD7Hm5V3kyyqGpacr6hOA63qcNPIgY7Vnv4Vbw
         r+kPzFx/yjP1wq91czI+TBhdBeAwlOvUSoisYtx6YdCoshlO3tUCB86e5TcDzmk9Eiac
         oD+miJ8PvqWP5FGcTSyrpv9reetMtqlLbTO6AlKrYAwsROR2CeBypoXLzWYgTT9FmhJ4
         gJLQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] ARM: upgrade Amlogic DT to Linux 5.10
References: <20201106101901.2472557-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2402082c-f0e7-96c8-05e6-2db3b6883843@baylibre.com>
Date: Thu, 12 Nov 2020 14:35:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201106101901.2472557-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 11:18, Neil Armstrong wrote:
> This syncs the Amlogic DT to 5.10, and :
> - adds support for the new common MESON_EE_POWER_DOMAIN synced on 5.10
> - adds Odroid-N2+ DT using the Odroid-N2 DT as base
> 
> Neil Armstrong (4):
>   ARM: dts: sync Amlogic GX & AXG from Linux 5.10-rc1
>   power: domain: meson-ee-pwrc: add support for the Meson GX SoCs
>   power: domain: meson-ee-pwrc: add support for the Meson AXG SoCs
>   configs: use the new MESON_EE_POWER_DOMAIN driver for Amlogic
>     GXBB/GXL/GXM boards
> 
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/meson-axg.dtsi                   |   6 +-
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi      |  88 ---
>  arch/arm/dts/meson-g12b-odroid-n2-plus.dts    |  31 +
>  arch/arm/dts/meson-g12b-odroid-n2.dts         | 618 +----------------
>  arch/arm/dts/meson-g12b-odroid-n2.dtsi        | 625 ++++++++++++++++++
>  arch/arm/dts/meson-gx-mali450.dtsi            |  61 ++
>  arch/arm/dts/meson-gx.dtsi                    |  18 +-
>  arch/arm/dts/meson-gxbb.dtsi                  |  63 +-
>  arch/arm/dts/meson-gxl-mali.dtsi              |  46 +-
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |   2 +-
>  arch/arm/dts/meson-gxl-s805x.dtsi             |  23 +
>  arch/arm/dts/meson-gxl.dtsi                   |  17 +-
>  arch/arm/dts/meson-gxm.dtsi                   |  45 +-
>  arch/arm/dts/meson-khadas-vim3.dtsi           |  94 ++-
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  86 ---
>  configs/libretech-ac_defconfig                |   2 +-
>  configs/libretech-cc_defconfig                |   2 +-
>  configs/libretech-s905d-pc_defconfig          |   2 +-
>  configs/libretech-s912-pc_defconfig           |   2 +-
>  configs/odroid-c2_defconfig                   |   2 +-
>  drivers/power/domain/meson-ee-pwrc.c          |  52 +-
>  include/dt-bindings/power/meson-axg-power.h   |  14 +
>  include/dt-bindings/power/meson-gxbb-power.h  |  13 +
>  24 files changed, 1002 insertions(+), 911 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-plus.dts
>  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dtsi
>  create mode 100644 arch/arm/dts/meson-gx-mali450.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s805x.dtsi
>  create mode 100644 include/dt-bindings/power/meson-axg-power.h
>  create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
> 


Applied to u-boot-amlogic-next

