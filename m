Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.5067.1613644527866621022
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Feb 2021 02:35:28 -0800
Received: by mail-wr1-f43.google.com with SMTP id n8so2332075wrm.10
        for <u-boot-amlogic@groups.io>; Thu, 18 Feb 2021 02:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbstET6/gwFLVUyGsoASE3vCWDAPcULGeA3SPLUbsSU=;
        b=gk7fEQ7x0G2a2B8xqidsH71+MnjR8c9QtqnB+nYBObeaGqMYaN/Ek0CfuXsjAueWML
         Vx3jwYACagKVH7/kuhz4amWlMVuSiyvo/NIAg8tVDLsbFr3nExbkVsRHa65Nh8+/Axoh
         3juvpw/aloi2zwl95XpINOBMSvyMeLnwsAbt3n5bDerpAfokeGJpHJ+A6ftfcc1N8vSb
         S9AgBAkGqI2Hgl2oT+laMZAa8vC20dw7gF59JvKi0kEJ1ce03QoqsGys8E/jqLi5k3AS
         PGWCB7P/39LFxzfSmVn6XZndyZSAUWcW57AGsfYp10SDe7UC0Jyh9plTggNMhrEoljDF
         XAZA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v7 0/5] VIM3: add support for checking 'Function' button state
References: <CGME20210218103327eucas1p21cbeb2ae82a75cb350e1b1a683e30a73@eucas1p2.samsung.com>
 <20210218103318.18915-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b7ca684d-f2aa-0f76-ec42-0c5182a7194c@baylibre.com>
Date: Thu, 18 Feb 2021 11:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <20210218103318.18915-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 18/02/2021 11:33, Marek Szyprowski wrote:
> Hi All,
> 
> This patchset adds all building blocks needed for checking the 'Function'
> button state in the boot script on Amlogic A311D based VIM3 board. This
> button is connected to the ADC line of the SoC, so it required to enable
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
> v7:
> - added linux,code properties to the test.dts
> 
> v6: https://lists.denx.de/pipermail/u-boot/2021-February/441039.html
> - added a simple sandbox test for adc-keys
> - use of_to_plat and adc_raw_to_uV to simplify code in the adc button driver
> 
> v5: https://lists.denx.de/pipermail/u-boot/2021-January/438751.html
> - rebased onto latest uboot-amlogic/u-boot-amlogic-next branch
> - synchronized adc-keys binding with the recent version from the Linux
>   kernel
> - updated adc-keys driver to match behavior from dt-bindings
> - added a patch for meson-saradc driver to register vdd reference supply
>   to the ADC framework
> 
> v4: https://lists.denx.de/pipermail/u-boot/2020-December/435641.html
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
> 
> 
> Patch summary:
> 
> Marek Szyprowski (5):
>   dt-bindings: input: adc-keys bindings documentation
>   button: add a simple Analog to Digital Converter device based button
>     driver
>   adc: meson-saradc: add support for getting reference voltage value
>   configs: khadas-vim3(l): enable Function button support
>   test: add a simple test for the adc-keys button driver
> 
>  arch/sandbox/dts/test.dts                   |  27 +++-
>  configs/khadas-vim3_defconfig               |   2 +
>  configs/khadas-vim3l_defconfig              |   2 +
>  configs/sandbox_defconfig                   |   1 +
>  doc/device-tree-bindings/input/adc-keys.txt |  67 +++++++++
>  drivers/adc/meson-saradc.c                  |  21 +++
>  drivers/button/Kconfig                      |   8 ++
>  drivers/button/Makefile                     |   1 +
>  drivers/button/button-adc.c                 | 146 ++++++++++++++++++++
>  test/dm/button.c                            |  50 ++++++-
>  10 files changed, 322 insertions(+), 3 deletions(-)
>  create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>  create mode 100644 drivers/button/button-adc.c
> 

Applying to u-boot-amlogic !

Thanks,
Neil
