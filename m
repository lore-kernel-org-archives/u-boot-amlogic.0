Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web08.4607.1635510089793550505
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 05:21:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1635510085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S1d4mk0zkOB2FCVd9xYH/V650ScDKwsb5YSL7N+hlEU=;
	b=lUMe6buWjEdn2URVV6CtulRdrynCkjHqkx7NnAjMDHkRqgDU1Ikbgm3VpLdTkTFnu4aqjO
	2RwqUeCFWwBMcWym3YgZBZjVuIbwlIRBlbn93iwCtlJWbt34XmINW3KmEPCutcU3BWE5LN
	BJiu8KjkFzxi9SobPgNpNbfsV+RSHgNr8gAN9kgYnBWnPm2J0fAlKfyhju7uRRWEjOnDxA
	sHjfyoXzO6qb/haXDMRV/ahfV+plSaFRxIK/53dThmUPQHO4FmcovwnO87OCEduzzGkpKw
	6Jl6/vdBgh2skVOJAORaez2teGJQ4sT/+5kQKSAYDyVDoffCabyq/tBti0wXsQ==
Message-ID: <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
Date: Fri, 29 Oct 2021 15:21:26 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
References: <20211029070820.3607994-1-adeep@lexina.in>
 <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Thanks.

29.10.2021 15:08, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 29/10/2021 09:08, Vyacheslav Bocharov wrote:
>> JetHome has own MAC OUI. Add jethub-j100 board file. Update config.
>>
>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>> ---
>>   board/amlogic/jethub-j100/MAINTAINERS   |  8 +++++
>>   board/amlogic/jethub-j100/Makefile      |  6 ++++
>>   board/amlogic/jethub-j100/jethub-j100.c | 41 +++++++++++++++++++++++++
>>   board/amlogic/jethub-j80/MAINTAINERS    |  3 +-
>>   configs/jethub_j100_defconfig           |  1 +
>>   5 files changed, 57 insertions(+), 2 deletions(-)
>>   create mode 100644 board/amlogic/jethub-j100/MAINTAINERS
>>   create mode 100644 board/amlogic/jethub-j100/Makefile
>>   create mode 100644 board/amlogic/jethub-j100/jethub-j100.c
>>
>> diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jethu=
b-j100/MAINTAINERS
>> new file mode 100644
>> index 0000000000..43f6a5fc86
>> --- /dev/null
>> +++ b/board/amlogic/jethub-j100/MAINTAINERS
>> @@ -0,0 +1,8 @@
>> +JetHome JetHub
>> +M:	Vyacheslav Bocharov <adeep@lexina.in>
>> +S:	Maintained
>> +L:	u-boot-amlogic@groups.io
>> +F:	board/amlogic/jethub-j100/
>> +F:	configs/jethub_j100_defconfig
>> +F:	doc/board/amlogic/jethub-j100.rst
>> +F:	include/configs/jethub.h
>> diff --git a/board/amlogic/jethub-j100/Makefile b/board/amlogic/jethub-j=
100/Makefile
>> new file mode 100644
>> index 0000000000..4d935af984
>> --- /dev/null
>> +++ b/board/amlogic/jethub-j100/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# (C) Copyright 2021 Vyacheslav Bocharov
>> +# Author: Vyacheslav Bocharov <adeep@lexina.in>
>> +
>> +obj-y	:=3D jethub-j100.o
>> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jet=
hub-j100/jethub-j100.c
>> new file mode 100644
>> index 0000000000..575bb31573
>> --- /dev/null
>> +++ b/board/amlogic/jethub-j100/jethub-j100.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2021 Vyacheslav Bocharov
>> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
>> + */
>> +
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <init.h>
>> +#include <net.h>
>> +#include <asm/io.h>
>> +#include <asm/arch/axg.h>
>> +#include <asm/arch/sm.h>
>> +#include <asm/arch/eth.h>
>> +#include <asm/arch/mem.h>
>> +
>> +int misc_init_r(void)
>> +{
>> +	u8 mac_addr[ARP_HLEN];
>> +	char serial[SM_SERIAL_SIZE];
>> +	u32 sid;
>> +
>> +	if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
>> +		sid =3D crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
>> +		/* Ensure the NIC specific bytes of the mac are not all 0 */
>> +		if ((sid & 0xffff) =3D=3D 0)
>> +			sid |=3D 0x800000;
>> +
>> +		/* OUI registered MAC address */
>> +		mac_addr[0] =3D 0x10;
>> +		mac_addr[1] =3D 0x27;
>> +		mac_addr[2] =3D 0xBE;
>> +		mac_addr[3] =3D (sid >> 16) & 0xff;
>> +		mac_addr[4] =3D (sid >>  8) & 0xff;
>> +		mac_addr[5] =3D (sid >>  0) & 0xff;
>> +
>> +		eth_env_set_enetaddr("ethaddr", mac_addr);
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/board/amlogic/jethub-j80/MAINTAINERS b/board/amlogic/jethub=
-j80/MAINTAINERS
>> index 459e9f89da..a899153117 100644
>> --- a/board/amlogic/jethub-j80/MAINTAINERS
>> +++ b/board/amlogic/jethub-j80/MAINTAINERS
>> @@ -4,6 +4,5 @@ S:	Maintained
>>   L:	u-boot-amlogic@groups.io
>>   F:	board/amlogic/jethub-j80/
>>   F:	configs/jethub_j80_defconfig
>> -F:	configs/jethub_j100_defconfig
>>   F:	doc/board/amlogic/jethub-j80.rst
>> -F:	doc/board/amlogic/jethub-j100.rst
>> +F:	include/configs/jethub.h
>> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconf=
ig
>> index 290ce4db85..ad026a89e0 100644
>> --- a/configs/jethub_j100_defconfig
>> +++ b/configs/jethub_j100_defconfig
>> @@ -1,4 +1,5 @@
>>   CONFIG_ARM=3Dy
>> +CONFIG_SYS_BOARD=3D"jethub-j100"
>>   CONFIG_SYS_CONFIG_NAME=3D"jethub"
>>   CONFIG_ARCH_MESON=3Dy
>>   CONFIG_SYS_TEXT_BASE=3D0x01000000
>>
>=20
> Applied to u-boot-amlogic
>=20
> I will probably send it next week along `add sm efuse write support and c=
md for read/write efuse`
>=20
> Thanks,
> Neil
