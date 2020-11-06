Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.9383.1604655026789779503
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:30:27 -0800
Received: by mail-wr1-f45.google.com with SMTP id y12so572639wrp.6
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+AZ8A9tX8nWB9MI7S8Oswd7XBTuXa6TmS0bJyeDmUg=;
        b=oI1JuoantjlwHkVW6ujtqvUyVL1OWb4mcKtY3wUuZoskHndUxb7dZLy96fZBtRlvlQ
         JZsk+Uj8e3bg1CpWSXMEsI2OOMvVQdOUs/RLNrhh7VNykjIlG2dO3NKHyzib7Fb6nR8+
         uH3SqMpNgYvhsRNcbuyCTftHpolb/rn3ZAd1WczSsoMOzedyxB7RRuQCs2qx9haViFGs
         XdrfVtRtRJLn66QM2yXVLuFOJAz6XNZtmJTPxwWmXPA+mLKGuOhLcDJyZ2ZA734QDt0l
         y+bp19+0DJgczajmHPqTPadkxe2EYufqoGweyZTs2vSPkMOrysZkntGX+JR+R/dVqPDK
         Z1bA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Fail to reset on Odroid-C4
References: <CGME20201106020946epcas1p3ff6494f0122e9f4c41f81877090df195@epcas1p3.samsung.com>
 <e66e17d2-8115-6d19-68b7-31f2166d6dc3@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <140e6846-4ee3-1099-2198-66d5a4aab9e2@baylibre.com>
Date: Fri, 6 Nov 2020 10:28:13 +0100
MIME-Version: 1.0
In-Reply-To: <e66e17d2-8115-6d19-68b7-31f2166d6dc3@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/11/2020 03:10, Jaehoon Chung wrote:
> Hi,
> 
> I have checked U-boot on Odroid-C4 with v2020.10.
> I found a problem about reset behavior.
> 
> In my environment,
> - Boot to SD-card,
> - built u-boot v2020.10 with ordoid-c4_defconfig
> - Referred to doc/board/amlogic/odroid-c4.rst
> 
> 
> If do "reset" command after run command "mmcinfo", it didn't work anymore.
> - After something to do operation relevant to MMC. (read/write or ls mmc, etc..)
> 
> 
> U-Boot 2020.10-00383-g2f27fb20151b-dirty (Nov 06 2020 - 10:37:09 +0900) odroid-c4
> 
> Model: Hardkernel ODROID-C4
> SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
> DRAM:  3.8 GiB
> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@ff3f0000
> Hit any key to stop autoboot:  0
> Odroid N2>
> Odroid N2>
> Odroid N2>
> Odroid N2>
> Odroid N2>
> Odroid N2> mmcinfo
> Device: sd@ffe05000
> Manufacturer ID: 3
> OEM: 5344
> Name: SB16G
> Bus Speed: 50000000
> Mode: SD High Speed (50MHz)
> Rd Block Len: 512
> SD version 3.0
> High Capacity: Yes
> Capacity: 14.8 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 Bytes
> Odroid N2> reset
> resetting ...
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id:?M1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;

It's a new one !

> 
> 
> I didn't analyze it in more detail. I will do. But it seems that relevant to BL2 binary.
> If nothing to do before reset, it's working fine.

Is this the same with SDCard ?

The SDCard & eMMC regulators doesn't reset to default when resetting, causing issues
with the boot ROM... maybe you'll need to reset the regulators in a reset for the
Odroid C4 board.

> 
> If someone already fixed this or I missed something to do, let me know, plz.

AFAIK no, I just pushed a fix for the eMMC/SDCard clock causing read issues at 50MHz.

Thanks for the patches & reports !

Neil

> 
> Best Regards,
> Jaehoon Chung
> 

