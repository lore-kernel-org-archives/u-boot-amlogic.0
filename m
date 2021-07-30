Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web08.23518.1627648155917177253
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:29:16 -0700
Received: by mail-wm1-f53.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so7146643wmd.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=T5ji4+YdB1xROcgS4tTzyeB0RcBlnqg55EmlR+mhg+c=;
        b=eydNJS9h6PphwH8FcEqQrebmwGckc3o3PCtVlMSzgCC8VVEUpbtbiXY4O+Qw/TW3Yx
         PoCNWu6mO3A7wMIykOOr9yiAGFTDJky8jBfzG7u0ZwLpyjrsMv6macEpP/8ywzA50923
         8SspP9+qLRPTM3QsVczmYVnOlHn7aJeAivQdWrSSp5/gkoZWvlobPHrz1BAUJIEewC9T
         zGqhqRY5SlUi7w19SvXAZxgj5M/244kk0V4QXCc5E6sNBxuJPI0S4tBJ8zDZU+6jmXQW
         VrRBBHOdFzMxEtWmhBBy0H0PpglpSDJiqgCjFWprwR4h38uy6cE4M2czr3os0cZsmruE
         X42A==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 0/5] meson64_android: use BCB for reboot reason
In-Reply-To: <2a76c618-8d6a-8a1c-19dd-2ce899c49459@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
 <2a76c618-8d6a-8a1c-19dd-2ce899c49459@baylibre.com>
Date: Fri, 30 Jul 2021 14:29:13 +0200
Message-ID: <87v94s56jq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 30/07/2021 10:55, Mattijs Korpershoek wrote:
>> The SEI-610 and SEI-510 boards are well supported in the
>> Android Open Source project via the yukawa [1] platform.
>> 
>> Their U-Boot version, despite being public [2] is not in mainline.
>> 
>> Android has multiple OSes it can boot into:
>> * Main android
>> * Recovery OS
>> * Fastbootd (recovery OS with fastboot mode)
>> * Bootloader (U-Boot) with fastboot mode
>> 
>> The decision of which OS to boot into is taken by the bootloader based on
>> the "reboot reason".
>> 
>> For amlogic boards, we pass the reboot reason via a custom smc call.
>> This support is limited: we don't r
>> 
>> These series reworks the reboot reason handling to use the BCB, which
>> is the standard Android way.
>> 
>> [1] https://android.googlesource.com/device/amlogic/yukawa
>> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
>> 
>> Mattijs Korpershoek (5):
>>   Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
>>   configs: meson64_android: use BCB for reboot to bootloader
>>   configs: meson64_android: implement recovery boot via BCB
>>   configs: meson64_android: reboot to fastbootd from bootloader
>>   configs: sei610/sei510: set CONFIG_CMD_BCB=y
>> 
>>  arch/arm/mach-meson/board-common.c | 34 -----------------
>>  configs/sei510_defconfig           |  1 +
>>  configs/sei610_defconfig           |  1 +
>>  include/configs/meson64_android.h  | 60 ++++++++++++++++++++----------
>>  4 files changed, 42 insertions(+), 54 deletions(-)
>> 
>
> Looks fine, but I'll move the patch 1 as last.
Thanks for your review.
>
> Can you re-post ?
>
> Please add:
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>
> to all patches if you repost.
I've reposted a v2 with your ack.

Mattijs
>
> Neil
