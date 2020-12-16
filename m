Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web10.4125.1608103786819735404
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:29:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1608103778;
	bh=hWkYcPQDQ85AgcHpqOtRcTrr+C/vOlhNz4Tst4TLkeI=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=XIZ/zuVF5qmEWru1uX6QaKNZ+qB7BHDZIuVXBDMurxuKZjixCmX1a3kgc32peOLIj
	 gPZIpYCpkjwy/t/lEuhbpC9pBoyJiZ/YzNHoFxrGBWB4dsZxjmfENGOznOKUa4ZMhw
	 H4Ca1WsOewcT5XJwFbiLUxz1wmdW9MNX9exh3OHk=
Subject: Re: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
References: <20201215144230.9235-7-m.szyprowski@samsung.com>
 <CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
 <20201215165439.13165-1-m.szyprowski@samsung.com>
 <a177e979-62ec-a459-d1ce-adca152931e5@gmx.de>
 <437012d3-3ff8-3d05-5854-680b0a37f0ab@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <00509303-b003-2a95-2cbc-9ae78990de1c@gmx.de>
Date: Wed, 16 Dec 2020 08:29:32 +0100
MIME-Version: 1.0
In-Reply-To: <437012d3-3ff8-3d05-5854-680b0a37f0ab@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/16/20 8:08 AM, Marek Szyprowski wrote:
> On 15.12.2020 20:07, Heinrich Schuchardt wrote:
>> On 12/15/20 5:54 PM, Marek Szyprowski wrote:
>>> Save examined button state in 'button' environment variable to enable
>>> checking button state in the scripts.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> Resend reason: get rid of the Change-Id tag, that was still in v2.
>>> ---
>>>  =C2=A0 cmd/button.c | 4 +++-
>>>  =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/cmd/button.c b/cmd/button.c
>>> index 64c5a8fa04..8da911068a 100644
>>> --- a/cmd/button.c
>>> +++ b/cmd/button.c
>>> @@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D button_get_state(dev);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D BUTTON_COUNT)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVA=
L;
>>> -=C2=A0=C2=A0=C2=A0 if (ret >=3D 0)
>>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D 0) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s\n",=
 state_label[ret]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env_set("button", state_la=
bel[ret]);
>>
>> Using a hard coded environment variable does not make much sense to me.
>> The button command has a return value. So just use
>>
>> button mybutton; setenv myvar $?
>>
> Thanks for the hint, I wasn't aware that uboot supports '$?'. By setting
> the 'button' env variable I've tried to mimic the behavior of the
> various network and file related commands, which sets 'filesize' env
> variable.
>
> I will need to add the return value propagation to the button command
> anyway to make it usable from the scripts.

Nothing to be done for the button command. Since

     a6bfd71a96201127836d59736abcb54dc2d5e1a5
     cmd/button: return button status

the button command returns

     0 (true) - pressed, on
     1 (false) - not pressed, off

Best regards

Heinrich
