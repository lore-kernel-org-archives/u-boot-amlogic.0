Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web10.621.1608059280213889493
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 11:08:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1608059271;
	bh=IpCcH9RaqiiZ6Z6KZD/bP3OkHA4b230g4OT5M5qkz5I=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=REJO8fHxDZECY95RGjDls7mcHXteGWxleBik4/fTsI6/dsYZ7DZ5Om40F14VWl2Zd
	 RpQ0NlPmMnisZ0ih2jDbAh0sKGqOplG1TLUy4TH7hTBKKy15ACjyIT3fX1XB0c8XSI
	 8hISrlrigPkPC+vc5wdAhLqRWa46a+q1+bwZjd+0=
Subject: Re: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
References: <20201215144230.9235-7-m.szyprowski@samsung.com>
 <CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
 <20201215165439.13165-1-m.szyprowski@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <a177e979-62ec-a459-d1ce-adca152931e5@gmx.de>
Date: Tue, 15 Dec 2020 20:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <20201215165439.13165-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/15/20 5:54 PM, Marek Szyprowski wrote:
> Save examined button state in 'button' environment variable to enable
> checking button state in the scripts.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Resend reason: get rid of the Change-Id tag, that was still in v2.
> ---
>   cmd/button.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/button.c b/cmd/button.c
> index 64c5a8fa04..8da911068a 100644
> --- a/cmd/button.c
> +++ b/cmd/button.c
> @@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
>   	ret =3D button_get_state(dev);
>   	if (ret >=3D BUTTON_COUNT)
>   		ret =3D -EINVAL;
> -	if (ret >=3D 0)
> +	if (ret >=3D 0) {
>   		printf("%s\n", state_label[ret]);
> +		env_set("button", state_label[ret]);

Using a hard coded environment variable does not make much sense to me.
The button command has a return value. So just use

button mybutton; setenv myvar $?

Best regards

Heinrich

> +	}
>
>   	return ret;
>   }
>

