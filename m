Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.5495.1628584887247428069
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Aug 2021 01:41:27 -0700
Received: by mail-wr1-f44.google.com with SMTP id m12so25136460wru.12
        for <u-boot-amlogic@groups.io>; Tue, 10 Aug 2021 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+tgp6zqZ23mZRYsSnYXLzxk0JB2tlyqffjx4uklKZ4=;
        b=zfMGNlPtpDcOYWCk2hZrxLZ6OgEaOQJiwzeTvYJsH0DV11DCOuwACc98+3WXvSTBGi
         yPqATRcgu/lzpSyxSrJWuIVhinjgZNXMNPFObT1xun+Yc8Fkk7+rONC4foGJgVvhs1mI
         3GWcHblLimCDjFzo2OEFsLBrGy105sV4vqj3XgDtQIj5LhXXmCzGmkS5+q91RaaUz2cV
         ndJrZics5osrbyStf+22CbN3eS09gheuoHR+DQHKQ9xbv9GIZhzhrEwaUy8Lhwq5UroV
         jNv/CO209O4A09oSRdYEtDmnSntGLzRBs1RwpdNmoSQ+0x1IJ5g++Kgz5pugqxpl6Vqo
         tsdg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/9] meson64_android: Android boot flow using abootimg
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805172332.GO858@bill-the-cat>
 <fcd676dd-b2b1-c201-8177-5419eae9f00d@baylibre.com>
 <87bl6ak2k6.fsf@baylibre.com> <20210806155629.GZ858@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1f7d09fc-be68-93a8-477b-62bf8eb5ece9@baylibre.com>
Date: Tue, 10 Aug 2021 10:41:24 +0200
MIME-Version: 1.0
In-Reply-To: <20210806155629.GZ858@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/08/2021 17:56, Tom Rini wrote:
> On Fri, Aug 06, 2021 at 05:36:41PM +0200, Mattijs Korpershoek wrote:
>> Hi Neil, Tom,
>>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> On 05/08/2021 19:23, Tom Rini wrote:
>>>> On Thu, Aug 05, 2021 at 05:17:19PM +0200, Mattijs Korpershoek wrote:
>>>>
>>>>> The SEI-610 and SEI-510 boards are well supported in the
>>>>> Android Open Source project via the yukawa [1] platform.
>>>>>
>>>>> Their U-Boot version, despite being public [2] is not in mainline.
>>>>>
>>>>> Android 10 and higher have significantly reworked the bootloader
>>>>> requirements:
>>>>>
>>>>> * bootloader should pass slot information in case of A/B
>>>>> * bootloader should perform AVB verification in case it's supported
>>>>> * bootloader should read and apply dtb overlays from a dtbo partition
>>>>>
>>>>> These series add support for all the above.
>>>>>
>>>>> [1] https://android.googlesource.com/device/amlogic/yukawa
>>>>> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
>>>>
>>>> My high level concern with this series is that it takes what I assume is
>>>> the Android-only boot path, and adds further abstractions to it, it
>>>> looks like.  Can we just say "Here is the Android 10 boot path" (since
>>>> AVB has been around for a while) and here is the generic distro boot
>>>> path for non-Android?  Reading this over it looks like it becomes "Here
>>>> is the Android + AVB boot path", "Here is the Androidd non-AVB boot
>>>> path" and then I assume "Here is the generic distro boot path".
>> Not exactly. Android supports multiple combinations:
>> - non-AVB + no-A/B  (legacy, no security). This is usually used for
>> development builds
>> - AVB + no-A/B
>> - AVB + A/B
>> Here, we should be supporting all of the above using compile flags.
>>>>
>>>> I'd also like to know if in general we can make some generic environment
>>>> macros for "Here is Android AVB boot path", so that we don't need to
>>>> duplicate this between SoCs.  At the very high level, something like the
>>>> generic distro boot framework, but that does Android instead.
>> I agree. It would be really nice if we could have a generic "boot android" framework
>>
>> TI has a ti_omap5_common.h which seems to support similar things.
>> However, it does not support the "no-A/B" mode.
>> In that file, we can also see board specific logic: namely the mapping
>> between the $board_name and the dtbo index passed to "abootimg".
>>
>> Google has another approach via the boot_android[1] command.
> 
> I guess I'm a little disappointed that there was no follow up to the
> question about boot_android.  I would like to see the Android support
> made easier to work with.
> 

We share the same disappointment, the Android boot flow is incredibly hard
to implement and test. And completely changes in incompatible ways between
new releases.

Neil
