Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.9119.1633699686661325952
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Oct 2021 06:28:07 -0700
Received: by mail-wr1-f52.google.com with SMTP id m22so29993415wrb.0
        for <u-boot-amlogic@groups.io>; Fri, 08 Oct 2021 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4aSl3m+nybYDg8b6WiJ6sI2YjFcCmpLGnMXyK4AQDbU=;
        b=XP78pno3O3L+HhzPNH5sd9g+ol8uApReQM2XSTg+e34QFNrYXTnrPGnpiN6J3i3A7k
         7e20SUWCoyESklPR6snI38UgoDCSTWf5m4/ETbiaPXAMldullkIwSlThEbnc82eO4lSJ
         9ihTFMZ5OHDsRvE5SnXpd2st1+V0ZlWPurVBPoARe+yX0W33ufprZTTz0Sd9E8Z3bXpM
         D6+qwVLCf5Cuf/GPMquG1kQfizrCekpZxUe1Vf1KfCynPvdwxkFw69iZoXmO0yjKeDKK
         AQd0Msubst1WNckJ2Qby5TNWky/3DdhUHvhpF1DsbxCquILQzN5YxtBymepyGHm8VMzq
         M4jg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: ARM: amlogic: RFC: meson_sm_get_serial secure call update
References: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
 <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
 <76a3cab3-c5e5-c557-7db6-426ff8f8bf69@lexina.in>
 <c3b0b6b0-3dc3-3cd0-699f-2d9578ad6e0c@baylibre.com>
 <db708076-7e34-8d99-c784-e5993ddaa7bf@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ec3c807e-0c7d-65f0-8649-bde1db7786e8@baylibre.com>
Date: Fri, 8 Oct 2021 15:28:03 +0200
MIME-Version: 1.0
In-Reply-To: <db708076-7e34-8d99-c784-e5993ddaa7bf@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 07/10/2021 16:28, Vyacheslav wrote:
> 07.10.2021 15:48, Neil Armstrong пишет:
>> On 07/10/2021 14:11, Vyacheslav wrote:
>>> 07.10.2021 11:13, Neil Armstrong пишет:
>>>> Hi,
>>>>
>>>> On 05/10/2021 11:35, Vyacheslav wrote:
>>>>> Hi.
>>>>>
>>>>> I am investigating the source code of uboot from amlogic and found differences in the function to get the cpu serial. In amlogic-uboot it looks like this:
>>>>>
>>>>>               int version = *((unsigned int *)sharemem_output_base);
>>>>>
>>>>>               if (version == 2) {
>>>>>                   memcpy(buff, (void *)sharemem_output_base + 4, 16);
>>>>> The current uboot source code uses only the read 12 bytes as cpu serial ignoring the chipID and the existence of a 16-byte version of the serial number.
>>>>>
>>>>> Does it make sense to transfer the code to the uboot project?
>>>>>
>>>> How does it detect when 16 bytes serial is available ?
>>> Call to sm function FN_CHIP_ID returns version number in uint32 at beginning of result (shmem_output var in sm.c):
>>>
>>>> int version = *((unsigned int *)sharemem_output_base);
>>> if version == 2 then serial is next 16 bytes
>>> for version == 1 then serial is next 12 bytes and amlogic suggests using chipid as an additional 4 bytes.
>>>
>>> I have gxl and axg platform, there version is 1. Unfortunately I don't have more recent chipsets at hand to check if they have introduced version 2 on them.
>> Seems to be a very recent addition, I get version 1 on S905Y2 (G12A), A311d (G12B) & S905D3 (SM1).
>>
> I forgot that the argument of amlogic's getchip call was changed to 2. With
> 
> regs.regs[0] = FN_CHIP_ID;
> regs.regs[1] = 2;
> regs.regs[2] = 0;
> 
> I receive version == 2 on axg and gxl.
> 
> For example on gxl (only 96bits checked):
> 
> regs[1]=0
> 02000000: a7795fe3 d8f855af 14c30b56 00000000  ._y..U..V.......
> 
> regs[1]=2
> 02000000: 00a40d21 560bc314 af55f8d8 e35f79a7 .......V..U..y_.
> 
> We have same serial with reversed byte order.

Interesting, but since the current serial based mac generation is based
on the 96bits current serial, adding support for the new 16bytes serial
will change the mac on the boards.

Not sure how to handle that.

Anyway, a patch is welcome to add support for that !

Neil

> 
> Change introduced in 2017 with comment:
> 
>     GX-family chips (e.g. GXB, GXL) supports a 128-bit chip ID.
>     128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
> 
>     BL30 provides a SoC command to obtain the chip ID value.
> 
>     Legacy implementation only returns 96-bit OTP data and requires
>     the construction of the 128-bit by the caller.
> 
>     This change updates the implementation to return the constructed
>     128-bit chip ID while maintain backward compatibility with existing
> 
>     software.
> 
> -- 
> 
> Vyacheslav

