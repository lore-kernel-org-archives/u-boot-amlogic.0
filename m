Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.4206.1608104593820208240
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:43:14 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216074256euoutp02a3e42f5e21690977bcfe6d0556b51d36~RIpeQipg_2188321883euoutp02o
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:42:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216074256euoutp02a3e42f5e21690977bcfe6d0556b51d36~RIpeQipg_2188321883euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608104576;
	bh=sG2IExuRHsPWbTyEPP2uj0oJrctuAhvmA+lKll5buo0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=ulh2bd7ZeIEDdp2PxCCPqaEkRMWB9ND/cz1vfexGRHw+MfWAeYu/qujvY5A1/DYtl
	 0I7K1QRNO1xjfzikfg+EhESxqbBS6n46GzlW8QSn22HlWOjsDwcPmswyOep1Oye8rm
	 zzsuP/j57M5ulumssG87m5Apb8/2kos4Hr7iQnDo=
Subject: Re: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4c699ba5-5163-6f58-ea0d-383f22019943@samsung.com>
Date: Wed, 16 Dec 2020 08:42:47 +0100
MIME-Version: 1.0
In-Reply-To: <00509303-b003-2a95-2cbc-9ae78990de1c@gmx.de>
References: <20201215144230.9235-7-m.szyprowski@samsung.com>
	<CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
	<20201215165439.13165-1-m.szyprowski@samsung.com>
	<a177e979-62ec-a459-d1ce-adca152931e5@gmx.de>
	<437012d3-3ff8-3d05-5854-680b0a37f0ab@samsung.com>
	<00509303-b003-2a95-2cbc-9ae78990de1c@gmx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 16.12.2020 08:29, Heinrich Schuchardt wrote:
> On 12/16/20 8:08 AM, Marek Szyprowski wrote:
>> On 15.12.2020 20:07, Heinrich Schuchardt wrote:
>>> On 12/15/20 5:54 PM, Marek Szyprowski wrote:
>>>> Save examined button state in 'button' environment variable to enabl=
e
>>>> checking button state in the scripts.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>> Resend reason: get rid of the Change-Id tag, that was still in v2.
>>>> ---
>>>> =C2=A0=C2=A0 cmd/button.c | 4 +++-
>>>> =C2=A0=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/cmd/button.c b/cmd/button.c
>>>> index 64c5a8fa04..8da911068a 100644
>>>> --- a/cmd/button.c
>>>> +++ b/cmd/button.c
>>>> @@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D button_get_state(dev);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D BUTTON_COUNT)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EINVAL;
>>>> -=C2=A0=C2=A0=C2=A0 if (ret >=3D 0)
>>>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf(=
"%s\n", state_label[ret]);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env_set("button", state_=
label[ret]);
>>>
>>> Using a hard coded environment variable does not make much sense to m=
e.
>>> The button command has a return value. So just use
>>>
>>> button mybutton; setenv myvar $?
>>>
>> Thanks for the hint, I wasn't aware that uboot supports '$?'. By setti=
ng
>> the 'button' env variable I've tried to mimic the behavior of the
>> various network and file related commands, which sets 'filesize' env
>> variable.
>>
>> I will need to add the return value propagation to the button command
>> anyway to make it usable from the scripts.
>
> Nothing to be done for the button command. Since
>
> =C2=A0=C2=A0=C2=A0 a6bfd71a96201127836d59736abcb54dc2d5e1a5
> =C2=A0=C2=A0=C2=A0 cmd/button: return button status
>
> the button command returns
>
> =C2=A0=C2=A0=C2=A0 0 (true) - pressed, on
> =C2=A0=C2=A0=C2=A0 1 (false) - not pressed, off
>
Right, I've missed that commit. I've developed my code on top of=20
v2020.10 release.

Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

