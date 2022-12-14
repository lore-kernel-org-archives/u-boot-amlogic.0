Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.105878.1671029126180459552
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Dec 2022 06:45:26 -0800
Received: by mail-wr1-f43.google.com with SMTP id h10so19538246wrx.3
        for <u-boot-amlogic@groups.io>; Wed, 14 Dec 2022 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TZVQl7d/D/SUk1I8FMM3c3Zg3nxbD1rvpMwMiwIkTc=;
        b=UY4exXYp+s562C5FtAK5KlQruJSSt/z9mWKXjYI1E6aNEUE92jRAHdi7KTv6vCg+5H
         IS7JSLish+XI7/nV0olgZYsiR4LBxIbgrM0RKf0EZ3bNe8oVR6M7MCnI+ZhlxRTYpY0w
         eLkxN3FVvmnVhYX2ezW9v+gVDR3mvFQ+/U4E8WtoFlBDHkpIh/Tg8Bi4elW47h5E7DKk
         igjr5S0e6+fg/LnxsSs1MoW+yaxLR3cx/BT3tT2Qz6+LY1nReFHqFayTL39FNgnEC/06
         aDOjOCJtvbsVdtF0yLZHPUUIi+7RY4bj4qnlkqjFVqlSo7cEuyZaUou1phIjLcgfsyKx
         /PnQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
In-Reply-To: <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
 <55e46ad9-63cb-ff2c-d087-ab9af41d20ea@linaro.org>
Date: Wed, 14 Dec 2022 15:45:12 +0100
Message-ID: <87cz8mcadj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: neil.armstrong@linaro.org, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Thu, Nov 24, 2022 at 10:34, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Mattijs,
>
> On 23/11/2022 16:42, Mattijs Korpershoek wrote:
>> While working on some USB bugs on the VIM3L board, we stumbled upon the fact
>> that mach-meson still uses legacy board_usb_*() functions instead of using DM [1]
>> 
>> This series aim to switch the g12a based boards to use CONFIG_DM_USB_GADGET and
>> removes the board_usb_*() logic.
>> 
>> * The first patch adds mode switching in the dwc3-meson-g12a glue driver whenever
>>    the dwc2 otg driver is probed()/removed().
>> 
>> * The second patch enables the config option and cleans up all board_usb_*().
>> 
>> This has been mainly tested with khadas-vim3l_android_defconfig using fastboot:
>> 
>> => fastboot usb 0
>> 
>> => # hit Ctrl-c
>> 
>> Other tests:
>> * ums 0 mmc 2 # can list / mount partitions from host
>> * usb start; usb storage # list usb thumb drive
>> * all defconfigs have been build tested
>> 
>> [1] https://lore.kernel.org/u-boot/938b9439-9014-5ee8-1627-16af508bface@linaro.org/
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> I'll run some tests on other G12 boards but so far this looks very good, thanks !

I got my hands on an odroid-c4 board and I also tested:
=> fastboot usb 0
=> # hit Ctrl-c
# disconnection is ok

And tested "usb start" and could list a usb thumb drive.

Any other tests you would like me to do?

>
> Neil
>
>> 
>> ---
>> Mattijs Korpershoek (2):
>>        usb: dwc3-meson-g12a: force mode on child add/removal
>>        ARM: meson: g12a: switch dwc2 otg to DM
>> 
>>   arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
>>   configs/bananapi-m5_defconfig             |   1 +
>>   configs/beelink-gsking-x_defconfig        |   1 +
>>   configs/beelink-gtking_defconfig          |   1 +
>>   configs/beelink-gtkingpro_defconfig       |   1 +
>>   configs/khadas-vim3_android_ab_defconfig  |   1 +
>>   configs/khadas-vim3_android_defconfig     |   1 +
>>   configs/khadas-vim3_defconfig             |   1 +
>>   configs/khadas-vim3l_android_ab_defconfig |   1 +
>>   configs/khadas-vim3l_android_defconfig    |   1 +
>>   configs/khadas-vim3l_defconfig            |   1 +
>>   configs/odroid-c4_defconfig               |   1 +
>>   configs/odroid-hc4_defconfig              |   1 +
>>   configs/odroid-n2_defconfig               |   1 +
>>   configs/radxa-zero_defconfig              |   1 +
>>   configs/sei510_defconfig                  |   1 +
>>   configs/sei610_defconfig                  |   1 +
>>   configs/u200_defconfig                    |   1 +
>>   drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
>>   19 files changed, 35 insertions(+), 127 deletions(-)
>> ---
>> base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
>> change-id: 20221024-meson-dm-usb-60e413696519
>> 
>> Best regards,
