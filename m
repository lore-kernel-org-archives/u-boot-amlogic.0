Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web08.31839.1610965455729958316
 for <u-boot-amlogic@groups.io>;
 Mon, 18 Jan 2021 02:24:16 -0800
Received: by mail-wm1-f42.google.com with SMTP id o10so5597113wmc.1
        for <u-boot-amlogic@groups.io>; Mon, 18 Jan 2021 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jm0qKBwVRJ5xBWTgxVDHTUCCzpLVvtCmm2/65Vv2+Hg=;
        b=Wm+0rnbiY4/yoR/GWHB9b4FSoJeMKJQO4A1/MDVNdZzGZWD6PaVotqy0msLqiy9at9
         K+ncoD+mmQh86IcgHkCD6A4mY39BqGlaA4NkGBggDv8RJLdGFyAkmHqmLmu7I9MgNXze
         TRaIEHT5hCA2P529sxHg7D+V25FSVcQzsbG+jhwRDE+BX1ifmGXNW93HGq/ZINd5yBSI
         WFfkkc8P8MGagXcWKfrduzXr3ex7m0mqeQaDkzZ6Tz76HQf70R94oXRICfvwUqDDLqJX
         0p6lIo4MhvnePdJCf1C6Fx6l48or5Nc3thwOteN+zz4STizjwajg2lPFW9mlZKbvrxEF
         chMQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 0/3] VIM3: add support for checking 'Function' button state
References: <CGME20201222085638eucas1p158d91ce4a22d13623b19706b26374078@eucas1p1.samsung.com>
 <20201222085633.10194-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <47e599d6-288c-163c-e40a-9c5d5b534bf9@baylibre.com>
Date: Mon, 18 Jan 2021 11:24:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201222085633.10194-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 22/12/2020 09:56, Marek Szyprowski wrote:
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
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> v4:
> - rebased onto uboot-amlogic/u-boot-amlogic-next and dropped merged patches
> - added adc-keys bindings docs (copied from Linux kernel)
> - minor code adjustments pointed by Simon
> - enabled driver also in khadas-vim3l_defconfig
> 
> v3: https://lists.denx.de/pipermail/u-boot/2020-December/435072.html
> - removed 'button' env variable
> - extended kconfig and patch descriptions
> 
> v2: https://lists.denx.de/pipermail/u-boot/2020-December/434991.html
> - removed Change-Id tags
> - split defconfig changes into ADC and button related
> 
> v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
> - initial submission

What's the state of the patchset ?

Neil

> 
> 
> Patch summary:
> 
> Marek Szyprowski (3):
>   dt-bindings: input: adc-keys bindings documentation
>   button: add a simple Analog to Digital Converter device based button
>     driver
>   configs: khadas-vim3(l): enable Function button support
> 
>  configs/khadas-vim3_defconfig               |   2 +
>  configs/khadas-vim3l_defconfig              |   2 +
>  doc/device-tree-bindings/input/adc-keys.txt |  49 ++++++++
>  drivers/button/Kconfig                      |   8 ++
>  drivers/button/Makefile                     |   1 +
>  drivers/button/button-adc.c                 | 121 ++++++++++++++++++++
>  6 files changed, 183 insertions(+)
>  create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>  create mode 100644 drivers/button/button-adc.c
> 

