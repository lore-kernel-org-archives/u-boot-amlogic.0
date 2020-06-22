Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.17039.1592831199233712393
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Jun 2020 06:06:40 -0700
Received: by mail-wr1-f67.google.com with SMTP id z13so4849184wrw.5
        for <u-boot-amlogic@groups.io>; Mon, 22 Jun 2020 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMlf6kAvr4lsPhY1mO1npxXwERkCz3df7zUKEGFXfTI=;
        b=KeV30feDVRuIlnFWH07msi+e3CxqPEL5TwHPQ1aYLEMEcPPflGFK8hZaYagwumlTwc
         o1LpykQZXi8MKTY8ZTcmH6z1qMJTQZT7nw+q9A4vrNBo7ZLU7lQgMMZc8Si95w3C+Rm9
         GJEifMVPEyqoIbQSjfUSUqfCyX/7WJqPHc+ZjxPb2DruKWUFxKBoxnkPYX9imfEop2Tn
         7SYzMNjmM+ziLSnU5WG18mUO6mIuqje4wv4uQriectab6Fd00fAuZk0yfPwHwM7N0+x1
         tDiDWnmuvigizPu8HzHWxvGyM4zTcDb56gfd3UzJPVf3vXpW55SO9IWQs1inxqqXQwIs
         azRQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: Add Odroid-N2 board support
References: <20200618144037.23392-1-narmstrong@baylibre.com>
 <CANAwSgR2whQUUHWUze8Jy8yE3frrtMxt_u=kyQRNrgDZ4wMsHA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c22bb120-62f6-c53c-7ba1-fef713708efc@baylibre.com>
Date: Mon, 22 Jun 2020 15:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <CANAwSgR2whQUUHWUze8Jy8yE3frrtMxt_u=kyQRNrgDZ4wMsHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Pascal Vizeli <pvizeli@syshack.ch>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 21/06/2020 19:23, Anand Moon wrote:
> Hi Neil,
> 
> On Thu, 18 Jun 2020 at 20:11, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Pascal Vizeli <pvizeli@syshack.ch>
>>
>> Add a proper Odroid-N2 board support to handle the Ethernet MAC
>> address stored in the in-SoC eFuses.
>>
> 
> This feature need to be implemented for all Amlogic SoC boards,
> since many boards link libretech-cc also generate random mac address
> for ethernet.

In fact, AFAIK only HardKernel stores the MAC in the fuses, now Amlogic stores
the MAC in the eMMC custom partitions, but they did for GXBB and previous SoCs.
Earlier I introduced meson_generate_serial_ethaddr() for GXL and later (not GXBB),
to generate an unique MAC address from the SoC serial.

Neil

> 
> Please add my: Tested on N2.
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> 
> -Anand
> 
>> Signed-off-by: Pascal Vizeli <pvizeli@syshack.ch>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  board/amlogic/odroid-n2/MAINTAINERS |  7 +++++
>>  board/amlogic/odroid-n2/Makefile    |  6 ++++
>>  board/amlogic/odroid-n2/odroid-n2.c | 49 +++++++++++++++++++++++++++++
>>  board/amlogic/w400/MAINTAINERS      |  2 --
>>  configs/odroid-n2_defconfig         |  2 +-
>>  5 files changed, 63 insertions(+), 3 deletions(-)
>>  create mode 100644 board/amlogic/odroid-n2/MAINTAINERS
>>  create mode 100644 board/amlogic/odroid-n2/Makefile
>>  create mode 100644 board/amlogic/odroid-n2/odroid-n2.c
>>
>> diff --git a/board/amlogic/odroid-n2/MAINTAINERS b/board/amlogic/odroid-n2/MAINTAINERS
>> new file mode 100644
>> index 0000000000..5627e54058
>> --- /dev/null
>> +++ b/board/amlogic/odroid-n2/MAINTAINERS
>> @@ -0,0 +1,7 @@
>> +ODROID-N2
>> +M:     Neil Armstrong <narmstrong@baylibre.com>
>> +S:     Maintained
>> +L:     u-boot-amlogic@groups.io
>> +F:     board/amlogic/odroid-n2/
>> +F:     configs/odroid-n2_defconfig
>> +F:     doc/board/amlogic/odroid-n2.rst
>> diff --git a/board/amlogic/odroid-n2/Makefile b/board/amlogic/odroid-n2/Makefile
>> new file mode 100644
>> index 0000000000..68e4e2a828
>> --- /dev/null
>> +++ b/board/amlogic/odroid-n2/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# (C) Copyright 2020 BayLibre, SAS
>> +# Author: Neil Armstrong <narmstrong@baylibre.com>
>> +
>> +obj-y  := odroid-n2.o
>> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
>> new file mode 100644
>> index 0000000000..caf7fd6810
>> --- /dev/null
>> +++ b/board/amlogic/odroid-n2/odroid-n2.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2020 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <env.h>
>> +#include <init.h>
>> +#include <net.h>
>> +#include <asm/io.h>
>> +#include <asm/arch/sm.h>
>> +#include <asm/arch/eth.h>
>> +
>> +#define EFUSE_MAC_OFFSET       20
>> +#define EFUSE_MAC_SIZE         12
>> +#define MAC_ADDR_LEN           6
>> +
>> +int misc_init_r(void)
>> +{
>> +       u8 mac_addr[MAC_ADDR_LEN];
>> +       char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>> +       ssize_t len;
>> +
>> +       meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>> +
>> +       if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>> +               len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>> +                                         efuse_mac_addr, EFUSE_MAC_SIZE);
>> +               if (len != EFUSE_MAC_SIZE)
>> +                       return 0;
>> +
>> +               /* MAC is stored in ASCII format, 1bytes = 2characters */
>> +               for (int i = 0; i < 6; i++) {
>> +                       tmp[0] = efuse_mac_addr[i * 2];
>> +                       tmp[1] = efuse_mac_addr[i * 2 + 1];
>> +                       tmp[2] = '\0';
>> +                       mac_addr[i] = simple_strtoul(tmp, NULL, 16);
>> +               }
>> +
>> +               if (is_valid_ethaddr(mac_addr))
>> +                       eth_env_set_enetaddr("ethaddr", mac_addr);
>> +               else
>> +                       meson_generate_serial_ethaddr();
>> +       }
>> +
>> +       return 0;
>> +}
>> diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
>> index 5e837cfaef..a1b0ac8636 100644
>> --- a/board/amlogic/w400/MAINTAINERS
>> +++ b/board/amlogic/w400/MAINTAINERS
>> @@ -5,8 +5,6 @@ L:      u-boot-amlogic@groups.io
>>  F:     board/amlogic/w400/
>>  F:     configs/khadas-vim3_defconfig
>>  F:     configs/khadas-vim3l_defconfig
>> -F:     configs/odroid-n2_defconfig
>>  F:     doc/board/amlogic/w400.rst
>>  F:     doc/board/amlogic/khadas-vim3.rst
>>  F:     doc/board/amlogic/khadas-vim3l.rst
>> -F:     doc/board/amlogic/odroid-n2.rst
>> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
>> index e0cc6e3729..063809416e 100644
>> --- a/configs/odroid-n2_defconfig
>> +++ b/configs/odroid-n2_defconfig
>> @@ -1,5 +1,5 @@
>>  CONFIG_ARM=y
>> -CONFIG_SYS_BOARD="w400"
>> +CONFIG_SYS_BOARD="odroid-n2"
>>  CONFIG_ARCH_MESON=y
>>  CONFIG_SYS_TEXT_BASE=0x01000000
>>  CONFIG_ENV_SIZE=0x2000
>> --
>> 2.22.0
>>

