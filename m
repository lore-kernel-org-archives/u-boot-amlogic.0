Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.104695.1673360723799373963
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 06:25:24 -0800
Received: by mail-wm1-f45.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso6616594wmb.3
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KtarQl98aIpePo/5BlJGT/iJvJzbUCaQV8QUWKCcPPs=;
        b=dlPityKeNNle/FVQsCWUOE/8ssEFdb4wCFJrCIogwdIhImB1MjjN6VWJbhgUTZPVcb
         q2k3oBhMn1nZ3vGCP/2yypU+vZPJ14cAa27JHx/yZ9PKvLlCyasHIOEm1FJz/Sw3lmK1
         9JiZn8m2AjLkInjGiwADkzNAIqdHMe/hC1mmiUj7K+nQFxAHrn9ExGTtrYNGmlAoDUub
         4RQYi5UEp1zW3b8VUxpDxBMjJZv/hMV9Xs0BfNOEfZmX0fY457KNC/D8Uk2nnO7EMkby
         8PnZFJbQSvjwzgR+42WbOy3wvc0CQD1lUbkJkGEldGkWGd+FhJUcq1WLXyjYjHVlmYhC
         ECiw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <1e7a6e16-d03f-10c8-3186-55bec4b68f89@linaro.org>
Date: Tue, 10 Jan 2023 15:25:21 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
 <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
 <87cz8mcadj.fsf@baylibre.com>
 <3a844610-20e3-cbd1-f00c-88f1f2f3e5ed@linaro.org>
 <87h6wy8xgh.fsf@baylibre.com>
In-Reply-To: <87h6wy8xgh.fsf@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/01/2023 12:01, Mattijs Korpershoek wrote:
> On Wed, Dec 14, 2022 at 15:49, neil.armstrong@linaro.org wrote:
> 
>> Hi,
>>
>> On 14/12/2022 15:45, Mattijs Korpershoek wrote:
>>> Hi Neil,
>>
>> <snip>
>>
>>>>
>>>> I'll run some tests on other G12 boards but so far this looks very good, thanks !
>>>
>>> I got my hands on an odroid-c4 board and I also tested:
>>> => fastboot usb 0
>>> => # hit Ctrl-c
>>> # disconnection is ok
>>>
>>> And tested "usb start" and could list a usb thumb drive.
>>>
>>> Any other tests you would like me to do?
>>
>> No it's enough, thx for testing on the C4, this test the Device/Host
>> switch is still working !
>>
>> Marek, can you take the whole patchset with my Acked-by or should I take it ?
>>
>> Neil
> 
> Hi Neil, Marek,
> 
> Anything blocking to pick this up?
> I see it's assigned to Neil on patchwork, but it's mostly usb related.
> 
> I've just re-tested the series on top of usb/master, if that helps.

Marek,

I'm ready to merge it, is it ok for you ?

Neil

> 
> Thanks you,
> Mattijs
> 
>>
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> ---
>>>>> Mattijs Korpershoek (2):
>>>>>          usb: dwc3-meson-g12a: force mode on child add/removal
>>>>>          ARM: meson: g12a: switch dwc2 otg to DM
>>>>>
>>>>>     arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
>>>>>     configs/bananapi-m5_defconfig             |   1 +
>>>>>     configs/beelink-gsking-x_defconfig        |   1 +
>>>>>     configs/beelink-gtking_defconfig          |   1 +
>>>>>     configs/beelink-gtkingpro_defconfig       |   1 +
>>>>>     configs/khadas-vim3_android_ab_defconfig  |   1 +
>>>>>     configs/khadas-vim3_android_defconfig     |   1 +
>>>>>     configs/khadas-vim3_defconfig             |   1 +
>>>>>     configs/khadas-vim3l_android_ab_defconfig |   1 +
>>>>>     configs/khadas-vim3l_android_defconfig    |   1 +
>>>>>     configs/khadas-vim3l_defconfig            |   1 +
>>>>>     configs/odroid-c4_defconfig               |   1 +
>>>>>     configs/odroid-hc4_defconfig              |   1 +
>>>>>     configs/odroid-n2_defconfig               |   1 +
>>>>>     configs/radxa-zero_defconfig              |   1 +
>>>>>     configs/sei510_defconfig                  |   1 +
>>>>>     configs/sei610_defconfig                  |   1 +
>>>>>     configs/u200_defconfig                    |   1 +
>>>>>     drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
>>>>>     19 files changed, 35 insertions(+), 127 deletions(-)
>>>>> ---
>>>>> base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
>>>>> change-id: 20221024-meson-dm-usb-60e413696519
>>>>>
>>>>> Best regards,

