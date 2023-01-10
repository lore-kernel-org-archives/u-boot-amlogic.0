Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.100883.1673348513714373523
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 03:01:54 -0800
Received: by mail-wm1-f49.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so9553213wms.4
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4wysKX1nxokw6o+DTPLe4d7KKFiXEmnmBbiDaU5WOQ=;
        b=CU+J9YaU/tvPkgCV3I5KDNS2Nq4dVPB8eeeQDgOyLb4FHfnfhZczKGzfOUwQa1ysTr
         ZIdETqkznZlrkFdSgQZ4rpmuNwAMI6MSmOQmHkakICZCsyXVZnOI9li1b3zaAEZbyFlZ
         u2ssjulUhEuGkhrmruh82kSLYijhy1DuNIrG95onEq9viJbjcn9kkhKDprgNX9rybV5Q
         +1TKlQu3DCZZvAvB6gVuzAbttqdZSife8O9EI2MeKBROQdeif0yuNVFSPU327V+Avqvb
         uNoPyY54emXfwDD3SIUScjQ/ohXe7ZQPHkk55SDwLXBZH8zSGhx7vddTNZJW67HThKki
         CJkQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
In-Reply-To: <3a844610-20e3-cbd1-f00c-88f1f2f3e5ed@linaro.org>
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
 <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
 <87cz8mcadj.fsf@baylibre.com>
 <3a844610-20e3-cbd1-f00c-88f1f2f3e5ed@linaro.org>
Date: Tue, 10 Jan 2023 12:01:50 +0100
Message-ID: <87h6wy8xgh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: neil.armstrong@linaro.org, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Wed, Dec 14, 2022 at 15:49, neil.armstrong@linaro.org wrote:

> Hi,
>
> On 14/12/2022 15:45, Mattijs Korpershoek wrote:
>> Hi Neil,
>
> <snip>
>
>>>
>>> I'll run some tests on other G12 boards but so far this looks very good, thanks !
>> 
>> I got my hands on an odroid-c4 board and I also tested:
>> => fastboot usb 0
>> => # hit Ctrl-c
>> # disconnection is ok
>> 
>> And tested "usb start" and could list a usb thumb drive.
>> 
>> Any other tests you would like me to do?
>
> No it's enough, thx for testing on the C4, this test the Device/Host
> switch is still working !
>
> Marek, can you take the whole patchset with my Acked-by or should I take it ?
>
> Neil

Hi Neil, Marek,

Anything blocking to pick this up?
I see it's assigned to Neil on patchwork, but it's mostly usb related.

I've just re-tested the series on top of usb/master, if that helps.

Thanks you,
Mattijs

>
>> 
>>>
>>> Neil
>>>
>>>>
>>>> ---
>>>> Mattijs Korpershoek (2):
>>>>         usb: dwc3-meson-g12a: force mode on child add/removal
>>>>         ARM: meson: g12a: switch dwc2 otg to DM
>>>>
>>>>    arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
>>>>    configs/bananapi-m5_defconfig             |   1 +
>>>>    configs/beelink-gsking-x_defconfig        |   1 +
>>>>    configs/beelink-gtking_defconfig          |   1 +
>>>>    configs/beelink-gtkingpro_defconfig       |   1 +
>>>>    configs/khadas-vim3_android_ab_defconfig  |   1 +
>>>>    configs/khadas-vim3_android_defconfig     |   1 +
>>>>    configs/khadas-vim3_defconfig             |   1 +
>>>>    configs/khadas-vim3l_android_ab_defconfig |   1 +
>>>>    configs/khadas-vim3l_android_defconfig    |   1 +
>>>>    configs/khadas-vim3l_defconfig            |   1 +
>>>>    configs/odroid-c4_defconfig               |   1 +
>>>>    configs/odroid-hc4_defconfig              |   1 +
>>>>    configs/odroid-n2_defconfig               |   1 +
>>>>    configs/radxa-zero_defconfig              |   1 +
>>>>    configs/sei510_defconfig                  |   1 +
>>>>    configs/sei610_defconfig                  |   1 +
>>>>    configs/u200_defconfig                    |   1 +
>>>>    drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
>>>>    19 files changed, 35 insertions(+), 127 deletions(-)
>>>> ---
>>>> base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
>>>> change-id: 20221024-meson-dm-usb-60e413696519
>>>>
>>>> Best regards,
