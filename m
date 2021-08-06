Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web09.2040.1628236658153505126
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Aug 2021 00:57:38 -0700
Received: by mail-wr1-f51.google.com with SMTP id p5so9922022wro.7
        for <u-boot-amlogic@groups.io>; Fri, 06 Aug 2021 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1Wgr0qUjc/TBwDb51jM/HlVaS/UulASz5hyzGbR108=;
        b=WA1TMVFa2Ebv7CxBF1dlztltdoD5aWzlvZ2FDW3QhSFQP1dW5X6Mu/Krl9tdk3XHC2
         HnMt0x/VxswgE0bpQJHNLuzY+FDQDhcElvq0w3J70J6ML9O4vKaBNXWd+Ln3M6847j1Z
         6AtpGps8m28EOoBxoCUZo/p7zGP7NDsMJkhkVSSkxfyLyiQ6veI9g+Z76kkDjwI8NGZD
         zAv5JACKsOIcvhSaTR0S+iSI+gqt18s/5LReEZMM4NpEv+p6ZMspacNg37oYLf2ViSD+
         fA6U5XoYyQISOLG1KL/Vwu7YZuJyz0ZyL6QAl74LWqq3eU9UUmLhiRriPhsrMxG5JyYW
         8tqA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/9] meson64_android: Android boot flow using abootimg
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805172332.GO858@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <fcd676dd-b2b1-c201-8177-5419eae9f00d@baylibre.com>
Date: Fri, 6 Aug 2021 09:57:35 +0200
MIME-Version: 1.0
In-Reply-To: <20210805172332.GO858@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 19:23, Tom Rini wrote:
> On Thu, Aug 05, 2021 at 05:17:19PM +0200, Mattijs Korpershoek wrote:
> 
>> The SEI-610 and SEI-510 boards are well supported in the
>> Android Open Source project via the yukawa [1] platform.
>>
>> Their U-Boot version, despite being public [2] is not in mainline.
>>
>> Android 10 and higher have significantly reworked the bootloader
>> requirements:
>>
>> * bootloader should pass slot information in case of A/B
>> * bootloader should perform AVB verification in case it's supported
>> * bootloader should read and apply dtb overlays from a dtbo partition
>>
>> These series add support for all the above.
>>
>> [1] https://android.googlesource.com/device/amlogic/yukawa
>> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> My high level concern with this series is that it takes what I assume is
> the Android-only boot path, and adds further abstractions to it, it
> looks like.  Can we just say "Here is the Android 10 boot path" (since
> AVB has been around for a while) and here is the generic distro boot
> path for non-Android?  Reading this over it looks like it becomes "Here
> is the Android + AVB boot path", "Here is the Androidd non-AVB boot
> path" and then I assume "Here is the generic distro boot path".
> 
> I'd also like to know if in general we can make some generic environment
> macros for "Here is Android AVB boot path", so that we don't need to
> duplicate this between SoCs.  At the very high level, something like the
> generic distro boot framework, but that does Android instead.
> 

We've been thinking about that, but the Android boot flow doesn't really leave place
for other methods.

In our implementation we decided to use the distro_bootcmd helper to setup the different
Android boot flow steps, it permits to have a much simpler cmd definition than the other
implementation, but makes mixing with the default boot steps more complex (or maybe there
is something we can use to enable/disable easily some distro BOOT_TARGET_DEVICES ?)

Neil
