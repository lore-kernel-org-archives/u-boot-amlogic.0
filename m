Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web10.6618.1635519651087835920
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 08:00:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1635519646; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MoqGfh/w4cZ6rUVaigwn4rCQ8e27oAeM6VM13cV2wiw=;
	b=c8v8yElhhJVJ9oUMykxzGZeLEHxQWnLOuL5TUpLNKOmo8QtewARm19QHMgBjcEtM5p/4ul
	B6d9yFA15y+Fr5dKui2GEuQgZdeMyffPfTL+UDnDFzWWUcN/l4TbexC/ItA5fvZePI8lOH
	AiUxOH1KbgcVyZiXw1bMS8n1lTwda8cHqmznyOJa7XddbIl8On2huci/wdjEw84D+oLLMP
	Tz2BBPJi9hrkP2lUakZPhjdPw1ZBqU3luTvri1jDtK0poHtWTIWoDws1P13Zx2qLP1hfP4
	mtgTZ0zMrk6FlGQ1v1Pd7F44DEx/DdPCoNtKd1qE8uSy5vv/SJ11OyjU0XCrew==
Message-ID: <4f332887-6694-149b-6bef-86bd48278452@lexina.in>
Date: Fri, 29 Oct 2021 18:00:43 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
References: <20211029070820.3607994-1-adeep@lexina.in>
 <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
 <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
 <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Fixed my build to use -Werror :)
Thanks.

29.10.2021 16:53, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>=20
> Ci fails with :
>=20
> +board/amlogic/jethub-j100/jethub-j100.c: In function 'misc_init_r':
> 1516+board/amlogic/jethub-j100/jethub-j100.c:24:23: error: implicit decla=
ration of function 'crc32' [-Werror=3Dimplicit-function-declaration]
> 1517+   24 |                 sid =3D crc32(0, (unsigned char *)serial, SM=
_SERIAL_SIZE);
> 1518+      |
>=20
> Can you send a fix I can squash on the commit ?
>=20
> Neil
>=20
> On 29/10/2021 14:21, Vyacheslav wrote:
>> Thanks.
>>
>> 29.10.2021 15:08, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On 29/10/2021 09:08, Vyacheslav Bocharov wrote:
>>>> JetHome has own MAC OUI. Add jethub-j100 board file. Update config.
>>>>
>>>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>>>> ---
>>>>  =C2=A0 board/amlogic/jethub-j100/MAINTAINERS=C2=A0=C2=A0 |=C2=A0 8 ++=
+++
>>>>  =C2=A0 board/amlogic/jethub-j100/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++
>>>>  =C2=A0 board/amlogic/jethub-j100/jethub-j100.c | 41 +++++++++++++++++=
++++++++
>>>>  =C2=A0 board/amlogic/jethub-j80/MAINTAINERS=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 +-
>>>>  =C2=A0 configs/jethub_j100_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>  =C2=A0 5 files changed, 57 insertions(+), 2 deletions(-)
>>>>  =C2=A0 create mode 100644 board/amlogic/jethub-j100/MAINTAINERS
>>>>  =C2=A0 create mode 100644 board/amlogic/jethub-j100/Makefile
>>>>  =C2=A0 create mode 100644 board/amlogic/jethub-j100/jethub-j100.c
>>>>
>>>> diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jet=
hub-j100/MAINTAINERS
>>>> new file mode 100644
>>>> index 0000000000..43f6a5fc86
>>>> --- /dev/null
>>>> +++ b/board/amlogic/jethub-j100/MAINTAINERS
>>>> @@ -0,0 +1,8 @@
>>>> +JetHome JetHub
>>>> +M:=C2=A0=C2=A0=C2=A0 Vyacheslav Bocharov <adeep@lexina.in>
>>>> +S:=C2=A0=C2=A0=C2=A0 Maintained
>>>> +L:=C2=A0=C2=A0=C2=A0 u-boot-amlogic@groups.io
>>>> +F:=C2=A0=C2=A0=C2=A0 board/amlogic/jethub-j100/
>>>> +F:=C2=A0=C2=A0=C2=A0 configs/jethub_j100_defconfig
>>>> +F:=C2=A0=C2=A0=C2=A0 doc/board/amlogic/jethub-j100.rst
>>>> +F:=C2=A0=C2=A0=C2=A0 include/configs/jethub.h
>>>> diff --git a/board/amlogic/jethub-j100/Makefile b/board/amlogic/jethub=
-j100/Makefile
>>>> new file mode 100644
>>>> index 0000000000..4d935af984
>>>> --- /dev/null
>>>> +++ b/board/amlogic/jethub-j100/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>> +#
>>>> +# (C) Copyright 2021 Vyacheslav Bocharov
>>>> +# Author: Vyacheslav Bocharov <adeep@lexina.in>
>>>> +
>>>> +obj-y=C2=A0=C2=A0=C2=A0 :=3D jethub-j100.o
>>>> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/j=
ethub-j100/jethub-j100.c
>>>> new file mode 100644
>>>> index 0000000000..575bb31573
>>>> --- /dev/null
>>>> +++ b/board/amlogic/jethub-j100/jethub-j100.c
>>>> @@ -0,0 +1,41 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2021 Vyacheslav Bocharov
>>>> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
>>>> + */
>>>> +
>>>> +#include <common.h>
>>>> +#include <dm.h>
>>>> +#include <init.h>
>>>> +#include <net.h>
>>>> +#include <asm/io.h>
>>>> +#include <asm/arch/axg.h>
>>>> +#include <asm/arch/sm.h>
>>>> +#include <asm/arch/eth.h>
>>>> +#include <asm/arch/mem.h>
>>>> +
>>>> +int misc_init_r(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 u8 mac_addr[ARP_HLEN];
>>>> +=C2=A0=C2=A0=C2=A0 char serial[SM_SERIAL_SIZE];
>>>> +=C2=A0=C2=A0=C2=A0 u32 sid;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) =
{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sid =3D crc32(0, (unsigned=
 char *)serial, SM_SERIAL_SIZE);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure the NIC specific=
 bytes of the mac are not all 0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((sid & 0xffff) =3D=3D =
0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
d |=3D 0x800000;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* OUI registered MAC addr=
ess */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[0] =3D 0x10;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[1] =3D 0x27;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[2] =3D 0xBE;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[3] =3D (sid >> 16=
) & 0xff;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[4] =3D (sid >>=C2=
=A0 8) & 0xff;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_addr[5] =3D (sid >>=C2=
=A0 0) & 0xff;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_env_set_enetaddr("etha=
ddr", mac_addr);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> diff --git a/board/amlogic/jethub-j80/MAINTAINERS b/board/amlogic/jeth=
ub-j80/MAINTAINERS
>>>> index 459e9f89da..a899153117 100644
>>>> --- a/board/amlogic/jethub-j80/MAINTAINERS
>>>> +++ b/board/amlogic/jethub-j80/MAINTAINERS
>>>> @@ -4,6 +4,5 @@ S:=C2=A0=C2=A0=C2=A0 Maintained
>>>>  =C2=A0 L:=C2=A0=C2=A0=C2=A0 u-boot-amlogic@groups.io
>>>>  =C2=A0 F:=C2=A0=C2=A0=C2=A0 board/amlogic/jethub-j80/
>>>>  =C2=A0 F:=C2=A0=C2=A0=C2=A0 configs/jethub_j80_defconfig
>>>> -F:=C2=A0=C2=A0=C2=A0 configs/jethub_j100_defconfig
>>>>  =C2=A0 F:=C2=A0=C2=A0=C2=A0 doc/board/amlogic/jethub-j80.rst
>>>> -F:=C2=A0=C2=A0=C2=A0 doc/board/amlogic/jethub-j100.rst
>>>> +F:=C2=A0=C2=A0=C2=A0 include/configs/jethub.h
>>>> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defco=
nfig
>>>> index 290ce4db85..ad026a89e0 100644
>>>> --- a/configs/jethub_j100_defconfig
>>>> +++ b/configs/jethub_j100_defconfig
>>>> @@ -1,4 +1,5 @@
>>>>  =C2=A0 CONFIG_ARM=3Dy
>>>> +CONFIG_SYS_BOARD=3D"jethub-j100"
>>>>  =C2=A0 CONFIG_SYS_CONFIG_NAME=3D"jethub"
>>>>  =C2=A0 CONFIG_ARCH_MESON=3Dy
>>>>  =C2=A0 CONFIG_SYS_TEXT_BASE=3D0x01000000
>>>>
>>>
>>> Applied to u-boot-amlogic
>>>
>>> I will probably send it next week along `add sm efuse write support and=
 cmd for read/write efuse`
>>>
>>> Thanks,
>>> Neil
>=20
