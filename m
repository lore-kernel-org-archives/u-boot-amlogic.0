Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web12.12423.1633616893830312241
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 07:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633616891; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Gpg68HTwkjSGhOodFrQzOiwQiHqQdClYieat0PnutRc=;
	b=bNsHfs7o/RQw6VeVMHBrA0fcwoitB7+gZ6AlD75evhPFA/vNWR/FXNx92yn0dnL5zrZpde
	8aGR5WabPjEHt5cYwc99lncxyfXtPjYTFk/w8yc6+3UA11/FmKX/SQGQjMJaY07E+Kbh7b
	w4XS3BoDBFXhMDeh+hKWLXE21JCPgDCgHcXCTtOXeIKRaiSj31qcpB3Eq9xTc1o3+SnS3y
	Ox/OpAb+IXStWg92GAiaBO0fSisVL61d87zpmTADDJXhxdwV8quR/pl/uj7WcbD84Uy4r/
	fwlVCG+FjAA1o3RXF0EmGnXYvjkQghgNte2tyGW83SpQlZUHoHoaWdWvZQlc/w==
Subject: Re: ARM: amlogic: RFC: meson_sm_get_serial secure call update
References: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
 <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
 <76a3cab3-c5e5-c557-7db6-426ff8f8bf69@lexina.in>
 <c3b0b6b0-3dc3-3cd0-699f-2d9578ad6e0c@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <db708076-7e34-8d99-c784-e5993ddaa7bf@lexina.in>
Date: Thu, 7 Oct 2021 17:28:10 +0300
MIME-Version: 1.0
In-Reply-To: <c3b0b6b0-3dc3-3cd0-699f-2d9578ad6e0c@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

07.10.2021 15:48, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 07/10/2021 14:11, Vyacheslav wrote:
>> 07.10.2021 11:13, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Hi,
>>>
>>> On 05/10/2021 11:35, Vyacheslav wrote:
>>>> Hi.
>>>>
>>>> I am investigating the source code of uboot from amlogic and found dif=
ferences in the function to get the cpu serial. In amlogic-uboot it looks l=
ike this:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int ve=
rsion =3D *((unsigned int *)sharemem_output_base);
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ve=
rsion =3D=3D 2) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 memcpy(buff, (void *)sharemem_output_base + 4, 16);
>>>> The current uboot source code uses only the read 12 bytes as cpu seria=
l ignoring the chipID and the existence of a 16-byte version of the serial =
number.
>>>>
>>>> Does it make sense to transfer the code to the uboot project?
>>>>
>>> How does it detect when 16 bytes serial is available ?
>> Call to sm function FN_CHIP_ID returns version number in uint32 at begin=
ning of result (shmem_output var in sm.c):
>>
>>> int version =3D *((unsigned int *)sharemem_output_base);
>> if version =3D=3D 2 then serial is next 16 bytes
>> for version =3D=3D 1 then serial is next 12 bytes and amlogic suggests u=
sing chipid as an additional 4 bytes.
>>
>> I have gxl and axg platform, there version is 1. Unfortunately I don't h=
ave more recent chipsets at hand to check if they have introduced version 2=
 on them.
> Seems to be a very recent addition, I get version 1 on S905Y2 (G12A), A31=
1d (G12B) & S905D3 (SM1).
>
I forgot that the argument of amlogic's getchip call was changed to 2. With

regs.regs[0]=C2=A0=3D FN_CHIP_ID;
regs.regs[1]=C2=A0=3D 2;
regs.regs[2]=C2=A0=3D 0;

I receive version =3D=3D 2 on axg and gxl.

For example on gxl (only 96bits checked):

regs[1]=3D0
02000000: a7795fe3 d8f855af 14c30b56 00000000=C2=A0 ._y..U..V.......

regs[1]=3D2
02000000: 00a40d21 560bc314 af55f8d8 e35f79a7 .......V..U..y_.

We have same serial with reversed byte order.

Change introduced in 2017 with comment:

 =C2=A0=C2=A0=C2=A0 GX-family chips (e.g. GXB, GXL) supports a 128-bit chip=
 ID.
 =C2=A0=C2=A0=C2=A0 128-bit chip ID consists 32-bit SoC version and 96-bit =
OTP data.

 =C2=A0=C2=A0=C2=A0 BL30 provides a SoC command to obtain the chip ID value=
.

 =C2=A0=C2=A0=C2=A0 Legacy implementation only returns 96-bit OTP data and =
requires
 =C2=A0=C2=A0=C2=A0 the construction of the 128-bit by the caller.

 =C2=A0=C2=A0=C2=A0 This change updates the implementation to return the co=
nstructed
 =C2=A0=C2=A0=C2=A0 128-bit chip ID while maintain backward compatibility w=
ith existing

 =C2=A0=C2=A0=C2=A0 software.

--

Vyacheslav
