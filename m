Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.13912.1603806342224963954
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Oct 2020 06:45:42 -0700
Received: by mail-wm1-f41.google.com with SMTP id c194so1436412wme.2
        for <u-boot-amlogic@groups.io>; Tue, 27 Oct 2020 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oBqgFVd7Hbk/NahGoCyQQBm7kFcjDALu9BuwFYw5QDM=;
        b=QsvW+4Njr8ovkLN/ph/l4ZNtsE/JvWXJfHZ+LuMgNYwn4dC88WnQ3JvJ/7pw4ZEbVR
         f2gMFh9HQHxdHP9Pi7dZIBySneZHZ3WDNY3C5Ne/uDnMpnUaJAvgNn8mo19DtfQVv0h7
         vAa+RTb88V8O00Zvucntn+Fz2wrLuEda8n5UW9O2qqFGAVm24YRiS5P3fktLfjO56pc+
         hNIBVtiOtxVWAvscQhqmK2Gq8CzobMuD5exqhaaICulEbUq5OH6JcFDN1vjG0FMGNYkH
         Vnp/58q9bx3O2PUibTmFODkLFLzfMGlW3ye1HXOHrVkpB8Ri3WK03jGjVCFCnFQLnjcU
         IuDg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
 <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com>
 <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
 <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com>
 <CAMeizLc163WqCM-MVGFSSZnrZ_6mwVTrtje4Vp86d8z4gDw-SQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <032e222c-1f46-0efc-d92b-ee848fc2c12e@baylibre.com>
Date: Tue, 27 Oct 2020 14:45:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAMeizLc163WqCM-MVGFSSZnrZ_6mwVTrtje4Vp86d8z4gDw-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anton Arapov <arapov@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 26/10/2020 18:56, Anton Arapov wrote:
> On Mon, Oct 26, 2020 at 4:35 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Mon 26 Oct 2020 at 15:59, Anton Arapov <arapov@gmail.com> wrote:
>>> Another observation is that u-boot with mentioned patch can't
>>> find/initialize ethernet on a brand new Odroid C2, rev0.2 20171114.
>>> But after booting without this patch at least once - ethernet is found
>>> and working fine. And amazingly it keeps working even after the patch
>>> is applied again later.
>> That would be amazing indeed
> 
> IKR :-)
> 
>>> On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> It's weird this fixes the issue, because the BOOT_0 to BOOT_8 have
>>>> default Pull-Up by default,
>> But it isn't necessarily what you get out of ROM code, which is reason
>> for setting up bias in DT initially.
>>>> and Linux works fine with this.
>> This part is weird ...
> 
>>>> S905_Public_Datasheet_V1.1.4.pdf pages 17 & 18
>>>> Maybe there is another issue in pinctrl instead ?
> 
> I am quite new here,... reading pdf and mapping it to code atm.
> 
> 
>>>> On 26/10/2020 15:36, Anton Arapov wrote:
> [snip]
>>>>> Could you suggest what could be done in order to fix the issue? Where
>>>>> should I look?
>>
>> Now if just removing the "bias-pull-up" is making it "go" for you, it
>> would be interresting to know what actually happened, what did you
>> inherit from the ROM code?
>>
>> IOW, could you compare the registers linked to the pin bias a let us
>> know what changed with and without ?
> 
> Jerome, I am new to u-boot story. Your request made me look into pdf
> and registers and this is what I found:
> 
> I built two u-boot builds with odroid-c2_defconf, (1) with the patch,
> (2) - a commit before the patch
> (1) dd5f2351e9 arm64: dts: meson: sync dt and bindings from v5.6-rc2
> (2) b3d69aa596 clk: meson: reset mmc clock on probe
> 
> I found the registers and offsets at page 87 of
> S905_Public_Datasheet_V1.1.4.pdf mentioned earlier.
> 
> u-boot build (1) with the patch, can NOT boot from eMMC:
> => md.b 0xc8834528 # PU/PD-EN
> c8834528: 01 7a 0f fc 00 c0 00 f0 ff ff 7f 00 00 00 00 00    .z..............
> => md.b 0xc88344f0 # PU/PD
> c88344f0: 01 7b 4f fc ff bf 00 f0 bf ff 6f 00 00 00 00 00    .{O.......o.....


Indeed, this makes Pull-Up only on these pins:
BOOT0
BOOT9
BOOT11
BOOT12
BOOT13
BOOT14

and the dtsi instructs to set Pull-Up on:
BOOT0 to BOOT7
BOOT10

so there is a bug on the pinctrl u-boot driver here...

Can you trace the drivers/pinctrl/meson/pinctrl-meson.c and drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c ?

We fixed the AXG and G12 ones, but maybe a bug subsists on the GX side.

But it's weird it doesn't appear on GXL.

Neil


> 
> u-boot build (2) right prior the patch, can boot from eMMC
> => md.b 0xc8834528 # PU/PD-EN
> c8834528: ff ff ff ff ff ff 00 f0 ff ff 7f 00 00 00 00 00    ................
> => md.b 0xc88344f0 # PU/PD
> c88344f0: ff ff ff ff ff bf 00 f0 bf ff 6f 00 00 00 00 00    ..........o.....
> 
> Just as a matter of experiment I tried to make u-boot build (1) able
> to boot from eMMC with:
> => mmc dev 1
> Card did not respond to voltage select!
> => mw.b 0xc8834528 ff 1
> => mw.b 0xc88344f0 ff 2
> => mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
> 
> IOW, changing 00000001 01111010 and 00000001 01111011 to 1*
> 
> To be honest I don't know whether this is useful to you at all, it was
> certainly fun for me. :-)
> 
> If this is not something you looked for, let me know how I can actually help.
> 
> Anton
> 

