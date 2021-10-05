Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web11.23184.1633426516090762276
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Oct 2021 02:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633426512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=gBwALDp9zxpskHd5LDtLOlt6Xuw5+OgVQ5PjlsbJdp4=;
	b=ihjEudHX9TcoOJVJ1gZHpn4y+4n+nS6DI9FPj/ulvUnFQ1ndXgyV2pW2M+5U2yG/F4SQhZ
	518P97L6kzffFnL/iH+iT9C21XgNtbXzIZ6BZ4FjYtgZHUqNTxVfDZtX/WvSvRA1Rv71cp
	kdqC3KdKTctS19yhpUywkvs85TwVkyj/9IavW8zMY+tGVBy/v82BqogGC00VDxF8shcZB6
	QIQQfbay/+yc/MfN47lwmIC/uttMDlw2HeKDfhNz51E74/LhXl5JKq0c2zvGN+FHPykqrC
	W+yi1SM1wGrEO3Anh72hGAvdvG7mUrMV7MgwsEmeaE5A8jw5qi/vIS1N0RHjmw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: ARM: amlogic: RFC: meson_sm_get_serial secure call update
Message-ID: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
Date: Tue, 5 Oct 2021 12:35:11 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi.

I am investigating the source code of uboot from amlogic and found=20
differences in the function to get the cpu serial. In amlogic-uboot it=20
looks like this:

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int version =3D *=
((unsigned int *)sharemem_output_base);

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (version =3D=
=3D 2) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 memcpy(buff, (void *)sharemem_output_base + 4, 16);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /**
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0* Legacy 12-byte chip ID read out, transform data
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0* to expected order format.
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0*/
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 uint32_t chip_info =3D readl(P_AO_SEC_SD_CFG8);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 uint8_t *ch;
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 int i;

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ((uint32_t *)buff)[0] =3D
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 ((chip_info & 0xff000000)=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 // Family ID
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 ((chip_info << 8) & 0xff0000) |=C2=A0=C2=A0=C2=A0 //=
 Chip Revision
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 ((chip_info >> 8) & 0xff00)); // Package ID

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ((uint32_t *)buff)[0] =3D htonl(((uint32_t *)buff)[0]);

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /* Transform into expected order for display */
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 ch =3D (uint8_t *)(sharemem_output_base + 4);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 for (i =3D 0; i < 12; i++)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 buff[i + 4] =3D ch[11 - i];
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }


Where P_AO_SEC_SD_CFG8 is offset (0x88<<2) of the AOBUS_BASE register.

The current uboot source code uses only the read 12 bytes as cpu serial=20
ignoring the chipID and the existence of a 16-byte version of the serial=20
number.

Does it make sense to transfer the code to the uboot project?


