Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.7724.1608284978660738411
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:49:39 -0800
Received: by mail-wm1-f44.google.com with SMTP id q75so1896305wme.2
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AlmT0+KRkCFUVXluGgVzpqT16Jol1fJmw432R4RngYU=;
        b=U/ePxtCN8pLPnPid2ihyR7v+M3PmqesXOY0Ebm8p3I2QRTqD9X5jaNmjTaaT18ir7v
         T/4Jp2qsAeqL0XULf/q+7QNr3+Ze2k42w/DSjBC2EiwE59nndQG6ln5oFfmJ3FPeREUJ
         V7idq0UGn2pqd2hUePEgn5U2Fj4RmX688HfPIrEi7QPV5fAcZTC2NuLjBoGo325kkki5
         MbDdnKddseNtU/wCDs1qavTizOXV0wWiwUPtdtk1mdSBa8yxLGwSeXJe/ieP/jGB46FC
         td2rSdWVQZzXfqbFe1s8fnPIyHaYA7Uw9rGK3XwVolbbibhcbllm4NKxuTlab0y3tPEg
         UO1Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com>
 <20201217090624.14902-1-m.szyprowski@samsung.com>
 <0c53e06e-afa4-2308-7d5d-ba08b1d0caf3@baylibre.com>
 <b006ae83-3a27-f0dd-c905-5ac7f41be067@samsung.com>
 <eea5161b-c5bc-3804-5f88-318052c29a31@baylibre.com>
 <7d86442a-4de9-d7c5-c997-8d1f17fcb7a5@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4d09fb17-7dfb-d702-adf5-5918a8e1cfc8@baylibre.com>
Date: Fri, 18 Dec 2020 10:49:34 +0100
MIME-Version: 1.0
In-Reply-To: <7d86442a-4de9-d7c5-c997-8d1f17fcb7a5@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, tobetter <tobetter@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 18/12/2020 10:42, Marek Szyprowski wrote:
> Hi Neil,
> 
> On 18.12.2020 10:24, Neil Armstrong wrote:
>> On 18/12/2020 10:11, Marek Szyprowski wrote:
>>> On 18.12.2020 09:36, Neil Armstrong wrote:
>>>> On 17/12/2020 10:06, Marek Szyprowski wrote:
>>>>> For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
>>>>> pin to the input (high impedance?) mode, otherwise the board is stuck
>>>>> in the middle of loading early stages of the bootloader from SD card.
>>>> Did you try taking the regulator-tflash_vdd and doing a disable/enable sequence
>>>> to reset the card ?
>>>>
>>>> The GPIOAO_3 has a default pull-up, so I don't see why moving it to input could change
>>>> anything.
>>>>
>>>> So maybe simply doing a 0->1 transition could do the same, using the regulator
>>>> would be much better.
>>>>
>>>> Can't we add "shutdown" or equivalent method to  the mmc driver that could do this
>>>> directly with the vdd regulator ?
>>> Yes, I've tried all combinations of playing this that GPIO and regulator
>>> that came to my mind. Switching pin to the input is the only one I've
>>> found working.
>> Thanks for the dumps !
>>
>> Could you try switching the tflash_vdd to opendrain like :
>>
>> --->8---
>>
>> --- a/arch/arm/dts/meson-sm1-odroid-c4.dts
>> +++ b/arch/arm/dts/meson-sm1-odroid-c4.dts
>> @@ -52,7 +52,7 @@
>>                  regulator-min-microvolt = <3300000>;
>>                  regulator-max-microvolt = <3300000>;
>>
>> -               gpio = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
>> +               gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
>>                  enable-active-high;
>>                  regulator-always-on;
>>          };
>>
>> --->8---
>>
>> This should leave the pin in input to achieve high state, and solve the issue.
>>
> Right, this fixed the issue! Thanks!
> 
> Do you want me to submit it as a patch to uboot and mainline Linux 
> kernel or do you want to handle it by yourself?

Sure, if you can please submit them.

Concerning u-boot, please update arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi instead
until the DT is sync'ed from Linux

> 
> Best regards
> 

Thanks for testing !

Neil

