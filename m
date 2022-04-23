Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.4163.1650697579120850856
 for <u-boot-amlogic@groups.io>;
 Sat, 23 Apr 2022 00:06:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650697576; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FUli5SnL1gFRLJPxQ9V3UbN7faKf7CLD3ytJHWYDOXc=;
	b=wndyzgWfxhI9KN2rc3ZwDWg+nVe35PILRP5bqpVszET0YII9OWQ5MIW+Y5ezctC+Rtu8md
	aAL/mQBL/AuK4yOjLtie6d2yBiyhTDetje3HMSYLd1ZFHuKSfKQyBsESKh94atCaI+zKrD
	PuH1sRoNYkdP2XQuPQd8VL4r9sRrxbe02Bd0kwu5n6SPsHXI+JpGG32KHdN8nCfPX4v8G0
	Qqj4K5/qZbMdy2wslO1exTuohlPwRCCDc87+bGl3/JldYtOT4mWbw21mM2zbU5pm+b8A8M
	6twD47bYKJT1Sc967LEHLWqo9BqWR8jvuSDJm0utGLf7qONenJVHbIaFXhrCqQ==
Message-ID: <56aff112-d559-eadd-5dc0-d12cca1dc9ee@lexina.in>
Date: Sat, 23 Apr 2022 10:06:15 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] board: amlogic: jethub j100: enable saradc in dts
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-6-adeep@lexina.in>
 <93ba1522-906d-dc05-0fcc-01fa294ef05c@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <93ba1522-906d-dc05-0fcc-01fa294ef05c@baylibre.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>



22.04.2022 16:26, Neil Armstrong wrote:
> On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
>> Prepare to use ADC channel 1 to check the hardware revision of the board=
.
>>
>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>> ---
>> =C2=A0 arch/arm/dts/meson-axg-jethome-jethub-j100.dts | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts=20
>> b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
>> index 5783732dc6..00a0b268af 100644
>> --- a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
>> +++ b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
>> @@ -359,3 +359,8 @@
>> =C2=A0 &cpu3 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #cooling-cells =3D <2>;
>> =C2=A0 };
>> +
>> +&saradc {
>> +=C2=A0=C2=A0=C2=A0 status =3D "okay";
>> +=C2=A0=C2=A0=C2=A0 vref-supply =3D <&vddio_ao18>;
>> +};
>=20
> Please move this in a -u-boot.dtsi file to keep the main DT in sync with=
=20
> Linux.

Thanks. Anyway, I will submit patch to the kernel later.

> Neil
