Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.105406.1671029390626465433
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Dec 2022 06:49:51 -0800
Received: by mail-wm1-f44.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so10919016wms.4
        for <u-boot-amlogic@groups.io>; Wed, 14 Dec 2022 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iibTlzmVGHdmH9vPURt1XMbFFSB5VfZ9P9r0QNPX5Dc=;
        b=ESx4iewDL4LeRLgoY6qMRNzaGQyszMvrHgiLP53rFRALhqo0IkpYijAK2/zmQzafVQ
         c6Dm1jp34ZKergpFKKsGogpqPyg+z7srGbcayr/jduzl8kMryUdl6FEttzPQxHwKMbty
         RxqgRIJXm4aypYDDsaKN2A5iCGLkXgtkA2blMRvE+KIyDtrtO5UnDiA41BX0kXeBPlP1
         PIavNObZE118lq7V2Ou8P3HMd2CjT3UQcQj2rIet92l4Hje4t4xYsKzrJX7mIF/XstO5
         Hhc6bVkdsb42+n7gd5S6oJydvoQBEaqpCy9d06Fhqk80aygGg28gmUHqNi/q9KdCztjI
         8+tg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3a844610-20e3-cbd1-f00c-88f1f2f3e5ed@linaro.org>
Date: Wed, 14 Dec 2022 15:49:47 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
 <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
 <87cz8mcadj.fsf@baylibre.com>
In-Reply-To: <87cz8mcadj.fsf@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 14/12/2022 15:45, Mattijs Korpershoek wrote:
> Hi Neil,

<snip>

>>
>> I'll run some tests on other G12 boards but so far this looks very good, thanks !
> 
> I got my hands on an odroid-c4 board and I also tested:
> => fastboot usb 0
> => # hit Ctrl-c
> # disconnection is ok
> 
> And tested "usb start" and could list a usb thumb drive.
> 
> Any other tests you would like me to do?

No it's enough, thx for testing on the C4, this test the Device/Host
switch is still working !

Marek, can you take the whole patchset with my Acked-by or should I take it ?

Neil

> 
>>
>> Neil
>>
>>>
>>> ---
>>> Mattijs Korpershoek (2):
>>>         usb: dwc3-meson-g12a: force mode on child add/removal
>>>         ARM: meson: g12a: switch dwc2 otg to DM
>>>
>>>    arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
>>>    configs/bananapi-m5_defconfig             |   1 +
>>>    configs/beelink-gsking-x_defconfig        |   1 +
>>>    configs/beelink-gtking_defconfig          |   1 +
>>>    configs/beelink-gtkingpro_defconfig       |   1 +
>>>    configs/khadas-vim3_android_ab_defconfig  |   1 +
>>>    configs/khadas-vim3_android_defconfig     |   1 +
>>>    configs/khadas-vim3_defconfig             |   1 +
>>>    configs/khadas-vim3l_android_ab_defconfig |   1 +
>>>    configs/khadas-vim3l_android_defconfig    |   1 +
>>>    configs/khadas-vim3l_defconfig            |   1 +
>>>    configs/odroid-c4_defconfig               |   1 +
>>>    configs/odroid-hc4_defconfig              |   1 +
>>>    configs/odroid-n2_defconfig               |   1 +
>>>    configs/radxa-zero_defconfig              |   1 +
>>>    configs/sei510_defconfig                  |   1 +
>>>    configs/sei610_defconfig                  |   1 +
>>>    configs/u200_defconfig                    |   1 +
>>>    drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
>>>    19 files changed, 35 insertions(+), 127 deletions(-)
>>> ---
>>> base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
>>> change-id: 20221024-meson-dm-usb-60e413696519
>>>
>>> Best regards,

