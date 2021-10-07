Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web11.10978.1633608723043565859
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 05:12:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633608720; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lb3HBCwl1NY0yA1/bb2ZGPVlqzmLG0/8lNGfCbDHreE=;
	b=LNakVzNC8ypE9Fn9i+YbAu7pslXkqoPPnMj2HRC2fN8Orf6BjErjVgPBiDK3Y6rgQMfFTl
	WA4qaMlmaoSP53R2FyMl/wefoWh41ryjrgBNmIDhxjYkpP7gmgivZV0x6h5lAjDPM0iAh/
	yyWhmpdXig+RjwhUlRFSLJo0VyMfrRR48GzkBcFJm2aIYAY8z4yDefzcXcuIx99Z3OgGXF
	bTv3Qb1Pl+CRsrr76dFdT0QKSIKs5chhPrNGqiQa9bI8X5PHfrhB5beS4jeyP46wV5CEtO
	A0r31XvJGZU+VHwglUf1C9b+rpYSw1zzQBh7+ghDH24PCOjfBaIkAh8AJHsLig==
Subject: Re: ARM: amlogic: RFC: meson_sm_get_serial secure call update
References: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
 <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <76a3cab3-c5e5-c557-7db6-426ff8f8bf69@lexina.in>
Date: Thu, 7 Oct 2021 15:11:58 +0300
MIME-Version: 1.0
In-Reply-To: <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

07.10.2021 11:13, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>
> On 05/10/2021 11:35, Vyacheslav wrote:
>> Hi.
>>
>> I am investigating the source code of uboot from amlogic and found diffe=
rences in the function to get the cpu serial. In amlogic-uboot it looks lik=
e this:
>>
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int version =
=3D *((unsigned int *)sharemem_output_base);
>>
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (version =
=3D=3D 2) {
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 memcpy(buff, (void *)sharemem_output_base + 4, 16);
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else {
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 /**
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0* Legacy 12-byte chip ID read out, transform data
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0* to expected order format.
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0*/
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 uint32_t chip_info =3D readl(P_AO_SEC_SD_CFG8);
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 uint8_t *ch;
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 int i;
>>
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 ((uint32_t *)buff)[0] =3D
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 ((chip_info & 0xff000000)=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 // Family ID
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 ((chip_info << 8) & 0xff0000) |=C2=A0=C2=A0=C2=A0=
 // Chip Revision
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 ((chip_info >> 8) & 0xff00)); // Package ID
>>
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 ((uint32_t *)buff)[0] =3D htonl(((uint32_t *)buff)[0]);
>>
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 /* Transform into expected order for display */
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 ch =3D (uint8_t *)(sharemem_output_base + 4);
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 for (i =3D 0; i < 12; i++)
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 buff[i + 4] =3D ch[11 - i];
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
>>
>>
>> Where P_AO_SEC_SD_CFG8 is offset (0x88<<2) of the AOBUS_BASE register.
> We already handle this in arch/arm/mach-meson/board-info.c
Really, I didn't look there.
>> The current uboot source code uses only the read 12 bytes as cpu serial =
ignoring the chipID and the existence of a 16-byte version of the serial nu=
mber.
>>
>> Does it make sense to transfer the code to the uboot project?
>>
> How does it detect when 16 bytes serial is available ?

Call to sm function FN_CHIP_ID returns version number in uint32 at=20
beginning of result (shmem_output var in sm.c):

> int version =3D *((unsigned int *)sharemem_output_base);

if version =3D=3D 2 then serial is next 16 bytes
for version =3D=3D 1 then serial is next 12 bytes and amlogic suggests usin=
g chipid as an additional 4 bytes.

I have gxl and axg platform, there version is 1. Unfortunately I don't have=
 more recent chipsets at hand to check if they have introduced version 2 on=
 them.

> I'm not against this but I'm not sure when 16 bytes are available.
I'm not sure if the 16 bytes even exist at all or if this is just in case f=
or future SoC.

--
Vyacheslav

