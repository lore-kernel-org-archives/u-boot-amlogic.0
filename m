Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.3958.1608102564486391066
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:09:25 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216070907euoutp02f4ad465bebc72f3dc8b321ca43cce1b2~RIL8fKB7P0054500545euoutp02a
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:09:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216070907euoutp02f4ad465bebc72f3dc8b321ca43cce1b2~RIL8fKB7P0054500545euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608102547;
	bh=gXtC0xtP99Ov2+RpwFAnGk2MKRTNfwl5TKhSJ1YR5mA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=PF1sMyDkRzUfhWmZyC+WixxAgQCxqekJliUqobT3/nVU4xjdfQ0MOW26wTMB/3F74
	 SpVoc+HIvs6b9r44Fd7jfvAdpjYf+E9wmuoVJfkvDVOEA0fSUUnCn+0u1ap1J2mdYt
	 eyaftEmoNUmW7dfyV+62tuBW8xZMP+qzgTfm5TVo=
Subject: Re: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <437012d3-3ff8-3d05-5854-680b0a37f0ab@samsung.com>
Date: Wed, 16 Dec 2020 08:08:59 +0100
MIME-Version: 1.0
In-Reply-To: <a177e979-62ec-a459-d1ce-adca152931e5@gmx.de>
References: <20201215144230.9235-7-m.szyprowski@samsung.com>
	<CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
	<20201215165439.13165-1-m.szyprowski@samsung.com>
	<a177e979-62ec-a459-d1ce-adca152931e5@gmx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 15.12.2020 20:07, Heinrich Schuchardt wrote:
> On 12/15/20 5:54 PM, Marek Szyprowski wrote:
>> Save examined button state in 'button' environment variable to enable
>> checking button state in the scripts.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> Resend reason: get rid of the Change-Id tag, that was still in v2.
>> ---
>> =C2=A0 cmd/button.c | 4 +++-
>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmd/button.c b/cmd/button.c
>> index 64c5a8fa04..8da911068a 100644
>> --- a/cmd/button.c
>> +++ b/cmd/button.c
>> @@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D button_get_state(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D BUTTON_COUNT)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL=
;
>> -=C2=A0=C2=A0=C2=A0 if (ret >=3D 0)
>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s\n", =
state_label[ret]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env_set("button", state_la=
bel[ret]);
>
> Using a hard coded environment variable does not make much sense to me.
> The button command has a return value. So just use
>
> button mybutton; setenv myvar $?
>
Thanks for the hint, I wasn't aware that uboot supports '$?'. By setting=20
the 'button' env variable I've tried to mimic the behavior of the=20
various network and file related commands, which sets 'filesize' env=20
variable.

I will need to add the return value propagation to the button command=20
anyway to make it usable from the scripts.

Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

