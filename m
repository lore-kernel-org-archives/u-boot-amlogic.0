Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web11.6209.1604628592923443414
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 18:09:54 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201106020950epoutp04e160ff7e1bbb306e34c29aec686bc848~EyTN3Sa_G3250932509epoutp045
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 02:09:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201106020950epoutp04e160ff7e1bbb306e34c29aec686bc848~EyTN3Sa_G3250932509epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604628590;
	bh=y4u0FNg0RBLtv8+A9Uk9phoORl2+8B5Xie/ZI03WNKk=;
	h=From:Subject:To:Cc:Date:References:From;
	b=Ut1W3EESk8nvqU52i7em74GiZju1ai4lJed9K5N8xZTptRqq2fhIfjGzByDRk/iNG
	 P2yUOr88lWVSfHsU2GtSdf0EJgFtxGyrR8/vs4Qj3Hcn1w5Y9aO8+8Ji//4FSpM/lP
	 wq+PjYGcNYKgQRe6bkd7Uanqc4tZJVmYJjR+ygOg=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Fail to reset on Odroid-C4
Message-ID: <e66e17d2-8115-6d19-68b7-31f2166d6dc3@samsung.com>
Date: Fri, 6 Nov 2020 11:10:07 +0900
MIME-Version: 1.0
References: <CGME20201106020946epcas1p3ff6494f0122e9f4c41f81877090df195@epcas1p3.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

I have checked U-boot on Odroid-C4 with v2020.10.
I found a problem about reset behavior.

In my environment,
- Boot to SD-card,
- built u-boot v2020.10 with ordoid-c4_defconfig
- Referred to doc/board/amlogic/odroid-c4.rst


If do "reset" command after run command "mmcinfo", it didn't work anymore.
- After something to do operation relevant to MMC. (read/write or ls mmc, etc..)


U-Boot 2020.10-00383-g2f27fb20151b-dirty (Nov 06 2020 - 10:37:09 +0900) odroid-c4

Model: Hardkernel ODROID-C4
SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
DRAM:  3.8 GiB
MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@ff3f0000
Hit any key to stop autoboot:  0
Odroid N2>
Odroid N2>
Odroid N2>
Odroid N2>
Odroid N2>
Odroid N2> mmcinfo
Device: sd@ffe05000
Manufacturer ID: 3
OEM: 5344
Name: SB16G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 14.8 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
Odroid N2> reset
resetting ...
bl31 reboot reason: 0xd
bl31 reboot reason: 0x0
system cmd  1.
SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
bl2_stage_init 0x01
bl2_stage_init 0x81
hw id:?M1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;


I didn't analyze it in more detail. I will do. But it seems that relevant to BL2 binary.
If nothing to do before reset, it's working fine.

If someone already fixed this or I missed something to do, let me know, plz.

Best Regards,
Jaehoon Chung
