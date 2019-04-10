Received: by mail-wm1-f67.google.com with SMTP id z24so2953690wmi.5
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FpI5Ng+i0isViOGxIbo/fFtga0kzqRzT7gTmxgik9fc=;
        b=tZ0GjScjPV8T0NMqW2hNkRj8QtU9w+xwzzbFW1xvsnC0BPG9OJI6/BM08wxhHsza6y
         ekhISyFEypRqOjYw9W8c0Gl13dQI6MIXbcSrTQZARWrMth8lH+bOn0bNFOwnxSoaN7Rg
         a2ri0i8CXv87N48vXGjZpOsME9ObGbAxhLnafb2TZnjZD4UQRlM688T8NKWxXlhUwjYb
         npawzjN0PEWpLHXWAjCDflARD41oL620Zmao3211qCS3uM4I5GktksME1CfljNfj8Pn/
         hyZMlEvj3YA1XYYhFfo5dGQ0kSX99C8W0Zrmu07bhlq02lTLxz+Ag8f1DGJ2jLbd0ZiV
         z5ow==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] ARM: meson: Add support for Libretech-AC
References: <20190326102035.9239-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bb9cccfe-5c7d-41c3-6593-936b9da17ced@baylibre.com>
Date: Wed, 10 Apr 2019 16:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190326102035.9239-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/03/2019 11:20, Neil Armstrong wrote:
> LibreTech AC is a single board computer manufactured by Libre Technology
> with the following specifications:
> 
>  - Amlogic S805X ARM Cortex-A53 quad-core SoC @ 1.2GHz
>  - ARM Mali 450 GPU
>  - 512MiB DDR4 SDRAM
>  - 10/100 Ethernet
>  - HDMI 2.0 4K/60Hz display
>  - 40-pin GPIO header
>  - 4 x USB 2.0 Host
>  - eMMC, SPI NOR Flash
>  - Infrared receiver
> 
> The u-boot specific code is the same as the P212 support,
> so use the P212 board support code with a distinct defconfig
> and config include files.
> 
> The patchset inports the DT from Linux 5.0 and add the corresponding
> configs and update the MAINTAINERS files.
> 
> Neil Armstrong (2):
>   ARM: dts: Import libretech-ac DT from Linux 5.0
>   boards: Amlogic: Add support for Libretech-AC
> 
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 248 ++++++++++++++++++
>  arch/arm/dts/meson-gxl.dtsi                   |  70 ++++-
>  board/amlogic/p212/MAINTAINERS                |   1 +
>  board/amlogic/p212/README.libretech-ac        | 103 ++++++++
>  configs/libretech-ac_defconfig                |  74 ++++++
>  include/configs/libretech-ac.h                |  24 ++
>  7 files changed, 512 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
>  create mode 100644 board/amlogic/p212/README.libretech-ac
>  create mode 100644 configs/libretech-ac_defconfig
>  create mode 100644 include/configs/libretech-ac.h
> 

Applied both to u-boot-amlogic

Neil
