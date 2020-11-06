Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.9804.1604657015662007907
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:03:36 -0800
Received: by mail-wr1-f48.google.com with SMTP id c17so664197wrc.11
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xW4Zqqt3Td2YtSfHc806Ds/jHG4Atmqr0B+Vsielc4=;
        b=M6IOeUWN9Eszstv2TxKjzm5/hsHoPnZiaV/ejeSHrOBaSdwKDjykrSAmz/w5UiGsJe
         rybLOjN9W5UimI+p8fUgpLWtl+uNlTcSTPXdy/rwqGFEc1DlL7KlGZX2EWjX5sC73/Yi
         3OCSwnHY+jJnfsN1ZeKI/FgzCXaFkkAPpYcnuOIV5W/XSOZzoX2rwEDN9Hvuc+OoLf4T
         it1uJfLMY78Y7TzNPqIc/DoT3Vvu7qQ6YMQvCMRmZld0ZmpjKsVWEjcjMwVo2RbPDZ6T
         KqF0BPTFpNjDCdzEPHSC7RauymlkGUI19YMaQ7hNb0a8p1dhYjIo3N0XXTVxE7kSppPi
         vboA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Fail to reset on Odroid-C4
References: <CGME20201106020946epcas1p3ff6494f0122e9f4c41f81877090df195@epcas1p3.samsung.com>
 <e66e17d2-8115-6d19-68b7-31f2166d6dc3@samsung.com>
 <140e6846-4ee3-1099-2198-66d5a4aab9e2@baylibre.com>
 <57e4b34e-76f6-7b04-6f1b-734e4611f6f9@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e176f941-25fa-4721-e8c8-62f25a904fa8@baylibre.com>
Date: Fri, 6 Nov 2020 11:01:21 +0100
MIME-Version: 1.0
In-Reply-To: <57e4b34e-76f6-7b04-6f1b-734e4611f6f9@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 10:59, Jaehoon Chung wrote:
> Hi,
> 
> On 11/6/20 6:28 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 06/11/2020 03:10, Jaehoon Chung wrote:
>>> Hi,
>>>
>>> I have checked U-boot on Odroid-C4 with v2020.10.
>>> I found a problem about reset behavior.
>>>
>>> In my environment,
>>> - Boot to SD-card,
>>> - built u-boot v2020.10 with ordoid-c4_defconfig
>>> - Referred to doc/board/amlogic/odroid-c4.rst
>>>
>>>
>>> If do "reset" command after run command "mmcinfo", it didn't work anymore.
>>> - After something to do operation relevant to MMC. (read/write or ls mmc, etc..)
>>>
>>>
>>> U-Boot 2020.10-00383-g2f27fb20151b-dirty (Nov 06 2020 - 10:37:09 +0900) odroid-c4
>>>
>>> Model: Hardkernel ODROID-C4
>>> SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
>>> DRAM:  3.8 GiB
>>> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
>>> In:    serial
>>> Out:   serial
>>> Err:   serial
>>> Net:   eth0: ethernet@ff3f0000
>>> Hit any key to stop autoboot:  0
>>> Odroid N2>
>>> Odroid N2>
>>> Odroid N2>
>>> Odroid N2>
>>> Odroid N2>
>>> Odroid N2> mmcinfo
>>> Device: sd@ffe05000
>>> Manufacturer ID: 3
>>> OEM: 5344
>>> Name: SB16G
>>> Bus Speed: 50000000
>>> Mode: SD High Speed (50MHz)
>>> Rd Block Len: 512
>>> SD version 3.0
>>> High Capacity: Yes
>>> Capacity: 14.8 GiB
>>> Bus Width: 4-bit
>>> Erase Group Size: 512 Bytes
>>> Odroid N2> reset
>>> resetting ...
>>> bl31 reboot reason: 0xd
>>> bl31 reboot reason: 0x0
>>> system cmd  1.
>>> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
>>> bl2_stage_init 0x01
>>> bl2_stage_init 0x81
>>> hw id:?M1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;
>>
>> It's a new one !
>>
>>>
>>>
>>> I didn't analyze it in more detail. I will do. But it seems that relevant to BL2 binary.
>>> If nothing to do before reset, it's working fine.
>>
>> Is this the same with SDCard ?
> 
> Yes. I had tested with same SD-card. (I can't test with eMMC, because eMMC doesn't initialize.)
> 
> 1) After boot, reset -> fine
> 2) After boot, run some mmc operation -> reset -> fail.
> 
> 
>>
>> The SDCard & eMMC regulators doesn't reset to default when resetting, causing issues
>> with the boot ROM... maybe you'll need to reset the regulators in a reset for the
>> Odroid C4 board.
> 
> Actually, i hope that it works fine after building mainline u-boot with odroid-c4_defconfig.
> Because it seems that supports Odroid-c4. But it doesn't work well. :(
> 
> For checking, i'm using with u-boot-amlogic with 2021.01-rc1
> 
> But eMMC doesn't work..
> I'm analyzing this problem..it doesn't work higher mode than 26MHz speed mode.
> How did you check for eMMC card? I will fix it but i don't have any information about meson_gx_mmc.

I did my test on the Khadas VIM3L, but we have the exact same issues on the SEI610, VIM3L and now C4 boards.

> 
> If i find how to fix it, i will send patch.
> 
> 
>>
>>>
>>> If someone already fixed this or I missed something to do, let me know, plz.
>>
>> AFAIK no, I just pushed a fix for the eMMC/SDCard clock causing read issues at 50MHz.
> 
> Is it relevant to IO error (-5)?

Yes, over 26MHz the eMMC fails, the clock management is in cause and needs to be
reworked, but this fix should be fine.

Neil

> 
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Thanks for the patches & reports !
>>
>> Neil
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>
>>
> 

