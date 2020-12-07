Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.5236.1607344168570474142
 for <u-boot-amlogic@groups.io>;
 Mon, 07 Dec 2020 04:29:34 -0800
Received: by mail-wm1-f51.google.com with SMTP id d3so11290016wmb.4
        for <u-boot-amlogic@groups.io>; Mon, 07 Dec 2020 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YiJiskwmeVlxte6EqTtd207XYr//73GDarT2BjqWYNg=;
        b=wxcHfYdaFEPzDy1d0DUGtmchA9Yip0ks4H4HKTH1rhGayvE+Ol3i62yH/xpMwcM386
         iEI7KSO6ctqKiiJu68edrBm0Ib7Qpv22/FBq06n/WoLP6zJRH46elpHuFdDkP/uLYRiH
         inqnOVsPoLIuEtz9zIc596O/CJyCVOJzmVEUENZwC4Qj4+MKgWhU4zGQJpkmSSoR3l0m
         SU3B9wbc9VjvIqEdAp4v3heeE3PFK3+kMM97vfIvE05Zi1u+QZobeLCzJr0yPOPcqFNh
         Ry7udH5lUeolRc9LSsv3egiCs0BjY9ILbnV8QTMttyJusA1lHOT8qH0w/5DhA2wJj6N+
         gF1w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net>
 <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net>
 <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
Date: Mon, 7 Dec 2020 13:29:25 +0100
MIME-Version: 1.0
In-Reply-To: <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Otto Meier <gf435@gmx.net>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

(Please CC u-boot-amlogic@groups.io when U-Boot is concerned)

On 07/12/2020 13:19, Otto Meier wrote:
> Hi Martin,
> 
> 
> I did a lot of googling this weekend and found some interesting problems with
> odroid-c2.
> 
> 1. booting from emmc stop after u-boot 2020.04 (this hits me also)

Indeed, this already has been reported, but the root cause is unknown

> 2. usb did not work with newer kernels.
> 
> This gaves me the idea that something in the configuration of the s905 soc
> is not ok.
> 
> here: https://forum.libreelec.tv/thread/12330-balbes150-le-images-with-kodi-19-for-s9xxx/?postID=147212#post147212
> and here: https://lists.denx.de/pipermail/u-boot/2020-November/thread.html
> 
> in https://groups.io/g/u-boot-amlogic/topic/77816805#661 some problems in pinctrl related to booting from emmc is discussed.
> 
> i found that commit dd5f2351e99aad8fcbedbc1305b8b51b09952336 of u-boot
> rendered the situation for odroid-c2 bad.
> 
> i gave the following patch on Top of commit ee1e04558ff8c8ed812b986939447f129bb0b0bb of u-boot
> a try ad it fixes the odroid-c2 boot issue.
> 
> --- u-boot.git/arch/arm/dts/meson-gxbb.dtsi.orig        2020-11-27 17:20:04.624193561 +0100
> +++ u-boot.git/arch/arm/dts/meson-gxbb.dtsi     2020-11-27 17:23:18.472088934 +0100
> @@ -403,36 +403,33 @@
>                         gpio-ranges = <&pinctrl_periphs 0 0 119>;
>                 };
>  
> -               emmc_pins: emmc {
> -                       mux-0 {
> -                               groups = "emmc_nand_d07",
> -                                      "emmc_cmd";
> -                               function = "emmc";
> -                               bias-pull-up;
> -                       };
>  
> -                       mux-1 {
> -                               groups = "emmc_clk";
> -                               function = "emmc";
> -                               bias-disable;
> -                       };
> -               };
> +                emmc_pins: emmc {
> +                        mux {
> +                                groups = "emmc_nand_d07",
> +                                       "emmc_cmd",
> +                                       "emmc_clk";
> +                                function = "emmc";
> +                        };
> +                };
>  
> -               emmc_ds_pins: emmc-ds {
> -                       mux {
> -                               groups = "emmc_ds";
> -                               function = "emmc";
> -                               bias-pull-down;
> -                       };
> -               };
> +                emmc_ds_pins: emmc-ds {
> +                        mux {
> +                                groups = "emmc_ds";
> +                                function = "emmc";
> +                        };
> +                };
>  
> -               emmc_clk_gate_pins: emmc_clk_gate {
> -                       mux {
> -                               groups = "BOOT_8";
> -                               function = "gpio_periphs";
> -                               bias-pull-down;
> -                       };
> -               };
> +                emmc_clk_gate_pins: emmc_clk_gate {
> +                        mux {
> +                                groups = "BOOT_8";
> +                                function = "gpio_periphs";
> +                        };
> +                        cfg-pull-down {
> +                                pins = "BOOT_8";
> +                                bias-pull-down;
> +                        };
> +                };
>  
>                 nor_pins: nor {
>                         mux {
> 
> 
> 
> So with the latest u-boot and the kernel from https://github.com/chewitt/linux/tree/amlogic-5.10.y
> commit 725fc8df7898102f9031ba2075f763884ffa3ee8 everything is working again.
> USB does hotplugging as expected.

So, this fixes USB under Linux ?? It's not clear

Neil

> 
> For me this make it work again. But i`m sorry, I don´t know what would be a real fix.
> 
> 
> 
> 
> 
> 
> Am 05.12.20 um 20:55 schrieb Martin Blumenstingl:
>> Hi Otto,
>>
>> On Sat, Dec 5, 2020 at 6:40 PM Otto Meier <gf435@gmx.net> wrote:
>>>
>>> Hi Martin,
>>>
>>> i have tried your second notice. but it does'nt solve the issue.
>>> if at leased on device is pluged in new devices are detected. if
>>> all devices have been removed, no new device will be detected anymore.
>> thanks for trying this out and for reporting back.
>> can you please also test if running "lsusb -vvv" (as root) makes the
>> devices show up?
>>
>> background info: the Amlogic Meson GXBB SoC on your Odroid-C2 board
>> uses a "dwc2" USB 2.0 controller.
>> I don't have any GXBB based board, but my Odroid-C1+ uses the same
>> controller and overall setup. There I can reproduce the problem you
>> are seeing.
>>
>> I am not sure which part of the "infrastructure" (on-board 4-port USB
>> hub, dwc2 controller, ...) is causing this issue.
>> My suggestion is to involve the linux-usb mailing list and dwc2 driver
>> maintainer:
>> - Minas Harutyunyan <hminas@synopsys.com> (dwc2 driver maintainer)
>> - linux-usb@vger.kernel.org (usb mailing list)
>>
>> In the past they provided information and helped to debug issues.
>> Please also keep me Cc'ed so I can help with any Amlogic specific
>> questions, drivers, etc.
>>
>>
>> Best regards,
>> Martin
>>

