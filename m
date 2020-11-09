Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web11.8737.1604911012950098334
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 00:36:54 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201109083650epoutp01a8bf611eefb43f7621fd1d381117349e~Fyg999_gr2730727307epoutp01V
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 08:36:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201109083650epoutp01a8bf611eefb43f7621fd1d381117349e~Fyg999_gr2730727307epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604911010;
	bh=RQ/MVCmWoww0MR81hBCNQ/QMJ9dDnxB3z06usDpm0tY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=sEyX7WBL5srsoyM+jD1Y8+RRDjReRdGMPlh4aE8rDKZlf0/m+ET2JdnptZnjbSUfe
	 MvFvhQ+wNOnCPXdm13Chj3vx0EuLZdvBmctBhfIp41rrQrJ6FHLOOyBkkg4XFc/EBJ
	 4J7abi6+Kl8updsa4tp3n1gLnLe3w2fP2KkKQqLg=
Subject: Re: Fail to reset on Odroid-C4
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <cfd25be7-4fca-93d2-531a-911069eb532f@samsung.com>
Date: Mon, 9 Nov 2020 17:37:04 +0900
MIME-Version: 1.0
In-Reply-To: <e176f941-25fa-4721-e8c8-62f25a904fa8@baylibre.com>
References: <CGME20201106020946epcas1p3ff6494f0122e9f4c41f81877090df195@epcas1p3.samsung.com>
	<e66e17d2-8115-6d19-68b7-31f2166d6dc3@samsung.com>
	<140e6846-4ee3-1099-2198-66d5a4aab9e2@baylibre.com>
	<57e4b34e-76f6-7b04-6f1b-734e4611f6f9@samsung.com>
	<e176f941-25fa-4721-e8c8-62f25a904fa8@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/6/20 7:01 PM, Neil Armstrong wrote:
> On 06/11/2020 10:59, Jaehoon Chung wrote:
>> Hi,
>>
>> On 11/6/20 6:28 PM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 06/11/2020 03:10, Jaehoon Chung wrote:
>>>> Hi,
>>>>
>>>> I have checked U-boot on Odroid-C4 with v2020.10.
>>>> I found a problem about reset behavior.
>>>>
>>>> In my environment,
>>>> - Boot to SD-card,
>>>> - built u-boot v2020.10 with ordoid-c4_defconfig
>>>> - Referred to doc/board/amlogic/odroid-c4.rst
>>>>
>>>>
>>>> If do "reset" command after run command "mmcinfo", it didn't work anymore.
>>>> - After something to do operation relevant to MMC. (read/write or ls mmc, etc..)
>>>>
>>>>
>>>> U-Boot 2020.10-00383-g2f27fb20151b-dirty (Nov 06 2020 - 10:37:09 +0900) odroid-c4
>>>>
>>>> Model: Hardkernel ODROID-C4
>>>> SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
>>>> DRAM:  3.8 GiB
>>>> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
>>>> In:    serial
>>>> Out:   serial
>>>> Err:   serial
>>>> Net:   eth0: ethernet@ff3f0000
>>>> Hit any key to stop autoboot:  0
>>>> Odroid N2>
>>>> Odroid N2>
>>>> Odroid N2>
>>>> Odroid N2>
>>>> Odroid N2>
>>>> Odroid N2> mmcinfo
>>>> Device: sd@ffe05000
>>>> Manufacturer ID: 3
>>>> OEM: 5344
>>>> Name: SB16G
>>>> Bus Speed: 50000000
>>>> Mode: SD High Speed (50MHz)
>>>> Rd Block Len: 512
>>>> SD version 3.0
>>>> High Capacity: Yes
>>>> Capacity: 14.8 GiB
>>>> Bus Width: 4-bit
>>>> Erase Group Size: 512 Bytes
>>>> Odroid N2> reset
>>>> resetting ...
>>>> bl31 reboot reason: 0xd
>>>> bl31 reboot reason: 0x0
>>>> system cmd  1.
>>>> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
>>>> bl2_stage_init 0x01
>>>> bl2_stage_init 0x81
>>>> hw id:?M1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;
>>>
>>> It's a new one !
>>>
>>>>
>>>>
>>>> I didn't analyze it in more detail. I will do. But it seems that relevant to BL2 binary.
>>>> If nothing to do before reset, it's working fine.
>>>
>>> Is this the same with SDCard ?
>>
>> Yes. I had tested with same SD-card. (I can't test with eMMC, because eMMC doesn't initialize.)
>>
>> 1) After boot, reset -> fine
>> 2) After boot, run some mmc operation -> reset -> fail.
>>
>>
>>>
>>> The SDCard & eMMC regulators doesn't reset to default when resetting, causing issues
>>> with the boot ROM... maybe you'll need to reset the regulators in a reset for the
>>> Odroid C4 board.
>>
>> Actually, i hope that it works fine after building mainline u-boot with odroid-c4_defconfig.
>> Because it seems that supports Odroid-c4. But it doesn't work well. :(
>>
>> For checking, i'm using with u-boot-amlogic with 2021.01-rc1
>>
>> But eMMC doesn't work..
>> I'm analyzing this problem..it doesn't work higher mode than 26MHz speed mode.
>> How did you check for eMMC card? I will fix it but i don't have any information about meson_gx_mmc.
> 
> I did my test on the Khadas VIM3L, but we have the exact same issues on the SEI610, VIM3L and now C4 boards.
> 
>>
>> If i find how to fix it, i will send patch.
>>
>>
>>>
>>>>
>>>> If someone already fixed this or I missed something to do, let me know, plz.
>>>
>>> AFAIK no, I just pushed a fix for the eMMC/SDCard clock causing read issues at 50MHz.
>>
>> Is it relevant to IO error (-5)?
> 
> Yes, over 26MHz the eMMC fails, the clock management is in cause and needs to be
> reworked, but this fix should be fine.

This issue is fixed after applied my patch. Also "reset" is working fine.

https://patchwork.ozlabs.org/project/uboot/patch/20201109031233.25320-1-jh80.chung@samsung.com/

Best Regards,
Jaehoon Chung

> 
> Neil
> 
>>
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Thanks for the patches & reports !
>>>
>>> Neil
>>>
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>
>>>
>>
> 
> 

