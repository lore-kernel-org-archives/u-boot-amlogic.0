Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.6502.1628264204803137832
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Aug 2021 08:36:45 -0700
Received: by mail-wr1-f41.google.com with SMTP id h14so11581270wrx.10
        for <u-boot-amlogic@groups.io>; Fri, 06 Aug 2021 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Gtni3IwrBd5xFT96wsgbV1T+mSkowOvJuXNBYTLURwQ=;
        b=krRZ78Jh1/Qj5rZU3g/UnWC6LFzCK1rKUJN/WIUkIvk14sS0rRQPudRkx9SyshW/ec
         3UgFMRyYVAxAWNFxioJu0Na3t8CegSO5WW3frXLKkntgHO/05bkiay1nL3cXaAOJzgi3
         tHFAu3Pv+UtJRQ1tp8X4/Cc0q39Gd4FBg/D6GZMCcvgRGta32Bx49j5aPMd1Ik3v+Vb0
         XqIOTrsJhQ5AVuKisf4x1RwYLabJfSxEUVGJYJP/19hcKL7TBTsIIlsRPxxG5e+RW+cA
         MoIWJcwVLUrAFL9D+mlMJmZED7W7dcbTzh/d0JF+YZh6lpPTjoe/82dPIz7UmNtNvpwu
         dH7A==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 0/9] meson64_android: Android boot flow using abootimg
In-Reply-To: <fcd676dd-b2b1-c201-8177-5419eae9f00d@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805172332.GO858@bill-the-cat>
 <fcd676dd-b2b1-c201-8177-5419eae9f00d@baylibre.com>
Date: Fri, 06 Aug 2021 17:36:41 +0200
Message-ID: <87bl6ak2k6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Neil, Tom,

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 05/08/2021 19:23, Tom Rini wrote:
>> On Thu, Aug 05, 2021 at 05:17:19PM +0200, Mattijs Korpershoek wrote:
>> 
>>> The SEI-610 and SEI-510 boards are well supported in the
>>> Android Open Source project via the yukawa [1] platform.
>>>
>>> Their U-Boot version, despite being public [2] is not in mainline.
>>>
>>> Android 10 and higher have significantly reworked the bootloader
>>> requirements:
>>>
>>> * bootloader should pass slot information in case of A/B
>>> * bootloader should perform AVB verification in case it's supported
>>> * bootloader should read and apply dtb overlays from a dtbo partition
>>>
>>> These series add support for all the above.
>>>
>>> [1] https://android.googlesource.com/device/amlogic/yukawa
>>> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
>> 
>> My high level concern with this series is that it takes what I assume is
>> the Android-only boot path, and adds further abstractions to it, it
>> looks like.  Can we just say "Here is the Android 10 boot path" (since
>> AVB has been around for a while) and here is the generic distro boot
>> path for non-Android?  Reading this over it looks like it becomes "Here
>> is the Android + AVB boot path", "Here is the Androidd non-AVB boot
>> path" and then I assume "Here is the generic distro boot path".
Not exactly. Android supports multiple combinations:
- non-AVB + no-A/B  (legacy, no security). This is usually used for
development builds
- AVB + no-A/B
- AVB + A/B
Here, we should be supporting all of the above using compile flags.
>> 
>> I'd also like to know if in general we can make some generic environment
>> macros for "Here is Android AVB boot path", so that we don't need to
>> duplicate this between SoCs.  At the very high level, something like the
>> generic distro boot framework, but that does Android instead.
I agree. It would be really nice if we could have a generic "boot android" framework

TI has a ti_omap5_common.h which seems to support similar things.
However, it does not support the "no-A/B" mode.
In that file, we can also see board specific logic: namely the mapping
between the $board_name and the dtbo index passed to "abootimg".

Google has another approach via the boot_android[1] command.

We will keep looking into this.

For now, we have mostly worked on cleaning up/syncing the downstream [1]
yukawa tree in order to enable AOSP users to rebuild their U-Boot from mainline.

[1] http://patchwork.ozlabs.org/project/uboot/patch/20170402084952.5102-7-deymo@google.com/
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
>> 
>
> We've been thinking about that, but the Android boot flow doesn't really leave place
> for other methods.
>
> In our implementation we decided to use the distro_bootcmd helper to setup the different
> Android boot flow steps, it permits to have a much simpler cmd definition than the other
> implementation, but makes mixing with the default boot steps more complex (or maybe there
> is something we can use to enable/disable easily some distro BOOT_TARGET_DEVICES ?)
>
> Neil
