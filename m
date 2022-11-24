Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.19783.1669282455665253466
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Nov 2022 01:34:16 -0800
Received: by mail-wm1-f53.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso806296wms.4
        for <u-boot-amlogic@groups.io>; Thu, 24 Nov 2022 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sF8lCJ4hU5Y6g+CGlg1vIjc+nwdIDlJ1X7vZ09QazKc=;
        b=jokdatV9rNTpvc6O4bMcMiCtwtz8LCDu4mIUc36lgfuKNFE4iZm4IumVsMh/bQ2ssg
         KMPIoaYqOsK70+6mvafe7F6Ks1MAhd9+A/gKxV4AJDdFYzCRlBm2kA4/a87Pbg4Ygmw9
         5EfuT6mB2z4gG1sAtt3ufmB8eouPofBzx5EF4gb+fS0qZBvTQrqdbvkio2KHKEyEl3Tx
         lFYu7jM4zrnWOIpv61fOBxJUQSH9ogivDAVejS4bK5RzW61YOB2/Pwvzpe8mI2Wf5YwQ
         77SeUBy8cg2O0qq2lfnxAnf/JzvE1bAQIrWDKWe/84ArKzD+HRr46tHqoV8HL/pSwb7O
         xosw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
Date: Thu, 24 Nov 2022 10:34:12 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
In-Reply-To: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Mattijs,

On 23/11/2022 16:42, Mattijs Korpershoek wrote:
> While working on some USB bugs on the VIM3L board, we stumbled upon the fact
> that mach-meson still uses legacy board_usb_*() functions instead of using DM [1]
> 
> This series aim to switch the g12a based boards to use CONFIG_DM_USB_GADGET and
> removes the board_usb_*() logic.
> 
> * The first patch adds mode switching in the dwc3-meson-g12a glue driver whenever
>    the dwc2 otg driver is probed()/removed().
> 
> * The second patch enables the config option and cleans up all board_usb_*().
> 
> This has been mainly tested with khadas-vim3l_android_defconfig using fastboot:
> 
> => fastboot usb 0
> 
> => # hit Ctrl-c
> 
> Other tests:
> * ums 0 mmc 2 # can list / mount partitions from host
> * usb start; usb storage # list usb thumb drive
> * all defconfigs have been build tested
> 
> [1] https://lore.kernel.org/u-boot/938b9439-9014-5ee8-1627-16af508bface@linaro.org/
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

I'll run some tests on other G12 boards but so far this looks very good, thanks !

Neil

> 
> ---
> Mattijs Korpershoek (2):
>        usb: dwc3-meson-g12a: force mode on child add/removal
>        ARM: meson: g12a: switch dwc2 otg to DM
> 
>   arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
>   configs/bananapi-m5_defconfig             |   1 +
>   configs/beelink-gsking-x_defconfig        |   1 +
>   configs/beelink-gtking_defconfig          |   1 +
>   configs/beelink-gtkingpro_defconfig       |   1 +
>   configs/khadas-vim3_android_ab_defconfig  |   1 +
>   configs/khadas-vim3_android_defconfig     |   1 +
>   configs/khadas-vim3_defconfig             |   1 +
>   configs/khadas-vim3l_android_ab_defconfig |   1 +
>   configs/khadas-vim3l_android_defconfig    |   1 +
>   configs/khadas-vim3l_defconfig            |   1 +
>   configs/odroid-c4_defconfig               |   1 +
>   configs/odroid-hc4_defconfig              |   1 +
>   configs/odroid-n2_defconfig               |   1 +
>   configs/radxa-zero_defconfig              |   1 +
>   configs/sei510_defconfig                  |   1 +
>   configs/sei610_defconfig                  |   1 +
>   configs/u200_defconfig                    |   1 +
>   drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
>   19 files changed, 35 insertions(+), 127 deletions(-)
> ---
> base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
> change-id: 20221024-meson-dm-usb-60e413696519
> 
> Best regards,

