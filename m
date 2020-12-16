Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.11280.1608137614675139627
 for <u-boot-amlogic@groups.io>;
 Wed, 16 Dec 2020 08:53:35 -0800
Received: by mail-wm1-f46.google.com with SMTP id k10so3024297wmi.3
        for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pV/ZEyiwDEwaGLLfErLNtSJ2y63hjWtXClfS8vZSNIk=;
        b=E4hoWpAMNWoUm0urzeGVq6qY+R2/CRxof7kKoxS38hf+YYr9R9cHIkfgAwwCB1NE0y
         LaeuSyJz9E1rsfBeqQICsBsduR8v5V42/fAjUL25NzOt09OXMuiHYyGIax24I/JqdlJz
         H1vN06tAL4Aaz5PhzlzmKp2qHm5FhlynzNQxF++2oyb+CVoPGRx3M/ALdWH0pgElDec0
         gmkLGCr/xtdrsaGLqWN4fFnuUGpSBUbE7lfVGGD3x3wqUZnqw8ZVraGW14LvB6239JeT
         Hc1njTjslpPSpk5hefGbGHw8oGOuz2Sb9FkGDxS7hYnvaUvjuQ2B0m/2NJsYijlcaIzy
         bp2g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/6] VIM3: add support for checking 'Function' button state
References: <CGME20201216075203eucas1p2607f08a1d296c130a18177bb012642fd@eucas1p2.samsung.com>
 <20201216075158.16458-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <759d8e5b-83a3-1039-dfca-266b93619309@baylibre.com>
Date: Wed, 16 Dec 2020 17:53:31 +0100
MIME-Version: 1.0
In-Reply-To: <20201216075158.16458-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 16/12/2020 08:51, Marek Szyprowski wrote:
> Hi All,
> 
> This patchset adds all building blocks needed for checking the 'Function'
> button state in the boot script on Amlogic A311D based VIM3 board. This
> button is connected to the ADC lines of the SoC, so it required to enable
> meson SARADC, the clocks needed for it and a simple button-adc drivers.
> 
> Once applied, one can use following commands in the boot scripts:
> -->8---
> echo Checking Func button state: \\c
> if button Function
> then
> 	echo Selected alternative boot
> 	...
> fi
> --->8---
> The above script requires commit a6bfd71a96 ("cmd/button: return button
> status") already present in mainline tree.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> v3:
> - removed 'button' env variable
> - extended kconfig and patch descriptions
> 
> v2: https://lists.denx.de/pipermail/u-boot/2020-December/434991.html
> - removed Change-Id tags
> - split defconfig changes into ADC and button related
> 
> v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
> - initial submission
> 
> 
> Patch summary:
> 
> Marek Szyprowski (6):
>   clk: meson: add minimal driver for g12a-ao clocks
>   adc: meson-saradc: add G12A variant
>   adc: meson-saradc: skip hardware init only if ADC is enabled
>   configs: khadas-vim3: enable ADC device support
>   button: add a simple ADC-based button driver
>   configs: khadas-vim3: enable Function button support
> 
>  configs/khadas-vim3_defconfig |   4 ++
>  drivers/adc/meson-saradc.c    |   9 ++-
>  drivers/button/Kconfig        |   8 +++
>  drivers/button/Makefile       |   1 +
>  drivers/button/button-adc.c   | 117 ++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/Makefile    |   1 +
>  drivers/clk/meson/g12a-ao.c   |  83 ++++++++++++++++++++++++
>  7 files changed, 221 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/button/button-adc.c
>  create mode 100644 drivers/clk/meson/g12a-ao.c
> 

Applied patches 1 to 4 to u-boot-amlogic-next

Also updated khadas-vim3l_defconfig in the same time in patch 4.

Thx

Neil
