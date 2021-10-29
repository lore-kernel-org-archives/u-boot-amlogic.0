Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.5501.1635515587873429938
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 06:53:08 -0700
Received: by mail-wm1-f49.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso12563326wmd.3
        for <u-boot-amlogic@groups.io>; Fri, 29 Oct 2021 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYFXDKu/Ee/ZUNT6heCB1seMtsB7x4EGrZpFnGpdEno=;
        b=monlwjWdqJbAsF95TnhHSOYTB0ExDvge+qe3aCIV3/N/RyQ0TBxal3z2EtlVcwgS9r
         w7A8wMNqdpGfqx4tN/xDVlQ0eLrCkU8ZOjWoOcMW9Ci2dVBrhG4lACB8jSNubq0qBFZE
         8gJrz6WDY0L9eeLGk7KxcgDxFadb31iISsSTBfdGn2AusKgJGGG0h42utR8gTD3hGwtP
         NV2tXb0q5HOekhrmMAEtZKBF1/5IMe46TeFunvBSXC6zBsnI8lk7JCjVLsHpxxsz7mBo
         N8eIn5+Rn+XSd2n4i8J9DvxX9RnefhpPepcONaQdMoJ7sfEaVZZLPUKmeQZtT3M6VS1Y
         vkFw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
References: <20211029070820.3607994-1-adeep@lexina.in>
 <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
 <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
Date: Fri, 29 Oct 2021 15:53:02 +0200
MIME-Version: 1.0
In-Reply-To: <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Ci fails with :

+board/amlogic/jethub-j100/jethub-j100.c: In function 'misc_init_r':
1516+board/amlogic/jethub-j100/jethub-j100.c:24:23: error: implicit declaration of function 'crc32' [-Werror=implicit-function-declaration]
1517+   24 |                 sid = crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
1518+      |

Can you send a fix I can squash on the commit ?

Neil

On 29/10/2021 14:21, Vyacheslav wrote:
> Thanks.
> 
> 29.10.2021 15:08, Neil Armstrong пишет:
>> On 29/10/2021 09:08, Vyacheslav Bocharov wrote:
>>> JetHome has own MAC OUI. Add jethub-j100 board file. Update config.
>>>
>>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>>> ---
>>>   board/amlogic/jethub-j100/MAINTAINERS   |  8 +++++
>>>   board/amlogic/jethub-j100/Makefile      |  6 ++++
>>>   board/amlogic/jethub-j100/jethub-j100.c | 41 +++++++++++++++++++++++++
>>>   board/amlogic/jethub-j80/MAINTAINERS    |  3 +-
>>>   configs/jethub_j100_defconfig           |  1 +
>>>   5 files changed, 57 insertions(+), 2 deletions(-)
>>>   create mode 100644 board/amlogic/jethub-j100/MAINTAINERS
>>>   create mode 100644 board/amlogic/jethub-j100/Makefile
>>>   create mode 100644 board/amlogic/jethub-j100/jethub-j100.c
>>>
>>> diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jethub-j100/MAINTAINERS
>>> new file mode 100644
>>> index 0000000000..43f6a5fc86
>>> --- /dev/null
>>> +++ b/board/amlogic/jethub-j100/MAINTAINERS
>>> @@ -0,0 +1,8 @@
>>> +JetHome JetHub
>>> +M:    Vyacheslav Bocharov <adeep@lexina.in>
>>> +S:    Maintained
>>> +L:    u-boot-amlogic@groups.io
>>> +F:    board/amlogic/jethub-j100/
>>> +F:    configs/jethub_j100_defconfig
>>> +F:    doc/board/amlogic/jethub-j100.rst
>>> +F:    include/configs/jethub.h
>>> diff --git a/board/amlogic/jethub-j100/Makefile b/board/amlogic/jethub-j100/Makefile
>>> new file mode 100644
>>> index 0000000000..4d935af984
>>> --- /dev/null
>>> +++ b/board/amlogic/jethub-j100/Makefile
>>> @@ -0,0 +1,6 @@
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +#
>>> +# (C) Copyright 2021 Vyacheslav Bocharov
>>> +# Author: Vyacheslav Bocharov <adeep@lexina.in>
>>> +
>>> +obj-y    := jethub-j100.o
>>> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
>>> new file mode 100644
>>> index 0000000000..575bb31573
>>> --- /dev/null
>>> +++ b/board/amlogic/jethub-j100/jethub-j100.c
>>> @@ -0,0 +1,41 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2021 Vyacheslav Bocharov
>>> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
>>> + */
>>> +
>>> +#include <common.h>
>>> +#include <dm.h>
>>> +#include <init.h>
>>> +#include <net.h>
>>> +#include <asm/io.h>
>>> +#include <asm/arch/axg.h>
>>> +#include <asm/arch/sm.h>
>>> +#include <asm/arch/eth.h>
>>> +#include <asm/arch/mem.h>
>>> +
>>> +int misc_init_r(void)
>>> +{
>>> +    u8 mac_addr[ARP_HLEN];
>>> +    char serial[SM_SERIAL_SIZE];
>>> +    u32 sid;
>>> +
>>> +    if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
>>> +        sid = crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
>>> +        /* Ensure the NIC specific bytes of the mac are not all 0 */
>>> +        if ((sid & 0xffff) == 0)
>>> +            sid |= 0x800000;
>>> +
>>> +        /* OUI registered MAC address */
>>> +        mac_addr[0] = 0x10;
>>> +        mac_addr[1] = 0x27;
>>> +        mac_addr[2] = 0xBE;
>>> +        mac_addr[3] = (sid >> 16) & 0xff;
>>> +        mac_addr[4] = (sid >>  8) & 0xff;
>>> +        mac_addr[5] = (sid >>  0) & 0xff;
>>> +
>>> +        eth_env_set_enetaddr("ethaddr", mac_addr);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/board/amlogic/jethub-j80/MAINTAINERS b/board/amlogic/jethub-j80/MAINTAINERS
>>> index 459e9f89da..a899153117 100644
>>> --- a/board/amlogic/jethub-j80/MAINTAINERS
>>> +++ b/board/amlogic/jethub-j80/MAINTAINERS
>>> @@ -4,6 +4,5 @@ S:    Maintained
>>>   L:    u-boot-amlogic@groups.io
>>>   F:    board/amlogic/jethub-j80/
>>>   F:    configs/jethub_j80_defconfig
>>> -F:    configs/jethub_j100_defconfig
>>>   F:    doc/board/amlogic/jethub-j80.rst
>>> -F:    doc/board/amlogic/jethub-j100.rst
>>> +F:    include/configs/jethub.h
>>> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
>>> index 290ce4db85..ad026a89e0 100644
>>> --- a/configs/jethub_j100_defconfig
>>> +++ b/configs/jethub_j100_defconfig
>>> @@ -1,4 +1,5 @@
>>>   CONFIG_ARM=y
>>> +CONFIG_SYS_BOARD="jethub-j100"
>>>   CONFIG_SYS_CONFIG_NAME="jethub"
>>>   CONFIG_ARCH_MESON=y
>>>   CONFIG_SYS_TEXT_BASE=0x01000000
>>>
>>
>> Applied to u-boot-amlogic
>>
>> I will probably send it next week along `add sm efuse write support and cmd for read/write efuse`
>>
>> Thanks,
>> Neil

