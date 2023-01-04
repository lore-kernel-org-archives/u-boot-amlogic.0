Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by mx.groups.io with SMTP id smtpd.web11.11754.1672838498511564075
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 05:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1672838494; bh=6WizkjT2kciM/DKH+zmOMXQqcWzj1Cbw6RuO/WsDkMg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U6ga0zGLfgMhLI3KnB8qNp27cjQwEM8uCbmP0g9uIEuqjL/qpmelwKXtAHfLvoeZC
	 bwSK92p44EyZAbbCgCWqnG4gcAII0K9XQD1l79au+QRRWzFMzQyuiosaufYIG2+Ij8
	 LHro42yec8hOeMtBl+NJEE0I84NoJEQ3JU6cAiGFzyC2D2fvMcUytme7t3HRPW8rgy
	 0RjYOepG7I57bjRQUcDYdIDDzzgc66AyepW8Xr9Rqe+DqT3Yu76pt7az1b9jYK5DD2
	 ClPwcbSoPQzDscc98v/HoPHkHve9FYj0atpmg7SRW1qEuiKaigDbL2m7MYzrGG0SRA
	 CJJnQ5jpH/Dug==
Message-ID: <d3f7f072-dc75-9601-ab6f-7f01aedcbefd@gmx.de>
Date: Wed, 4 Jan 2023 14:21:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/5] doc/usage: cmd: documentation for meson/sm command
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-4-avromanov@sberdevices.ru>
 <d4b8016b-b47e-c101-d9f6-622bf166e4d9@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <d4b8016b-b47e-c101-d9f6-622bf166e4d9@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: avromanov@sberdevices.ru
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, Neil Armstrong <neil.armstrong@linaro.org>, mkorpershoek@baylibre.com, sjg@chromium.org, trini@konsulko.com, narmstrong@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 1/4/23 13:35, Neil Armstrong wrote:
> Le 22/12/2022 =C3=A0 13:57, Alexey Romanov via groups.io a =C3=A9crit=C2=
=A0:
>
> Please add a short description of the change in the commit message.
>
> With this added:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
>> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>> ---
>> =C2=A0 doc/usage/cmd/sm.rst | 44 +++++++++++++++++++++++++++++++++++++++=
+++++

This lacks an addition to doc/usage/index.rst.

>> =C2=A0 1 file changed, 44 insertions(+)
>> =C2=A0 create mode 100644 doc/usage/cmd/sm.rst
>>
>> diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
>> new file mode 100644
>> index 00000000000..3a70c137ec9
>> --- /dev/null
>> +++ b/doc/usage/cmd/sm.rst
>> @@ -0,0 +1,44 @@
>> +.. SPDX-License-Identifier: GPL-2.0+:
>> +
>> +Meson Security Monitor command

sm command
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We always use the actual command name here as it appears in the index.

You can mention the Meson Security Monitor in the text below.

Best regards

Heinrich

>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Synopis
>> +-------
>> +
>> +::
>> +
>> +=C2=A0=C2=A0=C2=A0 sm serial <address>
>> +=C2=A0=C2=A0=C2=A0 sm reboot_reason [name]
>> +=C2=A0=C2=A0=C2=A0 sm efuseread <offset> <size> <address>
>> +=C2=A0=C2=A0=C2=A0 sm efusewrite <offset> <size> <address>
>> +=C2=A0=C2=A0=C2=A0 sm efusedump <offset> <size>
>> +
>> +Description
>> +-----------
>> +
>> +The sm command is used to request services from the secure monitor. Use=
r
>> +can call secure monitor to request special TEE function, for example
>> chip
>> +serial number info, reboot reason, etc.
>> +
>> +sm serial
>> +=C2=A0 Retrieve chip unique serial number from sm and write it to memor=
y on
>> +=C2=A0 appropriate address.
>> +
>> +sm reboot_reason
>> +=C2=A0 Print reboot reason to the console, if parameter [name] isn't
>> specified.
>> +=C2=A0 If parameter specified, set reboot reason string to environment
>> variable
>> +=C2=A0 with this name.
>> +
>> +sm efuseread
>> +=C2=A0 Read <size> bytes starting from <offset> from efuse memory bank =
and
>> write
>> +=C2=A0 result to the address <address>.
>> +
>> +sm efusewrite
>> +=C2=A0 Write into efuse memory bank, starting from <offset>, the <size>=
 bytes
>> +=C2=A0 of data, located at address <address>.
>> +
>> +Configuration
>> +-------------
>> +
>> +To use the sm command you must specify CONFIG_CMD_MESON=3Dy
>

