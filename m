Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.1458.1643016384581905729
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Jan 2022 01:26:25 -0800
Received: by mail-wr1-f48.google.com with SMTP id r14so12302582wrp.2
        for <u-boot-amlogic@groups.io>; Mon, 24 Jan 2022 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWjlA8hqiiqL6BLsH/fEBaLGVWYzmO54zmirGjk6w8Y=;
        b=GUt4ud10EmLK+yM0LIDjqsBz6xEpz0pyieeQ/onFC97qmR48RrzEc02O4kSTv82XqP
         sJZTjepq6WiyJJcA1m9ajGcXZOGhiYe07OfeFv43Tk3vB94SIml5iLHm/SD/pLt3i6v7
         FPRF1r5L4acSJX0tl+P1XGGdHGF6AiuhsclGjeyfZtFcSnpG/n5eAmXv4LIgqU5/IoeS
         HKty/DWCKO6bV66GUH9VWXB0lEHX5McNbBipmIKgJUXQNk4U9Sm6LDz8vdOLst84lwS1
         91I42XFDWGaJpIZA/AO2AnP5eBgiZg5E1l3cqBR6ewjQIXrRHkZ2LUX5gL8EXdi23I2o
         baOQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] image-board: fix wrong implementation ram disk address setup from cmdline
References: <20211125030859.2896352-1-art@khadas.com>
 <20220117194708.GA2657591@bill-the-cat>
 <CAKaHn9JSvM2S2DzjfdruhN56w8zf72udCdR-2QoQfKN4PHfhdg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1125d75f-7bba-37da-d9e0-7e562c766915@baylibre.com>
Date: Mon, 24 Jan 2022 10:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAKaHn9JSvM2S2DzjfdruhN56w8zf72udCdR-2QoQfKN4PHfhdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Art Nikpal <email2tema@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 23/01/2022 04:32, Art Nikpal wrote:
> On Tue, Jan 18, 2022 at 3:47 AM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Nov 25, 2021 at 11:08:59AM +0800, Artem Lapkin wrote:
>>
>>> Problem
>>>
>>> Wrong implementation logic: ramdisk cmdline image address always ignored!
>>> Next block { rd_addr = hextoul(select, NULL) } unusable for raw initrd.
>>>
>>> We have unbootable raw initrd images because, select_ramdisk for raw
>>> initrd images ignore submited select addr and setup rd_datap value to 0
>>>
>>> Signed-off-by: Artem Lapkin <art@khadas.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>> V2 changes
>>> _ rebase to master
>>> _ from https://patchwork.ozlabs.org/project/uboot/patch/20211016051915.4157293-1-art@khadas.com/
>>> ---
>>>  boot/image-board.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/boot/image-board.c b/boot/image-board.c
>>> index bf8817165c..87a8f07432 100644
>>> --- a/boot/image-board.c
>>> +++ b/boot/image-board.c
>>> @@ -334,7 +334,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
>>>
>>>       if (select) {
>>>               ulong default_addr;
>>> -             bool done = true;
>>> +             bool done = false;
>>>
>>>               if (CONFIG_IS_ENABLED(FIT)) {
>>>                       /*
>>> @@ -352,13 +352,13 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
>>>                                          &fit_uname_config)) {
>>>                               debug("*  ramdisk: config '%s' from image at 0x%08lx\n",
>>>                                     fit_uname_config, rd_addr);
>>> +                             done = true;
>>>                       } else if (fit_parse_subimage(select, default_addr,
>>>                                                     &rd_addr,
>>>                                                     &fit_uname_ramdisk)) {
>>>                               debug("*  ramdisk: subimage '%s' from image at 0x%08lx\n",
>>>                                     fit_uname_ramdisk, rd_addr);
>>> -                     } else {
>>> -                             done = false;
>>> +                             done = true;
>>>                       }
>>>               }
>>>               if (!done) {
>>
>> I think we still need this?  Can you please confirm and if so rebase to
>> master again, sorry, thanks!
> 
> i have check master which have new commit
> 621158d106fe53fbb2d786d9d19dff44ad1baf91
> 
> no need for this state !!
> 
> Author: Tom Rini <trini@konsulko.com>
> Date:   Mon Dec 20 09:36:32 2021 -0500
> 
>     Revert "image: Remove #ifdefs from select_ramdisk()"
> 
>     This reverts commit f33a2c1bd0fb371511a485cac1f182ba50db51be.
> 
>     This causes a crash on some platforms as seen here:
>     https://lore.kernel.org/r/f153017b-c41a-0d32-67b9-f288e695f900@baylibre.com/
> 
>     Reported-by: Neil Armstrong <narmstrong@baylibre.com>
>     Signed-off-by: Tom Rini <trini@konsulko.com>
> 
> PS: about crash problem maybe its same reason may be need try apply my
> patch and no need reverts commit
> f33a2c1bd0fb371511a485cac1f182ba50db51be.

Indeed, I missed this fix completely... anyway having a functional release was the most important at that time.

Re-sending "image: Remove #ifdefs from select_ramdisk()" with this fix squashed would be the time now.

Neil

>>
>> --
>> Tom

